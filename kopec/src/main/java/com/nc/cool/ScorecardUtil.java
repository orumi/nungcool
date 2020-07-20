package com.nc.cool;

import java.io.DataOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Vector;

import com.nc.sql.CoolConnection;
import com.nc.util.*;
import com.nc.math.*;

public class ScorecardUtil extends DBObject {

	public ScorecardUtil(Connection connection) {
		super(connection);
	}

	public static void getMeasureDefine(DBObject dbobject, DataOutputStream out, String year, int id)
	throws IOException, SQLException, Exception{
		ResultSet rs = null;
		try {
			StringBuffer sql = new StringBuffer();
			sql.append("select t.id mid,t.parentid mpid,t.contentid mcid, t.weight mweight, t.treelevel mlevel, t.orderid morder, o.shortname mname, ")
				.append(" a.id,a.measureid,a.updaterid,(select name from c_user where id=a.updaterid) as updatername,a.entrytype, ")
				.append(" a.measuretype,a.summarytype,a.frequency,a.equation, a.etlkey,")
				.append(" d.detaildefine,d.eval_s,d.eval_a,d.eval_b,d.eval_c,d.i_s,d.i_a,d.i_b,d.i_c,d.score_s,d.score_a,d.score_b,d.score_c, ")
				.append(" d.targetdefine,d.yb2,d.yb1,d.y,d.ya1,d.ya2,d.ya3,d.ya4,d.m1,d.m2,d.m3,d.m4,d.m5,d.m6,d.m7,d.m8,d.m9,d.m10,d.m11,d.m12,d.eval_frequency,d.trend ")
				.append(" from viewscorecard t, a_measure a, tbl_measuredefine d, c_measure o  ")
				.append(" where a.measureid=o.id and t.contentid=a.id and a.id=d.ameasureid and t.treelevel=5 and t.parentid=? and t.yyyy=? order by mid,morder");
			Object[] params = {new Integer(id),year};
			rs = dbobject.executePreparedQuery(sql.toString(), params);

			while(rs.next()){
				out.writeBoolean(true);
				out.writeInt(rs.getInt("mid"));
				out.writeInt(rs.getInt("id"));
				out.writeInt(rs.getInt("measureid"));
				out.writeUTF(rs.getString("mname"));
				out.writeDouble(rs.getDouble("mweight"));
				out.writeInt(rs.getInt("updaterid"));
				out.writeUTF(rs.getString("updatername")!=null?rs.getString("updatername"):"");
				out.writeUTF(rs.getString("entryType"));
				out.writeUTF(rs.getString("summarytype")!=null?rs.getString("summarytype"):"");
				out.writeUTF(rs.getString("measureType"));
				out.writeUTF(rs.getString("frequency"));
				out.writeUTF(rs.getString("equation")!=null?rs.getString("equation"):"");
				out.writeUTF(rs.getString("etlkey")!=null?rs.getString("etlkey"):"");
				out.writeUTF(rs.getString("detaildefine")!=null?rs.getString("detaildefine"):"");
				out.writeDouble(rs.getDouble("eval_s"));
				out.writeDouble(rs.getDouble("eval_a"));
				out.writeDouble(rs.getDouble("eval_b"));
				out.writeDouble(rs.getDouble("eval_c"));
				out.writeInt(rs.getInt("i_s"));
				out.writeInt(rs.getInt("i_a"));
				out.writeInt(rs.getInt("i_b"));
				out.writeInt(rs.getInt("i_c"));
				out.writeDouble(rs.getDouble("score_s"));
				out.writeDouble(rs.getDouble("score_a"));
				out.writeDouble(rs.getDouble("score_b"));
				out.writeDouble(rs.getDouble("score_c"));
				out.writeUTF(rs.getString("targetdefine")!=null?rs.getString("targetdefine"):"");
				out.writeUTF(rs.getString("yb2")!=null?rs.getString("yb2"):"");
				out.writeUTF(rs.getString("yb1")!=null?rs.getString("yb1"):"");
				out.writeUTF(rs.getString("y")!=null?rs.getString("y"):"");
				out.writeUTF(rs.getString("ya1")!=null?rs.getString("ya1"):"");
				out.writeUTF(rs.getString("ya2")!=null?rs.getString("ya2"):"");
				out.writeUTF(rs.getString("ya3")!=null?rs.getString("ya3"):"");
				out.writeUTF(rs.getString("ya4")!=null?rs.getString("ya4"):"");
				out.writeUTF(rs.getString("m1")!=null?rs.getString("m1"):"");
				out.writeUTF(rs.getString("m2")!=null?rs.getString("m2"):"");
				out.writeUTF(rs.getString("m3")!=null?rs.getString("m3"):"");
				out.writeUTF(rs.getString("m4")!=null?rs.getString("m4"):"");
				out.writeUTF(rs.getString("m5")!=null?rs.getString("m5"):"");
				out.writeUTF(rs.getString("m6")!=null?rs.getString("m6"):"");
				out.writeUTF(rs.getString("m7")!=null?rs.getString("m7"):"");
				out.writeUTF(rs.getString("m8")!=null?rs.getString("m8"):"");
				out.writeUTF(rs.getString("m9")!=null?rs.getString("m9"):"");
				out.writeUTF(rs.getString("m10")!=null?rs.getString("m10"):"");
				out.writeUTF(rs.getString("m11")!=null?rs.getString("m11"):"");
				out.writeUTF(rs.getString("m12")!=null?rs.getString("m12"):"");
				out.writeUTF(rs.getString("eval_frequency")!=null?rs.getString("eval_frequency"):"");
				out.writeUTF(rs.getString("trend")!=null?rs.getString("trend"):"");
			}
			out.writeBoolean(false);

		} catch (IOException ie){
			System.out.println(ie);
			throw ie;
		} catch (SQLException se){
			System.out.println(se);
			throw se;
		} catch (Exception e) {
			System.out.println(e);
			throw e;
		} finally {
			if (rs != null) {rs.close(); rs = null;}
		}
	}

