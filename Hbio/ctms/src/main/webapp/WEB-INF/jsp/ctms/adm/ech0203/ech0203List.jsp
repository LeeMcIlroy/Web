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
	function fn_view(quesNo){
		if(quesNo != ''){
			$("#quesNo").val(quesNo);
			$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0203/ech0203View.do'/>").submit();
		}else{
			alert('잘못된 요청입니다.');
		}
	}
	
	function fn_modify(quesNo){
		$("#quesNo").val(quesNo);
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0203/ech0203Modify.do'/>").submit();
	}
	
	//질문답변관리 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0203/ech0203List.do'/>").submit();
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
				$("#datepicker02").datepicker().datepicker("setDate", '');
			break;
			default : 
				$("#datepicker01").datepicker().datepicker("setDate", new Date());
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
		}
	}
	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>eCRF관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="질문답변관리"/>
           	</jsp:include>
			<!-- //타이틀 -->			
			<form:form commandName="searchVO" id="frm" name="frm">
			<input type="hidden" name="quesNo" id="quesNo"/>
			<!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>유형</p>
						<span>
							<form:select path="searchCondition1">
								<form:option value="">전체</form:option>
								<form:option value="S">단일응답</form:option>
								<form:option value="M">복수응답</form:option>
								<form:option value="F">자유기재형</form:option>
							</form:select>
						</span>
					</li>
					<li>
						<p>사용여부</p>
						<span>
							<form:select path="searchCondition2">
								<%-- <form:option value="">선택</form:option> --%>
								<form:option value="Y">사용</form:option>
								<form:option value="N">미사용</form:option>
								<form:option value="T">전체</form:option>
							</form:select>
						</span>
					</li>
					<li>
						<p>기간</p>
                        <span>
                            <form:select path="searchCondition3">
								<form:option value="">검색조건</form:option>
								<form:option value="dataRegdt">등록일</form:option>
							</form:select>
                        </span>
						<span>
							<form:input path="startDate" id="datepicker01" class="date" readonly="true"/>
							<a href="#" class="btn_cld">날짜검색</a>
						</span>
						<em>~</em>
						<span>
							<form:input path="endDate" id="datepicker02" class="date" readonly="true"/>
							<a href="#" class="btn_cld">날짜검색</a>
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
							<form:select path="searchType" onchange="fn_resetWord(); return false;">
								<form:option value="">검색조건</form:option>
								<form:option value="1">전체</form:option>
								<form:option value="2">질문/답변명</form:option>
								<form:option value="3">질문</form:option>
							</form:select>
						</span>
                        <span class="type02">
                            <form:input path="searchWord" placeholder="검색어 입력" />
                        </span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<!-- <a href="#">조회</a> -->
				<a href="#" onclick="fn_list(1); return false;">조회</a>
			</div>
			<!-- //검색영역 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<span>총 <c:out value="${paginationInfo.totalRecordCount }"/>건</span>
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_excel">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<!-- 목록 -->
			<table class="tbl_list tr_link">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:auto" />
					<col style="width:20%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">유형</th>
						<th scope="col">질문/답변명</th>
						<th scope="col">질문</th>
						<th scope="col">답변개수</th>
						<th scope="col">등록일</th>
                        <th scope="col">사용여부</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${resultList != null && resultList.size() > 0 }">
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr onclick="fn_view('<c:out value="${result.quesNo }"/>'); return false;">
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
									<td><c:out value="${result.quesType eq 'S'?'단일응답':result.quesType eq 'M'?'복수응답':'자유기재형' }"/></td>
									<td><c:out value="${result.quesNm }"/></td>	
									<td><c:out value="${result.quesCon }"/></td>
									<td><c:out value="${result.answCnt }"/></td>
									<td><c:out value="${result.dataRegdt }"/></td>
									<td><c:out value="${result.useYn eq 'Y'?'사용':'미사용' }"/></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td class="nodata" colspan="7">질문답변 정보가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<!-- //목록 -->
			<div class="list_btm">
				<!-- 페이징 -->
				<div class="pagenate">
					<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
					<form:hidden path="pageIndex"/>
				</div>
				<!-- //페이징 -->
				<!-- 하단버튼 -->
				<div class="list_btm_btn">
					<a href="#" onclick="fn_modify(''); return false;">등록</a>
				</div>
				<!-- //하단버튼 -->
			</div>
			<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
			</form:form>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>