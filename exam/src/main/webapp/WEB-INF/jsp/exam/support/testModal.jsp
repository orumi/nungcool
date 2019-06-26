<%@ page language="java"  contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>



<!--  항목 추가  -->
<div id="form_addItems" title="항목추가" >
  <form>
    <fieldset>

	<!-- popup_In -->
	<div class="popup_In">
		<!-- popup_In_table -->
		<div class="popup_In_table">
			<table summary="시료명" class="table_w">
				<colgroup>
				<col width="120px"/>
				<col width="*"/>
				</colgroup>
				<tr>
					<th class="bor_T_color01 bor_B_color01 bor_L_color01" >항목검색</th>
					<td class="bor_T_color01 bor_R_color01 bor_B_color01 ">
					<div class="input-group">
						<input type="text" id="searchItemname" name="searchItemname" value="" class="inputBox" style="width:68%" />
						<div class="input-group-btn">
							<button id="btn_select_items" name="btn_select_items" class="btn" onclick="javascript:actionPerformed('selectItems'); ">검색</button>
						</div>
					</div>	
					</td>
				</tr>
				<tr>
					<td class="bor_T_color01 bor_R_color01 bor_B_color01 " colspan="2">
						<div style="float:left;margin:3px 3px;">
						<div class="div_search" onclick="javascript:actionSelectItemsRange('가','나');">ㄱ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('나','다');">ㄴ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('다','라');">ㄷ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('라','마');">ㄹ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('마','바');">ㅁ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('바','사');">ㅂ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('사','아');">ㅅ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('아','자');">ㅇ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('자','차');">ㅈ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('차','카');">ㅊ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('카','타');">ㅋ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('타','파');">ㅌ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('파','하');">ㅍ</div>
						<div class="div_search" onclick="javascript:actionSelectItemsRange('하','히');">ㅎ</div>
						<!--   
						<div class="div_search"><a href="javascript:actionSelectItemsCheck();">KKKKK</a></div>
						-->
						</div>
						<div style="float:left;margin:3px 3px;">
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('a','b');">A</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('b','c');">B</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('c','d');">C</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('d','e');">D</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('e','f');">E</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('f','g');">F</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('g','g');">G</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('h','i');">H</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('i','j');">I</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('j','k');">J</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('k','l');">K</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('l','m');">L</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('m','n');">M</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('n','o');">N</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('o','p');">O</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('p','q');">P</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('q','r');">Q</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('r','s');">R</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('s','t');">S</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('t','u');">T</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('u','v');">U</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('v','w');">V</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('w','x');">W</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('x','y');">X</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('y','z');">Y</div>
						<div class="div_search_eng" onclick="javascript:actionSelectItemsRange('z','zz');">Z</div>
						</div>
					</td>
				</tr>
			</table>
		</div>	
		
		<div id="div_searchDetail" class="table_bg" style="width:100%;height:120px;overflow:scroll;overflow-y: scroll; overflow-x: hidden; display: none;">
			<table summary="항목 목록" class="table_h" id="tbl_searchDetail" style="border-top: 2px solid #D4D4D4;">
				<colgroup>
				<col width="10%"/>
				<col width="*"/>
				</colgroup>
				<tr>
					<th>선택</th>
					<th class="b_R_none">참발열량 세부 검색</th>
				</tr>
				
			</table>
		</div>
		<!-- table_bg -->
		<div id="div_selectItems" class="table_bg" style="width:100%; height:580px;overflow: scroll;overflow-y: scroll; overflow-x: hidden; display:inline;">
			<table summary="항목 목록" class="table_h" id="tbl_selectItems" style="border-top: 2px solid #D4D4D4;">
				<colgroup>
				<col width="5%"/>
				<col width="*"/>
				<col width="60%"/>
				</colgroup>
				<tr>
					<th>선택</th>
					<th>항목명</th>
					<th class="b_R_none">시험방법 선택(비고)</th>
				</tr>
				
			</table>
		</div>
		
		
				<!-- table_bg -->
		<div id="div_duplicate" class="table_bg" style="width:100%; height:580px;overflow: scroll;overflow-y: scroll; overflow-x: hidden; display: none;">
			<table summary="항목 상위 선택" class="table_h" id="tbl_duplicate" style="border-top: 2px solid #D4D4D4;">
				<colgroup>
				<col width="10%"/>
				<col width="20%"/>
				<col width="10%"/>
				<col width="20%"/>
				<col width="20%"/>
				<col width="20%"/>
				</colgroup>
				<tr>
					<th style="border-bottom-color: #929292;">상위 선택</th>
					<th style="border-bottom-color: #929292;">항목명</th>
					<th style="border-bottom-color: #929292;">시험조건</th>
					<th style="border-bottom-color: #929292;">단위</th>
					<th style="border-bottom-color: #929292;">시험방법</th>
					<th class="b_R_none"  style="border-bottom-color: #929292;">비고</th>
				</tr>
				
			</table>
		</div>
			<!-- //table_bg  -->
		<!-- //popup_In_table -->
	</div>
	<!-- //popup_In -->
	
	
	
	
    <!-- Allow form submission with keyboard without duplicating the dialog button  -->
    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    
    </fieldset>
    
    
  </form>
