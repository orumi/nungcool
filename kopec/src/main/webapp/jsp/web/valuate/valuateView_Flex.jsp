<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.nc.eval.*, com.nc.util.*, java.util.ArrayList"%>

<%
	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));
	
	String mode = request.getParameter("mode");
	AdminValuate util = new AdminValuate();
	
	if(mode.equals("getGroup")){ //// 그룹 가져올 경우
		util.setEvalGroup(request, response);
		DataSet dsGrp = (DataSet) request.getAttribute("dsGrp");
		StringBuffer sb = new StringBuffer();
		if(dsGrp != null){
			while(dsGrp.next()){
				sb.append(dsGrp.getString("GRPID") + "|");
				sb.append(dsGrp.getString("GRPNM"));
				sb.append("\r\n");
			}
		}
		if(sb.length() == 0){
			out.println("-");
		}else{
			out.println(sb.toString());
		}
	}else if(mode.equals("getScore")){ //// 점수 가져올 경우
		util.setEvalMeasure(request, response);
		
		EvalMeasureUtil meautil = (EvalMeasureUtil)request.getAttribute("meautil");
		
		if(meautil != null){
			ArrayList meaList = meautil.meaList;
			StringBuffer sb = new StringBuffer();
			System.out.println(meautil.meaList.size());
	   		for (int i=0;i<meaList.size();i++) {
	   			EvalMeasure mea = (EvalMeasure)meaList.get(i);
	   			
	   			/*
	   			if((double)ServerStatic.UPPER <= mea.getAvg()){
	   				sb.append(ServerStatic.UPPER + "|");
	   				sb.append("S" + "|");
	   			}else if((double)ServerStatic.HIGH <= mea.getAvg()){
	   				sb.append(ServerStatic.HIGH + "|");
	   				sb.append("A" + "|");
	   			}else if((double)ServerStatic.LOW <= mea.getAvg()){
	   				sb.append(ServerStatic.LOW + "|");
	   				sb.append("B" + "|");
	   			}else if((double)ServerStatic.LOWER <= mea.getAvg()){
	   				sb.append(ServerStatic.LOWER + "|");
	   				sb.append("C" + "|");
	   			}else if((double)ServerStatic.LOWER > mea.getAvg() && 0 < mea.getAvg()){
	   				sb.append(ServerStatic.LOWST + "|");
	   				sb.append("D" + "|");
	   			}else {
	   				sb.append("0" + "|");
	   				sb.append("-" + "|");
	   			}
	   		    */
	   			sb.append("0" + "|");
   				sb.append("-" + "|");
   			
	   			sb.append(mea.sname + "|");
	   			sb.append(mea.pname + "|");
	   			sb.append(mea.name + "|");
	   			sb.append(mea.bname + "|");
	   			sb.append(mea.belong + "|");
	   			sb.append(mea.weight + "|");
	   			sb.append(mea.frequency);
	   			
	   			sb.append("\r\n");
	   		}
	   		out.println(sb.toString());
	   		System.out.println(sb.toString());
		}	
	}	
%>