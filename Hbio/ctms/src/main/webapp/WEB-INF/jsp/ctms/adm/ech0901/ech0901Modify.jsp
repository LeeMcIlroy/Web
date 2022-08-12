<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function closeLayer( obj ) {
		$(obj).parent().parent().hide();
	}

	$(function(){

		//수정인 경우 CS_NO 생성하는 컬럼을 사용하지 못하게 처리해야 함
		var yndataRegnt = '<c:out value="${cs1000mVO.dataRegnt}"/>';
		if(!yndataRegnt=='') {
			$('#csNo').attr('disabled', 'true');
			$('#vendNo').attr('disabled', 'true');
			$('#vendName').attr('disabled', 'true');
			$('#btn_regVend').hide();
			$('.dispNone').hide();
			//$('#btn_csChk').hide();
		} else {
			$('#csNo').attr('disabled', 'true');
		}
		
		$("#modi-pop").change(function(){
			html = '<tr>';
			html += '	<td colspan="5">이름을 검색해주세요.</td>';
			html += '</tr>';
			$("#stdBody").html(html);
		});
		
		$("#modi-pop11").change(function(){
			html = '<tr>';
			html += '	<td colspan="5">이름을 검색해주세요.</td>';
			html += '</tr>';
			$("#stdBody11").html(html);
		});
		
		$("#modi-pop2").change(function(){
			html = '<tr>';
			html += '	<td colspan="5">고객사명을 검색해주세요.</td>';
			html += '</tr>';
			$("#stdBody2").html(html);
		});
		
	});	
	
	var resultList;
	
	function fn_search(){
		$.ajax({
			url: "<c:url value='/qxsepmny/ech1005/ech1005AjaxSearchStaff.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '	<td>'+resultList[i].empNo+'</td>';
					html += '	<td>'+resultList[i].empName+'</td>';
					html += '	<td>'+resultList[i].orgNm+'</td>';
					html += '	<td>'+resultList[i].branchNm+'</td>';
					html += '	<td>'+resultList[i].rsClsNm+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="5">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}

	function fn_select(i){
		var result = resultList[i];
		
		//팝업에서 선택한 값을 설정한다.
		$("#empNo").val(result.empNo);
		$("#empName").val(result.empName);
		$("#branchCd").val(result.branchCd);
		//$("#nameTd").html(result.name);
		//$("#orgNmTd").html(result.orgNm);
		//$("#bracnNmTd").html(result.branchNm);
		//$("#rsClsNmTd").html(result.rsClsNm);		
		
		$("#modi-pop").click();
		
		resultList = null;
	}
	
	function fn_search11(){
		$.ajax({
			url: "<c:url value='/qxsepmny/ech1005/ech1005AjaxSearchStaff.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord11").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select11('+i+'); return false;">';
					html += '	<td>'+resultList[i].empNo+'</td>';
					html += '	<td>'+resultList[i].empName+'</td>';
					html += '	<td>'+resultList[i].orgNm+'</td>';
					html += '	<td>'+resultList[i].branchNm+'</td>';
					html += '	<td>'+resultList[i].rsClsNm+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="5">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody11").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}

	function fn_select11(i){
		var result = resultList[i];
		
		//팝업에서 선택한 값을 설정한다.
		$("#empNo").val(result.empNo);
		$("#empName").val(result.empName);
		//$("#nameTd").html(result.name);
		//$("#orgNmTd").html(result.orgNm);
		//$("#bracnNmTd").html(result.branchNm);
		//$("#rsClsNmTd").html(result.rsClsNm);		
		
		$("#modi-pop11").click();
		
		resultList = null;
	}
	
	
	function fn_search2(){
		$.ajax({
			url: "<c:url value='/qxsepmny/ech1005/ech1005AjaxSearchVendor.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord2").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select2('+i+'); return false;">';
					/* html += '	<td>'+resultList[i].vendNo+'</td>'; */
					html += '	<td>'+resultList[i].vendName+'</td>';
					html += '	<td>'+resultList[i].excutName+'</td>';
					html += '	<td>'+resultList[i].dispbregRsno+'</td>';
					html += '	<td>'+resultList[i].telno+'</td>';
					html += '	<td>'+resultList[i].mngName+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="5">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody2").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}

	function fn_select2(i){
		var result = resultList[i];
		
		//팝업에서 선택한 값을 설정한다.
		$("#vendNo").val(result.vendNo);
		$("#vendName").val(result.vendName);
		//업무담당자,연락처,이메일을 설정한다.
		$("#rcsName").val(result.mngName);
		$("#rcsTel").val(result.mnghpNo);
		$("#rcsEmail").val(result.mngEmail);
		
		//$("#nameTd").html(result.name);
		//$("#orgNmTd").html(result.orgNm);
		//$("#bracnNmTd").html(result.branchNm);
		//$("#rsClsNmTd").html(result.rsClsNm);		
		
		$("#modi-pop2").click();
		
		resultList = null;
	}

	function fn_search3(){
		var searchWord = $("#searchWord2").val();
		var csNo = $("#csNo").val();
		var vendNo = $("#vendNo").val();
		if(vendNo == ''){
			alert('먼저 고객사를 선택해 주세요');
			return;
		}
		$.ajax({
			url: "<c:url value='/qxsepmny/ech0901/ech0901AjaxSearchCs.do'/>"
			, type: "post"
			, data: "searchWord="+searchWord+"&"+"vendNo="+vendNo+"&"+"csNo="+csNo
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select2('+i+'); return false;">';
					/* html += '	<td><input type="checkbox" name="csSeq" value="'+resultList[i].csNo+'""/></td>'; */
					html += '	<td>'+resultList[i].rownum+'</td>';
					html += '	<td>'+resultList[i].csDt+'</td>';
					html += '	<td>'+resultList[i].empName+'</td>';
					html += '	<td>'+resultList[i].csClsNm+'</td>';
					html += '	<td>'+resultList[i].csCont+'</td>';
					html += '	<td>'+resultList[i].rcsName+'</td>';
					html += '	<td>'+resultList[i].rcsTel+'</td>';
					html += '	<td>'+resultList[i].rcsEmail+'</td>';
					html += '	<td>'+resultList[i].remk+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="9">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody3").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0901/ech0901List.do'/>";
	}	
		
	function fn_update(){
		var regDt = $('#datepicker01').val();			
		if(regDt==''){
			alert('상담일자를 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
		
		var empNo = $('#empNo').val();
		if(empNo==''){
			alert('상담자를 입력해주세요.')
			$('#empNo').focus();
			return;
		}
		
		var vendNo = $('#vendNo').val();
		if(vendNo==''){
			alert('고객사를 입력해주세요.')
			$('#vendNo').focus();
			return;
		}
		
		var csCls = $('#csCls').val();
		if(csCls==''){
			alert('상담분야를 입력해주세요.')
			$('#csCls').focus();
			return;
		}
		
		var csCont = $('#csCont').val();
		if(csCont==''){
			alert('상담내용을 입력해주세요.')
			$('#csCont').focus();
			return;
		}
		
		var rcsName = $('#rcsName').val();
		if(rcsName==''){
			alert('담당자를 입력해주세요.')
			$('#rcsName').focus();
			return;
		}
		
		var tel = $('#rcsTel').val();
		if(tel != '') {
			var exptext = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
		    if(exptext.test(tel)==false){
		        alert("전화번호형식이 올바르지 않습니다.");
		        $('#rcsTel').focus();
		        return;
		    }	
		}
		
		var email = $('#rcsEmail').val();
		if(email != '') {
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		    if(exptext.test(email)==false){
		        //이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		        alert("이메일형식이 올바르지 않습니다.");
		        $('#rcsEmail').focus();
		        return;
		    }	
		}
		
		$('#csNo').removeAttr('disabled');
		$('#vendNo').removeAttr('disabled');		
		$('#vendName').removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0901/ech0901Update.do'/>").submit();
	}
	
	//고객사 간편등록 팝업
	function fn_regVend(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0901/ech0901VendmgPop.do'/>?corpCd="+corpCd
				, '고객사간편등록', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//첨부파일 삭제
	function fn_delfile(fileKey, seq){
	
		var html = '';
		if(seq != ''){
			html += '<input type="hidden" id="delFile" name="delFile" value="'+seq+'"/>';
		}
			html += '<input type="file" id="'+fileKey+'" name="'+fileKey+'" onchange="fn_file_add(\''+fileKey+'\'); return false;"/>';
			html += '<label for="'+fileKey+'" id="'+fileKey+'_label" class="btn_sub">파일업로드</label>';
		
		
		$("#"+fileKey+"_div").html(html);
	}
	
	//첨부파일 추가
	function fn_file_add(fileKey){
		
		if(fileCheck_adm(fileKey)){
			var fileValue = $('#'+fileKey).val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
			var html = ''
		
			html+= '<div>';
			html+= '<span>'+fileName+'</span>';
			html+= '<a href="#" onclick="fn_delfile(\''+fileKey+'\',\'\');">삭제</a>';
			html+= '</div>'; 
			
			$("#"+fileKey+"_label").addClass('dpn');
			$("#"+fileKey+"_div").append(html); 
        } 
	}
	
	// 이하 추가된 내용 
	//파일업로드  추가. 해당 요소 업로드 제거 핸들링
	$(document).ready(function(){
		   $("#addFile").on("click", function(e){ 
	    	
	    	e.preventDefault(); 
	    	fn_addFile();
	    });
		   $("a[name='delete']").on("click", function(e){ //삭제 버튼 
			   e.preventDefault(); 
		   fn_deleteFile($(this)); 
		   

		});

	});

	//파일업로드 추가
	var file_count = 1;

	function fn_addFile(){
		
	var file_cnt = ++file_count;
	var fileHtml = document.getElementById('fileDiv');
	var fileHtmlCnt = fileHtml.childElementCount; // 자식 요소 카운트

	      if (fileHtmlCnt >= 5) {
			alert('파일첨부는 5개까지만 가능합니다.');
			return false;
	      }else{

	    var html = '<p class="file-upload"><input type="text" value="파일선택" class="input-data p40" id="fileName_'+(file_cnt)+'" disabled="disabled" >';     
	        html += '<label for="upload_file_'+(file_cnt)+'" class="btn_sub"  style="margin-left: 7px;">파일업로드</label>';
	        /* html += '<label for="upload_file_'+(file_cnt)+'" class="btn_sub" style="margin-left: 4px;">파일업로드</label>'; */
	        html +='<input type="file" class="hidden" id="upload_file_'+(file_cnt)+'" name="file_'+(file_cnt)+'" />';
	        html +='<a href="#" name="delete" ><button class="white"  style="margin-left: 2px;">x</button></a>';
	        /* html +='<a href="#" name="delete" ><button class="white" style="margin-left: 5px;">x</button></a>'; */
	        html += '</p>' ;
	        
	        // 동적추가
	        $("#fileDiv").append(html); 
	        
	        //이 값은 이 값이다.
	        $("#upload_file_"+(file_cnt)).change(function(){ 
	        	if(fileCheck_adm('upload_file_'+(file_cnt))){
	    			var fileValue = $('#upload_file_'+(file_cnt)).val().split("\\");
	    			var fileName = fileValue[fileValue.length-1];
	    			var extension = fileName.split(".")[1].toUpperCase();
	    		
	     		/* if(extension != 'JPG'){
	    			alert('JPG만이 첨부 가능합니다');
	    			$('#upload_file').val('');
	    			return;
	    		} */
	    		$("#fileName_"+(file_cnt)).val(fileName);
	    		}
	         
	        });
	        
	        $("a[name='delete']").on("click", function(e){ //삭제 버튼 
	        	e.preventDefault(); 
	        	
	        fn_deleteFile($(this)); 
	        
	        });
	         
	      }
	}
	//파일업로드 text박스 제거
	function fn_deleteFile(obj){
		obj.parent().remove();
		}


	//파일 업로드. 이 값은 이값이다.
	 $(function(){
		
		 $("#upload_file_0").change(function(){
		
			if(fileCheck_adm('upload_file_0')){
				var fileValue = $('#upload_file_0').val().split("\\");
				var fileName = fileValue[fileValue.length-1];
				var extension = fileName.split(".")[1].toUpperCase();
			
			$("#fileName_0").val(fileName);
	 		/* if(extension != 'JPG'){
				alert('JPG만이 첨부 가능합니다');
				$('#upload_file').val('');
				return;
			} */

		        }
		 });
		 $("a[name='delete_0]").on("click", function(e){ //삭제 버튼 
		      	e.preventDefault(); 
		      	
		      	$("#fileName_0").val('파일선택');
		      
		 });
		 
		});
	 
	 // 수정 페이지  기존파일  x 표시 누를시 파일 삭제
	 function fn_xFile(attachNo){
		 var attachNo = attachNo;
		 
		 if (confirm("파일을 삭제하시겠습니까?")) {
			$.ajax({
				url : '<c:url value='/qxsepmny/ech0901/ech0901DeleteFileUpload.do'/>'
				,type : 'post'
				,data :{'attachNo':attachNo}
				,dataType:'json'
				,success:function(result){
					alert(result.message);
					window.location.reload();
				},error:function(e){
					alert(e);
				}
			 });
		 } 
	 }
	
	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>상담관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="영업관리"/>
	            <jsp:param name="dept2" value="상담관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>상담정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <form:form commandName="cs1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${cs1000mVO.corpCd}">
            <!-- 상담정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>    
                        <th scope="row"><i>*</i>상담일자</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="csDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${cs1000mVO.csDt }" />" class="date required" title="상담일" />
                                    <label for="datepicker01" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="bl"><i>*</i>상담자</th>
                        <td>
                           	<input type="text" value="<c:out value="${cs1000mVO.empName }" />"  class="p30" id="empName" name="empName"/>
                           	<input type="hidden"  value="<c:out value="${cs1000mVO.empNo }" />"  class="p30" id="empNo" name="empNo"/>
                            <label for="modi-pop11" class="btn_sub">조회</label>
                        </td>                        
                    </tr>
                    <tr>
                    	<th scope="row"><span class="dispNone"><i>*</i></span>고객사</th>
                        <td>
                            <input type="text" value="<c:out value="${cs1000mVO.vendName }" />"  class="p50" id="vendName" name="vendName"/>
							<input type="hidden" value="<c:out value="${cs1000mVO.vendNo }" />"  class="p50" id="vendNo" name="vendNo"/>
                            <label for="modi-pop2" class="btn_sub dispNone">조회</label>
                            <a href="#" onclick="fn_search3(); return false;" class="btn_sub" id="btn_csChk">상담이력</a>
                            <a href="#" onclick="fn_regVend(); return false;" class="btn_sub" id="btn_regVend">간편등록</a>
                        </td>
                        <th scope="row" class="bl"><i>*</i>상담분야</th>
                        <td>
                        	<!-- 상담분야 목록(공통코드) CM4000M - CM1360  -->
							<select id="csCls" name="csCls" class="p30">
								<option value="" <c:if test="${cs1000mVO.csCls eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${cm1360}">
									<option value="${result.cd}"<c:if test="${result.cd eq cs1000mVO.csCls}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
						</td>	
					</tr>		
					<tr>
                        <th scope="row"><i>*</i>상담내용</th>                        
                        <td colspan="3">
							<textarea class="type02 type03" id="csCont" name="csCont" placeholder="상담내용을 입력하세요"><c:out value="${cs1000mVO.csCont }" /></textarea>
						</td>                        
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>담당자</th>
                        <td>
							<input type="text" value="<c:out value="${cs1000mVO.rcsName }" />"  class="p50" id="rcsName" name="rcsName" />
						</td>
						<th scope="row" class="bl">연락처</th>
                        <td>
							<input type="text" value="<c:out value="${cs1000mVO.rcsTel }" />"  class="p50" id="rcsTel" name="rcsTel" />
						</td>
					</tr>
					<tr>
                        <th scope="row">메일주소</th>
                        <td colspan="3">
							<input type="text" value="<c:out value="${cs1000mVO.rcsEmail }" />"  class="p30" id="rcsEmail" name="rcsEmail" />
						</td>
					</tr>	
					<tr>
                        <th scope="row">비고</th>                        
                        <td colspan="3">
							<textarea class="type02 type03" id="remk" name="remk"><c:out value="${cs1000mVO.remk }" /></textarea>
						</td>                        
                    </tr>
                    <tr>
						<th scope="row">담당지사</th>
						<td colspan="3">
							<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->
														
							<select id="branchCd" name="branchCd" class="p15">
								<option value="" <c:if test="${cs1000mVO.branchCd eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${branch}">
									<option value="${result.branchCd}"<c:if test="${result.branchCd eq cs1000mVO.branchCd}">selected="selected"</c:if>>${result.branchName}</option>
								</c:forEach>
							</select>	
						</td>
                    </tr>
                    <tr>
                        <th scope="row">관리번호</th>
                        <td colspan="3">
                        	<input type="text" value="<c:out value="${cs1000mVO.csNo }" />"  class="p20" id="csNo" name="csNo"/>
                        </td>
                    </tr>                    
                </tbody>
            </table>
            <!-- 첨부파일 영역 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>파일첨부</h4>	                             
            </div>
            <!-- //서브타이틀 -->
            <!-- 파일첨부 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">첨부파일</th>
                        	<td colspan="3" id="file_td" >
                        	<c:choose>									
								<c:when test="${empty attachList }">
									<div id="fileDiv">
										<p class="file-upload">
											<input type="text" value="파일선택" class="input-data p40" id="fileName_0" disabled="disabled" >
											<label for="upload_file_0" class="btn_sub">파일업로드</label>
											<input type="file" class="hidden" id="upload_file_0" name="file_0" />
											<a href="#"><button class="white" name="delete_0">x</button></a>
											<a href="#" id="addFile"><button class="white" >+</button></a>
										</p>
									</div>							   
						       	</c:when>								
								<c:otherwise>
									<div id="fileDiv">
										<c:forEach  items="${attachList }" var="file" varStatus="status">
											<p class="file-upload">
												<input type="text" value="${file.orgFileName eq null? '파일선택':file.orgFileName}" class="input-data p40" id="fileName_${status.index }" disabled="disabled" >
												<label for="upload_file_${status.index }" class="btn_sub">파일업로드</label>
												<input type="file" class="hidden" id="upload_file_${status.index }" name="file_${status.index }" />
												<%-- <a href="#"><button class="white" name="delete_${status.index }"  onclick="fn_xFile('<c:out value="${file.attachNo}"/>');">x</button></a> --%>
												<a href="#"><button class="white" name="delete_${status.index }"  onclick="fn_delfile('file_0','<c:out value="${file.attachNo}"/>');">x</button></a>
												<c:if test="${status.index == 0}">
													<a href="#" id="addFile"><button class="white" >+</button></a>
												</c:if>
											</p>
										</c:forEach>
						   			</div>
								</c:otherwise>
							</c:choose>
                        	</td>
<%--                         <td colspan="3" id="file_td">
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
				                            	<label for="attachRpt01" id="attachRpt01_label" class="btn_sub">파일업로드</label>  
		                            		</c:otherwise>
	                            	</c:choose>
                            </div>
                        	 <div class="attach_sec type02 mb02" id="attachRpt02_div">
                                 <c:choose>
	                            		<c:when test="${attachMap.attachRpt02 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt02.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt02','<c:out value="${attachMap.attachRpt02.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	 <input type="file" id="attachRpt02" name="attachRpt02" onchange="fn_file_add('attachRpt02'); return false;"/>
			                            	<label for="attachRpt02" id="attachRpt02_label" class="btn_sub">파일업로드</label> 	
	                            		</c:otherwise>
                            	</c:choose> 
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt03_div">
                                 <c:choose>
	                            		<c:when test="${attachMap.attachRpt03 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt03.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt03','<c:out value="${attachMap.attachRpt03.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                                <input type="file" id="attachRpt03" name="attachRpt03" onchange="fn_file_add('attachRpt03'); return false;"/>
			                            	<label for="attachRpt03" id="attachRpt03_label" class="btn_sub">파일업로드</label>    
	                            		</c:otherwise>
                            	</c:choose>     
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt04_div">
                          	     <c:choose>
	                            		<c:when test="${attachMap.attachRpt04 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt04.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt04','<c:out value="${attachMap.attachRpt04.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	 <input type="file" id="attachRpt04" name="attachRpt04" onchange="fn_file_add('attachRpt04'); return false;"/>
			                            	<label for="attachRpt04" id="attachRpt04_label" class="btn_sub">파일업로드</label> 
	                            		</c:otherwise>
                            	</c:choose>     
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt05_div">
              	     			<c:choose>
	                            		<c:when test="${attachMap.attachRpt05 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt05.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt05','<c:out value="${attachMap.attachRpt05.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	 <input type="file" id="attachRpt05" name="attachRpt05" onchange="fn_file_add('attachRpt05'); return false;"/>
			                            	<label for="attachRpt05" id="attachRpt05_label" class="btn_sub">파일업로드</label> 
	                            		</c:otherwise>
                            	</c:choose> 
                            </div>  
                        </td> --%>
                    </tr>
                </tbody>
            </table>
            <!-- //파일첨부 -->
            </form:form>
			<!-- 버튼 -->
			<div class="btn_area">
					<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
					<a onclick="fn_update(); return false;">저장</a>
			</div>
			<!-- //버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info" id="mtl">			
				<h4>상담 이력</h4>
				<!-- 버튼 -->
				<div>
					<%-- <a href="#" class="btn_sub type02" onclick="fn_mtlpop('i','<c:out value="${rs1000mVO.corpCd }"/>','<c:out value="${rs1000mVO.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>',''); return false;" id="btnRegMtl">등록</a>
					<a href="#" class="btn_sub" onclick="fn_delMtl(); return false;" id="btnDelMtl">삭제</a> --%>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 상담 정보 -->
			<table class="tbl_list">
				<colgroup>
					<%-- <col style="width:5%" /> --%>
					<col style="width:5%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:10%" />
					<col style="width:auto" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:10%" />
					<col style="width:20%" />
				</colgroup>
				<thead>
					<tr>
						<!-- <th><input type="checkbox" id="all-cs"/></th> -->
						<th scope="col">번호</th>
						<th scope="col">상담일자</th>
						<th scope="col">상담자</th>
						<th scope="col">상담분야</th>
						<th scope="col">상담내용</th>
						<th scope="col">담당자</th>
						<th scope="col">연락처</th>
						<th scope="col">이메일</th>
						<th scope="col">비고</th>
					</tr>
				</thead>
				<tbody id="stdBody3">
				<c:forEach var="resultcs" items="${csList}" varStatus="status">
					<tr>					
						<%-- <td><input type="checkbox" name="csSeq" value="<c:out value='${resultcs.csNo }'/>"/></td> --%>
						<td><c:out value="${resultcs.rownum }"/></td>
						<td><c:out value="${resultcs.csDt }"/></td>
						<td><c:out value="${resultcs.empName }"/></td>
						<td><c:out value="${resultcs.csClsNm }"/></td>
						<td><c:out value="${resultcs.csCont }"/></td>
						<td><c:out value="${resultcs.rcsName }"/></td>
						<td><c:out value="${resultcs.rcsTel }"/></td>
						<td><c:out value="${resultcs.rcsEmail }"/></td>
						<td><c:out value="${resultcs.remk}"/></td>
					</tr>
				</c:forEach>
				<c:if test="${csList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="9">상담 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
            <!-- //상담정보 -->
		</div>
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>구성원조회</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>검색어</p>
						<span class="type02">
							<input type="text" name="searchWord" id="searchWord" class="input-data" placeholder="검색어를  입력하세요" />
						</span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_search(); return false;">검색하기</a>
			</div>
			<!-- 사용체크정보 -->
			<!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:auto%" />
					<col style="width:20%" />
					<col style="width:20%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">구성원번호</th>
						<th scope="col">이름</th>
						<th scope="col">부서</th>
						<th scope="col">지사</th>
						<th scope="col">연구원구분</th>
					</tr>
				</thead>
				<tbody id="stdBody">
					<tr>
						<td colspan="5">이름을 검색해주세요.</td>
					</tr>
				</tbody>
			</table>
			<!-- //목록 -->
			<!-- 버튼 -->
            <div class="btn_area">
            	<label for="modi-pop" class="type02 btn-cancel btn_sub">취소</label>			
			</div>
		</div>
		<!-- //팝업 -->
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop11" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup11" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>구성원조회</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>검색어</p>
						<span class="type02">
							<input type="text" name="searchWord11" id="searchWord11" class="input-data" placeholder="검색어를  입력하세요" />
						</span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_search11(); return false;">검색하기</a>
			</div>
			<!-- 사용체크정보 -->
			<!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:auto%" />
					<col style="width:20%" />
					<col style="width:20%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">구성원번호</th>
						<th scope="col">이름</th>
						<th scope="col">부서</th>
						<th scope="col">지사</th>
						<th scope="col">연구원구분</th>
					</tr>
				</thead>
				<tbody id="stdBody11">
					<tr>
						<td colspan="5">이름을 검색해주세요.</td>
					</tr>
				</tbody>
			</table>
			<!-- //목록 -->
			<!-- 버튼 -->
            <div class="btn_area">
            	<label for="modi-pop11" class="type02 btn-cancel btn_sub">취소</label>			
			</div>
		</div>
		<!-- //팝업 -->
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop2" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup2" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>고객사조회</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>검색어</p>
						<span class="type02">
							<input type="text" name="searchWord2" id="searchWord2" class="input-data" placeholder="검색어를  입력하세요" />
						</span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_search2(); return false;">검색하기</a>
			</div>
			<!-- 고객사목록 -->
			<!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<%-- <col style="width:15%" /> --%>
					<col style="width:auto%" />
					<col style="width:15%" />
					<col style="width:20%" />
					<col style="width:20%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<!-- <th scope="col">고객사번호</th> -->
						<th scope="col">고객사명</th>
						<th scope="col">대표자</th>
						<th scope="col">사업등록번호</th>
						<th scope="col">전화번호</th>
						<th scope="col">담당자</th>
					</tr>
				</thead>
				<tbody id="stdBody2">
					<tr>
						<td colspan="5">고객사명을 검색해주세요.</td>
					</tr>
				</tbody>
			</table>
			<!-- //목록 -->
			<!-- 버튼 -->
            <div class="btn_area">
            	<label for="modi-pop2" class="type02 btn-cancel btn_sub" >취소</label>			
			</div>
		</div>
		<!-- //팝업 -->
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
