<%@ page
    contentType="text/html;charset=euc-kr"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>::: 조직성과 :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/nungcool_bsc.css" rel="stylesheet" type="text/css">
</head>

<body background="images/page_bg.gif" leftmargin="5" topmargin="0" marginwidth="5">
<!-----//Box layout//----->
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="5"><img src="images/box_top_left.gif" width="5" height="44"></td>
    <td width="190" height="44" background="images/box_top_bg.gif"><img src="images/title_img_04.gif" width="190" height="44"></td>
    <td background="images/box_top_bg.gif">&nbsp;</td>
    <td width="5"><img src="images/box_top_right.gif" width="5" height="44"></td>
  </tr>
  <tr> 
    <td background="images/box_side_left.gif">&nbsp;</td>
    <td colspan="2" valign="top" bgcolor="#FFFFFF"> 
      <!---------///본문 컨텐츠 삽입영역 ///--------->
     <!--/탭메뉴/-->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td background="images/tapmenu_line_bg.gif"><a href="4.jsp">&nbsp;<img src="images/tapmenu4_01_over.gif" alt="자체평가보고서" width="100" height="23" border="0"></a><a href="4_02.jsp"><img src="images/tapmenu4_02_off.gif" alt="부서별평가조회" width="100" height="23" border="0"></a></td>
        </tr>
      </table> 
	  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
      <!----->
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="100%" valign="top"> 
            <!------//상단검색//----->
            <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#A4CBE3">
              <form name="form1" method="post" action="">
                <tr bgcolor="#DCEDF6"> 
                  <td width="14%" align="center"><strong><font color="#006699"> 
                    해당일자</font></strong></td>
                  <td width="86%" bgcolor="#FFFFFF"><select name="select">
                      <option value="2006">2006</option>
                    </select> <select name="select2">
                      <option value="상반기">상반기</option>
                      <option value="하반기">하반기</option>
                    </select> </td>
                </tr>
                <tr bgcolor="#DCEDF6"> 
                  <td align="center" bgcolor="#DCEDF6"><strong><font color="#006699">부서선택</font></strong></td>
                  <td bgcolor="#FFFFFF">부서 청/국/실: 
                    <select name="select3">
                    </select>
                    과: <select name="select4">
                    </select> <a href="#"><img src="images/btn_ok.gif" alt="확인" width="50" height="20" border="0" align="absmiddle"></a></td>
                </tr>
              </form>
            </table>
            <!-------//상단검색 끝//------->
          </td>
        </tr>
        <tr> 
          <td valign="top">&nbsp;</td>
        </tr>
      </table>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr valign="top">
          <td width="43%">
		  <!------//좌측 KPI 목록//------>
            <table width="98%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="25"><strong> <img src="images/icon_point_00.gif" width="15" height="15" align="absmiddle"> 
                  전청 KPI 목록</strong></td>
              </tr>
            </table> 
            <table width="98%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr align="center" bgcolor="#D4DCF4"> 
                <td width="25%"><font color="#003399"><strong>관점</strong></font></td>
                <td width="45%"><font color="#003399"><strong>KPI명</strong></font></td>
                <td width="15%"><font color="#003399"><strong>달성도</strong></font></td>
                <td width="15%" bgcolor="#D4DCF4"><font color="#003399"><strong>자체평가여부</strong></font></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td>이해관계자</td>
                <td><a href="#">고객만족도</a></td>
                <td align="center"><img src="images/icon_level_01.gif" width="37" height="14"></td>
                <td align="center"><img src="images/icon_go_01.gif" width="37" height="14"></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td>업무수행</td>
                <td>&nbsp;</td>
                <td align="center"><img src="images/icon_level_02.gif" width="37" height="14"></td>
                <td align="center"><img src="images/icon_go_02.gif" width="37" height="14"></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td>내부프로세스</td>
                <td>&nbsp;</td>
                <td align="center"><img src="images/icon_level_03.gif" width="37" height="14"></td>
                <td align="center"><img src="images/icon_go_01.gif" width="37" height="14"></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td>학습과 자원</td>
                <td>&nbsp;</td>
                <td align="center"><img src="images/icon_level_04.gif" width="37" height="14"></td>
                <td align="center"><img src="images/icon_go_02.gif" width="37" height="14"></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td align="center">&nbsp;</td>
                <td align="center">&nbsp;</td>
              </tr>
            </table> 
			<!------//좌측 KPI 목록 끝//------>
			</td>
          <td width="57%">
		  <!------//우측 KPI  내용//------>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="25"><strong> <img src="images/icon_point_00.gif" width="15" height="15" align="absmiddle"> 
                  전청 KPI 세부내용</strong></td>
              </tr>
            </table>
            <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#9DB5D7">
              <tr> 
                <td width="16%" align="center" bgcolor="#D4DCF4"><strong><font color="#003399">KPI 
                  명</font></strong></td>
                <td width="84%" bgcolor="#FFFFFF"><font color="#666666">고객만족도</font></td>
              </tr>
              <tr> 
                <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">산식</font></strong></td>
                <td bgcolor="#FFFFFF"><font color="#666666">(보도자료 작성목표달성율)*0.4 
                  + (정책실적) * 0.8</font></td>
              </tr>
              <tr> 
                <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">Target</font></strong></td>
                <td bgcolor="#FFFFFF"><font color="#666666">상반기: 45%, 50%</font></td>
              </tr>
              <tr> 
                <td align="center" bgcolor="#D4DCF4"><strong><font color="#003399">달성구간</font></strong></td>
                <td bgcolor="#FFFFFF"><font color="#666666">120% | 110% </font></td>
              </tr>
            </table>
			<!------//우측 KPI  내용 끝//------>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="2">&nbsp;</td>
              </tr>
              <tr> 
                <td width="78%" height="30"><strong> <img src="images/icon_point_00.gif" width="15" height="15" align="absmiddle"> 
                  평가</strong></td>
                <td width="22%" align="right"><a href="#"><img src="images/btn_report_write.gif" alt="평가보고서 작성" width="104" height="20" border="0"></a></td>
              </tr>
            </table>
			<!------//우측 평가보고서내용 3//------>
            <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
              <tr> 
                <td width="17%" align="center" bgcolor="#EAEAEA"><font color="#333333"><strong>평가항목</strong></font></td>
                <td width="68%" bgcolor="#FFFFFF"><strong><font color="#3366CC">목표달성도(가중치)</font></strong></td>
                <td width="15%" bgcolor="#FFFFFF"><select name="select5">
                    <option value="01">우수</option>
                  </select></td>
              </tr>
              <tr> 
                <td align="center" bgcolor="#EAEAEA"><font color="#333333"><strong>내용</strong></font></td>
                <td colspan="2" bgcolor="#FFFFFF" class="height_18"><font color="#333333">목표 
                  및 달성 등급<br>
                  조사개요<br>
                  조사분야 </font></td>
              </tr>
            </table>
            <br>
			<!----------->
            <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
              <tr> 
                <td width="17%" align="center" bgcolor="#EAEAEA"><font color="#333333"><strong>평가항목</strong></font></td>
                <td width="68%" bgcolor="#FFFFFF"><strong><font color="#3366CC">목표달성도(가중치)</font></strong></td>
                <td width="15%" bgcolor="#FFFFFF"><select name="select6">
                    <option value="01">우수</option>
                  </select></td>
              </tr>
              <tr> 
                <td align="center" bgcolor="#EAEAEA"><font color="#333333"><strong>내용</strong></font></td>
                <td colspan="2" bgcolor="#FFFFFF" class="height_18"><font color="#333333">목표 
                  및 달성 등급<br>
                  조사개요<br>
                  조사분야 </font></td>
              </tr>
            </table>
            <br>
			<!--------->
            <table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
              <tr> 
                <td width="17%" align="center" bgcolor="#EAEAEA"><font color="#333333"><strong>평가항목</strong></font></td>
                <td width="68%" bgcolor="#FFFFFF"><strong><font color="#3366CC">목표달성도(가중치)</font></strong></td>
                <td width="15%" bgcolor="#FFFFFF"><select name="select7">
                    <option value="01">우수</option>
                  </select></td>
              </tr>
              <tr> 
                <td align="center" bgcolor="#EAEAEA"><font color="#333333"><strong>내용</strong></font></td>
                <td colspan="2" bgcolor="#FFFFFF" class="height_18"><font color="#333333">목표 
                  및 달성 등급<br>
                  조사개요<br>
                  조사분야 </font></td>
              </tr>
            </table> 
			<!------//우측 평가보고서내용  끝//------>
			</td>
        </tr>
      </table>
      
      <!---------///본문 컨텐츠 삽입영역  끝///--------->
    </td>
    <td background="images/box_side_right.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td height="5"><img src="images/box_down_left.gif" width="5" height="5"></td>
    <td colspan="2" background="images/box_down_bg.gif"><img src="images/box_down_bg.gif" width="5" height="5"></td>
    <td><img src="images/box_down_right.gif" width="5" height="5"></td>
  </tr>
  <tr> 
    <td height="5" colspan="4"><img src="images/5px.gif" width="5" height="5"></td>
  </tr>
</table>
<!-----//Box layout end//----->
</body>
</html>
