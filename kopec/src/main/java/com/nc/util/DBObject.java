package com.nc.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class DBObject {
  Connection conn; 

  boolean autoCommit;
  boolean actionComplete;
  String lastSQL;
  boolean inUse;
  boolean usePreStmt;
  Statement stmt;
  PreparedStatement pstmt;
  ResultSet rs;
  int counter;
  

    public DBObject(DBObject dbobject){
        this(dbobject.conn);
    } 

    public DBObject(Connection connection) {
        conn = connection;
    }

    public void setConnection(Connection connection) {
        conn = connection;
    }

    public Connection getConnection() {
        return conn;
    }

    public void deleteTableRows(String s, int ai) throws SQLException {
        String s1 = "DELETE FROM " + s + " WHERE Id " + (ai);
        executeUpdate(s1);
    }

    public String insertCode(String s, String s1, int i)
        throws SQLException {
        
        s = s.trim();
        if(i < 10)
            s = s + "0";
        s = s + i;
        String s3 = "UPDATE " + s1 + " SET Code='" + s + "' WHERE Id=" + i;
        executeUpdate(s3);
        return s;
    }

    public String getNewCode(String s, int i) {
        
        s = s.trim();
        if(i < 10)
            s = s + "0";
        s = s + i;
        return s;
    }
    
    public int getNextId(String s) throws SQLException{
    	String sql = "Select max(id)+1 as nid from " + s;
    	rs = executeQuery(sql);
    	if (rs.next()){ 
    		if(0==rs.getInt("nid")) return 1;
    		else return rs.getInt("nid");
    	} else return 1;
    }
    
    public int getNextId(String t, String f) throws SQLException {
    	String s  = "select max("+f+")+1 as nid from "+t;
    	rs = executeQuery(s);
    	if (rs.next()){
    		if (0==rs.getInt("nid")) return 1;
    		else return rs.getInt("nid");
    	} else return 1;
    }
    
    public int getNextIconId(String mapId) throws SQLException {
    	String sql = "SELECT MAX(ID)+1 AS NID FROM TBLMAPICON WHERE MAPID=?";
    	rs = executePreparedQuery(sql,new Object[] {mapId});
    	if (rs.next()){
    		if (0==rs.getInt("NID")) return 1;
    		else return rs.getInt("NID");
    	} else return 1;
    }
    
    public ResultSet executeQuery(String s) throws SQLException {
	    actionComplete = false;
	    if(rs != null) {
	        rs.close();
	        rs = null;
	    }
	    try {
	        lastSQL = s;
	        counter++;
	        if(stmt == null) stmt = conn.createStatement();
	        rs = stmt.executeQuery(s);
	        //if(Log.isDebug())
	            //Log.debug("DBObject.executeQuery", "SQL: " + s);
	    } catch(SQLException sqlexception) {
	        //Log.warn("DBObject.executeQuery", "SQL failed: " + s);
	        System.out.println(sqlexception.toString());
	        throw sqlexception;
	    }
	    return rs;
	}

    public ResultSet executePreparedQuery(String s, Object[] params) throws SQLException {
	    actionComplete = false; 
	    if(rs != null) {
	        rs.close();
	        rs = null;
	    }
	    try {
	        lastSQL = s;
	        counter++;
	        if(pstmt != null) {
	        	pstmt.close();
	        	pstmt = null;
	        }
	        pstmt = conn.prepareStatement(s);
	        setParam(pstmt,params);
	        rs = pstmt.executeQuery();
	        //if(Log.isDebug())
	            //Log.debug("DBObject.executeQuery", "SQL: " + s);
	    } catch(SQLException sqlexception) {
	        //Log.warn("DBObject.executeQuery", "SQL failed: " + s);
	        System.out.println(sqlexception.toString());
	        throw sqlexception;
	    }
	    return rs;
	}
    
	public int executeUpdate(String s) throws SQLException {
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
	        if(stmt == null) stmt = conn.createStatement();
	        i = stmt.executeUpdate(s);
	        //if(Log.isDebug())
	            //Log.debug("DBObject.executeUpdate", "SQL: " + s);
	    } catch(SQLException sqlexception) {
	        //Log.warn("DBObject.executeUpdate", "SQL: " + s);
	    	System.out.println(sqlexception);
	        throw sqlexception;
	    }
	    return i;
	}

	public int executePreparedUpdate(String s, Object[] params) throws SQLException {
	    if(s == null || s.length() == 0)
	        return 0;
	    actionComplete = false;
	    if(rs != null) {
	        rs.close();
	        rs = null;
	    }
        if(pstmt != null){
        	pstmt.close();
        	pstmt = null;
        }
	    int i = 0;
	    try {
	        lastSQL = s;
	        counter++;   	
	        pstmt = conn.prepareStatement(s);
	        setParam(pstmt,params);
	        i = pstmt.executeUpdate();
	        //if(Log.isDebug())
	            //Log.debug("DBObject.executeUpdate", "SQL: " + s);
	    } catch(SQLException sqlexception) {
	        //Log.warn("DBObject.executeUpdate", "SQL: " + s);
	    	System.out.println(sqlexception);
	        throw sqlexception;
	    }
	    return i;
	}
	
    protected PreparedStatement getPreparedStatement(String sql) throws SQLException {
        pstmt = (PreparedStatement)conn.prepareStatement(sql);
        return pstmt;
    }
    
    private void setParam(PreparedStatement ps, Object values[]) throws SQLException {
        if (values == null)
            return;
        for (int j = 0; j < values.length; j++) {
            if (values[j] == null) {
                ps.setNull(j + 1, 1);
            } else if (values[j] instanceof java.lang.String) {
                //ps.setString(j + 1, new String(((String)values[j]).getBytes()));
            	ps.setString(j + 1, ((String)values[j]));
            } else if (values[j] instanceof Integer){
            	ps.setInt(j+1, ((Integer)values[j]).intValue());
            } else if (values[j] instanceof Double){
            	ps.setDouble(j+1, ((Double)values[j]).doubleValue());
            } else if (values[j] instanceof Long) {
            	ps.setLong(j+1, ((Long)values[j]).longValue());
            } else {
                ps.setObject(j + 1, values[j]);
            }
        }
    }
    
	public void close(){
		try {
			if (pstmt != null) pstmt.close();
			if (stmt != null) stmt.close();
			if (rs != null) rs.close();
		} catch (SQLException se) {
			System.out.println("DBObject close()"+se);
		} catch (Exception e){
			System.out.println("DBObject close()"+e);
		} finally {
			pstmt = null;
			stmt = null;
			rs = null;
		}
	}
}
