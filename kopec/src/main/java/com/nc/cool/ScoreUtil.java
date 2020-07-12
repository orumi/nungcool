package com.nc.cool;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;

public class ScoreUtil {
	
	public StringBuffer getMeasureDetail(String year, int id)
	throws SQLException, IOException{
		DBObject dbobject = null;	
		CoolConnection conn = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			StringBuffer sql = new StringBuffer();
			sql.append("select d.measureid,to_char(d.effectivedate,'YYYYMMDD') strdate,d.actual,d.weighting, d.planned,d.best,d.worst,d.benchmark,d.bau,s.score from ") 
				.append(" (select * from a_measuredetail where (to_char(effectivedate,'YYYY')) = ? and measureid=? ) d  ")
				.append(" left join ")
				.append(" (select score, measureid, effectivedate from a_measurescore where (to_char(effectivedate,'YYYY'))=? and measureid=?) s ")
				.append(" on d.measureid=s.measureid and d.effectivedate=s.effectivedate ")
				.append(" order by d.effectivedate ");
			Integer integer = new Integer(id);
			Object[] params = {year, integer, year, integer};
			
			if (dbobject == null) dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executePreparedQuery(sql.toString(), params);
			
			while(rs.next()){
				sb.append(rs.getInt("measureid")+"|");
				sb.append(rs.getString("strdate")+"|");
				sb.append(rs.getDouble("actual")+"|");
				sb.append(rs.getDouble("weighting")+"|");
				sb.append(rs.getDouble("planned")+"|");
				sb.append(rs.getDouble("best")+"|");
				sb.append(rs.getDouble("worst")+"|");
				sb.append(rs.getDouble("benchmark")+"|");
				sb.append(rs.getDouble("bau")+"|");
				sb.append(rs.getDouble("score"));
				sb.append("\n");
			}
			return sb;
	} catch (SQLException se) {
		throw se;
	} finally {
		if (rs!=null){ rs.close(); rs = null;}
		if (dbobject != null){dbobject.close(); dbobject = null;}
		if (conn!=null){conn.close(); conn = null;}
	}
}
}
