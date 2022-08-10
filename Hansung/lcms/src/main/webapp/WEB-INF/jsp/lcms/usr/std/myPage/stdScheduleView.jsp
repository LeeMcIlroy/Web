<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
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
		// 바로가기 버튼 이동
		/* onclick="javascript:fn_chg_lect('<c:out value="${lect.lectSeq }"/>', '<c:out value="${lect.lectName }"/>') */
		function fn_lectRoomMove(lectSeq,lectName){
		
			fn_chg_lect(lectSeq,lectName);
		}
		
		function fn_list(pageNo){
			$("#pageIndex").val(pageNo);
			$("#listForm").attr("action", "<c:url value='/usr/std/myPage/stdScheduleView.do'/>").submit();
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
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">수업시간표</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>마이페이지</span>
						<span>수업시간표</span>
					</div>
				</div>
				
					<form:form commandName="searchVO" id="listForm" name="listForm">
				<!-- <input type="hidden" name="noti_seq" id="noti_seq"> -->
				
				<!-- search -->
				<%-- <div class="search-box none-option">
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
										<td>개설학기</td>
										<td>
											<form:select path="searchCondition5"  onchange="fn_list('1')">
												<form:options items="${yearList }"/>
											</form:select>
											<form:select path="searchCondition6" id="semEster" onchange="fn_list('1')">
												<c:forEach items="${semeList }" var="seme">
													<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
												</c:forEach>
											</form:select>
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
										<option>개설학기</option>
										<option>2019</option>
									</select>
									<select class="w49pc-01">
										<option>가을학기</option>
									</select>
								</li>
							</ul>
							<div class="m-search-btn">
								<button type="button" for="sh-op-cl01">검색</button>
							</div>
						</div>
					</div>
					<!--// 모바일 추가 -->
				</div> --%>
				<!--// search -->
<!-- ****************** 학생 지원한 과목 20200325 ******************-->
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-list-table">
						<colgroup>
							<!-- <col style="width:5%;" /> -->
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
								<!-- <th>No.</th> -->
								<th>제목</th>
								<th>분반</th>
								<th>담임</th>
								<th>교사</th>
								<th>강의실</th>
								<th>수강인원</th>
								<th>수업요일</th>
								<th>강의실</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status" >
							<tr>
								<!-- <td><c:out value="${result.rowindex}"/></td> -->
								<td><c:out value="${result.lectName}"/></td>
								<td><c:out value="${result.lectDivi}"/></td>
								<td><c:out value="${result.lectClaTea}"/></td>
								<td><c:out value="${result.lectTea}"/></td>
								<td><c:out value="${result.lectClassroom}"/></td>
								<td><c:out value="${result.lectPer}"/></td>
								<td><c:out value="${result.lectWeek}"/></td>
								<td><a href="#" onclick="fn_lectRoomMove('<c:out value="${result.lectSeq }"/>', '<c:out value="${result.lectName }"/>'); return false;" class="underline">바로가기</a></td>
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
										<span class="title"><a href="#" onclick="fn_lectRoomMove('<c:out value="${result.lectSeq }"/>', '<c:out value="${result.lectName }"/>'); return false;" class="underline"><c:out value="${result.lectName}"/></a></span>
									</p>
									<p class="option">
										<span class="date"><c:out value="${result.lectDivi}"/></span>
										<span class="hit"><c:out value="${result.lectWeek}"/></span>
									</p>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-print">인쇄</button>
					</div>
				</div>
				<!--// table button -->
			</form:form>
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
</body>
</html>