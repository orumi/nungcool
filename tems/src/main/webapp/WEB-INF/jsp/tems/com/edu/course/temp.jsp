<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">
<link rel="stylesheet" href="<c:url value='/css/tems/edu/edu_.css' />">



<!-- /row-->
<div class="contant">

<!-- --------------------------------------------------------------------------------------------------- -->
<!-- --------------------------------------------------------------------------------------------------- -->
<!-- content area -->

<!-- 컨텐츠 영역 -->
<div id="edu_content" class="col-lg-10">
<!-- row -->
<div class="row">

	
	<!-- 왼쪽영역 -->
	<div class="col-lg-7">
		<!-- row -->
		<div class="row">
		
			<!-- /교육훈련등록 -->
			<div role="content" class="clear-both sub-content edu_wz">
				<div class="form-horizontal form-terms ui-sortable">
					<div class="jarviswidget jarviswidget-sortable" role="widget">	
						<!-- 위젯해더 -->
						<header role="heading">
							<span class="widget-icon"> <i class="fa fa-th-large"></i> </span><h2>교육훈련등록</h2>
						</header>
						<!-- /위젯해더 -->
						<!-- 위젯바디 -->    	
						<div class="widget-body">
							<fieldset>
							<div class="col-md-12 form-group ">
								<label class="col-md-3 form-label">교육훈련명</label>
								<div class="col-md-9 form_box">
									<input type="text" class="form-control input_400">
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-3 form-label">교육비</label>
								<div class="col-md-9 form-inline form_box">
									<input type="text" class="form-control input_100">&nbsp;원
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-3 form-label">교육장소</label>
								<div class="col-md-9 form_box">
									<input type="text" class="form-control input_400">
								</div>
							</div>
							</fieldset>	
				
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-3 form-label">접수일시</label>
								<div class="col-md-9 form-inline form_box">
									<input type="text" class="form-control input_100">
									<select class="form-control select_100">
												<option>시간</option>
												<option>01시</option>
												<option>02시</option>
									</select>&nbsp;&nbsp;~&nbsp;&nbsp;
									<input type="text" class="form-control input_100">
									<select class="form-control select_100">
												<option>시간</option>
												<option>01시</option>
												<option>02시</option>
												<option>03시</option>
									</select>
								</div>
							</div>
							</fieldset>	
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-3 form-label">훈련일시</label>
								<div class="col-md-9  form-inline form_box">
									<input type="text" class="form-control input_100">
									<select class="form-control select_100">
												<option>시간</option>
												<option>01시</option>
												<option>02시</option>
									</select>&nbsp;&nbsp;~&nbsp;&nbsp;
									<input type="text" class="form-control input_100">
									<select class="form-control select_100">
												<option>시간</option>
												<option>01시</option>
												<option>02시</option>
												<option>03시</option>
									</select>
								</div>
							</div>
							</fieldset>
							
							<fieldset>
							<div class="col-md-12 form-group">
								<label class="col-md-3 form-label ">훈련상태</label>
								<div class="col-md-9  form_box">
									
									<label class="radio radio-inline">
										<input type="radio" class="radiobox" name="style-0a">
										<span>대기</span> 
									</label>
									<label class="radio radio-inline">
										<input type="radio" class="radiobox" name="style-0a">
										<span>접수중</span>  
									</label>
									<label class="radio radio-inline">
										<input type="radio" class="radiobox" name="style-0a">
										<span>접수마감</span> 
									</label>
									<label class="radio radio-inline">
										<input type="radio" class="radiobox" name="style-0a">
										<span>종료</span> 
									</label>
									<label class="radio radio-inline">
										<input type="radio" class="radiobox" name="style-0a">
										<span>폐강</span> 
									</label>
								</div>
							</div>
							</fieldset>	
							
							<div class="edu_wz_btn_box">
								<button class="btn btn-default btn-sm">
									접수증발급
								</button>
							</div>
				
						</div>
						<!-- 위젯바디 -->    
					</div>
				</div>
			</div>
			<!-- /.교육훈련등록 -->
			
		</div>
		<!-- /row -->
	</div>
	<!-- /왼쪽영역 -->





	<!-- 오른쪽영역 -->
	<div class="col-lg-5">
		<!-- row -->
		<div class="row">
			<!-- /내부결재 -->
			<div role="content" class="clear-both sub-content edu_wz">
				<div class="form-horizontal form-terms ui-sortable">
					<div class="jarviswidget jarviswidget-sortable" role="widget">	
						<!-- 위젯해더 -->
						<header role="heading">
							<span class="widget-icon"> <i class="fa fa-th-large"></i></span><h2>내부결재</h2>
						</header>
						<!-- /위젯해더 -->
						
						<!-- 위젯바디 -->	
						<div class="widget-body table-responsive">
							<table class="table table-hover table-unborder table_unborder">
								<colgroup>
									<col  /> <!-- 결재제목 -->
									<col width="25%" /> <!-- 날짜 -->
									<col width="15%" /> <!-- 상태 -->
								</colgroup>
							
								<tbody>
									<tr>
										<td>SO 18436-4 트라이볼로지 영</td>
										<td class="text-right">2016-03-17</td>
										<td class="text-right">진행중</td>
									</tr>				
									<tr>
										<td>SO 18436-4 트라이볼로지 영</td>
										<td class="text-right">2016-03-17</td>
										<td class="text-right">진행중</td>
									</tr>				
								</tbody>
							</table>
						</div>
						<!-- /위젯바디 -->
					</div>
				</div>
	    	</div>
			<!-- /내부결재 -->
		</div>
		<!-- /row -->
		
				
		<!-- row -->
		<div class="row">
			<!-- /첨부파일 -->
			<div role="content" class="clear-both sub-content edu_wz">
				<div class="form-horizontal form-terms ui-sortable">
					<div class="jarviswidget jarviswidget-sortable" role="widget">	
						<!-- 위젯해더 -->
						<header role="heading">
							<span class="widget-icon"> <i class="fa fa-th-large"></i></span><h2>첨부파일</h2>
						</header>
						<!-- /위젯해더 -->
						
						<!-- 위젯바디 -->	
						<div class="widget-body">
							<table class="table table-hover table-unborder table_unborder">
								<colgroup>
									<col  /> <!-- 파일이름 -->
									<col width="25%" /> <!-- 용량 -->
									<col width="8%" /> <!-- 삭제 -->
								</colgroup>
								<tbody>
									<tr>
										<td>출석부.jpg</td>
										<td class="text-right">25.3M</td>
										<td class="text-right"><i class="fa fa-times text-danger"></i></td>
									</tr>				
									<tr>
										<td>설문지.zip</td>
										<td class="text-right">25.3M</td>
										<td class="text-right"><i class="fa fa-times text-danger"></i></td>
									</tr>
									<tr>
										<td>시험지.zip</td>
										<td class="text-right">25.3M</td>
										<td class="text-right"><i class="fa fa-times text-danger"></i></td>
									</tr>				
								</tbody>
							</table>
						</div>
						<!-- /위젯바디 -->
					</div>
				</div>
	    	</div>
			<!-- /첨부파일 -->
		</div>
		<!-- /row -->
	</div>
	<!-- /오른쪽영역 -->




