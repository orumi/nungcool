<%@page import="java.util.HashMap"%>
<%@page language="java"  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%@page import="java.util.List"%>  
<%@page import="exam.com.req.model.*"%>
<%@page import="tems.com.testBaseManagement.Common.Common"%>
<%@page import="exam.com.common.StringUtils"%>
<%@page import="java.util.Date"%>
<%

  List<ResultVO> listVO = (List<ResultVO>)request.getAttribute("listVO");
  String reqid = request.getParameter("reqid");
  String smpid = request.getParameter("smpid");
  
  String kolasyn = request.getAttribute("kolasyn")!=null?(String)request.getAttribute("kolasyn"):"";
  
  List<PriceVO> priceVO = (List<PriceVO>)request.getAttribute("priceVO");
  
  
  if(priceVO!=null && priceVO.size()>0){
%>	  
	<script>
		$("#totalprice", parent.document).val("<%=priceVO.get(0).getTotalprice()%>");
	</script>  
<%	  
  }
%>


<form name="frmResult">
	<input type="hidden" name="reqid" id="reqid" value="<%=reqid %>" >
	<input type="hidden" name="smpid" id="smpid" value="<%=smpid %>" >

</form>

<div style="height:35px;overflow-y: scroll;">
<table summary="검사항목" class="table_h" >

	<colgroup>
	<col width="4%"/>
	<col width="4%"/>
	<col width="16%"/>   <!--항목명   -->
	<col width="16%"/>   <!--시험조건   -->
	
	<col width="13%"/>   <!--단위   -->
	<col width="15%"/>   <!--시험방법   -->
	<col width="7%"/>    <!--수수료   -->
	
	<col width="14%"/>   <!--비고   -->
	<col width="10%"/>     <!--요구규격   -->
	</colgroup>
	
	<tr>
		<th>선택<br><input type="checkbox" id="chkAll" name="chkAll" onclick="javascript:clickCheckAll(this);"></th>
		<th>순번</th>
		<th>항목명</th>
		<th>시험조건</th>
		<th>단위</th>
		<th>시험방법</th>
		<th>수수료</th>
		<th>비고</th>
		<th class="b_R_none">요구규격</th>
	</tr>
</table>
</div>
<div style="height: 514px; overflow: auto; ">
<table summary="검사항목" class="table_h" >

	<colgroup>
	<col width="4%"/>
	<col width="4%"/>
	<col width="16%"/>   <!--항목명   -->
	<col width="16%"/>   <!--시험조건   -->
	
	<col width="13%"/>   <!--단위   -->
	<col width="15%"/>   <!--시험방법   -->
	<col width="7%"/>    <!--수수료   -->
	
	<col width="14%"/>   <!--비고   -->
	<col width="10%"/>     <!--요구규격   -->
	</colgroup>	
