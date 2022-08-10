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
		            <jsp:param name="dept2" value="디지털아트"/>
		            <jsp:param name="dept3" value="진출분야"/>
	           	</jsp:include>
				
				<div class="top_tab type_li5">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtJobList.do?menuType=01'/>">영상디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtJobList.do?menuType=02'/>">디지털애니메이션</a></li>
						<li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtJobList.do?menuType=03'/>">만화콘텐츠디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '04' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtJobList.do?menuType=04'/>">게임일러스트레이션</a></li>
						<li <c:if test="${searchVO.menuType eq '05' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtJobList.do?menuType=05'/>">성우콘텐츠·크리에이터</a></li>
					</ul>
				</div>		
				
				<c:if test="${searchVO.menuType eq '01' }">
					
					<p class="area_info">프로그램을 배우고 익히는데 그치지 않고 시각디자인의 주요 부분인 타이포그래피, 주조색과 강조색을 통한 색채디자인, 프로그램을 이용한 컴퓨터 그래픽, 평면조형 등 디자이너가 갖춰야 할 모든 내용을 학습하여 수준 높은 영상콘텐츠 전문가를 양성한다.</p>
						
				
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd07.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd09.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd10.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd11.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_vd12.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>			
				<c:if test="${searchVO.menuType eq '02' }">
				
					<p class="area_info">디지털애니메이션 제작을 중심으로 2D애니메이션 영화, 독립애니메이션, 3D컴퓨터 애니메이션, 게임캐릭터 디자인 제작에 이르기까지 미래문화콘텐츠 산업의 전문 인재를 양성하기 위한 실무 중심의 교육과정으로 구성되어 있다.</p>
						
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_as01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_as02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_as03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_as04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_as05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_as06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_as07.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>			
				<c:if test="${searchVO.menuType eq '03' }">
				
					<p class="area_info">21세기 대한민국 문화콘텐츠산업의 새로운 패러다임을 이끌고 있는 웹툰의 기획 및 창작자들을 양성하는데 목표를 두고 있다. 만화교육을 전문으로 하는 교수진과 다양한 노하우를 지닌 현업 작가 분들을 초빙하여 체계적인 맞춤형 교육을 통해 창작자로서의 자질을 갖출 수 있다.</p>
						
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc07.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc08.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc09.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc10.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc11.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc12.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc13.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc14.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc15.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc16.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc17.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_wc18.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>			
				<c:if test="${searchVO.menuType eq '04' }">
					<p class="area_info">오늘날 게임산업은 다양한 세부 그래픽 전문가들의 협업을 통해 대단히 정교하고 화려한 영상미를 가지고 있다. 배경원화, 캐릭터원화, 아이템원화, 몬스터원화, 3D모델링, UI제작, 캐릭터 리소스 등의 다양한 파트에 대한 교육을 통해 수준 높은 포트폴리오를 완성한다.</p>
						
				
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi07.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi08.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi09.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi10.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi11.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi12.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi13.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi14.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi15.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi16.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_advan_gi17.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>			
				<c:if test="${searchVO.menuType eq '05' }">
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
						<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_voice_02_1_1.jpg'/>" />
						<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/digitalArt/da_voice_02_2.jpg'/>" />
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