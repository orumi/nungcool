package com.nc.coolChart;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class CoolChartUtil {
	
	public void coolChartList(HttpServletRequest request, HttpServletResponse response)
	{
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		DataSet ds = null;
		
		StringBuffer dept = new StringBuffer();	//-- 부서
		StringBuffer res = new StringBuffer();	//-- 본부
		StringBuffer childRes = new StringBuffer();	//-- 처실

		
		
		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
    		conn.createStatement(false);
    		ds = new DataSet();
    		
    		if(dbobject == null)
    			dbobject = new DBObject(conn.getConnection());
    		
    		
			//-- 부서(전사, 본부)
			dept.append("SELECT DISTINCT SCID, SNAME FROM ( ") ;
			dept.append("SELECT * FROM  ") ;
			dept.append("(SELECT T.ID CID,T.PARENTID CPID,T.CONTENTID CCID,T.TREELEVEL CLEVEL,T.RANK CRANK,T.WEIGHT CWEIGHT,C.NAME CNAME  ") ;
			dept.append("FROM TBLHIERARCHY T,TBLCOMPANY C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=0 ) COM ") ;
			dept.append("LEFT JOIN ") ;
			dept.append("(SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ") ;
			dept.append("FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 ) SBU ") ;
			dept.append("ON COM.CID=SBU.SPID ") ;
			dept.append("ORDER BY SRANK,SID ") ;
			dept.append(") ") ;
			dept.append("WHERE SCID IN (1,3) ") ;

			rs = dbobject.executePreparedQuery(dept.toString(), null);
			ds.load(rs);
			request.setAttribute("dept", ds);
			
			
			//--본부
			if (rs!=null && ds != null)
			{rs.close(); ds=null; ds = new DataSet(); rs = null;}

			res.append("SELECT DISTINCT BCID, BNAME, SCID FROM ( ") ;
			res.append("SELECT * FROM  ") ;
			res.append("(SELECT T.ID CID,T.PARENTID CPID,T.CONTENTID CCID,T.TREELEVEL CLEVEL,T.RANK CRANK,T.WEIGHT CWEIGHT,C.NAME CNAME  ") ;
			res.append("FROM TBLHIERARCHY T,TBLCOMPANY C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=0 ) COM ") ;
			res.append("LEFT JOIN ") ;
			res.append("(SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ") ;
			res.append("FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 ) SBU ") ;
			res.append("ON COM.CID=SBU.SPID ") ;
			res.append("LEFT JOIN ") ;
			res.append("(SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ") ;
			res.append("FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2) BSC ") ;
			res.append("ON SBU.SID=BSC.BPID ") ;
			res.append("ORDER BY SRANK,SID,BRANK,BID ") ;
			res.append(") ") ;
			res.append("WHERE SCID IN (1,3) ") ;

			rs = dbobject.executePreparedQuery(res.toString(), null);
			ds.load(rs);
			request.setAttribute("res", ds);
	
			chartList(request, dbobject);		//-- 체크 된 항목 저장 process 분리 
			conn.commit();
		}catch (SQLException se){
			try{conn.rollback();} catch (Exception e){}
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			try{conn.rollback();} catch (Exception se){}
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
			if (dbobject!=null){dbobject.close();dbobject=null;}
			if (conn!=null){conn.close();conn=null;}
		}
	}

	
	
	public void chartList(HttpServletRequest request, DBObject dbobject)
	{
		ResultSet rs = null;
		DataSet ds = null;
		DataSet resDs = null;
		DataSet indctDs = null;
		DataSet chkDs = null;	
		
		StringBuffer indct = new StringBuffer();	//-- 성과지표
		StringBuffer childRes = new StringBuffer();	//-- 처.실 
		StringBuffer chkList = new StringBuffer();	//-- 처.실
		
		String indctL = "";
		String childResL = "";
		String resid = "";
		String year = "";
		String deptid = "";
		String userid = "";
		
		
		try{
			
			String idx = request.getParameter("idx")==null?"":request.getParameter("idx");	//--구분 
			resid = request.getParameter("resid")==null?"":request.getParameter("resid");	//--각 본부
			year =  request.getParameter("year")==null?"":request.getParameter("year");
			deptid = request.getParameter("deptid")==null?"":request.getParameter("deptid");	//--전사, 본부
			userid = request.getParameter("userid")==null?"":request.getParameter("userid");
			
			indctL = request.getParameter("indctArr");
			childResL = request.getParameter("childResArr");
			
			//-- 페이지 처음 로딩시
			
			//-- 성과지표
			indctDs = new DataSet();
			
			indct.append("SELECT MCID,MNAME FROM  ") ;
			indct.append("(SELECT T.ID CID,T.PARENTID CPID,T.CONTENTID CCID,T.TREELEVEL CLEVEL,T.RANK CRANK,T.WEIGHT CWEIGHT,C.NAME CNAME  ") ;
			indct.append("FROM TBLHIERARCHY T,TBLCOMPANY C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=0 AND T.YEAR=? ) COM ") ;
			indct.append("LEFT JOIN ") ;
			indct.append("(SELECT T.ID SID,T.PARENTID SPID,T.CONTENTID SCID,T.TREELEVEL SLEVEL,T.RANK SRANK,T.WEIGHT SWEIGHT,C.NAME SNAME  ") ;
			indct.append("FROM TBLHIERARCHY T,TBLSBU C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=1 AND T.YEAR=? ) SBU ") ;
			indct.append("ON COM.CID=SBU.SPID ") ;
			indct.append("LEFT JOIN ") ;
			indct.append("(SELECT T.ID BID,T.PARENTID BPID,T.CONTENTID BCID,T.TREELEVEL BLEVEL,T.RANK BRANK,T.WEIGHT BWEIGHT,C.NAME BNAME  ") ;
			indct.append("FROM TBLHIERARCHY T,TBLBSC C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=2 AND T.YEAR=? ) BSC ") ;
			indct.append("ON SBU.SID=BSC.BPID ") ;
			indct.append("LEFT JOIN ") ;
			indct.append("(SELECT T.ID PID,T.PARENTID PPID,T.CONTENTID PCID,T.TREELEVEL PLEVEL,T.RANK PRANK,T.WEIGHT PWEIGHT,C.NAME PNAME  ") ;
			indct.append("FROM TBLTREESCORE T,TBLPST C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=3 AND T.YEAR=? ) PST ") ;
			indct.append("ON BSC.BID=PST.PPID ") ;
			indct.append("LEFT JOIN ") ;
			indct.append("(SELECT T.ID OID,T.PARENTID OPID,T.CONTENTID OCID,T.TREELEVEL OLEVEL,T.RANK ORANK,T.WEIGHT OWEIGHT,C.NAME ONAME  ") ;
			indct.append("FROM TBLTREESCORE T,TBLOBJECTIVE C WHERE T.CONTENTID=C.ID AND T.TREELEVEL=4 AND T.YEAR=? ) OBJ ") ;
			indct.append("ON PST.PID=OBJ.OPID ") ;
			indct.append("LEFT JOIN ") ;
			indct.append("(SELECT T.ID MID,T.PARENTID MPID,T.CONTENTID MCID,T.TREELEVEL MLEVEL,T.RANK MRANK,T.WEIGHT MWEIGHT,C.NAME MNAME  ") ;
			indct.append("FROM TBLTREESCORE T,TBLMEASUREDEFINE D, TBLMEASURE C WHERE T.CONTENTID=D.ID AND D.MEASUREID=C.ID AND T.TREELEVEL=5 AND T.YEAR=? ) MEA ") ;
			indct.append("ON OBJ.OID=MEA.MPID ") ;
			indct.append("where BCID = ? ") ;
			indct.append("ORDER BY CRANK,SRANK,SID,BRANK,BID,PRANK,PID,ORANK,OID,MRANK ") ;

			//-- insert, update 먼저 처리후 조회(저장 process 가 완료되기전에 조회가 되는걸 방지 하기 위해)
			if(idx.equals("S"))
			{
				indctL=indctL.substring(1, indctL.length());		//-- 스트링의 맨 앞에 있는 구분자를 삭제 위해
				childResL = childResL.substring(1, childResL.length()); //--위와 동일
				
				
				String[] indctArr = indctL.split(":");	//--지표 코드
				String[] childResArr = childResL.split(":");	//-- 처실코드
				StringBuffer strSQL = new StringBuffer();
				StringBuffer strSQLUdp = new StringBuffer();
				
				String flag = "";
				Object[] pa = new Object[]{};		//--insert object param
				Object[] paU = new Object[]{};	//-- update object param
				ArrayList al = new ArrayList();	//--insert ArrayList
				ArrayList alU = new ArrayList();	//--update ArrayList
				
				for(int i = 0; i < indctArr.length; i++)
				{
					for(int j = 0; j < childResArr.length; j++)
					{
						flag = "";
						flag = request.getParameter("chk"+String.valueOf(indctArr[i])+"_"+String.valueOf(childResArr[j]))==null?"N":"Y";

						
						pa = null;
						pa = new Object[]{year, indctArr[i] , childResArr[j], resid, flag, userid};

						paU = null;
						paU = new Object[]{flag, year, indctArr[i], childResArr[j], resid};
						
						strSQLUdp = new StringBuffer();
						strSQLUdp.append("update TBLCOOLCHART set checkyn = ?  ") ;
						strSQLUdp.append("where year = ?  ") ;
						strSQLUdp.append("and indctid = ?  ") ;
						strSQLUdp.append("and resid = ? ") ;
						strSQLUdp.append("and deptid = ? ") ;
						
						int udp = dbobject.executePreparedUpdate(strSQLUdp.toString(), paU);
						
						if(udp < 1)
						{
							strSQL = new StringBuffer();
							strSQL.append("INSERT INTO TBLCOOLCHART (YEAR, INDCTID, RESID, DEPTID, CHECKYN, REGIR) ") ;
							strSQL.append(" VALUES(  ?, ?,   ?,    ?, ?,    ? )  ") ;
							
							dbobject.executePreparedUpdate(strSQL.toString(), pa);
						}
						
						strSQLUdp = null;	//-- 초기화
						strSQLUdp = new StringBuffer();
						
						strSQL = null;		//-- 초기
						strSQL = new StringBuffer();;	
						
					}
				}
				request.setAttribute("confirm", "ok");	//-- update, insert 후 폼 reload 시 ok라를 값을 보내주면 폼에서 체크하여 alert 창 으로 알려줌.
			}
			
			Object[] indctParam = {year,year,year,year,year,year,resid};
			rs = dbobject.executePreparedQuery(indct.toString(), indctParam);
			indctDs.load(rs);
			request.setAttribute("indct", indctDs);
			
			Object[] resParam;
			if(resid.equals("1"))
			{
				childRes.append("SELECT id, name FROM TBLBSC ");
				childRes.append(" where id not in (1,3,8,17) ") ;
				resParam = null;
			}
			else
			{
				childRes.append("SELECT id, name FROM TBLBSC ") ;
				childRes.append("WHERE PARENTID = ? ") ;
				resParam = new Object[]{resid};
			}
			
			if (rs!=null)
			{rs.close(); rs = null;}
			
			resDs = new DataSet();
			rs = dbobject.executePreparedQuery(childRes.toString(), resParam);
			resDs.load(rs);
			request.setAttribute("childRes", resDs);
			
			if (rs!=null)
			{rs.close(); rs = null;}
			
			chkDs = new DataSet();
			chkList.append("select INDCTID, RESID, CHECKYN from TBLCOOLCHART where DEPTID=?");
			Object[] chkPa = {resid};
			rs = dbobject.executePreparedQuery(chkList.toString(), chkPa);
			System.out.println("resid      " + resid);
			chkDs.load(rs);
			request.setAttribute("chkList", chkDs);

			System.out.println(chkDs);
			if (rs!=null && ds != null)
			{rs.close(); ds=null; ds = new DataSet(); rs = null;}
			
			System.out.println(idx);
			
		}catch (SQLException se){
			request.setAttribute("result","false");
			System.out.println(se);
		} catch (Exception e){
			request.setAttribute("result","false");
			System.out.println(e);
		} finally {
			if (rs!=null){try{rs.close(); rs=null;}catch(Exception se){}}
		}
	}
}
