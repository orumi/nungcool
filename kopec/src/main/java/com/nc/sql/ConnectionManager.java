package com.nc.sql;

import com.nc.cool.*;
import com.nc.util.*;
import com.nc.sql.CoolConnection;

import java.sql.*;
import java.util.*;


public class ConnectionManager { 
    static class CounterReference  {
        int value;

        CounterReference() { 
        }
    }


    public ConnectionManager(String s, Properties properties) {
        lock = new Object();
        name = s;
        setProperties(properties);
    }

    public synchronized void setProperties(Properties properties) {
        if(!dbMetaInitialised);
        driver = properties.getProperty("DB_DRIVER", driver);
        database = ServerUtil.parseVar(properties.getProperty("DB_URL", database), properties);
        username = properties.getProperty("DB_USERNAME", username);
        if(password == null)
            password = properties.getProperty("DB_PASSWORD", password);
        charSet = properties.getProperty("DB_CHARSET", "EUC-KR");
        if(connectionPool == null);
        debugPool = "true".equals(properties.getProperty("DB_POOL_DEBUG", "false"));
        conReqTimeout = Long.valueOf(properties.getProperty("DB_CON_REQ_TIMEOUT", "-1")).longValue();
        poolSize = Integer.parseInt(properties.getProperty("DB_POOL_SIZE", "5"));
        pollInterval = Long.valueOf(properties.getProperty("DB_CON_POLL", "3600")).longValue();
        pollTestSQL = properties.getProperty("DB_CON_POLL_SQL", "SELECT Count(ID) FROM tblUser");
        if(poolSize > 0) {
            if(connectionPool == null)
                connectionPool = new Vector(poolSize);
        } else {
            connectionPool = null;
        }
        dbMetaInitialised = false;
    }

    public void initCounterGenerator() {
        if(counterTable == null)
            counterTable = new HashMap();
    }

    public int getNextCounter(CoolConnection coolconnection, String s)
        throws SQLException {
        int i;
        synchronized(counterTable) {
            s = s.toUpperCase();
            CounterReference counterreference = (CounterReference)counterTable.get(s);
            if(counterreference == null){
                counterreference = new CounterReference();
                StringBuffer stringbuffer = new StringBuffer();
                stringbuffer.append("SELECT MAX(id) FROM ");
                stringbuffer.append(s);
                ResultSet resultset = coolconnection.executeQuery(stringbuffer.toString());
                if(resultset.next())
                    counterreference.value = resultset.getInt(1);
                counterTable.put(s, counterreference);
            }
            i = ++counterreference.value;
        }
        return i;
    }

    public int getCurrCounter(String s)
        throws SQLException {
        CounterReference counterreference = (CounterReference)counterTable.get(s);
        return counterreference.value;
    }

    public void resetCounter(String s){
        synchronized(counterTable){
            if(counterTable.containsKey(s))
                counterTable.remove(s);
        }
    }


    public void setDatabaseManager(DatabaseManager databasemanager) {
        dbaseManager = databasemanager;
    }

    synchronized CoolConnection getCoolConnection(int i){
        CoolConnection coolconnection = (CoolConnection)connectionPool.get(i);
        if(coolconnection.request()) {
            idleConnections--;
            return coolconnection;
        } else {
            return null;
        }
    }

