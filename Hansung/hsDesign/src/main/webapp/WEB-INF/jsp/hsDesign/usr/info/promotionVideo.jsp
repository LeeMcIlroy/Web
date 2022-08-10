<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<form id="frm" name="frm">
<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd>
			<a href="#content">본문 바로가기</a>
		</dd>
		<dd>
			<a href="#top_menu">메뉴 바로가기</a>
		</dd>
		<dd>
			<a href="#footer">페이지 하단 바로가기</a>
		</dd>
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
				<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
				<!--// lnb -->
				<!-- content -->
				<div class="sub_content">
					<!-- 타이틀 영역 -->
					<jsp:include
						page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
						<jsp:param name="dept1" value="캠퍼스생활" />
						<jsp:param name="dept2" value="해외프로그램" />
					</jsp:include>
					<iframe src="https://www.youtube.com/embed/cgQ_83wv1Tc" frameborder="0" allowfullscreen class="m_frame"></iframe>
					<iframe src="https://www.youtube.com/embed/O08-6HtBUwU" frameborder="0" allowfullscreen class="m_frame"></iframe>
					<iframe src="https://www.youtube.com/embed/jYLzQyRns4c" frameborder="0" allowfullscreen class="m_frame"></iframe>
					<iframe src="https://www.youtube.com/embed/VK5RHA2lK7U?rel=0" frameborder="0" allowfullscreen class="m_frame"></iframe>
					<iframe src="https://www.youtube.com/embed/4FconY0mcZM?rel=0" frameborder="0" allowfullscreen class="m_frame"></iframe>
					<!-- <iframe src="https://www.youtube.com/embed/e-r_ZSWnsN4?rel=0" frameborder="0" allowfullscreen class="m_frame"></iframe> -->
					<iframe src="https://www.youtube.com/embed/1DH0L557H24?rel=0" frameborder="0" allowfullscreen class="m_frame"></iframe>
					<iframe src="https://www.youtube.com/embed/m8UQHTK0uTQ?rel=0" frameborder="0" allowfullscreen class="m_frame"></iframe>
					<!-- <iframe src="https://www.youtube.com/embed/bhoOmZhyKj0?rel=0" frameborder="0" allowfullscreen class="m_frame"></iframe> -->
				</div>	
				<!--// content -->
			</div>
		</div>
		<!--// container -->
		<hr />
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!--// footer -->
	</div>
	<input type="hidden" id="message" value="${message}" />
</form>
</body>
</html>