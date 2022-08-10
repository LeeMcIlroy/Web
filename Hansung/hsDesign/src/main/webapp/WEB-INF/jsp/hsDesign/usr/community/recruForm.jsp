<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<!-- 입사지원서 양식 메뉴 추가 2021.05.14 반영전 -->
<body>
	<form:form commandName="searchVO" id="frm" name="frm">
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
			<!-- header area -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
			<!-- //header area -->
			<div class="main_content" id="content">
				<div class="width_box">
					<!-- left menu area-->
					<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
					<!-- //left menu area-->
					<div class="sub_content">
						<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">
							<c:param name="dept1" value="취업센터" />
							<c:param name="dept2" value="입사지원서양식" />
						</c:import>

						<div class="s_tit">입사지원사양식</div>
						<div class="sub_cont_box">
							<div class="emp_icon">
								<img alt="입사지원서양식가이드1" src="/assets/usr/img/emp_img.jpg">
							</div>
							<div class="emp_icon">
								<img alt="입사지원서양식가이드2" src="/assets/usr/img/emp_img.jpg">
							</div>
							<div class="emp_icon">
								<img alt="입사지원서양식가이드3" src="/assets/usr/img/emp_img.jpg">
							</div>
							<div class="emp_icon">
								<img alt="입사지원서양식가이드4" src="/assets/usr/img/emp_img.jpg">
							</div>
						</div>
						<!-- 다운로드 버튼이 위치 합니다. -->
						<div class="btn_box txt_left">
				            <a href="assets/usr/file/2.입사지원서 AI.ai" class="btn_go_write">입사지원서 AI</a>
				            <a href="assets/usr/file/3.입사지원서 PDF.pdf" class="btn_go_write">입사지원서PDF</a>
				            <a href="assets/usr/file/4.입사지원서 PPT.zip" class="btn_go_write">입사지원서PPT</a>
				        </div>
					</div>
				</div>
				<div class="go_top">
					<a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a>
				</div>
			</div>
			<!-- footer -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
			<!-- //footer -->
		</div>
		<input type="hidden" id="message" value="${message}" />
	</form:form>
</body>
</html>