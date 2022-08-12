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
	$(function(){
		
		//연구대상자 관리자확인일자 설정을 위해 목록 선택 - 관리자확인 후 연구대상자 로그인 가능 
		$("#all-chk").change(function(){
			$("input[name=rsjSeq]").prop("checked", $(this).prop('checked'));
		});
		
		//엑셀다운로드권한 
		var ynexauth = '<c:out value="${exauth}"/>';
		if(ynexauth=='N') {
			$('.btn_excel').css("display","none");
		}
		
		var ynadminType = '<c:out value="${adminType}"/>';	
		if(ynadminType=='2') {
			$('.btnLockNonDisp').css("display","none");
		}
		
		
	});
	
	//피험자관리 상세보기 화면
	function fn_view(corpCd, rsjNo){
		$("#corpCd").val(corpCd);
	 	$("#rsjNo").val(rsjNo);
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0301/ech0301View.do'/>").submit();
	}
	
	//피험자관리 목록으로
	function fn_list(pageNo){
		
		var dateStdt = $("#datepicker01").val();
		var dateEndt = $("#datepicker02").val();
		
		if(dateStdt > dateEndt){
			alert('시작일자를 조정해주세요')
			$('#datepicker01').focus();
			return;
		}
		
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0301/ech0301List.do'/>").submit();
	}
	//피험자관리 등록화면
	function fn_modify(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0301/ech0301Modify.do'/>").submit();
	}
	
	//피험자관리 엑셀다운로드
	function fn_excelDown(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0301/ech0301Excel.do'/>").submit();
	}

	// from ~ to 기간은 최대 365일이내 	
	function fn_date(i){
		$("input[name=period]:checked").attr("checked", false);
		var termDate = 365; // 차이일수 설정
		var staDate = new Date($("#datepicker01").val());
		var endDate = new Date($("#datepicker02").val())
		var dateDiff = Math.ceil((endDate.getTime() - staDate.getTime())/(1000*3600*24));
		if(dateDiff > termDate || dateDiff < -termDate){
			$("#datepicker02").val("");
			$("#datepicker02").focus();
			alert('작업기간은 '+termDate+'일 이내로 검색할 수 있습니다.');
		}
	}
	
	//검색항목 제어 기능 시작
	//기간 clear 
	function fn_resetTerm(){
		var chkTerm = $("#searchCondition4").val();
		if(chkTerm == '') {
			$("#datepicker01").datepicker().datepicker("setDate", '');
			$("#datepicker02").datepicker().datepicker("setDate", '');
			$("#searchCondition1").focus();
			$("input[name=period]:checked").prop("checked", false);  
		} 
		//$("#searchCondition1").val("");
		//$("#searchCondition2").val("");
		//$("#searchCondition1").focus();
	}
	
	//검색어 clear
	function fn_resetWord(){
		$("#searchWord").val("");
		$("#searchWord").focus();
	}
	
	
	function fn_resetWord(){
		$("#searchWord").val("");
		$("#searchWord").focus();
	}

	function fn_getDatePrev(dayCnt) {
		var dDate = new Date();
		var dDate = new Date(dDate.getTime()+(1000*60*60*24*-dayCnt));
		return dDate;
	}
	
	function fn_resetDate(){
		//alert('검색기간을 재설정합니다.');

		// 1 1년  2 3개월  3 1개월  4 전체
		switch($("input[name=period]:checked").val()) {
			case '1':
				$("#datepicker01").datepicker().datepicker("setDate", fn_getDatePrev(365));
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			case '2':
				$("#datepicker01").datepicker().datepicker("setDate", fn_getDatePrev(90));
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			case '3':
				$("#datepicker01").datepicker().datepicker("setDate", fn_getDatePrev(30));
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			case '4':
				$("#datepicker01").datepicker().datepicker("setDate", '');
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			default : 
				$("#datepicker01").datepicker().datepicker("setDate", new Date());
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
		}
	}
	
	function fn_open(){
		
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해 주세요.');
			return;
		}
		$("#datepicker03").datepicker().datepicker("setDate", new Date());
		$("#modi-pop").prop("checked", "true");
	}
	
	function fn_open2(){
		
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해 주세요.');
			return;
		}
		$("#datepicker04").datepicker().datepicker("setDate", new Date());
		$("#modi-pop2").prop("checked", "true");
	}
	
	
	function fn_step(){
		if(confirm('선택하신 연구대상자들을 확정합니다.확정후 로그인 접속이 가능합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();			
			var step1 = $("#datepicker01").val();
			var step2 = $("#datepicker02").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0301/ech0301AjaxSaveCfmDt.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					$("#modi-pop").click();
					fn_list(1);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	function fn_step2(){
		if(confirm('선택하신 연구대상자를 연구과제의 스크리닝대상자로 확정합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();			
			var step3 = $("#step3").val(); //연구코드
			var step4 = $("#datepicker02").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0301/ech0301AjaxSaveFirstSt.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step3="+step3+"&"+"step4="+step4+"&"+$("input[name=rsjSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					$("#modi-pop").click();
					fn_list(1);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	
	
	
	
	
	function fn_createId(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해 주세요.');
			return;
		}

		if(confirm('선택하신 연구대상자의 아이디를 설정합니다. 비밀번호는 아이디와 동일하게 설정됩니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();			
			//var step1 = $("#step1").val();
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0301/ech0301AjaxSaveFirst.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					fn_list(1);
					//window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	
	}

	//일괄 SMS 발송
	function fn_pop_sms(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해주세요.');
			return;
		}
		var corpCd = $("#corpCd").val();
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0301/ech0301SmsAllPop.do'/>?corpCd="+corpCd+"&"+$("input[name=rsjSeq]:checked").serialize()
					, 'SMS발송', 'width=840, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" id="corpCd" name="corpCd" value="${searchVO.corpCd }"/>
<input type="hidden" id="rsjNo" name="rsjNo"/>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>	
	<!-- container -->
	<div class="container">
		<h2>피험자관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="피험자관리"/>
	            <jsp:param name="dept2" value="피험자관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>기간</p>
                        <span>
                        	<select name="searchCondition4" id="searchCondition4" onchange="fn_resetTerm(); return false;">
								<option value="" <c:if test="${searchVO.searchCondition4  eq '' }">selected="selected"</c:if> >선택</option>
								<option value="1" <c:if test="${searchVO.searchCondition4  eq '1' }">selected="selected"</c:if> >가입일자</option>
								<option value="2" <c:if test="${searchVO.searchCondition4  eq '2' }">selected="selected"</c:if> >관리자확인일자</option>
							</select>
                        </span>
						<span>
							<input type="text" name="searchCondition1" id="datepicker01" value="<c:out value="${searchVO.searchCondition1 }" />" placeholder="0000-00-00" class="date" onchange="fn_date(1); return false;" title="시작일자"/>
							<label for="datepicker01" class="btn_cld">날짜검색</label>
						</span>
						<em>~</em>
						<span>
							<input type="text" name="searchCondition2" id="datepicker02" value="<c:out value="${searchVO.searchCondition2 }" />" placeholder="0000-00-00" class="date" onchange="fn_date(2); return false;" title="종료일자"/>
							<label for="datepicker02" class="btn_cld">날짜검색</label>
						</span>
						<span class="type00" onchange="fn_resetDate(); return false;">
							<input type="radio" name="period" id="period01" value="1"/> <label for="period01">1년</label>
							<input type="radio" name="period" id="period02" value="2"/> <label for="period02">3개월</label>
							<input type="radio" name="period" id="period03" value="3"/> <label for="period03">1개월</label>
							<input type="radio" name="period" id="period04" value="4"/> <label for="period04">전체</label>
						</span>
					</li>
					                 
                    <li>
						<p>검색어</p>
						<span>
							<select name="searchCondition3" id="searchCondition3" onchange="fn_resetWord(); return false;">
								<option value="" <c:if test="${searchVO.searchCondition3  eq '' }">selected="selected"</c:if> >선택</option>
								<option value="1" <c:if test="${searchVO.searchCondition3  eq '1' }">selected="selected"</c:if> >전체</option>
								<option value="2" <c:if test="${searchVO.searchCondition3  eq '2' }">selected="selected"</c:if> >이름</option>
								<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >생년월일</option>
								<option value="4" <c:if test="${searchVO.searchCondition3  eq '4' }">selected="selected"</c:if> >전화번호</option>
								<option value="5" <c:if test="${searchVO.searchCondition3  eq '5' }">selected="selected"</c:if> >피험자번호</option>
							</select>
						</span>
                        <span class="type02">
                            <!-- <input type="text" name="searchWord" id="searchWord" class="input-data" value="<c:out value="${searchVO.searchWord }" />" placeholder="이름, 생년월일, 전화번호를 입력하세요" />-->
                            <form:input path="searchWord" class="input-data" placeholder="이름,생년월일,전화번호를 입력하세요" style="width: 248px;"/>
                        </span>
					</li>
					<li>
						<p>관리자확인</p>
							<span>
								<select name="cfmYn" id="cfmYn" >
									<option value="" <c:if test="${searchVO.cfmYn  eq '' }">selected="selected"</c:if> >선택</option>
									<option value="1" <c:if test="${searchVO.cfmYn  eq '1' }">selected="selected"</c:if> >미확인</option>
									<option value="2" <c:if test="${searchVO.cfmYn  eq '2' }">selected="selected"</c:if> >확인</option>
								</select>
							</span>
					</li>   
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_list(1); return false;">조회</a>
			</div>
			<!-- //검색영역 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<span>
					총<strong><c:out value="${totalCount }"/></strong>건
				</span>
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_open2(); return false;">스크리닝등록</a>
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_open(); return false;">관리자확인</a>
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_createId(); return false;">아이디일괄부여</a>
					<a href="#" class="btn_sub" onclick="fn_pop_sms(); return false;">SMS 발송</a>
					<a href="#" onclick="fn_excelDown(); return false;" class="btn_excel">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:4%" />
					<col style="width:5%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:4%" />
					<col style="width:4%" />
					<col style="width:auto" />
					<col style="width:8%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" id="all-chk" /></th>
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">아이디</th>
						<th scope="col">가입일자</th>
						<th scope="col">생년월일</th>
						<th scope="col">나이</th>
						<th scope="col">성별</th>
						<th scope="col">거주지</th>
                        <th scope="col">핸드폰</th>
                        <th scope="col">연구순응도</th>
                        <th scope="col">예약상태</th>
                        <th scope="col">참여(확정)</th>
                        <th scope="col">관리자확인</th>
                        <th scope="col">상태</th>                        
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">			
						<tr>
							<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.rsjNo }'/>"/></td>				
							<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
							<td onclick="fn_view('<c:out value="${result.corpCd }"/>','<c:out value="${result.rsjNo }"/>'); return false;" style="text-decoration: underline;"><a href="#" ><c:out value="${result.rsjName }"/></a></td>
							<td><c:out value="${result.userId}"/></td>
							<td><c:out value="${result.regDt}"/></td>
							<td><c:out value="${result.brDt}"/></td>
							<td><c:out value="${result.age}"/></td>
							<td><c:out value="${result.genName}"/></td>
							<td><c:out value="${result.addr}"/></td>
							<td><c:out value="${result.hpNo}"/></td>
							<td><c:out value="${result.rsjStClsNm}"/></td>
							<td><c:out value="${result.tmtSt}"/></td>
							<td><c:out value="${result.jnCnt}"/></td>
							<td><c:out value="${result.cfmDt}"/></td>
							<td><c:out value="${result.userStNm}"/></td>
						</tr>
					</c:forEach>
					<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="15">연구대상자 정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<!-- //목록 -->
			<!--  목록 하단 -->
			<div class="list_btm">
				<!-- 페이징 -->
				<div class="pagenate">
					<div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
					</div>
				</div>
				<!-- //페이징 -->
				<!-- 하단버튼 -->
				<div class="list_btm_btn">
					<a href="#" onclick="fn_modify();">등록</a>
				</div>
				<!-- //하단버튼 -->
			</div>
			<!-- //목록 하단 -->
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>관리자확인일자 설정</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 사용체크정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
				</colgroup>
				<tbody>			
					<tr>
						<th scope="row">관리자 확인일자</th>
						<td colspan="3">
							<div>
								<input name="step1" id="datepicker03" placeholder="0000-00-00"  class="required" title="확인일자" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- 버튼 -->
            <div class="btn_area">
            	<a href="#" onclick="fn_step(); return false;" >저장</a>
            	<label for="modi-pop" class="type02 btn-cancel">취소</label>			
			</div>
		</div>
		</div>
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop2" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup2" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>연구코드설정</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 사용체크정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
				</colgroup>
				<tbody>			
					<tr>
						<th scope="row">연구코드</th>
						<td colspan="3">
							<div>
								<input type="text" class="step3" id="step3" class="required" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- 버튼 -->
            <div class="btn_area">
            	<a href="#" onclick="fn_step2(); return false;" >저장</a>
            	<label for="modi-pop2" class="type02 btn-cancel">취소</label>			
			</div>
		</div>
		</div>
		
		
		</div>
		<!-- //contents -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</form:form>
</body>
</html>