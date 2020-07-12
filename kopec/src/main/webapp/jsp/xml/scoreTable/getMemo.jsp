<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String mode		= request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	= request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();
	
	if(mode.equals("R"))	{
		
		// 옛날 것...
		if(div_gn.equals("getMemo"))	{
			System.out.println(div_gn + " Strart...");			
		
		    ScoreTableUtil util= new ScoreTableUtil();
		    util.getMemo(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					String comments = ds.isEmpty("COMMENTS")?"":ds.getString("COMMENTS");
					comments = comments.replaceAll("\r\n","&&enter&&");					
					
					sb.append((ds.isEmpty("YM")?"":ds.getString("YM")) +"|");           		                        // 0
					sb.append((ds.isEmpty("ACTUAL")?"":ds.getString("ACTUAL")) +"|");           		        // 1
					sb.append((ds.isEmpty("PLANNED")?"":ds.getString("PLANNED")) +"|");           		    // 2
					sb.append((ds.isEmpty("PLANNEDBASE")?"":ds.getString("PLANNEDBASE")) +"|");   // 3
					sb.append((ds.isEmpty("BASE")?"":ds.getString("BASE")) +"|");           		                // 4
					sb.append((ds.isEmpty("BASELIMIT")?"":ds.getString("BASELIMIT")) +"|");           		// 5
					sb.append((ds.isEmpty("LIMIT")?"":ds.getString("LIMIT")) +"|");           		                // 6
					sb.append(comments+"|");	                                                                                     // 7
					sb.append((ds.isEmpty("UPDATEDATE")?"":ds.getString("UPDATEDATE")) +"|");        // 8
					sb.append((ds.isEmpty("UPDATENM")?"":ds.getString("UPDATENM")) +"|");           	 // 9					
					sb.append((ds.isEmpty("FILENAME")?"":ds.getString("FILENAME")) +"|");           		 //10
					sb.append((ds.isEmpty("GRADE")?"":ds.getString("GRADE")) +"|");           		 //11
					
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());			
			
		// 2008.05.02 by PHG, 지표간략정보를 구함.
		} else if(div_gn.equals("getMemoMeas"))	{			
		
		    ScoreTableUtil util= new ScoreTableUtil();
		    util.getMemoMeas(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
                    sb.append((ds.isEmpty("id"             )?"":ds.getString("id"              )) +"|"); 
                    sb.append((ds.isEmpty("measureid"      )?"":ds.getString("measureid"       )) +"|"); 
                    sb.append((ds.isEmpty("name"      )?"":ds.getString("name"       )) +"|");                     
                    sb.append((ds.isEmpty("frequency"      )?"":ds.getString("frequency"       )) +"|"); 
                    sb.append((ds.isEmpty("weight"         )?"":ds.getString("weight"          )) +"|"); 
                    sb.append((ds.isEmpty("equationdefine" )?"":Util.toText(ds.getString("equationdefine"  ))) +"|"); 
                    sb.append((ds.isEmpty("equation"       )?"":Util.toText(ds.getString("equation"        ))) +"|"); 
                    sb.append((ds.isEmpty("measurement"    )?"":ds.getString("measurement"     )) +"|"); 
                    sb.append((ds.isEmpty("etlkey"         )?"":ds.getString("etlkey"          )) +"|"); 
					                                                                                     
					sb.append("\r\n");    		
				} 
			}
			
			out.println(sb.toString());			

		// 2008.05.02 by PHG, 계량지표 구함
		} else 	if(div_gn.equals("getMemoMeasQty"))	{			
			
		    ScoreTableUtil util= new ScoreTableUtil();
		    util.getMemoMeasQty(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					String comments = ds.isEmpty("COMMENTS")?"":ds.getString("COMMENTS");
					comments = comments.replaceAll("\r\n","&&enter&&");					
					
					sb.append((ds.isEmpty("YM")?"":ds.getString("YM")) +"|");           		                        // 0
					sb.append((ds.isEmpty("ACTUAL")?"":ds.getString("ACTUAL")) +"|");           		        // 1
					sb.append((ds.isEmpty("PLANNED")?"":ds.getString("PLANNED")) +"|");           		    // 2
					sb.append((ds.isEmpty("PLANNEDBASE")?"":ds.getString("PLANNEDBASE")) +"|");   // 3
					sb.append((ds.isEmpty("BASE")?"":ds.getString("BASE")) +"|");           		                // 4
					sb.append((ds.isEmpty("BASELIMIT")?"":ds.getString("BASELIMIT")) +"|");           		// 5
					sb.append((ds.isEmpty("LIMIT")?"":ds.getString("LIMIT")) +"|");           		                // 6
					sb.append(comments+"|");	                                                                                     // 7
					sb.append((ds.isEmpty("FILENAME")?"":ds.getString("FILENAME")) +"|");           		 //8
					sb.append((ds.isEmpty("GRADE")?"":ds.getString("GRADE")) +"|");           		 //9
					sb.append((ds.isEmpty("FILEPATH")?"":ds.getString("FILEPATH")) +"|");           		 //10
					
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());			

			// 2008.05.02 by PHG, 계량지표 지표항목		
		}	else if(div_gn.equals("getMemoMeasQtyItem"))	{			
			
		    ScoreTableUtil util= new ScoreTableUtil();
		    util.getMemoMeasQtyItem(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
					sb.append((ds.isEmpty("code")?"":ds.getString("code")) +"|");           		                // 0
					sb.append((ds.isEmpty("itemname")?"":ds.getString("itemname")) +"|");           		// 1
					sb.append((ds.isEmpty("itementry")?"":ds.getString("itementry")) +"|");           		    // 2
					sb.append((ds.isEmpty("actual")?"":ds.getString("actual")) +"|");                              // 3
					
					sb.append("\r\n");    		
				} 
			}
			out.println(sb.toString());			

		// 2008.05.02 by PHG, 비계량지표 구함
		} else	if(div_gn.equals("getMemoMeasQly"))	{			
			
		    ScoreTableUtil util= new ScoreTableUtil();
		    util.getMemoMeasQly(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
		    		
					sb.append((ds.isEmpty("ym")?"":ds.getString("ym")) +"|");           		                        // 0
			    	sb.append((ds.isEmpty("planned"   )?"":Util.toTextForFlexMeas(ds.getString("planned"   )))+"|");
			    	sb.append((ds.isEmpty("detail"    )?"":Util.toTextForFlexMeas(ds.getString("detail"    )))+"|");
			    	sb.append((ds.isEmpty("estigrade" )?"":Util.toTextForFlexMeas(ds.getString("estigrade" )))+"|");
			    	sb.append((ds.isEmpty("estimate"  )?"":Util.toTextForFlexMeas(ds.getString("estimate"  )))+"|");
			    	sb.append((ds.isEmpty("filename"  )?"":Util.toTextForFlexMeas(ds.getString("filename"  )))+"|");
			    	sb.append((ds.isEmpty("grade"     )?"":Util.toTextForFlexMeas(ds.getString("grade"  )))+"|");
			    	sb.append((ds.isEmpty("filepath"  )?"":Util.toTextForFlexMeas(ds.getString("filepath"     )))+"|");
			    	sb.append((ds.isEmpty("filename_plan"  )?"":Util.toTextForFlexMeas(ds.getString("filename_plan")))+"|");
			    	sb.append((ds.isEmpty("filepath_plan"  )?"":Util.toTextForFlexMeas(ds.getString("filepath_plan")))+"|");
			    	sb.append((ds.isEmpty("evalopinion"  )?"":Util.toTextForFlexMeas(ds.getString("evalopinion"  )))+"|");
			    	sb.append((ds.isEmpty("evalrnm"  )?"":Util.toTextForFlexMeas(ds.getString("evalrnm"      )))+"|");
			    	
					sb.append("\r\n");    		
				} 
			}

			out.println(sb.toString());		
			System.out.println(sb.toString());		
		}				
	}	
	
	%>
