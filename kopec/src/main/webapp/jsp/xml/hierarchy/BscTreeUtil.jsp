<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("UTF-8");

	String mode		= request.getParameter("mode")   == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	= request.getParameter("div_gn") == null ? ""  : (request.getParameter("div_gn")).trim();
	
	
	System.out.println("_____________________ div:"+div_gn);
	
	
	if(mode.equals("R"))	{

		//-----------------------------------------------------------------------		
		//   BSC Component 공통 Code를 구함.
		//-----------------------------------------------------------------------
		if(div_gn.equals("getComponent"))	{

		    BscTreeUtil util= new BscTreeUtil();
		    util.getComponent(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();

			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("kd"         )?"":ds.getString("kd"         )) +"|");          // 0 
					sb.append((ds.isEmpty("id"         )?"":ds.getString("id"         )) +"|");          // 1 
					sb.append((ds.isEmpty("name"       )?"":ds.getString("name"       )) +"|");          // 2 
					sb.append("\r\n");    		
				} 
			}
			out.println(sb.toString());			
		}
		
		//-----------------------------------------------------------------------		
		//   BSC Component 공통 Code를 구함.
		//-----------------------------------------------------------------------
		else if(div_gn.equals("getLoadType"))	{		
			BscTreeUtil util= new BscTreeUtil();
		    util.getEquType(request, response);
		    
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		sb.append((ds.isEmpty("TYPE")?"":ds.getString("TYPE"))+"|");
		    		sb.append((ds.isEmpty("UPPER")?"":ds.getString("UPPER"))+"|");
		    		sb.append((ds.isEmpty("HIGH")?"":ds.getString("HIGH"))+"|");
		    		sb.append((ds.isEmpty("LOW")?"":ds.getString("LOW"))+"|");
		    		sb.append((ds.isEmpty("LOWER")?"":ds.getString("LOWER"))+"|");    		
		    		sb.append((ds.isEmpty("TYPE_NM")?"":ds.getString("TYPE_NM"))+"|");
		    		sb.append((ds.isEmpty("PLANNED")?"":ds.getString("PLANNED"))+"|");
		    		sb.append((ds.isEmpty("PLANNEDBASE")?"":ds.getString("PLANNEDBASE"))+"|");
		    		sb.append((ds.isEmpty("BASE")?"":ds.getString("BASE"))+"|");    
		    		sb.append((ds.isEmpty("BASELIMIT")?"":ds.getString("BASELIMIT"))+"|");
		    		sb.append((ds.isEmpty("LIMIT")?"":ds.getString("LIMIT"))+"|");
		    		sb.append("\r\n");    		
		   		} 
		    }
		    out.println(sb.toString());
		}
		//-----------------------------------------------------------------------		
		//   BSC 담당자(Group <= 3)를 구함.
		//-----------------------------------------------------------------------
		else if(div_gn.equals("getBscUser"))	{
			
		    BscTreeUtil util= new BscTreeUtil();
		    util.getBscUser(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();

			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("orgcd"      )?"":ds.getString("orgcd"         )) +"|");          // 0 
					sb.append((ds.isEmpty("orgnm"      )?"":ds.getString("orgnm"         )) +"|");          // 1 
					sb.append((ds.isEmpty("userid"     )?"":ds.getString("userid"        )) +"|");          // 0 
					sb.append((ds.isEmpty("usernm"     )?"":ds.getString("usernm"        )) +"|");          // 1 

					sb.append("\r\n");    		
				} 
			}
			out.println(sb.toString());			
		}		
		//-----------------------------------------------------------------------		
		//   특정지표  담당자를 구함.
		//-----------------------------------------------------------------------
		else if(div_gn.equals("getMeasUser"))	{

		    BscTreeUtil util= new BscTreeUtil();
		    util.getMeasUser(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();

			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("orgcd"      )?"":ds.getString("orgcd"         )) +"|");          // 0 
					sb.append((ds.isEmpty("orgnm"      )?"":ds.getString("orgnm"         )) +"|");          // 1 
					sb.append((ds.isEmpty("userid"     )?"":ds.getString("userid"        )) +"|");          // 0 
					sb.append((ds.isEmpty("usernm"     )?"":ds.getString("usernm"        )) +"|");          // 1 
					sb.append((ds.isEmpty("mngyn"      )?"":ds.getString("mngyn"         )) +"|");          // 1 
					
					sb.append("\r\n");    		
				} 
			}
			out.println(sb.toString());			
		}		
		
		//-----------------------------------------------------------------------		
		// MAIN창의 지표대상부서를 구함.(Outer 조인)
		//-----------------------------------------------------------------------				
		else if(div_gn.equals("getTreeMeasList"))	{
		    BscTreeUtil util= new BscTreeUtil();
		    util.getTreeMeasList(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
                    sb.append((ds.isEmpty("cid"        )?"0":ds.getString("cid"       )) +"|");          // 0
                    sb.append((ds.isEmpty("cname"      )?"":ds.getString("cname"      )) +"|");          // 1
                    sb.append((ds.isEmpty("ccid"       )?"":ds.getString("ccid"       )) +"|");          // 2
                    sb.append((ds.isEmpty("crank"      )?"":ds.getString("crank"      )) +"|");          // 3
                    sb.append((ds.isEmpty("cweight"    )?"":ds.getString("cweight"    )) +"|");          // 4

                    sb.append((ds.isEmpty("sid"        )?"0":ds.getString("sid"       )) +"|");          // 5
                    sb.append((ds.isEmpty("sname"      )?"":ds.getString("sname"      )) +"|");          // 6
                    sb.append((ds.isEmpty("scid"       )?"":ds.getString("scid"       )) +"|");          // 7
                    sb.append((ds.isEmpty("srank"      )?"":ds.getString("srank"      )) +"|");          // 8
                    sb.append((ds.isEmpty("sweight"    )?"":ds.getString("sweight"    )) +"|");          // 9

                    sb.append((ds.isEmpty("bid"        )?"0":ds.getString("bid"       )) +"|");          // 10
                    sb.append((ds.isEmpty("bname"      )?"":ds.getString("bname"      )) +"|");          // 
                    sb.append((ds.isEmpty("bcid"       )?"":ds.getString("bcid"       )) +"|");          // 
                    sb.append((ds.isEmpty("brank"      )?"":ds.getString("brank"      )) +"|");          // 
                    sb.append((ds.isEmpty("bweight"    )?"":ds.getString("bweight"    )) +"|");          // 

					sb.append((ds.isEmpty("pid"        )?"0":ds.getString("pid"       )) +"|");          // 15
					sb.append((ds.isEmpty("pname"      )?"":ds.getString("pname"      )) +"|");          // 
					sb.append((ds.isEmpty("pcid"       )?"":ds.getString("pcid"       )) +"|");          // 
					sb.append((ds.isEmpty("prank"      )?"":ds.getString("prank"      )) +"|");          //
					sb.append((ds.isEmpty("pweight"    )?"":ds.getString("pweight"    )) +"|");          //

					sb.append((ds.isEmpty("oid"        )?"0":ds.getString("oid"       )) +"|");          // 20
					sb.append((ds.isEmpty("oname"      )?"":ds.getString("oname"      )) +"|");          // 34
					sb.append((ds.isEmpty("ocid"       )?"":ds.getString("ocid"       )) +"|");          // 30
					sb.append((ds.isEmpty("orank"      )?"":ds.getString("orank"      )) +"|");          // 32
					sb.append((ds.isEmpty("oweight"    )?"":ds.getString("oweight"    )) +"|");          // 33

					sb.append((ds.isEmpty("mid"        )?"0":ds.getString("mid"       )) +"|");          // 35
					sb.append((ds.isEmpty("mname"      )?"":ds.getString("mname"      )) +"|");          // 41
					sb.append((ds.isEmpty("mcid"       )?"":ds.getString("mcid"       )) +"|");          // 37
					sb.append((ds.isEmpty("mrank"      )?"":ds.getString("mrank"      )) +"|");          // 39
					sb.append((ds.isEmpty("mweight"    )?"":ds.getString("mweight"    )) +"|");          // 40

					sb.append((ds.isEmpty("measureid"  )?"":ds.getString("measureid"  )) +"|");          // 42
					sb.append((ds.isEmpty("etlkey"     )?"":ds.getString("etlkey"     )) +"|");          // 43
					sb.append((ds.isEmpty("measurement")?"":ds.getString("measurement")) +"|");          // 44
					sb.append((ds.isEmpty("frequency"  )?"":ds.getString("frequency"  )) +"|");          // 45
					sb.append((ds.isEmpty("trend"      )?"":ds.getString("trend"      )) +"|");          // 46
				
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());	
			//System.out.println(sb.toString());	
		}

		//-----------------------------------------------------------------------		
		// 지표정의서를 구함.
		//-----------------------------------------------------------------------
		else if(div_gn.equals("getMeasure"))	{
			BscTreeUtil util= new BscTreeUtil();
		    util.getMeasure(request, response);
			
		    DataSet ds        = (DataSet)request.getAttribute("ds"    );
		    DataSet dsItem    = (DataSet)request.getAttribute("dsItem");
		    DataSet dsUpdater = (DataSet)request.getAttribute("dsUpdater");
		    
		    StringBuffer sbUpdater = new StringBuffer();
		    if (dsUpdater!=null){
		    	while(dsUpdater.next()){
		    		sbUpdater.append((dsUpdater.isEmpty("USERID"  )?"":dsUpdater.getString("USERID"  ))+",");
		    		sbUpdater.append((dsUpdater.isEmpty("USERNAME")?"":dsUpdater.getString("USERNAME"))+",");
		    		sbUpdater.append("^");
		    	}
		    }	
		    
		    StringBuffer sbItem = new StringBuffer();
		    if (dsItem!=null){
		    	while(dsItem.next()){
		    		sbItem.append((dsItem.isEmpty("CODE"     )?"":dsItem.getString("CODE"     ))+",");
		    		sbItem.append((dsItem.isEmpty("ITEMNAME" )?"":dsItem.getString("ITEMNAME" ))+",");
		    		sbItem.append((dsItem.isEmpty("ITEMENTRY")?"":dsItem.getString("ITEMENTRY"))+",");
		    		sbItem.append((dsItem.isEmpty("ITEMTYPE" )?"":dsItem.getString("ITEMTYPE" ))+",");		    		
		    		sbItem.append((dsItem.isEmpty("ITEMFIXED")?"":dsItem.getString("ITEMFIXED" ))+",");			    		
		    		sbItem.append("^");
		    	}
		    }	
		    
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		sb.append((ds.isEmpty("ID"            )?"0":ds.getString("ID"          ))+"`");                   //0
		    		sb.append((ds.isEmpty("MNAME"         )?"" :ds.getString("MNAME"       ))+"`");                   //1
		    		sb.append((ds.isEmpty("DETAILDEFINE"  )?"" :Util.toText(ds.getString("DETAILDEFINE"  )) )+"`");   //2
		    		sb.append((ds.isEmpty("MEAN"          )?"" :ds.getString("MEAN"        ))+"`");                   //3
		    		sb.append((ds.isEmpty("EQUATIONDEFINE")?"" :Util.toText(ds.getString("EQUATIONDEFINE")) )+"`");   //4
		    		sb.append((ds.isEmpty("WEIGHT"        )?"0":ds.getString("WEIGHT"      ))+"`");                   //5
		    		sb.append((ds.isEmpty("UNIT"          )?"" :ds.getString("UNIT"        ))+"`");                   //6
		    		sb.append((ds.isEmpty("TREND"         )?"" :ds.getString("TREND"       ))+"`");                   //7
		    		sb.append((ds.isEmpty("FREQUENCY"     )?"" :ds.getString("FREQUENCY"   ))+"`");                   //8
		    		sb.append((ds.isEmpty("MEASUREMENT"   )?"" :ds.getString("MEASUREMENT" ))+"`");                   //9
		    		sb.append((ds.isEmpty("UPDATEID"      )?"" :ds.getString("UPDATEID"    ))+"`");                   //10
		    		sb.append((ds.isEmpty("UPDATENM"      )?"" :ds.getString("UPDATENM"    ))+"`");                   //11
		    		sb.append((ds.isEmpty("PLANNED"       )?"0":ds.getString("PLANNED"     ))+"`");                   //12
		    		sb.append((ds.isEmpty("BASE"          )?"0":ds.getString("BASE"        ))+"`");                   //13
		    		sb.append((ds.isEmpty("LIMIT"         )?"0":ds.getString("LIMIT"       ))+"`");                   //14
		    		sb.append((ds.isEmpty("EQUATION"      )?"" :Util.toText(ds.getString("EQUATION"    ))  )+"`");                   //15
		    		sb.append((ds.isEmpty("YA1"           )?"" :ds.getString("YA1"         ))+"`");                   //16
		    		sb.append((ds.isEmpty("YA2"           )?"" :ds.getString("YA2"         ))+"`");                   //17
		    		sb.append((ds.isEmpty("YA3"           )?"" :ds.getString("YA3"         ))+"`");                   //18
		    		sb.append((ds.isEmpty("YA4"           )?"" :ds.getString("YA4"         ))+"`");                   //19
		    		sb.append((ds.isEmpty("Y"             )?"" :ds.getString("Y"           ))+"`");                   //20
		    		sb.append((ds.isEmpty("YB1"           )?"" :ds.getString("YB1"         ))+"`");                   //21
		    		sb.append((ds.isEmpty("YB2"           )?"" :ds.getString("YB2"         ))+"`");                   //22
		    		sb.append((ds.isEmpty("YB3"           )?"" :ds.getString("YB3"         ))+"`");                   //23
		    		sb.append((ds.isEmpty("MRANK"          )?"0":ds.getString("MRANK"        ))+"`");                   //24
		    		sb.append((ds.isEmpty("ETLKEY"        )?"0":ds.getString("ETLKEY"      ))+"`");                   //25
		    		sb.append((ds.isEmpty("MEASUREID"     )?"0":ds.getString("MEASUREID"   ))+"`");                   //26
		    		sb.append(sbItem.toString()                                              +"`");                   //27
		    		sb.append(sbUpdater.toString()                                           +"`");                   //28	
		    		
		    		sb.append((ds.isEmpty("EQUATIONTYPE"  )?"":ds.getString("EQUATIONTYPE"  ))+"`");                  //29
		    		sb.append((ds.isEmpty("DATASOURCE"    )?"":ds.getString("DATASOURCE"    ))+"`");                  //30
		    		sb.append((ds.isEmpty("PLANNEDBASE"   )?"":ds.getString("PLANNEDBASE"   ))+"`");                  //31
		    		sb.append((ds.isEmpty("BASELIMIT"     )?"":ds.getString("BASELIMIT"     ))+"`");                  //32    		

		    		sb.append((ds.isEmpty("IFSYSTEM"      )?"":ds.getString("IFSYSTEM"      ))+"`");                  //33
		    		sb.append((ds.isEmpty("MNGDEPTNM"     )?"":ds.getString("MNGDEPTNM"     ))+"`");                  //34
		    		sb.append((ds.isEmpty("TARGETRATIONLE")?"":ds.getString("TARGETRATIONLE"))+"`");                  //35    	    		
		    		sb.append((ds.isEmpty("PLANNED_FLAG"  )?"":ds.getString("PLANNED_FLAG"  ))+"`");                  //36   
		    		
		    		sb.append((ds.isEmpty("SCORECODE"      )?"":ds.getString("SCORECODE"))+"`");                        //37
		    		sb.append((ds.isEmpty("PLANNEDBASEPLUS")?"":ds.getString("PLANNEDBASEPLUS"))+"`");                  //38
		    		sb.append((ds.isEmpty("BASEPLUS"       )?"":ds.getString("BASEPLUS"))+"`");                         //39
		    		sb.append((ds.isEmpty("BASELIMITPLUS"  )?"":ds.getString("BASELIMITPLUS"))+"`");                    //40
		    		sb.append((ds.isEmpty("LIMITPLUS"      )?"":ds.getString("LIMITPLUS"))+"`");                        //41
		    		sb.append("\r\n");    		
		   		} 
		    }
		    out.println(sb.toString());	

		    
		    System.out.println(sb.toString());
			
		}		

		//--------------------------------------------------------------------------------------------
		// 지표복사 및 생성 : 지표대상부서를 구함.
		//--------------------------------------------------------------------------------------------
		else if(div_gn.equals("getTreeOrgList"))	{
	
			// 지표대상부서를 구함.			
		    BscTreeUtil util= new BscTreeUtil();
		    util.getTreeOrgList(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("cid")?"":ds.getString("cid")) +"|");           		// 0 
					sb.append((ds.isEmpty("cname")?"":ds.getString("cname")) +"|");           	// 1 
					sb.append((ds.isEmpty("cpid")?"":ds.getString("cpid")) +"|");           	// 2 
					sb.append((ds.isEmpty("ccid")?"":ds.getString("ccid")) +"|");           	// 3 
					sb.append((ds.isEmpty("crank")?"":ds.getString("crank")) +"|");             // 4
					
					sb.append((ds.isEmpty("sid")?"":ds.getString("sid")) +"|");           		// 5 
					sb.append((ds.isEmpty("sname")?"":ds.getString("sname")) +"|");           	// 6
					sb.append((ds.isEmpty("spid")?"":ds.getString("spid")) +"|");           	// 7 
					sb.append((ds.isEmpty("scid")?"":ds.getString("scid")) +"|");           	// 8 
					sb.append((ds.isEmpty("srank")?"":ds.getString("srank")) +"|");           	// 9
	
					sb.append((ds.isEmpty("bid")?"":ds.getString("bid")) +"|");           		// 10
					sb.append((ds.isEmpty("bname")?"":ds.getString("bname")) +"|");           	// 11
					sb.append((ds.isEmpty("bpid")?"":ds.getString("bpid")) +"|");           	// 12
					sb.append((ds.isEmpty("bcid")?"":ds.getString("bcid")) +"|");           	// 13
					sb.append((ds.isEmpty("brank")?"":ds.getString("brank")) +"|");           	// 14
					
					sb.append("\r\n");    		
				} 
			}
	
			out.println(sb.toString());			
		}		
		 
		// 특정부서의 지표리스트를 구함.
		else if(div_gn.equals("getTreeBscList"))	{

		    BscTreeUtil util= new BscTreeUtil();
		    util.getTreeBscList(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("pid"        )?"":ds.getString("pid"        )) +"|");          // 0 
					sb.append((ds.isEmpty("ppid"       )?"":ds.getString("ppid"       )) +"|");          // 1 
					sb.append((ds.isEmpty("pcid"       )?"":ds.getString("pcid"       )) +"|");          // 2 
					sb.append((ds.isEmpty("plevel"     )?"":ds.getString("plevel"     )) +"|");          // 3 
					sb.append((ds.isEmpty("prank"      )?"":ds.getString("prank"      )) +"|");          // 4 
					sb.append((ds.isEmpty("pweight"    )?"":ds.getString("pweight"    )) +"|");          // 5 
					sb.append((ds.isEmpty("pname"      )?"":ds.getString("pname"      )) +"|");          // 6 
					sb.append((ds.isEmpty("oid"        )?"":ds.getString("oid"        )) +"|");          // 7 
					sb.append((ds.isEmpty("opid"       )?"":ds.getString("opid"       )) +"|");          // 8 
					sb.append((ds.isEmpty("ocid"       )?"":ds.getString("ocid"       )) +"|");          // 9 
					sb.append((ds.isEmpty("olevel"     )?"":ds.getString("olevel"     )) +"|");          // 10
					sb.append((ds.isEmpty("orank"      )?"":ds.getString("orank"      )) +"|");          // 11
					sb.append((ds.isEmpty("oweight"    )?"":ds.getString("oweight"    )) +"|");          // 12
					sb.append((ds.isEmpty("oname"      )?"":ds.getString("oname"      )) +"|");          // 13
					
					sb.append((ds.isEmpty("mid"        )?"":ds.getString("mid"        )) +"|");          // 14
					sb.append((ds.isEmpty("mpid"       )?"":ds.getString("mpid"       )) +"|");          // 15
					sb.append((ds.isEmpty("mcid"       )?"":ds.getString("mcid"       )) +"|");          // 16
					sb.append((ds.isEmpty("mlevel"     )?"":ds.getString("mlevel"     )) +"|");          // 17
					sb.append((ds.isEmpty("mrank"      )?"":ds.getString("mrank"      )) +"|");          // 18
					sb.append((ds.isEmpty("mweight"    )?"":ds.getString("mweight"    )) +"|");          // 19
					sb.append((ds.isEmpty("mname"      )?"":ds.getString("mname"      )) +"|");          // 20
					sb.append((ds.isEmpty("measureid"  )?"":ds.getString("measureid"  )) +"|");          // 21
					sb.append((ds.isEmpty("etlkey"     )?"":ds.getString("etlkey"     )) +"|");          // 22
					sb.append((ds.isEmpty("measurement")?"":ds.getString("measurement")) +"|");          // 23
					sb.append((ds.isEmpty("frequency"  )?"":ds.getString("frequency"  )) +"|");          // 24
					sb.append((ds.isEmpty("trend"      )?"":ds.getString("trend"      )) +"|");          // 25

					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());			
		}
		
		//---------------------------------------------------------------------------------------------
		// 특정 지표생성 및 항목복사...
		//---------------------------------------------------------------------------------------------
		else if(div_gn.equals("getMeasCopy"))	{

			// 지표대상부서를 구함.
		    BscTreeUtil util= new BscTreeUtil();
		    util.getMeasCopy(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("cid")?"":ds.getString("cid")) +"|");           		// 1
					sb.append((ds.isEmpty("cpid")?"":ds.getString("cpid")) +"|");           		// 
					sb.append((ds.isEmpty("ccid")?"":ds.getString("ccid")) +"|");           		// 
					sb.append((ds.isEmpty("clevel")?"":ds.getString("clevel")) +"|");           		// 
					sb.append((ds.isEmpty("crank")?"":ds.getString("crank")) +"|");           		// 5
					sb.append((ds.isEmpty("cweight")?"":ds.getString("cweight")) +"|");           		//
					sb.append((ds.isEmpty("cname")?"":ds.getString("cname")) +"|");           		//
					sb.append((ds.isEmpty("sid")?"":ds.getString("sid")) +"|");           		//
					sb.append((ds.isEmpty("spid")?"":ds.getString("spid")) +"|");           		//
					sb.append((ds.isEmpty("scid")?"":ds.getString("scid")) +"|");           		// 10
					sb.append((ds.isEmpty("slevel")?"":ds.getString("slevel")) +"|");           		//
					sb.append((ds.isEmpty("srank")?"":ds.getString("srank")) +"|");           		//
					sb.append((ds.isEmpty("sweight")?"":ds.getString("sweight")) +"|");           		//
					sb.append((ds.isEmpty("sname")?"":ds.getString("sname")) +"|");           		//
					sb.append((ds.isEmpty("bid")?"":ds.getString("bid")) +"|");           		// 15
					sb.append((ds.isEmpty("bpid")?"":ds.getString("bpid")) +"|");           		//
					sb.append((ds.isEmpty("bcid")?"":ds.getString("bcid")) +"|");           		//
					sb.append((ds.isEmpty("blevel")?"":ds.getString("blevel")) +"|");           		//
					sb.append((ds.isEmpty("brank")?"":ds.getString("brank")) +"|");           		//
					sb.append((ds.isEmpty("bweight")?"":ds.getString("bweight")) +"|");           		// 20
					sb.append((ds.isEmpty("bname")?"":ds.getString("bname")) +"|");           		//
					sb.append((ds.isEmpty("pid")?"":ds.getString("pid")) +"|");           		//
					sb.append((ds.isEmpty("ppid")?"":ds.getString("ppid")) +"|");           		//
					sb.append((ds.isEmpty("pcid")?"":ds.getString("pcid")) +"|");           		//
					sb.append((ds.isEmpty("plevel")?"":ds.getString("plevel")) +"|");           		// 25 
					sb.append((ds.isEmpty("prank")?"":ds.getString("prank")) +"|");           		//
					sb.append((ds.isEmpty("pweight")?"":ds.getString("pweight")) +"|");           		//
					sb.append((ds.isEmpty("pname")?"":ds.getString("pname")) +"|");           		//
					sb.append((ds.isEmpty("oid")?"":ds.getString("oid")) +"|");           		//
					sb.append((ds.isEmpty("opid")?"":ds.getString("opid")) +"|");           		// 30
					sb.append((ds.isEmpty("ocid")?"":ds.getString("ocid")) +"|");           		//
					sb.append((ds.isEmpty("olevel")?"":ds.getString("olevel")) +"|");           		//
					sb.append((ds.isEmpty("orank")?"":ds.getString("orank")) +"|");           		//
					sb.append((ds.isEmpty("oweight")?"":ds.getString("oweight")) +"|");           		//
					sb.append((ds.isEmpty("oname")?"":ds.getString("oname")) +"|");           		// 35
					sb.append((ds.isEmpty("mid")?"":ds.getString("mid")) +"|");           		//
					sb.append((ds.isEmpty("mpid")?"":ds.getString("mpid")) +"|");           		//
					sb.append((ds.isEmpty("mcid")?"":ds.getString("mcid")) +"|");           		//
					sb.append((ds.isEmpty("mlevel")?"":ds.getString("mlevel")) +"|");           		//
					sb.append((ds.isEmpty("mrank")?"":ds.getString("mrank")) +"|");           		// 40
					sb.append((ds.isEmpty("mweight")?"":ds.getString("mweight")) +"|");           		//
					sb.append((ds.isEmpty("mname")?"":ds.getString("mname")) +"|");           		//
					sb.append((ds.isEmpty("measureid")?"":ds.getString("measureid")) +"|");           		//
					sb.append((ds.isEmpty("etlkey")?"":ds.getString("etlkey")) +"|");           		// 44

					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());	
		}	

		//---------------------------------------------------------------------------------------------
		// 점수 등급 가져오기
		//---------------------------------------------------------------------------------------------
		else if(div_gn.equals("getScoreLevel"))	{

			// 지표대상부서를 구함.
		    BscTreeUtil util= new BscTreeUtil();
		    util.getScoreLevel(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("ScoreCode")?"":ds.getString("ScoreCode")) +"|");           		// 1
					sb.append((ds.isEmpty("S")?"":ds.getString("S")) +"|");           		// 
					sb.append((ds.isEmpty("A")?"":ds.getString("A")) +"|");           		// 
					sb.append((ds.isEmpty("B")?"":ds.getString("B")) +"|");           		// 
					sb.append((ds.isEmpty("C")?"":ds.getString("C")) +"|");           		// 5
					sb.append((ds.isEmpty("D")?"":ds.getString("D")) +"|");           		//
					

					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());	
		}
		//-----------------------------------------------------------------------		
	}	
	
	// -------------------------------------------------------------------------
	// Update... Delete...	
	// -------------------------------------------------------------------------
	if (mode.equals("U"))	{

		System.out.println("updateMeasure Start...1");	
		
		// 지표 상위레벨 Insert/Update.
		if(div_gn.equals("updateTreeNode"))	{				
				BscTreeUtil util= new BscTreeUtil();
			    util.updateTreeNode(request, response);
				
			    DataSet ds = (DataSet)request.getAttribute("ds");
			    StringBuffer sb = new StringBuffer();
			    if (ds!=null){
			    	while(ds.next()){ 
			    		sb.append((ds.isEmpty("ID"       )?"0":ds.getString("ID"       ))+"|");
			    		sb.append((ds.isEmpty("NAME"     )?"" :ds.getString("NAME"     ))+"|");
			    		sb.append((ds.isEmpty("TREELEVEL")?"0":ds.getString("TREELEVEL"))+"|");
			    		sb.append((ds.isEmpty("WEIGHT"   )?"0":ds.getString("WEIGHT"   ))+"|");
			    		sb.append((ds.isEmpty("RANK"     )?"0":ds.getString("RANK"     ))+"|");
			    		sb.append((ds.isEmpty("CONTENTID")?"0":ds.getString("CONTENTID"))+"|");
			    		sb.append("\r\n");    		
			   		} 
			    }
			    out.println(sb.toString());		
		}
		
		// 지표코드변경.
		if(div_gn.equals("replaceMeasure"))	{							
			BscTreeUtil util= new BscTreeUtil();			
		    util.replaceMeasure(request, response);

		    DataSet ds = (DataSet)request.getAttribute("ds");
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		sb.append((ds.isEmpty("ID"       )?"0":ds.getString("ID"       ))+"|");
		    		sb.append((ds.isEmpty("NAME"     )?"" :ds.getString("NAME"     ))+"|");
		    		sb.append((ds.isEmpty("TREELEVEL")?"0":ds.getString("TREELEVEL"))+"|");
		    		sb.append((ds.isEmpty("WEIGHT"   )?"0":ds.getString("WEIGHT"   ))+"|");
		    		sb.append((ds.isEmpty("RANK"     )?"0":ds.getString("RANK"     ))+"|");
		    		sb.append((ds.isEmpty("CONTENTID")?"0":ds.getString("CONTENTID"))+"|");
		    		sb.append("\r\n");    		
		   		} 
		    }
		    out.println(sb.toString());
	    }		
		
		// 지표추가.
		if(div_gn.equals("insertMeasure"))	{							
			BscTreeUtil util= new BscTreeUtil();			
		    util.insertMeasure(request, response);

		    DataSet ds = (DataSet)request.getAttribute("ds");
		    StringBuffer sb = new StringBuffer();
		    if (ds!=null){
		    	while(ds.next()){ 
		    		sb.append((ds.isEmpty("ID"       )?"0":ds.getString("ID"       ))+"|");
		    		sb.append((ds.isEmpty("NAME"     )?"" :ds.getString("NAME"     ))+"|");
		    		sb.append((ds.isEmpty("TREELEVEL")?"0":ds.getString("TREELEVEL"))+"|");
		    		sb.append((ds.isEmpty("WEIGHT"   )?"0":ds.getString("WEIGHT"   ))+"|");
		    		sb.append((ds.isEmpty("RANK"     )?"0":ds.getString("RANK"     ))+"|");
		    		sb.append((ds.isEmpty("CONTENTID")?"0":ds.getString("CONTENTID"))+"|");
		    		sb.append("\r\n");    		
		   		} 
		    }
		    out.println(sb.toString());
	    }
		
		// 지표정의서 수정.
		if(div_gn.equals("updateMeasure"))	{	
			System.out.println("updateMeasure Start...");			
			
			BscTreeUtil util= new BscTreeUtil();	
	    	util.updateMeasure(request, response);
		
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    StringBuffer sb = new StringBuffer();
		    
		    String equ = (String)request.getAttribute("equ");
		    
		    if (equ!=null)
		    if ("true".equals(equ)){
			    if (ds!=null){
			    	while(ds.next()){ 
			    		sb.append(equ+"|");
			    		sb.append((ds.isEmpty("ID")?"0":ds.getString("ID"))+"|");
			    		sb.append((ds.isEmpty("NAME")?"":ds.getString("NAME"))+"|");
			    		sb.append((ds.isEmpty("TREELEVEL")?"0":ds.getString("TREELEVEL"))+"|");
			    		sb.append((ds.isEmpty("WEIGHT")?"0":ds.getString("WEIGHT"))+"|");
			    		sb.append((ds.isEmpty("RANK")?"0":ds.getString("RANK"))+"|");
			    		sb.append((ds.isEmpty("CONTENTID")?"0":ds.getString("CONTENTID"))+"|");
			    		sb.append("\r\n");    		
			   		} 
			    }
			    out.println(sb.toString());
		    } else {
		    	out.println("false|");
		    }		
		}    
		
		// 지표항목 복사...
		if(div_gn.equals("setMeasCopy"))	{		
				
				// 지표대상부서 복사 처리..
			    BscTreeUtil util= new BscTreeUtil();
			    util.setMeasCopy(request, response);
				
			    DataSet ds = (DataSet)request.getAttribute("ds");
			    
			    String copyOK = (String)request.getAttribute("rslt");
		    	out.println(copyOK);

		// 지표 년도 이관처리.    	
		}else if (div_gn.equals("setMeasYearCopy"))	{		

	    		System.out.println(" setMeasYearCopy Start...");			
				  
			    BscTreeUtil util= new BscTreeUtil();
			    util.setMeasYearCopy(request, response);
				
			    DataSet ds = (DataSet)request.getAttribute("ds");
			    
			    String copyOK = (String)request.getAttribute("rslt");
		    	out.println(copyOK);
	    		System.out.println(" setMeasYearCopy End..." + copyOK);

	    // 부서대 부서 지표복사		
		}else if (div_gn.equals("setMeasOrgCreate"))	{		

    		System.out.println(" setMeasOrgCreate Start...");			
		    BscTreeUtil util= new BscTreeUtil();			 			  
		    util.setMeasOrgCreate(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    
		    String copyOK = (String)request.getAttribute("rslt");
	    	out.println(copyOK);
    		System.out.println(" setMeasOrgCreate End..." + copyOK);
    		
		// 지표 년도 이관처리.
		}else if (div_gn.equals("setMeasCreateAll"))	{		

    		System.out.println(" setMeasCreateAll Start...");			
			BscTreeUtil util= new BscTreeUtil();			 			  
		    util.setMeasCreateAll(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    
		    String copyOK = (String)request.getAttribute("rslt");
	    	out.println(copyOK);
    		System.out.println(" setMeasCreateAll End..." + copyOK);


	    // 특정지표를 대상부서에 생성 ...
		}else if (div_gn.equals("setMeasCreate"))	{		

			System.out.println(" setMeasCreate Start...");			

		    BscTreeUtil util= new BscTreeUtil();			 			  
		    util.setMeasCreate(request, response);
			
		    DataSet ds = (DataSet)request.getAttribute("ds");
		    
		    String copyOK = (String)request.getAttribute("rslt");
	    	out.println(copyOK);
    		System.out.println(" setMeasCreate End..." + copyOK);
		}
		
	}
	
	// -------------------------------------------------------------------------
	// Delete...	
	// -------------------------------------------------------------------------
	if (mode.equals("D"))	{
		
			if(div_gn.equals("updateTreeNode"))	{				
				BscTreeUtil util= new BscTreeUtil();
			    util.updateTreeNode(request, response);
				
			    String result = (String) request.getAttribute("result");
			    if ((result==null) || ("".equals(result))) result="false";
			    out.println(result);	
			}		
			
			if(div_gn.equals("deleteMeasure"))	{				
				BscTreeUtil util= new BscTreeUtil();
			    util.deleteMeasure(request, response);
				
			    String result = (String) request.getAttribute("result");
			    if ((result==null) || ("".equals(result))) result="false";
			    out.println(result);	
			}					
		
			if (div_gn.equals("setMeasYearDeleteAll"))	{		
	
	    		System.out.println(" setMeasYearDeleteAll Start...");			
				  // 지표 년도 이관처리.
			    BscTreeUtil util= new BscTreeUtil();
			    util.setMeasYearDeleteAll(request, response);
				
			    DataSet ds = (DataSet)request.getAttribute("ds");
			    
			    String copyOK = (String)request.getAttribute("rslt");
		    	out.println(copyOK);
	    		System.out.println(" setMeasYearDeleteAll End..." + copyOK);
			}
			
			// 부서의 하위지표  All 삭제
			if (div_gn.equals("OrgMeasDeleteAll"))	{		
				
	    		System.out.println(" OrgMeasDeleteAll Start...");			
				  
			    BscTreeUtil util= new BscTreeUtil();
			    util.OrgMeasDeleteAll(request, response);
				
			    DataSet ds = (DataSet)request.getAttribute("ds");
			    
			    String copyOK = (String)request.getAttribute("rslt");
		    	out.println(copyOK);
	    		System.out.println(" OrgMeasDeleteAll End..." + copyOK);
			}							
	}	
	
%>
