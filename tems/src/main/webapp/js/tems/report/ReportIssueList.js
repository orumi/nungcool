	/**
	 * 나눔결재 시스테 연계 메소드 
	 * @returns 
	 */
	function fnIssueReport(){
		
		/**
		 * - 나눔결재 시스템 연계 메소드 -
		 * 1. 성적서발급 정보 유효성 검사.
		 * 2. 성적서 파일 서버 송부 프로세스.
		 * 3. 본문 내용 작성
		 * 4. 나눔결재 성적서 발급 시행
		 */
		
		/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		* 1. 성적서발급 정보 유효성 검사.
		*    접수번호 체크  
		━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/	
		
		
		gridView.commit(); 
	 	var rows = gridView.getCheckedRows();
		var jRowsData = [];
		var jRowsNotData = [];
		var jData
			
		if(rows.length > 0){
			for(var i=0; i < rows.length; i++){
				jData = dataProvider.getJsonRow(rows[i]);
				if(jData.printflag == null || jData.printflag == ""){
					jRowsData.push(jData);	
				}
			};
		}
			
		if (jRowsData.length == 0) {
			alert("선택된 값이 없습니다.");
	        return;
	    }
		
		/*접수 번호 */
		var acceptNo = jRowsData[0].acceptno;
		
		/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		* 2. 접수번호에 해당되는 성적서 파일 생성
		* 
		*  
		━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/	
		
		// 코드 작성...
		
		
		
		
		
		/*━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
		* 3. 본문 내용 작성 
		* 
		*  
		━━━━━━━━━━━━━━━━━━━━━━━━━━━━━*/	
		
		var inspReportId = "0001";
		var office_id = "";
		var attach_file = "";
		
		// docId, office_id, user_id, attach_file
	    var contxt = onGetDocument("KTEST_"+inspReportId, office_id, attach_file);
		
		if(!contxt) {
			alert('본문 내용을 생성하는데 실패했습니다. 관리자에게 문의하세요.');
			return;
		}
		
		
		//alert($("#eDocFrm").find("#Document").val());
		
		
		
		var queryParam = $("#eDocFrm").serialize(); // 폼의 모든 파라메터 가져오기
		
		console.log(queryParam);
		$.ajax({
			url : eSignURL,
			data : queryParam,
			type : "POST",
			async : false,
			success : function(data) {
				
				if(data.code == "001") {
					if(data.status == "success") {
						var frm = $("#eDocFrm");
						/* 4. 생성된 전자결재 정보화면을 호출한다. */
						var openUrl = "http://" + $("#eleSignServer").val() + $("#openEleSignUrl").val();
						openUrl = openUrl.replace("userID=","userID=" + $(frm).find("#userID").val());
						openUrl += "%3FuserID=" + $(frm).find("#userID").val() + "%26jobID=" + $(frm).find("#jobID").val() + "%26docID=" + $(frm).find("#docID").val();
						//window.open(openUrl);
						alert(openUrl);
						
					}				
					else {
						alert("전자결재 전송처리에 실패했습니다.\r\n[" + data.message + "]");
					}
				}
				else {
					alert("전자결재 전송처리에 실패했습니다.");
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("ajaxDataSave error4");
			}
		});
		
		
		
		
		/*
		
		
		var val = JSON.stringify(jRowsData);
	
		var data = {"data":val};
		var url = "<c:url value='/report/reportIssue/sendReport.json'/>";
	
		
		alert(jRowsData[0].acceptno);*/
	}
	

	/**
	 * 미리 정의된 본부별 전자결재 양식으로 발행해준다.
	 * @returns {Boolean}
	 * docId : documentId
	 * office_id 
	 * 
	 */
	function onGetDocument(docId, office_id, insp_id, attach_file) {
		
		var frm = $("#eDocFrm");	
		$(frm).find("#docID").val(docId);
		
		var serverFileUrl = "";
		
		var elec_appr_subject = "elec_appr_subject";
		var elec_appr_content = "elec_appr_content";
		var elec_atch_file_name = "localhost";
		
		

		var subject    = elec_appr_subject;	// 제목
		var contentXml = elec_appr_content;	// 본문xml (미리 정의된 본문 XML데이터를 가져올것)

		var setData = "";	
		setData = '<?xml version="1.0" encoding="UTF-8"?>';
		setData += '<exchangeableDocument>';
		setData += '<documentInformation>';
		setData += '<documentType>' + $(frm).find("#jobID").val() + '</documentType>';                                         
		setData += '<documentID>' + docId + '</documentID>';                        
		setData += '<createTime>' + getCurrDateTime() + '</createTime>';                                              
		setData += '<modifiedTime>' + getCurrDateTime() + '</modifiedTime>';                                          
		setData += '<createSystem>' + $("#eleSignLimsName").val() + '</createSystem>';                                                          
		setData += '<createServer>' + $("#eleSignServer").val() + '</createServer>';                                                  
		setData += '<gccOrganizationCode></gccOrganizationCode>';                                               
		setData += '<creator>' +  $(frm).find("#userID").val() + '</creator>';                                                                 
		setData += '<subject>' + subject + '</subject>';                                                           
		setData += '</documentInformation>';                                                                            
		setData += '<processInformation>';                                                                              
		setData += '<destinationSystem>SmartFlow XF</destinationSystem>';                                       
		setData += '<recipient>' +  $(frm).find("#userID").val() + '</recipient>';                                                             
		setData += '<documentStatus>create</documentStatus>';                                                   
		setData += '<workflow>';                                                                                
		setData += '</workflow>';                                                                               
		setData += '</processInformation>';                                                                             
		setData += '<documentDescription>';  
		setData += '<work>';
		setData += '<work_manage>';
		setData += '<job_name></job_name>';
		setData += '<start_date></start_date>';
		setData += '<open_term></open_term>';
		setData += '<dept_name></dept_name>';
		setData += '<district_name></district_name>';
		setData += '</work_manage>';
		setData += '<work_ref></work_ref>';
		setData += '<work_item work_item_code="001" work_item_name="본문내용"><![CDATA[' + contentXml + ']]></work_item>';
		setData += '</work>';
		setData += '</documentDescription>';                                                                            
		setData += '<documentBody>';                                                                                    
		setData += '<business>';                                                                                
		setData += '<biz_name></biz_name>';                                                             
		setData += '</business>';                                                                               
		setData += '<process>';                                                                                 
		setData += '<proc_name></proc_name>';                                                           
		setData += '<ins_date></ins_date>';                                                             
		setData += '<dept_name></dept_name>';                                                           
		setData += '<chg_resno></chg_resno>';                                                           
		setData += '<chg_name></chg_name>';                                                             
		setData += '<chg_phone></chg_phone>';                                                           
		setData += '<chg_email></chg_email>';                                                           
		setData += '<proc_content></proc_content>'; 
		setData += '</process>';                                                                                
		setData += '</documentBody>';   
		//alert(setData);
		
		if(attach_file == "" || attach_file == undefined) {
			attach_file = "";
		}
		
		/* 첨부된 파일 설정 영역 */
		setData += '<attachments>';                                                                                     
		setData += '<file>';                                                                                    
		setData += '<seq>1</seq>';                                                                      
		setData += '<name>'+elec_atch_file_name+'.pdf</name>';                                                         
		// setData += '<url>'+replaceAll(attach_file,"&","&amp;")+'</url>';
		
		//alert(serverFileUrl+'pdfLoad.do?fileUrl='+attach_file);
		
		//setData += '<url>'+serverFileUrl+'/pdfLoad.do?fileUrl='+replaceAll(attach_file,"&","&amp;")+'</url>';
		setData += '<url>'+serverFileUrl+'/pdfLoad.do?fileUrl='+attach_file+'</url>';
		setData += '</file>';                                                                              
		setData += '</attachments>';    
		setData += '</exchangeableDocument>';
		
		
		// alert("파일명 : " + elec_atch_file_name + ".pdf,   파일경로 : " + replaceAll(attach_file,"&","&amp;"));
		
		$(frm).find("#Document").val(setData);
		return true;
	}
	
	
	/**
	 * 전자결재 본문에 날짜정보를 반환
	 * @returns {String}
	 */
	function getCurrDateTime() {
	    var now     = new Date(); 
	    var year    = now.getFullYear();
	    var month   = now.getMonth()+1; 
	    var day     = now.getDate();
	    var hour    = now.getHours();
	    var minute  = now.getMinutes();
	    var second  = now.getSeconds();
	    
	    if(month.toString().length == 1) {
	        var month = '0'+month;
	    }
	    if(day.toString().length == 1) {
	        var day = '0'+day;
	    }   
	    if(hour.toString().length == 1) {
	        var hour = '0'+hour;
	    }
	    if(minute.toString().length == 1) {
	        var minute = '0'+minute;
	    }
	    if(second.toString().length == 1) {
	        var second = '0'+second;
	    }   
	    var dateTime = year+'/'+month+'/'+day+' '+hour+':'+minute+':'+second;   
	     return dateTime;
	}

	
	