<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%@ page import="egovframework.rte.psl.dataaccess.util.EgovMap" %>
<%@ page import="lcms.valueObject.UsrVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%
	String lecMenuNo = ((String)session.getAttribute("lecMenuNo")!=null)?(String)session.getAttribute("lecMenuNo"):"";
	UsrVO usrVO = ((UsrVO)session.getAttribute("usrSession")!=null)?(UsrVO)session.getAttribute("usrSession"):null;
	String selLectName = (String)session.getAttribute("selLectName")!=null?(String)session.getAttribute("selLectName"):"";
	EgovMap lecSession = (EgovMap)session.getAttribute("lecSession");
	String lectSemNm = (((String)lecSession.get("lectSem")).equals("1")?"봄학기":((String)lecSession.get("lectSem")).equals("2")?"여름학기":((String)lecSession.get("lectSem")).equals("3")?"가을학기":"겨울학기");
	String lectSemYear = (((String)lecSession.get("lectYear")));
%>
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
		$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/clss/lecClssNoticeList.do'/>").submit();
	}
	
	function fn_select(lcnotiSeq){
	 	$("#lcnotiSeq").val(lcnotiSeq);
		$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/clss/lecClssNoticeView.do'/>").submit();
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<form:form commandName="lecClssNoticeVO" id="listForm" name="listForm">
	<input type="hidden" name="lcnotiSeq" id="lcnotiSeq"/>
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
												<option><%=lectSemYear %></option>
											</select>
											<select>
												<option><%=lectSemNm %></option>
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
										<option value="2020" <c:if test="${lectSemYear eq '2020'}">selected="selected"</c:if>>2020</option>
										<option value="2019" <c:if test="${lectSemYear eq '2019'}">selected="selected"</c:if>>2019</option>
										<option value="2018" <c:if test="${lectSemYear eq '2018'}">selected="selected"</c:if>>2018</option>
										<option value="2017" <c:if test="${lectSemYear eq '2017'}">selected="selected"</c:if>>2017</option>
									</select>
									<select class="w49pc-01">
										<option value="봄학기" <c:if test="${lectSemNm eq '봄학기'}">selected="selected"</c:if>>봄학기</option>
										<option value="여름학기" <c:if test="${lectSemNm eq '여름학기'}">selected="selected"</c:if>>여름학기</option>
										<option value="가을학기" <c:if test="${lectSemNm eq '가을학기'}">selected="selected"</c:if>>가을학기</option>
										<option value="겨울학기" <c:if test="${lectSemNm eq '겨울학기'}">selected="selected"</c:if>>겨울학기</option>
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
							<col style="width:5%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>제목</th>
								<th>첨부</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<tr>
									<td>
										<c:if test="${result.lcnotiTop eq 'Y'}">
											<span class="icon-notice">공지</span>
										</c:if>
										<c:if test="${result.lcnotiTop eq 'N'}">
											<c:out value="${paginationInfo.totalRecordCount+1 - ((lecClssNoticeVO.pageIndex-1) * 10 + status.count)}"/>
										</c:if>
									</td>
									<td class="txt-l">
										<a href="#" onclick="fn_select('<c:out value="${result.lcnotiSeq}"/>'); return false;" class="underline" >
											<c:out value="${result.lcnotiTitle}"/>
										</a>
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
										<c:choose>
										<c:when test="${result.lcnotiDate eq today }">
											&nbsp;&nbsp;<img src="<c:url value='/assets/usr/img/icon-new.png'/>" style="vertical-align:middle;" alt="새글" />
										</c:when> 
										<c:otherwise>
												&nbsp;
										</c:otherwise>
									</c:choose>
									</td>
									<td>
									<c:if test="${result.filecount > 0}">
									<img src="<c:url value='/assets/usr/img/icon-download-file.png'/>" style="vertical-align:middle; width: 10px; height: 10px;" alt="첨부파일" />
									</c:if>
									</td>
									<td><c:out value="${result.lcnotiWriter}"/></td>
									<td>
										<c:out value="${result.lcnotiDate }"/>
									</td>
									<td><c:out value="${result.lcnotiHit}"/></td>
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
										<span class="title">
											<a href="#" onclick="fn_select('<c:out value="${result.lcnotiSeq}"/>'); return false;" class="underline">
												${result.lcnotiTitle}
											</a>
										</span>
									</p>
									<p class="option">
										<span class="date"><c:out value="${result.lcnotiDate }"/></span>
									</p>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>


				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssNoticeModify.do'/>" class="white btn-newwrite sem-chk">공지등록</a>
					</div>
				</div>
				<!--// table button -->

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

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
	</form:form>
</body>
</html>