package com.nc.xml;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;
import com.nc.util.DataSet;

public class MeasureOrgUser {

	public MeasureOrgUser() {
		// TODO Auto-generated constructor stub
	}

	/*
	 * Method : getUserMeasure
	 * Desc   : 사용자에게 할당된 지표List를 가져옴.
	 */

	public void getUserMeasure(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year      = request.getParameter("year");
			String sbuid     = request.getParameter("sbuid")==null?"%":request.getParameter("sbuid");

			if (year==null) return;

			String groupId = (String)request.getSession().getAttribute("groupId");
			String userId  = (String)request.getSession().getAttribute("userId");

			int group = 1;

			if (groupId!=null) group = Integer.parseInt(groupId);
			if (group>3) return;

			if (group==1) userId="%";

			StringBuffer sb = new StringBuffer();
			Object[] params = null;

			sb.append(" select                                                                                   ");
			sb.append("         c.year,                                                                                        ");
			sb.append("         c.id cid, c.contentid ccid, cc.name cnm, c.treelevel clevel, c.rank crank, c.weight  cw,       ");
			sb.append("         s.id sid, s.contentid scid, sc.name snm, s.treelevel slevel, s.rank srank, s.weight  sw,       ");
			sb.append("         b.id bid, b.contentid bcid, bc.name bnm, b.treelevel blevel, b.rank brank, b.weight  bw,       ");
			sb.append("         p.id pid, p.contentid pcid, pc.name pnm, p.treelevel plevel, p.rank prank, p.weight  pw,       ");
			sb.append("         o.id oid, o.contentid ocid, oc.name onm, o.treelevel olevel, o.rank orank, o.weight  ow,       ");
			sb.append("         m.id mid, m.contentid mcid, mc.name mnm, m.treelevel mlevel, m.rank mrank, m.weight  mw,       ");
			sb.append("         md.measureid        mcode,                                                                     ");
			sb.append("         p.weight*o.weight*m.weight/(100*100*100)*100   mcw,                                            ");
			sb.append("         md.etlkey           etlkey,                                                                    ");
			sb.append("         md.frequency        freq  ,                                                                    ");
			sb.append("         md.unit             unit  ,                                                                    ");
			sb.append("         md.measurement      mment ,                                                                    ");
			sb.append("         md.trend            trend ,                                                                    ");
			sb.append("         md.entrytype        entrytype,                                                                 ");
			sb.append("         md.measuretype      meastype                                                                   ");
			sb.append(" from    tblhierarchy c, tblcompany   cc,                                                               ");
			sb.append("         tblhierarchy s, tblsbu       sc,                                                               ");
			sb.append("         tblhierarchy b, tblbsc       bc,                                                               ");
			sb.append("         tbltreescore p, tblpst       pc,                                                               ");
			sb.append("         tbltreescore o, tblobjective oc,                                                               ");
			sb.append("         tbltreescore m, tblmeasure   mc, tblmeasuredefine md                                           ");
			sb.append(" where   c.year = s.year(+) and c.treelevel = 0 and c.id = s.parentid(+) and c.contentid = cc.id(+)     ");
			sb.append(" and     s.year = b.year(+) and s.treelevel = 1 and s.id = b.parentid(+) and s.contentid = sc.id(+)     ");
			sb.append(" and     b.year = p.year(+) and b.treelevel = 2 and b.id = p.parentid(+) and b.contentid = bc.id(+)     ");
			sb.append(" and     p.year = o.year(+) and p.treelevel = 3 and p.id = o.parentid(+) and p.contentid = pc.id(+)     ");
			sb.append(" and     o.year = m.year(+) and o.treelevel = 4 and o.id = m.parentid(+) and o.contentid = oc.id(+)     ");
			sb.append(" and     m.treelevel = 5    and m.contentid = md.id(+) and md.measureid = mc.id(+)                      ");
			sb.append(" and     c.year = ?                                                                                ");
			sb.append(" and     s.id   like ?                                                                                ");
			sb.append(" and     md.id  in   (                                                                                  ");
			sb.append("                      select id        mcid from tblmeasuredefine where updateid like ?              ");
			sb.append("                      union                                                                          ");
			sb.append("                      select measureid mcid from tblauthority     where userid like ?                ");
			sb.append("                      )                                                                                 ");
			sb.append(" order by c.year desc, c.rank, c.id, s.rank, s.id, b.rank, b.id,                                        ");
			sb.append("                       p.rank, p.id, o.rank, o.id, m.rank, m.id			                               ");

	         params = new Object[] {year,sbuid,userId,userId};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}


