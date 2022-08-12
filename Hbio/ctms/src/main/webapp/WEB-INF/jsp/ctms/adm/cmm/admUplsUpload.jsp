<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix = "fn"  uri = "http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<style type="text/css">
</style>
<script type="text/javascript">
	$(function(){
		
		//alert("start!!!!!");
		var c1 = '<c:out value="${searchVO.searchParam3}"/>'
		//alert(c1);
		
		//관리자권한인 경우 양식파일 업로드 기능 설정
		var ynadminType = '<c:out value="${searchVO.searchParam2}"/>';
		if(ynadminType == '1') {
			$('#uploadfile_td').show();
		}else {
			$('#uploadfile_td').hide();	
		}

		//양식파일이 없는 경우 업로드 기능 제한
		var ynfile = '<c:out value="${searchVO.searchParam1}"/>';
		if(ynfile == '') {
			$('.btn-download-file').attr('disabled', true);
			$('.btn-upload-file').hide();
		}
		
		var fileTarget = $('#upload_file');
		
		fileTarget.on('change', function(){			
			var fileSize = -1;
			if(this.files){
				fileSize = this.files[0].size;
				//alert('fileSize='+fileSize);
			}
	
			if(fileCheck_admUpload(this, fileSize)){ 
				// 유효성 검사 성공시
				if(window.FileReader){
					var filename = $(this)[0].files[0].name;
				} else {
					var filename = $(this).val().split('/').pop().split('\\').pop();
				}
	
				// 파일명 셋팅
				$('.input-data').val(filename);
			}else { 
				// 유효성 검사 실패시, input file 요소 초기화
				$(this).val("");
			}
		});
	});
	  
	//지정된 파일 & 용량 확인(관리자)
	 function fileCheck_admUpload(fileObj, fileSize) {
	  	var file = $(fileObj).val();
	  
	  	//파일확장자 검사
	  	var fileExt = file.substring(file.lastIndexOf('.') + 1).toUpperCase();
			if(fileExt != "XLSX"){
				alert("가능한 파일이 아닙니다.");
			$('.input-data').val("");
				$(fileObj).val("");
				$(fileObj).replaceWith($(fileObj).clone(true));
				return false;
			}
	  	
	  	//하위브라우저에서는 확인이 안됨.
	  	if(fileSize== -1){
	  		console.log("구 버전의 브라우저에서는 파일사이즈 검사가 정상적으로 동작하지 않습니다.");
	  		return false;
	  	}
	  	
	  	//파일사이즈 검사
	//  	var maxSize = 5*1024*1024; 
	//  	if (fileSize > maxSize) {
	//  		alert("첨부된 파일의 용량이 초과하였습니다.");
	//  		$("#"+id).replaceWith( $("#"+id).clone(true) );
	//  		return false;
	//  	}
	  	return true;
	 }
	
	// 회원 업로드 데이터 업로드
	function fn_uploadMemData(){
		
		//업로드전 데이터 확인
		if("" == $('#upload_file').val()){
			alert("파일을 선택해주세요.");
			return;
		}
		
		if(confirm("선택하신 파일을 업로드 하시겠습니까?")){
			var chkFlag= '<c:out value="${searchVO.searchParam3}"/>'
			//alert("fn_uploadMemData="+chkFlag);
			if(chkFlag == 'CS') {
				/* $("#frm").attr("action", "<c:url value='/qxsepmny/ech0901/ech0901UploadMemData.do'/>").submit(); */
				$("#frm").attr("action", "<c:url value='/qxsepmny/cmm/CmmCsUploadMemData.do'/>").submit();
			}else if(chkFlag == 'IN') {
				$("#frm").attr("action", "<c:url value='/qxsepmny/cmm/CmmInUploadMemData.do'/>").submit();	
			}else if(chkFlag == 'AST') {
				$("#frm").attr("action", "<c:url value='/qxsepmny/cmm/CmmAstUploadMemData.do'/>").submit();	
			}else if(chkFlag == 'RS') {
				$("#frm").attr("action", "<c:url value='/qxsepmny/cmm/CmmRsUploadMemData.do'/>").submit();	
			}else if(chkFlag == 'SJ') {
				$("#frm").attr("action", "<c:url value='/qxsepmny/cmm/CmmSjUploadMemData.do'/>").submit();	
			}
		}
	}
	
	// Data 검증 탭
	function fn_nextStep() {
		$("#tab2").prop("checked", true);
	}
	
	// 데이터 저장
	function fn_saveMemData() {
		var chkFlag = '<c:out value="${flag}"/>';
		//alert("fn_saveMemData chkFlag= "+chkFlag);
		if(chkFlag == '') {
			alert("데이터일괄저장시 오류가 발생하였습니다. 다시 시도해주세요.");
			return;
		}else {
			$("#uploadFlag").val(chkFlag);
			$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/cmm/CmmSaveAllData.do'/>").submit();	
		}
		
		//if(chkFlag == 'CS') {
			/* $("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/ech0901/ech0901SaveCsData.do'/>").submit(); */
			//$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/cmm/CmmSaveAllData.do'/>").submit();	
		//}else if(chkFlag == 'IN') {
			//$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/cmm/CmmSaveAllData.do'/>").submit();	
		//}else if(chkFlag == 'AST') {
			//$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/cmm/CmmSaveAllData.do'/>").submit();	
		//}
	}

	//파일 다운로드 -> ctms_common.js로 이동 
	//function fn_filedownload(attachSeq, boardType){
		//if(attachSeq == '') {
			//alert('먼저 양식파일을 업로드해주세요(관리자권한 필요)');
			//return;
		//}
		
		//var yncout = '<c:out value="${pageContext.request.contextPath}"/>';
		//alert("yncout= "+yncout);
		
		//location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	//}
	
	//양식첨부기능 시작
	//첨부파일 삭제
	//function fn_delfile(fileKey, seq){
	
		//var html = '';
		//if(seq != ''){
			//html += '<input type="hidden" id="delFile" name="delFile" value="'+seq+'"/>';
		//}
			//html += '<input type="file" id="'+fileKey+'" name="'+fileKey+'" onchange="fn_file_add(\''+fileKey+'\'); return false;"/>';
			//html += '<label for="'+fileKey+'" id="'+fileKey+'_label" class="btn_sub" style="color:red;";>양식업로드</label>';
		
		
		//$("#"+fileKey+"_div").html(html);
	//}
			
	//지정된 파일타입 확인(관리자)
	//function fileCheck_adm2(id) {

		//var file = $("#"+id).val();
		//var fileSize = document.getElementById(id).files[0].size;
		
		//파일확장자 검사
		//var fileExt = file.substring(file.lastIndexOf('.') + 1).toUpperCase();
		//if (id == "titleImg") {
			//if (fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" && fileExt != "PNG") {
				//alert("가능한 파일이 아닙니다.");
				//$("#"+id).replaceWith( $("#"+id).clone(true) );
				//return false;
			//}			
		//}else if (id == "attachedFile_PDF"){
			//if(fileExt != "PDF"){
				//alert("가능한 파일이 아닙니다.");
				//$("#"+id).replaceWith( $("#"+id).clone(true) );
				//return false;
			//}
		//}else if (fileExt != "XLSX") {
					//alert("가능한 파일이 아닙니다.");
					//$("#"+id).replaceWith( $("#"+id).clone(true) );
					//return false;
		//}
		
		//하위브라우저에서는 확인이 안됨.
		//if(fileSize== -1){
			//console.log("구 버전의 브라우저에서는 파일사이즈 검사가 정상적으로 동작하지 않습니다.");
			//return false;
		//}
		
		//파일사이즈 검사
		//var maxSize = 5*1024*1024; //5메가
		//if (fileSize > maxSize) {
			//alert("첨부된 파일의 용량이 초과하였습니다.");
			//$("#"+id).replaceWith( $("#"+id).clone(true) );
			//return false;
		//}
		//return true;
	//}	
	
	//첨부파일 추가
	//function fn_file_add(fileKey, uplsCd){
		
		//if(fileCheck_adm2(fileKey)){
			
			//var fileValue = $('#'+fileKey).val().split("\\");
			//var fileName = fileValue[fileValue.length-1];
			//var extension = fileName.split(".")[1].toUpperCase();
			//var html = ''
		
			//html+= '<div>';
			//html+= '<span class="input-data2">'+fileName+'</span>';
			//html+= '<a href="#" onclick="fn_delfile(\''+fileKey+'\',\'\');">삭제</a>';
			//html+= '<a href="#" onclick="fn_uploadFile(uplsCd);"  style="color:red;";>양식업로드</a>';
			//html+= '</div>'; 
			
			//$("#"+fileKey+"_label").addClass('dpn');
			//$("#"+fileKey+"_div").append(html); 
        //} 
	//}
	
	
	//양식파일 업로드는 공통기능으로 처리하자 
	function fn_uploadFile(){
	    var form = $('#frm')[0]
	    var data = new FormData(form);
	    
	    var uplsFlag = '<c:out value="${searchVO.searchParam3}"/>';
	    if(uplsFlag == 'CS') {
	    	data.append('upls', 'CSUPLS');	
	    }else if(uplsFlag == 'IN') {
	    	data.append('upls', 'INUPLS');
	    }else if(uplsFlag == 'AST') {
	    	data.append('upls', 'ASTUPLS');
	    }else if(uplsFlag == 'RS') {
	    	data.append('upls', 'RSUPLS');
	    }else if(uplsFlag == 'SJ') {
	    	data.append('upls', 'SJUPLS');
	    }		
	    
	    $('#btnUpload').prop('disabled', true);
		
	    $.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',	        
	        /* url: "<c:url value='/qxsepmny/ech0901/ech0901AjaxUploadFile.do'/>", */
	        url: "<c:url value='/qxsepmny/cmm/CmmAjaxUploadFile.do'/>",
	        data: data,
	        processData: false,
	        contentType: false,
	        cache: false,
	        timeout: 600000,
	        success: function (data) {
	        	$('#btnUpload').prop('disabled', false);
	        	alert('양식파일을 업로드했습니다.')
	        	location.reload();
	    		$('.btn-download-file').removeAttr('disabled');
	    		$('.btn-upload-file').show();

	        },
	        error: function (e) {
	            $('#btnUpload').prop('disabled', false);
	            alert('양식파일 업로드를 실패하였습니다');
	        }
	    });
	
	}
	//양식첨부기능 끝
	
     
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>데이터일괄등록</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀  이곳은 해결해야 할 부분입니다 -->
			<%
				String dispTitle = "" ;
				String dispTitle2 = "";
				switch(dispTitle) {
					case "CS":
						dispTitle2 = "상담 일괄등록";	
						break;
					case "IN":
						dispTitle2 = "입금 일괄등록";	
						break;
					case "AST":
						dispTitle2 = "자산 일괄등록";	
						break;
					case "RS":
						dispTitle2 = "연구 일괄등록";	
						break;
					case "SJ":
						dispTitle2 = "연구대상자 일괄등록";	
						break;
					default:
						dispTitle2 = "일괄등록";
				}
			%>
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="일괄등록"/>
				<jsp:param name="dept2" value="데이터 일괄등록"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>데이터 일괄등록</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="frm" name="frm" method="post" enctype="multipart/form-data">
			<c:import url="/EgovPageLink.do?link=adm/inc/incCsrfToken" />
				<input type="hidden" id="corpCd" name="corpCd" value="${ct1000mVO.corpCd }"/>
				<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
				<input type="hidden" id="uploadFlag" name="uploadFlag"/>

					<div class="tab-box">
					<input id="tab1" type="radio" name="tabs" checked>
					<input id="tab2" type="radio" name="tabs">

					<div class="tab-btn">
						<label for="tab1" class="tab1">Upload</label>
						<label for="tab2" class="tab2">Data 검증</label>
					</div>

					<div id="content1">
						<!-- table -->
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:15%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th><sup>*</sup>Upload 파일</th>
										<td>
											<input type="text" value="파일선택" class="input-data" disabled="disabled">
											<label for="upload_file" class="btn-upload-file">파일업로드</label>
											<input type="file" class="hidden" name="upload_file" id="upload_file"/>											
											<button type="button" class="btn-download-file" onclick="fn_filedownload('<c:out value="${searchVO.searchParam1 }"/>', 'UPLS'); return false;">양식다운로드</button>
										</td>
									</tr>
									<!-- 양식파일업로드 -->
									<tr id="uploadfile_td">
				                        <th scope="row">양식파일</th>
				                         <td id="file_td">
				                            <div class="attach_sec type02 mb02" id="attachRpt01_div">
				                            	<c:choose>
				                            		<c:when test="${attachMap.attachRpt01 != null }">
						                            	<div>
						                            		<span><c:out value="${attachMap.attachRpt01.orgFileName }"/></span>
						                            		<a href="#" onclick="fn_delfile('attachRpt01','<c:out value="${attachMap.attachRpt01.attachNo }"/>');">삭제</a>
						                            	</div>
				                            		</c:when>
				                            		<c:otherwise>
						                            	 <input type="file" id="attachRpt01" name="attachRpt01" onchange="fn_file_add('attachRpt01'); return false;"/>
						                            	<label for="attachRpt01" id="attachRpt01_label" class="btn_sub">양식업로드</label>  
				                            		</c:otherwise>
				                            	</c:choose>
				                            </div>
				                         </td>
                    				</tr>
                    				<!--// 양식파일업로드 -->
								</tbody>
							</table>
						</div>
						<!--// table -->


						<!-- table button -->
