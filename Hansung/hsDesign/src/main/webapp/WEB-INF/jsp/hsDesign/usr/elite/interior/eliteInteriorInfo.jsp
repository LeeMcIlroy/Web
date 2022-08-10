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
			
				<!-- sns -->
				<%-- 
				<div class="top_sns">
					<ul>
						<li><a href="<c:url value='http://cafe.naver.com/edubankhs'/>" title="[새창] 네이버 블로그 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_n.jpg'/>" alt="네이버 블로그" /></a></li>
						<li><a href="<c:url value='https://www.facebook.com/hansungart'/>" title="[새창] 페이스북 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_f.jpg'/>" alt="페이스북" /></a></li>
						<li><a href="<c:url value='https://www.youtube.com/channel/UCnb-63kSFrD6o84QfIKt2SQ'/>" title="[새창] 유튜브 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_y.jpg'/>" alt="유투브" /></a></li>
					</ul>
				</div>
				 --%>
				<!-- //sns -->
				
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle2.jsp">
					<jsp:param name="dept1" value="일학습엘리트과정"/>
		            <jsp:param name="dept2" value="타일디자인시공"/>
		            <jsp:param name="dept3" value="전공안내"/>
	           	</jsp:include>
				<div class="sub_cont_page">
					<dl class="info_dl">
						<dd>
							<p><strong>실내디자인전공 "타일디자인 시공 전문가" 직업분야 소개</strong></p>
							<p>100세 시대를 앞에 두고 자신만의 직업과 자신만의 기술이 있다면 평생을 두고 간직할 만한 값진 보물일 것이다. 한디원과 타일분야 최고의 기술을 가진 강타일과 손잡고 미래 삶을 바꿀 타일아트 시공 전문가를 키워내기 위한 직업인 양성에 공동으로 합의하고 전략적 인재 양성에 들어갔다.</p>
							<p>이 직업은 실내디자인적인 디자인능력과 건축 및 설비능력이 융합된 복합적 능력이 필요 하며 창의적인 예술능력도 요구된다. 3년간의 학습능력으로 동종분야 창업도 가능하며 타일분야 최고의 전문가가 되기 위한 역량도 겸비하게 된다. </p>
						</dd>
					</dl>
					<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/hd_tile_01.png'/>" />
					<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
				</div>
			<!--// content -->
			</div>		
		</div>
	<!--// container -->
	<hr />
	</div>
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>