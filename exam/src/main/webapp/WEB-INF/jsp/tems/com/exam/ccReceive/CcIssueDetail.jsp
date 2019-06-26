<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link rel="stylesheet" href="<c:url value='/css/tems/temsDetail.css' />">   
    
<style type="text/css">
	.topBtn{
		height: 40px;
	}
	.topBtn p{
		float: right;
		margin-left: 10px;
	}
	.detailList1{
		height: 100px;
	}
</style> 


<!-- /section:basics/content.breadcrumbs -->
<div class="page-content">
	<div class="btnDiv">
		<p>
			<a href="javascript:void(0);" class="btn btn-labeled btn-success"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>발급승인 다음</a>
		</p>
		<p>
			<a href="javascript:void(0);" class="btn btn-labeled btn-success"> <span class="btn-label"><i class="glyphicon glyphicon-ok"></i></span>승인보류 다음</a>
		</p>
		<p style="margin-top: 5px">
			남은 결제 건수 : <input type="text" value="15" style="border: none;width: 30px;">건
		</p>
		<p>
			<a href="javascript:void(0);" class="btn btn-labeled btn-default"> <span class="btn-label"><i class="glyphicon glyphicon-th-list"></i></span>목록</a>
		</p>
	</div> <!--  -->
	
	<div class="detailList1" style="height: 100px;font-size: 15px;">
		<div class="col col-lg-12" style="height: 33%;">
			<div class="col col-lg-1 infoTitle">
				<b>접수번호</b>
			</div>
			<div class="col col-lg-3 infoBody infoInputRight">
				<p>
					<input type="text" value="접수번호1-1" style="border: none;">
				</p>
			</div>
		</div>
		
		<div class="col col-lg-12" style="height: 33%;">
			<div class="col col-lg-1 infoTitle">
				<b>접 수 일</b>
			</div>
			<div class="col col-lg-3 infoBody infoInputRight">
				<p>
					<input type="text" value="2015-01-01" style="border: none;">
				</p>
			</div>
		</div>
		
		<div class="col col-lg-12" style="height: 33%;">
			<div class="col col-lg-1 infoTitle">
				<b>결 과 일</b>
			</div> 
			<div class="col col-lg-3 infoBody infoInputRight infoInputBottom">
				<p>
					<input type="text" value="2015-01-30" style="border: none;">
				</p>
			</div>
		</div>
	</div>
	
	<div class="detailList2" style="height: 180px;border: 0px solid;margin-top: 15px;">
		<div style="height: 20%;">
			<div class="listTitle col col-lg-2">
				<p>
					시료정보
				</p>			
			</div>
		</div>
		<div style="height: 80%;" class="col col-lg-12">
			<div class="sampleTable" style="height: 25%;">
				<div class="col col-lg-1 infoTitle">
					<b>순번</b>
				</div>
				<div class="col col-lg-3 infoTitle">
					<b>시료 명</b>
				</div>
				<div class="col col-lg-4 infoTitle">
					<b>유종 제품</b>
				</div>
				<div class="col col-lg-2 infoTitle">
					<b>검사항목건수</b>
				</div>
				<div class="col col-lg-2 infoTitle">
					<b>수수료</b>
				</div>
			</div>
			<div class="sampleTable" style="height: 25%;">
				<div class="col col-lg-1 infoBody infoInputRight"><p>1</p></div>
				<div class="col col-lg-3 infoBody infoInputRight"><p>시료명1</p></div>
				<div class="col col-lg-4 infoBody infoInputRight"><p>휘발유</p></div>
				<div class="col col-lg-2 infoBody infoInputRight"><p>14</p></div>
				<div class="col col-lg-2 infoBody"><p>150,000</p></div>
			</div>
			<div class="sampleTable" style="height: 25%;">
				<div class="col col-lg-1 infoBody infoInputRight"><p>2</p></div>
				<div class="col col-lg-3 infoBody infoInputRight"><p>시료명2</p></div>
				<div class="col col-lg-4 infoBody infoInputRight"><p>자동차용경유</p></div>
				<div class="col col-lg-2 infoBody infoInputRight"><p>12</p></div>
				<div class="col col-lg-2 infoBody"><p>120,000</p></div>
			</div>
			<div class="sampleTable" style="height: 25%;">
				<div class="col col-lg-1 infoBody infoInputBottom infoInputRight"><p>3</p></div>
				<div class="col col-lg-3 infoBody infoInputBottom infoInputRight"><p>시료명3</p></div>
				<div class="col col-lg-4 infoBody infoInputBottom infoInputRight"><p>선박용경유</p></div>
				<div class="col col-lg-2 infoBody infoInputBottom infoInputRight"><p>14</p></div>
				<div class="col col-lg-2 infoBody infoInputBottom"><p>140,000</p></div>
			</div>
		</div>
	</div>
	
	<div class="detailList3" style="height: 300px;border: 0px solid;margin-top: 15px;">
		<div style="height: 15%;">
			<div class="listTitle col col-lg-4">
				<p>
					검사항목 [<input type="text" style="border: none;text-align: center;" value="시료명1">]
				</p>			
			</div>
		</div>
		<div style="height: 85%;" class="col col-lg-12">
			<div style="height: 14%;">
				<div class="col col-lg-4 infoTitle infoTitleRight">
					<b>
						검사항목
					</b>
				</div>
				<div class="col col-lg-2 infoTitle infoTitleRight">
					<b>
						단위
					</b>
				</div>
				<div class="col col-lg-2 infoTitle infoTitleRight">
					<b>
						측정값
					</b>
				</div>
				<div class="col col-lg-2 infoTitle infoTitleRight">
					<b>
						시험결과
					</b>		
				</div>
				<div class="col col-lg-2 infoTitle">
					<b>
						시험방법
					</b>
				</div>
			</div>
			<div style="height: 14%;">
				<div class="col col-lg-4 infoBody infoTitleRight"><p>황분</p></div>
				<div class="col col-lg-2 infoBody infoTitleRight"><p>(m/m)%</p></div>
				<div class="col col-lg-2 infoBody infoTitleRight"><p>0.268</p></div>
				<div class="col col-lg-2 infoBody infoTitleRight"><p>0.27</p></div>
				<div class="col col-lg-2 infoBody"><p>시험방법1</p></div>
			</div>
			<div style="height: 14%;">
				<div class="col col-lg-4 infoBody infoTitleRight"><p>총발열량</p></div>
				<div class="col col-lg-2 infoBody infoTitleRight"><p>mg/kg</p></div>
				<div class="col col-lg-2 infoBody infoTitleRight"><p>45.232</p></div>
				<div class="col col-lg-2 infoBody infoTitleRight"><p>45.23</p></div>
				<div class="col col-lg-2 infoBody"><p>시험방법2</p></div>
			</div>
			<div style="height: 56%;">
				<div class="col col-lg-4 infoInputBottom infoTitleRight" style="height: 100%;">
					<div class="infoBody infoTitleRight" style="width: 50%;float: left;height: 100%;"><p>금속분</p></div>
					<div class="infoBody" style="width: 50%;float: left;height: 100%">
						<div class="col col-lg-12" style="height: 25%;"><p>Cr</p></div>
						<div class="col col-lg-12" style="height: 25%;"><p>Pb</p></div>
						<div class="col col-lg-12" style="height: 25%;"><p>As</p></div>
						<div class="col col-lg-12" style="height: 25%;"><p>Cd</p></div>
					</div>
				</div>
				<div class="col col-lg-2 infoBody infoInputBottom infoTitleRight">
					<p>mg/kg</p>
				</div>
				<div class="col col-lg-2 infoBody infoInputBottom infoTitleRight" style="height: 100%;">
					<div class="" style="height: 25%;"><p>0.005</p></div>
					<div class="" style="height: 25%;"><p>0.423</p></div>
					<div class="" style="height: 25%;"><p>0.0001</p></div>
					<div class="" style="height: 25%;"><p>0.038</p></div>
				</div>
				<div class="col col-lg-2 infoBody infoInputBottom infoTitleRight"  style="height: 100%;">
					<div class="" style="height: 25%;"><p>1미만</p></div>
					<div class="" style="height: 25%;"><p>1미만</p></div>
					<div class="" style="height: 25%;"><p>1미만</p></div>
					<div class="" style="height: 25%;"><p>1미만</p></div>
				</div>
				<div class="col col-lg-2 infoBody infoInputBottom">
					<p>ICP</p>
				</div>
			</div>
		</div>
	</div>
</div>
	