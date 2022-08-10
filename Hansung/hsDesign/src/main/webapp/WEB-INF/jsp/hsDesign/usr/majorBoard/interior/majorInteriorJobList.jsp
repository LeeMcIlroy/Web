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
				
				<div class="top_tab type_li10">
					<ul>
						<li <c:if test="${searchVO.menuType eq '05' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorJobList.do?menuType=05'/>">메타건축디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorJobList.do?menuType=01'/>">인테리어디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorJobList.do?menuType=02'/>">가구•리빙디자인</a></li>
						<!-- <li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorJobList.do?menuType=03'/>">부동산마케팅 </a></li> -->
<%-- 						<li <c:if test="${searchVO.menuType eq '04' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorJobList.do?menuType=04'/>">VMD</a></li> --%>
					<li <c:if test="${searchVO.menuType eq '06' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorJobList.do?menuType=06'/>">라이프스타일디자인</a></li>
					<li <c:if test="${searchVO.menuType eq '07' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorJobList.do?menuType=07'/>">3D모델링디자인</a></li> 
					</ul>
				</div>
				<c:if test="${searchVO.menuType eq '01' }">
					<p class="area_info">
						주거공간, 상업공간, 복합 및 문화공간 분야와 건축요소, 재료, 가구, 색채, 조명 등 실내구성요소에 대한 전반적인 내용을 학습한다.<br>
						공간에서 요구되는 창의적이고 합리적인 사고과정을 통해 예술성, 기능성, 기술성이 높은 실내 환경을 창출할 수 있는 디자이너를 양성한다.
					</p>
					
					<div class="s_tit">취업분야</div>
					<p class="area_info">인테리어디자인사, 인테리어자재사, 전시디자인사, 인테리어시공사</p>

					<div class="s_tit">관련자격증</div>
					<p class="area_info">실내건축(산업)기사, 컬러리스트(산업)기사, 멀티미디어 콘텐츠 제작 전문가, 건축(산업)기사, 건설안전(산업)기사, 건축설계(산업)기사, Auto CAD 자격증, 컴퓨터활용능력 1,2급, 소방안전관리자 1,2급 등</p>
	
	
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
					</div>
				</c:if>
				<c:if test="${searchVO.menuType eq '02' }">
					<p class="area_info">가구디자인만이 아닌 공간과 가구의 연계성을 이해하면서 가구디자인 분야를 이해하게 되고, 가구디자인의 실무자 및 CEO의 강연을 통하여 기업 브랜드가구의 특성과 제작가구의 특성 등 다양한 형태를 경험한다.</p>

					<div class="s_tit">취업분야</div>
					<p class="area_info">전시디자인사, 가구디자인사, 백화점VMD, 인테리어소품관련사, 디자인에이전시 등</p>

					<div class="s_tit">관련자격증</div>
					<p class="area_info">실내건축(산업)기사, 컬러리스트(산업)기사, 멀티미디어 콘텐츠 제작 전문가, 건축(산업)기사, 건설안전(산업)기사, 건축설계(산업)기사, Auto CAD 자격증, 컴퓨터활용능력 1,2급, 소방안전관리자 1,2급 등</p>
	
	
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft03.jpg'/>" /></li>
						 <!-- <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft07.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft08.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft09.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft10.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_ft11.jpg'/>" /></li>-->
						</ul>
					</div>
				</c:if>
				<c:if test="${searchVO.menuType eq '03' }">
					<p class="area_info">
						부동산 분야도 4차산업혁명 추세에 발맞추어 부동산 상품을 브랜드화 하여 경쟁력을 갖추도록 하는 마케팅 실무능력을 갖춘 부동산브랜드마케팅 전문인력 양성을 목표로 한다. 
						 이를 위해 부동산업의 전문화된 다양한 직군을 소개하고, 기존의 부동산 중개업에 한정하지 않고, 건축과 리모델링 등의 디자인과  결합한 융복합적인 전문가적 시각을 갖추도록 관련 영역을 학습하여 부동산브랜드마케팅 전문능력을 배양한다. 
						<br>이를 통해 공인중개사, 부동산컨설턴트, 부동산마케터, 리모델링디자이너 등을 양성한다.
					</p>
					<div class="s_tit">취업분야</div>
					<p class="area_info">
						시행사, 건설사, 금융회사, 부동산 개발회사, 부동산중개업, 부동산 컨설팅사, 부동산 관공서
					</p>
	
					<div class="s_tit">관련자격증</div>
					<p class="area_info">
						공인중개사, 리모델링사업관리사, 건축(산업)기사, 실내건축(산업)기사, 컬러리스트(산업)기사, 건설안전(산업)기사, Auto CAD 자격증, 소방안전관리자 1,2급 등
					</p>

					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm01.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm02.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/home_advan_sm03.jpg'/>" /></li>
						</ul>
					</div>
				</c:if>
				<c:if test="${searchVO.menuType eq '04' }">
					<p class="area_info">완성된 모델하우스, 백화점 매장, 로드 샵 매장, 주거 공간, 상업 공간 등에 시각적인 포인트를 주고, 상품의 종류와 컨셉 및 전시, 진열, 판매 기획에 따른 상품이 가지고 있는 특성을 표현하는 코디네이션 연출을 위해 전체적인 레이아웃을 잡아주는 ‘디스플레이어’를 양성한다.</p>

					<div class="s_tit">취업분야</div>
					<p class="area_info">VMD사, 백화점 및 브랜드디스플레이사, 인테리어디자인사, 인테리어 재료 및 시공관련사, 인테리어스타일링사, 전시디자인사 등 </p>

					<div class="s_tit">관련자격증</div>
					<p class="area_info">실내건축(산업)기사, 컬러리스트(산업)기사, 멀티미디어 콘텐츠 제작 전문가, 건축(산업)기사, 건설안전(산업)기사, 건축설계(산업)기사, Auto CAD 자격증, 컴퓨터활용능력 1,2급, 소방안전관리자 1,2급 등</p>


					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/vmd_01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/vmd_02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/vmd_03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/vmd_04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/vmd_05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/vmd_06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/vmd_07.jpg'/>" /></li>
						</ul>
					</div>
				</c:if>
				<c:if test="${searchVO.menuType eq '05' }">
					<p class="area_info">메타버스 서비스를 바탕으로 한, 기업이나 이용자들이 의도하는 바를 가상공간에 구현할 수 있는 디지털 설계능력을 교육하는 전공이다. 건축, 인테리어, 부동산 지식을 바탕으로 클라이언트가 요구하는 브랜드 컨셉에 맞는 환경을 구현할 수 있는 메타버스 건축디자이너를 양성한다.</p>

					<div class="s_tit">취업분야</div>
					<p class="area_info">건축설계사무소, 건설회사, 인테리어디자인사, 부동산개발사, 메타버스 플랫폼개발사, 건축엔지니어링사 등</p>

					<div class="s_tit">관련자격증</div>
					<p class="area_info">건축(산업)기사, 건축설계(산업)기사, 실내건축(산업)기사, 컬러리스트(산업)기사, 멀티미디어 콘텐츠 제작 전문가, 건설안전(산업)기사, Auto CAD 자격증, 컴퓨터활용능력 1,2급, 소방안전관리자 1,2급 등</p>


					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/architectural design_01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/architectural design_02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/architectural design_03.jpg'/>" /></li>
						 <!-- <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/architectural design_04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/architectural design_05.jpg'/>" /></li>-->
						</ul>
					</div>
				</c:if>
				<c:if test="${searchVO.menuType eq '06' }">
					<p class="area_info">
						기초디자인, 색채학, 제품디자인, 인간중심디자인, 생활소품디자인 등의 다양한 커리큘럼을 통해 라이프스타일을 분석하여 인간이 영위하는 공간, 가구, 제품 등을 중심으로 문제해결 능력을 지닌 전문디자이너를 양성한다.
					</p>
					
					<div class="s_tit">취업분야</div>
					<p class="area_info">방송사, 전시디자인사, 제품디자인사, 생활용품디자인사, 인테리어디자인사, 백화점VMD, 인테리어소품관련사, 디자인에이전시 등</p>

					<div class="s_tit">관련자격증</div>
					<p class="area_info">실내건축(산업)기사, 컬러리스트(산업)기사, 제품디자인(산업)기사, Auto CAD 자격증, 컴퓨터활용능력 1,2급, 소방안전관리자 1,2급 등</p>
	
	
					<div class="photo_slider">
						<ul class="b_photo">
						  
						</ul>
					</div>
				</c:if>
				<c:if test="${searchVO.menuType eq '07' }">
					<p class="area_info">
						건축디자인, 인테리어디자인, 제품디자인 등의 분야에서 중요시 되는 각종 3D모델링 소프트웨어 능력을 강력하게 교육하여, 각종 가상의 건축물 및 공간, 생활 소품 등도 직접 디자인할 수 있는 능력을 배양한다.
					</p>
					
					<div class="s_tit">취업분야</div>
					<p class="area_info">인테리어디자인사, 건축설계사무소, 전시디자인사, 방송영상제작사, 모델링 스튜디오 등</p>

					<div class="s_tit">관련자격증</div>
					<p class="area_info">건축설계사무소, 건설회사, 인테리어디자인사, 메타버스 플랫폼개발사, 제품디자인사, 생활용품디자인사 등</p>
	
	
					<div class="photo_slider">
						<ul class="b_photo">
						
						</ul>
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