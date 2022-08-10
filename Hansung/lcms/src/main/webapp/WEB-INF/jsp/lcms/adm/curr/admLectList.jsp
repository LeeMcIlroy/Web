<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib  prefix = "fn" 	uri = "http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
function fn_list(pageNo){
	$("#pageIndex").val(pageNo);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/admLectList.do'/>").submit();
}

function fn_modify(lectSeq){
 	$("#lectSeq").val(lectSeq);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/admLectModify.do'/>").submit();
}      

// 엑셀 다운로드
function fn_excelDown(){
	$("#listForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/curr/admLectExcel.do'/>").submit();
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
		            <jsp:param name="dept2" value="강의개설"/>
	           	</jsp:include>
				<!-- search -->
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" name="lectSeq" id="lectSeq"/>
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
										<td>대상학기</td>
										<td> <!-- onchange="this.form.submit()" -->
											<form:select path="searchCondition1" onchange="fn_search_seme(this);">
												<form:options items="${yearList }"/>
											</form:select>
											<form:select path="searchCondition2" id="semEster">
												<c:forEach var="seme" items="${semeList}">
													<form:option value="${seme.semester}"><c:out value="${seme.semeNm }"/></form:option>
												</c:forEach>
											</form:select>
										</td>
										<td>교육과정</td>
										<td>
											<form:select path="searchCondition3">
												<form:option value="">선택</form:option>
												<c:forEach var="result" items="${currName}">
											<form:option value="${result.currName}">${result.currName}</form:option>
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
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>과목명</th>
								<th>분반</th>
								<th>담임</th>
								<th>교사</th>
								<th>강의실</th>
								<th>정원</th>
								<th>개설기간</th>
								<th>개설여부</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<tr onclick="fn_modify('<c:out value="${result.lectSeq }"/>'); return false;">
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
									<td><c:out value="${result.lectName}"/></td>
									<td><c:out value="${result.lectDivi}"/></td>
									<td><c:out value="${result.name}"/></td>
									<td><c:out value="${result.lectTea}"/></td>
									<td><c:out value="${result.lectClassroom}"/></td>
									<td><c:out value="${result.lectPer}"/></td>
									<td><c:out value="${result.lectSdate}"/>
									<c:if test="${!empty result.lectSdate && !empty result.lectEdate}">
									&nbsp; ~ &nbsp;
									</c:if>
									<c:out value="${result.lectEdate}"/></td>
									<td>
										<c:if test="${result.lectState eq 'Y'}">개강</c:if>
										<c:if test="${result.lectState eq 'N'}">폐강</c:if>
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
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admLectModify.do'/>" class="white btn-newwrite">신규강의</a>
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