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
		            <jsp:param name="dept2" value="원장인사말"/>
	           	</jsp:include>
	           	<div class="pg_box">
					<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/dg_img.jpg'/>" alt="사진 : 한성대학교 원장 한 혜 련" />
					<span>
						<p>“디자인과 예술의 중심!<br>한디원에서 여러분의 주인공이 되십시오!”</p>
						디자인과 아트 전공의 특성화 된 교육으로 최고의 명성과 위상을 추구하는 서울의 센터 한성대학교 한디원에 오신 것을 환영합니다.<br>
						한디원은 한성대학교에서 운영하는 디자인 특성화 교육기관입니다.<br>
						학교와 산업체 등 교육의 수요자 중심으로 한 실무적 커리큘럼과 철저한 교육관리로 최고의 인재를 양성합니다. 현장중심 실무전문가, 기업 CEO 등 산업현장에서 뛰는 열정적인 교수님들을 초빙하여 학생들에게 이론적인 학문은 물론 넓은 디자인 세계를 경험하게 하는 체험 교육을 시행하고 있습니다.<br><br>
	
						한성대학교 한디원은 1997년 설립 이래, 2001년 교육인적자원부 학습과목 개설을 시작으로 2006년 국내  최초로 디자인분야의 단위전공인 실내디자인전공이 개설되었습니다. 현재 실내디자인, 시각디자인학, 산업디자인, 디지털아트학, 패션디자인학, 패션비즈니스학, 미용학이 학위과정으로 운영되고 있으며,<br>
						비학위과정인 전문가 및 교양과정이 디자인과 아트 전반에 특화된 열린 교육으로 그 가치를 실현하고 있습니다.<br>
						무한한 창의적 가능성을 실현할 수 있는 곳! 이곳이 바로 한성대학교 한디원입니다.<br>
						여러분 미래의 꿈을 함께 만들어가는 동반자가 되겠습니다.
						<div class="name">한성대학교 부설 디자인아트교육원 원장 한 혜 련</div>
					</span>
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