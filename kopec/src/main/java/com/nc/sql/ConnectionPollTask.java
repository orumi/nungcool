package com.nc.sql;

import com.nc.util.ScheduledTask;

import java.sql.ResultSet;

public class ConnectionPollTask extends ScheduledTask{

	ConnectionManager conManager;
	String pollTestSQL;
	
	public ConnectionPollTask(ConnectionManager connectionManager, String s){
		conManager = connectionManager;
		pollTestSQL = s;
	}
	
	public void run() {
		if(conManager.connectionPool == null)
			return ;
		int i = conManager.connectionPool.size();
		Object obj = null;
		//Log.debug("ConnectionPollTask.run",conManager.name+"polling connections");
		for (int j = 0; j < i; j++) {
			CoolConnection coolConnection = conManager.getCoolConnection(j);
			if(coolConnection != null)
				try{
					coolConnection.createStatement(true);
					ResultSet resultset = coolConnection.executeQuery(pollTestSQL);
				} catch(Exception e){
					System.out.println("ConnectionPollTask.run Exception occurred during polling. Closing conenction :"+e);
					coolConnection.ownsConnection = true;
				} finally {
					System.out.println("coolConnection close at :"+j+"/"+i);
					coolConnection.close();
				}
		}
		
	}
	

}
