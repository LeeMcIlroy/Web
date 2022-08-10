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
		
		//리스트로
		function fn_list(pageNo){
			$("#pageIndex").val(pageNo);
			$("#listForm").attr("action", "<c:url value='/usr/lec/myPage/lecScheduleList.do'/>").submit();
		}
		
		// 바로가기 버튼 이동
		/* onclick="javascript:fn_chg_lect('<c:out value="${lect.lectSeq }"/>', '<c:out value="${lect.lectName }"/>') */
		function fn_lectRoomMove(lectSeq,lectName){
		
			fn_chg_lect(lectSeq,lectName);
		}
		
	</script>
<body>

	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">강의시간표</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>마이페이지</span>
						<span>강의시간표</span>
					</div>
				</div>
				
				<form:form commandName="searchVO" id="listForm" name="listForm">
				<!-- <input type="hidden" name="noti_seq" id="noti_seq"> -->
				
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
											<form:select path="searchCondition5" onchange="fn_search_seme(this);">
												<form:options items="${yearList }"/>
											</form:select>
											<form:select path="searchCondition6" id="semEster">
												<c:forEach items="${semeList }" var="seme">
													<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
												</c:forEach>
											</form:select>
										</td>
									</tr>
								</tbody>
							</table>

							<a href="#" onclick="fn_list('1'); return false;">검색하기</a>
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
									<form:select path="searchCondition5" onchange="fn_list(1);" class="w49pc-01">
										<form:options items="${yearList }"/>
									</form:select>
									<form:select path="searchCondition6" class="w49pc-01">
										<c:forEach items="${semeList }" var="seme">
											<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
										</c:forEach>
									</form:select>
								</li>
							</ul>
							<div class="m-search-btn">
								<button type="button" onclick="fn_list('1'); return false;">검색</button>
							</div>
						</div>
					</div>
					<!--// 모바일 추가 -->
				</div>
				<!--// search -->

				<!--search info-->
				<div class="search-infomation">
					<div class="search-count">
						<strong><c:out value="${paginationInfo.totalRecordCount }"/></strong>건이 검색되었습니다.
					</div>
					<div class="paging-select">
						<c:out value="${paginationInfo.currentPageNo }"/> / <c:out value="${totalPageCount }"/>page &nbsp;&nbsp;
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
							<col />
							<%-- <col /> --%>
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>제목</th>
								<th>분반</th>
								<th>담임</th>
								<th>교사</th>
								<th>수강인원</th>
								<th>수업강의실</th>
								<%-- <th>수업요일</th> --%>
								<th>강의실</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
									<td><c:out value="${result.lectName}"/></td>
									<td><c:out value="${result.lectDivi}"/></td>
									<td><c:out value="${result.lectTea}"/></td>
									<td><c:out value="${result.teaGroup}"/></td>
									<td><c:out value="${result.lectPer}"/></td>
									<td><c:out value="${result.lectClassroom}"/></td>
									<%-- <td><c:out value="${result.lectWeek}"/></td> --%>
									<td><a href="#" onclick="fn_lectRoomMove('<c:out value="${result.lectSeq }"/>', '<c:out value="${result.lectName }"/>'); return false;" class="underline">바로가기</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob">
					<div class="mob-list">
						<ul>
						<c:forEach var="result" items="${resultList}" varStatus="status" >
							<li>
								<p onclick="fn_lectRoomMove('<c:out value="${result.lectSeq }"/>', '<c:out value="${result.lectName }"/>'); return false;">
									<span class="title"><c:out value="${result.lectName}"/></span>
								</p>
								<p class="option">
									<span class="croom"><c:out value="${result.lectDivi}"/></span>
									<span class="date"><c:out value="${result.lectClassroom}"/></span>
								</p>
							</li>
						</c:forEach>
						</ul>
					</div>
				</div>
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
				<!-- table -->
				<p class="sub-title">학사일정</p>
				<div class="list-table-box">
					<table class="normal-list-table mob-small">
						<colgroup>
							<col style="width:5%;" />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>주차</th>
								<th>일자</th>
								<th>요일</th>
								<th>학사행사</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${scheList}" varStatus="status" >
							<tr>
								<td><c:out value="${result.monthOfWeek}"/></td>
								<td><c:out value="${result.attDate}"/></td>
								<td><c:out value="${result.dayOfWeek}"/></td>
								<td><c:out value="${result.scheContent}"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<!-- table -->
				<p class="sub-title">수업강의실</p>
				<div class="list-table-box">
					<table class="normal-list-table mob-small">
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
								<th>주차</th>
								<th>일자</th>
								<th>요일</th>
								<th>급반</th>
								<th>강의실</th>
								<th>수업방식</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${clssRoomList}" varStatus="status" >
								<tr>
									<td class="<c:out value='${result.dayOfWeek eq "금"?"bt-black":"" }'/>"><c:out value="${result.monthOfWeek}"/></td>
									<td class="<c:out value='${result.dayOfWeek eq "금"?"bt-black":"" }'/>"><c:out value="${result.attDate}"/></td>
									<td class="<c:out value='${result.dayOfWeek eq "금"?"bt-black":"" }'/>"><c:out value="${result.dayOfWeek}"/></td>
									<td class="<c:out value='${result.dayOfWeek eq "금"?"bt-black":"" }'/>"><c:out value="${result.lectName}"/>&nbsp;<c:out value="${result.lectDivi}"/></td>
									<td class="<c:out value='${result.dayOfWeek eq "금"?"bt-black":"" }'/>"><c:out value="${result.clssRoom}"/></td>
									<td class="<c:out value='${result.dayOfWeek eq "금"?"bt-black":"" }'/>"><c:out value="${result.clssType}"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
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