package com.nc.eis;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class EISAdministration {

	/*
	 *   EIS : 정형화된 리포트 Form의 데이타를 구하는 SQL
	 */
	public void getRptFormList(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {
			//System.out.println("@@@@@@@@@@@@");
			String year    = request.getParameter("year");
			String eis_no = request.getParameter("eis_no");

			//System.out.println("year="+year+"\n");

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			dbobject = new DBObject(conn.getConnection());

			// GET DETAIL;;
			StringBuffer sbSQL =  new StringBuffer();
			  sbSQL.append(" SELECT	                            							")
		    	     	 .append("				A.EIS_NO,												")
		    	     	 .append("				F_GETCODENM('E02',A.EIS_NO) EIS_NM,						")
		    	     	 .append("				A.LDIV_CD, 												")
		    	     	 .append("				A.LDIV_NM,												")
		    	     	 .append("				A.SDIV_CD, 												")
		    	     	 .append("				A.SDIV_NM, 												")
		    	     	 .append("				TO_CHAR(MAX(CASE WHEN A.RNO = 7 THEN B.ACTUAL_VALUE END),'999,999,999,999') AS VAL1,	")
		    	     	 .append("				TO_CHAR(MAX(CASE WHEN A.RNO = 6 THEN B.ACTUAL_VALUE END),'999,999,999,999') AS VAL2,	")
		    	     	 .append("				TO_CHAR(MAX(CASE WHEN A.RNO = 5 THEN B.ACTUAL_VALUE END),'999,999,999,999') AS VAL3,	")
		    	     	 .append("				TO_CHAR(MAX(CASE WHEN A.RNO = 4 THEN B.ACTUAL_VALUE END),'999,999,999,999') AS VAL4,	")
		    	     	 .append("				TO_CHAR(MAX(CASE WHEN A.RNO = 3 THEN B.ACTUAL_VALUE END),'999,999,999,999') AS VAL5,	")
		    	     	 .append("				TO_CHAR(MAX(CASE WHEN A.RNO = 2 THEN B.ACTUAL_VALUE END),'999,999,999,999') AS VAL6,	")
		    	     	 .append("				TO_CHAR(MAX(CASE WHEN A.RNO = 1 THEN B.ACTUAL_VALUE END),'999,999,999,999') AS VAL7,	")
		    	     	 .append("				MAX(A.DISP_ORD) DISP_ORD                                ")
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
		    	     	 .append("							SELECT  to_number(?) - ROWNUM + 1 EIS_YEAR, ")
		    	     	 .append("									ROWNUM RNO							")
		    	     	 .append("							FROM	TZ_CALENDAR							")
		    	     	 .append("							WHERE	ROWNUM <= 7							")
		    	     	 .append("							) C 										")
		    	     	 .append("				WHERE		A.EIS_NO  = B.EIS_NO						")
		    	     	 .append("				AND			A.LDIV_CD = B.LDIV_CD						")
		    	     	 .append("				ORDER BY	B.DISP_ORD,C.EIS_YEAR						")
		    	     	 .append("				) A,													")
		    	     	 .append("				TE_EISRPTRSLT B											")
		    	     	 .append(" WHERE		A.EIS_NO   = B.EIS_NO   (+)								")
		    	     	 .append(" AND			A.LDIV_CD  = B.LDIV_CD  (+)								")
		    	     	 .append(" AND			A.SDIV_CD  = B.SDIV_CD  (+)								")
		    	     	 .append(" AND			A.EIS_YEAR = B.EIS_YEAR (+)								")
		    	     	 .append(" GROUP BY		A.EIS_NO, A.LDIV_CD, A.LDIV_NM, A.SDIV_CD, A.SDIV_NM	")
		    	     	 .append(" ORDER BY		A.EIS_NO, A.LDIV_CD, A.SDIV_CD 							");

			//System.out.println(sbSQL + "\n");
			//System.out.println(eis_no);

			//Object[] pmSQL =  {year, eis_no};
			Object[] pmSQL =  {year};
			rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds",ds);
		} catch (Exception e) {
			try{ conn.rollback(); } catch (Exception ex) {};
			System.out.println("getRptFormList : " + e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}

		/*
		 *   EIS : 심사분석 -> 경영관리 -> 인원추이 Graph
		 */
		public void getGraphManCnt(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String year    = request.getParameter("year");
				String eis_no = request.getParameter("eis_no");

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
	             sbSQL.append(" select max(a.disp_ord) disp_ord,                                                   \n")
	                  .append("     a.eis_no, f_getcodenm('E02',a.eis_no)  eis_nm,                                 \n")
	                  .append("     a.ldiv_cd, a.ldiv_nm, a.eis_year,                                              \n")
	                  .append("     sum(case when a.sdiv_cd = '01' then b.actual_value else null end) sdiv_cd01,   \n")
	                  .append("     sum(case when a.sdiv_cd = '02' then b.actual_value else null end) sdiv_cd02    \n")
	                  .append(" from                                                                               \n")
	                  .append("    (                                                                               \n")
	                  .append("    select c.eis_year , rno,                                                        \n")
	                  .append("         a.eis_no, a.ldiv_cd, a.div_nm   ldiv_nm,                                   \n")
	                  .append("           b.sdiv_cd, b.div_nm   sdiv_nm, b.dot_pos , b.disp_ord                    \n")
	                  .append("    from   te_eisrpt     a,                                                         \n")
	                  .append("         te_eisrptform b,                                                           \n")
	                  .append("         (select to_number(?) - rownum + 1 eis_year, rownum rno                     \n")
	                  .append("        from   tz_calendar                                                          \n")
	                  .append("        where  rownum <= 7                                                          \n")
	                  .append("        ) c                                                                         \n")
	                  .append("    where  a.eis_no  = b.eis_no                                                     \n")
	                  .append("    and    a.ldiv_cd = b.ldiv_cd                                                    \n")
	                  .append("    and    a.eis_no like ?                                                          \n")
	                  .append("    order by b.disp_ord, c.eis_year                                                 \n")
	                  .append("    ) a,                                                                            \n")
	                  .append("    te_eisrptrslt b                                                                 \n")
	                  .append(" where  a.eis_no   = b.eis_no   (+)                                                 \n")
	                  .append(" and    a.ldiv_cd  = b.ldiv_cd  (+)                                                 \n")
	                  .append(" and    a.sdiv_cd  = b.sdiv_cd  (+)                                                 \n")
	                  .append(" and    a.eis_year = b.eis_year (+)                                                 \n")
	                  .append(" group by a.eis_no, a.ldiv_cd, a.ldiv_nm, a.eis_year                                \n")
	                  .append(" order by a.eis_no, a.ldiv_cd                                                       \n");

				//System.out.println("@@@@@@@@@@@@@");
	            //System.out.println(sbSQL);

				Object[] pmSQL =  {year, eis_no};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getGraphManCnt : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 심사분석 > 사업개발 > 사업개발
		 */
		public void getEisTeSalesAmt(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String year    	= request.getParameter("year");
				String eis_no 	= request.getParameter("eis_no");

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append(" SELECT		DECODE(BIZ_LDIV_CD,'01','수주원별','02','분야별') AS BIZ_LDIV_CD,		")
	    	         .append("				CASE	WHEN BIZ_LDIV_CD = '01' AND BIZ_SDIV_CD = '01' THEN '한전'	")
	    	         .append("						WHEN BIZ_LDIV_CD = '01' AND BIZ_SDIV_CD = '02' THEN '비한전'	")
	    	         .append("						WHEN BIZ_LDIV_CD = '01' AND BIZ_SDIV_CD = '03' THEN '해외'	")
	    	         .append("						WHEN BIZ_LDIV_CD = '02' AND BIZ_SDIV_CD = '01' THEN '용역'	")
	    	         .append("						WHEN BIZ_LDIV_CD = '02' AND BIZ_SDIV_CD = '02' THEN '공사'	")
	    	         .append("						WHEN BIZ_LDIV_CD = '02' AND BIZ_SDIV_CD = '03' THEN '판매'	")
	    	         .append("				END BIZ_SDIV_CD,													")
	    	         .append("				TRIM(TO_CHAR(BEF_SALE_AMT,'999,999,999,999')) AS BEF_SALE_AMT,			")
	    	         .append("				TRIM(TO_CHAR(PLAN_AMT,'999,999,999,999')) AS PLAN_AMT,					")
	    	         .append("				TRIM(TO_CHAR(ACTUAL_AMT,'999,999,999,999')) AS ACTUAL_AMT,				")
	    	         .append("				TRIM(TO_CHAR((ACTUAL_AMT - PLAN_AMT),'999,999,999,999')) AS VARIATION,	")
	    	         .append("				TRIM(ROUND(((ACTUAL_AMT / PLAN_AMT) * 100),1)) AS ACHIEVE_RATE,			")
	    	         .append("				TRIM(TO_CHAR((ACTUAL_AMT - BEF_SALE_AMT),'999,999,999,999')) AS PRE_YEAR_VARIAT	")


	    	         .append(" FROM			TE_SALESAMT															")
	    	         .append(" WHERE		EIS_YEAR = ?														");
				//System.out.println(sbSQL);

				Object[] pmSQL =  {year};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getRptFormList : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 심사분석 > 사업개발 > 사업개발
		 */
		public void getEisTeContractAmt(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String year    	= request.getParameter("year");
				String eis_no 	= request.getParameter("eis_no");

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append(" SELECT	DEPT_CD,		DEPT_NM, 																")
			     	 .append("			TRIM(TO_CHAR(BEF_CONT_AMT,'999,999,999,999')) AS BEF_CONT_AMT,							")
			     	 .append("			TRIM(TO_CHAR(SALE_AMT,'999,999,999,999')) AS SALE_AMT,									")
			     	 .append("			TRIM(TO_CHAR(CONT_AMT,'999,999,999,999')) AS C0NT_AMT,									")
			     	 .append("			TRIM(TO_CHAR(END_YEAR_CONTRACT_BALANCE,'999,999,999,999')) AS END_YEAR_CONTRACT_BALANCE,")
			     	 .append("			TRIM(TO_CHAR(PRE_YEAR_VARIAT,'999,999,999,999')) AS PRE_YEAR_VARIAT						")
			     	 .append(" FROM		(																						")
			     	 .append("			SELECT  EIS_YEAR AS EIS_YEAR,															")
			     	 .append("					D.DEPT_NM,	 D.DEPT_CD,															")
			     	 .append("					BEF_CONT_AMT,																	")
			     	 .append("					SALE_AMT,																		")
			     	 .append("					CONT_AMT,																		")
			     	 .append("					NVL(BEF_CONT_AMT,0) - NVL(SALE_AMT,0) + NVL(CONT_AMT,0) AS END_YEAR_CONTRACT_BALANCE,")
			     	 .append("					NVL(BEF_CONT_AMT,0) - NVL(SALE_AMT,0) + NVL(CONT_AMT,0) - NVL(BEF_CONT_AMT,0) AS PRE_YEAR_VARIAT	                    ")
			     	 .append("			FROM	TE_DEPT D left outer join  TE_CONTRACTAMT A ON D.DEPT_CD = A.DEPT_CD(+) and A.EIS_YEAR=? Where D.Year=?	")
			     	 .append("			) Z																						");
				//System.out.println(sbSQL);

				Object[] pmSQL =  {year, year};
				//System.out.println("year ==> " + year);
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getRptFormList : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 심사분석 > 사업개발 > 사업개발
		 */
		public void getEisTeIntellActual(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String year    	= request.getParameter("year");
				String eis_no 	= request.getParameter("eis_no");

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
			    sbSQL.append(" SELECT  	NAT_GBN_CD,                                                                                                                       	")
		     	     .append("	        PATENT_APPLY,                                                                                                                   	")
		     	     .append("	        PATENT_REGI,                                                                                                                    	")
		     	     .append("	        BREND_REGI,                                                                                                                     	")
		     	     .append("	        TECH_REGI,                                                                                                                      	")
		     	     .append("	        COPYRIGHT,                                                                                                                      	")
		     	     .append("         	PROGRAM,                                                                                                                          	")
		     	     .append("	        SUM                                                                                                                             	")
		     	     .append("	FROM    (                                                                                                                               	")
		     	     .append("	        SELECT  EIS_YEAR AS EIS_YEAR,                                                                                           	")
		     	     .append("	                DECODE(NAT_GBN_CD,'01','국내','02','해외') AS NAT_GBN_CD,                                                               		")
		     	     .append("	                PATENT_APPLY,                                                                                                           	")
		     	     .append("	                PATENT_REGI,                                                                                                            	")
		     	     .append("	                BREND_REGI,                                                                                                             	")
		     	     .append("	                TECH_REGI,                                                                                                              	")
		     	     .append("	                COPYRIGHT,                                                                                                              	")
		     	     .append("                 	PROGRAM,                                                                                                                  	")
		     	     .append("                 	NVL(PATENT_APPLY,0) + NVL(PATENT_REGI,0) + NVL(BREND_REGI,0) + NVL(TECH_REGI,0) + NVL(COPYRIGHT,0) + NVL(PROGRAM,0) AS SUM	")
		     	     .append("         FROM    	TE_INTELLACTUAL																												")
		     	     .append("         )																																	")
		     	     .append(" WHERE   EIS_YEAR = ?																															");
				//System.out.println(sbSQL);

				Object[] pmSQL =  {year};
				//System.out.println("year ==> " + year);
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getRptFormList : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 경영현황 > 인력현황 : 사용안함(Query 오류)
		 *   - 개새끼 이따위로 Query문을 만드는 놈이 어딨있냐?
		 *     동업자의식이라고는 하나도 없는 놈 같으니라고...
		 *   - 앞으로 이딴식으로 코딩하는 놈 있으면 죽여버린다.
		 */
		public void getEisTeManCnt(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String yearMn  	= request.getParameter("yearMn");
				//System.out.println("yearMn="+yearMn);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append(" SELECT	SUBSTR(a.EIS_YEAR,0,4) || '-' || SUBSTR(a.EIS_YEAR,5,2) AS EIS_YEAR,																")
			     	 .append("          TRIM(TO_CHAR(TO_NUMBER(a.IY_VAL),'999,999,999,999')) AS IY_VAL,																		")
					 .append("          TRIM(TO_CHAR(a.IYF_VAL,'999,999,999,999')) AS IYF_VAL,																				")
					 .append("          TRIM(TO_CHAR(a.JK_VAL,'999,999,999,999')) AS JK_VAL,																				")
					 .append("          TRIM(TO_CHAR(a.JKF_VAL,'999,999,999,999')) AS JKF_VAL,																				")
					 .append("          TRIM(TO_CHAR(a.BJ_VAL,'999,999,999,999')) AS BJ_VAL,																				")
					 .append("          TRIM(TO_CHAR(a.BJF_VAL,'999,999,999,999')) AS BJF_VAL,																				")
			     	 .append("          a.YK_VAL,																															")
			     	 .append("          a.YB_VAL,																															")
			     	 .append("          a.JJ_VAL,																															")
			     	 .append("          TRIM(TO_CHAR(a.IYC_VAL,'999,999,999,999')) AS IYC_VAL,																				")
					 .append("          TRIM(TO_CHAR(a.JKC_VAL,'999,999,999,999')) AS JKC_VAL,																				")
					 .append("          TRIM(TO_CHAR(a.BJC_VAL,'999,999,999,999')) AS BJC_VAL,																				")
					 .append("          TRIM(TO_CHAR(a.JH_VAL,'999,999,999,999')) AS JH_VAL,																				")
					 .append("          TRIM(TO_CHAR(a.HH_VAL,'999,999,999,999')) AS HH_VAL,																				")
					 .append("          TRIM(TO_CHAR((a.IYC_VAL + a.JKC_VAL + a.BJC_VAL),'999,999,999,999')) AS HM_VAL,														")
			     	 .append("			a.IY_NAME,																															")
			     	 .append("			a.JK_NAME,																															")
			     	 .append("			a.BJ_NAME,																															")
			     	 .append("			a.YK_NAME,																															")
			     	 .append("			a.YB_NAME																															")
			     	 .append(" FROM		(          																															")
			     	 .append("			SELECT	a.IY_VAL,																													")
			     	 .append("                  a.IYF_VAL,																													")
			     	 .append("                  a.JK_VAL,																													")
			     	 .append("                  a.JKF_VAL,																													")
			     	 .append("                  a.BJ_VAL,																													")
			     	 .append("                  a.BJF_VAL,																													")
			     	 .append("                  a.YK_VAL,																													")
			     	 .append("                  a.YB_VAL,																													")
			     	 .append("                  a.EIS_YEAR,																													")
			     	 .append("                  (a.IY_VAL + a.JK_VAL) AS JJ_VAL,																							")
			     	 .append("                  (a.IYF_VAL - a.IY_VAL) AS IYC_VAL,																							")
			     	 .append("                  (a.JKF_VAL - a.JK_VAL) AS JKC_VAL,																							")
			     	 .append("                  (a.BJF_VAL - a.BJ_VAL) AS BJC_VAL,																							")
			     	 .append("                  (a.IYF_VAL + a.JKF_VAL + a.BJF_VAL) AS JH_VAL,																				")
			     	 .append("                  (a.IY_VAL + a.JK_VAL + a.BJ_VAL) AS HH_VAL,																					")
			     	 .append("                  a.IY_NAME,																													")
			     	 .append("                  a.JK_NAME,																													")
			     	 .append("                  a.BJ_NAME,																													")
			     	 .append("                  a.YK_NAME,																													")
			     	 .append("                  a.YB_NAME																													")
			     	 .append("          FROM    (          																													")
			     	 .append("                  SELECT	a.IY_VAL,																											")
			     	 .append("                          a.IYF_VAL,																											")
			     	 .append("                          a.JK_VAL,																											")
			     	 .append("                          a.JKF_VAL,																											")
			     	 .append("                          a.BJ_VAL,																											")
			     	 .append("                          a.BJF_VAL,																											")
			     	 .append("                          a.YK_VAL,																											")
			     	 .append("                          a.YB_VAL,																											")
			     	 .append("                          a.EIS_YEAR,																											")
			     	 .append("                          (																													")
			     	 .append("                          SELECT    DIV_NM																									")
			     	 .append("                          FROM      TZ_COMCODE																								")
			     	 .append("                          WHERE     LDIV_CD = 'E10'																							")
			     	 .append("                          AND       SDIV_CD = a.IY_CD																							")
			     	 .append("                          ) AS IY_NAME,																										")
			     	 .append("                          (																													")
			     	 .append("                          SELECT    DIV_NM																									")
			     	 .append("                          FROM      TZ_COMCODE																								")
			     	 .append("                          WHERE     LDIV_CD = 'E10'																							")
			     	 .append("                          AND       SDIV_CD = a.JK_CD																							")
			     	 .append("                          ) AS JK_NAME,																										")
			     	 .append("                          (																													")
			     	 .append("                          SELECT    DIV_NM																									")
			     	 .append("                          FROM      TZ_COMCODE																								")
			     	 .append("                          WHERE     LDIV_CD = 'E10'																							")
			     	 .append("                          AND       SDIV_CD = a.BJ_CD																							")
			     	 .append("                          ) AS BJ_NAME,																										")
			     	 .append("                          (																													")
			     	 .append("                          SELECT    DIV_NM																									")
			     	 .append("                          FROM      TZ_COMCODE																								")
			     	 .append("                          WHERE     LDIV_CD = 'E10'																							")
			     	 .append("                          AND       SDIV_CD = a.YK_CD																							")
			     	 .append("                          ) AS YK_NAME,																										")
			     	 .append("                          (																													")
			     	 .append("                          SELECT    DIV_NM																									")
			     	 .append("                          FROM      TZ_COMCODE																								")
			     	 .append("                          WHERE     LDIV_CD = 'E10'																							")
			     	 .append("                          AND       SDIV_CD = a.YB_CD																							")
			     	 .append("                          ) YB_NAME																											")
			     	 .append("                   FROM	(          																											")
			     	 .append("                          SELECT		SUM(a.IY_VAL) AS IY_VAL,																				")
			     	 .append("										SUM(a.IYF_VAL) AS IYF_VAL,																				")
			     	 .append("										SUM(a.JK_VAL) AS JK_VAL,																				")
			     	 .append("										SUM(a.JKF_VAL) AS JKF_VAL,																				")
			     	 .append("										SUM(a.BJ_VAL) AS BJ_VAL,																				")
			     	 .append("										SUM(a.BJF_VAL) AS BJF_VAL,																				")
			     	 .append("										SUM(a.YK_VAL) AS YK_VAL,																				")
			     	 .append("										SUM(a.YB_VAL) AS YB_VAL,																				")
			     	 .append("										a.EIS_YEAR,																								")
			     	 .append("										SUM(a.IY_CD) AS IY_CD,																					")
			     	 .append("										SUM(a.JK_CD) AS JK_CD,																					")
			     	 .append("										SUM(a.BJ_CD) AS BJ_CD,																					")
			     	 .append("										SUM(a.YK_CD) AS YK_CD,																					")
			     	 .append("										SUM(a.YB_CD) AS YB_CD																					")
			     	 .append("                          FROM		(          																								")
			     	 .append("										SELECT	a.CURR_CNT_SUM,																					")
			     	 .append("						        				a.FULL_CNT_SUM,																					")
			     	 .append("						        				a.EIS_YEAR,																						")
			     	 .append("						        				a.MAN_GBN_CD,																					")
			     	 .append("						        				case when a.MAN_GBN_CD = '10' then a.CURR_CNT_SUM end IY_VAL,									")
			     	 .append("						        				case when a.MAN_GBN_CD = '10' then a.FULL_CNT_SUM end IYF_VAL,									")
			     	 .append("						        				case when a.MAN_GBN_CD = '20' then a.CURR_CNT_SUM end JK_VAL,									")
				     .append("						        				case when a.MAN_GBN_CD = '20' then a.FULL_CNT_SUM end JKF_VAL,									")
				     .append("						        				case when a.MAN_GBN_CD = '30' then a.CURR_CNT_SUM end BJ_VAL,									")
				     .append("						        				case when a.MAN_GBN_CD = '30' then a.FULL_CNT_SUM end BJF_VAL,									")
				     .append("						        				case when a.MAN_GBN_CD = '40' then a.CURR_CNT_SUM end YK_VAL,									")
				     .append("						        				case when a.MAN_GBN_CD = '50' then a.CURR_CNT_SUM end YB_VAL,									")
				     .append("						        				case when a.MAN_GBN_CD = '10' then a.MAN_GBN_CD end IY_CD, 										")
				     .append("						        				case when a.MAN_GBN_CD = '20' then a.MAN_GBN_CD end JK_CD, 										")
				     .append("						        				case when a.MAN_GBN_CD = '30' then a.MAN_GBN_CD end BJ_CD,										")
				     .append("						        				case when a.MAN_GBN_CD = '40' then a.MAN_GBN_CD end YK_CD, 										")
				     .append("						        				case when a.MAN_GBN_CD = '50' then a.MAN_GBN_CD end YB_CD 										")
				     .append("										FROM    (																								")
				     .append("						         				SELECT		SUM(a.CURR_CNT) AS CURR_CNT_SUM,													")
				     .append("															SUM(a.FULL_CNT) AS FULL_CNT_SUM,													")
				     .append("															a.EIS_YEAR,																			")
				     .append("															a.MAN_GBN_CD                                                        				")
				     .append("						         				FROM		TE_MANCNT a																			")
				     .append("						         				WHERE		a.EIS_YEAR <= ?																		")
				     .append("						         				AND			TO_CHAR(TO_NUMBER(SUBSTR(?,0,4)) - 1) || SUBSTR(?,5,2) < a.EIS_YEAR					")
				     .append("						         				AND			SUBSTR(a.eis_year,5,2) in ('03','06','09','12')                      				")
				     .append("						         				GROUP BY	a.EIS_YEAR,a.MAN_GBN_CD																")
				     .append("						         				ORDER BY	a.EIS_YEAR,a.MAN_GBN_CD																")
				     .append("						         				) a																								")
				     .append("										) a																										")
				     .append("                          GROUP BY	a.EIS_YEAR																								")
				     .append("                          ORDER BY	a.EIS_YEAR        																						")
				     .append("                          ) a																													")
				     .append("                  ) a          																												")
				     .append("          ) a																																	");


				//System.out.println(sbSQL);
				System.out.println("yearMn="+yearMn);

				Object[] pmSQL =  {yearMn,yearMn,yearMn};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisTeManCnt : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 경영현황 > 인원현황 : 재작성
		 */
		public void getEisManCnt(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String yearMn  	= request.getParameter("yearMn");
				//System.out.println("yearMn="+yearMn);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append("  SELECT                                                    ");
				sbSQL.append("             a.MAN_GBN_CD                          DIV_CD,  ");
				sbSQL.append("             f_getCodeNm('E10',a.MAN_GBN_CD)       DIV_NM,  ");
				sbSQL.append("             SUM(a.FULL_CNT)                    AS JUNG_CNT,");
				sbSQL.append("             SUM(a.CURR_CNT)                    AS CURR_CNT,");
				sbSQL.append("             SUM(a.FULL_CNT) - SUM(a.CURR_CNT)  AS ADD_CNT  ");
				sbSQL.append("  FROM       TE_MANCNT a                                    ");
				sbSQL.append("  WHERE      a.EIS_YEAR = ?                                 ");
				sbSQL.append("  AND        a.DEPT_CD  = '00'                              ");
				sbSQL.append("  GROUP BY   a.EIS_YEAR,a.MAN_GBN_CD                        ");
				sbSQL.append("  ORDER BY   a.EIS_YEAR,a.MAN_GBN_CD                        ");


				System.out.println(sbSQL);
				//System.out.println("yearMn="+yearMn);

				Object[] pmSQL =  {yearMn};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisBizSalesStatus : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 경영현황 > 인원직급별 현황 : 재작성
		 */
		public void getEisDivManCnt(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String yearMn  	= request.getParameter("yearMn");
				//System.out.println("yearMn="+yearMn);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append(" SELECT  a.eis_year    ym,                                                          ");
				sbSQL.append("         sum(case when a.man_gbn_cd in ('10','20') then curr_cnt end)   jung_cnt,   ");
				sbSQL.append("         sum(case when a.man_gbn_cd in ('30')      then curr_cnt end)   byul_cnt,   ");
				sbSQL.append("         sum(case when a.man_gbn_cd in ('40')      then curr_cnt end)   tech_cnt,   ");
				sbSQL.append("         sum(case when a.man_gbn_cd in ('50')      then curr_cnt end)   supp_cnt    ");
				sbSQL.append(" FROM    TE_MANCNT a                                                                ");
				sbSQL.append(" WHERE   a.eis_year <= ?                                                            ");
				sbSQL.append(" AND     a.eis_year >  ltrim(to_char(to_number(?) - 100))                           ");
				sbSQL.append(" AND     substr(a.eis_year,5,2) in ('03','06','09','12')                            ");
				sbSQL.append(" AND     a.dept_cd   = '00'                                                         ");
				sbSQL.append(" GROUP BY a.eis_year                                                                ");

				//System.out.println(sbSQL);
				//System.out.println("yearMn="+yearMn);

				Object[] pmSQL =  {yearMn,yearMn};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisBizSalesStatus : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/**
		 *   경영정보 > 경영현황 > 손
		 */
		public void getEisSonYik(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String yearMn  	= request.getParameter("yearMn");
				//System.out.println("yearMn="+yearMn);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;

				StringBuffer sbSQL =  new StringBuffer();
				 sbSQL.append(" SELECT div_cd, div_nm, plan_amt, actual_amt, forecast_amt                                 ");
				 sbSQL.append(" FROM   (                                                                                        ");
				 sbSQL.append("     	SELECT '1' div_cd, '매출액'   div_nm, SUM(NVL(SALES_PLAN_SVC,0) + NVL(SALES_PLAN_CONST,0))   AS PLAN_AMT, ");
				 sbSQL.append("     	                              		  SUM(NVL(SALES_ACTUAL_SVC,0) + NVL(SALES_ACTUAL_CONST,0)) AS ACTUAL_AMT, ");
				 sbSQL.append("     	                              		  SUM(NVL(SALES_FORECAST_SVC,0) + NVL(SALES_FORECAST_CONST,0)) AS FORECAST_AMT ");
				 sbSQL.append("         FROM TE_DEPTBIZ WHERE YM = ?        UNION 			                                                  ");
				 sbSQL.append("     	SELECT '2' div_cd, '영업비용' div_nm, SUM(SALES_COST_PLAN  )                     AS AMT,               ");
				 sbSQL.append("     										  SUM(SALES_COST_ACTUAL)                     AS AMT,               ");
				 sbSQL.append("     										  SUM(SALES_COST_FORECAST)                     AS AMT               ");
				 sbSQL.append("         FROM TE_DEPTBIZ WHERE YM = ?        UNION                                                             ");
				 sbSQL.append("     	SELECT '3' div_cd, '영업이익' div_nm, SUM(NVL(SALES_PLAN_SVC,0) + NVL(SALES_PLAN_CONST,0)) - SUM(SALES_COST_PLAN)  AS AMT, ");
				 sbSQL.append("     									      SUM(NVL(SALES_ACTUAL_SVC,0) + NVL(SALES_ACTUAL_CONST,0)) - SUM(SALES_COST_ACTUAL)  AS AMT, ");
				 sbSQL.append("     									      SUM(NVL(SALES_FORECAST_SVC,0) + NVL(SALES_FORECAST_CONST,0)) - SUM(SALES_COST_FORECAST)  AS AMT ");
				 sbSQL.append("         FROM TE_DEPTBIZ WHERE YM = ?                                                                          ");
				 sbSQL.append(" )                                                                                                             ");
				 sbSQL.append(" ORDER BY div_cd                                                                                               ");


				//System.out.println(sbSQL);
				//System.out.println("yearMn="+yearMn);

				Object[] pmSQL =  {yearMn,yearMn,yearMn};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisSonYik : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 경영현황 > 영업현황
		 */
		public void getEisBizSalesStatus(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String yearMn  	= request.getParameter("yearMn");
				//System.out.println("yearMn="+yearMn);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append(" SELECT     	TRIM(TO_CHAR(SUM(a.SALES_PLAN),'999,999,999,999')) AS SALES_PLAN,						")
		     	 	 .append("            	TRIM(SUM(a.SALES_PLAN)) AS SALES_PLAN_G,												")
		     	 	 .append("            	TRIM(TO_CHAR(SUM(a.SALES_ACTUAL),'999,999,999,999')) AS SALES_ACTUAL,					")
		     	 	 .append("            	TRIM(SUM(a.SALES_ACTUAL)) AS SALES_ACTUAL_G,											")
		     	 	 .append("           	TRIM(TO_CHAR(SUM(a.SALES_FORECAST),'999,999,999,999')) AS SALES_FORECAST,				")
		     	 	 .append("           	TRIM(SUM(a.SALES_FORECAST)) AS SALES_FORECAST_G,										")
		     	 	 .append("           	TRIM(TO_CHAR(SUM(a.SALES_COST_PLAN),'999,999,999,999')) AS SALES_COST_PLAN,				")
		     	 	 .append("           	TRIM(TO_CHAR(SUM(a.SALES_COST_ACTUAL),'999,999,999,999')) AS SALES_COST_ACTUAL,			")
		     	 	 .append("           	TRIM(TO_CHAR(SUM(a.SALES_COST_FORECAST),'999,999,999,999')) AS SALES_COST_FORECAST,		")
		     	 	 .append("            	TRIM(TO_CHAR(SUM(a.SALES_PROFIT_PLAN),'999,999,999,999')) AS SALES_PROFIT_PLAN,			")
		     	 	 .append("            	TRIM(TO_CHAR(SUM(a.SALES_PROFIT_ACTUAL),'999,999,999,999')) AS SALES_PROFIT_ACTUAL,		")
		     	 	 .append("            	TRIM(TO_CHAR(SUM(a.SALES_PROFIT_FORECAST),'999,999,999,999')) AS SALES_PROFIT_FORECAST,	")
		     	 	 .append("            	SUBSTR(b.YM,0,4) || '-' || SUBSTR(b.YM,5,2) AS YM										")
			     	 .append(" FROM       	(   																					")
			     	 .append("             	SELECT	YM,																				")
			     	 .append("                      DEPT_CD,																		")
			     	 .append("                      (NVL(SALES_PLAN_SVC,0) + NVL(SALES_PLAN_CONST,0)) AS SALES_PLAN,				")
			     	 .append("                      (NVL(SALES_ACTUAL_SVC,0) + NVL(SALES_ACTUAL_CONST,0)) AS SALES_ACTUAL,			")
			     	 .append("                      (NVL(SALES_FORECAST_SVC,0) + NVL(SALES_FORECAST_CONST,0)) AS SALES_FORECAST,	")
 			     	 .append("                      NVL(SALES_COST_PLAN,0) AS SALES_COST_PLAN,										")
			     	 .append("                      NVL(SALES_COST_ACTUAL,0) AS SALES_COST_ACTUAL,									")
			     	 .append("                      NVL(SALES_COST_FORECAST,0) AS SALES_COST_FORECAST,								")
			     	 .append("                      NVL(SALES_PROFIT_PLAN,0) AS SALES_PROFIT_PLAN,									")
			     	 .append("                      NVL(SALES_PROFIT_ACTUAL,0) AS SALES_PROFIT_ACTUAL,								")
			     	 .append("                      NVL(SALES_PROFIT_FORECAST,0) AS SALES_PROFIT_FORECAST							")
			     	 .append("             	FROM    TE_DEPTBIZ																		")
			     	 .append("				) a,																					")
			     	 .append("				(																						")
					 .append("				SELECT  	YM																			")
					 .append("				FROM    	TZ_CALENDAR																	")
					 .append("				WHERE   	MM IN('03','06','09','12')													")
					 .append("				AND     	TO_CHAR(TO_NUMBER(SUBSTR(?,0,4)) - 4) || '12' < YM							")
					 .append("				AND     	YM <= SUBSTR(?,0,4) || '12'													")
					 .append("				ORDER BY	YM																			")
					 .append("				) b																						")
					 .append(" WHERE       	a.YM(+) = b.YM																			")
					 .append(" AND       	b.YM > TO_NUMBER(SUBSTR(?,0,4)) - 4														")
					 .append(" GROUP BY    	b.YM   																					")
					 .append(" ORDER BY    	b.YM  																					");

				//System.out.println(sbSQL);
				//System.out.println("yearMn="+yearMn);

				Object[] pmSQL =  {yearMn,yearMn,yearMn};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisBizSalesStatus : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 경영현황 > 영업현황
		 */
		public void getEisBizSalesDeptStatus(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String yearMn  	= request.getParameter("yearMn");
				//System.out.println("yearMn="+yearMn);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append(" SELECT     	SUBSTR(b.YM,0,4) || '-' || SUBSTR(b.YM,5,2) AS YM,										")
				     .append(" 				b.SDIV_CD as DEPT_CD,																	")
				     .append("            	b.DIV_NM,																				")
				     .append("            	TO_CHAR(a.SALES_PLAN,'999,999,999,999') AS SALES_PLAN,									")
				     .append("            	a.SALES_PLAN AS SALES_PLAN_G,															")
					 .append("            	TO_CHAR(a.SALES_ACTUAL,'999,999,999,999') AS SALES_ACTUAL,								")
					 .append("            	a.SALES_ACTUAL AS SALES_ACTUAL_G,														")
					 .append("            	TO_CHAR(a.SALES_FORECAST,'999,999,999,999') AS SALES_FORECAST,							")
					 .append("            	a.CONTRACT_AMT AS CONTRACT_AMT,				                                 			")
					 .append("            	a.SALES_FORECAST AS SALES_FORECAST_G,													")
				     .append("            	a.SALES_COST_PLAN,																		")
				     .append("            	a.SALES_COST_ACTUAL,																	")
				     .append("            	a.SALES_COST_FORECAST,																	")
				     .append("            	a.SALES_PROFIT_PLAN,																	")
				     .append("            	a.SALES_PROFIT_ACTUAL,																	")
				     .append("            	a.SALES_PROFIT_FORECAST																	")
				     .append(" FROM       	( 																						")
				     .append("             	SELECT	YM,																				")
				     .append("                      DEPT_CD,																		")
				     .append("                      (NVL(SALES_PLAN_SVC,0) + NVL(SALES_PLAN_CONST,0)) AS SALES_PLAN,				")
				     .append("                      (NVL(SALES_ACTUAL_SVC,0) + NVL(SALES_ACTUAL_CONST,0)) AS SALES_ACTUAL,			")
	 			     .append("                      (NVL(SALES_FORECAST_SVC,0) + NVL(SALES_FORECAST_CONST,0)) AS SALES_FORECAST,	")
				     .append("                      NVL(SALES_COST_PLAN,0) AS SALES_COST_PLAN,										")
				     .append("                      NVL(SALES_COST_ACTUAL,0) AS SALES_COST_ACTUAL,									")
				     .append("                      NVL(SALES_COST_FORECAST,0) AS SALES_COST_FORECAST,								")
				     .append("                      NVL(SALES_PROFIT_PLAN,0) AS SALES_PROFIT_PLAN,									")
				     .append("                      NVL(SALES_PROFIT_ACTUAL,0) AS SALES_PROFIT_ACTUAL,								")
				     .append("                      NVL(SALES_PROFIT_FORECAST,0) AS SALES_PROFIT_FORECAST,							")
				     .append("                      NVL(CONTRACT_AMT,0) AS CONTRACT_AMT                   							")
				     .append("				FROM    TE_DEPTBIZ																		")
	 			     .append("           	) a,																					")
	 			     .append("            	(																						")
	 			     .append("            	SELECT	a.YM,																			")
				     .append("                      b.SDIV_CD,																		")
				     .append("                      b.DIV_NM																		")
				     .append("             	FROM    (																				")
	 			     .append("                      SELECT		YM																	")
	 			     .append("                      FROM    	TZ_CALENDAR															")
	 			     .append("                      WHERE   	MM IN('03','06','09','12')											")
	 			     .append("                      AND     	TO_CHAR(TO_NUMBER(SUBSTR(?,0,4)) - 1) || '12' < YM					")
	 			     .append("                      AND     	YM <= SUBSTR(?,0,4) || '12'											")
	 			     .append("                      ORDER BY   	YM																	")
	 			     .append("                      ) a,																			")
	 			     .append("                      (																				")
	 			     .append("                      SELECT      DEPT_CD as SDIV_CD,															")
	 			     .append("                                  DEPT_NM as DIV_NM																")
	 			     .append("                      FROM        TE_DEPT															")
	 			     .append("                      WHERE       YEAR=?														")
	  			     .append("                      ) b																				")
	  			     .append("           	) b																						")
				     .append(" WHERE       	a.YM(+) = b.YM 																			")
				     .append(" AND         	a.DEPT_CD(+) = b.SDIV_CD   																")
				     .append(" ORDER BY    	b.YM, DEPT_CD 																					");

				//System.out.println(sbSQL);
				//System.out.println("yearMn="+yearMn);

				Object[] pmSQL =  {yearMn,yearMn,yearMn.substring(0, 4)};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisBizSalesDeptStatus : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}


		/*
		 *   경영정보 > 경영현황 > 사업개발(영업, 수주)
		 */
		public void getEisBizContDept(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String ym  	= request.getParameter("yearMn");
				//System.out.println("yearMn="+yearMn);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append(" select 																						");
				sbSQL.append(" 		   a.ym,                                                                                ");
				sbSQL.append(" 		   a.dept_cd,                                                                           ");
				sbSQL.append("   	   f_getEisDeptNm(a.ym,a.dept_cd) dept_nm,                                              ");
				sbSQL.append("         to_char(sum(a.cont_plan     )                    ,'999,999,999')   cont_plan     ,   ");
				sbSQL.append("         to_char(sum(a.cont_actual   )                    ,'999,999,999')   cont_actual   ,   ");
				sbSQL.append("         to_char(sum(a.cont_forecast )                    ,'999,999,999')   cont_forecast ,   ");
				sbSQL.append("         to_char(sum(a.cont_actual ) - sum(a.cont_plan)   ,'999,999,999')   cont_chai ,       ");
				sbSQL.append("         to_char(sum(a.sales_plan    )                    ,'999,999,999')   sales_plan    ,   ");
				sbSQL.append("         to_char(sum(a.sales_actual  )                    ,'999,999,999')   sales_actual  ,   ");
				sbSQL.append("         to_char(sum(a.sales_forecast)                    ,'999,999,999')   sales_forecast,   ");
				sbSQL.append("         to_char(sum(a.contract_amt  )                    ,'999,999,999')   contract_amt  ,   ");
				sbSQL.append("         to_char(sum(b.cont_plan     )                    ,'999,999,999')   y_cont_plan     , ");
				sbSQL.append("         to_char(sum(b.cont_actual   )                    ,'999,999,999')   y_cont_actual   , ");
				sbSQL.append("         to_char(sum(b.cont_forecast )                    ,'999,999,999')   y_cont_forecast , ");
				sbSQL.append("         to_char(sum(b.cont_forecast ) - sum(b.cont_plan ),'999,999,999')   y_cont_chai ,     ");
				sbSQL.append("         to_char(sum(b.sales_plan    )                    ,'999,999,999')   y_sales_plan    , ");
				sbSQL.append("         to_char(sum(b.sales_actual  )                    ,'999,999,999')   y_sales_actual  , ");
				sbSQL.append("         to_char(sum(b.sales_forecast)                    ,'999,999,999')   y_sales_forecast, ");
				sbSQL.append("         to_char(sum(b.contract_amt  )                    ,'999,999,999')   y_contract_amt    ");
				sbSQL.append(" from    (                                                                                    ");
				sbSQL.append(" 		select                                                                                  ");
				sbSQL.append(" 		  ym                     ,                                                              ");
				sbSQL.append(" 		  dept_cd                ,                                                              ");
				sbSQL.append(" 		  nvl(cont_plan_svc        ,0) + nvl(cont_plan_const      ,0)       cont_plan     ,     ");
				sbSQL.append(" 		  nvl(cont_actual_svc      ,0) + nvl(cont_actual_const    ,0)       cont_actual   ,     ");
				sbSQL.append(" 		  nvl(cont_forecast_svc    ,0) + nvl(cont_forecast_const  ,0)       cont_forecast ,     ");
				sbSQL.append(" 		  nvl(sales_plan_svc       ,0) + nvl(sales_plan_const     ,0)       sales_plan    ,     ");
				sbSQL.append(" 		  nvl(sales_actual_svc     ,0) + nvl(sales_actual_const   ,0) +                         ");
				sbSQL.append(" 		  nvl(sales_actual_etc     ,0)                                      sales_actual  ,     ");
				sbSQL.append(" 		  nvl(sales_forecast_svc   ,0) + nvl(sales_forecast_const ,0)       sales_forecast,     ");
				sbSQL.append(" 		  nvl(contract_amt         ,0)                                      contract_amt  ,     ");
				sbSQL.append(" 		  nvl(sales_cost_plan      ,0)                                      cost_plan     ,     ");
				sbSQL.append(" 		  nvl(sales_cost_actual    ,0)                                      cost_actual   ,     ");
				sbSQL.append(" 		  nvl(sales_cost_forecast  ,0)                                      cost_forecast       ");
				sbSQL.append(" 		from te_deptbiz                                                                         ");
				sbSQL.append(" 		where  ym like ?                                                                        ");
				sbSQL.append(" 		and    dept_cd <> '99'                                                                  ");
				sbSQL.append(" 		) a,                                                                                    ");
				sbSQL.append(" 		(                                                                                       ");
				sbSQL.append(" 		select                                                                                  ");
				sbSQL.append(" 		  ym                     ,                                                              ");
				sbSQL.append(" 		  dept_cd                ,                                                              ");
				sbSQL.append(" 		  nvl(cont_plan_svc        ,0) + nvl(cont_plan_const      ,0)       cont_plan     ,     ");
				sbSQL.append(" 		  nvl(cont_actual_svc      ,0) + nvl(cont_actual_const    ,0)       cont_actual   ,     ");
				sbSQL.append(" 		  nvl(cont_forecast_svc    ,0) + nvl(cont_forecast_const  ,0)       cont_forecast ,     ");
				sbSQL.append(" 		  nvl(sales_plan_svc       ,0) + nvl(sales_plan_const     ,0)       sales_plan    ,     ");
				sbSQL.append(" 		  nvl(sales_actual_svc     ,0) + nvl(sales_actual_const   ,0) +                         ");
				sbSQL.append(" 		  nvl(sales_actual_etc     ,0)                                      sales_actual  ,     ");
				sbSQL.append(" 		  nvl(sales_forecast_svc   ,0) + nvl(sales_forecast_const ,0)       sales_forecast,     ");
				sbSQL.append(" 		  nvl(contract_amt         ,0)                                      contract_amt  ,     ");
				sbSQL.append(" 		  nvl(sales_cost_plan      ,0)                                      cost_plan     ,     ");
				sbSQL.append(" 		  nvl(sales_cost_actual    ,0)                                      cost_actual   ,     ");
				sbSQL.append(" 		  nvl(sales_cost_forecast  ,0)                                      cost_forecast       ");
				sbSQL.append(" 		from te_deptbiz                                                                         ");
				sbSQL.append(" 		where  ym like substr(?,1,4)||'12'                                                      ");
				sbSQL.append(" 		) b                                                                                     ");
				sbSQL.append(" where  a.dept_cd = b.dept_cd (+)                                                             ");
				sbSQL.append(" group by a.ym, a.dept_cd                                                                     ");

				Object[] pmSQL =  {ym, ym};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisBizSalesDeptStatus : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}


		/*
		 *   경영정보 > 경영현황 > 사업개발현황
		 */
		public void getEisBizContractStatus(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String yearMn  	= request.getParameter("yearMn");
				//System.out.println("yearMn="+yearMn);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append(" SELECT      SUBSTR(b.YM,0,4) || '-' || SUBSTR(b.YM,5,2) AS YM,																									")
					 .append("             b.SDIV_CD as DEPT_CD,																																")
					 .append("             b.DIV_NM,																																			")
					 .append("             TO_CHAR(a.CONT_PLAN_SVC,'999,999,999,999') AS CONT_PLAN_SVC,																							")
					 .append("             TO_CHAR(a.CONT_ACTUAL_SVC,'999,999,999,999') AS CONT_ACTUAL_SVC,																						")
					 .append("             CASE WHEN a.CONT_PLAN_SVC IS NULL OR CONT_PLAN_SVC = ''  THEN ''																						")
					 .append("                  WHEN a.CONT_PLAN_SVC = '0' THEN '0%'																											")
					 .append("             ELSE      ROUND((a.CONT_ACTUAL_SVC / a.CONT_PLAN_SVC) * 1000,0) / 10 || '%'																			")
					 .append("             END AS CONT_SVC_PER_CALC,																															")
					 .append("             TO_CHAR(a.CONT_PLAN_CONST,'999,999,999,999') AS CONT_PLAN_CONST,																						")
					 .append("             TO_CHAR(a.CONT_ACTUAL_CONST,'999,999,999,999') AS CONT_ACTUAL_CONST,																					")
					 .append("             CASE WHEN a.CONT_PLAN_CONST IS NULL OR CONT_PLAN_CONST = ''  THEN ''																					")
					 .append("                  WHEN a.CONT_PLAN_CONST = '0' THEN '0%'																											")
					 .append("             ELSE      ROUND((a.CONT_ACTUAL_CONST / a.CONT_PLAN_CONST) * 1000,0) / 10 || '%'																		")
					 .append("             END AS CONT_CONST_PER_CALC,																															")
					 .append("             TO_CHAR(a.CONT_PLAN,'999,999,999,999') AS CONT_PLAN,																									")
					 .append("             a.CONT_PLAN AS CONT_PLAN_G,																									")
					 .append("             TO_CHAR(a.CONT_ACTUAL,'999,999,999,999') AS CONT_ACTUAL,																								")
					 .append("             a.CONT_ACTUAL AS CONT_ACTUAL_G,																								")
					 .append("             CASE WHEN a.CONT_PLAN IS NULL OR CONT_PLAN = ''  THEN ''																								")
					 .append("                  WHEN a.CONT_PLAN = '0' THEN '0%'																												")
					 .append("             ELSE      ROUND((a.CONT_ACTUAL / a.CONT_PLAN) * 1000,0) / 10 || '%'																					")
					 .append("             END AS CONT_PER_SUM_CALC,																															")
					 .append("             TO_CHAR(a.CONT_PLAN_SVC_SUM,'999,999,999,999') AS CONT_PLAN_SVC_SUM,																					")
					 .append("             TO_CHAR(a.CONT_ACTUAL_SVC_SUM,'999,999,999,999') AS CONT_ACTUAL_SVC_SUM,																				")
					 .append("             CASE WHEN a.CONT_PLAN_SVC_SUM IS NULL OR CONT_PLAN_SVC_SUM = ''  THEN ''																				")
					 .append("                  WHEN a.CONT_PLAN_SVC_SUM = '0' THEN '0%'																										")
					 .append("             ELSE      ROUND((a.CONT_ACTUAL_SVC_SUM / a.CONT_PLAN_SVC_SUM) * 1000,0) / 10 || '%'																	")
					 .append("             END AS CONT_SVC_SUM_CALC,																															")
					 .append("             a.CONT_PLAN_CONST_SUM,																																")
					 .append("             a.CONT_ACTUAL_CONST_SUM,																																")
					 .append("             CASE WHEN a.CONT_PLAN_CONST_SUM IS NULL OR CONT_PLAN_CONST_SUM = ''  THEN ''																			")
					 .append("                  WHEN a.CONT_PLAN_CONST_SUM = '0' THEN '0%'																										")
					 .append("             ELSE      ROUND((a.CONT_ACTUAL_CONST_SUM / a.CONT_PLAN_CONST_SUM) * 1000,0) / 10 || '%'																")
					 .append("             END AS CONT_CONST_SUM_CALC,																															")
					 .append("             TO_CHAR(a.CONT_PLAN_SUM,'999,999,999,999') AS CONT_PLAN_SUM,																							")
					 .append("             TO_CHAR(a.CONT_ACTUAL_SUM,'999,999,999,999') AS CONT_ACTUAL_SUM,																						")
					 .append("             CASE WHEN a.CONT_PLAN_SUM IS NULL OR CONT_PLAN_SUM = ''  THEN ''																						")
					 .append("                  WHEN a.CONT_PLAN_SUM = '0' THEN '0%'																											")
					 .append("             ELSE      ROUND((a.CONT_ACTUAL_SUM / a.CONT_PLAN_SUM) * 1000,0) / 10 || '%'																			")
					 .append("             END AS CONT_SUM_CALC,																																")
					 .append("             a.CONT_FORECAST_SVC,																																	")
					 .append("             a.CONT_FORECAST_CONST,                        																										")
					 .append("             a.CONT_FORECAST,                        																												")
					 .append("             a.CONT_FORECAST_SVC_SUM,																																")
					 .append("             a.CONT_FORECAST_CONST_SUM,																															")
					 .append("             a.CONT_FORECAST_SUM,																																	")
					 .append("             a.CONTRACT_AMT,																																		")
					 .append("             a.CONTRACT_AMT01,																																	")
					 .append("             a.CONTRACT_AMT02,																																	")
					 .append("             a.CONTRACT_AMT03,																																	")
					 .append("             a.CONTRACT_AMT04,																																	")
					 .append("             a.CONTRACT_AMT_SUM																																	")
					 .append(" FROM        (																																					")
					 .append("             SELECT      a.YM,																																	")
					 .append("                         a.DEPT_CD,																																")
					 .append("                         a.CONT_PLAN_SVC,																															")
					 .append("                         a.CONT_PLAN_CONST,																														")
					 .append("                         a.CONT_ACTUAL_CONST,																														")
					 .append("                         CASE WHEN (a.CONT_PLAN_SVC IS NULL OR a.CONT_PLAN_SVC = '') AND (a.CONT_PLAN_CONST IS NULL OR a.CONT_PLAN_CONST = '') THEN ''			")
					 .append("                         ELSE      TO_CHAR(a.CONT_PLAN)																											")
					 .append("                         END AS CONT_PLAN,																														")
					 .append("                         b.CONT_PLAN_SVC_SUM,																														")
					 .append("                         b.CONT_PLAN_CONST_SUM,																													")
					 .append("                         b.CONT_PLAN_SUM,																															")
					 .append("                         a.CONT_ACTUAL_SVC,																														")
					 .append("                         CASE WHEN (a.CONT_ACTUAL_SVC IS NULL OR a.CONT_ACTUAL_SVC = '') AND (a.CONT_ACTUAL_CONST IS NULL OR a.CONT_ACTUAL_CONST = '') THEN ''	")
					 .append("                         ELSE      TO_CHAR(a.CONT_ACTUAL)																											")
					 .append("                         END AS CONT_ACTUAL,																														")
					 .append("                         a.CONT_FORECAST_SVC,																														")
					 .append("                         a.CONT_FORECAST_CONST,                        																							")
					 .append("                         CASE WHEN (a.CONT_FORECAST_SVC IS NULL OR a.CONT_FORECAST_SVC = '') AND (a.CONT_FORECAST_CONST IS NULL OR a.CONT_FORECAST_CONST = '') THEN ''	")
					 .append("                         ELSE      TO_CHAR(a.CONT_FORECAST)																										")
					 .append("                         END AS CONT_FORECAST,																													")
					 .append("                         b.CONT_ACTUAL_SVC_SUM,																													")
					 .append("                         b.CONT_ACTUAL_CONST_SUM,																													")
					 .append("                         b.CONT_ACTUAL_SUM,																														")
					 .append("                         b.CONT_FORECAST_SVC_SUM,																													")
					 .append("                         b.CONT_FORECAST_CONST_SUM,																												")
					 .append("                         b.CONT_FORECAST_SUM,																														")
					 .append("                         c.CONTRACT_AMT,																															")
					 .append("                         c.CONTRACT_AMT01,																														")
					 .append("                         c.CONTRACT_AMT02,																														")
					 .append("                         c.CONTRACT_AMT03,																														")
					 .append("                         c.CONTRACT_AMT04,																														")
					 .append("                         c.CONTRACT_AMT_SUM																														")
					 .append("             FROM        (																																		")
					 .append("                         SELECT      YM,																															")
					 .append("                                     DEPT_CD,																														")
					 .append("                                     CONT_PLAN_SVC,																												")
					 .append("                                     CONT_PLAN_CONST,																												")
					 .append("                                     NVL(CONT_PLAN_SVC,0) + NVL(CONT_PLAN_CONST,0) AS CONT_PLAN,																	")
					 .append("                                     CONT_ACTUAL_SVC,																												")
					 .append("                                     CONT_ACTUAL_CONST,																											")
					 .append("                                     NVL(CONT_ACTUAL_SVC,0) + NVL(CONT_ACTUAL_CONST,0) AS CONT_ACTUAL,															")
					 .append("                                     CONT_FORECAST_SVC,																											")
					 .append("                                     CONT_FORECAST_CONST,																											")
					 .append("                                     NVL(CONT_FORECAST_SVC,0) + NVL(CONT_FORECAST_CONST,0) AS CONT_FORECAST														")
					 .append("                         FROM        TE_DEPTBIZ																													")
					 .append("                         ) a,																																		")
					 .append("                         (																																		")
					 .append("                         SELECT      SUM(CONT_PLAN_SVC) AS CONT_PLAN_SVC_SUM,																						")
					 .append("                                     SUM(CONT_PLAN_CONST) AS CONT_PLAN_CONST_SUM,																					")
					 .append("                                     SUM(CONT_PLAN) AS CONT_PLAN_SUM,																								")
					 .append("                                     SUM(CONT_ACTUAL_SVC) AS CONT_ACTUAL_SVC_SUM,																					")
					 .append("                                     SUM(CONT_ACTUAL_CONST) AS CONT_ACTUAL_CONST_SUM,																				")
					 .append("                                     SUM(CONT_ACTUAL) AS CONT_ACTUAL_SUM,																							")
					 .append("                                     SUM(CONT_FORECAST_SVC) AS CONT_FORECAST_SVC_SUM,																				")
					 .append("                                     SUM(CONT_FORECAST_CONST) AS CONT_FORECAST_CONST_SUM,																			")
					 .append("                                     SUM(CONT_FORECAST) AS CONT_FORECAST_SUM,																						")
					 .append("                                     YM																															")
					 .append("                         FROM        (																															")
					 .append("                                     SELECT      YM,																												")
					 .append("                                                 CONT_PLAN_SVC,																									")
					 .append("                                                 CONT_PLAN_CONST,																									")
					 .append("                                                 NVL(CONT_PLAN_SVC,0) + NVL(CONT_PLAN_CONST,0) AS CONT_PLAN,														")
					 .append("                                                 CONT_ACTUAL_SVC,																									")
					 .append("                                                 CONT_ACTUAL_CONST,																								")
					 .append("                                                 NVL(CONT_ACTUAL_SVC,0) + NVL(CONT_ACTUAL_CONST,0) AS CONT_ACTUAL,												")
					 .append("                                                 CONT_FORECAST_SVC,																								")
					 .append("                                                 CONT_FORECAST_CONST,																								")
					 .append("                                                 NVL(CONT_FORECAST_SVC,0) + NVL(CONT_FORECAST_CONST,0) AS CONT_FORECAST											")
					 .append("                                     FROM        TE_DEPTBIZ																										")
					 .append("                                     )																															")
					 .append("                         GROUP BY    YM																															")
					 .append("                         ) b,																																		")
					 .append("                         (																																		")
					 .append("                         SELECT      a.YM,																														")
					 .append("                                     a.DEPT_CD,																													")
					 .append("                                     a.CONTRACT_AMT,																												")
					 .append("                                     b.CONTRACT_AMT01,																											")
					 .append("                                     b.CONTRACT_AMT02,																											")
					 .append("                                     b.CONTRACT_AMT03,																											")
					 .append("                                     b.CONTRACT_AMT04,																											")
					 .append("                                     NVL(b.CONTRACT_AMT01,0) + NVL(b.CONTRACT_AMT02,0) + NVL(b.CONTRACT_AMT03,0) + NVL(b.CONTRACT_AMT04,0) AS CONTRACT_AMT_SUM	")
					 .append("                         FROM        (																															")
					 .append("                                     SELECT      YM,																												")
					 .append("                                                 DEPT_CD,																											")
					 .append("                                                 CONTRACT_AMT																										")
					 .append("                                     FROM        TE_DEPTBIZ																										")
					 .append("                                     ) a,																															")
					 .append("                                     (																															")
					 .append("                                     SELECT      YM,																												")
					 .append("                                                 SUM(CONTRACT_AMT01) AS CONTRACT_AMT01,																			")
					 .append("                                                 SUM(CONTRACT_AMT02) AS CONTRACT_AMT02,																			")
					 .append("                                                 SUM(CONTRACT_AMT03) AS CONTRACT_AMT03,																			")
					 .append("                                                 SUM(CONTRACT_AMT04) AS CONTRACT_AMT04																			")
					 .append("                                     FROM        (																												")
					 .append("                                                 SELECT      YM,																									")
					 .append("                                                             CASE WHEN DEPT_CD = '01' THEN CONTRACT_AMT END AS CONTRACT_AMT01,									")
					 .append("                                                             CASE WHEN DEPT_CD = '02' THEN CONTRACT_AMT END AS CONTRACT_AMT02,									")
					 .append("                                                             CASE WHEN DEPT_CD = '03' THEN CONTRACT_AMT END AS CONTRACT_AMT03,									")
					 .append("                                                             CASE WHEN DEPT_CD = '04' THEN CONTRACT_AMT END AS CONTRACT_AMT04										")
					 .append("                                                 FROM        (																									")
					 .append("                                                             SELECT      YM,																						")
					 .append("                                                                         DEPT_CD,																					")
					 .append("                                                                         CONTRACT_AMT																				")
					 .append("                                                             FROM        TE_DEPTBIZ																				")
					 .append("                                                             )																									")
					 .append("                                                 )																												")
					 .append("                                     GROUP BY    YM																												")
					 .append("                                     ) b																															")
					 .append("                         WHERE       a.YM = b.YM																													")
					 .append("                         ) c																																		")
					 .append("             WHERE       a.YM = b.YM(+)																															")
					 .append("             AND         a.YM = c.YM																																")
					 .append("             AND         a.DEPT_CD = c.DEPT_CD																													")
					 .append("             ) a,																																					")
					 .append("             (																																					")
					 .append("             SELECT     a.YM,																																		")
					 .append("                        b.SDIV_CD,																																")
					 .append("                        b.DIV_NM																																	")
					 .append("             FROM       (																																			")
					 .append("                         SELECT     YM																															")
					 .append("                         FROM       TZ_CALENDAR																													")
					 .append("                         WHERE      MM IN('03','06','09','12')																									")
					 .append("                         AND        TO_CHAR(TO_NUMBER(SUBSTR(?,0,4)) - 5) || '12' < YM																			")
					 .append("                         AND        YM <= SUBSTR(?,0,4) || '12'																									")
					 .append("                         ORDER BY   YM																															")
					 .append("                        ) a,																																		")
					 .append("                        (																																			")
					 .append("                        SELECT      DEPT_CD as SDIV_CD,																														")
					 .append("                                    DEPT_NM as DIV_NM																														")
					 .append("                        FROM        TE_DEPT	 																													")
					 .append("                        WHERE       YEAR = ?																												")
					 .append("                        ) b																																		")
					 .append("             ) b																																					")
					 .append(" WHERE       a.YM(+) = b.YM																																		")
					 .append(" AND         a.DEPT_CD(+) = b.SDIV_CD																																")
					 .append(" ORDER BY    b.YM, DEPT_CD																																			");

				//System.out.println(sbSQL);
				//System.out.println("yearMn="+yearMn+"/"+yearMn.substring(0, 4));

				Object[] pmSQL =  {yearMn,yearMn,yearMn.substring(0, 4)};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisBizContractStatus : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 경영현황 > 사업개발현황
		 */
		public void getEisOutEvalStatusG(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String year  	= request.getParameter("year");
				//System.out.println("year="+year);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append(" SELECT    a.PADEP,																			")
					 .append("           a.ORG_CD,																			")
					 .append("           b.DIV_NM,																			")
					 .append("           a.EMP_BONUS1,																		")
					 .append("           a.EMP_BONUS2,																		")
					 .append("           a.EMP_BONUS3,																		")
					 .append("           a.EMP_BONUS4,																		")
					 .append("           a.EMP_BONUS5,																		")
					 .append("           a.EMP_BONUS6,																		")
					 .append("           a.EMP_BONUS7,																		")
					 .append("           a.EMP_BONUS8																		")
					 .append(" FROM      (          																		")
					 .append("           SELECT    SUM(EMP_BONUS1) AS EMP_BONUS1,											")
					 .append("                     SUM(EMP_BONUS2) AS EMP_BONUS2,											")
					 .append("                     SUM(EMP_BONUS3) AS EMP_BONUS3,											")
					 .append("                     SUM(EMP_BONUS4) AS EMP_BONUS4,											")
					 .append("                     SUM(EMP_BONUS5) AS EMP_BONUS5,											")
					 .append("                     SUM(EMP_BONUS6) AS EMP_BONUS6,											")
					 .append("                     SUM(EMP_BONUS7) AS EMP_BONUS7,											")
					 .append("                     SUM(EMP_BONUS8) AS EMP_BONUS8,											")
					 .append("                     ORG_CD,																	")
					 .append("                     '장려금지급률' AS PADEP	,													")
					 .append("                     '01' AS PADEP_NUM													")
					 .append("           FROM      (																		")
					 .append("                     SELECT    ORG_CD,														")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 7 THEN EMP_BONUS END AS EMP_BONUS1,	")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 6 THEN EMP_BONUS END AS EMP_BONUS2,	")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 5 THEN EMP_BONUS END AS EMP_BONUS3,	")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 4 THEN EMP_BONUS END AS EMP_BONUS4,	")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 3 THEN EMP_BONUS END AS EMP_BONUS5,	")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 2 THEN EMP_BONUS END AS EMP_BONUS6,	")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 1 THEN EMP_BONUS END AS EMP_BONUS7,	")
					 .append("                               CASE WHEN EVAL_YEAR = ? THEN EMP_BONUS END AS EMP_BONUS8		")
					 .append("                     FROM      (																")
					 .append("                               SELECT    EVAL_YEAR,											")
					 .append("                                         ORG_CD,												")
					 .append("                                         EMP_BONUS,											")
					 .append("                                         CHIEF_BONUS,											")
					 .append("                                         EVAL_RANK											")
					 .append("                               FROM      TG_EVALORG											")
					 .append("                               WHERE     EVAL_YEAR > ? - 8									")
					 .append("                               ) a															")
					 .append("                     ORDER BY  EVAL_YEAR,ORG_CD												")
					 .append("                     )																		")
					 .append("           GROUP BY  ORG_CD																	")
					 .append("           UNION ALL																			")
					 .append("           SELECT    SUM(EMP_BONUS1) AS EMP_BONUS1,											")
					 .append("                     SUM(EMP_BONUS2) AS EMP_BONUS2,											")
					 .append("                     SUM(EMP_BONUS3) AS EMP_BONUS3,											")
					 .append("                     SUM(EMP_BONUS4) AS EMP_BONUS4,											")
					 .append("                     SUM(EMP_BONUS5) AS EMP_BONUS5,											")
					 .append("                     SUM(EMP_BONUS6) AS EMP_BONUS6,											")
					 .append("                     SUM(EMP_BONUS7) AS EMP_BONUS7,											")
					 .append("                     SUM(EMP_BONUS8) AS EMP_BONUS8,											")
					 .append("                     ORG_CD,																	")
					 .append("                    '사장성과지급률' AS PADEP,													")
					 .append("                    '02' AS PADEP_NUM													")
					 .append("           FROM      (																		")
					 .append("                     SELECT    ORG_CD,														")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 7 THEN CHIEF_BONUS END AS EMP_BONUS1,")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 6 THEN CHIEF_BONUS END AS EMP_BONUS2,")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 5 THEN CHIEF_BONUS END AS EMP_BONUS3,")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 4 THEN CHIEF_BONUS END AS EMP_BONUS4,")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 3 THEN CHIEF_BONUS END AS EMP_BONUS5,")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 2 THEN CHIEF_BONUS END AS EMP_BONUS6,")
					 .append("                               CASE WHEN EVAL_YEAR = ? - 1 THEN CHIEF_BONUS END AS EMP_BONUS7,")
					 .append("                               CASE WHEN EVAL_YEAR = ? THEN CHIEF_BONUS END AS EMP_BONUS8		")
					 .append("                     FROM      (																")
					 .append("                               SELECT    EVAL_YEAR,											")
					 .append("                                         ORG_CD,												")
					 .append("                                         EMP_BONUS,											")
					 .append("                                         CHIEF_BONUS,											")
					 .append("                                         EVAL_RANK											")
					 .append("                               FROM      TG_EVALORG											")
					 .append("                               WHERE     EVAL_YEAR > ? - 8									")
					 .append("                               ) a															")
					 .append("                     ORDER BY  EVAL_YEAR,ORG_CD												")
					 .append("                     )																		")
					 .append("           GROUP BY  ORG_CD																	")
					 .append("           ) a,																				")
					 .append("           (																					")
					 .append("           SELECT    SDIV_CD,																	")
					 .append("                     DIV_NM																	")
					 .append("           FROM      TZ_COMCODE																")
					 .append("           WHERE     LDIV_CD = 'G01'	AND USE_YN='Y'											")
					 .append("           ) b																				")
					 .append(" WHERE     a.ORG_CD = b.SDIV_CD																")
				 	 .append(" ORDER BY	 a.PADEP_NUM,a.ORG_CD																");

				//System.out.println(sbSQL);
				//System.out.println("year="+year);

				Object[] pmSQL =  {
									year,year,year,year,year,year,year,year,year,
									/*year,year,year,year,year,year,year,year,year,*/
									year,year,year,year,year,year,year,year,year
								  };
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisOutEvalStatusG : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 경영현황 > 사업개발현황
		 */
		public void getEisOutEvalStatusGP(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String year  	= request.getParameter("year");
				//System.out.println("year="+year);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();

			    /*sbSQL.append(" SELECT    EVAL_YEAR,                                                                 ")
				 	 .append("           SUM(EMP_BONUS_00) AS EMP_BONUS_00,                                         ")
				 	 .append("           SUM(EMP_BONUS_01) AS EMP_BONUS_01,                                         ")
				 	 .append("           SUM(EMP_BONUS_02) AS EMP_BONUS_02,                                         ")
				 	 .append("           SUM(EMP_BONUS_03) AS EMP_BONUS_03,                                         ")
				 	 .append("           SUM(EMP_BONUS_04) AS EMP_BONUS_04,                                         ")
				 	 .append("           SUM(EMP_BONUS_05) AS EMP_BONUS_05,                                         ")
				 	 .append("           SUM(EMP_BONUS_06) AS EMP_BONUS_06,                                         ")
				 	 .append("           SUM(EMP_BONUS_07) AS EMP_BONUS_07,                                         ")

				 	 .append("           SUM(CHIEF_BONUS_00) AS CHIEF_BONUS_00,                                     ")
				 	 .append("           SUM(CHIEF_BONUS_01) AS CHIEF_BONUS_01,                                     ")
				 	 .append("           SUM(CHIEF_BONUS_02) AS CHIEF_BONUS_02,                                     ")
				 	 .append("           SUM(CHIEF_BONUS_03) AS CHIEF_BONUS_03,                                     ")
				 	 .append("           SUM(CHIEF_BONUS_04) AS CHIEF_BONUS_04,                                     ")
				 	 .append("           SUM(CHIEF_BONUS_05) AS CHIEF_BONUS_05,                                     ")
				 	 .append("           SUM(CHIEF_BONUS_06) AS CHIEF_BONUS_06,                                     ")
				 	 .append("           SUM(CHIEF_BONUS_07) AS CHIEF_BONUS_07,                                     ")

				 	 .append("           SUM(EVAL_RANK_00) AS EVAL_RANK_00,                                         ")
				 	 .append("           SUM(EVAL_RANK_01) AS EVAL_RANK_01,                                         ")
				 	 .append("           SUM(EVAL_RANK_02) AS EVAL_RANK_02,                                         ")
				 	 .append("           SUM(EVAL_RANK_03) AS EVAL_RANK_03,                                         ")
				 	 .append("           SUM(EVAL_RANK_04) AS EVAL_RANK_04,                                         ")
				 	 .append("           SUM(EVAL_RANK_05) AS EVAL_RANK_05,                                         ")
				 	 .append("           SUM(EVAL_RANK_06) AS EVAL_RANK_06,                                          ")
				 	 .append("           SUM(EVAL_RANK_07) AS EVAL_RANK_07                                          ")

				 	 .append(" FROM      (                                                                          ")
				 	 .append("           SELECT    EVAL_YEAR,                                                       ")
				 	 .append("                     CASE WHEN ORG_CD = '00' THEN EMP_BONUS END AS EMP_BONUS_00,      ")
				 	 .append("                     CASE WHEN ORG_CD = '01' THEN EMP_BONUS END AS EMP_BONUS_01,      ")
				 	 .append("                     CASE WHEN ORG_CD = '02' THEN EMP_BONUS END AS EMP_BONUS_02,      ")
				 	 .append("                     CASE WHEN ORG_CD = '03' THEN EMP_BONUS END AS EMP_BONUS_03,      ")
				 	 .append("                     CASE WHEN ORG_CD = '04' THEN EMP_BONUS END AS EMP_BONUS_04,      ")
				 	 .append("                     CASE WHEN ORG_CD = '05' THEN EMP_BONUS END AS EMP_BONUS_05,      ")
				 	 .append("                     CASE WHEN ORG_CD = '06' THEN EMP_BONUS END AS EMP_BONUS_06,      ")
				 	 .append("                     CASE WHEN ORG_CD = '07' THEN EMP_BONUS END AS EMP_BONUS_07,      ")

				 	 .append("                     CASE WHEN ORG_CD = '00' THEN CHIEF_BONUS END AS CHIEF_BONUS_00,  ")
				 	 .append("                     CASE WHEN ORG_CD = '01' THEN CHIEF_BONUS END AS CHIEF_BONUS_01,  ")
				 	 .append("                     CASE WHEN ORG_CD = '02' THEN CHIEF_BONUS END AS CHIEF_BONUS_02,  ")
				 	 .append("                     CASE WHEN ORG_CD = '03' THEN CHIEF_BONUS END AS CHIEF_BONUS_03,  ")
				 	 .append("                     CASE WHEN ORG_CD = '04' THEN CHIEF_BONUS END AS CHIEF_BONUS_04,  ")
				 	 .append("                     CASE WHEN ORG_CD = '05' THEN CHIEF_BONUS END AS CHIEF_BONUS_05,  ")
				 	 .append("                     CASE WHEN ORG_CD = '06' THEN CHIEF_BONUS END AS CHIEF_BONUS_06,  ")
				 	 .append("                     CASE WHEN ORG_CD = '07' THEN CHIEF_BONUS END AS CHIEF_BONUS_07,  ")

				 	 .append("                     CASE WHEN ORG_CD = '00' THEN 8 - EVAL_RANK END AS EVAL_RANK_00,  ")
				 	 .append("                     CASE WHEN ORG_CD = '01' THEN 8 - EVAL_RANK END AS EVAL_RANK_01,	")
				 	 .append("                     CASE WHEN ORG_CD = '02' THEN 8 - EVAL_RANK END AS EVAL_RANK_02,  ")
				 	 .append("                     CASE WHEN ORG_CD = '03' THEN 8 - EVAL_RANK END AS EVAL_RANK_03,  ")
				 	 .append("                     CASE WHEN ORG_CD = '04' THEN 8 - EVAL_RANK END AS EVAL_RANK_04,  ")
				 	 .append("                     CASE WHEN ORG_CD = '05' THEN 8 - EVAL_RANK END AS EVAL_RANK_05,  ")
				 	 .append("                     CASE WHEN ORG_CD = '06' THEN 8 - EVAL_RANK END AS EVAL_RANK_06,  ")
				 	 .append("                     CASE WHEN ORG_CD = '07' THEN 8 - EVAL_RANK END AS EVAL_RANK_07   ")


				 	 .append("           FROM      (                                                                ")
				 	 .append("                     SELECT    *                                                      ")
				 	 .append("                     FROM      TG_EVALORG                                             ")
				 	 .append("                     ORDER BY  EVAL_YEAR,ORG_CD                                       ")
				 	 .append("                     )                                                                ")
				 	 .append("           )                                                                          ")
				 	 .append(" WHERE     EVAL_YEAR > ? - 8															")
				 	 .append(" AND		 EVAL_YEAR <= ?                                                             ")
				 	 .append(" GROUP BY  EVAL_YEAR                                                                  ")
				 	 .append(" ORDER BY  EVAL_YEAR                                                                  ");
			 	*/
				//System.out.println(sbSQL);
				//System.out.println("year="+year);

				sbSQL.append(" SELECT    EVAL_YEAR,                                                                  \n ")
				.append("            SUM(EMP_BONUS_00) AS EMP_BONUS_00,                                          \n ")
				.append("            SUM(EMP_BONUS_01) AS EMP_BONUS_01,                                          \n ")
				.append("            SUM(EMP_BONUS_02) AS EMP_BONUS_02,                                          \n ")
				.append("            SUM(EMP_BONUS_03) AS EMP_BONUS_03,                                          \n ")
				.append("            SUM(EMP_BONUS_07) AS EMP_BONUS_07,                                          \n ")
				.append("            SUM(EMP_BONUS_08) AS EMP_BONUS_08,                                          \n ")
				.append("            SUM(EMP_BONUS_09) AS EMP_BONUS_09,                                          \n ")
				.append("            SUM(EMP_BONUS_10) AS EMP_BONUS_10,                                          \n ")
				.append("            SUM(EMP_BONUS_11) AS EMP_BONUS_11, \n ")
				.append("            SUM(EMP_BONUS_12) AS EMP_BONUS_12,          \n ")
				.append("            SUM(CHIEF_BONUS_00) AS CHIEF_BONUS_00,                                      \n ")
				.append("            SUM(CHIEF_BONUS_01) AS CHIEF_BONUS_01,                                      \n ")
				.append("            SUM(CHIEF_BONUS_02) AS CHIEF_BONUS_02,                                      \n ")
				.append("            SUM(CHIEF_BONUS_03) AS CHIEF_BONUS_03,                                      \n ")
				.append("            SUM(CHIEF_BONUS_07) AS CHIEF_BONUS_07,                                      \n ")
				.append("            SUM(CHIEF_BONUS_08) AS CHIEF_BONUS_08,                                      \n ")
				.append("            SUM(CHIEF_BONUS_09) AS CHIEF_BONUS_09,                                      \n ")
				.append("            SUM(CHIEF_BONUS_10) AS CHIEF_BONUS_10,                                      \n ")
				.append("            SUM(CHIEF_BONUS_11) AS CHIEF_BONUS_11, \n ")
				.append("            SUM(CHIEF_BONUS_12) AS CHIEF_BONUS_12,     \n ")
				.append("            SUM(EVAL_RANK_00) AS EVAL_RANK_00,                                          \n ")
				.append("            SUM(EVAL_RANK_01) AS EVAL_RANK_01,                                          \n ")
				.append("            SUM(EVAL_RANK_02) AS EVAL_RANK_02,                                          \n ")
				.append("            SUM(EVAL_RANK_03) AS EVAL_RANK_03,                                          \n ")
				.append("            SUM(EVAL_RANK_07) AS EVAL_RANK_07,                                          \n ")
				.append("            SUM(EVAL_RANK_08) AS EVAL_RANK_08,                                          \n ")
				.append("            SUM(EVAL_RANK_09) AS EVAL_RANK_09, \n ")
				.append("            SUM(EVAL_RANK_10) AS EVAL_RANK_10, \n ")
				.append("            SUM(EVAL_RANK_11) AS EVAL_RANK_11,                                           \n ")
				.append("            SUM(EVAL_RANK_12) AS EVAL_RANK_12                                             \n ")
				.append("  FROM      (                                                                           \n ")
				.append("            SELECT    EVAL_YEAR,                                                        \n ")
				.append("                      CASE WHEN ORG_CD = '00' THEN EMP_BONUS END AS EMP_BONUS_00,       \n ")
				.append("                      CASE WHEN ORG_CD = '01' THEN EMP_BONUS END AS EMP_BONUS_01,       \n ")
				.append("                      CASE WHEN ORG_CD = '02' THEN EMP_BONUS END AS EMP_BONUS_02,       \n ")
				.append("                      CASE WHEN ORG_CD = '03' THEN EMP_BONUS END AS EMP_BONUS_03,       \n ")
				.append("                      CASE WHEN ORG_CD = '07' THEN EMP_BONUS END AS EMP_BONUS_07,       \n ")
				.append("                      CASE WHEN ORG_CD = '08' THEN EMP_BONUS END AS EMP_BONUS_08,       \n ")
				.append("                      CASE WHEN ORG_CD = '09' THEN EMP_BONUS END AS EMP_BONUS_09,       \n ")
				.append("                      CASE WHEN ORG_CD = '10' THEN EMP_BONUS END AS EMP_BONUS_10,       \n ")
				.append("                      CASE WHEN ORG_CD = '11' THEN EMP_BONUS END AS EMP_BONUS_11, \n ")
				.append("                      CASE WHEN ORG_CD = '12' THEN EMP_BONUS END AS EMP_BONUS_12, \n ")
				.append("                      CASE WHEN ORG_CD = '00' THEN CHIEF_BONUS END AS CHIEF_BONUS_00,   \n ")
				.append("                      CASE WHEN ORG_CD = '01' THEN CHIEF_BONUS END AS CHIEF_BONUS_01,   \n ")
				.append("                      CASE WHEN ORG_CD = '02' THEN CHIEF_BONUS END AS CHIEF_BONUS_02,   \n ")
				.append("                      CASE WHEN ORG_CD = '03' THEN CHIEF_BONUS END AS CHIEF_BONUS_03,   \n ")
				.append("                      CASE WHEN ORG_CD = '07' THEN CHIEF_BONUS END AS CHIEF_BONUS_07,   \n ")
				.append("                      CASE WHEN ORG_CD = '08' THEN CHIEF_BONUS END AS CHIEF_BONUS_08,   \n ")
				.append("                      CASE WHEN ORG_CD = '09' THEN CHIEF_BONUS END AS CHIEF_BONUS_09,   \n ")
				.append("                      CASE WHEN ORG_CD = '10' THEN CHIEF_BONUS END AS CHIEF_BONUS_10, \n ")
				.append("                      CASE WHEN ORG_CD = '11' THEN CHIEF_BONUS END AS CHIEF_BONUS_11, \n ")
				.append("                      CASE WHEN ORG_CD = '12' THEN CHIEF_BONUS END AS CHIEF_BONUS_12,   \n ")
				.append("                      CASE WHEN ORG_CD = '00' THEN 10 - EVAL_RANK END AS EVAL_RANK_00,   \n ")
				.append("                      CASE WHEN ORG_CD = '01' THEN 10 - EVAL_RANK END AS EVAL_RANK_01,     \n ")
				.append("                      CASE WHEN ORG_CD = '02' THEN 10 - EVAL_RANK END AS EVAL_RANK_02,   \n ")
				.append("                      CASE WHEN ORG_CD = '03' THEN 10 - EVAL_RANK END AS EVAL_RANK_03,   \n ")
				.append("                      CASE WHEN ORG_CD = '07' THEN 10 - EVAL_RANK END AS EVAL_RANK_07,   \n ")
				.append("                      CASE WHEN ORG_CD = '08' THEN 10 - EVAL_RANK END AS EVAL_RANK_08,   \n ")
				.append("                      CASE WHEN ORG_CD = '09' THEN 10 - EVAL_RANK END AS EVAL_RANK_09,   \n ")
				.append("                      CASE WHEN ORG_CD = '10' THEN 10 - EVAL_RANK END AS EVAL_RANK_10, \n ")
				.append("                      CASE WHEN ORG_CD = '11' THEN 10 - EVAL_RANK END AS EVAL_RANK_11, \n ")
				.append("                      CASE WHEN ORG_CD = '12' THEN 10 - EVAL_RANK END AS EVAL_RANK_12    \n ")
				.append("            FROM      (                                                                 \n ")
				.append("                      SELECT    *                                                       \n ")
				.append("                      FROM      TG_EVALORG                                              \n ")
				.append("                      ORDER BY  EVAL_YEAR,ORG_CD                                        \n ")
				.append("                      )                                                                 \n ")
				.append("            )                                                                           \n ")
				.append("  WHERE     EVAL_YEAR > ? - 6                                                             \n ")
				.append("  AND       EVAL_YEAR <= ?                                                              \n ")
				.append("  GROUP BY  EVAL_YEAR                                                                   \n ")
				.append("  ORDER BY  EVAL_YEAR \n ");



				Object[] pmSQL =  {year,year};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisOutEvalStatusGP : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 경영현황 > 사업개발현황
		 */
		public void getEisOutEvalMeas(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String year  	= request.getParameter("year");
				//System.out.println("year="+year);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();

		        sbSQL.append(" SELECT		a.MEAS_DIV_CD,															")
					 .append("				F_GETCODENM('G02', a.MEAS_DIV_CD) MEAS_DIV_NM,							")
					 .append("				a.MEAS_GRP_CD, 															")
					 .append("				F_GETCODENM('G03', a.MEAS_GRP_CD) MEAS_GRP_NM, 							")
					 .append("				a.MEAS_CD, 																")
					 .append("				F_GETCODENM('G04', a.MEAS_CD) MEAS_NM,									")
					 .append("				MAX(a.DISP_ORD) DISP_ORD ,                                      		")
					 .append("				MAX(a.WEIGHT)  WEIGHT,													")
					 .append("				MAX(CASE WHEN b.ORG_CD = '00' THEN b.EVAL_GRADE END)  EVAL_GRADE_00,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '00' THEN b.EVAL_SCORE END) GRADE_SCORE_00,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '01' THEN b.EVAL_GRADE END)  EVAL_GRADE_01,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '01' THEN b.EVAL_SCORE END) GRADE_SCORE_01,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '02' THEN b.EVAL_GRADE END)  EVAL_GRADE_02,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '02' THEN b.EVAL_SCORE END) GRADE_SCORE_02,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '03' THEN b.EVAL_GRADE END)  EVAL_GRADE_03,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '03' THEN b.EVAL_SCORE END) GRADE_SCORE_03,    ")
					 .append("				MAX(CASE WHEN b.ORG_CD = '07' THEN b.EVAL_GRADE END)  EVAL_GRADE_07,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '07' THEN b.EVAL_SCORE END) GRADE_SCORE_07,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '08' THEN b.EVAL_GRADE END)  EVAL_GRADE_08,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '08' THEN b.EVAL_SCORE END) GRADE_SCORE_08,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '09' THEN b.EVAL_GRADE END)  EVAL_GRADE_09,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '09' THEN b.EVAL_SCORE END) GRADE_SCORE_09,    ")
					 .append("				MAX(CASE WHEN b.ORG_CD = '10' THEN b.EVAL_GRADE END)  EVAL_GRADE_10,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '10' THEN b.EVAL_SCORE END) GRADE_SCORE_10,    ")
					 .append("				MAX(CASE WHEN b.ORG_CD = '11' THEN b.EVAL_GRADE END)  EVAL_GRADE_11,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '11' THEN b.EVAL_SCORE END) GRADE_SCORE_11,    ")
					 .append("				MAX(CASE WHEN b.ORG_CD = '12' THEN b.EVAL_GRADE END)  EVAL_GRADE_12,	")
					 .append("				MAX(CASE WHEN b.ORG_CD = '12' THEN b.EVAL_SCORE END) GRADE_SCORE_12     ")
					 .append(" FROM			(																		")
					 .append("				SELECT  EVAL_YEAR, 														")
					 .append("						MEAS_GRP_CD, 													")
					 .append("						MEAS_CD,														")
					 .append("						MEAS_DIV_CD, DISP_ORD,             							    ")
					 .append("						WEIGHT															")
					 .append("				FROM	TG_EVALORGMEAS													")
					 .append("				WHERE	EVAL_YEAR = ?													")
					 .append("				AND	    MEAS_DIV_CD = '0'			  								    ")
					 .append("				) a,																	")
					 .append("				TG_EVALORGMEAS B														")
					 .append(" WHERE		a.EVAL_YEAR   = b.EVAL_YEAR   (+)										")
					 .append(" AND			a.MEAS_GRP_CD = b.MEAS_GRP_CD (+)										")
					 .append(" AND			a.MEAS_CD     = b.MEAS_CD     (+)										")
					 .append(" GROUP BY		a.MEAS_DIV_CD, a.MEAS_GRP_CD, a.MEAS_CD      				")
					 .append(" ORDER BY		a.MEAS_DIV_CD, a.MEAS_GRP_CD, a.MEAS_CD                 									        ");

				System.out.println(sbSQL);
				//System.out.println("year="+year);

				Object[] pmSQL =  {year};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisOutEvalMeas : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

		/*
		 *   경영정보 > 경영현황 > 사업개발현황
		 */
		public void getEisOutEvalMeasSO(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String year  	= request.getParameter("year");
				//System.out.println("year="+year);

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();

		        sbSQL.append(" SELECT   EVAL_YEAR,																")
			     	 .append("			MAX(CASE WHEN ORG_CD = '00' THEN  QLY_MEAS END) AS QLY_MEAS_00, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '01' THEN  QLY_MEAS END) AS QLY_MEAS_01, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '02' THEN  QLY_MEAS END) AS QLY_MEAS_02, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '03' THEN  QLY_MEAS END) AS QLY_MEAS_03, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '07' THEN  QLY_MEAS END) AS QLY_MEAS_07, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '08' THEN  QLY_MEAS END) AS QLY_MEAS_08, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '09' THEN  QLY_MEAS END) AS QLY_MEAS_09, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '10' THEN  QLY_MEAS END) AS QLY_MEAS_10, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '11' THEN  QLY_MEAS END) AS QLY_MEAS_11, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '12' THEN  QLY_MEAS END) AS QLY_MEAS_12, 		")

					 .append("			MAX(CASE WHEN ORG_CD = '00' THEN  QTY_MEAS END) AS QTY_MEAS_00, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '01' THEN  QTY_MEAS END) AS QTY_MEAS_01, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '02' THEN  QTY_MEAS END) AS QTY_MEAS_02, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '03' THEN  QTY_MEAS END) AS QTY_MEAS_03, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '07' THEN  QTY_MEAS END) AS QTY_MEAS_07, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '08' THEN  QTY_MEAS END) AS QTY_MEAS_08, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '09' THEN  QTY_MEAS END) AS QTY_MEAS_09, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '10' THEN  QTY_MEAS END) AS QTY_MEAS_10, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '11' THEN  QTY_MEAS END) AS QTY_MEAS_11, 		")
					 .append("			MAX(CASE WHEN ORG_CD = '12' THEN  QTY_MEAS END) AS QTY_MEAS_12, 		")

			     	 .append("			MAX(CASE WHEN ORG_CD = '00' THEN  EVAL_SCORE END) AS EVAL_SCORE_00,     ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '01' THEN  EVAL_SCORE END) AS EVAL_SCORE_01,     ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '02' THEN  EVAL_SCORE END) AS EVAL_SCORE_02,     ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '03' THEN  EVAL_SCORE END) AS EVAL_SCORE_03,     ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '07' THEN  EVAL_SCORE END) AS EVAL_SCORE_07,     ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '08' THEN  EVAL_SCORE END) AS EVAL_SCORE_08,     ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '09' THEN  EVAL_SCORE END) AS EVAL_SCORE_09,     ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '10' THEN  EVAL_SCORE END) AS EVAL_SCORE_10,     ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '11' THEN  EVAL_SCORE END) AS EVAL_SCORE_11,     ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '12' THEN  EVAL_SCORE END) AS EVAL_SCORE_12,     ")

			     	 .append("			MAX(CASE WHEN ORG_CD = '00' THEN  EVAL_RANK END) AS EVAL_RANK_00,       ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '01' THEN  EVAL_RANK END) AS EVAL_RANK_01,       ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '02' THEN  EVAL_RANK END) AS EVAL_RANK_02,       ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '03' THEN  EVAL_RANK END) AS EVAL_RANK_03,       ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '07' THEN  EVAL_RANK END) AS EVAL_RANK_07,       ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '08' THEN  EVAL_RANK END) AS EVAL_RANK_08,       ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '09' THEN  EVAL_RANK END) AS EVAL_RANK_09,       ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '10' THEN  EVAL_RANK END) AS EVAL_RANK_10,       ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '11' THEN  EVAL_RANK END) AS EVAL_RANK_11,       ")
			     	 .append("			MAX(CASE WHEN ORG_CD = '12' THEN  EVAL_RANK END) AS EVAL_RANK_12        ")

			     	 .append(" FROM     (                                                                       ")
			     	 .append("			SELECT  EVAL_YEAR,                                                      ")
			     	 .append("					ORG_CD,                                                         ")
			     	 .append("					QLY_MEAS,                                                     	")
			     	 .append("					QTY_MEAS,                                                     	")
			     	 .append("					EVAL_SCORE,                                                     ")
			     	 .append("					EVAL_RANK                                                       ")
			     	 .append("			FROM    TG_EVALORG                                                      ")
			     	 .append("			WHERE   EVAL_YEAR = ?                                              		")
			     	 .append("			)																		")
			     	 .append(" GROUP BY EVAL_YEAR																");

		        //System.out.println(sbSQL);
				//System.out.println("year="+year);

				Object[] pmSQL =  {year};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisOutEvalMeasSO : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}

	    /**
	     * Method Name : getEisEvalOrgMeas
	     * Description	  : 특정년도의 평가기관의 지표을 조회
	     * Author		      : PHG
	     * Create Date	  : 2008-02-04
	     * History	          :
	     * @throws SQLException
	     */
		public void getEisEvalOrgMeasP(HttpServletRequest request, HttpServletResponse response) {
			CoolConnection conn = null;
			DBObject dbobject = null;
			ResultSet rs = null;

			try {
				String eval_year = request.getParameter("eval_year");
				String org_cd = request.getParameter("org_cd");

				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				dbobject = new DBObject(conn.getConnection());

				// GET DETAIL;;
				StringBuffer sbSQL =  new StringBuffer();
				sbSQL.append("  select                                              ");
				sbSQL.append("         org_cd      ,                                ");
				sbSQL.append("         f_getcodenm('G01',org_cd) org_nm,            ");
				sbSQL.append("  	      meas_cd     ,                                ");
				sbSQL.append("  	      f_getcodenm('G04',meas_cd) meas_nm,          ");
				sbSQL.append("         meas_grp_cd ,                                ");
				sbSQL.append("  	      f_getcodenm('G03',meas_grp_cd) meas_grp_nm,  ");
				sbSQL.append("         meas_div_cd ,                                ");
				sbSQL.append("  	      f_getcodenm('G02',meas_div_cd) meas_div_nm,  ");
				sbSQL.append("         weight      ,                                ");
				sbSQL.append("         disp_ord    ,                                ");
				sbSQL.append("         eval_grade  ,                                ");
				sbSQL.append("         actual_value,                                ");
				sbSQL.append("         grade_score ,                                ");
				sbSQL.append("         eval_score                                   ");
				sbSQL.append("  from   tg_evalorgmeas                               ");
				sbSQL.append("  where  eval_year   = ?                         ");
				sbSQL.append("  and	   meas_div_cd   = '1'                         ");
				sbSQL.append("  and    org_cd   like ?||'%'                            ");
				sbSQL.append("  order by org_cd, meas_grp_cd, disp_ord, meas_cd     ");

				////System.out.println(sbSQL);

				Object[] pmSQL =  {eval_year, org_cd};
				rs = dbobject.executePreparedQuery(sbSQL.toString(),pmSQL);

				DataSet ds = new DataSet();
				ds.load(rs);

				request.setAttribute("ds",ds);
			} catch (Exception e) {
				try{ conn.rollback(); } catch (Exception ex) {};
				System.out.println("getEisEvalOrgMeasP : " + e);
			} finally {
				try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
				if (dbobject != null){dbobject.close(); dbobject = null;}
				if (conn != null) {conn.close(); conn = null;}
			}
		}//-- method getEisEvalOrgMeas
}



