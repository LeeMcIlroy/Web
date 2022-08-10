<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
function fn_list(pageNo){
	$("#pageIndex").val(pageNo);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/admSemeList.do'/>").submit();
}

function fn_modify(sem_code){
 	$("#sem_code").val(sem_code);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/admSemeModify.do'/>").submit();
}

// 엑셀 다운로드
function fn_excelDown(){
	$("#listForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/curr/admSemeExcel.do'/>").submit();
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
					<jsp:param name="dept1" value="교육과정"/>
		            <jsp:param name="dept2" value="학기"/>
	           	</jsp:include>
				<!--search info-->
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" name="sem_code" id="sem_code"/>
				<div class="search-infomation">
					<div class="search-count">
						<strong><c:out value="${totalCount }"/></strong>건이 검색되었습니다.
					</div>
					<div class="paging-select">
							${currentPageNo} / ${totalPageCount }page &nbsp;&nbsp;
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
							<col style="width:5%;" />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col style="width:5%;" />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>년도</th>
								<th>학기</th>
								<th>재등록신청기간</th>
								<th>수업평가기간</th>
								<th>등록기간</th>
								<th>개설기간</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status" >
							<tr onclick="fn_modify('<c:out value="${result.semCode }"/>'); return false;">
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
								<td><c:out value="${result.semYear}"/></td>
								<td>
									<c:if test="${ result.semester eq '1'}">봄학기</c:if>
									<c:if test="${ result.semester eq '2'}">여름학기</c:if>
									<c:if test="${ result.semester eq '3'}">가을학기</c:if>
									<c:if test="${ result.semester eq '4'}">겨울학기</c:if>
								</td>
								<td><c:out value="${result.lecAttendS}"/><br /> ~ <c:out value="${result.lecAttendE}"/></td>
								<td><c:out value="${result.valuationS}"/><br /> ~ <c:out value="${result.valuationE}"/></td>
								<td><c:out value="${result.registS}"/><br /> ~ <c:out value="${result.registE}"/></td>
								<td><c:out value="${result.enterRegiS}"/><br /> ~ <c:out value="${result.enterRegiE}"/></td>
								<td>
									<c:choose>
										<c:when test="${result.openSem eq 'Y' && result.openRegi eq 'Y'}">
											개설
										</c:when>
										<c:when test="${result.openSem eq 'N' && result.openRegi eq 'Y'}">
											신청
										</c:when>
										<c:when test="${result.openSem eq 'N' && result.openRegi eq 'N'}">
											마감
										</c:when>
										<c:otherwise>개설</c:otherwise>
									</c:choose>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admSemeModify.do'/>" class="white btn-newwrite">학기등록</a>
					</div>
				</div>
				<!--// table button -->

				<!-- paging -->
				<div class="paginate">
					<div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
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