<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="pageIndex"/>
<form:hidden path="searchType"/>
<form:hidden path="menuType"/>
<form:hidden path="searchCondition2"/>
<form:hidden path="searchWord"/>
<input type="hidden" id="mbSeq" name="mbSeq">
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
			<!-- content -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="전공"/>
		            <jsp:param name="dept2" value="2+2본교연계과정"/>
	           	</jsp:include>
				
				<div class="sub_cont_page">
					
				<!-- 		<p class="area_info">
							한성대학교는 ‘진리(眞理)ㆍ지선(至善)’이라는 교육이념을 바탕으로 공동선(公同善)을 추구하는 창조적 인재를 양성하는데 교육목적을 두고 있다. 산업교육을 진흥하고, 산학협력을 촉진함으로써 산업사회의 요구에 부응하는 창의력있는 산업인력을 양성한다. 
							산업발전에 필요한 새로운 지식과 기술을 개발, 보급하여 산업사회 발전에 이바지하며, 21세기 세계화 시대에 부응하는 실무중심의 현장인력 재교육으로 전문 인력을 양성한다.산업체 수요에 의한 맞춤형 직업교육 체제(Work to School)를 대학교육과정에 도입하여, 
							실무가 가능한 인재양성에 대한 대학의 역할 및 산업체 등의 수요에 대한 맞춤형으로 구성되어 있다.					
						</p> -->
					
				<!-- 	<div class="s_tit">진출분야</div>
					<p class="area_info">
						헤어디자이너, 메이크업, 에스테틱, 네일, 특수분장
					</p>
						 -->
						<img src="${pageContext.request.contextPath }/assets/usr/img/course/courseInfo_01.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/course/courseInfo_02.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/course/courseInfo_03.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/course/courseInfo_04.png" style="width: 100%;"/>				
						<img src="${pageContext.request.contextPath }/assets/usr/img/course/courseInfo_05.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/course/courseInfo_06.png" style="width: 100%;"/>
						
				
				
				</div>
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
</form:form>
</body>
</html>