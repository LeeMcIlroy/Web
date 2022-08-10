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
		            <jsp:param name="dept2" value="총장인사말"/>
	           	</jsp:include>
	           	<div class="pg_box">
					<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/pg_img.jpg'/>" alt="사진 : 한성대학교 총창 이 상 한" />
					<span>
						<p>“지식을 창조적으로 발전시켜나가는<br>전문가가 주역이 됩니다”</p>
						21세기는 세계가 하나로 통합되는 사회이며, 지식이 융합되고 합성되는 사회입니다.<br>
						지식을 창조적으로 발전시켜 나가는 전문가가 주역이 되는 세계이며, 공동체를 생각하는 통합적 리더십이 가치를 발휘하는 시대입니다.<br>
						사람들의 생각은 다양하고 세상을 바라보는 시각도 각기 다릅니다.<br>
						위대한 일은 작은 열정에서부터 시작됩니다.<br>
						무엇을 보고 무엇을 위해 살아가느냐에 따라서 삶의 모습도 결정되는 것입니다.<br><br>
	
						여러분이 보는 세상은 따뜻했으면 좋겠습니다.<br>
						열매를 향한 시도는 언제라도 설렙니다.<br>
						봄은 꽃의 계절이 아니라 씨앗의 계절입니다.<br>
						어린 아이가 탄생하는 것과 같이 역사는 언제나 봄의 그 현장에서 시작됩니다.<br>
						매년 어김없이 봄이 시작됩니다.<br>
						우리 마음에도 새 봄이 시작되어 좌절했던 모든 마음들이 기지개를 켜고 일어날 것입니다.<br>
						여러분 인생의 아름다운 봄을 한성대학교와 함께 펼쳐 나가시길 바랍니다.
						<div class="name">한성대학교 총장 이 상 한</div>
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