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

//보이기
//function div_show() {
// document.getElementById("test_div").style.display = "block";
//}

//숨기기
//function div_hide() {
// document.getElementById("test_div").style.display = "none";
//}

//<a href="#" class="btn_sub" id="btnRsvSms">예약SMS 발송</a>
//<a href="#" onclick="fn_pop_sms(); return false;" class="btn_sub" id="btnSms">SMS 발송</a>
//<a href="#" onclick="fn_pop_email(); return false;" class="btn_sub" id="btnEmail">이메일 발송</a>
//<a href="#" class="btn_sub type02" onclick="fn_bat(1); return false;" id="btnFirst">1차선정</a>
//<a href="#" onclick="fn_pop_resv(); return false;" class="btn_sub" id="btnSrsv">스크리닝예약</a>
//<a href="#" class="btn_sub type02" onclick="fn_bat(2); return false;" id="btnCfm">피험자확정</a>
//<a href="#" class="btn_sub type02" onclick="fn_code(); return false;" id="btnRsi">식별번호부여</a>
//<a href="#" class="btn_excel">엑셀</a>

	$(function(){
		
				
		var ynVal = '<c:out value="${searchVO.setVal}"/>';
		
		if(status) { ynVal = "6"};
		
		
		// 탭구분에 따라 기능 버튼 표시 
		switch (ynVal){
	      case "1" : // 전체
	    	  $("#setVal1").attr('class', 'on');
	    	  $("#btnExcel").hide();
	          break;
	      case "2" : // 지원자
	    	  $("#setVal2").attr('class', 'on');
	    	  $("#btnRsi").hide(); 
	    	  $("#btnDel").hide();
	    	  $("#btnPool").hide();
	    	  $("#btnExcel").hide();
	          break;
	      case "3" : // 풀선별
	    	  $("#setVal3").attr('class', 'on');
	    	  $("#btnRsi").hide();
	    	  $("#btnExcel").hide();
	          break;
	      case "4" : // 1차선정 스크리닝
	    	  $("#setVal4").attr('class', 'on');
	    	  $("#btnFirst").hide();
	    	  $("#btnRsi").hide();
	    	  $("#btnDel").hide();
	    	  $("#btnPool").hide();
	          break;
	      case "5" : // 스크리닝방문 - 스크리닝예약만 있는 목록
	    	  $("#setVal5").attr('class', 'on');
	    	  $("#btnFirst").hide();
	    	  $("#btnRsi").hide();
	    	  $("#btnDel").hide();
	    	  $("#btnPool").hide();
	          break;
	      case "6" : // 피험자확정 
	    	  $("#setVal6").attr('class', 'on');
	    	  $("#btnFirst").hide();
	    	  $("#btnDel").hide();
	    	  $("#btnCfm").hide();
	    	  $("#btnPool").hide();
	          break;
	      default :
	          document.write("nothing");
	    }

 		//var ynAdmin = '<c:out value="${rs1010mVO.isAdminType}"/>';
		//var ynDrt = '<c:out value="${rs1010mVO.isRsDrt}"/>';
		//var ynStaff = '<c:out value="${rs1010mVO.isRsStaff}"/>';

		//if(ynDrt=="N") {
			//if(ynStaff=="N") {
				//if(ynAdmin=="2") {
						//$("#btnRsi").hide();
						//$("#btnFirst").hide();
				    	//$("#btnDel").hide();
				    	//$("#btnCfm").hide();
				    	//$("#btnPool").hide();
					//}
			//}
		//}
		
		//DATA LOCK = 'Y' 인 경우 수정,삭제 불가
		var ynLock = '<c:out value="${rs1010mVO.dataLockYn}"/>';		
		if(ynLock=='Y') {
			$(".btnLockNonDisp").hide();
			//$(".btnLockNonDisp").attr('onclick', '').unbind('click');
				
		}
				
		// 연구대상자 목록에서 선택
		$("#all-chk").change(function(){
			$("input[name=rsjSeq]").prop("checked", $(this).prop('checked'));
		});

	
	});

	function fn_view(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102View.do'/>").submit();
	}
	function fn_view2(setVal){
		$("#setVal").val(setVal);
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102View2.do'/>").submit();
	}
	
	
	
	function fn_pop_email(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100202.do'/>"
					, '이메일발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}

	function fn_pop_resv(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100301.do'/>"
					, '예약관리', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}

	//function fn_pop_sms(corpCd){
		//var corpCd = $("#corpCd").val();
		//var rsNo = $("#rsNo").val();
		//var rsjNo = $("input[name=rsjSeq]:checked").serialize();
		//window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102SmsPop.do'/>?corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+$("input[name=rsjSeq]:checked").serialize()
		//			, 'SMS발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	//}
	//예약SMS 발송 - 한명씩만 처리한다. 
	function fn_pop_smsmt(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해주세요.');
			return;
		}
		if($("input[name=rsjSeq]:checked").length > 1){
			alert('연구대상자는 1명만 선택해주세요.');
			return;
		}
		var corpCd = $("#corpCd").val();
		var rsNo = $("#rsNo").val();
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102SmsMtPop.do'/>?corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+$("input[name=rsjSeq]:checked").serialize()
					, 'SMS발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//일괄 SMS 발송
	function fn_pop_sms(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해주세요.');
			return;
		}
		var corpCd = $("#corpCd").val();
		var rsNo = $("#rsNo").val();
		var rsjNo = $("input[name=rsjSeq]:checked").serialize();
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102SmsAllPop.do'/>?corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+$("input[name=rsjSeq]:checked").serialize()
					, 'SMS발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//스크리닝 예약수정
	function fn_resrModiPop(corpCd, resrNo){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102ScrMtmgPop.do'/>?corpCd="+corpCd+"&resrNo="+resrNo
				, '스크리닝예약수정', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//일괄 스크리닝 예약관리 팝업
	function fn_scrmtmgallpop(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해주세요.');
			return;
		}
		var corpCd = $("#corpCd").val();
		var rsNo = $("#rsNo").val();
		var rsjNo = $("input[name=rsjSeq]:checked").serialize();
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102ScrMtmgAllPop.do'/>?corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+$("input[name=rsjSeq]:checked").serialize()
				, '스크리닝예약관리', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_pop(corpCd, rsNo, rsCd){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech1001/ech1001List.do'/>?corpCd="+corpCd+"&rsNo="+rsNo+"&rsCd="+rsCd
				, '피험자조회', 'width=1000, height=700, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	
	//건별 피험저관리  팝업
	function fn_Rsjmgpop(corpCd, rsNo, subNo, rsjNo){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102RsjmgPop.do'/>?corpCd="+corpCd+"&rsNo="+rsNo+"&subNo="+subNo+"&rsjNo="+rsjNo
				, '피험자관리', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102List.do'/>").submit();
	}
	
	//1: 1차선정  2: 피험자확정 
	function fn_bat(stat){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해 주세요.');
			return;
		}
		if(stat == "1"){
			if(confirm('선택하신 연구대상자를 스크리닝대상자로 확정하고 스크리닝번호가 부여됩니다.\r\n저장하시겠습니까?')){
				var corpCd = $("#corpCd").val();
				var rsNo = $("#rsNo").val();			
				//var step1 = $("#step1").val();
				var step1 = "Y";
				var step2 = "N";
				$.ajax({
					url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102AjaxSaveFirst.do'/>"
					, type: "post"
					, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
					, dataType:"json"
					, success: function(data){
						alert(data.message);
						window.location.reload();
					}, error: function(){
						alert("오류가 발생하였습니다.");
					}
				});
			}
		}else{
			if(confirm('선택하신 연구대상자들의 연구참여를 최종 확정합니다.\r\n저장하시겠습니까?')){
				var corpCd = $("#corpCd").val();
				var rsNo = $("#rsNo").val();			
				//var step1 = $("#step1").val();
				var step1 = "Y";
				var step2 = "N";
				$.ajax({
					url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102AjaxSaveCfm.do'/>"
					, type: "post"
					, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
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
		
	}
	
	
	// 연구대상자 삭제 
	
	function fn_del(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해 주세요.');
			return;
		}
		if(confirm('선택하신 연구대상자의 피험자 선정정보를 삭제합니다(풀선별 연구대상자만 가능하며 동의서첨부, 최종확정시 삭제불가). \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();			
			//var step1 = $("#step1").val();
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102AjaxSaveDel.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
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
	
	
	function fn_open(){
		
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해 주세요.');
			return;
		}
		$("#modi-pop").prop("checked", "true");
		
	}
	
	function fn_step(){
		if(confirm('선택하신 연구대상자들의 연구참여를 최종 확정합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();			
			//var step1 = $("#step1").val();
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102AjaxSaveCfm.do'/>"
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
	
	// 식별번호 일괄등록 
	function fn_code(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('식별번호가 부여되지 않은 연구대상자를 선택해 주세요.');
			return;
		}
		/* if(confirm('연구대상자의 식별번호를 일괄 등록합니다.\r\n등록하시겠습니까?')){	
			$("#detailForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102RsiCodeBat.do'/>").submit();
		} */
		
		if(confirm('연구대상자의 식별번호를 일괄 등록합니다. \r\n등록하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var rsCd = $("#rsCd").val();
			//var step1 = $("#step1").val();
			var step1 = "Y";
			var step2 = "Y";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102AjaxRsiCodeBat.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"rsCd="+rsCd+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
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
	
	//피험자선정 엑셀다운로드
	function fn_excelDown(setVal){

		$("#setVal").val(setVal);
		switch (setVal){
	      case "1" : // 전체
	  		  alert('엑셀기능이 없습니다.');
	          break;
	      case "2" : // 지원자
	    	  alert('엑셀기능이 없습니다.');
	          break;
	      case "3" : // 풀선별
	    	  alert('엑셀기능이 없습니다.');
	          break;
	      case "4" : // 1차선정 스크리닝
	    	  $("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102ExcelScrList.do'/>").submit();	  
	          break;
	      case "5" : // 스크리닝방문 - 스크리닝예약만 있는 목록
	    	  $("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102ExcelScrList.do'/>").submit();
	          break;
	      case "6" : // 피험자확정
	    	  if(confirm('피험자 확정명단을 다운로드합니다.민감한 개인정보가 포함되여 있습니다.\r\n다운로드하시겠습니까?')){	
	    		  $("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102ExcelCfmList.do'/>").submit();
	  		   }
	          break;
	      default :
	          document.write("nothing");
	    }
		
	}
	
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
	            <jsp:param name="dept2" value="피험자선정"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>연구관리</h4>
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
            <form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1010mVO.corpCd }"/>
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1010mVO.rsNo }"/>
			<input type="hidden" id="setVal" name="setVal"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
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
						<td>
							<c:choose>
                          		<c:when test="${rs1010mVO.dataLockYn eq 'Y' }"><c:out value="${rs1010mVO.rsCd }" /><span style="color:red;">(Data Locked)</span></c:when>
                          		<c:when test="${rs1010mVO.dataLockYn eq 'N' }"><c:out value="${rs1010mVO.rsCd }" /></c:when>
                          	</c:choose>
						</td>					
						<th scope="row" class="bl">연구명</th>
						<td><c:out value="${rs1010mVO.rsName }" /></td>
					</tr>
					<%-- <tr>
						<th scope="row">연구상태</th>
						<td><c:out value="${rs1010mVO.rsstClsNm }" /></td>
						<th scope="row" class="bl">연구기간</th>
						<td><c:out value="${rs1010mVO.rsStdt }" />~<c:out value="${rs1010mVO.rsEndt }" /></td>
					</tr>
					<tr>
						<th scope="row">고객사명</th>
						<td><c:out value="${rs1010mVO.vendName }" /></td>
						<th scope="row" class="bl">담당자</th>
						<td><c:out value="${rs1010mVO.vmngName }" />,<c:out value="${rs1010mVO.vmnghpNo }" />,<c:out value="${rs1010mVO.vmngEmail }" /></td>
					</tr> --%>
				</tbody>
			</table>
			<!-- //연구정보 -->
            <!-- 버튼 -->
            <div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">목록</a>
			</div>
            <!-- 탭버튼 -->
            <div class="tab_area tab06">
                <ul>
                	<li><a href="#" onclick="fn_view(1); return false;"  id="setVal1">전체</a></li>
                	<li><a href="#" onclick="fn_view2(2); return false;" id="setVal2">지원자</a></li>
                	<li><a href="#" onclick="fn_view2(3); return false;" id="setVal3">풀선별</a></li>
                	<li><a href="#" onclick="fn_view2(4); return false;" id="setVal4">스크리닝</a></li>
                	<li><a href="#" onclick="fn_view2(5); return false;" id="setVal5">스크리닝방문</a></li>
                	<li><a href="#" onclick="fn_view2(6); return false;" id="setVal6">피험자확정</a></li>
                </ul>
            </div>
            <!-- //탭버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<a href="#" onclick="fn_pop('<c:out value="${rs1010mVO.corpCd }" />', '<c:out value="${rs1010mVO.rsNo }" />', '<c:out value="${rs1010mVO.rsCd }" />'); return false;" class="btn_sub type02 btnLockNonDisp" id="btnPool">피험자 풀선별</a>
				<a href="#" class="btn_sub btnLockNonDisp" onclick="fn_del(); return false;" id="btnDel">삭제</a>
				<!-- 버튼 -->
				<div>
					<a href="#" onclick="fn_pop_smsmt(); return false;" class="btn_sub btnLockNonDisp" id="btnRsvSms">예약SMS 발송</a>
					<a href="#" onclick="fn_pop_sms('<c:out value="${rs1010mVO.corpCd }" />'); return false;" class="btn_sub" id="btnSms">SMS 발송</a>
					<!-- <a href="#" onclick="fn_pop_email(); return false;" class="btn_sub" id="btnEmail">이메일 발송</a>  -->
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_bat(1); return false;" id="btnFirst">스크리닝</a>
					<a href="#" onclick="fn_scrmtmgallpop(); return false;" class="btn_sub btnLockNonDisp" id="btnSrsv">스크리닝예약</a>
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_bat(2); return false;" id="btnCfm">피험자확정</a>
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_code(); return false;" id="btnRsi">식별번호부여</a>				
					<a href="#" class="btn_excel" onclick="fn_excelDown('<c:out value="${searchVO.setVal}"/>'); return false;" id="btnExcel">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:4%" />
					<col style="width:5%" />
					<col style="width:6%" />
					<col style="width:10%" />
					<col style="width:4%" />
					<col style="width:8%" />
					<col style="width:5%" />
					<col style="width:8%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:8%" />
					<col style="width:auto" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" id="all-chk"/></th>
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">거주지</th>
						<th scope="col">성별</th>
						<th scope="col">생년월일</th>
						<th scope="col">나이</th>
						<th scope="col">핸드폰</th>
						<th scope="col">지원</th>
						<th scope="col">풀선별</th>
						<th scope="col">스크리닝</th>
						<th scope="col">스크리닝번호</th>
						<th scope="col">스크리닝방문</th>
						<th scope="col">피험자확정</th>
						<th scope="col">식별번호</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultList }" var="result">
						<tr>
							<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.subNo }'/>"/></td>
							<td><c:out value="${result.rownum }"/></td>
							<td  onclick="fn_view('<c:out value='${result.corpCd}'/>','<c:out value='${result.rsNo}'/>'); return false;"><c:out value="${result.rsjName }"/></td>
	                        <td><c:out value="${result.addrMain }"/></td>
							<td><c:out value="${result.genYnNm }"/></td>
							<td><c:out value="${result.brDt }"/></td>
							<td><c:out value="${result.age }"/></td>
							<td><c:out value="${result.hpNo }"/></td>
							<td><c:out value="${result.appYn }"/></td>
							<td><c:out value="${result.poolYn }"/></td>
							<td><c:out value="${result.firstSt }"/></td>
							<td><c:out value="${result.firstStNo }"/></td>
							<td id="answTd_0">
								<c:set var="chkNo" value="${result.mapKey }"/>
								<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
									<div class="que_item ques_div_0">
										<a href="#" onclick="fn_resrModiPop('<c:out value="${resutlMt.corpCd }"/>','<c:out value="${resutlMt.resrNo }"/>'); return false;" style="text-decoration: underline;"><c:out value="${resutlMt.resrDt }"/>-<c:out value="${resutlMt.resrHr }"/>:<c:out value="${resutlMt.resrMm }"/>(<c:out value="${resutlMt.mtStNm }"/>)</a>						
									</div>
								</c:forEach>
							</td>
							<td><c:out value="${result.cfmYn }"/></td>
							<td><c:out value="${result.rsiNo }"/></td>
							<td>
								<a href="#" onclick="fn_Rsjmgpop('<c:out value="${result.corpCd }"/>','<c:out value="${result.rsNo }"/>','<c:out value="${result.subNo }"/>','<c:out value="${result.rsjNo }"/>'); return false;" class="btn_sub">관리</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="16">선정된 연구대상자 정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<!-- //목록 -->
<%-- 			<!-- 스마트추천 -->
			<div class="tbl_top_info">
				<h4>스마트 추천</h4>
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_sub">SMS 발송</a>
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_open(); return false;">일정저장</a>
				</div>
			</div>
			<!-- //서브타이틀 -->
            <!-- 추천정보 -->
			<table class="tbl_list">
			<colgroup>
					<col style="width:4%" />
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" id="all-chk2"/></th>
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">생년월일</th>
						<th scope="col">나이</th>
						<th scope="col">성별</th>
						<th scope="col">핸드폰</th>
						<th scope="col">상세보기</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result2" items="${resultList2}" varStatus="status">
					<tr>
						<td><input type="checkbox" name="rsjSeq2" value="<c:out value='${result.subNo }'/>"/></td>					
						<td><c:out value="${result2.rownum }"/></td>
						<td><c:out value="${result2.rsjName }"/></td>
						<td><c:out value="${result2.brDt }"/></td>
						<td><c:out value="${result2.age}"/></td>
						<td><c:out value="${result2.genYnNm}"/></td>
						<td><c:out value="${result2.hpNo}"/></td>
						<td><a href="#" onclick="fn_pop('<c:out value="${result2.corpCd }"/>','<c:out value="${result2.rsNo }"/>','<c:out value="${result2.subNo }"/>'); return false;" class ="btnLockNonDisp btn_sub">상세보기</a></td>
					</tr>
				</c:forEach>
				<c:if test="${resultList2.size() == 0 }">
							<tr>
								<td class="nodata" colspan="8">스마트추천 정보가 없습니다.</td>
							</tr>
				</c:if>
				</tbody>
			</table>
			<!-- //추천정보 --> --%>
			
			
			
			
			
		</form:form>	
		</div>
		<!-- //contents -->
		<!-- 팝업(최종확정) -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>연구대상자 확정</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 사용체크정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>			
					<tr>
						<th scope="row">최종확정</th>
						<!-- <td>
							<div>
								<input name="step1" id="step1" value="<c:out value="${rs2000mVO.cfmYn }" />" />
							</div>
						</td>  -->
					</tr>
				</tbody>
			</table>
			<!-- 버튼 -->
            <div class="btn_area">
            	<a href="#" onclick="fn_step(); return false;" >저장</a>
            	<label for="modi-pop" class="type02 btn-cancel">취소</label>			
			</div>
		</div>
		<!-- 팝업(최종확정)-->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
		<input type="hidden" name="status" id="status" value="<c:out value='${status }'/>"/>
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
