package com.nc.sql;

import com.nc.util.ServerUtil;
import java.sql.*;
import java.util.ArrayList;

 
public class CoolConnection {
 
    CoolConnection(ConnectionManager connectionmanager) {
        manager = connectionmanager;
    }

    public void setUsePreparedStatement(boolean flag) {
        usePreStmt = flag;
    }

    public ConnectionManager getManager() {
        return manager;
    }

    public boolean hasConnection() {
        return con != null;
    }

    public Connection getConnection() {
        return con;
    }

    public boolean hasStatment(){
        return stmt != null;
    }

    synchronized boolean request() {
        if(inUse) {
            return false;
        } else {
            inUse = true;
            return true;
        }
    }

    synchronized boolean isIdle() {
        return !inUse;
    }

    synchronized void release(){
        inUse = false;
    }

    public int getCounter(){
        return counter;
    }

    public void resetCounter(){
        counter = 0;
    }
    
    public boolean openConnection() throws SQLException {
        if(con == null) {
            con = manager.getConnection(this);
            autoCommit = true;
        }
        return con != null; 
    }

    public void close()
    {
        try {
            if(con == null)
                return;
            if(rs != null) {
                rs.close();
                rs = null;
            }
            if(stmt != null) {
                stmt.close();
                stmt = null;
            }
            if(!autoCommit && !actionComplete) {
                con.rollback();
            }
            manager.releaseConnection(this);
            System.gc();
        } catch(Exception exception) {
        }
    }

    public void rollback()
        throws SQLException
    {
        if(!autoCommit && !actionComplete)
        {
            con.rollback();
            actionComplete = true;
        } else
        {
            //Log.error("CoolConnection.rollback", "autoCommit=" + autoCommit + " complete=" + actionComplete);
        }
    }

    public void commit()
        throws SQLException {
        if(!autoCommit && !actionComplete) {
            con.commit();
            actionComplete = true;
        } else {
            //Log.error("CoolConnection.commit", "Commit Error: autoCommit=" + autoCommit + " complete=" + actionComplete);
        }
    }

    public void createStatement(boolean flag)
        throws SQLException {
        if(con == null)
            openConnection();   // 최초에 connection 가져오기
        if(stmt == null) {
            con.setAutoCommit(autoCommit = flag);
            stmt = con.createStatement();
            actionComplete = false;
        } else {
            //Log.error("CoolConnection.createStatement", "statement already open", new Exception());
        }
    }
    
    public ResultSet executeQuery(String s)
        throws SQLException {
        actionComplete = false;
        if(rs != null) {
            rs.close();
            rs = null;
        }
        try {
            lastSQL = s;
            counter++;
            rs = stmt.executeQuery(s);
           // if(Log.isDebug())
             //   Log.debug("CoolConnection.executeQuery", "SQL: " + s);
        } catch(SQLException sqlexception) {
            //Log.warn("CoolConnection.executeQuery", "SQL failed: " + s);
            System.out.println(sqlexception.toString());
            throw sqlexception;
        }
        return rs;
    }

    public int executeUpdate(String s)
        throws SQLException{
        if(s == null || s.length() == 0)
            return 0;
        actionComplete = false;
        if(rs != null) {
            rs.close();
            rs = null;
        }
        int i = 0;
        try {
            lastSQL = s;
            counter++;
            i = stmt.executeUpdate(s);
            //if(Log.isDebug())
              //  Log.debug("CoolConnection.executeUpdate", "SQL: " + s);
        } catch(SQLException sqlexception) {
            //Log.warn("CoolConnection.executeUpdate", "SQL: " + s);
            throw sqlexception;
        }
        return i;
    }

    public String getLastSQL() {
        return lastSQL;
    }

    public ArrayList getTableList(String s, String s1, String s2)
        throws SQLException {
        String as[] = {
            "TABLE"
        };
        return getTables(s, s1, s2, as);
    }

    public ArrayList getViewList(String s, String s1, String s2)
        throws SQLException {
        String as[] = {
            "VIEW"
        };
        return getTables(s, s1, s2, as);
    }

    public ArrayList getTables(String s, String s1, String s2, String as[])
        throws SQLException {
        DatabaseMetaData databasemetadata = con.getMetaData();
        rs = databasemetadata.getTables(s, s1, s2, as);
        ArrayList arraylist = new ArrayList();
        for(; rs.next(); arraylist.add(ServerUtil.getString(rs, 3)));
        rs.close();
        return arraylist;
    }

    public boolean tableExists(String s, String s1, String s2)
        throws SQLException {
        return tableExists(s, s1, s2, "TABLE");
    }

    public boolean viewExists(String s, String s1, String s2)
        throws SQLException {
        return tableExists(s, s1, s2, "VIEW");
    }

    public boolean tableExists(String s, String s1, String s2, String s3)
        throws SQLException {
        DatabaseMetaData databasemetadata = con.getMetaData();
        if(rs != null) {
            rs.close();
            rs = null;
        }
        try {
            if(databasemetadata.storesUpperCaseIdentifiers() || databasemetadata.storesUpperCaseQuotedIdentifiers())
                s2 = s2.toUpperCase();
            else
            if(databasemetadata.storesLowerCaseIdentifiers() || databasemetadata.storesLowerCaseQuotedIdentifiers())
                s2 = s2.toLowerCase();
            rs = databasemetadata.getTables(s, s1, s2, new String[] {
                s3
            });
            boolean flag = rs.next();
            return flag;
        } finally {
            rs.close();
            rs = null;
        }
    }

    public boolean fieldExists(String s, String s1, String s2, String s3)
        throws SQLException
    {
        DatabaseMetaData databasemetadata = con.getMetaData();
        if(rs != null)
        {
            rs.close();
            rs = null;
        }
        try
        {
            if(databasemetadata.storesUpperCaseIdentifiers() || databasemetadata.storesUpperCaseQuotedIdentifiers())
            {
                s3 = s3.toUpperCase();
                s2 = s2.toUpperCase();
            } else
            if(databasemetadata.storesLowerCaseIdentifiers() || databasemetadata.storesLowerCaseQuotedIdentifiers())
            {
                s3 = s3.toLowerCase();
                s2 = s2.toLowerCase();
            }
            rs = databasemetadata.getColumns(s, s1, s2, s3);
            boolean flag = rs.next();
            return flag;
        }
        finally
        {
            rs.close();
            rs = null;
        }
    }

    public boolean counterExists(String s)
        throws SQLException
    {
        rs = executeQuery(s);
        boolean flag = rs.next();
        rs.close();
        rs = null;
        return flag;
    }

    int id;
    boolean ownsConnection;
    boolean autoCommit;
    boolean actionComplete;
    String lastSQL;
    boolean inUse;
    boolean usePreStmt;
    Connection con;
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;
    ConnectionManager manager;
    int counter;
}
