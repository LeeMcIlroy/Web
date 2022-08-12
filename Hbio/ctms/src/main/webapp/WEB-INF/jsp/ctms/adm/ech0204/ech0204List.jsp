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
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0204/ech0204List.do'/>").submit();
	}

	function fn_view(rsNo){
		$("#rsNo").val(rsNo);
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0204/ech0204View.do'/>").submit();
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
	//-- 검색항목 제어 기능 끝
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>피부특성관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="피부특성관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<form:form commandName="searchVO" id="frm" name="frm" method="post">
				<input type="hidden" id="rsNo" name="rsNo"/>
				<!-- 검색영역 -->
				<div class="srch_area">
					<ul>
						<li>
							<p>연도</p>
							<%-- <span class="type01">
								<form:input path="searchCondition1" placeholder="연구코드" />
							</span> --%>
							<span>
								<form:select path="searchYear" onchange="fn_search_rsplan(this); return false;">
									<option value="">선택</option>
									<form:options items="${yearList }"/>
								</form:select>
							</span>
							<span class="type01" >
								<form:select path="searchCondition8" id="rsCdList">
									<c:forEach items="${yearRsCdList }" var="rscd">
										<form:option value="${rscd.rsCd }"><c:out value="${rscd.rsCd }"/></form:option>
									</c:forEach>
								</form:select>
							</span>
						</li>
						<li>
							<p>연구상태</p>
							<span>
								<!-- 연구상태 목록(공통코드) CM4000M - CT2050   -->
								<select id="searchCondition6" name="searchCondition6">
									<option value="">선택</option>
									<c:if test="${searchVO.searchCondition6 eq '' }">selected="selected"</c:if>
									<c:forEach var="result" items="${ct2050}">									
										<option value="${result.cd}"<c:if test="${result.cd eq searchVO.searchCondition6 }">selected="selected"</c:if>>${result.cdName}</option>
									</c:forEach>
								</select>
							</span>
						</li>
						<li>
							<p>eCRF상태</p>
							<span>
								<form:select path="searchCondition5">
									<form:option value="">전체</form:option>
									<c:forEach items="${stateList }" var="state">
										<form:option value="${state.cd }"><c:out value="${state.cdName }"/></form:option>
									</c:forEach>
								</form:select>
							</span>
						</li>
						<li>
							<p>기간</p>
	                        <span>
	                            <form:select path="searchCondition4" onchange="fn_resetTerm(); return false;">
									<form:option value="">검색조건</form:option>
									<form:option value="1">연구시작</form:option>
									<form:option value="2">연구종료</form:option>
								</form:select>
	                        </span>
							<span>
								<form:input path="searchCondition1" id="datepicker01" class="date" readonly="true"/>
								<label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
							<em>~</em>
							<span>
								<form:input path="searchCondition2" id="datepicker02" class="date" readonly="true"/>
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
								<form:select path="searchType" onchange="fn_resetWord(); return false;">
									<form:option value="">검색조건</form:option>
									<form:option value="1">연구명</form:option>
									<form:option value="2">연구코드</form:option>
								</form:select>
							</span>
	                        <span class="type02">
	                            <form:input path="searchWord" placeholder="검색어 입력" />
	                        </span>
						</li>
					</ul>
					<!-- 조회버튼 -->
					<a href="#" onclick="fn_list('1'); return false;">조회</a>
				</div>
				<!-- //검색영역 -->
				<!-- 테이블 상단 정보 -->
				<div class="tbl_top_info">
					<span>총<strong><c:out value="${totalCount }"/></strong>건</span>
					<!-- 버튼 -->
					<div>
						<!-- <a href="#" onclick="fn_excelDown(); return false;" class="btn_excel">엑셀</a> -->
					</div>
				</div>
				<!-- //테이블 상단 정보 -->
				<!-- 목록 -->
				<table class="tbl_list tr_link">
					<colgroup>
						<col style="width:5%" />
						<col style="width:20%" />
						<col style="width:auto" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">연구코드</th>
							<th scope="col">연구명</th>
							<th scope="col">연구상태</th>
							<th scope="col">시작일자</th>
							<th scope="col">종료일자</th>
							<th scope="col">피험자수</th>
							<th scope="col">eCRF상태</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${resultList != null && resultList.size() != 0 }">
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr onclick="fn_view('<c:out value="${result.rsNo }"/>'); return false;">
										<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
										<td><c:out value="${result.rsCd }"/></td>						
										<td><c:out value="${result.rsName }"/></td>
										<td><c:out value="${result.rsstClsNm }"/></td>
										<td><c:out value="${result.rsStdt }"/></td>
										<td><c:out value="${result.rsEndt }"/></td>
										<td><c:out value="${result.rsiCnt }"/></td>
										<td><c:out value="${result.stateClsNm }"/></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="nodata" colspan="8">피부특성관리 정보가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<!-- //목록 -->
				<!-- 페이징 -->
				<div class="pagenate">
					<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
					<form:hidden path="pageIndex"/>
				</div>
				<!-- //페이징 -->
			</form:form>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>