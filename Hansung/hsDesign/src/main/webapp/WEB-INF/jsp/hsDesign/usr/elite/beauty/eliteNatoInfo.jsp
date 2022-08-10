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
		            <jsp:param name="dept2" value="일학습엘리트과정"/>
		            <jsp:param name="dept3" value="나투리아"/>
		            <jsp:param name="dept4" value="전공안내"/>
	           	</jsp:include>
				
				<div class="sub_cont_page">
					<dl class="info_dl">
						<dd>
							<p><strong style="font-size: 20px;">미용학전공 “뷰티교육자”, “하야시두피모발”, “나투리아” 소개</strong></p>
							<p>미용학전공은 취업과 학업을 동시에 가능하도록 기업이 전략적으로 교육에 참여하고 학업이외의 시간에는 일을 할 수 있도록 학생중심 직업인 육성전공이다.</p>
							<p>미용학전공에서 양성하고자 하는 헤어디자이너는 비주얼디자인(visual design)교육에 기반 특화된 헤어디자이너를 키워내고 졸업과 동시에 바로 현장에서 능력을 발휘하는 현장실무형 인재를 양성하는데 목적이 있다.</p>
							<p>이를 위해 사)한국미용장협회 등과 손잡고 경쟁력 있는 뷰티 전문가를 양성한다. 뷰티 전문가는 기계가 근접하지 못하는 감성적인 부분이 필요로 하는 직업군으로 사람에게서 느끼는 다양한 감정을 해석하고 헤어를 통해 창출하는 인간만이 펼칠 수 있는 예술적 행위라 할 수 있다. 남보다 더 아름답게 보이기 위한 인간의 본능을 만족시키는 예술이자 직업군이다.</p>
						</dd>
						<dd>
							<p style="margin-top: 30px;text-align: center;"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/elite/nato.png'/>" /></p>
						</dd>
					</dl>
				</div>
				<div class="s_tit">한디원 미용학 전공 특징</div>
				<div class="sub_cont_page">
					<dl class="info_dl">
						<dd>
							<p>
								<strong>1. 배움이 다르다</strong> <br />최고의 교수진이 학생들에게 미용강사 및 특강강사
								전문교육을 함으로 졸업 후 헤어. 메이크업. 피부. 네일. 스킨아트. 웨딩. 피부병원. 성형외과.
								일반병원뷰티코디. 모발두피관리병원. 뷰티마네킨. 뷰티에디터. 뷰티텔러마케터. 뷰티창업 부문에서 미용강사로서의
								자격을 갖추게 됩니다. 또한 우수 학생에 대해 해외연수 및 국내 유명학원 강사 자격이 부여되고, 현장실무와
								교육강사로서의 자질을 갖추기 위해 전문화된 교육과정과 강사양성프로그램을 운영합니다.(학원 연계 교육, 대학원
								진학 상담제도, 논문스터디 등)

							</p>
							<p>
								<strong>2. 취업의 질이 다르다</strong> <br />취업의 어려움과 취업 후 안정된 고용안전이
								보장되지 않아 고학력의 대학 졸업생들이 미용기술을 배우기 위해 다시 전문학교에 입학하는 추세이며, 다양한
								자격증 취득, 실무위주의 작업과정 체크리스트 서비스를 통하여 고객과의 상담부터 재방문까지의 과정을 리얼하게
								습득하는 체계적인 수업 및 산업체 적응프로그램을 통하여 맞춤형 안정 취업을 하여 직장생활을 하게 됩니다.

							</p>
							<p>
								<strong>3. 뷰티창업에 도전하다</strong> <br />학습자의 다양한 창업도전기회를 주기 위해
								헤어. 메이크업. 피부. 네일. 스킨아트. 웨딩. 피부병원. 성형외과. 일반병원뷰티코디. 모발두피관리병원.
								뷰티마네킨. 뷰티에디터. 뷰티텔러마케터 등 뷰티분야의 창업을 위한 집중교육으로 운영되며 배움의 기회와
								현장경력 등을 동시에 쌓을 수 있도록 열린 교육과정으로 운영합니다. 미용학사 학위를 취득한 후 보다 전문적인
								기관으로의 취업을 통하여 현장적응을 하고 창업에 도전할 수 있게 합니다. 담당교수제를 도입하여 미용창업을
								위한 창업기초-실무-제반교육-예비창업 커리큘럼을 진행합니다.

							</p>
						</dd>
					</dl>
				</div>
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