    public synchronized CoolConnection getCoolConnection()  throws SQLException{
        if(poolSize > 0) {
            int i = connectionPool.size();
            if(idleConnections > 0) {
                for(int j = 0; j < i; j++) {
                    CoolConnection coolconnection = (CoolConnection)connectionPool.get(j);
                    if(coolconnection.request()) {
                        idleConnections--;
                        if(debugPool)
                            System.out.println("DBPOOL Using cached connection (" + idleConnections + " idle) id=" + coolconnection.id);
                        return coolconnection;
                    }
                }

            }
            
            if(i < poolSize) {
                CoolConnection coolconnection1 = new CoolConnection(this);
                coolconnection1.id = i;
                coolconnection1.ownsConnection = false;
                coolconnection1.request();
                connectionPool.add(coolconnection1);
                if(debugPool)
                	System.out.println("DBPOOL, Creating connection " + coolconnection1.id);
                return coolconnection1;
            }
            
            if(debugPool)
            	System.out.println("DBPOOL, Waiting for connection");
            while(idleConnections == 0 && (i = connectionPool.size()) > 0)
                try {
                    if(conReqTimeout >= 0L)
                        wait(conReqTimeout);
                    else
                        wait();
                }
                catch(InterruptedException interruptedexception) { }
            if(debugPool)
            	System.out.println("DBPOOL, Woken");
            for(int k = 0; k < i; k++) {
                CoolConnection coolconnection2 = (CoolConnection)connectionPool.get(k);
                if(coolconnection2.request()) {
                    idleConnections--;
                    notify();
                    if(debugPool)
                    	System.out.println("DBPOOL, Found cached connection (" + idleConnections + " idle) id=" + coolconnection2.id);
                    return coolconnection2;
                }
            }

            throw new SQLException("No connection available, server may be busy");
        } else {
            CoolConnection coolconnection3 = new CoolConnection(this);
            coolconnection3.ownsConnection = true;
            return coolconnection3;
        }
    }

    Connection getConnection(CoolConnection coolconnection) throws SQLException{
        Connection connection = null;
        try {
            Class.forName(driver);
            Properties properties = new Properties();
            properties.setProperty("user", username);
            properties.setProperty("password", password);
            properties.setProperty("charSet", charSet);
            connection = DriverManager.getConnection(database, properties);
            if(!dbMetaInitialised) {
                dbMetaInitialised = true;
                DatabaseMetaData databasemetadata = connection.getMetaData();
                productName = databasemetadata.getDatabaseProductName();
                productVersion = databasemetadata.getDatabaseProductVersion();
                driverName = databasemetadata.getDriverName();
                driverVersion = databasemetadata.getDriverVersion();
                maxConnections = databasemetadata.getMaxConnections();
                if(poolSize > 0 && pollInterval > 0L) {
                    long l = pollInterval * 1000L;
                    Scheduler.schedule(new ConnectionPollTask(this, pollTestSQL), l, l);
                }
                initCounterGenerator();
            }
            //System.out.println("#################  getConnection Open...."+coolconnection);
        } catch(ClassNotFoundException classnotfoundexception) {
            throw new SQLException("DB_Driver Path"+classnotfoundexception);
        } catch(Exception exception) {
            throw new SQLException("Connection Mgr"+exception.toString());
        }
        return connection;
    } 

    synchronized void releaseConnection(CoolConnection coolconnection)
        throws SQLException {
        if(coolconnection.ownsConnection) {
            if(coolconnection.con != null)
                try {
                    coolconnection.con.close();
                } catch(Exception exception) {
                } finally {
                	//System.out.println("#################    Connection close...."+coolconnection);
                    coolconnection.con = null;
                }
            if(poolSize <= 0);
        } else {
            coolconnection.release();
            idleConnections++;
            notify();
        }
    }

    public synchronized void releaseConnections()
        throws SQLException {
        releaseConnections(false);
    }

    public synchronized void releaseConnections(boolean flag)
        throws SQLException {
        Vector vector = connectionPool;
        connectionPool = new Vector(poolSize);
        int i = vector.size();
        for(int j = 0; j < i; j++)
            try {
                CoolConnection coolconnection = (CoolConnection)vector.get(j);
                if(flag && coolconnection.con != null)
                    try {
                        coolconnection.con.close();
                    } catch(Exception exception1) {
                    } finally {
                        coolconnection.con = null;
                    }
                coolconnection.ownsConnection = true;
            } catch(Exception exception) {
            }

        idleConnections = 0;
        notifyAll();
    }
    
    public int getConnectionCount(){
    	return connectionPool.size();
    }
    
    public int getPoolSize(){
    	return poolSize;
    }

    DatabaseManager dbaseManager;
    String name;
    boolean debugPool;
    int poolSize;
    int idleConnections;
    long pollInterval;
    long conReqTimeout;
    String pollTestSQL;
    Vector connectionPool;
    String driver;
    String database;
    String username;
    String password;
    String charSet;
    Object lock;
    boolean dbMetaInitialised;
    public String productName;
    public String productVersion;
    public String driverName;
    public String driverVersion;
    public int maxConnections;
    HashMap counterTable;
}
