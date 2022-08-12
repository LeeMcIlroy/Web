<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<!-- <style>
  #sortable { list-style-type: none; margin: 0; padding: 0; width: 100%; }
  #sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 24px; }
  #sortable li span { position: absolute; margin-left: -1.3em; }
</style> -->
<script type="text/javascript">
	$(function(){
			
		//DATA LOCK = 'Y' 인 경우 수정,삭제 불가
		var ynLock = '<c:out value="${rs1000mVO.dataLockYn}"/>';		
		if(ynLock=='Y') {
			$(".btnLockNonDisp").hide();
		}
		
		var ynLock = '<c:out value="${rs1000mVO.dataLockYn}"/>';		
		if(ynLock=='Y') {
			$(".btnLockNonDisp").hide();
		}
		
		//승인완료된 경우 생성버튼, 삭제버튼을 감춘다. mkCls = '1030'
		var ynMkCls = '<c:out value="${rs1000mVO.mkCls}"/>';
		if(ynMkCls > '1010') {
			$(".btnLockNonDisp").hide();
		}

		//CRF상태 - 대기, 작성중, 확정 
		var ecrfState = '<c:out value="${rs1000mVO.ecrfState}"/>';
		
		switch(ecrfState) {
		case "WAIT" :  
			$("#ecrfState1").attr('checked', 'checked');
			break;
		case "WRIT" :  
			$("#ecrfState2").attr('checked', 'checked');
			break;
		case "CONF" :  
			$("#ecrfState3").attr('checked', 'checked');
			break;		
		default :
			$("#ecrfState3").attr('checked', 'checked');	
		}		

		//CRF설정차수 목록 선택
		$("#all-crf").change(function(){
			$("input[name=svSeq").prop("checked", $(this).prop('checked'));
		});
		
	});
	
	/* function fn_update(){
		var svItem = document.getElementsByClassName('chkcnt');
		//alert("update"+svItem.length);		
		for(var i=0; i<svItem.length; i++) {
			$('#tempType_'+i).removeAttr('disabled');
			$('#tempNo_'+i).removeAttr('disabled');	
		}
		
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0211/ech0211Update.do'/>").submit();
	} */
	
	function fn_temp(num){
		var tempType = $("#tempType_"+num).val();
		//alert(tempType);
		var html = '<option>템플릿명</option>';		
		
		if(tempType != ''){
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0211/ajaxSelectTempList.do'/>"
				, type: "post"
				, data: "tempType="+tempType
				, dataType:"json"
				, success: function(data){
					var tempList = data.tempList;
					
					for(var i=0; i<tempList.length; i++){
						html += '<option value="'+tempList[i].tempNo+'">'+tempList[i].tempNm+'</option>';						
					}
					
					$("#tempNo_"+num).html(html);
					
					var tempList2 = data.CT3020;
					var typeName = "";
					for(var i=0; i<tempList2.length; i++){
						if(tempList2[i].cd == tempType ) {
							typeName = tempList2[i].cdName;
						}
					}
					$("#title_"+num).val(typeName);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}else{
			$("#tempNo_"+num).html(html);
		}
	}
	
	/* function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0211/ech0211List.do'/>";
	} */
	
	//목록으로
	function fn_list(){
		$("#frm2").attr("action", "<c:url value='/qxsepmny/ech0211/ech0211List.do'/>").submit();
	}
	
	
	

	/* function test() {
		var totalpage = sessionStorage.getItem("totalpage");
		var cnt =$('.tbl_view').length-2;
		document.getElementById("upageCnt_"+cnt).value = totalpage;
		sessionStorage.removeItem("totalpage");

	} */
	//고객사 간편등록 팝업
	function fn_regVend(){
		if(confirm('새로운 CRF단계 간편정보를 등록합니다. 먼저 현재 작업중인 정보를 저장하시고 작업을 진행해주세요.\r\n진행 하시겠습니까?')){
			window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0211/ech0211VendmgPop.do'/>"
					, 'CRF단계등록', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
		}
	}

	//설정한 CRF보기
	function fn_viewCrf(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0211/ech0211ViewCrf.do'/>").submit();
	}
		
	

	//시험물질 정보 추가/수정 -> 수정을 팝업으로 할 경우 고려하고 하단 입력화면으로 구성할 경우는 삭제 할 것  
	function fn_crfpop(mode, corpCd, rsNo, svSeq){
		
		var _left = Math.ceil(( window.screen.width - 500 )/2);
	    var _top = Math.ceil(( window.screen.height - 500 )/2); 
	   	//alert("rsNo= "+rsNo);
	   	//alert("rsCd= "+rsCd);

		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101MtlmgPop.do'/>?mode="+mode+"&corpCd="+corpCd+"&rsNo="+rsNo+"&rsCd="+rsCd+"&mtlNo="+mtlNo+"&mrsNo="+mrsNo
				, '시험물질정보관리', 'width=500, height=500, left='+ _left+',top='+_top+', menubar=no, status=no, toolbar=no, scrollbars=1');
	}

	// CRF설정 등록 
	function fn_addCrf(){

		//입력값 검증		
		var svSeq = $("#svSeq").val();
		if(svSeq=='') {
			alert('작성차수를 선택해주세요.');
			$('#svSeq').focus();
			return;
		}

		//작성차수 중복을 체크해야 한다 -> Controller에서 처리한 것으로 함 -> front-end에서 처리하는 방식도 확인필요.
								
		var tempNo = $("#tempNo_0").val();
		if(tempNo=='') {
			alert('작성차수의 템플릿을 선택해주세요.');
			$('#tempType_0').focus();
			return;
		}
		var title = $("#title_0").val();
		if(title=='') {
			alert('명칭을 입력해주세요.');
			$('#title_0').focus();
			return;
		}		
		/* if(tempNo=='템플릿명') {
			var upageCnt = $("#upageCnt_0").val();
			if(upageCnt=='') {
				alert('구성쪽수를 입력해주세요.');
				$('#upageCnt_0').focus();
				return;
			}
		}	 */			
		if(confirm('새로운 CRF차수정보를 등록합니다. 설정된 작성차수를 확인해주세요. \r\n설정하시겠습니까?')){			
			var form = $('#frm')[0];  	    
			    // Create an FormData object          
			var data = new FormData(form);  

			var tempType = $("#tempType_0").val();
			var rsNo = $("#rsNo").val();
			var tempNo = $("#tempNo_0").val();
			if(tempType=='4000') { //연구대상자특성
				fn_ubi_pop('frm2', 'survey_2','corpCd#HNBSRC#type#survey_2#tempNo#'+tempNo+'#rsNo##');
				//setTimeout(test, 5000);
				setTimeout(fn_addCrfView, 5000);
			}else if(tempType=='4010') { //사용성설문
				fn_ubi_pop('frm2', 'survey_2','corpCd#HNBSRC#type#survey_2#tempNo#'+tempNo+'#rsNo##');
				//setTimeout(test, 5000);
				setTimeout(fn_addCrfView, 6000);
			}else if(tempType=='4020') { //효능설문
				fn_ubi_pop('frm2', 'survey_2','corpCd#HNBSRC#type#survey_2#tempNo#'+tempNo+'#rsNo##');
				//setTimeout(test, 5000);
				setTimeout(fn_addCrfView, 6000);
			}else { //CRF템플릿 파일 첨부 시 
				fn_addCrfData("0");
			}
			
		}
	
	}

	function fn_addCrfView() {
		var totalpage = sessionStorage.getItem("totalpage");
		//var cnt =$('.tbl_view').length-2;
		//document.getElementById("upageCnt_"+cnt).value = totalpage;
		sessionStorage.removeItem("totalpage");
		//alert("remove totalpage= "+totalpage);
		//alert("totalpage= "+totalpage);
		fn_addCrfData(totalpage);
		return totalpage;

	}

	function fn_addCrfData(totalpage) {
		$("#totalpage").val(totalpage);
		var form = $('#frm')[0];  	    
	    // Create an FormData object          
		var data = new FormData(form); 
		$.ajax({
			url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0211/ech0211AjaxAddCrf.do'/>"
			, type: "post"
			, data: data
			, dataType:"json"
			, processData: false    
		    , contentType: false      
		    , cache: false           
		    , timeout: 600000
			, success: function(data){
				alert(data.message);					
				if(data.rtCd != "D") {
					window.location.reload();	
				}
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	
	}
	
	// 연구관리 CRF상태 저장 - 대기, 작성중, 확정 - '확정'상태만 CRF 작성설정 가능  
	function fn_updateCrfState(){
		if(confirm('CRF설정 상태를 변경 합니다. 확정 상태인 경우 CRF작성설정이 가능합니다. \r\n변경하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var ecrfState = $("input[name=ecrfState]:checked").val();
			//alert(corpCd);
			//alert(rsNo);
			//alert(ecrfState);
			
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0211/ech0211AjaxUpdateCrfState.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"ecrfState="+ecrfState
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
			
		}
	}

	//첨부파일 추가
	function fn_file_add(fileKey){
		//alert("fileKey= "+fileKey);
		
		if(fileCheck_adm(fileKey)){
			var fileValue = $('#'+fileKey).val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
			var html = ''
		
			html+= '<div>';
			html+= '<span>'+fileName+'</span>';
			html+= '<a onclick="fn_delfile(\''+fileKey+'\',\'\');">삭제</a>';
			html+= '</div>'; 
			
			$("#"+fileKey+"_label").addClass('dpn');
			$("#"+fileKey+"_div").append(html); 
			$("#fileKey_"+fileKey).val(fileKey);						
        } 
	}

	//첨부파일 삭제
	function fn_delfile(fileKey, seq){
	
		var html = '';
		if(seq != ''){
			html += '<input type="hidden" id="delFile" name="delFile" value="'+seq+'"/>';
		}
			html += '<input type="file" id="'+fileKey+'" name="'+fileKey+'" onchange="fn_file_add(\''+fileKey+'\'); return false;"/>';
			html += '<label for="'+fileKey+'" id="'+fileKey+'_label" class="btn_sub">CRF파일업로드</label>';
		
		$("#"+fileKey+"_div").html(html);
	}

	//CRF설정 정보 삭제
	function fn_delCrf(){	
		if($("input[name=svSeq]:checked").length == 0){
			alert('삭제할 CRF설정 정보를 선택해 주세요.');
			return;
		}
		if(confirm('선택하신 CRF설정 정보를 삭제합니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0211/ech0211AjaxDelCrf.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+$("input[name=svSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}

	//CRF작성설정 재설정
	function fn_resetSvSeq(){
		$("input[name=svSeq").prop("checked", "checked");

		if(confirm('CRF작성차수를 재설정합니다. 화면에서 조정한 작성차수를 확인하세요. \r\n재설정하시겠습니까?')){	
			var form = $('#frm')[0];  	    
	    	// Create an FormData object          
			var data = new FormData(form);
			
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0211/ech0211AjaxResetSvSeq.do'/>"
				, type: "post"
				, data: data 
				, dataType:"json"
				, processData: false    
			    , contentType: false      
			    , cache: false 					
				, success: function(data){
					alert(data.message);
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}

	/* function onlyUnique(value, index, self) {
	    return self.indexOf(value) === index;
	}

	// usage example:
	var a = ['a', 1, 'a', 2, '1'];
	var unique = a.filter( onlyUnique ); // returns ['a', 1, 2, '1']
	unique

 */
 	$(function() {
		$("#sortable").sortable();
		$("#sortable").disableSelection();
	});	

	//안전성평가CRF생성(피부자극)
	function fn_addCrfSkinStim(){	
		
		if(confirm('안전성평가 CRF를 자동설정합니다. 등록된 시험물질정보를 확인해주세요.\r\n생성하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var step1 = $("#step1").val();	
			var step2 = $('input[name=step2]:checked').val(); //평가주기 1 30분후 2 24시간후	
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0211/ech0211AjaxAddCrfSkinStim.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}

	function fn_openTempTitle(){
		$("#modi-pop").prop("checked", "true");
	}

	//CRF등록화면으로 이동
	setTimeout(function() {
		var crf = "crf";				
	      if(crf != null){   
	    	   
	    	   	document.getElementById("inputCrf").scrollIntoView();
				//localStorage.removeItem(mtl);
	       }
	       	       
	}, 500);


	//연구대상자 일괄등록 화면 전환
	function fn_AddAllUpload(){
		if(confirm('(연구대상자)일괄등록 화면으로 전환됩니다. \r\n진행하시겠습니까?')){
			$("#uploadFlag").val("SJ");
			$("#frm").attr("action","<c:url value='/qxsepmny/cmm/CmmUplsUpload.do'/>").submit();
	 		//$("#listForm").attr("action","<c:url value='/qxsepmny/ech0901/ech0901CsUpload.do'/>").submit();
		}
	}	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- 검색조건유지 설정 -->
    <form:form commandName="searchVO" id="frm2" name="frm2">
    	<form:hidden path="searchCondition1"/>
    	<form:hidden path="searchCondition2"/>
    	<form:hidden path="searchCondition3"/>
    	<form:hidden path="searchCondition4"/>
    	<form:hidden path="searchCondition5"/>
    	<form:hidden path="searchCondition6"/>
    	<form:hidden path="searchCondition7"/>
    	<form:hidden path="searchCondition8"/>
    	<form:hidden path="searchYear"/>
    	<form:hidden path="searchWord"/>
    	<input type="hidden" id="file" name="file"/>
    </form:form>
    <!-- //검색조건유지 설정 -->
	<form:form commandName="cr2110mVO" id="frm" name="frm" method="post" enctype="multipart/form-data">	
		<form:hidden path="rsNo"/>
		<form:hidden path="corpCd"/>		
		<input type="hidden" id="totalpage" name="totalpage"/>
		<input type="hidden" id="uploadFlag" name="uploadFlag"/>
		<!-- <input type="hidden" id="tempNo" name="tempNo"/> -->
		<!-- container -->
		<div class="container">
			<h2>CRF설정관리</h2>
			<!-- contents -->
			<div class="contents">
				<!-- 타이틀 -->
				<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="eCRF관리"/>

		            <jsp:param name="dept2" value="CRF설정관리"/>
	           	</jsp:include>
				<!-- //타이틀 -->
				<!-- 서브타이틀 -->
				<div class="sub_title_area type02">
					<h4>기본정보</h4>
				</div>
				<!-- //서브타이틀 -->
	            <!-- 기본정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">연구코드</th>
							<td>
								<c:out value="${rs1000mVO.rsCd }"/>
								<c:choose>
									<c:when test="${rsFinSetChkCnt eq 0 }">
										<span style="color:red;">(CRF설정확인:연구종료확인서 미설정)</span>
									</c:when>
								</c:choose>							
							</td>
							<th scope="row" class="bl">연구명</th>
							<td><c:out value="${rs1000mVO.rsName }"/></td>
						</tr>
						<tr>
							<th scope="row">eCRF상태</th> 
	                        <td>
	                        	<input type="radio" name="ecrfState" id="ecrfState1" value="WAIT" />
	                            <label for="ecrfState1">대기</label>
	                            <input type="radio" name="ecrfState" id="ecrfState2" value="WRIT" />
	                            <label for="ecrfState2">작성중</label>
	                            <input type="radio" name="ecrfState" id="ecrfState3" value="CONF" checked="checked" />
	                            <label for="ecrfState3">확정</label>                            	                            
	                        </td> 
	                        <th scope="row" class="bl">총구성쪽수</th>
							<td><c:out value="${rs1000mVO.tpageCnt }"/><span>(등록 연구대상자수:<c:out value="${rsiCnt }"/>명)</span>
							</td>
						</tr>							
					</tbody>
				</table>				
	            <!-- //기본정보 -->
	            <!-- 버튼 -->
				<!-- <div class="btn_area">
					<a href="#" class="type02" onclick="fn_list(); return false;">목록</a>
					<a href="#" onclick="fn_update(); return false;" class="btnLockNonDisp">저장</a>
					<a href="#" onclick="fn_regVend(); return false;" class="btn_sub btnLockNonDisp" id="btn_regVend">CRF단계등록</a>
					<a href="#" class="type02" onclick="fn_viewCrf(); return false;">CRF(보기)</a>
				</div> -->
				<!-- //버튼 -->
				<div class="btn_area">
					<a href="#" class="type02" onclick="fn_list(); return false;">목록</a>
					<a href="#" onclick="fn_updateCrfState(); return false;" class="btnLockNonDisp">CRF상태 저장</a>					
				</div>
				<div class="tbl_top_info">			
					<h4>CRF설정 정보 - 작성차수변경은 Drag&Drop기능으로 작성순서를 변경 후 '차수재설정' 버튼을 눌러주세요 </h4>
					<!-- 버튼 -->
					<div id ="crf">
						<%-- <a href="#crf" class="btn_sub type02 btnLockNonDisp" onclick="fn_crfpop('i','<c:out value="${rs1000mVO.corpCd }"/>','<c:out value="${rs1000mVO.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>','','<c:out value="${rs1000mVO.mrsNo }"/>'); return false;" id="btnRegcrf">등록</a> --%>
						<a href="#" class="btn_sub btnLockNonDisp" onclick="fn_resetSvSeq(); return false;" id="btnresetSvSeq">차수재설정</a>
						<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_delCrf(); return false;" id="btnDelcrf">삭제</a>
						<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_AddAllUpload(); return false;">연구대상자 일괄등록</a>						
					</div>
				</div>
					
					<!-- <div id="survey_list"> -->					
					<ul id="sortable">
					<c:forEach var="resultcrf" items="${eCrfList}" varStatus="status">
					<li class="uk-stat-default">
					<table class="tbl_view">
										<colgroup>
											<col style="width:15%" />
											<col style="width:35%" />
											<col style="width:15%" />
											<col style="width:35%" />
										</colgroup>
										<tbody>
						<tr>
							<th scope="row" >작성차수</th>
							<td>
								<c:out value="${resultcrf.svSeq }"/>
								<!-- --><!-- <input type="text" name="resetSvSeq" class="p10"/> -->
								<input type="checkbox" name="svSeq" value="<c:out value='${resultcrf.svSeq }'/>"/>
							</td>
							<th scope="row" class="bl">사용명칭</th>	
							<td><c:out value="${resultcrf.title }"/></td>
						</tr>
						<tr>
							<th scope="row">템플릿</th>
							<td><c:out value="${resultcrf.tempTypeNm }"/>><c:out value="${resultcrf.tempNm }"/></td>						
							<th scope="row" class="bl">구성정보</th>		
							<td>
								<c:choose>	                          		
									<c:when test="${resultcrf.svyYn eq 'Y' and resultcrf.tempType eq '4080'}">
										<a href="#" onclick="fn_ubi_pop('frm2', 'survey_3', 'corpCd#<c:out value='${resultcrf.corpCd }'/>#rsNo#<c:out value='${resultcrf.rsNo }'/>#tempNo#<c:out value='${resultcrf.tempNo }'/>#rsiNo#<c:out value='${resultcrf.rsiNo }'/>#rsjNo#<c:out value='${resultcrf.rsjNo }'/>#usrName#<c:out value="${resultcrf.rsiNo }"/>#type#survey_3'); return false;" class="btn_sub">피부자극</a>
										구성쪽수:<c:out value='${resultcrf.upageCnt }'/>  시작번호:<c:out value='${resultcrf.spageCnt }'/>
									</c:when>
									<c:when test="${resultcrf.svyYn eq 'Y' and resultcrf.tempType eq '4000' }">
										<a href="#" onclick="fn_ubi_pop('frm2', 'survey_2', 'corpCd#<c:out value='${resultcrf.corpCd }'/>#rsNo#<c:out value='${resultcrf.rsNo }'/>#tempNo#<c:out value='${resultcrf.tempNo }'/>#rsiNo#<c:out value='${resultcrf.rsiNo }'/>#rsjNo#<c:out value='${resultcrf.rsjNo }'/>#usrName#<c:out value="${resultcrf.rsiNo }"/>#type#survey_2'); return false;" class="btn_sub">특성</a>
										구성쪽수:<c:out value='${resultcrf.upageCnt }'/>  시작번호:<c:out value='${resultcrf.spageCnt }'/>
									</c:when>
									<c:when test="${resultcrf.svyYn eq 'Y' and resultcrf.tempType ne '4000'}">
										<a href="#" onclick="fn_ubi_pop('frm2', 'survey_1', 'corpCd#<c:out value='${resultcrf.corpCd }'/>#rsNo#<c:out value='${resultcrf.rsNo }'/>#tempNo#<c:out value='${resultcrf.tempNo }'/>#rsiNo#<c:out value='${resultcrf.rsiNo }'/>#rsjNo#<c:out value='${resultcrf.rsjNo }'/>#usrName#<c:out value="${resultcrf.rsiNo }"/>#type#survey_1'); return false;" class="btn_sub">설문</a>
										구성쪽수:<c:out value='${resultcrf.upageCnt }'/>  시작번호:<c:out value='${resultcrf.spageCnt }'/>
									</c:when>
									<c:when test="${resultcrf.svyYn eq 'N' }">
										<!-- 템플릿번호로 파일 찾기 -->
										<a href="#" onclick="fn_ubi_pop2('frm2', <c:out value='${resultcrf.tempNo }'/>, 'corpCd#<c:out value='${resultcrf.corpCd }'/>#tempNo#<c:out value='${resultcrf.tempNo }'/>#type#crf#title#<c:out value='${resultcrf.tempNo }'/>', '', <c:out value='${resultcrf.tempNo }'/>); return false;" class="btn_sub">보기</a>
										구성쪽수:<c:out value='${resultcrf.upageCnt }'/>  시작번호:<c:out value='${resultcrf.spageCnt }'/>
									</c:when>
								</c:choose>								
							</td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>	
							<td colspan="3">			                        	
	                            <c:set var="chkNo" value="${resultcrf.mapKey }"/>
								<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
									<div>
										<c:choose>
											<c:when test="${resutlMt.orgFileName != null }">
			                            		<span><c:out value="${resutlMt.orgFileName }"/></span>			                            		
	                            			</c:when>	                            				                         
	                            		</c:choose>
	                            	</div>													
								</c:forEach>
							</td>
						</tr>	
						<%-- <tr>					
							<th scope="row">관리</th>		
							<td><a href="#" onclick="fn_crfpop('u','<c:out value="${resultcrf.corpCd }"/>','<c:out value="${resultcrf.rsNo }"/>','<c:out value="${resultcrf.svSeq }"/>''); return false;" class="btn_sub btnModicrf btnLockNonDisp" >수정</a>
							</td>
						</tr> --%>
								</tbody>
									</table>
						</li>
					</c:forEach>
					</ul>					
					<c:if test="${eCrfList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="3">CRF설정 정보가 없습니다.</td>
						</tr>
					</c:if>
				<div class="survey_info sv_div_0">
				<div class="tbl_top_info" id="inputCrf">			
					<h4>CRF설정 정보 입력</h4>
					<!-- 버튼 -->					
				</div>
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">작성차수</th>
							<td>
								<form:select path="svSeq" id="svSeq" class="p10">
									<form:option value="">선택</form:option>
									<c:forEach begin="1" end="20" var="seq">
										<form:option value="${seq }"><c:out value="${seq }"/></form:option>
									</c:forEach>
								</form:select>
								차
								&nbsp;&nbsp;												
							</td>
						</tr>					
						<tr>
							<th scope="row">템플릿 선택</th>
							<td>
								<form:select path="tempType" class="p20" id="tempType_0" onchange="fn_temp('0'); return false;">
									<form:option value="">템플릿구분</form:option>
									<c:forEach items="${typeList}" var="type">
										<form:option value="${type.cd }"><c:out value="${type.cdName }"/></form:option>
									</c:forEach>
								</form:select>
								<form:select path="tempNo" id="tempNo_0" class="p40">
									<form:option value="">템플릿명</form:option>
									<c:forEach items="${tempList }" var="temp">
										<form:option value="${temp.tempNo }"><c:out value="${temp.tempNm }"/></form:option>
									</c:forEach>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">명칭</th>
							<td>
								<form:input path="title" id="title_0" class="type02 ta_l" />
							</td>
						</tr>										
						<!-- 첨부파일 업로드 -->
						<tr>
	                        <th scope="row">첨부파일</th>
	                        <td colspan="3" id="file_td">
	                            <div class="attach_sec type02 mb02" id="attachRpt0_div">
	                            	<input type="file" id="attachRpt0" name="attachRpt0" onchange="fn_file_add('attachRpt0'); return false;"/>
					                <label for="attachRpt0" id="attachRpt0_label" class="btn_sub">CRF파일업로드</label>
	                            </div>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th scope="row">구성쪽수</th>                        
	                        <td>
								<%-- <form:input path="upageCnt" id="upageCnt_0" class="type02 p10"/><span style="color: red;" >*CRF파일을 첨부한 경우 반드시 구성쪽수(페이지수)를 입력해주세요.</span> --%>
								<span><p style="color:red;"><i>*CRF파일 첨부시 구성쪽수(페이지수)는 자동 설정됩니다. 첨부파일의 구성쪽수가 많은 경우 저장시간이 지연될 수 있습니다. 잠시만 기다려주세요.</i></p></span>
								<span><p style="color:red;"><i>*설문(연구자대상자특성,사용성,효능설문)템플릿의 구성쪽수(페이지수)는 템플릿선택시 자동 적용됩니다.</i></p></span>
								<span><p style="color:red;"><i>*설문(연구자대상자특성,사용성,효능설문)템플릿은 설문템플릿관리에서 등록하시면 됩니다.</i></p></span>
							</td>
	                    </tr>					                    
					</tbody>					
				</table>
				<p>*시험물질을 추가 등록(삭제)한 경우 피부자극평가 CRF를 삭제한 후 재 생성해주세요.</p>
				</div>				
				<div class="btn_area">
					<a href="#" class="type02" onclick="fn_list(); return false;">목록</a>
					<a href="#" onclick="fn_addCrf(); return false;" class="btnLockNonDisp">저장</a>
					<a href="#" onclick="fn_regVend(); return false;" class="btn_sub btnLockNonDisp" id="btn_regVend">CRF단계등록</a>
					<a href="#" class="type02" onclick="fn_viewCrf(); return false;">CRF(보기)</a>
					<a href="#" class="type02" onclick="fn_openTempTitle(); return false;">피부자극평가CRF생성</a>
				</div>
			</div>
			<!-- //contents -->
			<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>사용CRF명칭 설정</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 사용체크정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:20%" />
					<col style="width:80%" />
				</colgroup>
				<tbody>			
					<tr>
						<th scope="row"><i>*</i>사용CRF명칭</th>
						<td>
							<div>
								<input type="text" class="step1 p50" id="step1" class="required" title="사용CRF명칭"/>
							</div>
						</td>
					</tr>
					<tr>	
						<th scope="row"><i>*</i>평가주기</th>
						<td>
							<div>
								<input type="radio" name="step2" id="step21" value="1" checked="checked"/>
							    <label for="step21">첩포제거 30분후</label>
							    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							    <input type="radio" name="step2" id="step22" value="2" />
							    <label for="step22">첩포제거 24시간후</label>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<p>*사용CRF명칭은 피부자극 평가 CRF 상단에 표시되는 명칭입니다.</p>
			<!-- 버튼 -->
            <div class="btn_area">
            	<a href="#" onclick="fn_addCrfSkinStim(); return false;" >저장</a>
            	<label for="modi-pop" class="type02 btn-cancel">취소</label>			
			</div>
		</div>
		</div>
		<!-- 팝업 -->
			<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
			<input type="hidden" name="cnt" id="cnt"/>
		</div>			
		<!-- //container -->
	</form:form>		
</div>	
<!-- //wrap -->
</body>
</html>