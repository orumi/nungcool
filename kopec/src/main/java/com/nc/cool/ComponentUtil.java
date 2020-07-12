package com.nc.cool;

import java.io.DataOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.nc.util.DBObject;

public class ComponentUtil extends DBObject{  
	
	public ComponentUtil(Connection con){
		super(con);
	}

	public void getComponentList(DataOutputStream out)
	throws SQLException, IOException{
	ResultSet rs = null;
	
	try{
		String sql = "select id,code,description from c_company order by description";
		rs = executeQuery(sql);
		out.writeInt(0);
		while(rs.next()){
			out.writeBoolean(true);
			out.writeInt(rs.getInt("id"));
			out.writeUTF(rs.getString("code"));
			out.writeUTF(rs.getString("description"));
		}
		out.writeBoolean(false);
		if (rs!=null){ rs.close(); rs = null;}
		sql = "select id,code,description from c_businessunit order by description";
		rs = executeQuery(sql);
		out.writeInt(1);
		while(rs.next()){
			out.writeBoolean(true);
			out.writeInt(rs.getInt("id"));
			out.writeUTF(rs.getString("code"));
			out.writeUTF(rs.getString("description"));
		}
		out.writeBoolean(false);
		if (rs!=null){ rs.close(); rs = null;}
		sql = "select id,code,description from c_scorecard order by description";
		rs = executeQuery(sql);
		out.writeInt(2);
		while(rs.next()){
			out.writeBoolean(true);
			out.writeInt(rs.getInt("id"));
			out.writeUTF(rs.getString("code"));
			out.writeUTF(rs.getString("description"));
		}
		out.writeBoolean(false);
		if (rs!=null){ rs.close(); rs = null;}
		sql = "select id,code,description from c_perspective order by description";
		rs = executeQuery(sql);
		out.writeInt(3);
		while(rs.next()){
			out.writeBoolean(true);
			out.writeInt(rs.getInt("id"));
			out.writeUTF(rs.getString("code"));
			out.writeUTF(rs.getString("description"));
		}
		out.writeBoolean(false);
		if (rs!=null){ rs.close(); rs = null;}
		sql = "select id,code,description from c_objective order by description";
		rs = executeQuery(sql);
		out.writeInt(4);
		while(rs.next()){
			out.writeBoolean(true);
			out.writeInt(rs.getInt("id"));
			out.writeUTF(rs.getString("code"));
			out.writeUTF(rs.getString("description"));
		}
		out.writeBoolean(false);
		if (rs!=null){ rs.close(); rs = null;}
		sql = "select id,code,shortname from c_measure order by shortname";
		rs = executeQuery(sql);
		out.writeInt(5);
		while(rs.next()){
			out.writeBoolean(true);
			out.writeInt(rs.getInt("id"));
			out.writeUTF(rs.getString("code"));
			out.writeUTF(rs.getString("shortname"));
		}
		out.writeBoolean(false);
	
	} catch (IOException ie) {
		throw ie;
	} catch (SQLException se) {
		throw se;
	} finally {
		if (rs!=null){ rs.close(); rs = null;}
	}
}
}
