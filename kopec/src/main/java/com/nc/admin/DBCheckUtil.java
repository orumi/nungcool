package com.nc.admin;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.tree.TreeUtil;
import com.nc.util.DBObject;


public class DBCheckUtil {
	
	public void setService(HttpServletRequest request, HttpServletResponse response){
    	System.out.println("DB Checker Starting...");
		CoolConnection conn = null;
		DBObject dbobject = null;
		TreeUtil treeutil = null;
		ResultSet rs = null;
    	    	
    	//boolean fixData = request.getParameter("fixData") != null;
    	boolean fixAddTable = request.getParameter("fixAddTable") != null;
    	//boolean fixAddField = request.getParameter("fixAddField") != null;
    	//boolean fixType = request.getParameter("fixType") != null;
    	//boolean fixSize = request.getParameter("fixSize") != null;
    	//boolean fixDrop = request.getParameter("fixDrop") != null;
    	boolean dropTable = request.getParameter("dropTable") != null;
    	boolean emptyTable = request.getParameter("emptyTable") != null;
    	boolean emptyTableNotUser = request.getParameter("emptyTableNotUser") != null;
    	boolean resetTable = request.getParameter("resetTable") != null;
    	
    	System.out.println("DB Checker Starting...1111");
    	try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			QueryMaker querymaker = null;//service.getQueryMaker();
			String dbSchema = null;//service.getDBSchema();
			String dbCatalog = null;//service.getDBCatalog();
			
			DatabaseMetaData databasemetadata = conn.getConnection().getMetaData();
			ArrayList arrayList = querymaker.tableList;
			int i = arrayList.size();
			
			MessageSet mSet = new MessageSet();
			
			System.out.println("DB Checker Starting...2222");
			if (dropTable || emptyTable || emptyTableNotUser){
				for(int j = i-1; j>=0; j--){
					Object obj = arrayList.get(j);
					if(obj instanceof Table){
						Table table = (Table)obj;
						String tblName = table.getName();
						boolean isExist = ("TABLE".equals(table.kind))?conn.tableExists(dbSchema,dbCatalog,tblName):conn.viewExists(dbSchema,dbCatalog,tblName);
						if(isExist){
							if (dropTable){
								String strQy = ("TABLE".equals(table.kind))?querymaker.dropTable(tblName):querymaker.dropView(tblName);
								conn.executeUpdate(strQy);
							} else if(emptyTable || emptyTableNotUser && !tblName.equals("TBLUSER")&&"TABLE".equals(table.kind)){
								String strQy = querymaker.emptyTable(tblName);
								conn.executeUpdate(strQy);
							}
						}
					}
				}
			}
			
			if (resetTable ){
				String sql = "delete from tblmeasurescore";
				conn.executeUpdate(sql);
				sql = "delete from tblmeasuredetail";
				conn.executeUpdate(sql);
				sql = "delete from tblAudit";
				conn.executeUpdate(sql);
				sql = "delete from tblmemo";
				conn.executeUpdate(sql);
				sql = "delete from tblmapicon";
				conn.executeUpdate(sql);
				sql = "delete from tbltreeinitiative";
				conn.executeUpdate(sql);
				sql = "delete from tblinitiative";
				conn.executeUpdate(sql);
				sql = "delete from tbltreeIndex";
				conn.executeUpdate(sql);
				sql = "delete from tbltreescore";
				conn.executeUpdate(sql);
				sql = "delete from tblhierarchy";
				conn.executeUpdate(sql);
				sql = "delete from tblmeasuredefine";
				conn.executeUpdate(sql);
				sql = "delete from tblmeasure";
				conn.executeUpdate(sql);
				sql = "delete from tblobjective";
				conn.executeUpdate(sql);
				sql = "delete from tblpst";
				conn.executeUpdate(sql);
				sql = "delete from tblbsc";
				conn.executeUpdate(sql);
				sql = "delete from tblsbu";
				conn.executeUpdate(sql);
				sql = "delete from tblcompany";
				conn.executeUpdate(sql);
				conn.commit();
			}
			
            for(int k = 0; k < i; k++)
                try {
                    Object obj1 = arrayList.get(k);
                    if(obj1 instanceof Table) {
                        Table table1 = (Table)obj1;
                        
                        Message mg = new Message();  /////////////////////////// add Message;;;
                        mSet.setObject(mg);
                        mg.tblName = table1.name;
                        if (dropTable) mg.message ="Table "+table1.name+"was dropped";   /////
                        
                        
                        String s13 = table1.getName();
                        String s16 = null;
                        if(databasemetadata.storesUpperCaseIdentifiers() || databasemetadata.storesUpperCaseQuotedIdentifiers())
                            s16 = s13.toUpperCase();
                        else if(databasemetadata.storesLowerCaseIdentifiers() || databasemetadata.storesLowerCaseQuotedIdentifiers())
                            s16 = s13.toLowerCase();
                        else
                            s16 = s13;
                        
                        boolean flag13 = ("TABLE".equals(table1.kind))?conn.tableExists(dbSchema,dbCatalog, s13):conn.viewExists(dbSchema,dbCatalog, s13);
                        
                        if(flag13) {
                            ArrayList arraylist2 = new ArrayList();
                            HashMap hashmap1 = new HashMap();
                            ResultSet resultset2 = databasemetadata.getColumns(dbSchema,dbCatalog, s16, null);
                            ArrayList arraylist3 = new ArrayList();
                            String s22;
                            int k1;
                            String s23;
                            int j2;
                            for(; resultset2.next(); hashmap1.put(s22.toUpperCase(), ((Object) (new Object[] {
                            		new Integer(k1), s23, new Integer(j2)
                            	}))))
                            {
                                s22 = "";//ServerUtil.getString(resultset2, 4);
                                arraylist2.add(s22);
                                k1 = resultset2.getInt(5);
                                s23 = "";//ServerUtil.getString(resultset2, 6);
                                j2 = resultset2.getInt(7);
                                mg.addNode(s22,"Pass","");   /////////////////////////// Table Field Pass;;;
                            }

                            resultset2.close();

                            Iterator iterator1 = hashmap1.keySet().iterator();
                            int l1 = arraylist2.size();
                            for(int i2 = 0; i2 < l1; i2++) {
                                String s24 = (String)arraylist2.get(i2);
                                String s25 = s24.toUpperCase();
                                Object aobj[] = (Object[])hashmap1.get(s25);
                                int i3 = ((Integer)aobj[0]).intValue();
                                String s29 = (String)aobj[1];
                                int j3 = ((Integer)aobj[2]).intValue();
                            }

                        } else {

                            String s18 = querymaker.createTable(table1);
                            mg.error = "Table "+table1.name+" was not found";
                            if(fixAddTable) {
                                try {
                                    String sqSql = table1.sequenceSQL;
                                    if ((!("".equals(sqSql))) && (sqSql != null)){
                                    	try{
                                    		conn.executeUpdate(sqSql);
                                    	} catch (Exception e){
                                    		
                                    	}
                                    }
                                	
                                	conn.executeUpdate(s18);
                                	
                                	String trSql = table1.triggerSQL;
                                    if ((!("".equals(trSql))) && (trSql != null)){
                                    	conn.executeUpdate(trSql);
                                    }
                                	String indSql = table1.indexSQL;
                                    if ((!("".equals(indSql))) && (indSql != null)){
                                    	conn.executeUpdate(indSql);
                                    }
                                	String alSql = table1.alterSQL;
                                    if ((!("".equals(alSql))) && (alSql != null)){
                                    	conn.executeUpdate(alSql);
                                    }
                                    
                                   	mg.define = "Table "+table1.name+" was created  "+s18;
                                } catch(Exception exception2) {
                                	System.out.println(table1);
                                    System.out.println("<br>" + exception2); 
                                }
                            } else  {
                            	mg.define = "Table "+table1.name+" will create with sql  "+s18;
                            }
                        }
 
                    }
                    
                } catch(Exception exception1){
                    //Log.warn("DBChecker", "Error", exception1);
                    System.out.println("Error at DBChecher class;"+ exception1);
                }

          	
            request.setAttribute("mSet",mSet);
            
        }  catch(Exception exception) {
            //Log.error("RapidScoreCard.doGet", "Exception", exception);
            try { conn.rollback(); } catch (SQLException se){}
            System.out.println(exception);
        }  finally {
            conn.close();
            conn = null;
        }
	}
}