<%-- 						<div class="table-button">
							<div class="btn-box">
								<button type="button" class="white btn-upload"  onclick="fn_uploadMemData(); return false;">Upload</button>
								<c:if test="${!empty insertMemList}">
									<a href="#" class="white btn-next" onclick="fn_nextStep(); return false;">다음</a>
								</c:if>
							</div>
						</div> --%>
						<div class="table-button">
							<div class="btn_area">
								<a href="#" class="white btn-upload"  onclick="fn_uploadMemData(); return false;">Upload</a>
								<c:if test="${!empty insertMemList}">
									<a href="#" class="white btn-next type02" onclick="fn_nextStep(); return false;">다음</a>
								</c:if>
							</div>
							<p>*업로드시 파일명은 양식다운로드에서 다운로드한 파일명과 동일해야 합니다.</p>
							<p>*데이터 작성시 다운로드한 양식의 형식을 유지해 주세요.</p>
						</div>
						<!--// table button -->
					</div>

					<div id="content2">
						<!-- table -->
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:15%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>신규정보 검증</th>
										<td>
											<c:choose>
												<c:when test="${fn:length(insertMemList) eq 0}">
													등록할 신규정보가 없습니다.
												</c:when>
												<c:otherwise>
													<c:out value="${fn:length(insertMemList)}" />건      <span>‘저장’버튼을 클릭하면 신규정보만 등록됩니다.</span>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									
									<tr>
										<th>중복정보 검증</th>
										<td>
											<c:out value="${fn:length(excelDupMemList)}" />건
											<c:if test="${!empty excelDupMemList}" >
												<!-- <button type="button" class="btn-download-file" onclick="fn_excel('dupMem'); return false;">중복 연구과제 download</button> -->
											</c:if>
										</td>
									</tr>
									
									<c:if test="${!empty excelDupMemList}" >
										<c:forEach var="result" items="${excelDupMemList}" varStatus="status">
										<tr>
											<th><c:out value="${status.count}" /></th>
											<td>
												요청 <c:out value="${result.vendNo}"/>-<c:out value="${result.csDt}"/>-<c:out value="${result.csCont}"/>
												<%-- <c:out value="${result.name}" /> 
												<c:out value="${result.eMail}" />
												<c:out value="${result.phoneNo}" /> --%>
												<br/>
												
												<c:forEach var="dup" items="${result.dupMemList}">
													중복 <c:out value="${dup.vendNo}"/>-<c:out value="${dup.csDt}"/>-<c:out value="${dup.csCont}"/>
													<%-- <c:out value="${dup.name}" /> 
													<c:out value="${dup.eMail}" />
													<c:out value="${dup.phoneNo}" /> --%>
													<br/>
												</c:forEach>
											</td>	
											</tr>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
						</div>
						<!--// table -->


						<!-- table button -->
						<%-- <div class="table-button">
							<div class="btn-box">
								<c:if test="${!empty insertMemList}">
									<button type="button" class="white btn-save" onclick="fn_saveMemData(); return false;">저장</button>
								</c:if>
							</div>
						</div> --%>
						<div class="table-button">
							<div class="btn_area">
								<c:if test="${!empty insertMemList}">
									<a class="white btn-save" onclick="fn_saveMemData(); return false;">저장</a>
								</c:if>
							</div>							
						</div>
						<!--// table button -->
						
					</div>
					
					<div class="errors">
						<c:forEach var="result" items="${errors}" varStatus="status">
							<b><c:out value="${status.count}" /></b>.<span style="color:red;">${result.value}</span>
							<br/> 
						</c:forEach>
					</div>
				</div>
	            
            </form:form>
            <!-- 버튼 -->
			<!-- <div class="btn_area">
				 <a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_delete(); return false;" class="type02" >삭제</a>
				<a href="#" onclick="fn_update(); return false;" class="nonDisp type02" >수정</a>
			</div> -->
			<!-- //버튼 -->
		</div>
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
<script type="text/javascript">


</script>
</body>
</html>