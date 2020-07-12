package com.nc.etl;

import java.sql.ResultSet;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.*;


public class ET010103 {
	
	
	public DataSet getLogList(String sLogDate1, String sLogDate2) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());		
			DataSet ds1 = null;
			String sql = "";
			
			sql = "SELECT z1.inputdate, z1.etlkey, z1.itemcode, z1.log, z1.frequency  \n"
				+ "   , to_char(z1.inputdate,'yyyy-mm-dd HH:MM') inputdate1           \n"
				+ "   , (SELECT deptname FROM tblorganization WHERE deptcode=z1.deptcode) deptname  \n"
				+ "   , (SELECT name FROM tblmeasurepool WHERE id=z1.contentid ) contentname        \n"
				+ "   , (SELECT itemname FROM tblmeasureitem WHERE measureid=z1.contentid AND itemcode=z1.itemcode ) itemname  \n"
				+ " FROM  \n" 
				+ " (     \n"
				+ "  SELECT a.inputdate, a.etlkey, a.itemcode, a.log  \n"
				+ "    , (SELECT max(frequency)  FROM tblmeasuredefine WHERE etlkey=a.etlkey ) frequency  \n"
				+ "    , (SELECT contentid  FROM tbltreescore  WHERE treecls='BSC_ALIAS' AND  measuredefineid=(SELECT MAX(id)  FROM tblmeasuredefine WHERE etlkey=a.etlkey) ) contentid  \n"
				+ "    , (SELECT deptcode  FROM tbltreescore  WHERE treecls='BSC_ALIAS' AND  measuredefineid=(SELECT MAX(id)  FROM tblmeasuredefine WHERE etlkey=a.etlkey) ) deptcode    \n"     
				+ "  FROM tbletllog a  \n"
				+ "  WHERE a.logdate BETWEEN '" + sLogDate1 + "' AND '" + sLogDate2 + "'   \n"
				+ "  ) z1                         \n" 
				+ " ORDER BY z1.inputdate DESC    \n"
				;

			rs = dbobject.executeQuery(sql);
			ds1 = new DataSet();
			
			ds1.load(rs);
			
			return ds1;
			
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
		
		return null;
	}
	

}