</div>



<!-- 유종제품 선택  -->
<div id="form_addSample" title="유종제품선택">
  <p class="validateTips">신청하고자하는 제품명을 클릭하십시오.</p>
 
  <form>
    <fieldset>
	<!-- popup_In -->
	<div class="popup_In">
		<!-- popup_In_table -->
		<div class="popup_In_table">
			<!-- btn_W_com -->
			<div class="btn_W_com" id="div_class">
				
				
			</div>	


<!-- table_bg -->
			<div class="table_bg" style="width:100%; height:600px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
				<table summary="시료정보" class="table_h" id="tbl_master_list">
					<colgroup>
					<col width="170px;"/>
					<col width="*"/>
					</colgroup>
					<tr>
						<th>유종</th>
						<th class="b_R_none">제품</th>
					</tr>
					
				</table>
			</div>

		</div>
	</div>	
	
	
	
	
    <!-- Allow form submission with keyboard without duplicating the dialog button  -->
    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    
    </fieldset>
    
    
  </form>
</div>





<div id="form_editSample" title="시료명칭">
  <p class="validateTips">시료명을 작성하십시오.</p>
 
  <form>
    <fieldset>

	<input type="hidden" name="add_masterId" id="add_masterId" />


	<!-- popup_In -->
	<div class="popup_In">
		<!-- popup_In_table -->
		<div class="popup_In_table">
			<table summary="시료명" class="table_w">
				<colgroup>
				<col width="20%"/>
				<col width="*"/>
				</colgroup>
				<tr>
					<th class="bor_T_color01 bor_B_color01 bor_L_color01">시료명</th>
					<td class="bor_T_color01 bor_R_color01 bor_B_color01 "><input type="text" name="add_sampleName" id="add_sampleName" value="" class="h30" style="width:98%" /></td>
				</tr>
			</table>
		</div>
		<!-- //popup_In_table -->
	</div>
	<!-- //popup_In -->
	 
	
	
	
    <!-- Allow form submission with keyboard without duplicating the dialog button  -->
    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    
    </fieldset>
    
    
  </form>
</div>









<!--  템블릿 저장하기  -->
<div id="form_insertTemplet" title="템블릿 저장하기" >
  <p class="validateTips">템블릿 목록</p>
 
  <form>
    <fieldset>

	<!-- popup_In -->
	<div class="popup_In">

		<!-- table_bg -->
			<div class="table_bg" id="div_templet" style="width:100%; height:250px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
				<table summary="템블릿 목록" class="table_h" id="tbl_selectTemplet">
					<colgroup>
					<col width="10%"/>
					<col width="30%"/>
					<col width="*"/>
					<col width="30%"/>
					</colgroup>
					<tr>
						<th>선택</th>
						<th>템블릿명</th>
						<th>시료/제품명</th>
						<th class="b_R_none">템블릿 설명</th>
					</tr>
					
				</table>
			</div>
			<!-- //table_bg  -->
		<!-- //popup_In_table -->
	</div>
	<!-- //popup_In -->
	
	
	
    <!-- Allow form submission with keyboard without duplicating the dialog button  -->
    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    
    </fieldset>
    
    
  </form>
