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
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/admProgList.do'/>").submit();
}

function fn_modify(progSeq){
 	$("#progSeq").val(progSeq);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/admProgModify.do'/>").submit();
}

</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" name="progSeq" id="progSeq"/>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="교육과정"/>
		            <jsp:param name="dept2" value="프로그램"/>
	           	</jsp:include>
				<%-- <!-- search -->
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search">
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:8%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<td>대상학기</td>
										<td>
											<select name="searchCondition1" >
												<option>전체</option>
												<option value="2020">2020</option>
												<option value="2019">2019</option>
												<option value="2018">2018</option>
											</select>
											<select name="searchCondition2">
												<option>전체</option>
												<option value="1">봄학기</option>
												<option value="2">여름학기</option>
												<option value="3">가을학기</option>
												<option value="4">겨울학기</option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
							<a href="#" onclick="fn_list(1); return false;">검색하기</a>
						</div>
					</div>
				</div>
				<!--// search --> --%>


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
								<th>프로그램명</th>
								<th>과정코드</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<tr onclick="fn_modify('<c:out value="${result.progSeq }"/>'); return false;">
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
									<td><c:out value="${result.progName}"/></td>
									<td><c:out value="${result.progCode}"/></td>
									<td>
										<c:if test="${result.progState eq 'Y'}">운영</c:if>
										<c:if test="${result.progState eq 'N'}">미운영</c:if>
									</td>
								</tr>
							</c:forEach>
						
							<!-- <tr>
								<td>3</td>
								<td><span class="underline">정규과정</span></td>
								<td><span class="underline">CP</span></td>
								<td>운영</td>
							</tr>
							<tr>
								<td>2</td>
								<td><span class="underline">특별과정</span></td>
								<td><span class="underline">SP</span></td>
								<td>미운영</td>
							</tr> -->
						</tbody>
					</table>
				</div>
				<!--// table -->
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admProgModify.do'/>" class="white btn-newwrite">프로그램등록</a>
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