</div>
<!-- /row -->


<!-- row -->
<div class="row">

	<!-- 훈련생리스트 -->
	<div class="col-lg-12 edu_wz">
	
		<!-- /데이타 테이블 제목-->
		<div class="dt-title pull-left">
			<i class="fa fa-th-large"></i> 
			<span>훈련생리스트
			</span>
		</div>
			
		<!-- /.데이타 테이블 제목-->
		
		<!-- /dt-toolbar-->
		<div class="dt-toolbar">
			<div class="col-sm-6">
				<form class="form-inline" action="list.do" method="get" >
					<select name="searchType" class="form-control input-sm">
						<option value=''>선택하세요</option>
				        <option value='t'>상태</option>
				        <option value='c'>교육훈련명</option>
			        </select>
					<input name="keyword"   class="form-control input-sm search_input">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="ace-icon fa fa-search icon-on-right"></span>
						검색
					</button>
				</form>  
			</div>
				
				
			<div class="col-sm-6">
	
				
				<div class="pull-right toolbar-group">	
					<button class="btn btn-default btn-sm" >
						내부결재
					</button>
				</div>
				<div class="pull-right toolbar-group">	
					<button class="btn btn-default btn-sm" >
						접수증발급
					</button>
					<button class="btn btn-default btn-sm" >
						수료증발급
					</button>
				</div>	
				<div class="pull-right">
					<form class="form-inline" action="list.do" method="get" >
						<select name="searchType" class="form-control input-sm">
							<option value=''>선택하세요</option>
					       	<option value='t'>상태</option>
					       	<option value='c'>교육훈련명</option>
				       	</select>
						<button type="submit" class="btn btn-default btn-sm">
							<span class="ace-icon fa fa-search icon-on-right"></span>
							변경
						</button>
					</form>
				</div>	
			
			</div>
			
				
				
		</div>
		<!-- /.dt-toolbar-->
		
		<div id="tbl_data">
			<table class="table table-bordered table-striped table-hover">
				<colgroup>
					<col width="2%" /> <!-- 체크박스 -->
					<col width="3%" /> <!-- 번호 -->
					<col width="5%" /> <!-- 이름 -->
					<col  />           <!-- 핸드폰 -->
					<col  />           <!-- 이메일 -->
					<col width="8%" /> <!-- 접수상태 -->
					<col width="5%" /> <!-- 접수증 -->
					<col width="5%" /> <!-- 견적서 -->
					<col width="5%" /> <!-- 결제방법 -->
					<col width="5%" /> <!-- 결제시기 -->
					<col width="8%" /> <!-- 결제상태 -->
					<col width="5%" /> <!-- 계산서종류 -->
					<col width="5%" /> <!-- 계산서발급 -->
					<col width="5%" /> <!-- 접수증발행 -->
					<col width="5%" /> <!-- 평가결과 -->
					<col width="5%" /> <!-- 평가점수 -->
					<col width="5%" /> <!-- 수료증발급 -->
				</colgroup>
				
				<thead>
					<tr>
						<th rowspan="2">
							<label><input type="checkbox" class="checkbox" ><span ></span></label>
						</th>
						<th rowspan="2">번호</th>
						<th colspan="5">접수정보</th>
						<th rowspan="2">견적서</th>
						<th colspan="3">결제정보</th>
						<th colspan="2">계산서</th>
						<th rowspan="2">접수증<br>발급</th>
						<th colspan="2">평가</th>
						<th rowspan="2">수료증<br>발급</th>
					</tr>
					<tr>
						<th>이름</th>
						<th>핸드폰</th>
						<th>이메일</th>
						<th>상태</th>
						<th>접수증</th>
						<th>방법</td>
						<th>시기</td>
						<th>상태</td>
						<th>종류</td>
						<th>발급</td>
						<th>결과</th>
						<th>점수</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><label><input type="checkbox" class="checkbox" ><span ></span></label></td>
						<td>187</td>
						<td><a href="./enrollInfo.do">홍길동</a></td>
						<td>010-2323-5689</td>
						<td>iremys@gmail.com</td>
						<td>접수확인중</td>
						<td>보기</td>
						<td>발급</td>
						<td>카드</td>
						<td>정상</td>
						<td>결제확인중</td>
						<td>청구</td>
						<td>발급</td>
						<td>발급</td>
						<td>수료</td>
						<td>70</td>
						<td>발급</td>
					</tr>	
							
				</tbody>
	
			</table>
			
		</div>
	
	
	
		
		
	</div>
	<!-- /훈련생리스트 -->

</div>
<!-- /row -->
	


</div>
<!-- /컨텐츠 영역 -->









<!-- 도움말 영역 -->
<div id="edu_help" class="col-lg-2 well">
도움말들어갈자리

</div>
<!-- /도움말 영역 -->






<!-- /content area -->
<!-- --------------------------------------------------------------------------------------------------- -->
<!-- --------------------------------------------------------------------------------------------------- -->
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</div>