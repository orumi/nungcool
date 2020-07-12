<%@ page contentType="text/tvs; charset=UTF-8" %>
<%@ page import="java.util.*,
                 com.nc.eis.*,
                 com.nc.util.*,
                 com.nc.xml.*"
%>
<%
	String mode		   = request.getParameter("mode") == null ? "R" : (request.getParameter("mode")).trim();
	String div_gn	   = request.getParameter("div_gn") == null ? "" : (request.getParameter("div_gn")).trim();

	//------------------------------------------------------------------------------------------
	//		조회.
	//------------------------------------------------------------------------------------------
	System.out.println("div_gb :" + div_gn);
	if(mode.equals("R"))	{

			// 평가년도 기준설정
			if(div_gn.equals("getPsnBaseLine"))	{
					PsnBonusUtil util =  new PsnBonusUtil();
					util.getPsnBaseLine(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("r_co"      )?"":ds.getString("r_co"     ))+"|");
							sb.append((ds.isEmpty("r1_s"      )?"":ds.getString("r1_s"     ))+"|");
							sb.append((ds.isEmpty("r1_a"      )?"":ds.getString("r1_a"     ))+"|");
							sb.append((ds.isEmpty("r1_b"      )?"":ds.getString("r1_b"     ))+"|");
							sb.append((ds.isEmpty("r1_c"      )?"":ds.getString("r1_c"     ))+"|");
							sb.append((ds.isEmpty("r1_d"      )?"":ds.getString("r1_d"     ))+"|");
							sb.append((ds.isEmpty("r2_s"      )?"":ds.getString("r2_s"     ))+"|");
							sb.append((ds.isEmpty("r2_a"      )?"":ds.getString("r2_a"     ))+"|");
							sb.append((ds.isEmpty("r2_b"      )?"":ds.getString("r2_b"     ))+"|");
							sb.append((ds.isEmpty("r2_c"      )?"":ds.getString("r2_c"     ))+"|");
							sb.append((ds.isEmpty("r2_d"      )?"":ds.getString("r2_d"     ))+"|");
							sb.append((ds.isEmpty("except_mh" )?"":ds.getString("except_mh"))+"|");
							sb.append((ds.isEmpty("except_bscmh" )?"":ds.getString("except_bscmh"))+"|");
							sb.append((ds.isEmpty("close_yn"         )?"":ds.getString("close_yn"        ))+"|");

				    		sb.append("\r\n");
						}
					}

					out.println(sb.toString());

			// 직급설정
			}else if(div_gn.equals("getPsnJikgub"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getPsnJikgub(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("jikgub_cd"        )?"":ds.getString("jikgub_cd"   ))+"|");
							sb.append((ds.isEmpty("jikgub_nm"        )?"":ds.getString("jikgub_nm"   ))+"|");
							sb.append((ds.isEmpty("use_yn"           )?"":ds.getString("use_yn"      ))+"|");
				    		sb.append("\r\n");
						}
					}

					out.println(sb.toString());


			// 단본부 매핑 : SBU의 List를 가져옴
			}else if(div_gn.equals("getPsnSbuMapping"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getPsnSbuMapping(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("sbuid"        )?"":ds.getString("sbuid"     ))+"|");
							sb.append((ds.isEmpty("sbunm"      )?"":ds.getString("sbunm"   ))+"|");
							sb.append((ds.isEmpty("bscid"        )?"":ds.getString("bscid"     ))+"|");
							sb.append((ds.isEmpty("bscnm"      )?"":ds.getString("bscnm"   ))+"|");
							sb.append((ds.isEmpty("sbucid"      )?"":ds.getString("sbucid"   ))+"|");
							sb.append((ds.isEmpty("bsccid"      )?"":ds.getString("bsccid"   ))+"|");

				    		sb.append("\r\n");
						}
					}

					out.println(sb.toString());

			// 단본부를 구함 : 단본부의 부서 List를 가져옴
			}else if(div_gn.equals("getPsnBscMapping"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getPsnBscMapping(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("sbuid"       )?"":ds.getString("sbuid"     ))+"|");
							sb.append((ds.isEmpty("sbunm"     )?"":ds.getString("sbunm"   ))+"|");
							sb.append((ds.isEmpty("bscid"       )?"":ds.getString("bscid"     ))+"|");
							sb.append((ds.isEmpty("bscnm"     )?"":ds.getString("bscnm"   ))+"|");
							sb.append((ds.isEmpty("sbucid"      )?"":ds.getString("sbucid"   ))+"|");
							sb.append((ds.isEmpty("bsccid"     )?"":ds.getString("bsccid"   ))+"|");

				    		sb.append("\r\n");
						}
					}
					out.println(sb.toString());

			// 평가년도 5등급 구분
			}else if(div_gn.equals("getPsnGradeBase"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getPsnGradeBase(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("org_cnt"   )?"":ds.getString("org_cnt" ))+"|");
							sb.append((ds.isEmpty("org_s"      )?"":ds.getString("org_s"   ))+"|");
							sb.append((ds.isEmpty("org_a"      )?"":ds.getString("org_a"   ))+"|");
							sb.append((ds.isEmpty("org_b"      )?"":ds.getString("org_b"   ))+"|");
							sb.append((ds.isEmpty("org_c"      )?"":ds.getString("org_c"   ))+"|");
							sb.append((ds.isEmpty("org_d"      )?"":ds.getString("org_d"   ))+"|");

				    		sb.append("\r\n");
						}
					}

					out.println(sb.toString());

			// 부서성과 조회
			}else if(div_gn.equals("getPsnBscScore"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getPsnBscScore(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("sbuid"    )?"":ds.getString("sbuid"    ))+"|");
							sb.append((ds.isEmpty("sbunm"    )?"":ds.getString("sbunm"    ))+"|");
							sb.append((ds.isEmpty("bscid"    )?"":ds.getString("bscid"    ))+"|");
							sb.append((ds.isEmpty("bscnm"    )?"":ds.getString("bscnm"    ))+"|");
							sb.append((ds.isEmpty("score_qty")?"":ds.getString("score_qty"))+"|");
							sb.append((ds.isEmpty("score_qly")?"":ds.getString("score_qly"))+"|");
							sb.append((ds.isEmpty("score_sum")?"":ds.getString("score_sum"))+"|");
							sb.append((ds.isEmpty("score_add")?"":ds.getString("score_add"))+"|");
							sb.append((ds.isEmpty("score_tot")?"":ds.getString("score_tot"))+"|");
							sb.append((ds.isEmpty("grp_rank")?"":ds.getString("grp_rank"))+"|");
							sb.append((ds.isEmpty("grade1")?"":ds.getString("grade1"))+"|");
							sb.append((ds.isEmpty("grade2")?"":ds.getString("grade2"))+"|");
							sb.append((ds.isEmpty("div_rate1")?"":ds.getString("div_rate1"))+"|");
							sb.append((ds.isEmpty("div_rate2")?"":ds.getString("div_rate2"))+"|");
							sb.append((ds.isEmpty("r_co")?"":ds.getString("r_co"       ))+"|");
							sb.append((ds.isEmpty("org_rate1")?"":ds.getString("org_rate1"))+"|");
							sb.append((ds.isEmpty("org_rate2")?"":ds.getString("org_rate2"))+"|");

				    		sb.append("\r\n");
						}
					}

					out.println(sb.toString());

			// 개인별 인사 사업M/H
			}else if(div_gn.equals("getPsnBizMh"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getPsnBizMh(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("emp_no"   )?"":ds.getString("emp_no"   ))+"|");
							sb.append((ds.isEmpty("emp_nm"   )?"":ds.getString("emp_nm"   ))+"|");
							sb.append((ds.isEmpty("jikgb_cd" )?"":ds.getString("jikgb_cd" ))+"|");
							sb.append((ds.isEmpty("jikgb_nm" )?"":ds.getString("jikgb_nm" ))+"|");
							sb.append((ds.isEmpty("dept_cd"  )?"":ds.getString("dept_cd"  ))+"|");
							sb.append((ds.isEmpty("dept_nm"  )?"":ds.getString("dept_nm"  ))+"|");
							sb.append((ds.isEmpty("mh"       )?"":ds.getString("mh"       ))+"|");
							sb.append((ds.isEmpty("except_yn")?"":ds.getString("except_yn"))+"|");
							sb.append((ds.isEmpty("except_cmt")?"":ds.getString("except_cmt"))+"|");

				    		sb.append("\r\n");
						}
					}

					out.println(sb.toString());

			// 개인별 성과급 지급률 상세
			}else if(div_gn.equals("getPsnScore"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getPsnScore(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("emp_no"    )?"":ds.getString("emp_no"       ))+"|");
							sb.append((ds.isEmpty("emp_nm"    )?"":ds.getString("emp_nm"       ))+"|");
							sb.append((ds.isEmpty("jikgb_cd"  )?"":ds.getString("jikgb_cd"     ))+"|");
							sb.append((ds.isEmpty("jikgb_nm"  )?"":ds.getString("jikgb_nm"     ))+"|");
							sb.append((ds.isEmpty("emp_rate"  )?"":ds.getString("emp_rate"     ))+"|");

							sb.append((ds.isEmpty("sbuid"      )?"":ds.getString("sbuid"       ))+"|");
							sb.append((ds.isEmpty("sbunm"      )?"":ds.getString("sbunm"       ))+"|");
							sb.append((ds.isEmpty("bscid"      )?"":ds.getString("bscid"       ))+"|");
							sb.append((ds.isEmpty("bscnm"      )?"":ds.getString("bscnm"       ))+"|");
							sb.append((ds.isEmpty("bsccid"     )?"":ds.getString("bsccid"      ))+"|");
							sb.append((ds.isEmpty("sbu_grade"  )?"":ds.getString("sbu_grade"   ))+"|");
							sb.append((ds.isEmpty("bsc_grade"  )?"":ds.getString("bsc_grade"   ))+"|");
							sb.append((ds.isEmpty("bsc_rate"   )?"":ds.getString("bsc_rate"    ))+"|");
							sb.append((ds.isEmpty("bsc_mh"     )?"":ds.getString("bsc_mh"      ))+"|");
							sb.append((ds.isEmpty("bsc_mh_rate")?"":ds.getString("bsc_mh_rate" ))+"|");
							sb.append((ds.isEmpty("bsc_mh_sum" )?"":ds.getString("bsc_mh_sum"  ))+"|");

							sb.append((ds.isEmpty("dept_cd"    )?"":ds.getString("dept_cd"     ))+"|");
							sb.append((ds.isEmpty("dept_nm"    )?"":ds.getString("dept_nm"     ))+"|");
							sb.append((ds.isEmpty("mh"         )?"":ds.getString("mh"          ))+"|");

				    		sb.append("\r\n");
						}
					}

					out.println(sb.toString());

			// 개인별 성과급 지급률
			}else if(div_gn.equals("getPsnScoreList"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getPsnScoreList(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("emp_no"    )?"":ds.getString("emp_no"       ))+"|");
							sb.append((ds.isEmpty("emp_nm"    )?"":ds.getString("emp_nm"       ))+"|");
							sb.append((ds.isEmpty("jikgb_cd"  )?"":ds.getString("jikgb_cd"     ))+"|");
							sb.append((ds.isEmpty("jikgb_nm"  )?"":ds.getString("jikgb_nm"     ))+"|");
							sb.append((ds.isEmpty("emp_rate"  )?"":ds.getString("emp_rate"     ))+"|");

							sb.append((ds.isEmpty("sbuid"      )?"":ds.getString("sbuid"       ))+"|");
							sb.append((ds.isEmpty("sbunm"      )?"":ds.getString("sbunm"       ))+"|");
							sb.append((ds.isEmpty("bscid"      )?"":ds.getString("bscid"       ))+"|");
							sb.append((ds.isEmpty("bscnm"      )?"":ds.getString("bscnm"       ))+"|");
							sb.append((ds.isEmpty("bsccid"     )?"":ds.getString("bsccid"      ))+"|");
							sb.append((ds.isEmpty("sbu_grade"  )?"":ds.getString("sbu_grade"   ))+"|");
							sb.append((ds.isEmpty("bsc_grade"  )?"":ds.getString("bsc_grade"   ))+"|");
							sb.append((ds.isEmpty("bsc_rate"   )?"":ds.getString("bsc_rate"    ))+"|");
							sb.append((ds.isEmpty("bsc_mh"     )?"":ds.getString("bsc_mh"      ))+"|");
							sb.append((ds.isEmpty("bsc_mh_rate")?"":ds.getString("bsc_mh_rate" ))+"|");
							sb.append((ds.isEmpty("bsc_mh_sum" )?"":ds.getString("bsc_mh_sum"  ))+"|");


				    		sb.append("\r\n");
						}
					}

					out.println(sb.toString());


			// 개인 성과급 지급률
			}else if(div_gn.equals("getPsnEmpScore"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getPsnEmpScore(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("emp_no"    )?"":ds.getString("emp_no"       ))+"|");
							sb.append((ds.isEmpty("emp_nm"    )?"":ds.getString("emp_nm"       ))+"|");
							sb.append((ds.isEmpty("jikgb_cd"  )?"":ds.getString("jikgb_cd"     ))+"|");
							sb.append((ds.isEmpty("jikgb_nm"  )?"":ds.getString("jikgb_nm"     ))+"|");
							sb.append((ds.isEmpty("emp_rate"  )?"":ds.getString("emp_rate"     ))+"|");

							sb.append((ds.isEmpty("sbuid"      )?"":ds.getString("sbuid"       ))+"|");
							sb.append((ds.isEmpty("sbunm"      )?"":ds.getString("sbunm"       ))+"|");
							sb.append((ds.isEmpty("bscid"      )?"":ds.getString("bscid"       ))+"|");
							sb.append((ds.isEmpty("bscnm"      )?"":ds.getString("bscnm"       ))+"|");
							sb.append((ds.isEmpty("bsccid"     )?"":ds.getString("bsccid"      ))+"|");
							sb.append((ds.isEmpty("sbu_grade"  )?"":ds.getString("sbu_grade"   ))+"|");
							sb.append((ds.isEmpty("bsc_grade"  )?"":ds.getString("bsc_grade"   ))+"|");
							sb.append((ds.isEmpty("bsc_rate"   )?"":ds.getString("bsc_rate"    ))+"|");
							sb.append((ds.isEmpty("bsc_mh"     )?"":ds.getString("bsc_mh"      ))+"|");
							sb.append((ds.isEmpty("bsc_mh_rate")?"":ds.getString("bsc_mh_rate" ))+"|");

				    		sb.append("\r\n");
						}
					}

					out.println(sb.toString());

			// 개인별 인사 사업M/H
			}else if(div_gn.equals("getPsnEmpDeptMh"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getPsnEmpDeptMh(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("emp_no"   )?"":ds.getString("emp_no"   ))+"|");
							sb.append((ds.isEmpty("emp_nm"   )?"":ds.getString("emp_nm"   ))+"|");
							sb.append((ds.isEmpty("jikgb_cd" )?"":ds.getString("jikgb_cd" ))+"|");
							sb.append((ds.isEmpty("jikgb_nm" )?"":ds.getString("jikgb_nm" ))+"|");
							sb.append((ds.isEmpty("dept_cd"  )?"":ds.getString("dept_cd"  ))+"|");
							sb.append((ds.isEmpty("dept_nm"  )?"":ds.getString("dept_nm"  ))+"|");
							sb.append((ds.isEmpty("bsccid"   )?"":ds.getString("bsccid"   ))+"|");
							sb.append((ds.isEmpty("bscnm"    )?"":ds.getString("bscnm"    ))+"|");
							sb.append((ds.isEmpty("mh"       )?"":ds.getString("mh"       ))+"|");
							sb.append((ds.isEmpty("except_yn")?"":ds.getString("except_yn"))+"|");
							sb.append((ds.isEmpty("except_cmt")?"":ds.getString("except_cmt"))+"|");

				    		sb.append("\r\n");
						}
					}

					out.println(sb.toString());

			//-----------------------------------------------------------------------
			//   개인성과 대상자를 구함.
			//-----------------------------------------------------------------------
			} else if(div_gn.equals("getUser"))	{

				PsnBonusUtil util  =  new PsnBonusUtil();
			    util.getUser(request, response);

				DataSet ds = (DataSet)request.getAttribute("ds");
				StringBuffer sb = new StringBuffer();

				if (ds!=null){
					while(ds.next()){
						sb.append((ds.isEmpty("jikgb_cd"      )?"":ds.getString("jikgb_cd"         )) +"|");          // 0
						sb.append((ds.isEmpty("jikgb_nm"      )?"":ds.getString("jikgb_nm"         )) +"|");          // 1
						sb.append((ds.isEmpty("userid"        )?"":ds.getString("userid"        )) +"|");          // 0
						sb.append((ds.isEmpty("usernm"        )?"":ds.getString("usernm"        )) +"|");          // 1

						sb.append("\r\n");
					}
				}
				out.println(sb.toString());
			//-----------------------------------------------------------------------
			//   노조전임인지 확인
			//-----------------------------------------------------------------------
			} else if(div_gn.equals("getLaborUser"))	{

				PsnBonusUtil util  =  new PsnBonusUtil();
			    util.getLaborUser(request, response);

				DataSet ds = (DataSet)request.getAttribute("ds");
				StringBuffer sb = new StringBuffer();

				if (ds!=null){
					while(ds.next()){
						sb.append((ds.isEmpty("laboryn"      )?"":ds.getString("laboryn"         )) +"|");          // 0
						sb.append((ds.isEmpty("emp_no"      )?"":ds.getString("emp_no"         )) +"|");
						sb.append((ds.isEmpty("emp_nm"      )?"":ds.getString("emp_nm"         )) +"|");
					}
				}
				out.println(sb.toString());
			//-----------------------------------------------------------------------
			//   노조전임인지 확인
			//-----------------------------------------------------------------------
			} else if(div_gn.equals("getLaborUserList"))	{

					PsnBonusUtil util  =  new PsnBonusUtil();
				    util.getLaborUserList(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();

					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("userid"      )?"":ds.getString("userid"         )) +"|");
							sb.append((ds.isEmpty("usernm"      )?"":ds.getString("usernm"         )) +"|");
							sb.append("\r\n");
						}
					}
					out.println(sb.toString());

			// 대전지역 조직을 구함.
			}else if(div_gn.equals("getExceptBscCd"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.getExceptBscCd(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();
					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("sid"     )?"":ds.getString("sid"     ))+"|");
							sb.append((ds.isEmpty("scid"    )?"":ds.getString("scid"    ))+"|");
							sb.append((ds.isEmpty("snm"     )?"":ds.getString("snm"     ))+"|");

							sb.append((ds.isEmpty("bid"     )?"":ds.getString("bid"     ))+"|");
							sb.append((ds.isEmpty("bcid"    )?"":ds.getString("bcid"    ))+"|");
							sb.append((ds.isEmpty("bnm"     )?"":ds.getString("bnm"     ))+"|");
							sb.append((ds.isEmpty("empcnt"     )?"":ds.getString("empcnt"     ))+"|");

				    		sb.append("\r\n");
						}
					}
					out.println(sb.toString());

			//-----------------------------------------------------------------------
			//  대전지역 확인
			//-----------------------------------------------------------------------
			} else if(div_gn.equals("getExceptBscUser"))	{

					PsnBonusUtil util  =  new PsnBonusUtil();
				    util.getExceptBscUser(request, response);

					DataSet ds = (DataSet)request.getAttribute("ds");
					StringBuffer sb = new StringBuffer();

					if (ds!=null){
						while(ds.next()){
							sb.append((ds.isEmpty("sbuid"       )?"":ds.getString("sbuid"          )) +"|");
							sb.append((ds.isEmpty("sbucid"      )?"":ds.getString("sbucid"         )) +"|");
							sb.append((ds.isEmpty("sbunm"       )?"":ds.getString("sbunm"          )) +"|");
							sb.append((ds.isEmpty("bscid"       )?"":ds.getString("bscid"          )) +"|");
							sb.append((ds.isEmpty("bsccid"      )?"":ds.getString("bsccid"         )) +"|");
							sb.append((ds.isEmpty("bscnm"       )?"":ds.getString("bscnm"          )) +"|");
							sb.append((ds.isEmpty("userid"      )?"":ds.getString("userid"         )) +"|");
							sb.append((ds.isEmpty("usernm"      )?"":ds.getString("usernm"         )) +"|");
							sb.append("\r\n");
						}
					}
					out.println(sb.toString());
				}
	//------------------------------------------------------------------------------------------
	//		등록,수정,삭제
	//------------------------------------------------------------------------------------------
	} else {

			// 기준년도 설정
			if(div_gn.equals("setPsnBaseLine"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.setPsnBaseLine(request, response);

					out.println("true");
			}

			// 직급설정
			if(div_gn.equals("setPsnJikgub"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.setPsnJikgub(request, response);

					out.println("true");
			}

			// BSC환경설정 : Mapping....
			if(div_gn.equals("setPsnMapping"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.setPsnMapping(request, response);

					out.println("true");
			}

			// BSC환경설정 : Grade 설정
			if(div_gn.equals("setPsnGrade"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.setPsnGrade(request, response);

					out.println("true");
			}



			// 부서성과 집계
			if(div_gn.equals("setPsnBscScore"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.setPsnBscScore(request, response);

					out.println("true");
			}

			// BSC환경설정 : 부서 Grade 설정
			if(div_gn.equals("setPsnBscGrade"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.setPsnBscGrade(request, response);

					out.println("true");
			}

			// 개인 M/H집계
			if(div_gn.equals("setPsnBizMh"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.setPsnBizMh(request, response);

					out.println("true");
			}

			//  개인성과지급률 계산
			if(div_gn.equals("setPsnScore"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.setPsnScore(request, response);

					out.println("true");
			}

			// 노조전임설정.
			if(div_gn.equals("setLaborUser"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.setLaborUser(request, response);

					out.println("true");
			}

			// 대전지역 사원설정.
			if(div_gn.equals("setExceptBscUser"))	{
					PsnBonusUtil util  =  new PsnBonusUtil();
					util.setExceptBscUser(request, response);

					out.println("true");
			}

	}



%>
