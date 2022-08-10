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
		            <jsp:param name="dept2" value="패션디자인"/>
		            <jsp:param name="dept3" value="진출분야"/>
	           	</jsp:include>
<!-- 		            200417수정 -->
<%-- 		            <jsp:param name="dept2" value="패션비즈니스"/> --%>

<!-- 200416수정 -->
				<div class="top_tab type_li4">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionJobList.do?menuType=01'/>">패션디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionJobList.do?menuType=02'/>">패션스타일링</a></li>
<%-- 						<li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionJobList.do?menuType=03'/>">패션소재ㆍ텍스타일 디자인</a></li> --%>
						<li <c:if test="${searchVO.menuType eq '04' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessJobList.do?menuType=04'/>">패션MD·마케팅</a></li>
						<li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessJobList.do?menuType=03'/>">패션창업</a></li>
					</ul>
				</div>	
				
				<c:if test="${searchVO.menuType eq '04' }">
					
					<p class="area_info">
					<!-- 200416수정 -->
<!-- 					패션시장을 분석하고 상품을 기획하여 브랜드 운영을 총괄하는 패션MD, 아이템의 효과적인 연출과 디스플레이를 통해 기업의 이미지를 만들어내는 패션 VMD, 패션상품을 판매하고 관리하는 샵마스터 브랜드 매니저 등 패션산업의 핵심인력을 양성한다. -->
					패션마케팅 전공은 글로벌 시대에 경쟁력 있는 패션머천다이저 및 비주얼머천다이저를 양성하는 전공 과정이다. 패션사업과 마케팅의 전반적 이해를 토대로 패션상품기획, 패션브랜드런칭, 패션트렌드 분석력 및 머천다이징 능력을 기른다. 
					또한 패션유통에 대한 이해를 바탕으로 판매촉진과 매장의 효과적 연출 및 운영에 관한 능력을 배양하기 위해 슬무중심의 교육을 받게 된다. 
					</p>

					<div class="s_tit">취업분야</div>
					<p class="area_info"> 패션MD(Fashion Merchandiser)가 대표적이며 디자이너와 상품기획 및 브랜드 총 관리업무를 담당하는 기획MD, 생산된 패션제품을 유통시키기고 판매 및 영업을 담당하는 영업MD,
					원부자재 개발과 제품생산에 전반적인 관리를 담당하는 생산MD, 제품연출 및 디스플레이를 담당하는 VMD(Visual Merchandiser)와 유통업체의 경우 구매와 영업에 대한 총괄업무를 담당하는 리테일MD(Buyer)가 있습니다. 또한 매장에서 고객을 상대로 제품을 판매하는 업무를 담당하는 숍마스터와 브랜드 매니저가 있습니다.</p>
				
					
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/fbusiness/fb_advan_fp01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/fbusiness/fb_advan_fp02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/fbusiness/fb_advan_fp03.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>				
				<!-- <c:if test="${searchVO.menuType eq '02' }">
					
					<p class="area_info">
					패션시장을 분석하고 상품을 기획하여 브랜드 운영을 총괄하는 패션MD, 아이템의 효과적인 연출과 디스플레이를 통해 기업의 이미지를 만들어내는 패션 VMD, 패션상품을 판매하고 관리하는 샵마스터 브랜드 매니저 등 패션산업의 핵심인력을 양성한다.
					</p>

					<div class="s_tit">취업분야</div>
					<p class="area_info"> 
					패션 디렉터, 모델리스트, 패션 스타일리스트, 트렌드 정보기획자, 패션 에디터, 패션 컨설턴트, 대중문화 및 공연예술 관련 의상감독 등
					</p>
					
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/fbusiness/fb_advan_fm01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/fbusiness/fb_advan_fm02.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if> -->				
				<c:if test="${searchVO.menuType eq '03' }">
				
					<p class="area_info">
					<!-- 200416수정 -->
<!-- 					국대 최대 온라인 쇼핑몰 G마켓·옥션과의 MOU를 통해 패션창업에 필요한 실무 강의를 진행한다. 상품등록, 사진촬영, 상품페이지 제작, 판매관리, 광고·마케팅, 세무, 상품사입 등 창업에 필요한 모든 과정에 대해 체계적으로 배울 수 있다. -->
						패션창업전공은 G마켓/옥션 및 전자상거래 솔루션 카페24 등 대기업과 산학협력하여 인터넷이나 모바일을 기반으로 한다. 예비 창업자 및 소자본으로 패션 비즈니스 창업을 준비하는 예비 창업자들에게 좋은 기회를 제공해줄 것으로 확신한다. 
						창업 컨설팅부터 정부지원사업까지 패션사업에 누구나 쉽게 접근할 수 있도록 돕고 또한 패션기업의 온라인 관련 분야에 적합한 인재를 배출하기 위해 심화교육을 제공한다.
					</p>
	
					<div class="s_tit">취업분야</div>
					<p class="area_info"> 
					온라인/모바일 쇼핑몰 창업, 소자본 개인 창업, 패션 상품 기획자, 패션 기업 온라인 부서 담당자 및 기획자 등
	
					</p>
			
				
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/fbusiness/fb_advan_fc01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/fbusiness/fb_advan_fc02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/fbusiness/fb_advan_fc03.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
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