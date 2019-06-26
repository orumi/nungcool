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

    function chkPwd() {
        var str = $("#newPsword").val();

        var reg_pwd = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;

        if (!reg_pwd.test(str)) {
            alert("비밀번호는 6~20글자 사이 숫자와 영문을 혼합한 형태여야 합니다.");
            return false;
        }
        return true;
    }

    function crtPswordChk() {

        var crtPsword = $("#currentPsword").val();

        $.ajax({
            type: "POST",
            url: "<c:url value= '/member/crtPswordChk.json'/>",
            data: {"data": crtPsword},
            dataType: "text",
            success: function (data) {
                if (data == "true") {

                    pswordChange.submit();

                } else {
                    alert('현재 비밀번호 입력이 잘못 되었습니다.');
                }
            },
            error: function (xhr, status, error, data) {
                alert("에러가 발생 하였습니다, 문제가 지속되면 관리자에게 문의하여 주세요.");
            }
        });
    }

    function psChkTriger() {
        chkPwd();
        crtPswordChk();
    }

    $(function () {
        $("#pswordChange").validate({

            debug: true,
            rules: {
                currentPsword: {
                    required: true
                },
                newPsword: {
                    required: true,
                    notEqualTo: '#currentPsword'
                },
                newPswordConfirm: {
                    required: true,
                    equalTo: '#newPsword'
                }
            }
            ,
            messages: {
                currentPsword: {
                    required: "필수 입력사항 입니다."
                },
                newPsword: {
                    required: " 필수 입력사항 입니다.",
                    notEqualTo: "현재 비밀번호와 같을 수 없습니다."
                },
                newPswordConfirm: {
                    required: " 필수 입력사항 입니다.",
                    equalTo: "새 비밀번호 항목과 일치하지 않습니다."
                }
            },
        })
    });

</script>


<head>
    <title></title>
</head>
<body>
<div class="right_warp">
    <div class="title_route">
        <div class="title_route">
            <h3>비밀번호 변경</h3>

            <p class="route">
                <img src="${pageContext.request.contextPath}/images/exam/ico/home.gif" alt="홈">
                <img src="${pageContext.request.contextPath}/images/exam/bg/gt.gif" alt=""> 고객지원 센터
                <img src="${pageContext.request.contextPath}/images/exam/bg/gt.gif" alt="">
                <span>비밀번호 변경</span>
            </p>



        </div>

    </div>


    <div>
        <div class="col-sm-12">
            <br/>
            <h3>비밀번호를 변경하는 페이지 입니다.</h3>
            <br/>
            귀하의 비밀번호를 외부로부터 보호 하기 위하여<br/>
            저희 석유 관리원은 주기적인 비밀번호 교체를 권장 합니다.<br/>
            <br/>
            아울러 비밀번호는 저희 정책에 따라,<br/>
            6~16자리 그리고 문자와 숫자를 혼합한 형태를 요구 합니다.<br/>
        </div>
    </div>


    <br/>
    <br/>
    <br/>

    <form id="pswordChange" name="pswordChange" action="<c:url value='/member/passwordChange.do'/>" method="post">
        <div class="table_bg m_B27">

            <table summary="신청일자검색" class="table_w">
                <colgroup>
                    <col width="131px">
                    <col width="*">
                </colgroup>
                <tbody>
                <tr>
                    <th style="text-align: left">현재 비밀번호</th>
                    <td>
                        <input type="password" id="currentPsword" name="currentPsword" value="" class="h30">
                    </td>
                </tr>
                <tr>
                    <th style="text-align: left">새 비밀번호</th>
                    <td>
                        <input type="password" id="newPsword" name="newPsword" value="" class="h30">
                    </td>
                </tr>
                <tr>
                    <th style="text-align: left">새 비밀번호 확인</th>
                    <td>
                        <input type="password" id="newPswordConfirm" name="newPswordConfirm" value="" class="h30">
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div style="text-align: right">
            <button type="submit" class="btn btn-primary" onclick="psChkTriger()">
                확인
            </button>
        </div>

    </form>
</div>


</body>
</html>
