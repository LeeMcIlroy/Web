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
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/admClstmList.do'/>").submit();
}

function fn_modify(clstmSeq){
 	$("#clstmSeq").val(clstmSeq);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/admClstmModify.do'/>").submit();
}

</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" name="clstmSeq" id="clstmSeq"/>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="교육과정"/>
		            <jsp:param name="dept2" value="수업시간"/>
	           	</jsp:include>
				<!-- search -->
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search">
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:8%;" />
									<col style="width:15%;" />
									<col style="width:8%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<td>학기</td>
										<td>
											<form:select path="searchCondition1" onchange="fn_search_seme(this);">
												<form:options items="${yearList }"/>
											</form:select>
											<form:select path="searchCondition2" id="semEster">
												<c:forEach items="${semeList }" var="seme">
													<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
												</c:forEach>
											</form:select>
										</td>
										<td>프로그램</td>
										<td>
											<form:select path="searchCondition3">
												<c:forEach items="${progName }" var="prog">
													<form:option value="${prog.progName }"><c:out value="${prog.progName }"/></form:option>
												</c:forEach>
											</form:select>
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
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>프로그램명</th>
								<th>교시</th>
								<th>강의시작시간</th>
								<th>강의종료시간</th>
								<th>오전/오후</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<tr onclick="fn_modify('<c:out value="${result.clstmSeq }"/>'); return false;">
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
									<td><c:out value="${result.clstmName}"/></td>
									<td><c:out value="${result.clstmCode}교시"/></td>
									<td><c:out value="${result.clstmStimeS}"/> : <c:out value="${result.clstmStimeE}"/></td>
									<td><c:out value="${result.clstmEtimeS}"/> : <c:out value="${result.clstmEtimeE}"/></td>
									<td>
									<c:choose>
									<c:when test="${result.clstmStimeS eq '09' || result.clstmStimeS eq '10' || result.clstmStimeS eq '11'}">오전</c:when>
									<c:otherwise>오후</c:otherwise>
									</c:choose>
									</td>
									<td>
										<c:if test="${result.clstmState eq 'Y'}">운영</c:if>
										<c:if test="${result.clstmState eq 'N'}">미운영</c:if>
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
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admClstmModify.do'/>" class="white btn-newwrite">강의시간등록</a>
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