</div>



<!--  템블릿 가져오기  -->
<div id="form_adjustTemplet" title="템블릿 가져오기" >
  <p class="validateTips">템블릿 목록</p>
 
  <form>
    <fieldset>

	<!-- popup_In -->
	<div class="popup_In">

		<!-- table_bg -->
			<div class="table_bg" id="div_adjustTemple" style="width:100%; height:250px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
				<table summary="템블릿 목록" class="table_h" id="tbl_adjustTemplet">
					<colgroup>
					<col width="10%"/>
					<col width="30%"/>
					<col width="*"/>
					<col width="30%"/>
					</colgroup>
					<tr>
						<th>선택</th>
						<th>템블릿명</th>
						<th>시료/제품명</th>
						<th class="b_R_none">템블릿 설명</th>
					</tr>
					
				</table>
			</div>
			<!-- //table_bg  -->
		<!-- //popup_In_table -->
	</div>
	<!-- //popup_In -->
	
	
	
    <!-- Allow form submission with keyboard without duplicating the dialog button  -->
    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    
    </fieldset>
    
    
  </form>
</div>







<!--  템블릿 가져오기  -->
<div id="form_copySample" title="시료복사" >
	<div style="width:100%;height:28px;">
  		<p class="validateTips" style="float:left;">시료 목록</p>
  		
	 	<select name="smplcopycnt" id="smplcopycnt" style="width:80px;float:right">
	 		<option value="1">1</option>
	 		<option value="2">2</option>
	 		<option value="3">3</option>
	 		<option value="4">4</option>
	 		<option value="5">5</option>
	 		<option value="6">6</option>
	 		<option value="7">7</option>
	 		<option value="8">8</option>
	 		<option value="9">9</option>
	 		<option value="10">10</option>
	 		<option value="20">20</option>
	 		<option value="30">30</option>
	 	</select>
	 	<span style="float:right; padding-top:3px; padding-right:6px; font-size:12px; font-weight:500; color:#ff0000">시료복사 개수 선택 :  </span>
 	</div>
  <form>
    <fieldset>

	<!-- popup_In -->
	<div class="popup_In">

		<!-- table_bg -->
			<div class="table_bg" id="div_copySample" style="width:100%; height:250px;overflow: scroll;overflow-y: scroll; overflow-x: hidden">
				<table summary="템블릿 목록" class="table_h" id="tbl_copySample">
					<colgroup>
					<col width="10%"/>
					<col width="50%"/>
					<col width="*"/>
					</colgroup>
					<tr>
						<th>선택</th>
						<th>시료명</th>
						<th>제품명</th>
					</tr>
					
				</table>
			</div>
			<!-- //table_bg  -->
		<!-- //popup_In_table -->
	</div>
	<!-- //popup_In -->
	
	
	
    <!-- Allow form submission with keyboard without duplicating the dialog button  -->
    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    
    </fieldset>
    
    
  </form>
</div>