	/*
	 * Method : getMeasUser
	 * Desc   : 사용자에게 할당된 지표List를 가져옴.
	 */

	public void getMeasUser(HttpServletRequest request, HttpServletResponse response) {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try {

			String year  = request.getParameter("year");
			String mcid  = request.getParameter("mcid");

			if (year==null) return;


			StringBuffer sb = new StringBuffer();
			Object[] params = null;

            sb.append(" select usertype, usertypenm, userid, f_getempnm(userid) usernm                                                                 ");
            sb.append(" from                                                                                                                        ");
            sb.append("       (                                                                                                                     ");
            sb.append("       select id        mcid, '1' usertype,'정' usertypenm, updateid userid from tblmeasuredefine where id = ?            ");
            sb.append("       union                                                                                                                 ");
            sb.append("       select measureid mcid, '2' usertype,'부' usertypenm, userid   userid from tblauthority     where measureid = ?     ");
            sb.append("       )                                                                                                                     ");
            sb.append(" order by usertype                                                                                                           ");


	        params = new Object[] {mcid,mcid};

			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);

			dbobject = new DBObject(conn.getConnection());

			rs = dbobject.executePreparedQuery(sb.toString(),params);

			DataSet ds = new DataSet();
			ds.load(rs);

			request.setAttribute("ds", ds);
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}



	 /**
     * Method Name : setMeasUser
     * Description : 지표의 담당자 등록
     * Autho       : PHG
     * Create Date : 2008-04-04
     * History	          :
     * @throws SQLException
     */
	public void setMeasUser(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }

			StringBuffer strSQL = new StringBuffer();

			// Loop를 돌며 Insert,Update,Delete...
			String year     = request.getParameter("year");
			String mcid     = request.getParameter("mcid");

			String userid = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";
			String tag    = request.getParameter("tag")!=null?request.getParameter("tag"):"";

			// 삭제후 처리...
			if ("U".equals(tag)||"D".equals(tag)){
				strSQL.append("DELETE TBLAUTHORITY WHERE YEAR=? AND MEASUREID=?  ");

				System.out.println("DELETE ....TAG : "+tag+ ", year : " + year + ", measureid : " + mcid );

				Object[] iPaD = {year, mcid};
				dbobject.executePreparedUpdate(strSQL.toString(), iPaD);
			}

			// Insert or Update....
			if ("U".equals(tag)){

				// 저장
				String   arrData = request.getParameter("arrData");
				String[] recData = arrData.split("`");

				for (int i = 0; i < recData.length; i++) {

							String[] iPart = recData[i].split(",");

							String vUserType     = iPart[0];
							String vUserId       = iPart[1];

							strSQL = new StringBuffer();

							// 1인경우 정, 2인경우
							if ("1".equals(vUserType)){
								  	strSQL.append(" update tblmeasuredefine set updateid = ? where id = ? " );
									Object[] iPa1 = {vUserId, mcid};
									dbobject.executePreparedUpdate(strSQL.toString(), iPa1);
							} else {

								strSQL.append(" INSERT INTO TBLAUTHORITY (YEAR,MEASUREID,USERID) VALUES (?,?,?) ") ;

								Object[] iPa = {year, mcid, vUserId};
								dbobject.executePreparedUpdate(strSQL.toString(), iPa);

							}	// key가 널이 아닌 경우만 입력
				}	// Loop End.

			} // if ~ end.

