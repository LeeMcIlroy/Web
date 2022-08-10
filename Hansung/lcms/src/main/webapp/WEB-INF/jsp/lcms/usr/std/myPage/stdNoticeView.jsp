<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script>
		function closeLayer( obj ) {
			$(obj).parent().parent().hide();
		}

		$(function(){

			/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
			$('.imgSelect').click(function(e)
			{
				var sWidth = window.innerWidth;
				var sHeight = window.innerHeight;

				var oWidth = $('.popupLayer').width();
				var oHeight = $('.popupLayer').height();

				// 레이어가 나타날 위치를 셋팅한다.
				var divLeft = e.clientX + 10;
				var divTop = e.clientY + 5;

				// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
				if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
				if( divTop + oHeight > sHeight ) divTop -= oHeight;

				// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
				if( divLeft < 0 ) divLeft = 0;
				if( divTop < 0 ) divTop = 0;

				$('.popupLayer').css({
					"top": divTop,
					"left": divLeft,
					"position": "absolute"
				}).show();
			});

		});
		
		
		function fn_list(){
			$("#detailForm").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/std/myPage/stdNoticeList.do'/>").submit();
		}
		
		//파일 다운로드
		function fn_filedownload(boardSeq, boardType){
			location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+boardSeq+"&type="+boardType;
		}
		
	</script>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavStd"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuStd"/>
			<!--// left menu -->
			
<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
			
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">공지사항</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>마이페이지</span>
						<span>공지사항</span>
					</div>
				</div>

				<p class="sub-title">공지내용</p>
				<!-- table -->
				<!-- *************************** 웹 상세 보기 ***************************-->
				<div class="list-table-box web">
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
								<td colspan="5">
									<c:out value="${result.noti_title }"/>
									<jsp:useBean id="now" class="java.util.Date" />
									<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="today" />
									<fmt:parseDate var="dateFmt" pattern="yyyy.MM.dd" value="${result.noti_date }"/>
									<fmt:formatDate var="notiDate" pattern="yyyy.MM.dd" value="${dateFmt}" />
									<c:choose>
										<c:when test="${notiDate eq today }">
											&nbsp;&nbsp;<img src="<c:url value='/assets/usr/img/icon-new.png'/>" style="vertical-align:middle;" alt="새글" />
										</c:when> 
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>작성자</th>
								<td><c:out value="${result.noti_writer }"/></td>
								<th>작성일</th>
								<td><c:out value="${result.noti_date }"/></td>
								<th>조회수</th>
								<td><c:out value="${result.noti_stdhit }"/></td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="5">
									<c:out value="${result.noti_content }" escapeXml="false"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<!-- *************************** 모바일 상세 보기 ***************************-->
				<div class="mob">
					<div class="mob-write">
						<ul>
							<li>
								<p class="title">
									<span><c:out value="${result.noti_title }"/></span>
								</p>
								<p class="option">
									<span>작성자 <c:out value="${result.noti_writer }"/></span>
									<span>작성일 <c:out value="${result.noti_date }"/></span>
									<span>조회수 <c:out value="${result.noti_stdhit }"/></span>
								</p>
								<p>
									<c:out value="${result.noti_content }" escapeXml="false"/>
								</p>
							</li>
						</ul>
					</div>
				</div>
<!-- *************************** 웹 첨부파일 ***************************-->
				<p class="sub-title">첨부파일</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>첨부파일</th>
								<td>
									<c:forEach items="${attachList }" var="file" varStatus="status">
									<p class="file-upload">
									<a href="#" onclick="fn_filedownload('<c:out value='${file.attachSeq}'/>','NOTI'); return false;">
										<c:out value="${file.orgFileName }" />
										</a>
										</p>
								   </c:forEach>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
<!-- *************************** 모바일 첨부파일 ***************************-->
				<div class="mob mb20">
					<div class="mob-write">
						<ul>
							<c:forEach items="${attachList }" var="file" varStatus="status">
							<li>
								<p class="file-upload"><a href="#" onclick="fn_filedownload('<c:out value='${file.attachSeq}'/>','NOTI'); return false;">
									<c:out value="${file.orgFileName }" />
										</a>
										</p>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>

				<div class="table-button">
					<div class="btn-box">
						<a href="#" onclick="fn_list(); return false;" class="white btn-list">목록</a>
					</div>
				</div>
			</div>
			</form:form>
		</div>

	</div>
	<!--// contents --> 
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->

</body>
</html>