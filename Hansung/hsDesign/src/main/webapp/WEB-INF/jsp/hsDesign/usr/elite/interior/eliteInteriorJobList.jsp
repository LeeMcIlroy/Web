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
		            <jsp:param name="dept2" value="실내디자인"/>
		            <jsp:param name="dept3" value="진출분야"/>
	           	</jsp:include>
				
				<div class="top_tab type_li3">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorJobList.do?menuType=01'/>">인테리어디자이너</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorJobList.do?menuType=02'/>">가구디자이너</a></li>
						<li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorJobList.do?menuType=03'/>">공간미디어디자이너</a></li>
					</ul>
				</div>
				<c:if test="${searchVO.menuType eq '01' }">
					<p class="area_info">주거공간, 상업공간, 복합 및 문화공간 분야와 건축요소, 재료, 가구, 색채, 조명 등 실내구성요소에 대한 전반적인 내용을 학습한다. <br>
					공간에서 요구되는 창의적이고 합리적인 사고과정을 통해 예술성, 기능성, 기술성이 높은 실내 환경을 창출할 수 있는 디자이너를 양성한다. </p>
	
					<div class="s_tit">취업분야</div>
					<p class="area_info">건축설계사무소, 인테리어디자인회사, 인테리어 재료 및 시공관련회사, 가구디자인회사, 인테리어스타일링회사, 환경디자인회사, 전시디자인회사, 디자인소품관련사, 조명디자인회사, 색채관련회사, 이벤트관련회사, 백화점 및 브랜드디스플레이회사, VMD(Visual Merchandising], 인테리어 재료관련회사</p>
	
					<div class="s_tit">관련자격증</div>
					<p class="area_info">실내건축(산업)기사, 컬러리스트(산업)기사, 건축(산업)기사, 건설안전(산업)기사, 건축설계(산업)기사, Auto CAD 자격증, 컴퓨터활용능력 1,2급 등</p>
	
	
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it01.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it03.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it04.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it05.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it06.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it07.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it08.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it09.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it10.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_it11.png'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>
				<c:if test="${searchVO.menuType eq '02' }">
					<p class="area_info">가구디자인만이 아닌 공간과 가구의 연계성을 이해하면서 가구디자인 분야를 이해하게 되고, 가구디자인의 실무자 및 CEO의 강연을 통하여<br>기업 브랜드가구의 특성과 제작가구의 특성 등 다양한 형태를 경험한다.</p>
	
					<div class="s_tit">취업분야</div>
					<p class="area_info">가구디자인회사, 인테리어스타일링회사, 인테리어디자인회사, 인테리어 재료 및 시공관련회사, 환경디자인회사, 가구디자인 및 브랜드회사, 디자인소품관련회사, 조명디자인회사, 색채관련회사, 전시디자인회사, 디스플레이회사, 이벤트관련회사</p>
	
					<div class="s_tit">관련자격증</div>
					<p class="area_info">실내건축(산업)기사, 컬러리스트(산업)기사, 가구설계제도사, 건축(산업)기사, 건설안전(산업)기사, 건축설계(산업)기사, Auto CAD 자격증, 컴퓨터활용능력 1,2급등</p>
	
	
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft07.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft08.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft09.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft10.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft11.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>
				<c:if test="${searchVO.menuType eq '03' }">
					<p class="area_info">현대의 생활환경은 아날로그공간과 디지털공간이 융합되고 있으며, 디지털미디어 콘텐츠를 실제 공간디자인에 접목하는 인터랙티브한 공간디자인에 대한 요구가 증대되고 있다. 컴퓨팅 환경의 장점을 활용하여 사용자와 미디어콘텐츠의 인터랙션을 통해 공간디자인의 또 다른 미래 문화를 선도하는 인재를 양성한다.</p>

					<div class="s_tit">취업분야</div>
					<p class="area_info">인터렉티브기업, 미술감독, 아트디렉터, 환경디자인, 설치미술, 영화미술, 연극, 무대디자인, 방송세트, 광고, 홍보, 프로모션, 웨딩/이벤트, 전시디자인. 컨벤션/세미나. 드라마, 뮤지컬, CF, 오페라 등의 공간연출을 목적으로 하는 분야</p>

					<div class="s_tit">관련자격증</div>
					<p class="area_info">실내건축(산업)기사, 컬러리스트(산업)기사, 멀티미디어 콘텐츠 제작 전문가, 건축(산업)기사, 건설안전(산업)기사, 건축설계(산업)기사, Auto CAD 자격증, 컴퓨터활용능력 1,2급 등</p>


					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm05.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm06.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm07.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm08.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm09.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm10.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm11.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm12.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>
			</div>
		</div>
		<!--// content -->
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