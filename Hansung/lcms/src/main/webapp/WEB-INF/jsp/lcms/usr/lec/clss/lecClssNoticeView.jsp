<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 		uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"			uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		
		function edit(){
			$("#detailForm").attr("action", "<c:url value='/usr/lec/clss/lecClssNoticeModify.do'/>").submit();
		}

		function del(){
			if(confirm('삭제 하시겠습니까?')){
			$("#detailForm").attr("action", "<c:url value='/usr/lec/clss/lecClssNoticeDelete.do'/>").submit();
			}
		}
				
		
		//파일 다운로드
		function fn_filedownload(geupSeq, type){
			location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+geupSeq+"&type="+type;
		}
	</script>
<body>
<form:form commandName="lecClssNoticeVO" id="detailForm" name="detailForm" method="post">
<form:hidden path="lcnotiSeq" value="${result.lcnotiSeq }"/>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">강의공지</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>강의공지</span>
					</div>
				</div>

				<p class="sub-title">공지내용</p>
				<!-- table -->
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
									<c:out value="${result.lcnotiTitle }" />&nbsp;&nbsp;
										<jsp:useBean id="now" class="java.util.Date" />
									<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
									<fmt:parseDate var="dateFmt" pattern="yyyy.MM.dd HH:mm:ss" value="${result.lcnotiDate }"/>
									<fmt:formatDate var="lcnotiDate" pattern="yyyy-MM-dd" value="${dateFmt}" />
									<c:choose>
										<c:when test="${lcnotiDate eq today }">
											&nbsp;&nbsp;<img src="<c:url value='/assets/usr/img/icon-new.png'/>" style="vertical-align:middle;" alt="새글" />
										</c:when> 
										<c:otherwise>
												&nbsp;
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>작성자</th>
								<td><c:out value="${result.lcnotiWriter }" /></td>
								<th>작성일</th>
								<td><c:out value="${result.lcnotiDate }" /></td>
								<th>조회수</th>
								<td><c:out value="${result.lcnotiHit }" /></td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="5">
								<c:out value="${result.lcnotiContent }" escapeXml="false" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>제목</dt>
							<dd>
								<ul>
									<li>
										<c:out value="${result.lcnotiTitle }" />&nbsp;&nbsp;
									<c:choose>
										<c:when test="${lcnotiDate eq today }">
											&nbsp;&nbsp;<img src="<c:url value='/assets/usr/img/icon-new.png'/>" style="vertical-align:middle;" alt="새글" />
										</c:when> 
										<c:otherwise>
												&nbsp;
										</c:otherwise>
									</c:choose>
									</li>
								</ul>
							</dd>
						</dl>
						<dl>
							<dt>작성자</dt>
							<dd>
								<c:out value="${result.lcnotiWriter }" />
							</dd>
						</dl>
						<dl>
							<dt>작성일자</dt>
							<dd><c:out value="${result.lcnotiDate }" /></dd>
						</dl>
						<dl>
							<dt>조회수</dt>
							<dd><c:out value="${result.lcnotiHit }" /></dd>
						</dl>
						<dl>
							<!-- <dt>내용</dt>
							<dd> -->
								<c:out value="${result.lcnotiContent }" escapeXml="false" />
							<!-- </dd> -->
						</dl>
					</div>
				</div>

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
								<th>첨부파일</th>
								<td>
									<c:forEach items="${attachList }" var="attach">
										<p class="file-upload">
											<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>">
												<c:out value="${attach.orgFileName }"/>
											</a>
												<input type="hidden" id="deleteFile" name="deleteFile" value='<c:out value="${attach.attachSeq }"></c:out>'/>
										</p>
									</c:forEach>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>첨부파일</dt>
								<dd>
									<ul>
										<li>
											<c:forEach items="${attachList }" var="attach">
												<p class="file-upload">
													<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>">
														<c:out value="${attach.orgFileName }"/>
													</a>
												<input type="hidden" id="deleteFile" name="deleteFile" value='<c:out value="${attach.attachSeq }"></c:out>'/>
												</p>
											</c:forEach>
									</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>

				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssNoticeList.do'/>" class="white btn-list">목록</a>
						<a href="#" onclick="edit()" class="white btn-newwrite sem-chk">수정</a>
						<a href="#" onclick="del()" class="white btn-del sem-chk">삭제</a>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
</form:form>
</body>
</html> 