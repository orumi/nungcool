<%@ page import="exam.com.main.model.LoginUserVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: owner1120
  Date: 2016-03-02
  Time: 오후 2:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery.validate.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/additional-methods.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/messages_ko.js"></script>

<script>

    function idInquiryAction() {

        var userName = $("#userName").val();
        var phoneNum = $("#phoneNum").val();

        $.ajax({
            type: "POST",
            url: "<c:url value= '/member/idInquiryAction.json'/>",
            data: {"userName": userName, "phoneNum": phoneNum},
            dataType: "JSON",
            success: function (data) {
                alert(data.message);
            },
            error: function (xhr, status, error, data) {
                alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
            }
        });
    }

</script>


<head>
    <title></title>
</head>
<body>
<div class="right_warp">
    <div class="title_route">
        <div class="title_route">
            <h3>아이디 찾기</h3>

            <p class="route">
                <img src="${pageContext.request.contextPath}/images/exam/ico/home.gif" alt="홈">
                <img src="${pageContext.request.contextPath}/images/exam/bg/gt.gif" alt=""> 고객지원 센터
                <img src="${pageContext.request.contextPath}/images/exam/bg/gt.gif" alt="">
                <span>아이디 찾기</span>
            </p>

        </div>
    </div>
    <div>
        <div class="col-sm-12">
            <br/>

            <h3>회원정보에 등록한 휴대전화로 인증</h3>
            <br/>

            <div>
                <span style="color: #666666">회원정보에 등록한 휴대전화 번호와 입력한 휴대전화 번호가 같아야, 아이디를 찾을 수 있습니다.</span>
            </div>
        </div>
    </div>

    <br/>
    <div class="table_bg m_B27">

        <table summary="신청일자검색" class="table_w">
            <colgroup>
                <col width="131px">
                <col width="*">
            </colgroup>
            <tbody>
            <tr>
                <th style="text-align: left">사용자 이름</th>
                <td>
                    <input type="text" id="userName" name="userName" value="" class="h30">
                </td>
            </tr>
            <tr>
                <th style="text-align: left">사용자 전화번호</th>
                <td>
                    <input type="text" id="phoneNum" name="phoneNum" value="" class="h30"
                           onkeyup="this.value=this.value.replace(/[^0-9]/gi,'')" ;>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div style="text-align: right">
        <button type="submit" class="btn btn-primary" onclick="idInquiryAction()">
            아이디 찾기
        </button>
    </div>
    <div class="title_route">
        <div class="title_route">
            <h3>비밀번호 찾기</h3>
        </div>
    </div>


    <div>
        <div class="col-sm-12">
            <br/>

            <h3>고객님의 아이디를 입력 해 주세요</h3>
            <br/>

            <div>
                <span style="color: #666666">회원님의 휴대폰 번호로 인증번호가 전송 됩니다.</span>
            </div>
        </div>
    </div>
    <br/>
    <div class="table_bg m_B27">
        <table summary="신청일자검색" class="table_w">
            <colgroup>
                <col width="131px">
                <col width="*">
            </colgroup>
            <tbody>
            <tr>
                <th style="text-align: left">아이디</th>
                <td>
                    <input type="text" id="userId" name="userName" value="" class="h30">
                </td>
            </tr>
            <tr>
                <th style="text-align: left">인증번호 입력</th>
                <td>
                    <input type="text" id="certiNumb" name="userName" value="" class="h30">
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div>
        <button class="btn btn-primary">비밀번호 찾기</button>
    </div>


</div>



</body>
</html>
