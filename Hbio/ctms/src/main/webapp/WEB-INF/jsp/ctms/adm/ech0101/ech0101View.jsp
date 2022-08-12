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
<script type="text/javascript">
//localStorage를 이용해서 확정자 피험자 참여자 카운트 가져오기

	$(function(){
	
		var ynAdmin = '<c:out value="${rs1000mVO.isAdminType}"/>';
		var ynDrt = '<c:out value="${rs1000mVO.isRsDrt}"/>';
		var ynStaff = '<c:out value="${rs1000mVO.isRsStaff}"/>';
		
		
		if(ynDrt=="N") {
			if(ynStaff=="Y") {
				$("#data_lock").hide();
				$("#data_lock").attr('disabled', 'true');
			}else{
				if(ynAdmin=="1") {
					$("#data_lock").hide();
					$("#data_lock").attr('disabled', 'true');
				}else{
					$("#btnDel").hide();
					$("#btnModi").hide();
					$("#data_lock").hide();
					$("#data_lock").attr('disabled', 'true');
					
					//참여지사 목록
					$("#btnRegBr").hide();
					$("#btnDelBr").hide();
					$(".btnModiBr").attr('onclick', '').unbind('click');			
					
					//참여연구담당자 목록
					$("#btnRegSt").hide();
					$("#btnDelSt").hide();
					$(".btnModiSt").attr('onclick', '').unbind('click');
					}
			}
		}
	
		//삭제불가능 "N" - 삭제 x
		var ynDel = '<c:out value="${rs1000mVO.isDelCntr}"/>';
		if(ynDel=="N") {
			$("#btnDel").hide();
		}
		
		//DATA LOCK = 'Y' 인 경우 수정,삭제 불가
		var ynLock = '<c:out value="${rs1000mVO.dataLockYn}"/>';		
		if(ynLock=='Y') {
			$("#btnDel").hide();
			$("#btnModi").hide();
			$("#data_lock").attr('checked', 'checked');
			$("#data_lock").attr('disabled', 'true');
			
			//참여지사 목록
			$("#btnRegBr").hide();
			$("#btnDelBr").hide();
			$(".btnModiBr").attr('onclick', '').unbind('click');			
			
			//참여연구담당자 목록
			$("#btnRegSt").hide();
			$("#btnDelSt").hide();
			$(".btnModiSt").attr('onclick', '').unbind('click');
			
		}
		
		// 대상부위를 설정한다
		var ynVal = '<c:out value="${rs1000mVO.rsPos}"/>';
		const arrRsPos = ynVal.split(",");
				
		for(var i=0; i<arrRsPos.length; i++){
			var setval = arrRsPos[i];
			$("#rsPos"+setval).attr('checked', 'checked');
		}
		
		var ynVal = '<c:out value="${rs1000mVO.irbsmYn}"/>';
		
		if(ynVal == 'Y'){
			$("#irbsmYn1").attr('checked', 'checked');
		}else{
			$("#irbsmYn2").attr('checked', 'checked');
		}
		
		//참여지사 관리를 위한 목록 선택
		$("#all-chk").change(function(){
			$("input[name=rsjSeq]").prop("checked", $(this).prop('checked'));
		});
		
		//참여연구담당자 관리를 위한 목록 선택
		$("#all-chk2").change(function(){
			$("input[name=rsjSeq2]").prop("checked", $(this).prop('checked'));
		});
		
		//시험물질 정보 관리를 위한 목록 선택
		$("#all-mtl").change(function(){
			$("input[name=mtlDsp]").prop("checked", $(this).prop('checked'));
		});
	
		$("#data_lock").change(function(){
					
			if($("input[name=data_lock]:checked").length == 0) {				
				//data_lock 해지 DATA_LOCK = 'N'
				//해지 기능은 없음 
				fn_setDataLock('N');
				alert('change un-lock');
			} else {
				//data_lock 설정 DATA_LOCK = 'Y'
				fn_setDataLock('Y');
			}
				
		});
		
		//IRB심의정보 설정
		var ynVal = '<c:out value="${rs5000mVO.rvCls}"/>';
		switch (ynVal) {
			case '1':
				$("#rvCls1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rvCls2").attr('checked', 'checked');
		    	break;
		  	default:
		     	console.log('Sorry, we are out of service');
		}
		
		var ynVal = '<c:out value="${rs5000mVO.rvSt}"/>';
		switch (ynVal) {
			case '1':
				$("#rvSt1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rvSt2").attr('checked', 'checked');
		    	break;				
		  	default:
		     	console.log('Sorry, we are out of service');
		}
		
		var ynVal = '<c:out value="${rs5000mVO.rvRs}"/>';
		switch (ynVal) {
			case '1':
				$("#rvRs1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rvRs2").attr('checked', 'checked');
		    	break;				
		  	default:
		     	console.log('Sorry, we are out of service');
		}
		
		var ynVal = '<c:out value="${rs5000mVO.rvNo}"/>';
		if(ynVal == '') {
			$("#dspirb").hide();
		}
		
	});

	// data_lock 설정  Y, N 
	function fn_setDataLock(lock){
		if(lock == 'Y') {
			if(confirm('DATA LOCK을 설정합니다. LOCK설정된 후 복구가 되지 않습니다. \r\n저장하시겠습니까?')){
				var corpCd = $("#corpCd").val();
				var rsNo = $("#rsNo").val();	
				
				$.ajax({
					url: "<c:url value='/qxsepmny/ech0101/ech0101AjaxDataLock.do'/>"
					, type: "post"
					, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"lock="+lock
					, dataType:"json"
					, success: function(data){
						var status = data.status;
						var message = data.message;
						alert(message);
					}, error: function(){
						alert("오류가 발생하였습니다.");
					}
				});
			} else {
				
				//취소를 한 경우 LOCK 버튼을 해지해야 함.
				$("input[name=data_lock]").attr( 'checked', false );				
			}	
			
		} else {

		
		
		}
	}
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100501.do'/>"
					, '관리자 조회', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	function fn_list(){
		//location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101List.do'/>";
		//검색조건유지 설정 호출 
		
		$("#frm2").attr("action","<c:url value='/qxsepmny/ech0101/ech0101List.do'/>").submit();
	}	
	
	function fn_modify(){
	 	$("#frm").attr("action","<c:url value='/qxsepmny/ech0101/ech0101Modify.do'/>").submit();
	}
	
	function fn_delete(){
		if(confirm('해당 연구를 삭제하시겠습니까?')){
			$("#frm").attr("action","<c:url value='/qxsepmny/ech0101/ech0101Delete.do'/>").submit();
		}
	}
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}
	
	
	function fn_open(){
		
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('참여지사를 선택해 주세요.');
			return;
		}
				
		$("#modi-pop").prop("checked", "true");
		
	}
	
	function fn_step(){
		if(confirm('등록하신 참여지사정보를 등록합니다. \r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();			
			var step1 = $("#datepicker01").val();
			var step2 = $("#datepicker02").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205AjaxSaveStep.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					$("#modi-pop").click();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	
	//참여지사관리 추가/수정 
	function fn_brpop(mode, corpCd, rsNo, rsCd, branchCd){
	/* 	var popupWidth = 400;
		var popupHeight = 500;
		var popupX = (window.screen.width/2)-(popupWidth/2);
		var popupY = (window.screen.height/2)-(popupHeight/2); */
		var _left = Math.ceil(( window.screen.width - 500 )/2);
	    var _top = Math.ceil(( window.screen.height - 500 )/2); 
		//, '참여지사관리, width='+ popupWidth + ', height=' + popupHeight +', left='+ popupX + ', top='+ popupY + ', menubar=no, status=no, toolbar=no, scrollbars=1');
		//alert('참여지사관리, width='+ popupWidth + ', height=' + popupHeight +', left='+ popupX + ', top='+ popupY + ', menubar=no, status=no, toolbar=no, scrollbars=1');
		//, '참여지사관리, width='+ popupWidth + ', height=' + popupHeight +', left='+ popupX + ', top='+ popupY + ', menubar=no, status=no, toolbar=no, scrollbars=1');
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101BrmgPop.do'/>?mode="+mode+"&corpCd="+corpCd+"&rsNo="+rsNo+"&rsCd="+rsCd+"&branchCd="+branchCd
				, '참여지사관리', 'width=500, height=500,left='+ _left+',top='+_top+', menubar=no, status=no, toolbar=no, scrollbars=1');
	}	
	
	// 참여지사 삭제
	function fn_del(){
		
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('삭제할 참여지사를 선택해 주세요.');
			return;
		}
		if(confirm('선택하신 지사의 참여정보를 삭제합니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var rsCd = '<c:out value="${rs1000mVO.rsCd }" />';
			var subrsCd =rsCd.substring(0,14);
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101AjaxSaveDel.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+"rsCd="+subrsCd+"&"+$("input[name=rsjSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
			    	localStorage.setItem("brmg","brmg");
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
			
	
	}

	//참여연구담당자 추가/수정 
	function fn_stpop(mode, corpCd, rsNo, rsCd, empNo){
		
		var _left = Math.ceil(( window.screen.width - 500 )/2);
	    var _top = Math.ceil(( window.screen.height - 500 )/2); 

		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101StmgPop.do'/>?mode="+mode+"&corpCd="+corpCd+"&rsNo="+rsNo+"&rsCd="+rsCd+"&empNo="+empNo
				, '참여연구담당자관리', 'width=500, height=500, left='+ _left+',top='+_top+', menubar=no, status=no, toolbar=no, scrollbars=1');
	}	
	
	// 참여연구담당자 삭제
	function fn_delst(){
		if($("input[name=rsjSeq2]:checked").length == 0){
			alert('삭제할 참여연구담당자를 선택해 주세요.');
			return;
		}
		if(confirm('선택하신 연구담당자의 참여정보를 삭제합니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var step1 = "Y";
			var step2 = "N";
			var rsCd = '<c:out value="${rs1000mVO.rsCd }" />';
			var subrsCd =rsCd.substring(0,14);
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101AjaxSaveDelStaff.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+"rsCd="+subrsCd+"&"+$("input[name=rsjSeq2]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
			    	localStorage.setItem("stmg","stmg");
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
			
	}	
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}

	//시험물질 정보 추가/수정 
	function fn_mtlpop(mode, corpCd, rsNo, rsCd, mtlNo){
		
		var _left = Math.ceil(( window.screen.width - 500 )/2);
	    var _top = Math.ceil(( window.screen.height - 500 )/2); 

		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101MtlmgPop.do'/>?mode="+mode+"&corpCd="+corpCd+"&rsNo="+rsNo+"&rsCd="+rsCd+"&mtlNo="+mtlNo
				, '시험물질정보관리', 'width=500, height=500, left='+ _left+',top='+_top+', menubar=no, status=no, toolbar=no, scrollbars=1');
	}	
	
	//시험물질 정보 삭제
	function fn_delMtl(){
		
		
		if($("input[name=mtlDsp]:checked").length == 0){
			alert('삭제할 시험물질 정보를 선택해 주세요.');
			return;
		}
		if(confirm('선택하신 시험물질 정보를 삭제합니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var rsCd = '<c:out value="${rs1000mVO.rsCd }" />';
			var subrsCd = rsCd.substring(0,14);
			 
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101AjaxSaveDelMtl.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"rsCd="+subrsCd+"&"+$("input[name=mtlDsp]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
			    	localStorage.setItem("mtl","mtl");
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	
	}

   /*
   	로컬스토리지 값 받아와서 0.5초 후 해당 포커스로 이동
   	새로고침 후에 바로 포커스 이동은 안됨 새로고침이되고나서 페이지 로드 후 실행되야하기때문.
   	
   */

   var mtl = localStorage.getItem("mtl");	
   var brmg = localStorage.getItem("brmg");	
   var stmg = localStorage.getItem("stmg");	

	setTimeout(function() {
		
       if(mtl != null){   
    	   
    	  	document.getElementById('mtl').scrollIntoView();
			localStorage.removeItem(mtl);
       }
       if(brmg != null){
    	   
    	   	document.getElementById('brmg').scrollIntoView();
		   	localStorage.removeItem(brmg);   
       }
       if(stmg != null){
    	   
    	   	document.getElementById('stmg').scrollIntoView();
			localStorage.removeItem(stmg);
       }
       
	}, 500);

		
     
      
	

</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>연구관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="연구관리"/>
	            <jsp:param name="dept2" value="연구관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>연구정보</h4>
            </div>
            <!-- //서브타이틀 -->
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
            </form:form>
            <!-- //검색조건유지 설정 -->
            <form:form commandName="rs1000mVO" id="frm" name="frm">
            	<form:hidden path="corpCd"/>
            	<form:hidden path="rsNo"/>
            	<form:hidden path="isAdminType"/>
            	<form:hidden path="isRsDrt"/>
            	<form:hidden path="isRsStaff"/>
            	<form:hidden path="isDelCntr"/>
            </form:form>
            <!-- 연구정보 -->
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
                        <td colspan="3">
                       		<c:choose>
                          		<c:when test="${rs1000mVO.dataLockYn eq 'Y' }"><c:out value="${rs1000mVO.rsCd }" /><span style="color:red;">(Data Locked)</span></c:when>
                          		<c:when test="${rs1000mVO.dataLockYn eq 'N' }"><c:out value="${rs1000mVO.rsCd }" /></c:when>
                          	</c:choose>
                       </td>
                    </tr>
                    <tr>
                        <th scope="row">임상종류</th>
                        <td><c:out value="${rs1000mVO.rsNo2Nm }"/></td>
                        <th scope="row" class="bl">임상분류</th>
                        <td><c:out value="${rs1000mVO.rsNo3Nm }"/></td>
                    </tr>
                    <tr>
                    	<th scope="row" class="bl">등록일(최초)</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <span><c:out value="${rs1000mVO.regDt }"/></span>
                            </div>
                        </td>
                    </tr>    
                    <tr>
                        <th scope="row">연구책임자</th>
                        <td><c:out value="${rs1000mVO.rsDrtNm }"/></td>
                        <th scope="row">피험자수</th>
                        <td colspan="3">
                            <c:out value="${rs1000mVO.rsScnt }"/> 명&nbsp;&nbsp;&nbsp;
                            최대지원자수&nbsp;&nbsp;
                            <c:out value="${rs1000mVO.rsMscnt }"/> 명
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연구상태</th>
                        <td colspan="3">
                          	<c:choose>
                          		<c:when test="${rs1000mVO.rsstCls eq '10' }">예정</c:when>
                          		<c:when test="${rs1000mVO.rsstCls eq '20' }">진행</c:when>
                          		<c:when test="${rs1000mVO.rsstCls eq '30' }">완료</c:when>
                          		<c:when test="${rs1000mVO.rsstCls eq '40' }">취소</c:when>
                          	</c:choose>
                        </td>                        
                    </tr>
                    <tr>
                        <th scope="row">방문횟수</th>
                        <td>
                            <c:out value="${rs1000mVO.visitCnt }"/>회
                        </td>
                        <th scope="row" class="bl">중복참여여부</th>
                        <td>
                        	<c:choose>
                        		<c:when test="${rs1000mVO.duplYn eq 'Y' }">
                        			중복참여 가능
                        		</c:when>
                        		<c:when test="${rs1000mVO.duplYn eq 'N' }">
                        			중복참여 불가
                        		</c:when>
                        	</c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">모집성별</th>
                        <td>
                            <c:choose>
                        		<c:when test="${rs1000mVO.genYn eq 1 }">남</c:when>
                        		<c:when test="${rs1000mVO.genYn eq 2 }">여</c:when>
                        		<c:when test="${rs1000mVO.genYn eq 0 }">제한없음</c:when>
                        	</c:choose>
                        </td>
                        <th scope="row" class="bl">나이제한</th>
                        <td>
                        	<c:out value="${rs1000mVO.ageSt }"/>세 ~
                        	<c:out value="${rs1000mVO.ageEn }"/>세 이하
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">대상부위</th>
                        <td>                            
                            <input type="checkbox" name="rsPos" id="rsPos1" />
                            <label for="rsPos1">이마</label>
                            <input type="checkbox" name="rsPos" id="rsPos2" />
                            <label for="rsPos2">눈</label>
                            <input type="checkbox" name="rsPos" id="rsPos3" />
                            <label for="rsPos3">코</label>
                            <input type="checkbox" name="rsPos" id="rsPos4" />
                            <label for="rsPos4">입</label>
                            <input type="checkbox" name="rsPos" id="rsPos5" />
                            <label for="rsPos5">얼굴전체</label>
                            <input type="checkbox" name="rsPos" id="rsPos6" />
                            <label for="rsPos6">등</label>
                            <input type="checkbox" name="rsPos" id="rsPos7" />
                            <label for="rsPos7">피부전체</label>
                        </td>
                        <th scope="row" class="bl">신뢰성보증업무담당자</th>
                        <td>
                        	<c:out value="${rs1000mVO.rsGrtNm }"/>
                        </td>	
                    </tr>
                    <tr>
                        <th scope="row">연구명</th>
                        <td colspan="3">                            
                            <c:out value="${rs1000mVO.rsName }"/>
                        </td>
                    </tr>
                     <tr>
                        <th scope="row">연구목적</th>
                        <td colspan="3" >
                        <textarea><c:out value="${rs1000mVO.rsPps }"/></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연구방법</th>
                        <td colspan="3" >
                        <textarea><c:out value="${rs1000mVO.rsPtc }"/></textarea>
                        </td>
                    </tr>
                    <tr>  
                        <th scope="row">IRB승인</th>
                        <td colspan="3">
                            <input type="radio" name="irbsmYn" id="irbsmYn1"/>
                            <label for="irbsmYn1">필요</label>
                            <input type="radio" name="irbsmYn" id="irbsmYn2"/>
                            <label for="irbsmYn2">불필요</label>
                        </td>
                    </tr>
                    <!-- IRB정보 -->
                    <tr>
                        <th scope="row">IRB심의번호</th>
                        <td colspan="3">
                        	<div class="check_btn" id="dspirb">
	                        	<c:out value="${rs5000mVO.rvNo1 }"/>
	                            -
	                            <c:out value="${rs5000mVO.rvNo2 }"/>
	                            -
	                            <c:out value="${rs5000mVO.rvNo3 }"/>                             
	                            -
	                            <c:out value="${rs5000mVO.rvNo4 }"/>
	                            -
	                            <c:out value="${rs5000mVO.rvNo5 }"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">심의종류</th>
                        <td>
							<input type="radio" name="rvCls" id="rvCls1" value="1" />
							<label for="rvCls1">신속</label>
							<input type="radio" name="rvCls" id="rvCls2" value="2" />
							<label for="rvCls2">정규</label>
                        </td>
                        <th scope="row" class="bl">심의접수일</th>
                        <td>
							<div class="date_sec">
								<span>
									<input name="rvDt" id="datepicker07" placeholder="0000-00-00" value="<c:out value="${rs5000mVO.rvDt }" />" class="date required" title="접수일자" />
									<label for="datepicker07" class="btn_cld">날짜검색</label>
								</span>
							</div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">심의상태</th>
                        <td>
							<input type="radio" name="rvSt" id="rvSt1" value="1"/>
							<label for="rvSt1">심의중</label>
							<input type="radio" name="rvSt" id="rvSt2" value="2"/>
							<label for="rvSt2">완료</label>
                        </td>
                        <th scope="row" class="bl">심의결과</th>
                        <td>
                            <input type="radio" name="rvRs" id="rvRs1" value="1"/>
							<label for="rvRs1">승인</label>
							<input type="radio" name="rvRs" id="rvRs2" value="2"/>
							<label for="rvRs2">보완</label>
                        </td>
                    </tr>
                    <!-- //IRB정보 -->
                </tbody>
            </table>
            <!-- //연구정보 -->
            <div class="sub_title_area">
                <h4>임상시험일정(점검/보고)</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 임상시험일정 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">연구계획서</th>
                        <td>
                            <c:out value="${rs1000mVO.rsplDt }"/>
                        </td>
                        <th scope="row" class="bl">시험제품정보확인</th>
                        <td>
                            <c:out value="${rs1000mVO.rsitDt }"/>
                        </td>                        
                    </tr>
                    <tr>    
                        <th scope="row"  class="bl">IRB승인</th>
                        <td colspan="3">
                        	<c:out value="${rs1000mVO.rsirbDt }"/> 
                        </td>
                    </tr>
                    <tr>    
                        <th scope="row" class="bl">연구대상자 모집</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <c:out value="${rs1000mVO.rsrStdt }"/>
                                <em>~</em>
                                <c:out value="${rs1000mVO.rsrEndt }"/>
                            </div>
                        </td>
                    </tr>
                    <tr>    
                        <th scope="row" class="bl">연구기간</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <c:out value="${rs1000mVO.rsStdt }"/>
                                <em>~</em>
                                <c:out value="${rs1000mVO.rsEndt }"/>
                            </div>
                        </td>
                    </tr>
                    <tr>    
                        <th scope="row">초안보고서</th>
                        <td>
                        	<c:out value="${rs1000mVO.rep2Dt }"/> 
                        </td>
                        <th scope="row" class="bl">최종보고서</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <span><c:out value="${rs1000mVO.repDt }"/></span>
                            </div>
                        </td>
                    </tr>
                    <tr>  
                        <th scope="row" class="bl">전체연구일자</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <c:out value="${rs1000mVO.rsTstdt }"/>
                                <em>~</em>
                                <c:out value="${rs1000mVO.rsTendt }"/>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //의뢰기관 -->
            
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>의뢰기관</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 의뢰기관 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">고객사명</th>
                        <td>
                            <c:out value="${rs1000mVO.vendName }"/>
                        </td>
                        <th scope="row" class="bl">담당자</th>
                        <td>
                            <c:out value="${rs1000mVO.vmngName }"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연락처</th>
                        <td>
                            <c:out value="${rs1000mVO.vmnghpNo }"/>
                        </td>
                        <th scope="row" class="bl">이메일</th>
                        <td>
                            <c:out value="${rs1000mVO.vmngEmail }"/>
                        </td>
                    </tr>
                    <!-- 고객요청으로 연구비항목 삭제 - 2021.3.22 -->
                    <%-- <tr>
                        <th scope="row">연구비</th>
                        <td>                            
                            <fmt:formatNumber pattern="#,###"><c:out value="${rs1000mVO.rsPay }" /></fmt:formatNumber>
                        </td>
                        <th scope="row" class="bl">부가세</th>
                        <td>
                        	<fmt:formatNumber pattern="#,###"><c:out value="${rs1000mVO.rsPayvt }" /></fmt:formatNumber>
                        </td>
                    </tr> --%>                    
                    <tr>    
                        <th scope="row"  class="bl">제품정보</th>
                        <td colspan="3">
                        	<c:out value="${rs1000mVO.itemClsNm }"/>        
                        	&nbsp;&nbsp;&nbsp;제품명&nbsp;                   
                            <c:out value="${rs1000mVO.itemName }"/> 
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //의뢰기관 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>첨부파일</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 첨부파일 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                	<tr id="rsImage_tr">
                        <th scope="row">연구이미지</th>
                        <td colspan="3">      
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file01" name="rsImage" />	
                                 <c:choose>
                            		<c:when test="${attachMap.rsImage==null}">
		                            	<script type="text/javascript">
		                            			 $('#rsImage_tr').remove();
		                            	</script>	
                            		</c:when>
                            	</c:choose>
                            	<div>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.rsImage.attachNo }'/>', '<c:out value='${attachMap.rsImage.boardType }'/>'); return false;">
                            				<c:out value="${attachMap.rsImage.orgFileName }"/>
                            			</a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="rsPlan_tr">
                        <th scope="row">연구계획서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file02" name="rsPlan">
                            	<c:choose>
                            		<c:when test="${attachMap.rsPlan == null }">
		                            	<script type="text/javascript">
		                            			 $('#rsPlan_tr').remove();
		                            	</script>	
                            		</c:when>
                            	</c:choose>
                            	<div>
                            		<span>
	                            		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.rsPlan.attachNo }'/>', '<c:out value='${attachMap.rsPlan.boardType }'/>'); return false;">
	                            		<c:out value="${attachMap.rsPlan.orgFileName }"/></a>
                            		</span>
                            	</div>
							</div>
                        </td>
                    </tr>
                    <tr id="draftRpt_tr">
                        <th scope="row">초안보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file03" name="draftRpt"/>   	
                            	<c:choose>
                            		<c:when test="${attachMap.draftRpt == null }">
		                            	<script type="text/javascript">
		                            		 $('#draftRpt_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>                 
                            		<span>
	                    	       		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.draftRpt.attachNo }'/>', '<c:out value='${attachMap.draftRpt.boardType }'/>'); return false;">
		                           			<c:out value="${attachMap.draftRpt.orgFileName  }"/></a>
	                           		</span>             		
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="finalRpt_tr">
                        <th scope="row">최종보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">           
                            	<input type="file" id="in_file04" name="finalRpt" />
                            	
                            	<c:choose>
                            		<c:when test="${attachMap.finalRpt == null }">
		                            	<script type="text/javascript">
		                            			 $('#finalRpt_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	
                            	<div>	
                            		<span>
	                            		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.finalRpt.attachNo }'/>', '<c:out value='${attachMap.finalRpt.boardType }'/>'); return false;">
	                           				<c:out value="${attachMap.finalRpt.orgFileName }"/>
		                          		</a>
                            		</span>
                            	</div>
                         </div>
                        </td>
                    </tr>
                    <tr id="summary_tr">
                        <th scope="row">최종요약문</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file05" name="summary" />
                            	
								<c:choose>
                            		<c:when test="${attachMap.summary == null }">
		                            	<script type="text/javascript">
		                            			 $('#summary_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            		<span id="image5"></span>
                            		<span>
		                           		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.summary.attachNo }'/>', '<c:out value='${attachMap.summary.boardType }'/>'); return false;">
	                           				<c:out value="${attachMap.summary.orgFileName}"/></a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="korRpt_tr">
                        <th scope="row">국문보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file06" name="korRpt" />
							<c:choose>
                            		<c:when test="${attachMap.korRpt == null }">
		                            	<script type="text/javascript">
		                            			 $('#korRpt_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            
                            	<div>
                            		
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.korRpt.attachNo }'/>', '<c:out value='${attachMap.korRpt.boardType }'/>'); return false;">
	                           				<c:out value="${attachMap.korRpt.orgFileName }"/></a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="engRpt_tr">
                        <th scope="row">영문보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file07" name="engRpt"/>
                           		<c:choose>
                            		<c:when test="${attachMap.engRpt == null }">
		                            	<script type="text/javascript">
		                            			 $('#engRpt_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            		<span id="image7"></span>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.engRpt.attachNo }'/>', '<c:out value='${attachMap.engRpt.boardType }'/>'); return false;">
		                           			<c:out value="${attachMap.engRpt.orgFileName }"/></a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="gita1_tr">
                        <th scope="row">기타1</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file08" name="gita1" />
                           		<c:choose>
                            		<c:when test="${attachMap.gita1 == null }">
		                            	<script type="text/javascript">
		                            			 $('#gita1_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            	<span id="image8"></span>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.gita1.attachNo }'/>', '<c:out value='${attachMap.gita1.boardType }'/>'); return false;">
		                           			<c:out value="${attachMap.gita1.orgFileName }"/>
	                          			</a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="gita2_tr">
                        <th scope="row">기타2</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file09" name="gita2" />
                           	
                            	<c:choose>
                            		<c:when test="${attachMap.gita2 == null }">
		                            	<script type="text/javascript">
		                            			 $('#gita2_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            	<span id="image9"></span>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.gita2.attachNo }'/>', '<c:out value='${attachMap.gita2.boardType }'/>'); return false;">
		                           			<c:out value="${attachMap.gita2.orgFileName }"/>
	                          			</a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //첨부파일 -->
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list();" class="type02">목록</a>
				<a href="#" onclick="fn_delete(); return false;" id="btnDel">삭제</a>
				<a href="#" onclick="fn_modify(); return false;" id="btnModi">수정</a>
				<!-- 토글버튼 -->
				<div>
					데이터 잠금
		       		<div class="toggle_btn">
						<label class="switch">
							<input type="checkbox" id="data_lock" name="data_lock" />
							<span class="slider round"></span>
						</label>
						<p>Lock</p>
					</div>
				</div>				
				<!-- //토글버튼 -->
			</div>
			<!-- //버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">			
				<h4>시험물질 정보</h4>
				<!-- 버튼 -->
				<div id ="mtl">
					<a href="#mtl" class="btn_sub type02" onclick="fn_mtlpop('i','<c:out value="${rs1000mVO.corpCd }"/>','<c:out value="${rs1000mVO.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>',''); return false;" id="btnRegMtl">등록</a>
					<a href="#" class="btn_sub" onclick="fn_delMtl(); return false;" id="btnDelMtl">삭제</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- //시험물질 정보 -->
			<table class="tbl_list" id="br">
				<colgroup>
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:8%" />
					<col style="width:Auto" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:8%" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all-mtl"/></th>
						<th scope="col">번호</th>
						<th scope="col">물질번호</th>
						<th scope="col">음성대조군</th>
						<th scope="col">명칭</th>
						<th scope="col">Lot. No</th>
						<th scope="col">성상</th>
						<th scope="col">비고</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="resultmtl" items="${mtlList}" varStatus="status">
					<tr>					
						<td><input type="checkbox" name="mtlDsp" value="<c:out value='${resultmtl.mtlDsp }'/>"/></td>
						<td><c:out value="${resultmtl.rownum }"/></td>
						<td><c:out value="${resultmtl.mtlDsp }"/></td>
						<td><c:out value="${resultmtl.ncYn }"/></td>
						<td><c:out value="${resultmtl.mtlName }"/></td>
						<td><c:out value="${resultmtl.lotNo }"/></td>
						<td><c:out value="${resultmtl.mtlShp}"/></td>
						<td><c:out value="${resultmtl.remk}"/></td>
						<td><a href="#" onclick="fn_mtlpop('u','<c:out value="${resultmtl.corpCd }"/>','<c:out value="${resultmtl.rsNo }"/>','<c:out value="${resultmtl.rsCd }"/>','<c:out value="${resultmtl.mtlNo }"/>'); return false;" class="btn_sub btnModiMtl" >수정</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${mtlList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="9">시험물질 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
            <!-- 참여지사 -->
            <!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">			
				<h4>참여지사 정보</h4>
				<!-- 버튼 -->
				<div id="brmg">
					<a class="btn_sub type02" onclick="fn_brpop('i','<c:out value="${rs1000mVO.corpCd }"/>','<c:out value="${rs1000mVO.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>',''); return false;" id="btnRegBr">등록</a>
					<a class="btn_sub" onclick="fn_del(); return false;" id="btnDelBr">삭제</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- //참여지사 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:Auto" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:8%" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all-chk"/></th>
						<th scope="col">번호</th>
						<th scope="col">지사코드</th>
						<th scope="col">지사명</th>
						<th scope="col">참여상태</th>
						<th scope="col">참여시작일자</th>
						<th scope="col">참여종료일자</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${joinBranchList}" varStatus="status">
					<tr>					
						<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.branchCd }'/>"/></td>
						<td><c:out value="${result.rownum }"/></td>
						<td><c:out value="${result.branchCd }"/></td>
						<td><c:out value="${result.branchName }"/></td>
						<td><c:out value="${result.rsstClsNm }"/></td>
						<td><c:out value="${result.jnStdt}"/></td>
						<td><c:out value="${result.jnEndt}"/></td>
						<td><a href="#" onclick="fn_brpop('u','<c:out value="${result.corpCd }"/>','<c:out value="${result.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>','<c:out value="${result.branchCd }"/>'); return false;" class="btn_sub btnModiBr" >수정</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${joinBranchList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="8">참여지사 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
            <!-- //참여지사 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>참여연구자정보</h4>
				<!-- 버튼 -->
				<div id="stmg">
					<a class="btn_sub type02" onclick="fn_stpop('i','<c:out value="${rs1000mVO.corpCd }"/>','<c:out value="${rs1000mVO.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>',''); return false;" id="btnRegSt">등록</a>
					<a class="btn_sub" onclick="fn_delst(); return false;" id="btnDelSt">삭제</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- //참여연구담당자 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:Auto" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:8%" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all-chk2"/></th>
						<th scope="col">번호</th>
						<th scope="col">연구자번호</th>
						<th scope="col">연구자명</th>
						<th scope="col">참여상태</th>
						<th scope="col">참여시작일자</th>
						<th scope="col">참여종료일자</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result2" items="${joinEmpList}" varStatus="status">
					<tr>					
						<td><input type="checkbox" name="rsjSeq2" value="<c:out value='${result2.empNo }'/>"/></td>
						<td><c:out value="${result2.rownum }"/></td>
						<td><c:out value="${result2.empNo }"/></td>
						<td><c:out value="${result2.empName }"/></td>
						<td><c:out value="${result2.rsstClsNm }"/></td>
						<td><c:out value="${result2.jnStdt}"/></td>
						<td><c:out value="${result2.jnEndt}"/></td>
						<td><a href="#" onclick="fn_stpop('u','<c:out value="${result2.corpCd }"/>','<c:out value="${result2.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>','<c:out value="${result2.empNo }"/>'); return false;" class="btn_sub btnModiSt">수정</a>
					</tr>
				</c:forEach>
				<c:if test="${joinEmpList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="8">참여연구담당자 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
            <!-- //참여연구담당자 --> 
			
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