	public static void getMeasureDetail(DBObject dbobject, DataOutputStream out, String year, int id)
		throws SQLException, IOException{
		ResultSet rs = null;
		try{
			StringBuffer sql = new StringBuffer();
			sql.append("select d.measureid,to_char(d.effectivedate,'YYYYMMDD') strdate,d.actual,d.weighting, d.planned,d.best,d.worst,d.benchmark,d.bau,s.score from ")
				.append(" (select * from a_measuredetail where (to_char(effectivedate,'YYYY')) = ? and measureid=? ) d  ")
				.append(" left join ")
				.append(" (select score, measureid, effectivedate from a_measurescore where (to_char(effectivedate,'YYYY'))=? and measureid=?) s ")
				.append(" on d.measureid=s.measureid and d.effectivedate=s.effectivedate ")
				.append(" order by d.effectivedate ");
			Integer integer = new Integer(id);
			Object[] params = {year, integer, year, integer};

			rs = dbobject.executePreparedQuery(sql.toString(), params);

			while(rs.next()){
				out.writeBoolean(true);
				out.writeInt(rs.getInt("measureid"));
				out.writeUTF(rs.getString("strdate"));
				out.writeDouble(rs.getDouble("actual"));
				out.writeDouble(rs.getDouble("weighting"));
				out.writeDouble(rs.getDouble("planned"));
				out.writeDouble(rs.getDouble("best"));
				out.writeDouble(rs.getDouble("worst"));
				out.writeDouble(rs.getDouble("benchmark"));
				out.writeDouble(rs.getDouble("bau"));
				out.writeDouble(rs.getDouble("score"));
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

	public int saveDefine(MeasureDefine define) throws SQLException{
		int reval = -1;
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("insert into a_measure (id, measureid, updaterid,weighting,entrytype,measuretype,summarytype,frequency,equation,etlkey,concurrencyid) ")
				.append(" values (?,?,?,?,?,?,?,?,?,?,0) ");
			Object[] params = new Object[10];
			params[0] = new Integer(getNextDefineId());
			params[1] = new Integer(define.measureid);
			params[2] = new Integer(define.updaterid);
			params[3] = new Double(define.weighting);
			params[4] = define.entryType;
			params[5] = define.measureType;
			params[6] = define.summaryType;
			params[7] = define.frequency;
			params[8] = define.equation;
			params[9] = define.etlkey;

			int i = executePreparedUpdate(sb.toString(),params);
			if (i>0){
				reval = ((Integer)params[0]).intValue();
				StringBuffer sb1 = new StringBuffer();
				sb1.append("insert into tbl_measuredefine (ameasureid, detaildefine,eval_s,eval_a,eval_b,eval_c,i_s,i_a,i_b,i_c, ")
					.append(" score_s,score_a,score_b,score_c,targetdefine,yb2,yb1,y,ya1,ya2,ya3,ya4,m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,eval_frequency,trend)  ")
					.append(" values (?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?) ");
				Object[] p1 = new Object[36];
				p1[0]= params[0];p1[1]=define.detaildefine;
				p1[2]=new Double(define.eval_s);p1[3]=new Double(define.eval_a);p1[4]=new Double(define.eval_b);p1[5]=new Double(define.eval_c);
				p1[6]=new Integer(define.i_s);p1[7]=new Integer(define.i_a);p1[8]=new Integer(define.i_b);p1[9]=new Integer(define.i_c);
				p1[10]=new Double(define.score_s);p1[11]=new Double(define.score_a);p1[12]=new Double(define.score_b);p1[13]=new Double(define.score_c);
				p1[14]=define.targetdefine;p1[15]=define.yb2;p1[16]=define.yb1;p1[17]=define.y;p1[18]=define.ya1;p1[19]=define.ya2;
				p1[20]=define.ya3;p1[21]=define.ya4;
				p1[22]=define.m[0];p1[23]=define.m[1];p1[24]=define.m[2];p1[25]=define.m[3];p1[26]=define.m[4];p1[27]=define.m[5];
				p1[28]=define.m[6];p1[29]=define.m[7];p1[30]=define.m[8];p1[31]=define.m[9];p1[32]=define.m[10];p1[33]=define.m[11];
				p1[34]=define.eval_frequency;p1[35]=define.trend;
				executePreparedUpdate(sb1.toString(),p1);

				if (define.itemList.size()>0){
					StringBuffer sb2 = new StringBuffer();
					sb2.append("insert into tbl_measureitem (ameasureid,code,name) values (?,?,?)");
					Object[] p2 = new Object[3];
					for (int j = 0; j < define.itemList.size(); j++) {
						MeasureItem item = (MeasureItem)define.itemList.get(j);
						p2[0] = params[0];
						p2[1] = item.code;
						p2[2] = item.name;
						executePreparedUpdate(sb2.toString(),p2);
					}
				}

				String str = "DELETE FROM measuredependent WHERE parentId = ?";
	            i = executePreparedUpdate(str,new Object[]{params[0]});

	            if((define.entryType).equals("계산된 값")) {
	                String equation = define.equation;
	                try{
		                if(!equation.equals("")) {
		                    ExpressionParser expressionparser = new ExpressionParser(equation);
		                    Expression expression = expressionparser.getCompleteExpression();
		                    Vector vector = new Vector();
		                    expression.addUnknowns(vector);
		                    int j = vector.size();
		                    for(int i1 = 0; i1 < j; i1++) {
		                        String s = (String)vector.get(i1);
		                        int l = getVarMeasureId(s);

		                        Object[] params4 = new Object[] {params[0], new Integer(l)};

		            	        String str1 = "DECLARE parentId_ INTEGER; childId_ INTEGER; cnt INTEGER; "
		            	        					+ "BEGIN parentId_ := ?; childId_  := ?; "
		            	        					+ "SELECT COUNT(1) INTO cnt FROM measuredependent "
		            	        					+ "WHERE parentId = parentId_ AND childId = childId_; "
		            	        					+ "IF cnt = 0 THEN INSERT INTO measuredependent(parentId, childId) "
		            	        					+ "VALUES(parentId_, childId_); COMMIT; END IF; END;";

		            	        i = executePreparedUpdate(str1,params4);

		            		}
		                }
	                } catch (Exception e) {
	                	throw new Exception("산식 유효성 실패 ");
	                }
	            }
			}


			reval = ((Integer)params[0]).intValue();

		} catch (SQLException se){
			System.out.println(se);
			throw se;
		} catch (Exception e) {
			System.out.println(e);
		}
		return reval;
	}

	public int getNextDefineId() throws SQLException{
		ResultSet rs = null;
		try {
			String sql = "select max(id)+1 as nid from a_measure";
			rs = executeQuery(sql);
			if (rs.next()) return rs.getInt("nid");
		} catch (Exception e) {

		} finally {
			if(rs !=null){rs.close(); rs = null;}
		}
		return 0;
	}

	public int updateDefine(MeasureDefine define) throws SQLException{
		int reval = -1;
		try {
			StringBuffer sb = new StringBuffer();
			sb.append("update a_measure set updaterid=?,weighting=?,entrytype=?,measuretype=?,summarytype=?,frequency=?,equation=?,etlkey=? where id=?");
			Object[] params = new Object[9];
			params[0] = new Integer(define.updaterid);
			params[1] = new Double(define.weighting);
			params[2] = define.entryType;
			params[3] = define.measureType;
			params[4] = define.summaryType;
			params[5] = define.frequency;
			params[6] = define.equation;
			params[7] = define.etlkey;
			params[8] = new Integer(define.id);

			int i = executePreparedUpdate(sb.toString(),params);
			if (i>0){
				reval = define.id;
				StringBuffer sb1 = new StringBuffer();
				sb1.append("update tbl_measuredefine set detaildefine=?,eval_s=?,eval_a=?,eval_b=?,eval_c=?,i_s=?,i_a=?,i_b=?,i_c=?,")  //9
					.append("score_s=?,score_a=?,score_b=?,score_c=?,targetdefine=?,m1=?,m2=?,m3=?,m4=?,m5=?,m6=?,m7=?,m8=?,m9=?,m10=?,m11=?,m12=?,")  //17
					.append("eval_frequency=?,trend=?,yb2=?,yb1=?,y=?,ya1=?,ya2=?,ya3=?,ya4=? where ameasureid=?"); //10
				Object[] p1 = new Object[36];
				p1[0]=define.detaildefine;
				p1[1]=new Double(define.eval_s);p1[2]=new Double(define.eval_a);p1[3]=new Double(define.eval_b);p1[4]=new Double(define.eval_c);
				p1[5]=new Integer(define.i_s);p1[6]=new Integer(define.i_a);p1[7]=new Integer(define.i_b);p1[8]=new Integer(define.i_c);
				p1[9]=new Double(define.score_s);p1[10]=new Double(define.score_a);p1[11]=new Double(define.score_b);p1[12]=new Double(define.score_c);
				p1[13]=define.targetdefine;
				p1[14]=define.m[0];p1[15]=define.m[1];p1[16]=define.m[2];p1[17]=define.m[3];p1[18]=define.m[4];p1[19]=define.m[5];
				p1[20]=define.m[6];p1[21]=define.m[7];p1[22]=define.m[8];p1[23]=define.m[9];p1[24]=define.m[10];p1[25]=define.m[11];
				p1[26]=define.eval_frequency;p1[27]=define.trend;
				p1[28]=define.yb2;p1[29]=define.yb1;p1[30]=define.y;p1[31]=define.ya1;p1[32]=define.ya2;
				p1[33]=define.ya3;p1[34]=define.ya4;

				p1[35]= new Integer(define.id);
				executePreparedUpdate(sb1.toString(),p1);
			}

			StringBuffer sb2 = new StringBuffer("delete from tbl_measureitem where ameasureid=?");
			Object[] p2 = new Object[] {new Integer(define.id)};
			executePreparedUpdate(sb2.toString(),p2);

			if (define.itemList.size()>0){
				StringBuffer sb3 = new StringBuffer();
				sb3.append("insert into tbl_measureitem (ameasureid,code,name) values (?,?,?)");
				Object[] p3 = new Object[3];
				for (int j = 0; j < define.itemList.size(); j++) {
					MeasureItem item = (MeasureItem)define.itemList.get(j);
					p3[0] = new Integer(define.id);
					p3[1] = item.code;
					p3[2] = item.name;
					executePreparedUpdate(sb3.toString(),p3);
				}
			}

			String str = "DELETE FROM measuredependent WHERE parentId = ?";
            i = executePreparedUpdate(str,new Object[]{new Integer(define.id)});

            if((define.entryType).equals("계산된 값")) {
                String equation = define.equation;
                try{
	                if(!equation.equals("")) {
	                    ExpressionParser expressionparser = new ExpressionParser(equation);
	                    Expression expression = expressionparser.getCompleteExpression();
	                    Vector vector = new Vector();
	                    expression.addUnknowns(vector);
	                    int j = vector.size();
	                    for(int i1 = 0; i1 < j; i1++) {
	                        String s = (String)vector.get(i1);
	                        int l = getVarMeasureId(s);

	                        Object[] params4 = new Object[] {new Integer(define.id), new Integer(l)};

	            	        String str1 = "DECLARE parentId_ INTEGER; childId_ INTEGER; cnt INTEGER; "
	            	        					+ "BEGIN parentId_ := ?; childId_  := ?; "
	            	        					+ "SELECT COUNT(1) INTO cnt FROM measuredependent "
	            	        					+ "WHERE parentId = parentId_ AND childId = childId_; "
	            	        					+ "IF cnt = 0 THEN INSERT INTO measuredependent(parentId, childId) "
	            	        					+ "VALUES(parentId_, childId_); COMMIT; END IF; END;";

	            	        i = executePreparedUpdate(str1,params4);

	            		}
	                }
                } catch (Exception e) {
                	throw new Exception("산식 유효성 실패 ");
                }
            }
			reval = define.id;

		} catch (SQLException se){
			System.out.println(se);
			throw se;
		} catch (Exception e) {
			System.out.println(e);
		}
		return reval;
	}

	public int deleteDefine(int defineid) throws SQLException{
		int reval = -1;
		try {
			Object[] p = new Object[] {new Integer(defineid)};

			String str = "DELETE FROM measuredependent WHERE parentId = ?";
            executePreparedUpdate(str,p);

			StringBuffer s1 = new StringBuffer("delete from tbl_measureitem where ameasureid=?");
			executePreparedUpdate(s1.toString(),p);

			StringBuffer s2 = new StringBuffer("delete from tbl_measuredefine where ameasureid=?");
			executePreparedUpdate(s2.toString(),p);

			StringBuffer s3 = new StringBuffer("delete from a_measure where id=?");
			reval = executePreparedUpdate(s3.toString(),p);

		} catch (SQLException se){
			System.out.println(se);
			throw se;
		} catch (Exception e) {
			System.out.println(e);
		}
		return reval;
	}

    public static int getVarMeasureId(String s) throws Exception{
	    if(s.startsWith("ID"))
	        try {
	            return Integer.parseInt(s.substring(2));
	        } catch(Exception exception) {
	            throw new Exception(exception);
	        }
	        return 0;
	}

	public void importStructure(Importer dataimporter, HashMap rtnMap) {
		/*  처리과정
		 * 1. Import 필드 유효성 검사
		 * 2. 반복
		 * 		2.1 기초정보 코드 가져온다. (저장 여부)
		 * 			2.1.1 코드가 없으면 (저장이 안 되어 있으면) 저장.
		 * 		2.2 행당되는 조직 레벨에 등록이 되어 있는지 확인.
		 * 			2.2.1 등록이 안 되어 있으면 등록. (treeIndex에도 동시에 적용)
		 * 		2.3 지표 저장시
		 * 3. 처리 결과 리턴.
		 */


		//반드시 필요한 필드 목록
		String[] fields = {
				"year","company","companyweight","sbu","sbuweight","bsc","bscweight","pst","pstweight","obj",
				"objweight","measure","measureupdater","weighting","frequency","measurement","etlkey","trend" };

		String[] fullFields = {
				"year","company","companyweight","sbu","sbuweight","bsc","bscweight","pst","pstweight","obj",                              // 10
				"objweight","measure","measureupdater","weighting","frequency","mean","measuredefine","unit","measurement","etlkey",       // 20
				"trend","equationdefine","equation","planned","plannedbase", "base","baselimit","limit","datasource","ifsystem",           // 30
				"mngdeptnm","targetrationle", "y","yb1","yb2","yb3","ya1","ya2","ya3","ya4",                                               // 40
				"measureshare",
				"plannedbaseplus","baseplus","baselimitplus","limitplus"                                         // index 41 42 43 44
				};

		// 필드 유효성 검사
		System.out.println("checking Fields....");
		for (int i1=0; i1<fields.length;i1++){
			if ((dataimporter.getColumnIndex(fields[i1])) < 0 ) {
				rtnMap.put("error"," REQUIRED FIELD is Nothing : "+fields[i1]);
				return;
			}
		}

		try {
			for (dataimporter.resetCursor();dataimporter.next();) {
				setHierarchy(dataimporter, fullFields, rtnMap);   /// with on line update for row count;;;
			}
			System.out.println("Import End...");

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			rtnMap.put("count", String.valueOf(dataimporter.getRowCount()-1));
		}

	}
	private void setHierarchy(Importer importer, String[] fullFields, HashMap rtnMap) throws SQLException, Exception{
		String field = null;
		String comName = null;
		try{
			/*  company */
			field=fullFields[1];     // company component
			comName = importer.getString(field).trim();
			if ("".equals(comName)) throw new Exception("Company Name is nothing");
			int comid = getComponentId(comName,"TBLCOMPANY");
			String comId = null;
			if (comid == -1){
				HashMap hsmap = new HashMap();
				hsmap.put("NAME","'"+comName+"'");
				hsmap.put("INPUTDATE",Util.getToDayTime());
				comId = insertComponent("TBLCOMPANY", hsmap, "C");
			} else {
				comId = String.valueOf(comid);
			}

			field="TBLCOMPANY Hierarchy";   // company Hierarchy
			HashMap hm = new HashMap();
			hm.put("contentId",comId);
			hm.put("parentId",String.valueOf(0));
			hm.put("treelevel",String.valueOf(0));
			field=fullFields[2];
			hm.put("weight",importer.getString(field));
			hm.put("rank",Integer.toString(importer.getCursor()*10));
			hm.put("year",importer.getString("year"));

			String comHid = updateHierarchy("TBLHIERARCHY",hm);

			if (comHid == null) throw new Exception("Company Hierarchy id nothing");

			/*  sbu */
			field = fullFields[3];  // SBU Component
			comName = importer.getString(field).trim();
			if ("".equals(comName)) throw new Exception("SBU Name is nothing");
			int sbuid = getComponentId(comName,"TBLSBU");   /// field name ex company
			String sbuId = null;
			if (sbuid == -1){
				HashMap hsmap = new HashMap();
				hsmap.put("NAME","'"+comName+"'");
				hsmap.put("INPUTDATE",Util.getToDayTime());
				sbuId = insertComponent("TBLSBU",hsmap, "S");     ///alias field Name ex company
			} else {
				sbuId = String.valueOf(sbuid);                                          // content code;
			}

			field="TBLSBU Hierarchy";
			hm.clear();
			hm.put("contentId",sbuId);                                             		//  contentID;;;
			hm.put("parentId",comHid);                                           		/// 상위 조직 코드;
			hm.put("treelevel",String.valueOf(1));                             			//  tree level;
			field = fullFields[4];                                                      //  weight
			hm.put("weight",importer.getString(field));
			hm.put("rank",Integer.toString(importer.getCursor()*10));
			hm.put("year",importer.getString("year"));

			String sbuHid = updateHierarchy("TBLHIERARCHY",hm);

			if (sbuHid == null) throw new Exception(" SBU Hierarchy id nothing ");

			/*  bsc */
			field=fullFields[5];
			comName = importer.getString(field).trim();
			if ("".equals(comName)) throw new Exception("BSC Name is nothing");
			int bscid = getComponentId(comName,"TBLBSC");   								// (기초정보명, 테이블명)
			String bscId = null;                                                                                   // 기초정보 코드
			if (bscid == -1){
				HashMap hsmap = new HashMap();
				hsmap.put("NAME","'"+comName+"'");                          // link name es companyLink
				hsmap.put("INPUTDATE",Util.getToDayTime());
				bscId = insertComponent("TBLBSC",hsmap, "B");     						///  (tblName, map, alias prefix)  alias field Name ex company
			} else {
				bscId = String.valueOf(bscid);                                              // content code;
			}
			String bscHid = null;

			field="BSC Hierarchy";
			hm.clear();
			hm.put("contentId",bscId);                                             			//  contentID;;;
			hm.put("parentId",sbuHid);                                           			/// ************상위 조직 코드;
			hm.put("treelevel",String.valueOf(2));                             				// tree level;
			field = fullFields[6];
			hm.put("weight",importer.getString(field));        								// weight
			hm.put("rank",Integer.toString(importer.getCursor()*10));
			hm.put("year",importer.getString("year"));

			bscHid = updateHierarchy("TBLHIERARCHY",hm);

			if (bscHid == null) throw new Exception(" BSC Hierarchy id nothing ");

			/*  PST */
			field = fullFields[7];
			comName = importer.getString(field).trim();
			if ("".equals(comName)) throw new Exception("PST Name is nothing");
			int pstid = getComponentId(comName,"TBLPST");   				// (기초정보명, 테이블명)
			String pstId = null;                                                                                   // 기초정보 코드
			if (pstid == -1){                                                                                        // 기초정보가 없으면.
				HashMap hsmap = new HashMap();
				String name = importer.getString(fullFields[15]);
				hsmap.put("NAME","'"+comName+"'");                          					// link name es companyLink
				hsmap.put("INPUTDATE",Util.getToDayTime());
				pstId = insertComponent("TBLPST",hsmap, "P");     						     //  (tblName, map, alias prefix)  alias field Name ex company
			} else {
				pstId = String.valueOf(pstid);                                              // content code*************pstid=(pstid);
			}
			String pstHid = null;

			field="PST Hierarchy";
			hm.clear();
			hm.put("contentId",pstId);                                             			//  contentID;;;
			hm.put("parentId",bscHid);                                           			/// ************상위 조직 코드;
			hm.put("treelevel",String.valueOf(3));                             				// tree level;
			field = fullFields[8];
			hm.put("weight",importer.getString(field));        								// weight
			hm.put("rank",Integer.toString(importer.getCursor()*10));
			hm.put("year",importer.getString("year"));

			pstHid = updateHierarchy("TBLTREESCORE",hm);


			if (pstHid == null) throw new Exception(" PST Hierarchy id nothing ");

			/*  Objective */
			field = fullFields[9];
			comName = importer.getString(field).trim();
			if ("".equals(comName)) throw new Exception("Object Name is nothing");
			int objid = getComponentId(comName,"TBLOBJECTIVE");   		// (기초정보명, 테이블명)
			String objId = null;                                                                                   // 기초정보 코드
			if (objid == -1){                                                                                        // 기초정보가 없으면.
				HashMap hsmap = new HashMap();
				hsmap.put("NAME","'"+comName+"'");                          // link name es companyLink
				hsmap.put("INPUTDATE",Util.getToDayTime());

				objId = insertComponent("TBLOBJECTIVE",hsmap, "O");     			///  (tblName, map, alias prefix)  alias field Name ex company
			} else {
				objId = String.valueOf(objid);                                              // content code*************pstid=(pstid);
			}
			String objHid = null;
			field="Object Hierarchy";
			hm.clear();
			hm.put("contentId",objId);                                             			//  contentID;;;
			hm.put("parentId",pstHid);                                           			/// ************상위 조직 코드;
			hm.put("treelevel",String.valueOf(4));                             				// tree level;
			field = fullFields[10];
			hm.put("weight",importer.getString(field));        								// weight
			hm.put("rank",Integer.toString(importer.getCursor()*10));
			hm.put("year",importer.getString("year"));

			objHid = updateHierarchy("TBLTREESCORE",hm);


			if (objHid == null) throw new Exception(" Objective Hierarchy id nothing ");

			/*  Measure */
			field = fullFields[11];
			int measureid = getComponentId(importer.getString(field),"TBLMEASURE");   // (기초정보명, 테이블명)
			String measureId = null;                                                                                   // 기초정보 코드
			if (measureid == -1){                                                                                        // 기초정보가 없으면.
				HashMap hsmap = new HashMap();
				String kind = "고유".equals(importer.getString(fullFields[34]))?"I":"C";
				hsmap.put("NAME","'"+importer.getString(field)+"'");                          // link name es companyLink
				hsmap.put("INPUTDATE",Util.getToDayTime());
				hsmap.put("MEASCHAR","'"+kind+"'");
				measureId = insertComponent("TBLMEASURE",hsmap, "M");     ///  (tblName, map, alias prefix)  alias field Name ex company
			} else {
				measureId = String.valueOf(measureid);                                              // content code*************pstid=(pstid);
			}

			System.out.println("Measure : " + measureId + " : " + importer.getString(field));

			field = fullFields[12];
			//String updateid = getUserId(importer.getString(field));
			String updateid = importer.getString(field);  // 사요자 정보 임시 적용 됨.
			if ((updateid == null)) throw new Exception("Measure UpdaterId is null ");

			HashMap define = new HashMap();

			String weight = importer.getString(fullFields[13]);
			define.put("weight", weight);

			String frequency = importer.getString(fullFields[14]);
			if ((frequency==null)||("".equals(frequency))) throw new Exception("frequency 값이 없습니다.");
			if (!(("월".equals(frequency))||("분기".equals(frequency))||("반기".equals(frequency))||("년".equals(frequency))))
				throw new Exception(" 입력주기는 월,분기,반기,년입니다.");
			define.put("frequency","'"+frequency+"'");

			String mean = importer.getString(fullFields[15]);
			if ((mean !=null)&&(!"".equals(mean))) define.put("MEAN","'"+mean+"'");
			String measuredefine = importer.getString(fullFields[16]);
			if(( measuredefine != null)&&(!"".equals(measuredefine))) {
				measuredefine = measuredefine.replaceAll("'","\"");
				measuredefine = measuredefine.replaceAll("\n","\r");
				define.put("DETAILDEFINE","'"+measuredefine+"'");
			}

			define.put("year","'"+importer.getString("year")+"'");

			String unit = importer.getString(fullFields[17]);
			if((unit != null)&&(!"".equals(unit))) define.put("unit","'"+unit+"'");

			String measurement = importer.getString(fullFields[18]);
			if ((measurement!=null)&&(!"".equals(measurement))) define.put("MEASUREMENT","'"+measurement+"'");
			String etlkey = importer.getString(fullFields[19]);
			if((etlkey != null)&&(!"".equals(etlkey))) define.put("ETLKEY","'"+etlkey+"'");

			String trend = importer.getString(fullFields[20]);
			if ((trend==null)||("".equals(trend))) throw new Exception("trend 값이 없습니다.");
			if (!(("상향".equals(trend))||("하향".equals(trend))))
				throw new Exception("trend : 상향, 하향");
			define.put("trend","'"+trend+"'");


			define.put("updateid","'"+String.valueOf(updateid)+"'");

			String equationdefine = importer.getString(fullFields[21]);
			if((equationdefine != null)&&(!"".equals(equationdefine))) {
				equationdefine = equationdefine.replaceAll("\n","\r");
				define.put("EQUATIONDEFINE","'"+equationdefine+"'");
			}
			String equation = importer.getString(fullFields[22]);
			if((equation != null)&&(!"".equals(equation))) define.put("EQUATION","'"+equation+"'");
			String planned = importer.getString(fullFields[23]);
			if((planned != null)&&(!"".equals(planned))) define.put("PLANNED",planned);


			String plannedbase = importer.getString(fullFields[24]);
			if((plannedbase != null)&&(!"".equals(plannedbase))) define.put("PLANNEDBASE",plannedbase);
			String base = importer.getString(fullFields[25]);
			if((base != null)&&(!"".equals(base))) define.put("BASE",base);
			String baselimit = importer.getString(fullFields[26]);
			if((baselimit != null)&&(!"".equals(baselimit))) define.put("BASELIMIT",baselimit);

			String limit = importer.getString(fullFields[27]);
			if((limit != null)&&(!"".equals(limit))) define.put("LIMIT",limit);

			String datasource = importer.getString(fullFields[28]);
			if((datasource != null)&&(!"".equals(datasource))) define.put("DATASOURCE","'"+datasource+"'");

			String ifsystem = importer.getString(fullFields[29]);
			if((ifsystem != null)&&(!"".equals(ifsystem))) define.put("IFSYSTEM","'"+ifsystem+"'");

			String mngdeptnm = importer.getString(fullFields[30]);
			if((mngdeptnm != null)&&(!"".equals(mngdeptnm))) define.put("MNGDEPTNM","'"+mngdeptnm+"'");

			String targetrationle = importer.getString(fullFields[31]);
			if((targetrationle != null)&&(!"".equals(targetrationle))) define.put("TARGETRATIONLE","'"+targetrationle+"'");


			String plannedbaseplus = importer.getString(fullFields[41]);
			if((plannedbaseplus != null)&&(!"".equals(plannedbaseplus))) define.put("PLANNEDBASEPLUS",plannedbaseplus);

			String baseplus = importer.getString(fullFields[42]);
			if((baseplus != null)&&(!"".equals(baseplus))) define.put("BASEPLUS",baseplus);

			String baselimitplus = importer.getString(fullFields[43]);
			if((baselimitplus != null)&&(!"".equals(baselimitplus))) define.put("BASELIMITPLUS",baselimitplus);

			String limitplus = importer.getString(fullFields[44]);
			if((limitplus != null)&&(!"".equals(limitplus))) define.put("LIMITPLUS",limitplus);



//			String y = importer.getString(fullFields[29]);
//			if((y != null)&&(!"".equals(y))) define.put("Y","'"+y+"'");
//			String yb1 = importer.getString(fullFields[30]);
//			if((yb1 != null)&&(!"".equals(yb1))) define.put("YB1","'"+yb1+"'");
//			String yb2 = importer.getString(fullFields[31]);
//			if((yb2 != null)&&(!"".equals(yb2))) define.put("YB2","'"+yb2+"'");
//			String yb3 = importer.getString(fullFields[32]);
//			if((yb3 != null)&&(!"".equals(yb3))) define.put("YB3","'"+yb3+"'");
//
//			String ya1 = importer.getString(fullFields[33]);
//			if((ya1 != null)&&(!"".equals(ya1))) define.put("YA1","'"+ya1+"'");
//			String ya2 = importer.getString(fullFields[34]);
//			if((ya2 != null)&&(!"".equals(ya2))) define.put("YA2","'"+ya2+"'");
//			String ya3 = importer.getString(fullFields[35]);
//			if((ya3 != null)&&(!"".equals(ya3))) define.put("YA3","'"+ya3+"'");
//			String ya4 = importer.getString(fullFields[36]);
//			if((ya4 != null)&&(!"".equals(ya4))) define.put("YA4","'"+ya4+"'");


			// MeasureDefine생성
			String defineId = updateMeasureDefine(define,measureId,objHid);

			if (defineId == null) throw new Exception("MeasureDefine Id is null ");
			hm.clear();
			hm.put("contentId",defineId);                                             //  contentID;;;
			hm.put("parentId",objHid);                                           /// ************상위 조직 코드;
			hm.put("treelevel",String.valueOf(5));                             // tree level;
			hm.put("weight",importer.getString(fullFields[13]));        // weight
			hm.put("rank",Integer.toString(importer.getCursor()*10));
			hm.put("year",importer.getString("year"));

			// TREESCORE 생성
			objHid = updateHierarchy("TBLTREESCORE",hm);

						//--------------------------------------------------------------------------------------
			// 목표값 자동생성 : 목표구간 설정에 의한 자동생성.
			//--------------------------------------------------------------------------------------
			setMeasDetailValue(importer.getString("year"), defineId, frequency, weight, planned, plannedbase, base, baselimit, limit, plannedbaseplus, baseplus, baselimitplus,limitplus );


		} catch (Exception e){
			String msg = "Row at : "+importer.getCursor()+ " ,  field : "+field+" ,  "+e;
			msg = msg.replaceAll("\n","  ");
			rtnMap.put("error", msg);
			throw new Exception();
		}

	}
	private String updateMeasureDefine(HashMap define, String measureId, String parentId) throws SQLException{
		ResultSet rs;
		try {
				StringBuffer sb = new StringBuffer();
				sb.append("SELECT ID FROM TBLMEASUREDEFINE ");
				sb.append(" WHERE id in (SELECT contentid FROM TBLTREESCORE WHERE treelevel=5 and parentid=" +
						parentId+") and measureid="+measureId);

				rs = executeQuery(sb.toString());

				int id = 0;
				if (rs.next()) id = rs.getInt("id");
				if (id == 0 ){
					id = getNextId("TBLMEASUREDEFINE");
					StringBuffer sb1 = new StringBuffer();
					StringBuffer sb1v = new StringBuffer();
					sb1.append("INSERT INTO TBLMEASUREDEFINE (ID, MEASUREID ");
					for (Iterator it1=define.keySet().iterator(); it1.hasNext();) {
						String key = (String)it1.next();
						String field = (String)define.get(key);
						sb1.append(","+key);
						sb1v.append(","+field);
					}
					sb1.append(") VALUES ("+id+","+measureId+sb1v.toString()+")");

					//System.out.println(sb1.toString());

					executeUpdate(sb1.toString());

				} else {
					StringBuffer sb1 = new StringBuffer();
					sb1.append("UPDATE TBLMEASUREDEFINE SET ");
					boolean tag = false;
					for(Iterator it1=define.keySet().iterator();it1.hasNext();){
						if (tag) sb1.append(",");
						String key = (String)it1.next();
						String field = (String)define.get(key);
						sb1.append(key+"="+field);
						tag = true;
					}
					sb1.append(" WHERE id="+id);

					//System.out.println(sb1.toString());

					executeUpdate(sb1.toString());
				}

				return String.valueOf(id);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	private int getObjectiveId(String name, String c) throws SQLException{
		try {
			String s = "select * from a_objective where objectiveid in ( select id from c_objective where description='"+name+"')";
			ResultSet rs = executeQuery(s);
			if (rs.next()) return rs.getInt(1);
			return -1;
		} catch (SQLException se){
			System.out.println(se);
		}
		return -1;
	}
	private String insertObjective(String s, HashMap map, String alias) throws SQLException{
		StringBuffer sb = new StringBuffer();
		sb.append("INSERT INTO "+s+" (id, code ");

		for (Iterator iterator = map.keySet().iterator();iterator.hasNext();){
			String field = (String)iterator.next();
			sb.append(","+field);
		}
		int id = getNextId(s);
		String code = getNewCode(alias,id);

		sb.append(",concurrencyid ) VALUES ("+id+","+"'"+code+"'");

		for(Iterator iterator1 = map.keySet().iterator();iterator1.hasNext();){
			String key = (String)iterator1.next();
			String field = (String)map.get(key);
			sb.append(","+field);
		}
		sb.append(",0)");

		if (executeUpdate(sb.toString())>0){
			int oid = getNextId("a_objective");
			String s1 = "insert into a_objective (id,objectiveid,concurrencyid) VALUES ("+oid+","+id+",0)";
			if(executeUpdate(s1)>0){
				return String.valueOf(oid);
			} else {
				return null;
			}
		} else {
			return null;
		}
	}
	private int getComponentId(String name, String c) throws SQLException{
		try {
			String s="SELECT ID FROM "+c+" WHERE replace(NAME,' ','')=replace('"+name+"',' ','')";

			ResultSet rs = executeQuery(s);
			if (rs.next()) return rs.getInt(1);
			return -1;
		} catch (SQLException se){
			System.out.println(se);
		}
		return -1;
	}

	private String getUserId(String userId) throws SQLException{
		ResultSet rs  = executeQuery("SELECT USERID FROM TBLUSER WHERE USERID='"+userId+"'");
		if (rs.next()) return rs.getString(1);
		return null;
	}
	private String insertComponent(String s, HashMap map, String alias) throws SQLException{
		StringBuffer sb = new StringBuffer();
		sb.append("INSERT INTO "+s+" (id, code ");

		for (Iterator iterator = map.keySet().iterator();iterator.hasNext();){
			String field = (String)iterator.next();
			sb.append(","+field);
		}
		int id = getNextId(s);
		String code = getNewCode(alias,id);

		sb.append(" ) VALUES ("+id+","+"'"+code+"'");

		for(Iterator iterator1 = map.keySet().iterator();iterator1.hasNext();){
			String key = (String)iterator1.next();
			String field = (String)map.get(key);
			sb.append(","+field);
		}
		sb.append(")");

		if (executeUpdate(sb.toString())>0){
			return String.valueOf(id);
		} else {
			return null;
		}
	}
	private String updateHierarchy(String s, HashMap map) throws SQLException{
		boolean tag = false;
		StringBuffer sb = new StringBuffer();
		sb.append("UPDATE "+s+" SET ");
		sb.append(" WEIGHT="+map.get("weight"));
		sb.append(", RANK="+map.get("rank"));

		sb.append(" WHERE parentId="+map.get("parentId"))
			.append(" and contentId="+map.get("contentId"))
			.append(" and treeLevel="+map.get("treelevel"))
			.append(" AND YEAR="+map.get("year"));

		if (executeUpdate(sb.toString())<1){
			StringBuffer sb1 = new StringBuffer();
			sb1.append("INSERT INTO "+s+"( id,");

			boolean flag = false;
			for(Iterator iterator= map.keySet().iterator();iterator.hasNext();){
				if (flag)sb1.append(",");
				String key = (String)iterator.next();
				sb1.append(key);
				flag = true;
			}
			sb1.append(") VALUES (");
			sb1.append(getNextId(s)+",");
			flag = false;
			for(Iterator iterator=map.keySet().iterator();iterator.hasNext();){
				if (flag) sb1.append(" , ");
				String key = (String)iterator.next();
				String field = (String)map.get(key);
				sb1.append(field);
				flag = true;
			}
			sb1.append(" )");
			executeUpdate(sb1.toString());
			tag = true;
		}

		String get = "SELECT id FROM "+s+" WHERE parentId="+map.get("parentId")+" and contentId="
		+map.get("contentId")+" and treeLevel="+map.get("treelevel")+" and year="+map.get("year");
		ResultSet rs = executeQuery(get);
		int id=-1;
		if (rs.next()) id = rs.getInt(1);

		return String.valueOf(id);
	}

	public void importItem(Importer dataimporter, HashMap rtnMap) {
		/*  처리과정
		 * 1. Import 필드 유효성 검사
		 * 2. 반복
		 * 		2.1 기초정보 코드 가져온다. (저장 여부)
		 * 			2.1.1 코드가 없으면 (저장이 안 되어 있으면) 저장.
		 * 		2.2 행당되는 조직 레벨에 등록이 되어 있는지 확인.
		 * 			2.2.1 등록이 안 되어 있으면 등록. (treeIndex에도 동시에 적용)
		 * 		2.3 지표 저장시
		 * 3. 처리 결과 리턴.
		 */


		//반드시 필요한 필드 목록
		String[] fields = new String[] {
				"company","companyweight","sbu","sbuweight","pst","pstweight","obj","objweight","csf","csfweight",
				"measure","measureupdater","weighting","entrytype","frequency","eval_frequency","measuretype","trend"};

		String[] fullFields = {
				"company","companyweight","sbu","sbuweight","pst","pstweight","obj","objweight","csf","csfweight",
				"measure","measureupdater","weighting","entrytype","frequency","eval_frequency","measuredefine","unit","measuretype","etlkey",
				"trend","s","a","b","c","si","ai","bi","ci","targetdefine",
				"y-2","y-1","y","y+1","y+2","y+3","y+4","m1","m2","m3",
				"m4","m5","m6","m7","m8","m9","m10","m11","m12"};
		/*
		String[] fullFields = new String[] {
				"company","companyweight","companyowner","companyclink","companyalink",   // 0.. 4
				"sbu","sbuweight","sbuowner","sbuclink","sbualink",												// 5
				"bsc","bscweight","bscowner","bscclink","bscalink",                            // 10
				"pst","pstweight","pstowner","pstclink","pstalink","pstnotes",                                   // 15
				"obj","objweight","objowner","objgroup","objdefine","objclink","objalink",										// 21
				"measure","measuregroup","measureowner","measureupdater","weighting","entrytype","frequency",			// 28
				"measuredescription","unit","measureclink","measurealink","measuredefine","worst","best","etlkey",				//35
				"measuretype","equation","planned","bau","benchmark"};	//43
		*/
		// 필드 유효성 검사
		System.out.println("checking Fields....");
		for (int i1=0; i1<fields.length;i1++){
			if ((dataimporter.getColumnIndex(fields[i1])) < 0 ) {
				rtnMap.put("error"," REQUIRED FIELD is Nothing : "+fields[i1]);
				return;
			}
		}

		try {
			for (dataimporter.resetCursor();dataimporter.next();) {
				setHierarchy(dataimporter, fullFields, rtnMap);   /// with on line update for row count;;;
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			rtnMap.put("count", String.valueOf(dataimporter.getRowCount()-1));
		}

	}

	public void importItemActual(Importer dataimporter, HashMap rtnMap) {
		/*  처리과정
		 * 1. Import 필드 유효성 검사
		 * 2. 반복
		 * 		2.1 기초정보 코드 가져온다. (저장 여부)
		 * 			2.1.1 코드가 없으면 (저장이 안 되어 있으면) 저장.
		 * 		2.2 행당되는 조직 레벨에 등록이 되어 있는지 확인.
		 * 			2.2.1 등록이 안 되어 있으면 등록. (treeIndex에도 동시에 적용)
		 * 		2.3 지표 저장시
		 * 3. 처리 결과 리턴.
		 */


		//반드시 필요한 필드 목록
		String[] fields = new String[] {
				"company","companyweight","sbu","sbuweight","pst","pstweight","obj","objweight","csf","csfweight",
				"measure","measureupdater","weighting","entrytype","frequency","eval_frequency","measuretype","trend"};

		String[] fullFields = {
				"company","companyweight","sbu","sbuweight","pst","pstweight","obj","objweight","csf","csfweight",
				"measure","measureupdater","weighting","entrytype","frequency","eval_frequency","measuredefine","unit","measuretype","etlkey",
				"trend","s","a","b","c","si","ai","bi","ci","targetdefine",
				"y-2","y-1","y","y+1","y+2","y+3","y+4","m1","m2","m3",
				"m4","m5","m6","m7","m8","m9","m10","m11","m12"};
		/*
		String[] fullFields = new String[] {
				"company","companyweight","companyowner","companyclink","companyalink",   // 0.. 4
				"sbu","sbuweight","sbuowner","sbuclink","sbualink",												// 5
				"bsc","bscweight","bscowner","bscclink","bscalink",                            // 10
				"pst","pstweight","pstowner","pstclink","pstalink","pstnotes",                                   // 15
				"obj","objweight","objowner","objgroup","objdefine","objclink","objalink",										// 21
				"measure","measuregroup","measureowner","measureupdater","weighting","entrytype","frequency",			// 28
				"measuredescription","unit","measureclink","measurealink","measuredefine","worst","best","etlkey",				//35
				"measuretype","equation","planned","bau","benchmark"};	//43
		*/
		// 필드 유효성 검사
		System.out.println("checking Fields....");
		for (int i1=0; i1<fields.length;i1++){
			if ((dataimporter.getColumnIndex(fields[i1])) < 0 ) {
				rtnMap.put("error"," REQUIRED FIELD is Nothing : "+fields[i1]);
				return;
			}
		}

		try {
			for (dataimporter.resetCursor();dataimporter.next();) {
				setHierarchy(dataimporter, fullFields, rtnMap);   /// with on line update for row count;;;
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			rtnMap.put("count", String.valueOf(dataimporter.getRowCount()-1));
		}

	}

	//-----------------------------------------------------------------------------------------------------
	// 	 : setMeasDetailValue
	//   지표 목표값 생성시 관련 MeasureDetail에 Planned, Base, Limt을 주기에 맞게 자동생성.
	//
	//		tbluser에 12명이상 등록안되면 입력이 제대로 안됨.
	//-----------------------------------------------------------------------------------------------------
	public int setMeasDetailValue(String year, String measureid, String frequency, String weight,
			                        String planned,String plannedbase,String base,String baselimit,String limit, String plannedbaseplus, String baseplus, String baselimitplus,String limitplus) {

		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		DataSet ds = new DataSet();

		try {
				conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
				conn.createStatement(false);
				if (dbobject==null) dbobject= new DBObject(conn.getConnection());

				if ("".equals(year)){
					return -1;
				}
				// 0. 년도의 지표정의서 ID에 해당되는 정보를 구함.
				StringBuffer sb = new StringBuffer();

				sb.append(" SELECT  ?||a.ym ym                   ");
				sb.append(" FROM    (                                                               ");
				sb.append("         SELECT '년' freq, ltrim(to_char(rownum * 12,'00')) ym           ");
				sb.append("         FROM   tbluser WHERE rownum <= 1                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '반기' freq, ltrim(to_char(rownum * 6,'00')) ym          ");
				sb.append("         FROM   tbluser WHERE rownum <= 2                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '분기' freq, ltrim(to_char(rownum * 3,'00')) ym          ");
				sb.append("         FROM   tbluser WHERE rownum <= 4                                ");
				sb.append("         UNION ALL                                                       ");
				sb.append("         SELECT '월' freq, ltrim(to_char(rownum * 1,'00')) ym            ");
				sb.append("         FROM   tbluser WHERE rownum <= 12                               ");
				sb.append("         ) a                                                             ");
				sb.append(" WHERE  a.freq = ?                                                       ");
				sb.append(" ORDER BY a.ym                                                           ");

				Object[] paramS = {year,frequency};
				rs = dbobject.executePreparedQuery(sb.toString(),paramS);
				ds.load(rs);
				System.out.println("Row Count : "+ ds.getRowCount());
				System.out.println("MeasDetail 1.mcid : " + measureid );


				String  ym         ;

				// 지표정의서 Read...
				int v_cnt = 0;
				int i = 0;

				while(ds.next()){

					System.out.println("MeasDetail Loop : " + i++);

					ym          = ds.getString("ym"         );

					//--------------------------------------------------------------
					// 1. MeasureDetail에 목표등급 데이타 Setting.
					//--------------------------------------------------------------
					// 1-1. 주기에 맞지않는 목표값 삭제

					StringBuffer sbD = new StringBuffer();

					if ("년".equals(frequency)){

						sbD.append(" delete tblmeasuredetail                               ");
						sbD.append(" where  measureid                = ?                   ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%' ");
						sbD.append(" and    substr(strdate,5,2) not in ('12')              ");

					} else if ("반기".equals(frequency)){
						sbD.append(" delete tblmeasuredetail                               ");
						sbD.append(" where  measureid                = ?                   ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%' ");
						sbD.append(" and    substr(strdate,5,2) not in  ('06','12')        ");

					} else if ("분기".equals(frequency)){
						sbD.append(" delete tblmeasuredetail                                 ");
						sbD.append(" where  measureid                = ?                     ");
						sbD.append(" and    strdate               like substr(?, 1,4)||'%'   ");
						sbD.append(" and    substr(strdate,5,2) not in ('03','06','09','12') ");
					}

					Object[] paramD = {measureid,ym};
					dbobject.executePreparedUpdate(sbD.toString(),paramD);

					System.out.println("MeasDetail Delete : " + measureid + ", ym :" + ym);

					// 1-2. 주기에 맞는 목표값 자동 생성
					StringBuffer sbQ = new StringBuffer();

					sbQ.append(" select count(*) cnt             ");
					sbQ.append(" from   tblmeasuredetail         ");
					sbQ.append(" where  measureid       = ?      ");
					sbQ.append(" and    strdate      like ?||'%' ");

					Object[] paramQ = {measureid,ym};

					rs2 = null;
					rs2 = dbobject.executePreparedQuery(sbQ.toString(),paramQ);
					rs2.next();

					v_cnt = rs2.getInt("cnt");
					rs2.close();

					System.out.println("MeasDetail I/U Check : " + v_cnt);

					if (v_cnt > 0){
						StringBuffer sbU = new StringBuffer();

						sbU.append(" update tblmeasuredetail                                         ");
						sbU.append(" set    weight      = ?                                          ");
						sbU.append("     ,  planned     = ?                                          ");
						sbU.append("     ,  plannedbase = ?                                          ");
						sbU.append("     ,  base        = ?                                          ");
						sbU.append("     ,  baselimit   = ?                                          ");
						sbU.append("     ,  limit       = ?                                          ");
						sbU.append("     ,  plannedbaseplus      = ?                                     ");
						sbU.append("     ,  baseplus             = ?                                     ");
						sbU.append("     ,  baselimitplus        = ?                                     ");
						sbU.append("     ,  limitplus            = ?                                     ");
						sbU.append("     ,  updatedate  = sysdate                                    ");
						sbU.append(" where  measureid       = ?                                      ");
						sbU.append(" and    strdate      like ?||'%'                                 ");

						Object[] paramU = {weight, planned, plannedbase, base,baselimit,limit, plannedbaseplus,
								baseplus,
								baselimitplus,
								limitplus, measureid,ym};
						dbobject.executePreparedUpdate(sbU.toString(),paramU);

						System.out.println("MeasDetail Update : " + measureid);

					}else{
						StringBuffer sbC = new StringBuffer();

						sbC.append(" insert into tblmeasuredetail                                            ");
						sbC.append(" (id, measureid, strdate, weight,                                        ");
						sbC.append("  planned, plannedbase, base, baselimit, limit, inputdate)               ");
						sbC.append(" SELECT nvl(max(id) + 1,0) id, ? measureid,?   ym,?  weight,             ");
						sbC.append("        ? planned, ? plannedbase, ? base, ? baselimit, ? limit, sysdate  ");
						sbC.append(" FROM   tblmeasuredetail                                                 ");

						Object[] paramI = {measureid,ym,weight, planned, plannedbase, base, baselimit, limit};
						dbobject.executePreparedUpdate(sbC.toString(),paramI);

						System.out.println("MeasDetail Insert : " + measureid);
					}

				}

				System.out.println("MeasDetail Planned Auto Create Sucess : " + measureid);

				rs.close();

				conn.commit();

				return 0;

		} catch (Exception e) {
			System.out.println("setMeasDetailValue2 에러 : " + e.toString());
			//e.printStackTrace();
			return -1;
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			try{if (rs2 != null) {rs2.close(); rs2 = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}

	}
}
