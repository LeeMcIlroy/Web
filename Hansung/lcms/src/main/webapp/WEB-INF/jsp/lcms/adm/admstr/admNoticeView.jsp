<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 		uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"			uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">

//목록으로
function fn_list(){
	$("#detailForm").attr("action", "<c:url value='/qxsepmny/admstr/admNoticeList.do'/>").submit();
}

//수정페이지로
function fn_update(){
	$("#detailForm").attr("action", "<c:url value='/qxsepmny/admstr/admNoticeModify.do'/>").submit();
}

// 공지 페이지 삭제
function fn_delete(){
	if (confirm("공지를 삭제하시겠습니까?")) {
	$("#detailForm").attr("action", "<c:url value='/qxsepmny/admstr/admNoticeDelete.do'/>").submit();
		
	}
}

//파일 다운로드
function fn_filedownload(geupSeq, type){
	location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+geupSeq+"&type="+type;
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
		            <jsp:param name="dept2" value="공지사항"/>
	           	</jsp:include>
	           	
	           	
<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
<input type="hidden" id="noti_seq" name="noti_seq" value="${result.noti_seq }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
	           	
				<p class="sub-title">공지내용</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>제목</th>
								
								<td colspan="3"><c:out value="${result.noti_title}" />
									<jsp:useBean id="now" class="java.util.Date" />
									<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
									<fmt:parseDate var="dateFmt" pattern="yyyy.MM.dd HH:mm:ss" value="${result.noti_date }"/>
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
								<th>공지구분</th>
								<td><c:out value="${result.noti_gubun}" /></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td><c:out value="${result.noti_writer}" /></td>
								<th>작성일</th>
								<td>
									<fmt:parseDate var="dateFmt" pattern="yyyy.MM.dd HH:mm:ss" value="${result.noti_date }"/>
									<fmt:formatDate var="notiDate" pattern="yyyy.MM.dd HH:mm:ss" value="${dateFmt}" />
									<c:out value="${notiDate}" />
								</td>
								<th>조회수</th>
								<td><c:out value="${result.noti_hit}" /></td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="5"><c:out value="${result.noti_content}" escapeXml="false;"/></td>
							</tr>
						
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">첨부파일</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
						<tr>
							<th>첨부파일</th>
								<td>
								<c:forEach items="${attachList }" var="file" varStatus="status">
									<a href="#" onclick="fn_filedownload('<c:out value='${file.attachSeq}'/>','NOTI'); return false;">
										<c:out value="${file.orgFileName }" />
									</a>
									<br>
									<input type="hidden" id="delSeqList" name="delSeqList" value="<c:out value="${file.attachSeq }" />">
								</c:forEach>

								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
</form:form>
				<div class="table-button">
					<div class="btn-box">
						<a href="#" onclick="fn_delete(); return false;" class="white btn-list">삭제</a>
						<a href="#" onclick="fn_update(); return false;" class="white btn-list">수정</a>
						<a href="#" onclick="fn_list(); return false;" class="white btn-list">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->

</body>
</html>