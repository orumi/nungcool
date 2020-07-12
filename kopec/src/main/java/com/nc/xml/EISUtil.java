package com.nc.xml;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class EISUtil {
	public void getFinance(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {

			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT  period_name, SALES, MANUFACTURING_COST,SALES_COST,ETC_PROFIT,   ")
	         .append("         ETC_COST,SPECIAL_PROFIT,SPECIAL_LOSS, TAX,   ")
	         .append("         SALES-MANUFACTURING_COST 매출총이익, ")
	         .append("         SALES-MANUFACTURING_COST-SALES_COST 영업이익, SALES-MANUFACTURING_COST-SALES_COST+ETC_PROFIT-ETC_COST 경상이익, ")
	         .append("         SALES-MANUFACTURING_COST-SALES_COST-ETC_COST+ETC_PROFIT-SPECIAL_LOSS+SPECIAL_PROFIT 법인세비용차감전순이익, ")
	         .append("         SALES-MANUFACTURING_COST-SALES_COST-ETC_COST+ETC_PROFIT-SPECIAL_LOSS+SPECIAL_PROFIT-TAX 당기순이익, ")
	         .append("         CUM_SALES - CUM_MANUFACTURING_COST 매출총이익누적, ")
	         .append("         CUM_SALES-CUM_MANUFACTURING_COST-CUM_SALES_COST 영업이익누적, CUM_SALES-CUM_MANUFACTURING_COST-CUM_SALES_COST+CUM_ETC_PROFIT-CUM_ETC_COST 경상이익누적, ")
	         .append("         CUM_SALES-CUM_MANUFACTURING_COST-CUM_SALES_COST-CUM_ETC_COST+CUM_ETC_PROFIT-CUM_SPECIAL_LOSS+CUM_SPECIAL_PROFIT 법인세비용차감전순이익누적, ")
	         .append("         CUM_SALES-CUM_MANUFACTURING_COST-CUM_SALES_COST-CUM_ETC_COST+CUM_ETC_PROFIT-CUM_SPECIAL_LOSS+CUM_SPECIAL_PROFIT-CUM_TAX 당기순이익누적 ")
	         .append(" FROM                ")
	         .append(" ( ")
	         .append("       SELECT  period_name, SALES, SUM(SALES) OVER (PARTITION BY SUBSTR(PERIOD_NAME,1,5)) CUM_SALES, MANUFACTURING_COST,SUM(MANUFACTURING_COST) OVER (PARTITION BY SUBSTR(PERIOD_NAME,1,5)) CUM_MANUFACTURING_COST, ")
	         .append("               SALES_COST,SUM(SALES_COST) OVER (PARTITION BY SUBSTR(PERIOD_NAME,1,5)) CUM_SALES_COST, ETC_PROFIT,SUM(ETC_PROFIT) OVER (PARTITION BY SUBSTR(PERIOD_NAME,1,5)) CUM_ETC_PROFIT,   ")
	         .append("               ETC_COST,SUM(ETC_COST) OVER (PARTITION BY SUBSTR(PERIOD_NAME,1,5)) CUM_ETC_COST,SPECIAL_PROFIT, SUM(SPECIAL_PROFIT) OVER (PARTITION BY SUBSTR(PERIOD_NAME,1,5)) CUM_SPECIAL_PROFIT,  ")
	         .append("               SPECIAL_LOSS, SUM(SPECIAL_LOSS) OVER (PARTITION BY SUBSTR(PERIOD_NAME,1,5)) CUM_SPECIAL_LOSS, TAX, SUM(TAX) OVER (PARTITION BY SUBSTR(PERIOD_NAME,1,5)) CUM_TAX ")
	         .append("       FROM                          ")
	         .append("       ( ")
	         .append("                 select period_name, SUM(SALES) SALES, SUM(MANUFACTURING_COST) MANUFACTURING_COST, SUM(SALES_COST) SALES_COST, SUM(ETC_PROFIT) ETC_PROFIT, SUM(ETC_COST) ETC_COST,  ")
	         .append("                        SUM(SPECIAL_PROFIT) SPECIAL_PROFIT, SUM(SPECIAL_LOSS) SPECIAL_LOSS, SUM(TAX) TAX ")
	         .append("                 from ")
	         .append("                 (                  ")
	         .append("                         (  ")
	         .append("                             SELECT A.PERIOD_NAME ,SUM(NVL(A.ACCOUNTED_CR,0)-NVL(A.ACCOUNTED_DR,0)) SALES,0 MANUFACTURING_COST, 0 SALES_COST,0 ETC_PROFIT,0 ETC_COST,0 SPECIAL_PROFIT,0 SPECIAL_LOSS,0 TAX ")
	         .append("                             FROM     APPS.GL_JE_LINES A, APPS.GL_CODE_COMBINATIONS B, GL.GL_JE_HEADERS C ")
	         .append("                             WHERE  A.PERIOD_NAME >= '2005-01'  ")
	         .append("                                  AND  A.STATUS='P' ")
	         .append("                                  AND  C.ACTUAL_FLAG='A' ")
	         .append("                                  AND  C.CURRENCY_CODE NOT IN ('STAT') ")
	         .append("                                  AND  A.CODE_COMBINATION_ID = B.CODE_COMBINATION_ID ")
	         .append("                                  AND  A.JE_HEADER_ID=C.JE_HEADER_ID    ")
	         .append("                                  AND  B.SEGMENT3 between  '410000' and '441199'             ")
	         .append("                                  AND  A.SET_OF_BOOKS_ID = 1 ")
	         .append("                             GROUP BY A.PERIOD_NAME ")
	         .append("                         ) ")
	         .append("                         UNION ALL ")
	         .append("                         (             ")
	         .append("                            SELECT PERIOD_NAME ,0 SALES,SUM(MAN_COST+WORK_COST) MANUFACTURING_COST, 0 SALES_COST,0 ETC_PROFIT,0 ETC_COST,0 SPECIAL_PROFIT,0 SPECIAL_LOSS,0 TAX        ")
	         .append("                            FROM ")
	         .append("                            (  ")
	         .append("                                ( ")
	         .append("                                   SELECT GJL.PERIOD_NAME PERIOD_NAME, SUM(GJL.ACCOUNTED_CR) MAN_COST, 0 WORK_COST ")
	         .append("                                   FROM APPS.GL_JE_LINES    GJL, APPS.GL_CODE_COMBINATIONS GCC, GL.GL_JE_HEADERS GJH ")
	         .append("                                   WHERE  GJL.PERIOD_NAME >= '2005-01'  ")
	         .append("                                        AND  GJL.STATUS='P' ")
	         .append("                                        AND  GJH.ACTUAL_FLAG='A' ")
	         .append("                                        AND  GJH.CURRENCY_CODE NOT IN ('STAT') ")
	         .append("                                        AND  GJL.CODE_COMBINATION_ID = GCC.CODE_COMBINATION_ID ")
	         .append("                                        AND  GJL.JE_HEADER_ID=GJH.JE_HEADER_ID    ")
	         .append("                                        AND  GCC.SEGMENT3 between  '115200' and '115299' ")
	         .append("                                        AND  GJL.SET_OF_BOOKS_ID = 1 ")
	         .append("                                   GROUP BY GJL.PERIOD_NAME ")
	         .append("                                 )                                    ")
	         .append("                                UNION ALL        ")
	         .append("                                ( ")
	         .append("                                   SELECT GJL.PERIOD_NAME PERIOD_NAME,  0 MAN_COST, SUM(NVL(GJL.ACCOUNTED_DR,0)-NVL(GJL.ACCOUNTED_CR,0)) WORK_COST  ")
	         .append("                                   FROM APPS.GL_JE_LINES    GJL, APPS.GL_CODE_COMBINATIONS GCC, GL.GL_JE_HEADERS GJH ")
	         .append("                                   WHERE  GJL.PERIOD_NAME >= '2005-01'  ")
	         .append("                                        AND  GCC.SEGMENT3 between  '471111' and '479999' ")
	         .append("                                        AND  GJL.STATUS='P' ")
	         .append("                                        AND  GJH.ACTUAL_FLAG='A' ")
	         .append("                                        AND  GJH.CURRENCY_CODE NOT IN ('STAT') ")
	         .append("                                        AND  GJL.CODE_COMBINATION_ID = GCC.CODE_COMBINATION_ID ")
	         .append("                                        AND  GJL.JE_HEADER_ID=GJH.JE_HEADER_ID                                           ")
	         .append("                                        AND  GJL.SET_OF_BOOKS_ID = 1 ")
	         .append("                                   GROUP BY GJL.PERIOD_NAME ")
	         .append("                                 ) ")
	         .append("                             ) ")
	         .append("                             GROUP BY PERIOD_NAME  ")
	         .append("                         ) ")
	         .append("                         UNION ALL   ")
	         .append("                         (   ")
	         .append("                             SELECT GJL.PERIOD_NAME ,0 SALES,0 MANUFACTURING_COST, SUM(NVL(GJL.ACCOUNTED_DR,0)-NVL(GJL.ACCOUNTED_CR,0)) SALES_COST,0 ETC_PROFIT,0 ETC_COST,0 SPECIAL_PROFIT,0 SPECIAL_LOSS,0 TAX           ")
	         .append("                             FROM APPS.GL_JE_LINES    GJL, APPS.GL_CODE_COMBINATIONS GCC, GL.GL_JE_HEADERS GJH ")
	         .append("                             WHERE  GJL.PERIOD_NAME >= '2005-01'  ")
	         .append("                                  AND  GCC.SEGMENT3 between  '700000' and '733999' ")
	         .append("                                  AND  GJL.STATUS='P' ")
	         .append("                                  AND  GJH.ACTUAL_FLAG='A' ")
	         .append("                                  AND  GJH.CURRENCY_CODE NOT IN ('STAT') ")
	         .append("                                  AND  GJL.CODE_COMBINATION_ID = GCC.CODE_COMBINATION_ID ")
	         .append("                                  AND  GJL.JE_HEADER_ID=GJH.JE_HEADER_ID                                     ")
	         .append("                                  AND  GJL.SET_OF_BOOKS_ID = 1 ")
	         .append("                             GROUP BY GJL.PERIOD_NAME ")
	         .append("                          ) ")
	         .append("                          UNION ALL ")
	         .append("                          (    ")
	         .append("                             SELECT GJL.PERIOD_NAME ,0 SALES,0 MANUFACTURING_COST, 0 SALES_COST,SUM(NVL(GJL.ACCOUNTED_CR,0)-NVL(GJL.ACCOUNTED_DR,0)) ETC_PROFIT,0 ETC_COST,0 SPECIAL_PROFIT,0 SPECIAL_LOSS,0 TAX                  ")
	         .append("                             FROM APPS.GL_JE_LINES    GJL, APPS.GL_CODE_COMBINATIONS GCC, GL.GL_JE_HEADERS GJH ")
	         .append("                             WHERE  GJL.PERIOD_NAME >= '2005-01'        ")
	         .append("                                  AND  GCC.SEGMENT3 between  '810000' and '815999'  ")
	         .append("                                  AND  GJL.SET_OF_BOOKS_ID = 1                ")
	         .append("                                  AND  GJL.STATUS='P' ")
	         .append("                                  AND  GJH.ACTUAL_FLAG='A' ")
	         .append("                                  AND  GJH.CURRENCY_CODE NOT IN ('STAT') ")
	         .append("                                  AND  GJL.CODE_COMBINATION_ID = GCC.CODE_COMBINATION_ID ")
	         .append("                                  AND  GJL.JE_HEADER_ID=GJH.JE_HEADER_ID                                     ")
	         .append("                             GROUP BY GJL.PERIOD_NAME       ")
	         .append("                           ) ")
	         .append("                           UNION ALL ")
	         .append("                           (        ")
	         .append("                             SELECT GJL.PERIOD_NAME ,0 SALES,0 MANUFACTURING_COST, 0 SALES_COST,0 ETC_PROFIT,SUM(NVL(GJL.ACCOUNTED_DR,0)-NVL(GJL.ACCOUNTED_CR,0)) ETC_COST,0 SPECIAL_PROFIT,0 SPECIAL_LOSS,0 TAX    ")
	         .append("                             FROM APPS.GL_JE_LINES    GJL, APPS.GL_CODE_COMBINATIONS GCC, GL.GL_JE_HEADERS GJH ")
	         .append("                             WHERE  GJL.PERIOD_NAME >= '2005-01'                        ")
	         .append("                                  AND  GJL.STATUS='P' ")
	         .append("                                  AND  GJH.ACTUAL_FLAG='A' ")
	         .append("                                  AND  GJH.CURRENCY_CODE NOT IN ('STAT') ")
	         .append("                                  AND  GJL.CODE_COMBINATION_ID = GCC.CODE_COMBINATION_ID ")
	         .append("                                  AND  GJL.JE_HEADER_ID=GJH.JE_HEADER_ID    ")
	         .append("                                  AND  GCC.SEGMENT3 between  '820000' and '825099' ")
	         .append("                                  AND  GJL.SET_OF_BOOKS_ID = 1 ")
	         .append("                             GROUP BY GJL.PERIOD_NAME      ")
	         .append("                          ) ")
	         .append("                          UNION ALL ")
	         .append("                          (          ")
	         .append("                             SELECT GJL.PERIOD_NAME ,0 SALES,0 MANUFACTURING_COST, 0 SALES_COST,0 ETC_PROFIT,0 ETC_COST,SUM(NVL(GJL.ACCOUNTED_CR,0)-NVL(GJL.ACCOUNTED_DR,0)) SPECIAL_PROFIT,0 SPECIAL_LOSS,0 TAX         ")
	         .append("                             FROM APPS.GL_JE_LINES    GJL, APPS.GL_CODE_COMBINATIONS GCC, GL.GL_JE_HEADERS GJH ")
	         .append("                             WHERE  GJL.PERIOD_NAME >= '2005-01'                        ")
	         .append("                                  AND  GJL.STATUS='P' ")
	         .append("                                  AND  GJH.ACTUAL_FLAG='A' ")
	         .append("                                  AND  GJH.CURRENCY_CODE NOT IN ('STAT') ")
	         .append("                                  AND  GJL.CODE_COMBINATION_ID = GCC.CODE_COMBINATION_ID ")
	         .append("                                  AND  GJL.JE_HEADER_ID=GJH.JE_HEADER_ID    ")
	         .append("                                  AND  GCC.SEGMENT3 between  '851000' and '851999' ")
	         .append("                                  AND  GJL.SET_OF_BOOKS_ID = 1 ")
	         .append("                             GROUP BY GJL.PERIOD_NAME             ")
	         .append("                          ) ")
	         .append("                          UNION ALL ")
	         .append("                          (    ")
	         .append("                             SELECT GJL.PERIOD_NAME ,0 SALES,0 MANUFACTURING_COST, 0 SALES_COST,0 ETC_PROFIT,0 ETC_COST,0 SPECIAL_PROFIT,SUM(NVL(GJL.ACCOUNTED_DR,0)-NVL(GJL.ACCOUNTED_CR,0)) SPECIAL_LOSS,0 TAX  ")
	         .append("                             FROM APPS.GL_JE_LINES    GJL, APPS.GL_CODE_COMBINATIONS GCC, GL.GL_JE_HEADERS GJH ")
	         .append("                             WHERE  GJL.PERIOD_NAME >= '2005-01'                        ")
	         .append("                                  AND  GJL.STATUS='P' ")
	         .append("                                  AND  GJH.ACTUAL_FLAG='A' ")
	         .append("                                  AND  GJH.CURRENCY_CODE NOT IN ('STAT') ")
	         .append("                                  AND  GJL.CODE_COMBINATION_ID = GCC.CODE_COMBINATION_ID ")
	         .append("                                  AND  GJL.JE_HEADER_ID=GJH.JE_HEADER_ID    ")
	         .append("                                  AND  GCC.SEGMENT3 between  '860000' and '861299' ")
	         .append("                                  AND  GJL.SET_OF_BOOKS_ID = 1 ")
	         .append("                             GROUP BY GJL.PERIOD_NAME                           ")
	         .append("                          ) ")
	         .append("                          UNION ALL ")
	         .append("                          (  ")
	         .append("                             SELECT GJL.PERIOD_NAME ,0 SALES,0 MANUFACTURING_COST, 0 SALES_COST,0 ETC_PROFIT,0 ETC_COST,0 SPECIAL_PROFIT,0 SPECIAL_LOSS,SUM(NVL(GJL.ACCOUNTED_DR,0)-NVL(GJL.ACCOUNTED_CR,0)) TAX  ")
	         .append("                             FROM APPS.GL_JE_LINES  GJL, APPS.GL_CODE_COMBINATIONS GCC, GL.GL_JE_HEADERS GJH ")
	         .append("                             WHERE  GJL.PERIOD_NAME >= '2005-01'                        ")
	         .append("                                  AND  GJL.STATUS='P' ")
	         .append("                                  AND  GJH.ACTUAL_FLAG='A' ")
	         .append("                                  AND  GJH.CURRENCY_CODE NOT IN ('STAT') ")
	         .append("                                  AND  GJL.CODE_COMBINATION_ID = GCC.CODE_COMBINATION_ID ")
	         .append("                                  AND  GJL.JE_HEADER_ID=GJH.JE_HEADER_ID    ")
	         .append("                                  AND  GCC.SEGMENT3 between  '890000' and '891199' ")
	         .append("                                  AND  GJL.SET_OF_BOOKS_ID = 1 ")
	         .append("                             GROUP BY GJL.PERIOD_NAME     ")
	         .append("                          )              ")
	         .append("                 )  ")
	         .append("                 GROUP BY PERIOD_NAME ")
	         .append("       ) ")
	         .append("       WHERE PERIOD_NAME BETWEEN '2005-01' AND ?   ")
	         .append(" ) ");
			
			String year = request.getParameter("year");
			String month = request.getParameter("month"); 
			
			System.out.println(month);
			if (year==null) return;
			
			Object[] obj = {year+"-"+month};
			
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			rs = dbobject.executePreparedQuery(sb.toString(),obj);
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
			
		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	public void getCost(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
            
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT YYYY,YY_QUA,SUM(L_MAT_COST) L_MAT_COST,SUM(L_LABOR_COST) L_LABOR_COST,SUM(L_EXPEND_COST) L_EXPEND_COST,SUM(H_MAT_COST) H_MAT_COST, ")
	         .append("        SUM(H_LABOR_COST) H_LABOR_COST,SUM(H_EXPEND_COST) H_EXPEND_COST ")
	         .append(" FROM ")
	         .append(" ( ")
	         .append("       SELECT YYYY , YY_QUA, SUM(AMT) L_MAT_COST,0 L_LABOR_COST,0 L_EXPEND_COST,0 H_MAT_COST,0 H_LABOR_COST,0 H_EXPEND_COST ")
	         .append("       FROM EIS.tb_mf_fa_cost2 ")
	         .append("       WHERE LH_FLAG = 'L'  AND LH_TYCODE='J01'")
	         .append("         AND WNAME='재료비' ")
	         .append("       GROUP BY YYYY, YY_QUA ")
	         .append("       UNION ALL ")
	         .append("       SELECT YYYY , YY_QUA, 0 L_MAT_COST,SUM(AMT) L_LABOR_COST,0 L_EXPEND_COST,0 H_MAT_COST,0 H_LABOR_COST,0 H_EXPEND_COST ")
	         .append("       FROM EIS.tb_mf_fa_cost2 ")
	         .append("       WHERE LH_FLAG = 'L'  AND LH_TYCODE='J01'")
	         .append("         AND WNAME='노무비' ")
	         .append("       GROUP BY YYYY, YY_QUA ")
	         .append("       UNION ALL ")
	         .append("       SELECT YYYY , YY_QUA, 0 L_MAT_COST,0 L_LABOR_COST,SUM(AMT) L_EXPEND_COST,0 H_MAT_COST,0 H_LABOR_COST,0 H_EXPEND_COST ")
	         .append("       FROM EIS.tb_mf_fa_cost2 ")
	         .append("       WHERE LH_FLAG = 'L'  AND LH_TYCODE='J01'")
	         .append("         AND WNAME='경비' ")
	         .append("       GROUP BY YYYY, YY_QUA ")
	         .append("       UNION ALL ")
	         .append("       SELECT YYYY , YY_QUA, 0 L_MAT_COST,0 L_LABOR_COST,0 L_EXPEND_COST,SUM(AMT) H_MAT_COST,0 H_LABOR_COST,0 H_EXPEND_COST ")
	         .append("       FROM EIS.tb_mf_fa_cost2 ")
	         .append("       WHERE LH_FLAG = 'H' ")
	         .append("         AND WNAME='재료비' ")
	         .append("       GROUP BY YYYY, YY_QUA ")
	         .append("       UNION ALL ")
	         .append("       SELECT YYYY , YY_QUA, 0 L_MAT_COST,0 L_LABOR_COST,0 L_EXPEND_COST,0 H_MAT_COST,SUM(AMT) H_LABOR_COST,0 H_EXPEND_COST ")
	         .append("       FROM EIS.tb_mf_fa_cost2 ")
	         .append("       WHERE LH_FLAG = 'H' ")
	         .append("         AND WNAME='노무비' ")
	         .append("       GROUP BY YYYY, YY_QUA ")
	         .append("       UNION ALL ")
	         .append("       SELECT YYYY ,YY_QUA, 0 L_MAT_COST,0 L_LABOR_COST,0 L_EXPEND_COST,0 H_MAT_COST,0 H_LABOR_COST,SUM(AMT) H_EXPEND_COST ")
	         .append("       FROM EIS.tb_mf_fa_cost2 ")
	         .append("       WHERE LH_FLAG = 'H' ")
	         .append("         AND WNAME='경비' ")
	         .append("       GROUP BY YYYY, YY_QUA ")
	         .append(" ) ")
	         .append(" WHERE YYYY >= '2005' AND YY_QUA >='1' ")
	         .append(" GROUP BY YYYY, YY_QUA ORDER BY YYYY DESC,YY_QUA   ");
			
			rs = dbobject.executeQuery(sb.toString());
			
			DataSet ds = new DataSet();
			ds.load(rs);
			
			request.setAttribute("ds",ds);
			
		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	public void getFund(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String year = request.getParameter("year");
			String qtr = request.getParameter("qtr"); 
			
			if (year==null) return;
			
			StringBuffer sb1 = new StringBuffer();
			sb1.append(" SELECT YY, QUARTER, 비용예산, 비용실적, 수익예산, 수익실적, 구매예산, 구매실적, 자본예산, 자본실적, 분기예산, 분기실적,  ")
	         .append("        100*NVL(분기실적,0)/NVL(분기예산,0) 분기예산집행률, SUM(분기예산) OVER (PARTITION BY YY) 연예산, SUM(분기실적) OVER (PARTITION BY YY) 연실적, ")
	         .append("         100* ( SUM(분기실적) OVER (PARTITION BY YY) )/( SUM(분기예산) OVER (PARTITION BY YY) ) 연예산집행률 ")
	         .append(" FROM ")
	         .append(" (         ")
	         .append("       SELECT YY, QUARTER,SUM(NVL(비용예산,0)) 비용예산, SUM(NVL(비용실적,0)) 비용실적, SUM(NVL(수익예산,0)) 수익예산,SUM(NVL(수익실적,0)) 수익실적,SUM(NVL(구매예산,0)) 구매예산, SUM(NVL(구매실적,0)) 구매실적,  ")
	         .append("             SUM(NVL(자본예산,0)) 자본예산, SUM(NVL(자본실적,0)) 자본실적, ")
	         .append("             SUM( NVL(비용예산,0)+NVL(수익예산,0)+NVL(구매예산,0)+NVL(자본예산,0)) 분기예산,SUM( NVL(비용실적,0)+NVL(수익실적,0)+NVL(구매실적,0)+NVL(자본실적,0)) 분기실적             ")
	         .append("       FROM ")
	         .append("       ( ")
	         .append("           SELECT SUBSTR(YYYYMM,1,4) YY, QUARTER,SUM(BUDGET_AMT) 비용예산, SUM(ACT_AMT) 비용실적,0 수익예산,0 수익실적,0 구매예산, 0 구매실적, 0 자본예산, 0 자본실적 ")
	         .append("           FROM ")
	         .append("           (  ")
	         .append("                 SELECT YYYYMM,GBN, BUDGET_AMT BUDGET_AMT, ACT_AMT , ")
	         .append("                        CASE WHEN SUBSTR(YYYYMM,5,2)='01' OR  SUBSTR(YYYYMM,5,2)='02' OR  SUBSTR(YYYYMM,5,2)='03' THEN '1'    /* 분기별 합산을 위해 */ ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='04' OR  SUBSTR(YYYYMM,5,2)='05' OR  SUBSTR(YYYYMM,5,2)='06' THEN '2' ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='07' OR  SUBSTR(YYYYMM,5,2)='08' OR  SUBSTR(YYYYMM,5,2)='09' THEN '3' ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='10' OR  SUBSTR(YYYYMM,5,2)='11' OR  SUBSTR(YYYYMM,5,2)='12' THEN '4' ")
	         .append("                        END QUARTER ")
	         .append("                 FROM EIS.TB_FN_BUDGET_ACT ")
	         .append("                 WHERE GBN = '비용' ")
	         .append("           ) ")
	         .append("           GROUP BY SUBSTR(YYYYMM,1,4),QUARTER ")
	         .append("           UNION ALL ")
	         .append("           SELECT SUBSTR(YYYYMM,1,4), QUARTER, 0 비용예산, 0 비용실적, SUM(BUDGET_AMT) 수익예산, SUM(ACT_AMT) 수익실적,0 구매예산, 0 구매실적, 0 자본예산, 0 자본실적 ")
	         .append("           FROM ")
	         .append("           (  ")
	         .append("                 SELECT YYYYMM,GBN, BUDGET_AMT BUDGET_AMT, ACT_AMT , ")
	         .append("                        CASE WHEN SUBSTR(YYYYMM,5,2)='01' OR  SUBSTR(YYYYMM,5,2)='02' OR  SUBSTR(YYYYMM,5,2)='03' THEN '1'    /* 분기별 합산을 위해 */ ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='04' OR  SUBSTR(YYYYMM,5,2)='05' OR  SUBSTR(YYYYMM,5,2)='06' THEN '2' ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='07' OR  SUBSTR(YYYYMM,5,2)='08' OR  SUBSTR(YYYYMM,5,2)='09' THEN '3' ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='10' OR  SUBSTR(YYYYMM,5,2)='11' OR  SUBSTR(YYYYMM,5,2)='12' THEN '4' ")
	         .append("                        END QUARTER ")
	         .append("                 FROM EIS.TB_FN_BUDGET_ACT ")
	         .append("                 WHERE GBN = '수익' ")
	         .append("           ) ")
	         .append("           GROUP BY SUBSTR(YYYYMM,1,4),QUARTER ")
	         .append("           UNION ALL ")
	         .append("           SELECT SUBSTR(YYYYMM,1,4), QUARTER, 0 비용예산, 0 비용실적, 0 수익예산, 0 수익실적, SUM(BUDGET_AMT) 구매예산, SUM(ACT_AMT) 구매실적,0 자본예산, 0 자본실적 ")
	         .append("           FROM ")
	         .append("           (  ")
	         .append("                 SELECT YYYYMM,GBN, BUDGET_AMT BUDGET_AMT, ACT_AMT , ")
	         .append("                        CASE WHEN SUBSTR(YYYYMM,5,2)='01' OR  SUBSTR(YYYYMM,5,2)='02' OR  SUBSTR(YYYYMM,5,2)='03' THEN '1'    /* 분기별 합산을 위해 */ ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='04' OR  SUBSTR(YYYYMM,5,2)='05' OR  SUBSTR(YYYYMM,5,2)='06' THEN '2' ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='07' OR  SUBSTR(YYYYMM,5,2)='08' OR  SUBSTR(YYYYMM,5,2)='09' THEN '3' ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='10' OR  SUBSTR(YYYYMM,5,2)='11' OR  SUBSTR(YYYYMM,5,2)='12' THEN '4' ")
	         .append("                        END QUARTER ")
	         .append("                 FROM EIS.TB_FN_BUDGET_ACT ")
	         .append("                 WHERE GBN = '구매예산' ")
	         .append("           ) ")
	         .append("           GROUP BY SUBSTR(YYYYMM,1,4),QUARTER ")
	         .append("           UNION ALL ")
	         .append("           SELECT SUBSTR(YYYYMM,1,4),QUARTER,0 비용예산, 0 비용실적,0 수익예산, 0 수익실적, 0 구매예산, 0 구매실적, SUM(BUDGET_AMT) 자본예산, SUM(ACT_AMT) 자본실적 ")
	         .append("           FROM ")
	         .append("           (  ")
	         .append("                 SELECT YYYYMM,GBN, BUDGET_AMT BUDGET_AMT, ACT_AMT , ")
	         .append("                        CASE WHEN SUBSTR(YYYYMM,5,2)='01' OR  SUBSTR(YYYYMM,5,2)='02' OR  SUBSTR(YYYYMM,5,2)='03' THEN '1'    /* 분기별 합산을 위해 */ ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='04' OR  SUBSTR(YYYYMM,5,2)='05' OR  SUBSTR(YYYYMM,5,2)='06' THEN '2' ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='07' OR  SUBSTR(YYYYMM,5,2)='08' OR  SUBSTR(YYYYMM,5,2)='09' THEN '3' ")
	         .append("                             WHEN SUBSTR(YYYYMM,5,2)='10' OR  SUBSTR(YYYYMM,5,2)='11' OR  SUBSTR(YYYYMM,5,2)='12' THEN '4' ")
	         .append("                        END QUARTER ")
	         .append("                 FROM EIS.TB_FN_BUDGET_ACT ")
	         .append("                 WHERE GBN = '자본예산' ")
	         .append("           ) ")
	         .append("           GROUP BY SUBSTR(YYYYMM,1,4),QUARTER ")
	         .append("       ) ")
	         .append("       GROUP BY YY, QUARTER     ")
	         .append(" ) ")
	         .append(" WHERE YY>=2005 AND (YY||QUARTER<=?) ");
			Object[] obj1 = {year+qtr};
			rs = dbobject.executePreparedQuery(sb1.toString(),obj1);
			DataSet ds1 = new DataSet();
			ds1.load(rs);
			request.setAttribute("ds1",ds1);
			
			
		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	public void getFundDetail(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			
			String year = request.getParameter("year");
			
			if (year==null) return;
			
			int pYear = Integer.parseInt(year)-1;
			
			
			StringBuffer sb1 = new StringBuffer();
			sb1.append(" SELECT SUBSTR(YYYYMM,0,4) YEAR,SUBSTR(YYYYMM,5,2) MONTH,   ")
	         .append("       ( SELECT AMT FROM EIS.TB_FN_CASH_PLAN_ACT WHERE CODE='999999' AND YYYYMM=? ) IN_REMAINDER,  ")
	         .append("       SUM(IN_PLAN) IN_PLAN,SUM(IN_ACTUAL) IN_ACTUAL, SUM(OUT_PLAN) OUT_PLAN,SUM(OUT_ACTUAL) OUT_ACTUAL ")
	         .append(" FROM ")
	         .append(" (  ")
	         .append("         SELECT YYYYMM, AMT IN_PLAN,0 IN_ACTUAL, 0 OUT_PLAN, 0 OUT_ACTUAL   ")
	         .append("         FROM EIS.TB_FN_CASH_PLAN_ACT ")
	         .append("         WHERE CODE='105000' AND PLAN_ACT_GBN ='계획' ")
	         .append("         UNION ALL ")
	         .append("         SELECT YYYYMM, 0 IN_PLAN,AMT IN_ACTUAL, 0 OUT_PLAN, 0 OUT_ACTUAL ")
	         .append("         FROM EIS.TB_FN_CASH_PLAN_ACT ")
	         .append("         WHERE CODE='105000' AND PLAN_ACT_GBN ='실적' ")
	         .append("         UNION ALL ")
	         .append("         SELECT YYYYMM,0 IN_PLAN,0 IN_ACTUAL, AMT OUT_PLAN, 0 OUT_ACTUAL ")
	         .append("         FROM EIS.TB_FN_CASH_PLAN_ACT ")
	         .append("         WHERE CODE='215000' AND PLAN_ACT_GBN ='계획' ")
	         .append("         UNION ALL ")
	         .append("         SELECT YYYYMM, 0 IN_PLAN,0 IN_ACTUAL, 0 OUT_PLAN, AMT OUT_ACTUAL ")
	         .append("         FROM EIS.TB_FN_CASH_PLAN_ACT ")
	         .append("         WHERE CODE='215000' AND PLAN_ACT_GBN ='실적' ")
	         .append(" ) ")
	         .append(" WHERE YYYYMM >= ? ")
	         .append(" GROUP BY YYYYMM ");
			Object[] obj1 = {String.valueOf(pYear)+"12",year+"01"};
			
			rs = dbobject.executePreparedQuery(sb1.toString(),obj1);
			DataSet ds1 = new DataSet();
			ds1.load(rs);
			request.setAttribute("ds1",ds1);
			
			
		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}	
	public void getProduct(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			
			int m = Integer.parseInt(month);
			if (m<10) month = "0"+month;
			String date = request.getParameter("date");
			int d = Integer.parseInt(date);
			if (d<10) date = "0"+date;
			
			String day = year+month+date;
			if (year==null) return;
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT YYYY, QUATER, SUM(L_TARGET_PROD) L_T_PROD_FA, SUM(L_ACT_PROD) L_A_PROD_FA, ")
			  .append(" SUM(H_TARGET_PROD) H_T_PROD_TU, SUM(H_ACT_PROD) H_A_PROD_TU, ")
			  .append(" SUM(L_TARGET_DELI) L_T_DELI_FA,SUM(L_ACT_DELI) L_A_DELI_FA,  ")
	   		  .append(" SUM(H_TARGET_DELI) H_T_DELI_TU,SUM(H_ACT_DELI) H_A_DELI_TU, ")
	   		  .append(" ROUND(SUM(L_TARGET_PROD)*19.13/1000,2) L_T_PROD_TU, ROUND(SUM(L_ACT_PROD)*19.13/1000,2) L_A_PROD_TU, ")
	   		  .append(" ROUND(SUM(H_TARGET_PROD)*1000/19.13,2) H_T_PROD_FA, ROUND(SUM(H_ACT_PROD)*1000/19.13,2) H_A_PROD_FA, ")
	   	      .append(" ROUND(SUM(L_TARGET_DELI)*19.13/1000,2) L_T_DELI_TU,ROUND(SUM(L_ACT_DELI)*19.13/1000,2) L_A_DELI_TU, ")
	   		  .append(" ROUND(SUM(H_TARGET_DELI)*1000/19.13,2) H_T_DELI_FA, ROUND(SUM(H_ACT_DELI)*1000/19.13,2) H_A_DELI_FA ")
	   		 .append(" FROM ")
	         .append(" ( ")
	         .append("       SELECT AA.YYYY, AA.QUATER, L_TARGET_PROD, L_ACT_PROD, H_TARGET_PROD, H_ACT_PROD, 0 L_TARGET_DELI, 0 L_ACT_DELI, 0 H_TARGET_DELI, 0 H_ACT_DELI ")
	         .append("       FROM ")
	         .append("       ( ")
	         .append("       select YYYY, 1 QUATER, QUATER1_TARGET L_TARGET_PROD, QUATER1_ACT L_ACT_PROD ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='생산량' AND LH_FLAG='L' ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 2 QUATER, QUATER2_TARGET L_TARGET_PROD, QUATER2_ACT L_ACT_PROD ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='생산량' AND LH_FLAG='L'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 3 QUATER, QUATER3_TARGET L_TARGET_PROD, QUATER3_ACT L_ACT_PROD ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='생산량' AND LH_FLAG='L'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 4 QUATER, QUATER4_TARGET L_TARGET_PROD, QUATER4_ACT L_ACT_PROD ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='생산량' AND LH_FLAG='L' ")
	         .append("       )AA       ")
	         .append("       INNER JOIN       ")
	         .append("       ( ")
	         .append("       select YYYY, 1 QUATER, QUATER1_TARGET H_TARGET_PROD, QUATER1_ACT H_ACT_PROD ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='생산량' AND LH_FLAG='H'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 2 QUATER, QUATER2_TARGET H_TARGET_PROD, QUATER2_ACT H_ACT_PROD ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='생산량' AND LH_FLAG='H'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 3 QUATER, QUATER3_TARGET H_TARGET_PROD, QUATER3_ACT H_ACT_PROD ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='생산량' AND LH_FLAG='H'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 4 QUATER, QUATER4_TARGET H_TARGET_PROD, QUATER4_ACT H_ACT_PROD ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='생산량' AND LH_FLAG='H' ")
	         .append("       )BB ")
	         .append("       ON AA.YYYY= BB.YYYY AND AA.QUATER=BB.QUATER ")
	         .append("       UNION ALL ")
	         .append("       SELECT AA.YYYY, AA.QUATER,0 L_TARGET_PROD,0 L_ACT_PROD,0 H_TARGET_PROD,0 H_ACT_PROD,L_TARGET_DELI, L_ACT_DELI, H_TARGET_DELI, H_ACT_DELI ")
	         .append("       FROM ")
	         .append("       ( ")
	         .append("       select YYYY, 1 QUATER, QUATER1_TARGET L_TARGET_DELI, QUATER1_ACT L_ACT_DELI ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='납품량' AND LH_FLAG='L'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 2 QUATER, QUATER2_TARGET L_TARGET_DELI, QUATER2_ACT L_ACT_DELI ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='납품량' AND LH_FLAG='L'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 3 QUATER, QUATER3_TARGET L_TARGET_DELI, QUATER3_ACT L_ACT_DELI ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='납품량' AND LH_FLAG='L'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 4 QUATER, QUATER4_TARGET L_TARGET_DELI, QUATER4_ACT L_ACT_DELI ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='납품량' AND LH_FLAG='L' ")
	         .append("       )AA       ")
	         .append("       INNER JOIN       ")
	         .append("       ( ")
	         .append("       select YYYY, 1 QUATER, QUATER1_TARGET H_TARGET_DELI, QUATER1_ACT H_ACT_DELI ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='납품량' AND LH_FLAG='H'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 2 QUATER, QUATER2_TARGET H_TARGET_DELI, QUATER2_ACT H_ACT_DELI ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='납품량' AND LH_FLAG='H'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 3 QUATER, QUATER3_TARGET H_TARGET_DELI, QUATER3_ACT H_ACT_DELI ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='납품량' AND LH_FLAG='H'       ")
	         .append("       UNION ALL       ")
	         .append("       select YYYY, 4 QUATER, QUATER4_TARGET H_TARGET_DELI, QUATER4_ACT H_ACT_DELI ")
	         .append("       from eis.tb_mn_target ")
	         .append("       where GBN='납품량' AND LH_FLAG='H' ")
	         .append("       )BB ")
	         .append("       ON AA.YYYY= BB.YYYY AND AA.QUATER=BB.QUATER             ")
	         .append(" ) ")
	         .append(" WHERE YYYY=? ")
	         .append(" GROUP BY YYYY, QUATER ");
			Object[] obj = {year};
			
			rs = dbobject.executePreparedQuery(sb.toString(),obj);
			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("ds",ds);
			
			StringBuffer strRev = new StringBuffer();
			strRev.append("D");
			
			StringBuffer strRev1 = new StringBuffer();
			strRev1.append("D");
			
			
			StringBuffer sb1 = new StringBuffer();
			sb1.append("SELECT ")
				.append(" (SELECT SUM(DAY_PLAN_QTY) FROM EIS.TB_MF_DAILY WHERE SUBSTR(YYYYMMDD,0,8)=? AND ROUTING=4101) LDP, ")
				.append(" (SELECT DAY_ACT_QTY FROM EIS.TB_MF_DAILY WHERE SUBSTR(YYYYMMDD,0,8)=? AND ROUTING=4101 AND PROJECT_NO='검사누계') LDA, ")
				.append(" (SELECT ACC_PLAN_QTY FROM EIS.TB_MF_DAILY WHERE YYYYMMDD= ")
				.append(" (SELECT MIN(YYYYMMDD) MD FROM EIS.TB_MF_DAILY WHERE SUBSTR(YYYYMMDD,0,8)>? AND ROUTING=4101 AND PROJECT_NO='누계') ")
				.append(" AND ROUTING=4101 AND PROJECT_NO='누계') LAP, ")
				.append(" (SELECT ACC_ACT_QTY FROM EIS.TB_MF_DAILY WHERE YYYYMMDD= ")
				.append(" (SELECT MAX(YYYYMMDD) MD FROM EIS.TB_MF_DAILY WHERE SUBSTR(YYYYMMDD,0,8)<=? AND ROUTING=4101 AND PROJECT_NO='검사누계') ")
				.append(" AND ROUTING=4101 AND PROJECT_NO='검사누계') LAA, ")
				.append(" (SELECT AVG(YEAR_PLAN_QTY) AVG FROM EIS.TB_MF_DAILY WHERE SUBSTR(YYYYMMDD,0,4)=? AND ROUTING=4101 AND YEAR_PLAN_QTY<>0) LA ")
				.append(" FROM DUAL ");
			Object[] obj1 = {day,day,day,day,year};
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(sb1.toString(),obj1);
			
			while(rs.next()){
				strRev.append("|"+rs.getInt("LDP"))
					.append("|"+rs.getInt("LDA"))
					.append("|"+rs.getInt("LAP"))
					.append("|"+rs.getInt("LAA"))
					.append("|"+rs.getInt("LA"));
			}
			
			StringBuffer sbTon = new StringBuffer();
			sbTon.append("SELECT ")
				.append(" (SELECT ROUND(SUM(DAY_PLAN_QTY)*19.13/1000,2) FROM EIS.TB_MF_DAILY WHERE SUBSTR(YYYYMMDD,0,8)=? AND ROUTING=4101) LDP, ")
				.append(" (SELECT ROUND(DAY_ACT_QTY*19.13/1000,2) FROM EIS.TB_MF_DAILY WHERE SUBSTR(YYYYMMDD,0,8)=? AND ROUTING=4101 AND PROJECT_NO='검사누계') LDA, ")
				.append(" (SELECT ROUND(ACC_PLAN_QTY*19.13/1000,2) FROM EIS.TB_MF_DAILY WHERE YYYYMMDD= ")
				.append(" (SELECT MIN(YYYYMMDD) MD FROM EIS.TB_MF_DAILY WHERE SUBSTR(YYYYMMDD,0,8)>? AND ROUTING=4101 AND PROJECT_NO='누계') ")
				.append(" AND ROUTING=4101 AND PROJECT_NO='누계') LAP, ")
				.append(" (SELECT ROUND(ACC_ACT_QTY*19.13/1000,2) FROM EIS.TB_MF_DAILY WHERE YYYYMMDD= ")
				.append(" (SELECT MAX(YYYYMMDD) MD FROM EIS.TB_MF_DAILY WHERE SUBSTR(YYYYMMDD,0,8)<=? AND ROUTING=4101 AND PROJECT_NO='검사누계') ")
				.append(" AND ROUTING=4101 AND PROJECT_NO='검사누계') LAA, ")
				.append(" (SELECT ROUND(AVG(YEAR_PLAN_QTY)*19.13/1000,2) AVG FROM EIS.TB_MF_DAILY WHERE SUBSTR(YYYYMMDD,0,4)=? AND ROUTING=4101 AND YEAR_PLAN_QTY<>0) LA ")
				.append(" FROM DUAL ");
			if (rs!=null){rs.close(); rs=null;}
			rs = dbobject.executePreparedQuery(sbTon.toString(),obj1);
			
			while(rs.next()){
				strRev1.append("|"+rs.getInt("LDP"))
					.append("|"+rs.getInt("LDA"))
					.append("|"+rs.getInt("LAP"))
					.append("|"+rs.getInt("LAA"))
					.append("|"+rs.getInt("LA"));
			}
			
			
			
			StringBuffer sb2 = new StringBuffer();
			sb2.append("SELECT SUM(DAY_PLAN_QTY) DP, ROUND(SUM(DAY_PLAN_QTY)*19.13/1000,0) HDP, SUM(DAY_ACT_QTY) DA, ROUND(SUM(DAY_ACT_QTY)*19.13/1000,0) HDA ")
				.append(" FROM EIS.TB_MF_DAILY  ")
				.append(" WHERE SUBSTR(YYYYMMDD,0,8)=? AND ROUTING=5051 AND PROJECT_NO<>'누계' AND PROJECT_NO<>'검사누계'");
			Object[] obj2 = {day};
			
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(sb2.toString(),obj2);
			
			if (rs.next()){
				strRev1.append("|"+rs.getInt("HDP"))
					.append("|"+rs.getInt("HDA"));
				strRev.append("|"+rs.getInt("DP"))
				.append("|"+rs.getInt("DA"));				
			} else {
				strRev1.append("|")
				.append("|");
				strRev.append("|")
				.append("|");	
			}
			
			StringBuffer sb3 = new StringBuffer();
			sb3.append("SELECT ACC_PLAN_QTY AP,ROUND(ACC_PLAN_QTY*19.13/1000,0) HAP, ACC_ACT_QTY AA,ROUND(ACC_ACT_QTY*19.13/1000,0) HAA FROM EIS.TB_MF_DAILY WHERE YYYYMMDD= ")
				.append(" (SELECT MIN(YYYYMMDD) FROM EIS.TB_MF_DAILY WHERE YYYYMMDD>? AND ROUTING=5051 AND PROJECT_NO='누계') ")
				.append(" AND ROUTING=5051 AND PROJECT_NO='누계' ");
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(sb3.toString(),obj2);
			
			if(rs.next()){
				strRev1.append("|"+rs.getInt("HAP"))
					.append("|"+rs.getInt("HAA"));
				strRev.append("|"+rs.getInt("AP"))
					.append("|"+rs.getInt("AA"));				
			} else {
				strRev1.append("|")
				.append("|");
				strRev.append("|")
					.append("|");	
			}
			
			StringBuffer sb4 = new StringBuffer();
			sb4.append("SELECT AVG(YEAR_PLAN_QTY) A, ROUND(AVG(YEAR_PLAN_QTY)*19.13/1000,0) HA FROM EIS.TB_MF_DAILY WHERE ROUTING=5051 AND SUBSTR(YYYYMMDD,0,4)=? AND YEAR_PLAN_QTY<>0");
			Object[] obj4 = {year};
			if (rs!=null){rs.close(); rs=null;}
			
			rs = dbobject.executePreparedQuery(sb4.toString(),obj4);
			
			if(rs.next()){
				strRev1.append("|"+rs.getInt("HA")+"|[ton-U]");
				strRev.append("|"+rs.getInt("A")+"|[FA]");
			}else {
				strRev1.append("|"+"|[ton-U]");
				strRev.append("|"+"|[FA]");
			}
			
			request.setAttribute("daily",strRev.toString());
			request.setAttribute("daily1",strRev1.toString());
		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	
	public void getMeasure(HttpServletRequest request, HttpServletResponse respons){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			String year = request.getParameter("year");
			if (year==null) return;
			String month = request.getParameter("month");
			
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM ( ")
	         .append(" SELECT T.ID,T.PARENTID,T.CONTENTID,T.TREELEVEL,D.ID MID,D.MEASUREID,D.FREQUENCY,D.UNIT,D.EQUATIONDEFINE,D.MEASUREMENT,C.NAME,D.YEAR, ")
	         .append(" (SELECT USERNAME FROM TBLUSER WHERE USERID=D.UPDATEID) UNAME  FROM TBLMEASUREDEFINE D,TBLMEASURE C,TBLTREESCORE T ")
	         .append(" WHERE T.CONTENTID=D.ID AND T.TREELEVEL=5 AND D.MEASUREID=C.ID AND D.YEAR=? AND D.ID IN (1,2,3,5,6,7,12)  ")
	         .append(" ) MEA ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,C.NAME ONAME FROM TBLTREESCORE T, TBLOBJECTIVE C  ")
	         .append(" WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ")
	         .append(" ON MEA.PARENTID=OBJ.OID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,C.NAME PNAME FROM TBLTREESCORE T, TBLPST C  ")
	         .append(" WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=?) PST ")
	         .append(" ON OBJ.OPID=PST.PID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,C.NAME BNAME FROM TBLHIERARCHY T, TBLBSC C  ")
	         .append(" WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=?) BSC ")
	         .append(" ON PST.PPID=BSC.BID ")
	         .append(" LEFT JOIN  ")
	         .append(" (SELECT A.MEASUREID AMID,ROUND(A.ACTUAL,1) ACTUAL,A.PLANNED,A.BASE,A.LIMIT FROM TBLMEASUREDETAIL A WHERE SUBSTR(A.STRDATE,0,6)=? ) ACT ")
	         .append(" ON MEA.MID=ACT.AMID ")
	         .append(" LEFT JOIN ")
	         .append(" (SELECT ROUND(S.SCORE,1) SCORE,S.MEASUREID SMID FROM TBLMEASURESCORE S WHERE SUBSTR(S.STRDATE,0,6)=?) SCR ")
	         .append(" ON MEA.MID=SCR.SMID ORDER BY BID,PID,MID");
			
			Object[] obj = {year,year,year,year,year+month,year+month};
			
			rs = dbobject.executePreparedQuery(sb.toString(),obj);
			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("ds",ds);
			
			
		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	public void getActual(HttpServletRequest request, HttpServletResponse response){
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			dbobject = new DBObject(conn.getConnection());
			String year = request.getParameter("year");
			if (year==null) return;
			String month = request.getParameter("month");
			
			String bYear = String.valueOf(Integer.parseInt(year)-1);
			String mid = request.getParameter("mid");
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT * FROM ( ")
				.append(" SELECT SUBSTR(D.STRDATE,1,4) YEAR, SUBSTR(D.STRDATE,5,2) MONTH,ROUND(D.ACTUAL,2) ACTUAL,D.WEIGHT,D.PLANNED,D.COMMENTS,D.BASE,D.LIMIT,ROUND(S.SCORE,2) SCORE ") 
				.append(" FROM TBLMEASUREDETAIL D,TBLMEASURESCORE S WHERE D.MEASUREID=S.MEASUREID(+) AND D.STRDATE=S.STRDATE(+)  ")
				.append(" AND D.MEASUREID=? AND SUBSTR(D.STRDATE,0,4)=? ) CUR  ")
				.append(" LEFT JOIN  ")
				.append(" (SELECT SUBSTR(D.STRDATE,1,4) YEARB, SUBSTR(D.STRDATE,5,2) MONTHB,ROUND(D.ACTUAL,2) ACTUALB,D.WEIGHT WEIGHTB,D.PLANNED PLANNEDB,D.COMMENTS COMMENTSB,D.BASE BASEB ") 
				.append(" ,D.LIMIT LIMITB,ROUND(S.SCORE,2) SCOREB  ")
				.append(" FROM TBLMEASUREDETAIL D,TBLMEASURESCORE S WHERE D.MEASUREID=S.MEASUREID(+) AND D.STRDATE=S.STRDATE(+) ") 
				.append(" AND D.MEASUREID=(SELECT ID FROM TBLMEASUREDEFINE WHERE ETLKEY=(SELECT D.ETLKEY FROM TBLMEASUREDEFINE D WHERE D.ID=?) AND YEAR=?) ")  
				.append(" AND SUBSTR(D.STRDATE,0,4)=?)BEF  ")
				.append(" ON CUR.MONTH=BEF.MONTHB  ")
				.append(" ORDER BY YEAR,MONTH ");
			
			Object[] obj = {mid,year,mid,bYear,bYear};
			
			rs = dbobject.executePreparedQuery(sb.toString(),obj);
			DataSet ds = new DataSet();
			ds.load(rs);
			request.setAttribute("ds",ds);
		} catch (Exception e) {
			System.out.println(this.toString()+" : "+e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	
	
	
	
	
	
	
	
	
	
	
}
