<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
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
	
	function fn_open(){
		var surveySeq = $("#language").val();
		window.open("<c:out value='${pageContext.request.contextPath }/usr/std/lecRoom/stdLecEvalModify.do?'/>surveySeq="+surveySeq
				, '수업만족도', 'width=600, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_view(){
		window.open("<c:out value='${pageContext.request.contextPath }/usr/std/lecRoom/stdLecEvalView.do?'/>"
				, '수업만족도', 'width=600, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
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
					<p class="page-lv01">수업만족도</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업만족도</span>
					</div>
				</div>
				<form:form commandName="searchVO" id="frm" name="frm">
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
							<div class="m-search-btn">
								<label for="sh-op-cl01">검색</label>
							</div>
						</div>
					</div>
					<!--// 모바일 추가 -->
				</div>
				<!--// search -->

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
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>담당교사</th>
								<th>제출시작</th>
								<th>제출마감</th>
								<th>제출여부</th>
								<th>제출일시</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="sDate" value=""/>
							<c:set var="eDate" value=""/>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<c:set var="sDate" value="${result.valSub1 }"/>
								<c:set var="eDate" value="${result.valSub2 }"/>
								<c:set var="answYn" value="${result.answYn }"/>
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td class="txt-l"><c:out value="${result.profName }"/></td>
									<td><c:out value="${result.valuationS }"/></td>
									<td><c:out value="${result.valuationE }"/></td>
									<td>
										<c:if test="${result.answYn eq 'Y' }">
											<label class="underline imgSelect" onclick="fn_view(); return false;">제출</label>
										</c:if>
										<c:if test="${result.answYn eq 'N' }">
											미제출
										</c:if>
									</td>
									<td><c:out value="${result.regDate }"/></td>
								</tr>
							</c:forEach>
							<c:if test="${resultList.size() == 0 }">
								<tr>
									<td colspan="6">조회된 내용이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-list">
						<ul>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<li>
									<p>
										<span class="title"><c:out value="${result.profName }"/></span>
									</p>
									<p class="option">
										<span class="date">
											<c:if test="${result.answYn eq 'Y' }">
												<label class="underline imgSelect" onclick="fn_view(); return false;">제출</label>
											</c:if>
											<c:if test="${result.answYn eq 'N' }">
												미제출
											</c:if>
										</span>
										<span class="hit"><c:out value="${result.regDate }"/></span>
									</p>
								</li>
							</c:forEach>
							<c:if test="${resultList.size() == 0 }">
								<p>
									<span class="title">조회된 내용이 없습니다.</span>
								</p>
							</c:if>
						</ul>
					</div>
				</div>

				<div class="table-button">
					<div class="btn-box">
						<jsp:useBean id="now" class="java.util.Date" />
						<fmt:formatDate value="${now}" pattern="yyyyMMddHHmm" var="today" />
						<fmt:parseNumber value="${today}" integerOnly="true" var="todayNum"  />
						<fmt:parseNumber value="${sDate.replaceAll('-','')}" integerOnly="true" var="sDateNum"/>
						<fmt:parseNumber value="${eDate.replaceAll('-','')}" integerOnly="true" var="eDateNum"/>
					
						<c:if test="${sDateNum <= today && today <= eDateNum && answYn ne 'Y' }">
							<label for="modi-pop" class="white btn-newwrite">수업만족도제출</label>
						</c:if>
					</div>
				</div>
				</form:form>
			</div>
		</div>
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:300px; height:150px; top:50%; left:50%; margin-left:-150px; margin-top:-75px;">
			<div class="list-table-box">
				<table class="normal-wmv-table">
					<colgroup>
						<col style="width:40%;">
						<col >
					</colgroup>
					<tbody>
						<tr>
							<th>언어 (Language)</th>
							<td>
								<select id="language">
									<c:forEach items="${langList }" var="lang">
										<option value="<c:out value='${lang.surveySeq }'/>"><c:out value="${lang.lang }"/></option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="table-button">
				<div class="btn-box">
					<label for="modi-pop" class="white btn-save" onclick="fn_open();">확인</label>
					<label for="modi-pop" class="white btn-cancel">취소</label>
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

</body>
</html>