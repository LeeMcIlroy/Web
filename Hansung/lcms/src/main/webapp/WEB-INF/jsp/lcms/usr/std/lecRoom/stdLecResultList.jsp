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
					<p class="page-lv01">출결/성적</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>출결/성적</span>
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
							<div class="m-search-btn">
								<button type="button">검색</button>
							</div>
						</div>
					</div>
					<!--// 모바일 추가 -->
				</div>
				<!--// search -->

				<p class="sub-title">출석현황</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:25%;" />
							<col style="width:25%;" />
							<col style="width:25%;" />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>현재수업시간</th>
								<th>출석시간</th>
								<th>결석시간</th>
								<th>현재출석율(%)</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><c:out value="${attend.total }"/></td>
								<td><c:out value="${attend.attend }"/></td>
								<td><c:out value="${attend.absent }"/></td>
								<td><c:out value="${attend.rate }"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>현재수업시간</dt>
							<dd><c:out value="${attend.total }"/></dd>
						</dl>
						<dl>
							<dt>출석시간</dt>
							<dd><c:out value="${attend.attend }"/></dd>
						</dl>
						<dl>
							<dt>결석시간</dt>
							<dd><c:out value="${attend.absent }"/></dd>
						</dl>
						<dl>
							<dt>현재출석율(%)</dt>
							<dd><c:out value="${attend.rate }"/></dd>
						</dl>
					</div>
				</div>
				<c:if test="${lecSession.admisYn eq 'Y' }">
				<p class="sub-title">성적현황</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col />
							<col />
							<col />
							<col />
							<col style="width:8%;" />
						</colgroup>
						<thead>
							<tr>
								<th colspan="4">영역별평균</th>
								<th rowspan="3">평균</th>
							</tr>
							<tr>
								<th colspan="2">표현능력</th>
								<th colspan="2">이해능력</th>
							</tr>
							<tr>
								<th>말하기</th>
								<th>쓰기</th>
								<th>듣기</th>
								<th>읽기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="<c:out value="${grade.avgSpeak < 60?'color:#fc6039':'' }"/>"><c:out value="${grade.avgSpeak }"/></td>
								<td style="<c:out value="${grade.avgWrite < 60?'color:#fc6039':'' }"/>"><c:out value="${grade.avgWrite }"/></td>
								<td style="<c:out value="${grade.avgListen < 60?'color:#fc6039':'' }"/>"><c:out value="${grade.avgListen }"/></td>
								<td style="<c:out value="${grade.avgRead < 60?'color:#fc6039':'' }"/>"><c:out value="${grade.avgRead }"/></td>
								<td style="<c:out value="${grade.avgTotal < 70?'color:#fc6039':'' }"/>"><c:out value="${grade.avgTotal }"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				</c:if>
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