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
		            <jsp:param name="dept2" value="미용학"/>
		            <jsp:param name="dept3" value="진출분야"/>
	           	</jsp:include>
				
				
				<div class="top_tab type_li4">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyJobList.do?menuType=01'/>">헤어디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyJobList.do?menuType=02'/>">메이크업디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyJobList.do?menuType=03'/>">네일디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '04' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyJobList.do?menuType=04'/>">피부디자인</a></li>
					</ul>
				</div>	
				
				<c:if test="${searchVO.menuType eq '01' }">
					
					<p class="area_info">
					“TWINS(쌍둥이)실무시스템 체계적인 교육프로그램”<br>
					국내 최초 헤어 커리큘럼의 전문화를 실현하고, 헤어관련 시장이 급속하게 변화하는 미용 산업체에 대응할 수 있는 인재 양성을 위한 체계적인 교육시스템입니다.
					“TWINS(쌍둥이)실무시스템 프로그램” 은 현재 뷰티 살롱과 똑같은 시설에서 실제 고객을 대상으로 수업이 진행되고 헤어관련 토털전문가로 숙련가 완성 과정의 시간을 절약하여 산업체에서 빠르게 개인의 부가가치를 높일 수 있게 합니다.
					</p>

					<div class="s_tit">취득가능 자격증</div>
					<p class="area_info"> 미용사자격증, 이용사자격증, 미용사면허증, 모발 및 두피관리사 자격증, 헤어스타일리스트 1, 2급 강사자격증, 컬러리스트 자격증, 국가미용사 면허증 발급</p>

					<div class="s_tit">진출분야</div>
					<p class="area_info">소자본 On/off 창업, 모발 및 두피 관리 전문가, 스타일리스트, 학원강사, 학교선생님, 학교 방과 후 지도교사, 대학교 평생교육원 강사 및 교수, 대학교 강사 및 교수, 미용관련 산업체 입사, 뷰티 에디터, 미용교육 전문강사, 뷰티 샵 창업</p>
				
					
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_hd01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_hd02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_hd03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_hd04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_hd05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_hd06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_hd07.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_hd08.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_hd09.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>				
				<c:if test="${searchVO.menuType eq '02' }">
					
					<p class="area_info">
					“국내 최초 교원능력개발프로그램으로 실무 중심의 메이크업/체계적인 교육”<br>

					특성화 된 현장에서 필요로 하는 전문가를 양성하기 위해 세부적으로 특성화 된 커리큘럼으로 프로패셔널한 메이크업 아티스트와 교육자를 동시에 양성합니다.
					국내 최초로 메이크업 전공 과정을 세분화시키고 현장과 동일한 특별한 교육시스템을 도입하여 최고의 교육자로 양성합니다.

					</p>

					<div class="s_tit">취득가능 자격증</div>
					<p class="area_info">국가미용사 면허증 발급, 메이크업, 분장사 자격증, 뷰티스타일리스트 자격증, 웨딩메이크업 자격증, 컬러리스트 산업기사</p>

					<div class="s_tit">진출분야</div>
					<p class="area_info">메이크업 아티스트, 이미지 컨설턴트, 특수 분장, 영화분장, 웨딩메이크업, 무대메이크업(아나운서/홈쇼핑/패션쇼 등), 분장사(방송/기획사/영화사/CF/각종 공연/프리랜서등), 뷰티 에디터, 미용교육 전문강사, 뷰티 샵 창업</p>
					
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_mu01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_mu02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_mu03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_mu04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_mu05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_mu06.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>				
				<c:if test="${searchVO.menuType eq '03' }">
				
					<p class="area_info">
						“국내 최초 네일 심화 교육”<br>
						“체계적인 실무기초부터 현장실무를 위한 맞춤형 교육”<br>
						기본 네일기술과 현장 네일실무능력이 매칭 된 특성화 된 현장에서 필요로 하는 전문가를 양성하기 위해 국내 최초로 현장 중심 네일전문 교육시스템을 도입하여 전문적인 네일아티스트와 교육자를 양성합니다.
					
					</p>

					<div class="s_tit">취득가능 자격증</div>
					<p class="area_info">
					네일 2급, 1급 기술 강사 자격증, 발 관리 자격증, 족구반사 자격증, 속눈썹연장 2급, 1급 자격증 등, 뷰티스타일리스트 자격증, 컬러리스트 산업기사, 미용사(일반) 자격증

					</p>

					<div class="s_tit">진출분야</div>
					<p class="area_info">
					뷰티샵 매니저, 경영전문가(네일샵, 네일전문제품 취급점), 유학 및 대학원 진학, 학원 강사, 학교 방과 후 지도교사, 대학교 평생교육원 강사 및 교수, 대학교 강사 및 교수, 뷰티 에디터, 미용교육 전문강사, 뷰티 샵 창업

					</p>
				
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_nd01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_nd02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_nd03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_nd04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_nd05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_nd06.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>	
				<c:if test="${searchVO.menuType eq '04' }">
				
					<p class="area_info">
						문제성 피부를 가진 고객을 전문적이고 상세한 상담을 통해 화학적, 물리적 자극에 대한 반응을 테스트한 후 피부진단을 내리고 전문 에스테티션이 도구와 화장품을 통해 피부치료 후 효과적으로 관리하여 피부관리나 피부질환예방을 극대화 할 수 있는 에스테티션을 목표로 실무에 바로 적용할 수 있는 기술을 습득함으로 피부미용과 병원 산업체에서 요구하는 현장전문가를 배출합니다.<br><br>
						고객의 얼굴과 전신을 대상으로 피부를 관찰, 분석하여 인체에 친화성이 있는 활성성분(화장품)과 피부미용기기 또는 미용기법을 통하여 피부가 지닌 본래의 기능을 도화 피부를 개선하고 피부고유의 기능을 되살려 실무에 바로 적용할 수 있는 기술을 습득합니다.

					
					</p>

					<div class="s_tit">취득가능 자격증</div>
					<p class="area_info">
					피부미용 국가 자격증, 아로마 테라피, 발관리, 병원 코디네이터, 경락, 체형관리사, 타이 마사지, 두피 자격증, 비만관리사, 이미지 메이킹 국제 체형관리사 자격증


					</p>

					<div class="s_tit">진출분야</div>
					<p class="area_info">
					스파 테라피, 병원 코디네이터, 피부 강사, 에스테틱 관리사, 대학원 진학, 화장품 회사, 화장품 전문강사, 창업, 병원 내 에스테틱, 호텔 스파, 기능성 전문제품 회사, 직업 기술학교 강사, 미용업계 신문사, 전문 잡지사, 피부관리용 기기회사, 두피모발전문센터, 두피 모발전문센터 창업, 학원강사, 학교선생님, 학교 방과 후 지도교사, 대학교 평생교육원 강사 및 교수, 대학교 강사 및 교수


					</p>
				
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_sa01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_sa02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_sa03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_sa04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_sa05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_advan_sa06.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beautyOne/photo_s_eximg08.jpg" /></a>
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