<!-- 우편번호 검색  -->
<div id="form_zipcode" title="우편번호 검색" style="    overflow: hidden;">
  <form>
    <fieldset>

	<!-- popup_In -->
	<div class="" style="width:100%;float:left;">
		<!-- popup_In_table -->
		
			<!-- popup -->
			<div class="" style="width:100%;border:0px;float:left;">
			 <h4 class="title01">도로명 주소 찾기</h4>
			 <!-- popup_In -->
			 <div class="popup_In" style="float:left;height:182px;">
			   
			     <div class="left_Box" style="float:left;   margin: 10px;" >
				     <div class="h5_title">
				      <h5>주소명 검색방법</h5>
				     </div>
					<div class="h_Table_line02"  style="float:left;width:100%; ">
						 <div class="top_Table_box" style="float:left;width:100%; overflow-x:hidden; overflow-y:hidden;"  >  
						 <table style="margin: 4px;">
						 <tr><td >
						 	1. 동 + 검물명 입력 : 예) '충무로1가(동명) 중앙우체국(건물명)'<br>
						 	2. 도로명 + 건물번호 입력 : 예)'소공로(도로명) 70(건물번호)'<br>
						 	3. 건물명 입력 : 예)'중앙우체국(건물명)'
						 </td></tr>
						 </table>
						 </div>
					</div>	 
				</div>
				   
			   <div class="search_Box" style="float:left;width:92%;margin-left:12px;margin-bottom: 12px;">
			    <table summary="검색" class="table01" >
			     <caption>검색</caption>
			     <colgroup>
			     <col width="80px"/>
			     <col width="*"/>
			     </colgroup>
			     <tr>
			      <th>시/도</th>
			      <td>
			       <select style="width:180px;"  name="cbLvl1" id="cbLvl1" onchange="">
			       </select>
			      </td>
			     </tr>
			     <tr><td style="height:3px;" colspan="4"></td></tr>
			     <tr>
			      <th>
					주소검색
			      </th>
			      <td  colspan="3">
			      	<select name="searchType" id="searchType" style="width:80px;">
			      		<option value="road">도로명</option>
			      		<option value="area">지번</option>
			      	</select>      
			       <input type="text" style="width:200px;"  name="txtSearch" id="txtSearch"  >
			      	<a href="#" onclick="actionSearchZipCode();" id="btnSearch" ><img src="<c:url value='/images/exam/btn/btn_inquiry01.gif'/>" alt="검색"  /></a>
			      </td>
			     </tr>     
			    </table>
			   </div>
			   
			
			
			    <div class="con_right_in" style="float:left; width:100%; ">
			
			

		
		    <!-- left_Box_top -->
		     <div class="left_Box" style="width:100%;" >
			     <!-- h5_title -->
			     <div class="h5_title">
			      <h5>주소목록</h5>
				      <div align="right" style="margin-right: 20px;margin-top:5px;">
				      		주소를 클릭하십시오.
				      </div>
			     </div>
		     <!-- //h5_title -->
		        
		        <!-- DataGrid 전체 DIV -->
				<div class="h_Table_line02"  style="width:100%;">
					 <div class="table_bg" style="width:100%; overflow-x:hidden; overflow-y:scroll;"  >      
					       <table summary="" class="table_h">
					        <thead id="tblHeader">
						        <tr>
						         <th style="width:5%"  dataField="rn" textAlign="center" >검색<br>순번</th>
						         <th style="width:15%" dataField="tblZipcode" textAlign="center" >우편번호</th>
						         <th style="width:35%"  dataField="tblRoadNameFull" textAlign="left" > 주소</th>
						        </tr>
					       	</thead>
					       </table>
					   </div>
					<!-- Grid List 전체 DIV width-2px  -->
		            <div class="bottom_T_box" id="tblList" style="width:100%;height:280px;overflow-x:hidden;overflow-y:scroll" onscroll="">
			            <table style="" class="table_h">
			                <tbody id="tblListbody"></tbody>    
			            </table>
		            </div>
		            <div style="margin-top: 7px;">
		            <!-- 
		            	<div id="paging"><strong>[</strong> 전체수:  0,  전체페이지 : 0,  현재페이지 : 0 <strong>]</strong> </div>
		             -->	
		            </div>            
				</div>
		    
		    
		    </div>
		    <!-- left_Box_top -->
		
		     </div>
		  </div>
		  <!-- //con_right -->
		 </div>
		 <!-- //container -->
 
 
 
			<!-- //table_bg  -->
		<!-- //popup_In_table -->
	</div>
	<!-- //popup_In -->
	
	
	
	
    <!-- Allow form submission with keyboard without duplicating the dialog button  -->
    <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    
    </fieldset>
    
    
  </form>
</div>





