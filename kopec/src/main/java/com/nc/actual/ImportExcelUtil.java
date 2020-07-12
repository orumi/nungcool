package com.nc.actual;

import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class ImportExcelUtil {
	public void getOrgMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		
		try { 
		
			String year = request.getParameter("year");
			String month1 = request.getParameter("month1");
			String month2 = request.getParameter("month2");
			String sbuId = request.getParameter("sbuId");
			String bscId = request.getParameter("bscId");
			
			String mode = request.getParameter("mode");
			String contentId = request.getParameter("contentId"); 
			
			String groupId = (String)request.getSession().getAttribute("groupId");
			int group = 5;
			System.out.println("groupId :" + groupId);
			if (groupId!=null) group = Integer.parseInt(groupId);
			
			if (group>3) return;
			
			String userId = (String)request.getSession().getAttribute("userId");
			
			if (year==null) return;
			System.out.println("OutPut:"+userId+"/"+year+"/"+month1+"/"+month2+"/"+sbuId+"/"+mode+"/"+contentId);
			System.out.println("mode:"+mode);
			//String frq = getFrequecny(new Integer(month1).intValue());
			
			StringBuffer sb = new StringBuffer();
			Object[] params = null;
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			if(mode.equals("detail")) {
				StringBuffer sbItem = new StringBuffer();
				sbItem.append(" SELECT * FROM ")
		         	  .append(" (SELECT * FROM TBLITEM WHERE MEASUREID=(SELECT ID FROM (select ID from TBLMEASUREDEFINE where YEAR = ? AND MEASUREID=? ORDER BY ID) ITEMs WHERE ROWNUM = 1) ) ITEM ");
				params = new Object[] {year, contentId};
								
				rs = dbobject.executePreparedQuery(sbItem.toString(),params);
				
				DataSet dsItem = new DataSet();
				dsItem.load(rs);
				
				request.setAttribute("dsItem", dsItem);
				
				StringBuffer sbItemAct = new StringBuffer();
//				sbItemAct.append(" SELECT * FROM ")
//				         .append(" (SELECT * FROM TBLITEM WHERE MEASUREID IN (SELECT ID FROM TBLMEASUREDEFINE WHERE YEAR = ? AND MEASUREID=?) ) ITEM ")
//				         .append(" LEFT JOIN ")
//				         .append(" (SELECT MEASUREID MID,CODE CD,STRDATE,ACTUAL,ROUND(ACCUM,3) ACCUM,ROUND(AVERAGE,3) AVERAGE FROM TBLITEMACTUAL WHERE STRDATE>=? AND STRDATE <=?) ACT ")
//				         .append(" ON ITEM.CODE=ACT.CD AND ITEM.MEASUREID = ACT.MID ORDER BY MEASUREID, STRDATE, CODE");

				//-------------------------------------------------------------------------------------------------------------------------------------------				
				// 일부 항목만 입력된 경우 처리가 안되어 수정, 2008.05.20 PHG.
				// 
				// and 이렇게 SQL 코딩하면 가독성이 뛰어나지 않나???
				//-------------------------------------------------------------------------------------------------------------------------------------------
				sbItemAct.append(" SELECT a.ym strdate, a.mcid measureid, a.frequency, a.code, a.itemname, a.itementry, a.itemfixed, b.actual                   ");
				sbItemAct.append(" FROM   (                                                                                                                     ");
				sbItemAct.append("         SELECT a.year||c.mm  ym, a.id  mcid, a.frequency, b.code, b.itemname, b.itementry, b.itemfixed                       ");
				sbItemAct.append("         FROM   tblmeasuredefine a, tblitem b,                                                                                ");
				sbItemAct.append("                 (                                                                                                            ");
				sbItemAct.append("                 select '년'   freq, ltrim(to_char(rownum*12, '00')) mm from tblmeasuredefine where rownum  = 1   union all   ");
				sbItemAct.append("                 select '반기' freq, ltrim(to_char(rownum*6 , '00')) mm from tblmeasuredefine where rownum <= 2   union all   ");
				sbItemAct.append("                 select '분기' freq, ltrim(to_char(rownum*3 , '00')) mm from tblmeasuredefine where rownum <= 4   union all   ");
				sbItemAct.append("                 select '월'   freq, ltrim(to_char(rownum*1 , '00')) mm from tblmeasuredefine where rownum <= 12              ");
				sbItemAct.append("                 ) c                                                                                                          ");
				sbItemAct.append("         WHERE  a.id        = b.measureid                                                                                     ");
				sbItemAct.append("         AND    a.frequency = c.freq                                                                                          ");
				sbItemAct.append("         AND    a.year      = ?                                                                                               ");
				sbItemAct.append("         AND    a.measureid = ?                                                                                               ");
				sbItemAct.append("         ) a,                                                                                                                 ");
				sbItemAct.append("         tblitemactual b                                                                                                      ");
				sbItemAct.append(" where  a.ym   = substr(b.strdate(+),1,6)                                                                                     ");
				sbItemAct.append(" and    a.mcid = b.measureid(+)                                                                                               ");
				sbItemAct.append(" and    a.code = b.code     (+)                                                                                               ");
				sbItemAct.append(" and    a.ym  >= ?                                                                                                            ");
				sbItemAct.append(" and    a.ym  <= ?                                                                                                            ");
				sbItemAct.append(" order by a.mcid, a.ym, a.code                                                                                                ");
				
				Object[] pmItem = {year, contentId,year+month1, year+month2};
				
				rs = dbobject.executePreparedQuery(sbItemAct.toString(),pmItem);
				
				DataSet dsItemAct = new DataSet();
				dsItemAct.load(rs);
				
				request.setAttribute("dsItemAct", dsItemAct);
				
				if (groupId.equals("1")){userId = "%";} // 관리자 일 경우 모든성과식적 표시  2008년 10월 27일 배광진씨요청
								
				sb.append(" SELECT * FROM ")
				 .append(" (SELECT A.YEAR AYEAR,A.MEASUREID AMID FROM TBLAUTHORITY A WHERE A.USERID like ? AND YEAR=? ")
		         .append(" UNION ")
		         .append(" SELECT D.YEAR AYEAR,D.ID AMID  FROM TBLMEASUREDEFINE D WHERE D.UPDATEID like ? AND YEAR=?) AUT ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT MEA.*, CASE WHEN MEA.FREQUENCY ='년' THEN CAL1.YM WHEN MEA.FREQUENCY='반기' THEN CAL2.YM ")
				 .append("  WHEN MEA.FREQUENCY='분기' THEN CAL3.YM WHEN MEA.FREQUENCY ='월' THEN CAL4.YM END YM FROM")
		         .append("  (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT, ")
		         .append("  C.NAME MNAME,D.FREQUENCY,T.YEAR MTYEAR,D.MEASUREMENT,D.MEASUREID MSID,C.MEASCHAR,D.ID DID,D.ETLKEY, D.EQUATION  ")
		         .append(" 	 FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='계량' AND D.MEASUREID=? ) MEA ")
		         .append("   LEFT JOIN ")
		         .append("  (SELECT D.ID, C.YM, D.FREQUENCY ")
		         .append("   FROM (SELECT max(YM) YM FROM TZ_CALENDAR WHERE YEAR=? AND MM='12' GROUP BY YM) C, ")
		         .append("   TBLMEASUREDEFINE D WHERE D.FREQUENCY='년' AND D.YEAR=? AND MEASUREMENT='계량' AND MEASUREID=?) CAL1 ")
		         .append("   ON MEA.DID = CAL1.ID AND MEA.FREQUENCY = CAL1.FREQUENCY ")
		         .append("   LEFT JOIN ")
		         .append("  (SELECT D.ID, C.YM, D.FREQUENCY ")
		         .append("   FROM (SELECT max(YM) YM FROM TZ_CALENDAR WHERE YEAR=? AND MM in ('06','12') GROUP BY YM) C, ")
		         .append("   TBLMEASUREDEFINE D WHERE D.FREQUENCY='반기' AND D.YEAR=? AND MEASUREMENT='계량' AND MEASUREID=?) CAL2 ")
		         .append("   ON MEA.DID = CAL2.ID AND MEA.FREQUENCY = CAL2.FREQUENCY ")
		         .append("   LEFT JOIN ")
		         .append("  (SELECT D.ID, C.YM, D.FREQUENCY ")
		         .append("   FROM (SELECT max(YM) YM FROM TZ_CALENDAR WHERE YEAR=? AND MM in ('03','06','09','12') GROUP BY YM) C, ")
		         .append("   TBLMEASUREDEFINE D WHERE D.FREQUENCY='분기' AND D.YEAR=? AND MEASUREMENT='계량' AND MEASUREID=?) CAL3 ")
		         .append("   ON MEA.DID = CAL3.ID AND MEA.FREQUENCY = CAL3.FREQUENCY ")
		         .append("   LEFT JOIN ")
		         .append("  (SELECT D.ID, C.YM, D.FREQUENCY ")
		         .append("   FROM (SELECT max(YM) YM FROM TZ_CALENDAR WHERE YEAR=? GROUP BY YM) C, ")
		         .append("   TBLMEASUREDEFINE D WHERE D.FREQUENCY='월' AND D.YEAR=? AND MEASUREMENT='계량' AND MEASUREID=?) CAL4 ")
		         .append("   ON MEA.DID = CAL4.ID AND MEA.FREQUENCY = CAL4.FREQUENCY ")
		         .append("  ) MEA ON AUT.AMID=MEA.MCID AND AUT.AYEAR=MTYEAR ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
		         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
		         .append(" ON MEA.MPID=OBJ.OID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
		         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
		         .append(" ON OBJ.OPID=PST.PID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
		         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
		         .append(" ON PST.PPID=BSC.BID ")
		         .append(" LEFT JOIN ")
		         .append(" (SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME ")
		         .append(" FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ")
		         .append(" ON BSC.BPID=SBU.SID ")
		         .append(" LEFT JOIN ")
		         .append("(SELECT ROUND(D.ACTUAL,3) ACTUAL,D.PLANNED,D.PLANNEDBASE,D.BASE,D.BASELIMIT,D.LIMIT,FILEPATH,FILENAME,D.MEASUREID,ROUND(S.SCORE,3) SCORE,S.GRADE,S.GRADE_SCORE,S.STRDATE ")
		         .append(" FROM TBLMEASUREDETAIL D, TBLMEASURESCORE S ")
		         .append(" WHERE D.MEASUREID=S.MEASUREID AND D.STRDATE=S.STRDATE ) DET ")
		         .append(" ON MEA.MCID=DET.MEASUREID AND MEA.YM = substr(DET.STRDATE, 0, 6) ")
		         .append(" WHERE MID IS NOT NULL AND YM>='"+year+month1+"' AND YM<='"+year+month2+"'  ")
		         .append(" ORDER BY YM, SID, BID");
				//System.out.println(sb.toString());
				params = new Object[] {userId,year,userId,year, year,contentId, year,year,contentId,year,year,contentId,year,year,contentId,year,year,contentId, year,year,year,year};
			} else {  // get List
				String frq = "'월'";
				
				if ( (new Integer(month1).intValue()==3) || (new Integer(month1).intValue()==9)) {
					frq = frq+",'분기'";
				} else if ((new Integer(month1).intValue()==6) ) {
					frq = frq+",'분기','반기'";
				} else if (new Integer(month1).intValue()==12) {
					frq = frq+",'분기','반기','년'";
				}
				System.out.println("frq:"+frq+"/"+frq.indexOf("년"));
				if ( (new Integer(month2).intValue()==3) || (new Integer(month2).intValue()==9) && frq.indexOf("분기")==-1) {
					frq = frq+",'분기'";
				} else if ((new Integer(month2).intValue()==6) && frq.indexOf("반기")==-1) {
					frq = frq+",'분기','반기'";
				} else if (new Integer(month2).intValue()==12 && frq.indexOf("년")==-1) {
					frq = frq+",'분기','반기','년'";
				}
				System.out.println("groupId  2:" + groupId);
				if (groupId.equals("1")){ 
					//관리자 일 경우 모든성과실적 표시  2008년 10월 27일 배광진씨요청으로 수정
					
				
					sb.append(" SELECT DISTINCT MNAME, FREQUENCY, MSID, MEASCHAR FROM ")
			         .append(" (SELECT A.YEAR AYEAR,A.MEASUREID AMID FROM TBLAUTHORITY A WHERE  YEAR=? ")
			         .append(" UNION ")
			         .append(" SELECT D.YEAR AYEAR,D.ID AMID  FROM TBLMEASUREDEFINE D WHERE  YEAR=?) AUT ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,T.YEAR MTYEAR,D.MEASUREMENT,D.MEASUREID MSID,C.MEASCHAR  ")
			         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='계량'  AND D.FREQUENCY IN ("+frq+") ) MEA ")
			         .append(" ON AUT.AMID=MEA.MCID AND AUT.AYEAR=MTYEAR ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
			         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
			         .append(" ON MEA.MPID=OBJ.OID ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
			         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
			         .append(" ON OBJ.OPID=PST.PID ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
			         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
			         .append(" ON PST.PPID=BSC.BID ")
			         .append(" LEFT JOIN ")
			         .append("(SELECT ROUND(D.ACTUAL,3) ACTUAL,D.PLANNED,D.PLANNEDBASE,D.BASE,D.BASELIMIT,D.LIMIT,FILEPATH,FILENAME,D.MEASUREID,ROUND(S.SCORE,3) SCORE,S.GRADE,S.GRADE_SCORE FROM TBLMEASUREDETAIL D, TBLMEASURESCORE S ")
			         .append(" WHERE D.MEASUREID=S.MEASUREID AND SUBSTR(D.STRDATE,1,6) = SUBSTR(S.STRDATE,1,6) ) DET ")
			         .append(" ON AUT.AMID=DET.MEASUREID ")
			         .append(" WHERE MID IS NOT NULL ORDER BY MNAME");
					
					params = new Object[] {year,year, year,year,year,year};
				} else { //관리자가 아닌경우 로그인시
					sb.append(" SELECT DISTINCT MNAME, FREQUENCY, MSID, MEASCHAR FROM ")
			         .append(" (SELECT A.YEAR AYEAR,A.MEASUREID AMID FROM TBLAUTHORITY A WHERE A.USERID like ? AND YEAR=? ")
			         .append(" UNION ")
			         .append(" SELECT D.YEAR AYEAR,D.ID AMID  FROM TBLMEASUREDEFINE D WHERE D.UPDATEID  like ? AND YEAR=?) AUT ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME,D.FREQUENCY,T.YEAR MTYEAR,D.MEASUREMENT,D.MEASUREID MSID,C.MEASCHAR  ")
			         .append(" FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? AND MEASUREMENT='계량'  AND D.FREQUENCY IN ("+frq+") ) MEA ")
			         .append(" ON AUT.AMID=MEA.MCID AND AUT.AYEAR=MTYEAR ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ")
			         .append(" FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
			         .append(" ON MEA.MPID=OBJ.OID ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ")
			         .append(" FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ")
			         .append(" ON OBJ.OPID=PST.PID ")
			         .append(" LEFT JOIN ")
			         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ")
			         .append(" FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ")
			         .append(" ON PST.PPID=BSC.BID ")
			         .append(" LEFT JOIN ")
			         .append("(SELECT ROUND(D.ACTUAL,3) ACTUAL,D.PLANNED,D.PLANNEDBASE,D.BASE,D.BASELIMIT,D.LIMIT,FILEPATH,FILENAME,D.MEASUREID,ROUND(S.SCORE,3) SCORE,S.GRADE,S.GRADE_SCORE FROM TBLMEASUREDETAIL D, TBLMEASURESCORE S ")
			         .append(" WHERE D.MEASUREID=S.MEASUREID AND SUBSTR(D.STRDATE,1,6) = SUBSTR(S.STRDATE,1,6) ) DET ")
			         .append(" ON AUT.AMID=DET.MEASUREID ")
			         .append(" WHERE MID IS NOT NULL ORDER BY MNAME");
					
					params = new Object[] {userId,year,userId,year, year,year,year,year};					
				}
			}
			
			rs = dbobject.executePreparedQuery(sb.toString(),params);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			System.out.println(sb);
			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}		
	}
}
