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
		
		function fn_list(pageIndex){
			$("#pageIndex").val(pageIndex);
			$("#listForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/std/myPage/stdDormitoryList.do'/>").submit();
		}


		/* function fn_regist(){
			$("#listForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/std/myPage/stdDormitoryView.do'/>").submit();
		} */
		
	</script>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavStd"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuStd"/>
			<!--// left menu -->
	
	<form:form commandName="searchVO" id="listForm" name="listForm">		
			
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">기숙사</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>마이페이지</span>
						<span>기숙사</span>
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
										<td>개설학기</td>
										<td>
											<form:select path="searchCondition5" onchange="fn_list('1')" >
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
				</div>
				<!--// search -->

			<!--search info-->
				<div class="search-infomation">
					<div class="search-count">
						<strong><c:out value="${paginationInfo.totalRecordCount }" /></strong>건이 검색되었습니다.
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
				<div class="list-table-box web">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:5%;" />
							<col />
							<col />
							<col />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th rowspan="2">No.</th>
								<th rowspan="2">접수번호</th>
								<th rowspan="2">신청구분</th>
								<th rowspan="2">접수일시</th>
								<th colspan="2">기숙사</th>
								<!-- <th colspan="2">형태</th> -->
								<th rowspan="2">상태</th>
							</tr>
							<tr>
								<th>1순위</th>
								<th>2순위</th>
								<!-- <th>1순위</th>
								<th>2순위</th> -->
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td><c:out value="${result.rowindex }" /></td>
								<td><c:out value="${result.dormRecepnum }" /></td>
								<td>
								<c:if test="${result.dormRenewgubun eq '1'}">신입사</c:if>
								<c:if test="${result.dormRenewgubun eq '2'}">재입사</c:if>
								</td>
								<td><c:out value="${result.dormRegistdate }" /></td>
								<td><c:out value="${result.dormDormfirst }" /></td>
								<td><c:out value="${result.dormDormsecond }" /></td>
								<%-- <td><c:out value="${result.dormPerroomfirst }" /></td>
								<td><c:out value="${result.dormPerroomsecond }" /></td> --%>
								<td>
								<c:if test="${result.dormJoinyn eq 'Y'}">입사</c:if>
								<c:if test="${result.dormJoinyn eq 'N'}">신청</c:if>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="mob mb20">
					<div class="mob-list">
						<ul>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<li>
								<p>
									<span class="title"><a href="<c:out value='${pageContext.request.contextPath }/usr/std/myPage/stdDormitoryList.do'/>" class="underline">2019-3-001</a></span>
								</p>
								<p class="option">
									<span class="date">
									<c:if test="${result.dormRenewgubun eq '1'}">신입사</c:if>
								    <c:if test="${result.dormRenewgubun eq '2'}">재입사</c:if>
								    </span>
									<span class="hit">
									<c:if test="${result.dormJoinyn eq 'Y'}">입사</c:if>
								    <c:if test="${result.dormJoinyn eq 'N'}">신청</c:if>
									</span>
								</p>
							</li>
					</c:forEach>		
						</ul>
					</div>
				</div>

				<!-- table button -->
				<!-- <div class="table-button">
					<div class="btn-box">
						<a href="#" onclick="fn_regist(); return false;" class="white btn-newwrite">기숙사입사신청</a>
					</div>
				</div> -->
				<!--// table button -->

				<!-- paging -->
				<div class="paging_wrap">
					<div class="paging">
						
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>

					</div>
				</div>
				<!--// paging -->

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