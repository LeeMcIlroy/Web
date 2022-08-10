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
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle2.jsp">
					<jsp:param name="dept1" value="일학습엘리트과정"/>
		            <jsp:param name="dept2" value="성우콘텐츠크리에이터"/>
		            <jsp:param name="dept3" value="전공안내"/>
	           	</jsp:include>
				<div class="sub_cont_page">
					<dl class="info_dl">
						<dd>
							<p><strong>직업분야개요</strong></p>
                            <p>목소리(voice)는 개인의 개성을 나타내는 동시에 하나의 콘텐츠이다. 4차산업 물결 속에서 사람만이 가지고 있는 감정이 포함 된 Voice 콘텐츠는 그래서 더욱 중요하게 평가된다. 한성대학교 한디원은 4차산업시대에 맞는 직업군을 창출하고 자아실현을 위한 사회가 원하는 직업인으로 양성하기 위하여 본 직업분야교육 과정을 개설하였다.</p>
						</dd>
						<dd>
							<p><strong>커리큘럼 소개</strong></p>
                            <p>본 커리큘럼은 Voice를 중심으로 다양한 미디어와 결합한 새로운 직업분야 교육을 목표로 하고 있다.</p>
                            <p>성우뿐 아니라 Voice 더빙, 1인 미디어(MCN), 애니메이션 크리에이터, 게임 Voice, 영상편집, 영상촬영방법, 애니메이션제작 및 연기에 이르기까지 매체와 융합한 새로운 voice콘텐츠를 창출하기 위한 미래 지향적인 교육과정으로 구성되어 있다.</p>
                            <p>본 과정을 이수하게 되면 다양한 매체를 통한 voice 콘텐츠를 전문가 수준까지 제작할 수 있도록 사)한국성우협회와 애니메이션전문가, CG전문가, 특수영상콘텐츠 전문가들로 교수진이 구성되어 있다. </p>
						</dd>
					</dl>
					<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_voice_02_1.png'/>" />
					<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_voice_02_2.jpg'/>" />
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