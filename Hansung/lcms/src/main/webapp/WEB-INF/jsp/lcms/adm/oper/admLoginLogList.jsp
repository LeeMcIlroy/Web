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

function fn_list(pageIndex){
	$("#pageIndex").val(pageIndex);
	$("#listForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxsepmny/oper/admLoginLogList.do'/>").submit();
}

//엑셀 다운로드
function fn_excelDown(){
	$("#listForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/oper/admLoginLogExcel.do'/>").submit();
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
					<jsp:param name="dept1" value="운영"/>
		            <jsp:param name="dept2" value="접속이력"/>
	           	</jsp:include>
	           	
	           	<form:form commandName="searchVO" name="listForm" id="listForm">
	           	
				<!-- search -->
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search">
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<form:input path="searchWord" class="input-data" placeholder="이름을 입력하세요" />
										</td>
									</tr>
								</tbody>
							</table>

							<a href="#" onclick="fn_list('1'); return false;">검색하기</a>
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
						<c:out value="${paginationInfo.currentPageNo }"/> / <c:out value="${totalPageCount }"/>&nbsp;page &nbsp;&nbsp;
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
						</colgroup>
						<thead>
							<tr>
								<th>순번</th>
								<th>접속 구분</th>
								<th>아이디</th>
								<th>이름</th>
								<th>접속IP</th>
								<th>접속시간</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="status">
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + status.count)}"/></td>
									<td><c:out value="${result.loginType}"/></td>
									<td><c:out value="${result.loginId }"/></td>
									<td><c:out value="${result.name }"/></td>
									<td><c:out value="${result.acceIp }"/></td>
									<td><c:out value="${result.acceDate }"/></td>
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
					</div>
				</div>
				<!--// table button -->

				<!-- paging -->
				<div class="paging_wrap">
					<div class="paging">
						
							 <ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						    <form:hidden path="pageIndex"/>
					
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