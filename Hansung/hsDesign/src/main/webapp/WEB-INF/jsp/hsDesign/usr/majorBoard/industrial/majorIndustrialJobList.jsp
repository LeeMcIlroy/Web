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
					<jsp:param name="dept1" value="전공"/>
		            <jsp:param name="dept2" value="산업디자인"/>
		            <jsp:param name="dept3" value="진출분야"/>
	           	</jsp:include>
				
				<div class="top_tab type_li3">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialJobList.do?menuType=01'/>">제품·리빙디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialJobList.do?menuType=03'/>">주얼리·금속디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialJobList.do?menuType=02'/>">운송·자동차디자인</a></li>
					</ul>
				</div>		
				
				<c:if test="${searchVO.menuType eq '01' }">
					<p class="area_info">기초디자인, 색채학, 제품디자인, 인간중심디자인, 환경제품디자인 외 디자인론, 제품기획론, 디자인경영과 브랜드전략 등과 같은 이론 수업까지 다양한 커리큘럼을 통해 라이프스타일을 분석하여 인간이 영위하는 공간, 가구, 제품 등을 중심으로 문제해결력을 지닌 전문디자이너를 양성한다.</p>

					<div class="s_tit">취업분야</div>
					<p class="area_info">제품디자이너, 전자제품디자이너, 생활용품디자이너, 용기디자이너(화장품, 생활용품 등) 가구디자이너, 스포츠레져용품 디자이너, 팬시디자이너, 문구디자이너, 장난감디자이너, 디스플레이디자이너, 디자인컨설턴트, 인테리어디자이너, 패션 액세서리 디자이너, UX & UI 디자이너 등</p>
					
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/product1.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/product2.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/product3.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/product4.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/product5.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/product6.jpg'/>" /></li>
						</ul>
					</div>
				</c:if>		
				<c:if test="${searchVO.menuType eq '02' }">
				
					<p class="area_info">기초적인 조형연습부터, 디자인이론, 2D&3D디지털디자인(CAD, Alias 등), 운송기기디자인 등의 다양한 커리큘럼을 구성하여, 자전거 및 퍼스널모빌리티에서 중장비디자인까지 다양한 스케일의 운송기기디자인뿐만 아니라 차세대 컨셉디자인을 창출할 수 있는 창의적인 디자이너를 양성한다.</p>

					<div class="s_tit">취업분야</div>
					<p class="area_info">운송기기 디자인컨설턴트, 자동차디자이너(인테리어/엑스테리어), 자전거디자이너, 모빌리티디자이너, 운송기기디자이너, 자동차 액세사리 디자이너, 3D 모델러, 클레이 모델러 등</p>
				
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/car0.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/car1.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/car2.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/car3.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/car4.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/car5.jpg'/>" /></li>
						</ul>
					</div>
				</c:if>
				<c:if test="${searchVO.menuType eq '03' }">
				
					<p class="area_info">드로잉, 색채학, 도학 외 산업체 현장의 실무 교육 프로그램을 개설하고 개인별 맞춤교육을 통해 실무능력을 배양한다. 이를 통해 귀금속 산업과 패션악세서리 디자인 및 웨딩 주얼리 토탈코디네이션 산업전반에 이바지할 수 있도록 한다.</p>

					<div class="s_tit">취업분야</div>
					<p class="area_info">주얼리 디자이너, 패션 액세서리 디자이너, 주얼리 코디네이터, 주얼리 공방 및 창업, 공예디자이너 등</p>
				
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/jewelry1.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/jewelry2.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/jewelry3.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/jewelry4.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/industrial/jewelry5.jpg'/>" /></li>
						</ul>
					</div>
				</c:if>		
						
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