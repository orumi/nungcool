<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.util.*,
                 com.nc.tree.*,
                 com.nc.xml.*" 
%>
<%
	String mode = (request.getParameter("mode")==null?"":request.getParameter("mode"));

	MeasUtil util= new MeasUtil();
    util.getMeasTree(request, response);			
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

			sb.append((ds.isEmpty("measureid"  )?"":ds.getString("measureid"  )) +"|");          // 41
			sb.append((ds.isEmpty("frequency"  )?"":ds.getString("frequency"  )) +"|");          // 42
			    		
    		sb.append("\r\n");    		                       
   		} 
    }
    out.println(sb.toString());			
    
%>
