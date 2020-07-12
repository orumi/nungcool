package com.nc.eis;

import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class BusinessAdministration {
	public void setBusinessAdministrationList(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);			
			dbobject = new DBObject(conn.getConnection());			
			
			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			sbSQL.append(" SELECT		MAX(A.DISP_ORD) DISP_ORD,								")
    	     	 .append("				A.EIS_NO,												")
    	     	 .append("				F_GETCODENM('E02',A.EIS_NO) EIS_NM,						")
    	     	 .append("				A.LDIV_CD, 												")
    	     	 .append("				A.LDIV_NM,												")
    	     	 .append("				A.SDIV_CD, 												")
    	     	 .append("				A.SDIV_NM, 												")
    	     	 .append("				MAX(CASE WHEN A.RNO = 7 THEN B.ACTUAL_VALUE END) VAL1,	")
    	     	 .append("				MAX(CASE WHEN A.RNO = 6 THEN B.ACTUAL_VALUE END) VAL2,	")
    	     	 .append("				MAX(CASE WHEN A.RNO = 5 THEN B.ACTUAL_VALUE END) VAL3,	")
    	     	 .append("				MAX(CASE WHEN A.RNO = 4 THEN B.ACTUAL_VALUE END) VAL4,	")
    	     	 .append("				MAX(CASE WHEN A.RNO = 3 THEN B.ACTUAL_VALUE END) VAL5,	")
    	     	 .append("				MAX(CASE WHEN A.RNO = 2 THEN B.ACTUAL_VALUE END) VAL6,	")
    	     	 .append("				MAX(CASE WHEN A.RNO = 1 THEN B.ACTUAL_VALUE END) VAL7	") 
    	     	 .append(" FROM			(														")
    	     	 .append("				SELECT		C.EIS_YEAR, 								")
    	     	 .append("							RNO,										")
    	     	 .append("							A.EIS_NO, 									")
    	     	 .append("							A.LDIV_CD, 									")
    	     	 .append("							A.DIV_NM LDIV_NM,							")
    	     	 .append("							B.SDIV_CD,									")
    	     	 .append("							B.DIV_NM SDIV_NM, 							")
    	     	 .append("							B.DOT_POS, 									")
    	     	 .append("							B.DISP_ORD		   							")
    	     	 .append("				FROM		TE_EISRPT A,								")
    	     	 .append("							TE_EISRPTFORM B, 							")
    	     	 .append("							(											")
    	     	 .append("							SELECT	2007 - ROWNUM + 1 EIS_YEAR, 		")
    	     	 .append("									ROWNUM RNO							")
    	     	 .append("							FROM	TZ_CALENDAR							")
    	     	 .append("							WHERE	ROWNUM <= 7							")
    	     	 .append("							) C 										")
    	     	 .append("				WHERE		A.EIS_NO  = B.EIS_NO						")
    	     	 .append("				AND			A.LDIV_CD = B.LDIV_CD						")
    	     	 .append("				AND			A.EIS_NO LIKE '%'							")
    	     	 .append("				ORDER BY	B.DISP_ORD,C.EIS_YEAR						")
    	     	 .append("				) A,													")
    	     	 .append("				TE_EISRPTRSLT B											")
    	     	 .append(" WHERE		A.EIS_NO   = B.EIS_NO   (+)								")
    	     	 .append(" AND			A.LDIV_CD  = B.LDIV_CD  (+)								")
    	     	 .append(" AND			A.SDIV_CD  = B.SDIV_CD  (+)								")
    	     	 .append(" AND			A.EIS_YEAR = B.EIS_YEAR (+)								")
    	     	 .append(" GROUP BY		A.EIS_NO, A.LDIV_CD, A.LDIV_NM, A.SDIV_CD, A.SDIV_NM	")
    	     	 .append(" ORDER BY		A.EIS_NO, A.LDIV_CD, A.SDIV_CD 							"); 
			
			System.out.println(sbSQL);
			
			Object[] pmSQL = {};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("setBusinessAdministrationList : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}	
	}
}



