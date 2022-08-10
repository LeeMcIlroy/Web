<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
	<form:form commandName="searchVO" id="frm" name="frm">
		<form:hidden path="pageIndex" />
		<form:hidden path="searchType" />
		<form:hidden path="menuType" />
		<form:hidden path="searchCondition2" />
		<form:hidden path="searchWord" />
		<input type="hidden" id="mbSeq" name="mbSeq">
		<!-- skip_navigation -->
		<dl id="skip_nav">
			<dt>바로가기 메뉴</dt>
			<dd>
				<a href="#content">본문 바로가기</a>
			</dd>
			<dd>
				<a href="#top_menu">메뉴 바로가기</a>
			</dd>
			<dd>
				<a href="#footer">페이지 하단 바로가기</a>
			</dd>
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
					<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
					<!--// lnb -->
					<!-- content -->
					<div class="sub_content">
						<!-- 타이틀 영역 -->
						<jsp:include
							page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle2.jsp">
							<jsp:param name="dept1" value="전공" />
							<jsp:param name="dept2" value="일학습엘리트과정" />
							<jsp:param name="dept3" value="글로벌패션창업" />
							<jsp:param name="dept4" value="전공안내" />
						</jsp:include>

						<div class="sub_cont_page">
							<dl class="info_dl">
								<dd>
									<p><strong style="font-size: 20px;">한성대학교 한디원과 글로벌패션창업 소개</strong></p>
									<p>한성대학교 부설 디자인아트 교육원(이하 ‘한디원’)은 디자인계열의 전공을 전문으로 교육하는 대학부설 학점은행제 교육기관으로 졸업 후 한성대학교 총장명의 4년제 학사학위를 수여하고 있습니다.</p>
									<p>현재 패션비즈니스학, 패션디자인학, 실내디자인학, 시각디자인학, 산업디자인학, 디지털아트학, 미용학 등총 7개 전공을 운영하고 있으며, 한디원 졸업생들은 4년제 대학졸업자와 동등한 자격으로 취업이나 대학원 진학이 가능합니다.</p>
									<p>또한 국내외 유명 기업의 디자이너와 CEO로 구성된 교수진을 갖추고, 현장에 강한 실무 중심의 교육 커리큘 럼을 제공하여 디자인분야 취업률 86%, 대학원 진학 합격률 100%라는 좋은 성과를 나타내고 있습니다.</p>
									<p>한성대학교 한디원 [글로벌패션창업]은 급변하는 시대에 발 빠르게 적응할 수 있는 창의적 패션 창업인재를 양성하기 위하여 2018학년 새롭게 선보이는 패션비즈니스학 전공으로 [전자상거래 + 인터넷마케팅 + 글로벌 쇼핑몰 구축 및 관리 + 콘텐츠커머스 + 패션 MD]를 하나로 통합한 교육과정입니다.</p>
									<p>글로벌패션창업 교육과정은 빠르게 모바일로 변화하는 인터넷비즈니스구조와 해외시장 도전시에 부딪히게 되는 문제점들에 대하여 해결책을 제안하고 이에 적합한 창업인재를 양성하기위해 2017년 6월 한성대 한디원 패션비즈니스전공과 국내 쇼핑몰 솔루션업계 1위인 카페24가 MOU를 체결하고 각 분야 실무에 최적화된 전공교수를 발탁하고 현장에서 필요로하는 실무형 창업인재로 키우기 위해 차별화된 교육커리큘럼을 구성하였습니다.</p>
								</dd>
							</dl>
							<dl class="info_dl">
								<dd>
									<p><strong style="font-size: 20px;">글로벌패션창업의 특징</strong></p>
									<p>학업성취도에 따라 2학년(4학기) 또는 3학년(6학기) 수업으로 현장에서 요구하는 수준의 창업인재를 육성할 수 있으며, 한성대학교 총장명의의 패션학사 학위를 수여합니다.</p>
									<p>
										・ 토요일 전일제 수업으로 평일업무와 주말공부를 병행 할 수 있습니다.<br>
										・ 한성대 한디원 [글로벌패션창업]에 진학시, 입학에서 졸업까지 전학기 등록금의 40%를 장학금으로 지원합니다. (졸업 후 한성대 대학원 진학시, 전학기 등록금의 50%를 장학금으로 지원)<br>
										・ 본 교육과정은 패션전문지식과 전자상거래(인터넷 쇼핑몰)전문지식으로 구분이 되며, 각 전공 교과목은 분야별 전문교수를 선발하여 교육을 실시하므로 업계의 최신 정보와 네트워크를 쌓을 수 있습니다.<br>
										・ 교육이수시 [전자상거래 수출마스터 1급] 자격증을 전원 취득할 수 있습니다.<br>
										・ 학기 중 행사로 VC-Day를 개최하여 각각의 분야별 교육내용과 사업계획서를 실무에 계신 벤처투자자들에게 프리젠테이션하여 전문성을 검토받습니다. 이는 실제 상황과 똑같이 시뮬레이션할 수 있는 제도이며, 신규 쇼핑몰 런칭 및 2nd 브랜드 개설시 독립적으로 프로젝트를 수행할 수 있습니다.
									</p>
								</dd>
							</dl>
							<dl class="info_dl">
								<dd>
									<p><strong style="font-size: 20px;">글로벌패션창업 특전</strong></p>
									<p>한디원 [글로벌패션창업]에서는 다음과 같은 특전을 입학하신 모든분들께 드리고 있습니다.</p>
									<p>
										・ 정부지원사업 지원(지원금 3,000만원 ~ 1억원, 정보제공과 사업계획서 작성 지도)<br>
										・ 해외패션 시장조사 (최소 1회/년 이상)<br>
										・ 패션네트워크(각 분야별 전문가)를 제공<br>
										・ 패션 리크루트의 기회 제공<br>
										・ 1:1 창업 멘토링 및 무료 컨설팅
									</p>
								</dd>
							</dl>
							<dl class="info_dl">
								<dd>
									<p><strong style="font-size: 20px;">글로벌패션창업 모집대상</strong></p>
									<p>한디원 [글로벌패션창업]에서는 다음과 같은 분들을 모집하고 있습니다.</p>
									<p>
										・ 온라인 패션쇼핑몰을 창업하여 운영하고 있으나 매출성장에 어려움을 겪고 있거나 글로벌(해외)진출을 희망하시는 쇼핑몰의 대표님<br>
										・ 1세대(부모님세대)에서 2세대(자녀세대)로 패션기업 세대교체로 인하여 전문적 실무경험과 패션관련 네트워크가 필요한 2세 패션경영인<br>
										・ 패션 콘텐츠를 중심으로 전문적인 콘텐츠(미디어)커 머스 사업체를 운영하는 온라인마케터와 관련업계 대표님<br>
										・ 패션관련 업체에서 근무하여 실무경력은 있으나, 창업에 대한 지식이 부족하여 창업을 준비하고 있는 예비창업자<br>
										・ 4차산업과 글로벌 온라인 쇼핑몰에 관심을 가지고 교육산업에 관심이 많은 글로벌패션창업 전문강사 (예정자)<br>
										・ 오프라인 매장을 운영하고 있으나 온라인 비즈니스 (전자상거래) 진출에 어려움을 겪고 있는 대표님
									</p>
								</dd>
							</dl>
							<div style="margin-top: 20px;text-align: center;">
								<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/fbusiness/fd_marketing_03.png'/>" />
								<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/fbusiness/cafe24_1.jpg'/>" />
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