<%
		

    if(listVO!=null)
 	for(int i=0; i<listVO.size(); i++){
		
			ResultVO re_items = listVO.get(i);
			
			/* 단위 */
			String background_color = "";
			if( re_items.getIsadd().equals("Y")){
				background_color = "#CCE0FF";   // 신규 추가 
			}
			
			if( re_items.getMethodtag().equals("N") || re_items.getCondtag().equals("N") ){
					background_color = "#FFD7D7";
			}
			 
			String tmp_unit;
			if(  "-".equals(re_items.getUnitid()) && "-".equals(re_items.getSunit()) ){
				tmp_unit = "";
			} else {
			
				tmp_unit = "<option value='"+StringUtils.nvl(re_items.getUnitid(),"")+"'>"+StringUtils.nvl(re_items.getUnitid(),"")+"</option>";
				String etc_units = re_items.getSunit();
				
				if(etc_units!=null){
					String[] a_unit = etc_units.split("\\,");
					
					for(int a=0; a < a_unit.length; a++){
						if(!(re_items.getUnitid()!=null?re_items.getUnitid():"").equals(a_unit[a])){
							tmp_unit += "<option value='"+a_unit[a]+"'>"+a_unit[a]+"</option>";
						}
					}
				}
				tmp_unit += "<option value='-1'> 그외 </option>";
		
			}
			
			/*시험방법*/
			String tmp_method = "";
			String etc_methodNM = re_items.getSmethodname();
			String etc_methodID = re_items.getSmethodid();
			
			if("1".equals( StringUtils.nvl(re_items.getMethodid(),"")) && ("1".equals(etc_methodID) ) ){
				tmp_method = "";
			} else {
				if(!"-1".equals(StringUtils.nvl(re_items.getMethodid(),"") ) ){
					tmp_method = "<option value='"+StringUtils.nvl(re_items.getMethodid(),"")+"'>"+StringUtils.nvl(re_items.getMethodnm(),"")+"</option>";
				}

				
				
				if(etc_methodID!=null){
					String[] a_methodID = etc_methodID.split("\\,");
					String[] a_methodNM = etc_methodNM.split("\\,");
					for(int a=0; a<a_methodID.length;a++){
						if(re_items.getMethodid()!=null && !re_items.getMethodid().equals(a_methodID[a])){
							tmp_method += "<option value='"+a_methodID[a]+"'>"+a_methodNM[a]+"</option>";
						}
					}
				}
				
				if(!"Y".equals(kolasyn)){
					if(!"-1".equals(StringUtils.nvl(re_items.getMethodid(),"") ) ){
						tmp_method    += "<option value='-1'>그외</option>";
					} else {
						tmp_method    += "<option value='-1' selected>그외</option>";
					}
				}
			
			
			}
			
			
			/* 시험 조건 */
			String tmp_cond = "";
			if(re_items.getCondid() == null && re_items.getScondid() == null){
				tmp_cond = "";
			} else {
			
				if(!"-1".equals(StringUtils.nvl(re_items.getCondid(),"") ) ){
					tmp_cond = "<option value='"+StringUtils.nvl(re_items.getCondid(),"")+"'>"+StringUtils.nvl(re_items.getCondname(),"")+"</option>";
				}
				String etc_condNM = re_items.getScondname();
				String etc_condID = re_items.getScondid();
				
				if(etc_condID!=null){
					String[] a_condNM = etc_condNM.split("\\,");
					String[] a_condID = etc_condID.split("\\,");
					for(int c=0; c< a_condID.length; c++){
						if(!(re_items.getCondid()!=null?re_items.getCondid():"").equals(a_condID[c])){
							tmp_cond += "<option value='"+a_condID[c]+"'>"+a_condNM[c]+"</option>";
						}
					}
				}
				
				
				if(!"-1".equals(StringUtils.nvl(re_items.getCondid(),"") ) ){
					tmp_cond += "<option value='-1'>그외</option>";
				} else {
					tmp_cond += "<option value='-1' selected>그외</option>";
				}
			
			}
			String lvl = re_items.getTreelvl();
			
			
			
	%>			
			<!-- /*시작 부분*/ -->
			<tr id="tr_<%=re_items.getResultid()%>" style="background-color:<%=background_color%>">
				<td class="txt_C"><input name="chk_tbl_item" value="<%=re_items.getResultid()%>" type="checkbox" itemid="<%=re_items.getItemid()%>" itemids="<%=re_items.getItemids() %>"  resultpid="<%=re_items.getResultpid() %>" leafs="<%=re_items.getLeafs()%>" onclick="javascript:clickItem(this);"/></td>
				<td class="txt_C"><%=(i+1)%></td>
				<td class="txt_L"><%=re_items.getItemname() %></td>
			
			
				<td class="txt_C">
				<% if ("".equals(tmp_cond)){ %>
				<div style="width:100%;text-align:center;">
					
				</div>
				<% } else { %>
				<div style="width:100%;text-align:center;">
					<div class="div_unit_sel">
					<select id="sel_cond_<%=re_items.getResultid()%>" name="sel_cond_<%=re_items.getResultid()%>" items="<%=re_items.getResultid()%>" class="h26m1" style="color:#0500E0;font-weight:500;width:<%="-1".equals(StringUtils.nvl(re_items.getCondid(),"") )?"50":"100" %>px;" onchange="javascript:changeCond(this);">
			        <%= tmp_cond %>
					</select>
					</div>
					<div class="div_unit_etc" id="div_unit_etc_<%=re_items.getResultid()%>" style="display:<%="-1".equals(StringUtils.nvl(re_items.getCondid(),"") )?"inline":"none" %>;">
						<% if(re_items.getStempunit()!=null && !"".equals(re_items.getStempunit())){ %>
						<div style="text-align:left;">
						<input id="etc_temp_<%=re_items.getResultid()%>" name="etc_temp_<%=re_items.getResultid()%>" type="text" value="<%=StringUtils.nvl(re_items.getTempercond(),"")%>" class="h22m1" style="width:40px;text-align:right;" />
						<input type="hidden" id="etc_temp_unitid_<%=re_items.getResultid()%>" name="etc_temp_unitid_<%=re_items.getResultid()%>" value="<%=re_items.getStempunitid()%>">
						<div class="div_unit" id="etc_temp_unit_<%=re_items.getResultid()%>" name="etc_temp_unit_<%=re_items.getResultid()%>" style="width:25px;"><%=StringUtils.nvl(re_items.getStempunit(),"")%></div>
						</div>
						<% } %>
						<% if(re_items.getStimeunit()!=null && !"".equals(re_items.getStimeunit() )){ %>
						<div style="text-align:left;">
						<input id="etc_time_<%=re_items.getResultid()%>" name="etc_time_<%=re_items.getResultid()%>" type="text" value="<%=StringUtils.nvl(re_items.getTimecond(),"")%>" class="h22m1" style="width:40px;text-align:right;" />
						<input type="hidden" id="etc_time_unitid_<%=re_items.getResultid()%>" name="etc_time_unitid_<%=re_items.getResultid()%>" value="<%=re_items.getStimecondunitid()%>">
						<div class="div_unit" id="etc_time_unit_<%=re_items.getResultid()%>" name="etc_time_unit_<%=re_items.getResultid()%>" style="width:25px;"><%=StringUtils.nvl(re_items.getStimeunit(),"")%></div>
						</div>
						<% } %>
					</div>
				</div>
				<% } %>
				
				</td>			
			
				<td class="txt_C">
				<% if("".equals(tmp_unit)){ %>
				<div style="width:100%;text-align:center;">
					
				</div>
				<% } else { %>
				<div style="width:100%;float:left;">
					<select id="sel_unit_<%=re_items.getResultid()%>" name="sel_unit_<%=re_items.getResultid()%>" items="<%=re_items.getResultid()%>" class="h26" style="color:#0500E0;font-weight:500;width:94px;" onchange="javascript:changeUnit(this);">
			        <%= tmp_unit %>
					</select>
					<input id="etc_unit_<%=re_items.getResultid()%>" name="etc_unit_<%=re_items.getResultid()%>" type="text" value="" class="h24" style="color:#0500E0;font-weight:500;width:37px;display:none" />
				</div>	
				<% } %>
				</td>
				<td class="txt_C">
			    <% if("".equals(tmp_method)){ %>
			    <div style="width:100%;text-align:center;">
					
				</div>
			    <% } else { %>
					<select id="sel_method_<%=re_items.getResultid()%>" name="sel_method_<%=re_items.getResultid()%>" class="h26" style="color:#0500E0;font-weight:500;width:108px;" onchange="javascript:changeMethod('<%=re_items.getResultid()%>');">
			        <%=tmp_method %>
					</select>
					
				<% } %>	
				</td>
				<td class="txt_R"><%=StringUtils.nvl(re_items.getItemprice(),"") %></td>
				
			
				<td class="txt_L"><%=StringUtils.nvl(re_items.getRemark(),"")%></td>
				<td class="txt_C b_R_none">
				<% if("".equals(tmp_method)){ %>
			    <div style="width:100%;text-align:center;">
					
				</div>
			    <% } else { %>
					<input type="text" id="txt_reqspec_<%=re_items.getResultid()%>" name="txt_reqspec_<%=re_items.getResultid()%>" value="<%=StringUtils.nvl(re_items.getReqspec(),"")%>" class="h24" style="width:80px;<%=(re_items.getMethodid().equals("-1"))?"display:inline;":"display:none;" %>" />
				<% } %>	
				</td>
			</tr>
		
<%		
		}
 	
%>	
	
</table>	
</div>
									




