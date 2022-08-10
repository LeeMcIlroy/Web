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
function fn_list(pageNo){
	$("#pageIndex").val(pageNo);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/admCurrList.do'/>").submit();
}

function fn_modify(currSeq){
 	$("#currSeq").val(currSeq);
	$("#listForm").attr("method","post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/admCurrModify.do'/>").submit();
}

</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" name="currSeq" id="currSeq"/>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="교육과정"/>
		            <jsp:param name="dept2" value="교육과정"/>
	           	</jsp:include>
				<!--search info-->
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
							<col />
							<col />
							<col style="width:5%;" />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>교육과정명</th>
								<th>과정코드</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<tr onclick="fn_modify('<c:out value="${result.currSeq }"/>'); return false;">
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
									<td><c:out value="${result.currName}"/></td>
									<td><c:out value="${result.currCode}"/></td>
									<td>
										<c:if test="${result.currState eq 'Y'}">운영</c:if>
										<c:if test="${result.currState eq 'N'}">미운영</c:if>
									</td>
							</tr>
							</c:forEach>
							<!-- <tr>
								<td>3</td>
								<td><span class="underline">한국어교육과정</span></td>
								<td><span class="underline">K01</span></td>
								<td>운영</td>
							</tr>
							<tr>
								<td>2</td>
								<td><span class="underline">한국어교육과정</span></td>
								<td><span class="underline">K01</span></td>
								<td>미운영</td>
							</tr> -->
						</tbody>
					</table>
				</div>
				<!--// table -->
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admCurrModify.do'/>" class="white btn-newwrite">교육과정등록</a>
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
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
	</form:form>
</body>
</html>