			conn.commit();
			request.setAttribute("result", "true");

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
	} //-- method setEvalOrg

	 /**
     * Method Name : setMeasUserAll
     * Description : 지표의 담당자 From To 변경
     * Autho       : PHG
     * Create Date : 2008-04-04
     * History	          :
     * @throws SQLException
     */
	public void setMeasUserAll(HttpServletRequest request, HttpServletResponse response){

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;

		try{
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			if(dbobject == null) {	dbobject = new DBObject(conn.getConnection()); }

			StringBuffer strSQL = new StringBuffer();

			// Loop를 돌며 Insert,Update,Delete...
			String year           = request.getParameter("year");
			String fromuserid     = request.getParameter("fromuserid");
			String touserid       = request.getParameter("touserid");

			System.out.println("setMeasUserAll - FROM  : " + fromuserid + " TO " + touserid);

			String userid = (String)request.getSession().getAttribute("userId")!=null?(String)request.getSession().getAttribute("userId"):"";

			// 지표담당자(부) 신규등록후 기존 것 삭제.
			strSQL.append(" insert into tblauthority (year,measureid,userid)         ");
			strSQL.append(" select year,measureid, ?                                 ");
			strSQL.append(" from   tblauthority where year=? and userid=? and userid <> ?  ");

			Object[] iPaI = {touserid, year,  fromuserid, touserid};
			dbobject.executePreparedUpdate(strSQL.toString(), iPaI) ;

			strSQL = new StringBuffer();
			strSQL.append("DELETE tblauthority WHERE YEAR=? AND USERID=?  ");
			Object[] iPaD = {year, fromuserid};
			dbobject.executePreparedUpdate(strSQL.toString(), iPaD) ;


			// 지표정의서
			strSQL = new StringBuffer();

			strSQL.append(" update tblmeasuredefine set updateid = ?                                                                   ");
			strSQL.append(" where  id in (                                                                                             ");
			strSQL.append(" 		select  mcid from (                                                                                    ");
			strSQL.append(" 		select                                                                                                 ");
			strSQL.append(" 		        c.year,                                                                                        ");
			strSQL.append(" 		        c.id cid, c.contentid ccid, cc.name cnm, c.treelevel clevel, c.rank crank, c.weight  cw,       ");
			strSQL.append(" 		        s.id sid, s.contentid scid, sc.name snm, s.treelevel slevel, s.rank srank, s.weight  sw,       ");
			strSQL.append(" 		        b.id bid, b.contentid bcid, bc.name bnm, b.treelevel blevel, b.rank brank, b.weight  bw,       ");
			strSQL.append(" 		        p.id pid, p.contentid pcid, pc.name pnm, p.treelevel plevel, p.rank prank, p.weight  pw,       ");
			strSQL.append(" 		        o.id oid, o.contentid ocid, oc.name onm, o.treelevel olevel, o.rank orank, o.weight  ow,       ");
			strSQL.append(" 		        m.id mid, m.contentid mcid, mc.name mnm, m.treelevel mlevel, m.rank mrank, m.weight  mw,       ");
			strSQL.append(" 		        md.measureid        mcode,                                                                     ");
			strSQL.append(" 		        p.weight*o.weight*m.weight/(100*100*100)*100   mcw,                                            ");
			strSQL.append(" 		        md.etlkey           etlkey,                                                                    ");
			strSQL.append(" 		        md.frequency        freq  ,                                                                    ");
			strSQL.append(" 		        md.unit             unit  ,                                                                    ");
			strSQL.append(" 		        md.updateid         mment ,                                                                    ");
			strSQL.append(" 		        md.trend            updateid                                                                   ");
			strSQL.append(" 		from    tblhierarchy c, tblcompany   cc,                                                               ");
			strSQL.append(" 		        tblhierarchy s, tblsbu       sc,                                                               ");
			strSQL.append(" 		        tblhierarchy b, tblbsc       bc,                                                               ");
			strSQL.append(" 		        tbltreescore p, tblpst       pc,                                                               ");
			strSQL.append(" 		        tbltreescore o, tblobjective oc,                                                               ");
			strSQL.append(" 		        tbltreescore m, tblmeasure   mc, tblmeasuredefine md                                           ");
			strSQL.append(" 		where   c.year = s.year(+) and c.treelevel = 0 and c.id = s.parentid(+) and c.contentid = cc.id(+)     ");
			strSQL.append(" 		and     s.year = b.year(+) and s.treelevel = 1 and s.id = b.parentid(+) and s.contentid = sc.id(+)     ");
			strSQL.append(" 		and     b.year = p.year(+) and b.treelevel = 2 and b.id = p.parentid(+) and b.contentid = bc.id(+)     ");
			strSQL.append(" 		and     p.year = o.year(+) and p.treelevel = 3 and p.id = o.parentid(+) and p.contentid = pc.id(+)     ");
			strSQL.append(" 		and     o.year = m.year(+) and o.treelevel = 4 and o.id = m.parentid(+) and o.contentid = oc.id(+)     ");
			strSQL.append(" 		and     m.treelevel = 5    and m.contentid = md.id(+) and md.measureid = mc.id(+)                      ");
			strSQL.append(" 		and     c.year = ?                                                                                ");
			strSQL.append(" 		and     md.updateid = ?                                                                          ");
			strSQL.append(" 		order by c.year desc, c.rank, c.id, s.rank, s.id, b.rank, b.id,                                        ");
			strSQL.append(" 		                      p.rank, p.id, o.rank, o.id, m.rank, m.id                                         ");
			strSQL.append(" 		)                                                                                                      ");
			strSQL.append(" )                                                                                                          ");

			Object[] iPa = {touserid, year, fromuserid};
			dbobject.executePreparedUpdate(strSQL.toString(), iPa);

			conn.commit();
			request.setAttribute("result", "true");

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
	} //-- method setEvalOrg
}