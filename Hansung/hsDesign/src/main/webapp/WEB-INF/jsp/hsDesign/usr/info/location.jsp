<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<style>
.embed-container { 
	position: relative; 
	padding-bottom: 56.25%; 
	height: 0; 
	overflow: hidden; 
	max-width: 100%; 
} 
.embed-container iframe, .embed-container object, .embed-container embed { 
	position: absolute; 
	top: 0; 
	left: 0; 
	width: 100%; 
	height: 100%; 
}
</style>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<form id="frm" name="frm">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<!-- container -->
	<div class="main_content" id="content">
		<div class="width_box">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
			<!--// lnb -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="한디원소개"/>
		            <jsp:param name="dept2" value="오시는길"/>
	           	</jsp:include>
	           	<div class="location_box">
					<!-- <div class='embed-container'> -->
					<div>
						<!-- <iframe src='https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3161.866733793964!2d127.0081661154284!3d37.58175567979515!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca332d82a4b69%3A0x6fab1f41f290b960!2z7ZWc7ISx64yA7ZWZ6rWQ!5e0!3m2!1sko!2suk!4v1499932349498' width='600' height='450' frameborder='0' style='border:0' allowfullscreen></iframe> -->
						<img src="${pageContext.request.contextPath }/assets/usr/img/location_map.gif" alt="한성대입구역 2번 출구에서 좌측으로 가다가 우측 길 나오면 우측으로 직진" style="width:100%;"/>
					</div>
					<ul class="line4" style="margin-top:30px;">
						<li>4호선</li>
						<li>한성대입구역</li>
						<li class="location_info">
							마을버스 : 한성대입구역 2번출구 – 한성대학교행 02번 마을버스 이용 (5분거리)<br>
							도보 : 한성대입구역 2번출구 – 도보 10분 ~ 15분 거리<br>
							스쿨버스 : 한성대입구역 1, 2번출구
						</li>
					</ul>
					<ul class="line6">
						<li>6호선</li>
						<li>창신역</li>
						<li class="location_info">
							4번 출구 낙산행 마을버스(03번) 이용 (5분 거리) (쌍용아파트 입구에서 하차 후 한성대 남문 진입)
						</li>
					</ul>
					<ul class="line1 n_dd">
						<li>1호선</li>
						<li>동대문역</li>
					</ul>
					<ul class="line4">
						<li>4호선</li>
						<li>동대문역</li>
						<li class="location_info">
							5번 출구 낙산행 마을버스(03번) 이용 (20분 거리) (쌍용아파트 입구에서 하차 후 한성대 남문 진입)
						</li>
					</ul>
					<ul class="line1 n_dd">
						<li>1호선</li>
						<li>동묘앞</li>
					</ul>
					<ul class="line6">
						<li>6호선</li>
						<li>동묘앞</li>
						<li class="location_info">
							10번 출구 낙산행 마을버스(03번) 이용 (10분 거리) (쌍용아파트 입구에서 하차 후 한성대 남문 진입)<br>
							기타 차량 운행과 관련한 문의는 총무인사팀(760-4231)으로 전화주시기 바랍니다.
						</li>
					</ul>	
				</div>							
				<!-- rolling banner -->
				<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
				<!-- //rolling banner -->
				<!-- //content -->
			</div>
		</div>
		<!-- content -->
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
</form>
</body>
</html>