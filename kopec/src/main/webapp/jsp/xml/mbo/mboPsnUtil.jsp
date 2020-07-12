<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.mbo.*,
                 com.nc.util.*,
                 com.nc.xml.*" 
%>
<%
	request.setCharacterEncoding("UTF-8");

	//String mode		   = request.getParameter("mode")   == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	   = request.getParameter("div_gn") == null ? ""  : (request.getParameter("div_gn")).trim();

	
	
    //	부서에 속한 성과책임자 등록자 List.
	if(div_gn.equals("getPsnList"))	{
			mboPsnUtil util = new mboPsnUtil();
			util.getPsnList(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){ 
		    		sb.append((ds.isEmpty("emp_no"         )?"":ds.getString("emp_no"    ))+"|");
		    		sb.append((ds.isEmpty("emp_nm"         )?"":ds.getString("emp_nm"    ))+"|");
		    		sb.append((ds.isEmpty("in_seq"         )?"":ds.getString("in_seq"    ))+"|");
		    		sb.append((ds.isEmpty("in_rev"         )?"":ds.getString("in_rev"    ))+"|");
		    		
		    		sb.append((ds.isEmpty("in_jikmu"       )?"":ds.getString("in_jikmu"  ))+"|");
		    		sb.append((ds.isEmpty("organ_cd"       )?"":ds.getString("organ_cd"  ))+"|");
		    		sb.append((ds.isEmpty("organ_nm"       )?"":ds.getString("organ_nm"  ))+"|");
		    		sb.append((ds.isEmpty("saup_cd"        )?"":ds.getString("saup_cd"  ))+"|");		    		
		    		sb.append((ds.isEmpty("saup_nm"        )?"":ds.getString("saup_nm"   ))+"|");
		    		
		    		sb.append("\r\n");    	
				} 
			}
			out.println(sb.toString());
			
			//System.out.println(sb.toString());
	}				
    
     //	개인성과책임 List...
	if(div_gn.equals("getPsnAccountList"))	{
			mboPsnUtil util = new mboPsnUtil();
			util.getPsnAccountList(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){				
				while(ds.next()){ 
		    		sb.append((ds.isEmpty("emp_no"          )?"":ds.getString("emp_no"          ))+"|");
		    		sb.append((ds.isEmpty("emp_nm"          )?"":ds.getString("emp_nm"          ))+"|");
		    		sb.append((ds.isEmpty("in_seq"          )?"":ds.getString("in_seq"          ))+"|");
		    		sb.append((ds.isEmpty("in_rev"          )?"":ds.getString("in_rev"          ))+"|");		    		
		    		sb.append((ds.isEmpty("a_no"            )?"":ds.getString("a_no"            ))+"|");
		    		sb.append((ds.isEmpty("accountability"  )?"":Util.toTextForFlexMeas(ds.getString("accountability"  )))+"|");
		    		sb.append((ds.isEmpty("a_weight"        )?"":Util.toTextForFlexMeas(ds.getString("a_weight"        )))+"|");
		    		sb.append((ds.isEmpty("success_key"     )?"":Util.toTextForFlexMeas(ds.getString("success_key"     )))+"|");
		    		sb.append((ds.isEmpty("success_key2"    )?"":Util.toTextForFlexMeas(ds.getString("success_key2"    )))+"|");
		    		sb.append((ds.isEmpty("success_key3"    )?"":Util.toTextForFlexMeas(ds.getString("success_key3"    )))+"|");		    		
		    		
		    		sb.append("\r\n");    	
				} 
			}
			out.println(sb.toString());
	}				

	// Method : 개인 성과책임 -> 성과목표
	if(div_gn.equals("getPsnObject"))	{
			mboPsnUtil util = new mboPsnUtil();
			util.getPsnObject(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				while(ds.next()){      // object, plan, result,
		    		sb.append((ds.isEmpty("emp_no"            )?"":ds.getString("emp_no"        ))+"|");
		    		sb.append((ds.isEmpty("in_seq"            )?"":ds.getString("in_seq"          ))+"|");
		    		sb.append((ds.isEmpty("in_rev"            )?"":ds.getString("in_rev"          ))+"|");
		    		sb.append((ds.isEmpty("a_no"              )?"":ds.getString("a_no"            ))+"|");
		    		sb.append((ds.isEmpty("o_no"              )?"":ds.getString("o_no"            ))+"|");

		    		sb.append((ds.isEmpty("object"            )?"":Util.toTextForFlexMeas(ds.getString("object"          )))+"|");
		    		sb.append((ds.isEmpty("plan"              )?"":Util.toTextForFlexMeas(ds.getString("plan"            )))+"|");
		    		sb.append((ds.isEmpty("result"            )?"":Util.toTextForFlexMeas(ds.getString("result"          )))+"|");
		    		sb.append((ds.isEmpty("o_weight"          )?"":Util.toTextForFlexMeas(ds.getString("o_weight"        )))+"|");
		    		
		    		sb.append((ds.isEmpty("achieve_ex"        )?"":Util.toTextForFlexMeas(ds.getString("achieve_ex"      )))+"|");
		    		sb.append((ds.isEmpty("achieve_vg"        )?"":Util.toTextForFlexMeas(ds.getString("achieve_vg"      )))+"|");
		    		sb.append((ds.isEmpty("achieve_g"         )?"":Util.toTextForFlexMeas(ds.getString("achieve_g"       )))+"|");
		    		sb.append((ds.isEmpty("achieve_ni"        )?"":Util.toTextForFlexMeas(ds.getString("achieve_ni"      )))+"|");
		    		sb.append((ds.isEmpty("achieve_un"        )?"":Util.toTextForFlexMeas(ds.getString("achieve_un"      )))+"|");
		    		sb.append((ds.isEmpty("score1"            )?"":Util.toTextForFlexMeas(ds.getString("score1"          )))+"|");
		    				    		
		    		sb.append("\r\n");    	
				} 
			}
			out.println(sb.toString());
	}			
	
    //	개인성과책임 및 목표 List...
	if(div_gn.equals("getPsnAccountObjectList"))	{
			mboPsnUtil util = new mboPsnUtil();
			util.getPsnAccountObjectList(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){				
				while(ds.next()){ 
		    		sb.append((ds.isEmpty("emp_no"          )?"":ds.getString("emp_no"          ))+"|");
		    		sb.append((ds.isEmpty("emp_nm"          )?"":ds.getString("emp_nm"          ))+"|");
		    		sb.append((ds.isEmpty("in_seq"          )?"":ds.getString("in_seq"          ))+"|");
		    		sb.append((ds.isEmpty("in_rev"          )?"":ds.getString("in_rev"          ))+"|");		    		
		    		sb.append((ds.isEmpty("a_no"            )?"":ds.getString("a_no"            ))+"|");
		    		sb.append((ds.isEmpty("accountability"  )?"":Util.toTextForFlexMeas(ds.getString("accountability"  )))+"|");
		    		sb.append((ds.isEmpty("a_weight"        )?"":Util.toTextForFlexMeas(ds.getString("a_weight"        )))+"|");
		    		sb.append((ds.isEmpty("success_key"     )?"":Util.toTextForFlexMeas(ds.getString("success_key"     )))+"|");
		    		sb.append((ds.isEmpty("success_key2"    )?"":Util.toTextForFlexMeas(ds.getString("success_key2"    )))+"|");
		    		sb.append((ds.isEmpty("success_key3"    )?"":Util.toTextForFlexMeas(ds.getString("success_key3"    )))+"|");		    		
		    		
		    		sb.append((ds.isEmpty("o_no"              )?"":ds.getString("o_no"            ))+"|");
		    		sb.append((ds.isEmpty("object"            )?"":Util.toTextForFlexMeas(ds.getString("object"          )))+"|");
		    		sb.append((ds.isEmpty("o_weight"          )?"":Util.toTextForFlexMeas(ds.getString("o_weight"        )))+"|");
		    		sb.append((ds.isEmpty("plan"              )?"":Util.toTextForFlexMeas(ds.getString("plan"            )))+"|");
		    		sb.append((ds.isEmpty("result"            )?"":Util.toTextForFlexMeas(ds.getString("result"          )))+"|");
			    	
		    		sb.append("\r\n");    	
				} 
			}
			out.println(sb.toString());
	}	
    
	
    //	사장 성과책임.
	if(div_gn.equals("getAccountRoot"))	{
			mboPsnUtil util = new mboPsnUtil();
			util.getAccountRoot(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				
				while(ds.next()){ 
		    		sb.append((ds.isEmpty("emp_no"          )?"":ds.getString("emp_no"          ))+"|");
		    		sb.append((ds.isEmpty("emp_nm"          )?"":ds.getString("emp_nm"          ))+"|");
		    		sb.append((ds.isEmpty("in_seq"          )?"":ds.getString("in_seq"          ))+"|");
		    		sb.append((ds.isEmpty("in_rev"          )?"":ds.getString("in_rev"          ))+"|");	

		    		sb.append((ds.isEmpty("organ_cd"         )?"":ds.getString("organ_cd"             ))+"|");                       
		    		sb.append((ds.isEmpty("organ_nm"         )?"":ds.getString("organ_nm"             ))+"|");		    		           
		    		sb.append((ds.isEmpty("saup_cd"          )?"":ds.getString("saup_cd"              ))+"|");                       
		    		sb.append((ds.isEmpty("saup_nm"          )?"":ds.getString("saup_nm"              ))+"|");   		    		
		    		
		    		sb.append((ds.isEmpty("in_jikmu"        )?"":ds.getString("in_jikmu"        ))+"|");
		    		sb.append((ds.isEmpty("in_jikchk"       )?"":ds.getString("in_jikchk"       ))+"|");	
		    		sb.append((ds.isEmpty("jikchk_nm"       )?"":ds.getString("jikchk_nm"       ))+"|");	
		    		
		    		sb.append((ds.isEmpty("a_no"            )?"":ds.getString("a_no"            ))+"|");
		    		sb.append((ds.isEmpty("accountability"  )?"":Util.toTextForFlexMeas(ds.getString("accountability"  )))+"|");
		    		sb.append((ds.isEmpty("a_weight"        )?"":Util.toTextForFlexMeas(ds.getString("a_weight"        )))+"|");
		    		sb.append((ds.isEmpty("success_key"     )?"":Util.toTextForFlexMeas(ds.getString("success_key"     )))+"|");
		    		sb.append((ds.isEmpty("success_key2"    )?"":Util.toTextForFlexMeas(ds.getString("success_key2"    )))+"|");
		    		sb.append((ds.isEmpty("success_key3"    )?"":Util.toTextForFlexMeas(ds.getString("success_key3"    )))+"|");	
		    		
		    		sb.append("\r\n");    	
				} 
			}
			out.println(sb.toString());
			System.out.println(sb.toString());
	}		

    //	개인성과책임 List...
	if(div_gn.equals("getAccountTree"))	{
			mboPsnUtil util = new mboPsnUtil();
			util.getAccountTree(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				
				while(ds.next()){ 
		    		sb.append((ds.isEmpty("emp_no"           )?"":ds.getString("emp_no"               ))+"|");                       
		    		sb.append((ds.isEmpty("emp_nm"           )?"":ds.getString("emp_nm"               ))+"|");                       
		    		sb.append((ds.isEmpty("in_seq"           )?"":ds.getString("in_seq"               ))+"|");                       
		    		sb.append((ds.isEmpty("in_rev"           )?"":ds.getString("in_rev"               ))+"|");                       
		    		sb.append((ds.isEmpty("organ_cd"         )?"":ds.getString("organ_cd"             ))+"|");                       
		    		sb.append((ds.isEmpty("organ_nm"         )?"":ds.getString("organ_nm"             ))+"|");		    		           
		    		sb.append((ds.isEmpty("saup_cd"          )?"":ds.getString("saup_cd"              ))+"|");                       
		    		sb.append((ds.isEmpty("saup_nm"          )?"":ds.getString("saup_nm"              ))+"|");                       
		    		sb.append((ds.isEmpty("in_jikmu"         )?"":ds.getString("in_jikmu"             ))+"|");                       
		    		sb.append((ds.isEmpty("jikchknm"         )?"":ds.getString("jikchknm"             ))+"|");                       
		    		sb.append((ds.isEmpty("a_no"             )?"":ds.getString("a_no"                 ))+"|");                       
		    		sb.append((ds.isEmpty("a_weight"         )?"":ds.getString("a_weight"             ))+"|");                       
		    		sb.append((ds.isEmpty("accountability"   )?"":Util.toTextForFlexMeas(ds.getString("accountability"    )))+"|");	
		    		sb.append((ds.isEmpty("success_key"      )?"":Util.toTextForFlexMeas(ds.getString("success_key"       )))+"|");	
		    		sb.append((ds.isEmpty("success_key2"      )?"":Util.toTextForFlexMeas(ds.getString("success_key2"       )))+"|");	
		    		sb.append((ds.isEmpty("success_key3"      )?"":Util.toTextForFlexMeas(ds.getString("success_key3"       )))+"|");	

		    		sb.append((ds.isEmpty("emp_no1"          )?"":ds.getString("emp_no1"              ))+"|");                       
		    		sb.append((ds.isEmpty("emp_nm1"          )?"":ds.getString("emp_nm1"              ))+"|");                       
		    		
		    		sb.append((ds.isEmpty("in_1_saupdan"     )?"":ds.getString("in_1_saupdan"         ))+"|");                       
		    		sb.append((ds.isEmpty("in_seq_up"        )?"":ds.getString("in_seq_up"            ))+"|");                       
		    		sb.append((ds.isEmpty("in_rev_up"        )?"":ds.getString("in_rev_up"            ))+"|");                       
		    		sb.append((ds.isEmpty("a_no_up"          )?"":ds.getString("a_no_up"              ))+"|");                       
		    		
		    		sb.append((ds.isEmpty("emp_no2"          )?"":ds.getString("emp_no2"              ))+"|");                       
		    		sb.append((ds.isEmpty("emp_nm2"          )?"":ds.getString("emp_nm2"              ))+"|");                       
		    		sb.append((ds.isEmpty("in_2_saupdan"     )?"":ds.getString("in_2_saupdan"         ))+"|");        		           
		    		sb.append((ds.isEmpty("child"            )?"":ds.getString("child"                ))+"|");                       

		    		sb.append("\r\n");    	
				} 
			}
			out.println(sb.toString());
			
			System.out.println(sb.toString());
	}
	
	// Method : 개인 성과책임 -> 성과목표
	if(div_gn.equals("getAccountObject"))	{
		mboPsnUtil util = new mboPsnUtil();
		util.getAccountObject(request, response);
		
		DataSet ds = (DataSet)request.getAttribute("ds");
		StringBuffer sb = new StringBuffer();
		if (ds!=null){
			
			while(ds.next()){      // object, plan, result,
	    		sb.append((ds.isEmpty("emp_no"            )?"":ds.getString("emp_no"        ))+"|");
	    		sb.append((ds.isEmpty("in_seq"            )?"":ds.getString("in_seq"          ))+"|");
	    		sb.append((ds.isEmpty("in_rev"            )?"":ds.getString("in_rev"          ))+"|");
	    		sb.append((ds.isEmpty("a_no"              )?"":ds.getString("a_no"            ))+"|");
	    		sb.append((ds.isEmpty("o_no"              )?"":ds.getString("o_no"            ))+"|");

	    		sb.append((ds.isEmpty("object"            )?"":Util.toTextForFlexMeas(ds.getString("object"          )))+"|");
	    		sb.append((ds.isEmpty("plan"              )?"":Util.toTextForFlexMeas(ds.getString("plan"            )))+"|");
	    		sb.append((ds.isEmpty("result"            )?"":Util.toTextForFlexMeas(ds.getString("result"          )))+"|");
	    		sb.append((ds.isEmpty("o_weight"          )?"":Util.toTextForFlexMeas(ds.getString("o_weight"        )))+"|");
	    		
	    		sb.append((ds.isEmpty("achieve_ex"        )?"":Util.toTextForFlexMeas(ds.getString("achieve_ex"      )))+"|");
	    		sb.append((ds.isEmpty("achieve_vg"        )?"":Util.toTextForFlexMeas(ds.getString("achieve_vg"      )))+"|");
	    		sb.append((ds.isEmpty("achieve_g"         )?"":Util.toTextForFlexMeas(ds.getString("achieve_g"       )))+"|");
	    		sb.append((ds.isEmpty("achieve_ni"        )?"":Util.toTextForFlexMeas(ds.getString("achieve_ni"      )))+"|");
	    		sb.append((ds.isEmpty("achieve_un"        )?"":Util.toTextForFlexMeas(ds.getString("achieve_un"      )))+"|");
	    		sb.append((ds.isEmpty("score1"            )?"":Util.toTextForFlexMeas(ds.getString("score1"          )))+"|");
	    		sb.append((ds.isEmpty("ocid"             )?"":Util.toTextForFlexMeas(ds.getString("ocid"          )))+"|");
	    		sb.append((ds.isEmpty("oname"            )?"":Util.toTextForFlexMeas(ds.getString("oname"          )))+"|");
	    		
	    		sb.append("\r\n");    	
			} 
		}
		out.println(sb.toString());
	}				

    //	사장 성과책임목표.
	if(div_gn.equals("getTargetRoot"))	{
			mboPsnUtil util = new mboPsnUtil();
			util.getTargetRoot(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				
				while(ds.next()){ 
		    		sb.append((ds.isEmpty("emp_no"          )?"":ds.getString("emp_no"          ))+"|");
		    		sb.append((ds.isEmpty("emp_nm"          )?"":ds.getString("emp_nm"          ))+"|");
		    		sb.append((ds.isEmpty("in_seq"          )?"":ds.getString("in_seq"          ))+"|");
		    		sb.append((ds.isEmpty("in_rev"          )?"":ds.getString("in_rev"          ))+"|");	

		    		sb.append((ds.isEmpty("organ_cd"         )?"":ds.getString("organ_cd"             ))+"|");                       
		    		sb.append((ds.isEmpty("organ_nm"         )?"":ds.getString("organ_nm"             ))+"|");		    		           
		    		sb.append((ds.isEmpty("saup_cd"          )?"":ds.getString("saup_cd"              ))+"|");                       
		    		sb.append((ds.isEmpty("saup_nm"          )?"":ds.getString("saup_nm"              ))+"|");   		    		
		    		
		    		sb.append((ds.isEmpty("in_jikmu"        )?"":ds.getString("in_jikmu"        ))+"|");
		    		sb.append((ds.isEmpty("in_jikchk"       )?"":ds.getString("in_jikchk"       ))+"|");	
		    		sb.append((ds.isEmpty("jikchk_nm"       )?"":ds.getString("jikchk_nm"       ))+"|");	
		    		
		    		sb.append((ds.isEmpty("a_no"            )?"":ds.getString("a_no"            ))+"|");
		    		sb.append((ds.isEmpty("accountability"  )?"":Util.toTextForFlexMeas(ds.getString("accountability"  )))+"|");
		    		sb.append((ds.isEmpty("a_weight"        )?"":Util.toTextForFlexMeas(ds.getString("a_weight"        )))+"|");
		    		sb.append((ds.isEmpty("success_key"     )?"":Util.toTextForFlexMeas(ds.getString("success_key"     )))+"|");
		    		sb.append((ds.isEmpty("success_key2"    )?"":Util.toTextForFlexMeas(ds.getString("success_key2"    )))+"|");
		    		sb.append((ds.isEmpty("success_key3"    )?"":Util.toTextForFlexMeas(ds.getString("success_key3"    )))+"|");	

		    		sb.append((ds.isEmpty("o_no"            )?"":ds.getString("o_no"            ))+"|");
		    		sb.append((ds.isEmpty("object"          )?"":Util.toTextForFlexMeas(ds.getString("object"    )))+"|");
		    		sb.append((ds.isEmpty("o_weight"        )?"":Util.toTextForFlexMeas(ds.getString("o_weight"  )))+"|");
		    		sb.append((ds.isEmpty("plan"            )?"":Util.toTextForFlexMeas(ds.getString("plan"      )))+"|");
		    		sb.append((ds.isEmpty("result"          )?"":Util.toTextForFlexMeas(ds.getString("result"    )))+"|");
		    		
		    		sb.append("\r\n");    	
				} 
			}
			out.println(sb.toString());
	}		

    //	개인성과책임 List...
	if(div_gn.equals("getTargetTree"))	{
			mboPsnUtil util = new mboPsnUtil();
			util.getTargetTree(request, response);
			
			DataSet ds = (DataSet)request.getAttribute("ds");
			StringBuffer sb = new StringBuffer();
			if (ds!=null){
				
				while(ds.next()){ 
		    		sb.append((ds.isEmpty("emp_no"           )?"":ds.getString("emp_no"               ))+"|");                       
		    		sb.append((ds.isEmpty("emp_nm"           )?"":ds.getString("emp_nm"               ))+"|");                       
		    		sb.append((ds.isEmpty("in_seq"           )?"":ds.getString("in_seq"               ))+"|");                       
		    		sb.append((ds.isEmpty("in_rev"           )?"":ds.getString("in_rev"               ))+"|");                       
		    		sb.append((ds.isEmpty("organ_cd"         )?"":ds.getString("organ_cd"             ))+"|");                       
		    		sb.append((ds.isEmpty("organ_nm"         )?"":ds.getString("organ_nm"             ))+"|");		    		           
		    		sb.append((ds.isEmpty("saup_cd"          )?"":ds.getString("saup_cd"              ))+"|");                       
		    		sb.append((ds.isEmpty("saup_nm"          )?"":ds.getString("saup_nm"              ))+"|");                       
		    		sb.append((ds.isEmpty("in_jikmu"         )?"":ds.getString("in_jikmu"             ))+"|");                       
		    		sb.append((ds.isEmpty("jikchknm"         )?"":ds.getString("jikchknm"             ))+"|");                       
		    		sb.append((ds.isEmpty("a_no"             )?"":ds.getString("a_no"                 ))+"|");                       
		    		sb.append((ds.isEmpty("a_weight"         )?"":ds.getString("a_weight"             ))+"|");                       
		    		sb.append((ds.isEmpty("accountability"   )?"":Util.toTextForFlexMeas(ds.getString("accountability"    )))+"|");	
		    		sb.append((ds.isEmpty("success_key"      )?"":Util.toTextForFlexMeas(ds.getString("success_key"       )))+"|");	
		    		sb.append((ds.isEmpty("success_key2"      )?"":Util.toTextForFlexMeas(ds.getString("success_key2"       )))+"|");	
		    		sb.append((ds.isEmpty("success_key3"      )?"":Util.toTextForFlexMeas(ds.getString("success_key3"       )))+"|");	
		    		
		    		sb.append((ds.isEmpty("o_no"            )?"":ds.getString("o_no"            ))+"|");
		    		sb.append((ds.isEmpty("object"          )?"":Util.toTextForFlexMeas(ds.getString("object"    )))+"|");
		    		sb.append((ds.isEmpty("o_weight"        )?"":Util.toTextForFlexMeas(ds.getString("o_weight"  )))+"|");
		    		sb.append((ds.isEmpty("plan"            )?"":Util.toTextForFlexMeas(ds.getString("plan"      )))+"|");
		    		sb.append((ds.isEmpty("result"          )?"":Util.toTextForFlexMeas(ds.getString("result"    )))+"|");
		    		
		    		sb.append((ds.isEmpty("emp_no1"          )?"":ds.getString("emp_no1"              ))+"|");                       
		    		sb.append((ds.isEmpty("emp_nm1"          )?"":ds.getString("emp_nm1"              ))+"|");                       
		    		sb.append((ds.isEmpty("in_1_saupdan"     )?"":ds.getString("in_1_saupdan"         ))+"|");                       
		    		
		    		sb.append((ds.isEmpty("in_seq_up"        )?"":ds.getString("in_seq_up"            ))+"|");                       
		    		sb.append((ds.isEmpty("in_rev_up"        )?"":ds.getString("in_rev_up"            ))+"|");                       
		    		sb.append((ds.isEmpty("a_no_up"          )?"":ds.getString("a_no_up"              ))+"|");                       
		    		sb.append((ds.isEmpty("o_no_up"          )?"":ds.getString("o_no_up"              ))+"|");  
		    		                   
		    		sb.append((ds.isEmpty("emp_no2"          )?"":ds.getString("emp_no2"              ))+"|");                       
		    		sb.append((ds.isEmpty("emp_nm2"          )?"":ds.getString("emp_nm2"              ))+"|");                       
		    		sb.append((ds.isEmpty("in_2_saupdan"     )?"":ds.getString("in_2_saupdan"         ))+"|");        		           
		    		sb.append((ds.isEmpty("child"            )?"":ds.getString("child"                ))+"|");                       

		    		sb.append("\r\n");    	
				} 
			}
			out.println(sb.toString());
	}	
	
%>
