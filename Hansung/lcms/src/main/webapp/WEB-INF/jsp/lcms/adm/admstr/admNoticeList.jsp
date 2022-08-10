<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring"	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">

//공지내용 상세보기 화면
function fn_select(noti_seq){
 	$("#noti_seq").val(noti_seq);
 	$("#listForm").attr("action","<c:url value='/qxsepmny/admstr/admNoticeView.do'/>").submit();
}

//목록으로
function fn_list(pageNo){
	$("#pageIndex").val(pageNo);
	$("#listForm").attr("action", "<c:url value='/qxsepmny/admstr/admNoticeList.do'/>").submit();
}
//공지 등록화면
function fn_notiRegist(){
	$("#listForm").attr("action", "<c:url value='/qxsepmny/admstr/admNoticeModify.do'/>").submit();
}

</script>

<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" id="noti_seq" name="noti_seq"/>   
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="공지사항"/>
	           	</jsp:include>
				<!-- search -->
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
										<th>공지구분</th>
										<td>
											<select name="searchCondition1" onchange="fn_list('1');">
												<option value="">선택</option>
												<option value="1">전체</option>
												<option value="2">교사</option>
												<option value="3">학생</option>
											</select>
											<input type="text" name="searchWord" class="input-data" placeholder="제목, 내용을 입력하세요" />
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
							<col style="width:7%;"/>
							<col />
							<col style="width:5%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>공지구분</th>
								<th>제목</th>
								<th>첨부</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
								<td>
								<c:choose>
									<c:when test="${result.notiTop eq 'Y' }">
										<img src="<c:url value='/assets/adm/img/icon-notice_top.jpg'/>" style="vertical-align:middle;" alt="고정" />
									</c:when>
									<c:when test="${empty result.notiTop || result.notiTop eq ''}">
										<c:out value="${result.notiGubun}"/>
									</c:when>								
								</c:choose>
								</td>
								<td class="txt-l"><a href="#" class="underline imgSelect" onclick="fn_select('<c:out value='${result.notiSeq }'/>', this); return false;"><c:out value="${result.notiTitle }"/></a>
								<jsp:useBean id="now" class="java.util.Date" />
									<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
									<fmt:parseDate var="dateFmt" pattern="yyyy.MM.dd" value="${result.notiDate }"/>
									<fmt:formatDate var="notiDate" pattern="yyyy-MM-dd" value="${dateFmt}" />
									<c:choose>
										<c:when test="${notiDate eq today }">
											&nbsp;&nbsp;<img src="<c:url value='/assets/adm/img/icon-new.png'/>" style="vertical-align:middle;" alt="새글" />
										</c:when> 
										<c:otherwise>
												&nbsp;
										</c:otherwise>
									</c:choose>
								</td>
								<td>
								  <c:if test="${result.filecount > 0}">
									<a href="#"><span class="icon-download-file">첨부파일</span></a>
								</c:if>
								</td>
								<td><c:out value="${result.notiWriter}"/></td>
								<td><c:out value="${result.notiDate}"/></td>
								<td><c:out value="${result.notiHit}"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-newwrite"  onclick="fn_notiRegist()" >공지등록</button>
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