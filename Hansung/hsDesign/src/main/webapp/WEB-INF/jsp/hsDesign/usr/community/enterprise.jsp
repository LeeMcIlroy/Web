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
						<jsp:param name="dept1" value="취업센터" />
						<jsp:param name="dept2" value="함께하는기업들" />
					</jsp:include>
					
					<div class="sub_cont_box">
						<dl class="info_dl">
							<dt></dt>
							<dd>
	
								<div class="partner_info">
									<img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_list.jpg'/>" alt="함께하는 기업들" />	
								</div>
								
							</dd>
						</dl>
					</div>
					<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
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