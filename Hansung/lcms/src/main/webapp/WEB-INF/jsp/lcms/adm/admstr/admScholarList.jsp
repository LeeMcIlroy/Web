<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_list(idx){
		$("#pageIndex").val(idx);
		$("#frm").attr("action", "<c:url value='/qxsepmny/admstr/admScholarList.do'/>").submit();
	}
	
	function fn_modify(seq){
		$("#scholarSeq").val(seq);
		$("#frm").attr("action", "<c:url value='/qxsepmny/admstr/admScholarModify.do'/>").submit();
	}
	
	function fn_excelDown(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/admstr/admScholarExcel.do'/>").submit();
	}
	
	function fn_pop(seq){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admScholarPop.do?scholarSeq='/>"+seq, '증명서 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
</script>
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="장학/수상"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
				<input type="hidden" id="scholarSeq" name="scholarSeq"/>
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search">
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:10%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>장학구분</th>
										<td>
											<form:select path="searchCondition1">
												<form:option value="">구분</form:option>
												<form:option value="1">성실상</form:option>
												<form:option value="2">우수상</form:option>
												<form:option value="3">봉사상</form:option>
											</form:select>
											<form:input path="searchWord" class="input-data" placeholder="이름, 학번를 입력하세요" />
										</td>
									</tr>
								</tbody>
							</table>

							<a href="#" onclick="fn_list(1); return false;">검색하기</a>
						</div>
					</div>
				</div>
				<!--// search -->

				<!--search info-->
				<div class="search-infomation">
					<div class="search-count">
						<strong><c:out value="${paginationInfo.totalRecordCount }"/></strong>건이 검색되었습니다.
					</div>
					<div class="paging-select">
						<c:out value="${paginationInfo.currentPageNo }"/> / <c:out value="${totalPageCount }"/>page &nbsp;&nbsp;
						<form:select path="recordCountPerPage" onchange="fn_list(1); return false;">
							<form:option value="10">10</form:option>
							<form:option value="15">15</form:option>
							<form:option value="20">20</form:option>
							<form:option value="25">25</form:option>
							<form:option value="30">30</form:option>
						</form:select>
					</div>
				</div>
				<!--// search info-->

				<!-- table -->
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:5%;" />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>발급번호</th>
								<th>대상학기</th>
								<th>장학/수상</th>
								<th>학번</th>
								<th>이름</th>
								<th>영문명</th>
								<th>선정일자</th>
								<th>장학금(원)</th>
								<th>발행</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td><c:out value="${result.scholarNum }"/></td>
									<td><c:out value="${result.year }"/>년 <c:out value="${result.semeNm }"/></td>
									<td><c:out value="${result.scholarType }"/></td>
									<td><span class="underline imgSelect" onclick="fn_modify('<c:out value="${result.scholarSeq }"/>'); return false;"><c:out value="${result.memberCode }"/></span></td>
									<td><span class="underline imgSelect" onclick="fn_modify('<c:out value="${result.scholarSeq }"/>'); return false;"><c:out value="${result.name }"/></span></td>
									<td><c:out value="${result.eName }"/></td>
									<td><c:out value="${result.scholarDate }"/></td>
									<td><c:out value="${result.scholarship }"/></td>
									<td><a href="#" onclick="fn_pop('<c:out value="${result.scholarSeq }"/>'); return false;">인쇄</a></td>
								</tr>
							</c:forEach>
							<c:if test="${resultList.size() == 0 }">
								<tr>
									<td colspan="10">조회된 내용이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						<button type="button" class="white btn-newwrite" onclick="fn_modify(''); return false;">장학등록</button>
					</div>
				</div>
				<!--// table button -->
				<!-- paging -->
				<div class="paging_wrap">
					<div class="paging">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
						<form:hidden path="pageIndex" />
					</div>
				</div>
				<!--// paging -->
				</form:form>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>