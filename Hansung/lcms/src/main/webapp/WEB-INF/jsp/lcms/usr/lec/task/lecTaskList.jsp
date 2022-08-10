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
		
		function fn_list(pageNo){
			$("#pageIndex").val(pageNo);
			$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/task/lecTaskList.do'/>").submit();
		}
		
		function fn_view(taskSeq){
		 	$("#taskSeq").val(taskSeq);
			$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/task/lecTaskView.do'/>").submit();
		}

		function fn_modify(taskSeq){
		 	$("#taskSeq").val(taskSeq);
			$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/task/lecTaskModify.do'/>").submit();
		}
	</script>
<body>
	<form:form commandName="searchVO" id="listForm" name="listForm">
	<input type="hidden" name="taskSeq" id="taskSeq"/>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">과제게시판</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>과제</span>
						<span>과제게시판</span>
					</div>
				</div>
				<!-- search -->
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search web"><!-- 모바일 수정 -->
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
											<select>
												<option><c:out value="${semester.semYear }"/></option>
											</select>
											<select>
												<option><c:out value="${semester.semeNm }"/></option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>

							<a href="#">검색하기</a>
						</div>
					</div>
					<!-- 모바일 추가 -->
					<input type="checkbox" id="sh-op-cl01" class="hidden" />
					<div class="m-search-btn mob">
						<label for="sh-op-cl01">검색</label>
					</div>
					<div class="m-search mob">
						<div class="m-search-tit">
							<p>검색</p>
							<label for="sh-op-cl01" class="icon-pop-close">검색닫기</label>
						</div>
						<div class="w100-sh">
							<ul>
								<li>
									<select class="w49pc-01">
										<option><c:out value="${semester.semYear }"/></option>
									</select>
									<select class="w49pc-01">
										<option><c:out value="${semester.semeNm }"/></option>
									</select>
								</li>
							</ul>
						</div>
					</div>
					<!--// 모바일 추가 -->
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
				<div class="list-table-box web">
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
								<th>No.</th>
								<th>제목</th>
								<th>제출시작</th>
								<th>제출마감</th>
								<th>형태</th>
								<th>제출인원</th>
								<th>조회</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td class="txt-l">
										<a href="#" class="underline" onclick="fn_view('<c:out value="${result.taskSeq }"/>'); return false;">
											<c:out value="${result.taskNm }"/>
										</a>
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="today" />
										<fmt:parseNumber value="${today}" integerOnly="true" var="todayNum"/>
										<fmt:formatDate value="${result.regDate}" pattern="yyyyMMdd" var="rgDate"/>
										<fmt:parseNumber value="${rgDate}" integerOnly="true" var="rgDateNum"/>
										<c:choose>
											<c:when test="${(todayNum - rgDateNum) < 7 }">
												&nbsp;&nbsp;<img src="<c:url value='/assets/usr/img/icon-new.png'/>" style="vertical-align:middle;" alt="새글" />
											</c:when> 
											<c:otherwise>
													&nbsp;
											</c:otherwise>
										</c:choose>
									</td>
									<td><c:out value="${result.taskSdate }"/> <c:out value="${result.taskSdateT }"/>:<c:out value="${result.taskSdateM }"/></td>
									<td><c:out value="${result.taskEdate }"/> <c:out value="${result.taskEdateT }"/>:<c:out value="${result.taskEdateM }"/></td>
									<td>
										<c:choose>
											<c:when test="${result.taskYn eq 'Y'}">공개</c:when>
											<c:when test="${result.taskYn eq 'N'}">비공개</c:when>
										</c:choose>
									</td>
									<td><c:out value="${result.taskResultCnt }"/>/<c:out value="${result.taskAllCnt }"/>(<fmt:formatNumber value="${result.taskResultCnt eq '0'?'0':(result.taskResultCnt/result.taskAllCnt)*100 }" pattern="0"/>%)</td>
									<td><c:out value="${result.taskHit }"/></td>
									<td><c:out value="${result.taskStatus }"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-list">
						<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<li>
									<p>
										<span class="title"><a href="#" class="underline" onclick="fn_view('<c:out value="${result.taskSeq }"/>'); return false;"><c:out value="${result.taskNm }"/></a></span>
									</p>
									<p class="option">
										<span class="date"><c:out value="${result.taskStatus }"/></span>
									</p>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/task/lecTaskModify.do'/>" class="white btn-newwrite sem-chk">과제출제</a>
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
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>">
	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
	</form:form>
</body>
</html>