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
<form id="frm" name="frm">
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
						page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
						<jsp:param name="dept1" value="한디원뉴스" />
						<jsp:param name="dept2" value="함께하는기업들" />
					</jsp:include>
					
					<div class="sub_cont_box">
						<dl class="info_dl">
							<dt></dt>
							<dd>
								<div class="partner_box">
									<ul>
										<li>취업연계</li>
										<li>공동연구</li>
										<li>전공지원</li>
										<li>사회공헌</li>
										<li>취업지원</li>
									</ul>
								</div>
	
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_01_img.jpg'/>" alt="NAVER" /></dt>
										<dd>
											NAVER : 2014
											<p>‘다양한 콘텐츠 개발과 (모두)MODOO 프로젝트를 통한 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_02_img.jpg'/>" alt="㈜한샘" /></dt>
										<dd>
											㈜한샘 : 2016년 8월 30일
											<p>‘공동 교육 커리큘럼 개발과 공간디자이너 양성 아카데미과정을 통한 우수인력 양성’을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_04">사회공헌</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_03_img.jpg'/>" alt="㈜노루페인트" /></dt>
										<dd>
											㈜노루페인트 : 2016년 3월 3일
											<p>‘노루페인트 컬러 전문 교육프로그램의 활성화와 기초디자인 연계 수업을 통해, 우수한 인재 육성과 독립적이고 효율적인 컬러전문가 프로그램 과정＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_04_img.jpg'/>" alt="G마켓" /></dt>
										<dd>
											G마켓_이베이코리아
											<p>‘다양한 디자인 프로젝트 진행을 통해, 창의적이고 우수한 인재 육성과 소자본 패션창업지원＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_05">취업지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_05_img.jpg'/>" alt="이가자 미용학원" /></dt>
										<dd>
											이가자 미용학원 : 2014년 9월 5일
											<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반 업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_06_img.jpg'/>" alt="동부여성발전센터" /></dt>
										<dd>
											동부여성발전센터 : 2016년 10월 31
											<p>‘공동 교육 커리큘럼 개발과 공간디자이너 양성 아카데미과정을 통한 우수인력 양성’을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_04">사회공헌</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_07_img.jpg'/>" alt="(사)한국보석협회" /></dt>
										<dd>
											(사)한국보석협회 : 2016년 11월 15일
											<p>‘보석분야 교육콘텐츠 교류 및 인재양성＇을 목표로 실무산학협력을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_08_img.jpg'/>" alt="한국모델협회" /></dt>
										<dd>
											한국모델협회
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_09_img.jpg'/>" alt="(사)한국미용건강총연합회중앙회" /></dt>
										<dd>
											(사)한국미용건강총연합회중앙회 : 2014년 11월 13일
											<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문이력의 양성과 대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_05">취업지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_10_img.jpg'/>" alt="㈜베베케어" /></dt>
										<dd>
											㈜베베케어
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산합협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_11_img.jpg'/>" alt="㈜빗경" /></dt>
										<dd>
											㈜빗경 : 2016년 11월 22일
											<p>양사 관계증진과 미용〮뷰티헬스케어 등의 뷰티산업과 교육산업에서 주도적인 역할을 하며, 우수 인재의 양성을 통한 지식기반 일자리 창출에 공동 노력함과 동시에 대학의 지역사회 공헌과 기업의 사회적 의무를 성실히 수행하기 위해 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_12_img.jpg'/>" alt="미대편입 CHANGJO" /></dt>
										<dd>
											미대편입 CHANGJO : 2016년
											<p>‘졸업학위증 수여에 필요한 학점인정 국가자격 취득과정의 독립성과 효율성 향상＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_13_img.jpg'/>" alt="Dusol By BEAUTY ACADEMY" /></dt>
										<dd>
											Dusol By BEAUTY ACADEMY : 2016년 6월 3일
											<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반 업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_14_img.jpg'/>" alt="(주)플러스 디자인" /></dt>
										<dd>
											(주)플러스 디자인
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_15_img.jpg'/>" alt="가인미가" /></dt>
										<dd>
											가인미가 : 2016년 4월 23일
											<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하며 양 기관의 제반 업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_16_img.jpg'/>" alt="글램핑코리아" /></dt>
										<dd>
											글램핑코리아
											<p>‘실질적인 홍보 영상제작의 기회와 다양한 프로젝트 진행, 취업연계 프로그램을 통해, 양 기관의 발전과 기업의 사회적 의무를 성실히 수행하기 위해 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_04">사회공헌</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_17_img.jpg'/>" alt="Hestia" /></dt>
										<dd>
											Hestia : 2016년 4월 23일
											<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반 업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_18_img.jpg'/>" alt="혜미인뷰티 아카데미" /></dt>
										<dd>
											혜미인뷰티 아카데미 : 2012년 11월 1일
											<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반 업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_19_img.jpg'/>" alt="아이디 아이피" /></dt>
										<dd>
											아이디 아이피
											<p>‘다양한 전공 관련 행사와 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_20_img.jpg'/>" alt="속눈썹 전문샵 쉬즈 아이래쉬" /></dt>
										<dd>
											속눈썹 전문샵 쉬즈 아이래쉬 : 2014년 11월 13일
											<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과 대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_05">취업지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_21_img.jpg'/>" alt="월간 INTERNI & DECOR" /></dt>
										<dd>
											월간 INTERNI & DECOR
											<p>‘인테리어 트랜드 세미나 특강과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_22_img.jpg'/>" alt="아이네 클라이네" /></dt>
										<dd>
											아이네 클라이네
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_23_img.jpg'/>" alt="㈜미래보석감정원" /></dt>
										<dd>
											㈜미래보석감정원 : 2016년 11월 8일
											<p>‘보석감정 및 쥬얼리 마스터 자격증 교육을 통한 전문 인재양성＇을 목표로 실무산합협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_24_img.jpg'/>" alt="㈜케이아이 디자인" /></dt>
										<dd>
											㈜케이아이 디자인
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_25_img.jpg'/>" alt="LAB01 디자인" /></dt>
										<dd>
											LAB01 디자인
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_26_img.jpg'/>" alt="국제속눈썹전문가협회" /></dt>
										<dd>
											국제속눈썹전문가협회 : 2014년 10월 08일
											<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과 대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_05">취업지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_27_img.jpg'/>" alt="㈜Medinex" /></dt>
										<dd>
											㈜Medinex
											<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반 업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_28_img.jpg'/>" alt="메종 텍스타일" /></dt>
										<dd>
											메종 텍스타일
											<p>‘다양한 전공 관련 행사와 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_29_img.jpg'/>" alt="㈜올가휴" /></dt>
										<dd>
											㈜올가휴 : 2016년 11월 28일
											<p>양사 관계증진과 미용〮뷰티헬스케어 등의 뷰티산업과 교육산업에서 주도적인 역할을 하며, 우수 인재의 양성을 통한 지식기반 일자리 창출에 공동 노력함과 동시에 대학의 지역사회 공헌과 기업의 사회적 의무를 성실히 수행하기 위해 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_30_img.jpg'/>" alt="레인보우 코스메팅" /></dt>
										<dd>
											레인보우 코스메팅 : 2014년 11월 13일
											<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과 대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_05">취업지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_31_img.jpg'/>" alt="루디아 헤어디자인 아카데미" /></dt>
										<dd>
											루디아 헤어디자인 아카데미 : 2016년 6월 12일
											<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반 업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_32_img.jpg'/>" alt="RUIKD" /></dt>
										<dd>
											RUIKD : 2016년 10월 18일
											<p>미용〮뷰티코디네이트 등의 교육산업에서 주도적인 역할을 할 수 있도록 협력하여 양 기관 이미지 제고와 미래교육산업 증대에 기여하기 위해 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_33_img.jpg'/>" alt="크리스챤소보 뷰티 아카데미" /></dt>
										<dd>
											크리스챤소보 뷰티 아카데미 : 2010년 9월 16일
											<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반 업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_34_img.jpg'/>" alt="㈜에스아이디앤씨" /></dt>
										<dd>
											㈜에스아이디앤씨
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_35_img.jpg'/>" alt="㈜솔비 앤 솔비니" /></dt>
										<dd>
											㈜솔비 앤 솔비니
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_36_img.jpg'/>" alt="㈜쏘유" /></dt>
										<dd>
											㈜쏘유
											<p>‘다양한 전공 관련 행사와 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_37_img.jpg'/>" alt="㈜공간추계" /></dt>
										<dd>
											㈜공간추계
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_38_img.jpg'/>" alt="스타일셀러 ㈜아이엠모델" /></dt>
										<dd>
											스타일셀러 ㈜아이엠모델 : 2016년 11월 8일
											<p>‘다양한 디자인 프로젝트 진행을 통해, 창의적이고 우수한 인재 육성과 소자본 패션창업지원＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_05">취업지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_39_img.jpg'/>" alt="㈜토즈스튜디오" /></dt>
										<dd>
											㈜토즈스튜디오 : 2016년 11월 11일
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_40_img.jpg'/>" alt="컬러니크 ㈜더유핏" /></dt>
										<dd>
											컬러니크 ㈜더유핏
											<p>‘산∙학 연계를 통해 창의적이며 고객친화적인 화장품 개발과 다양한 프로젝트 진행, 취업연계 프로그램을 통해, 양 기관의 발전과 기업의 사회적 의무를 성실히 수행하기 위해 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_04">사회공헌</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_41_img.jpg'/>" alt="ALL THAT BEAUTY ACADEMY" /></dt>
										<dd>
											ALL THAT BEAUTY ACADEMY : 2016년 1월 26일
											<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반 업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_42_img.jpg'/>" alt="나이스미디어" /></dt>
										<dd>
											나이스미디어 : 2014년 1월 24일
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_43_img.jpg'/>" alt="에이비전" /></dt>
										<dd>
											에이비전 : 2016년 2월 22일
											<p>‘다양한 디자인 프로젝트 진행과 취업연계 프로그램을 통해, 창의적이고 우수한 인재 육성＇을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_44_img.jpg'/>" alt="(사)월드뷰티아트협회" /></dt>
										<dd>
											(사)월드뷰티아트협회 : 2016년 2월
											<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과 대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
										<li class="icon_05">취업지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_45_img.jpg'/>" alt="KBS 미디어텍 뷰티아카데미" /></dt>
										<dd>
											KBS 미디어텍 뷰티아카데미 : 2017년 2월 2일
											<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과 대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_46_img.jpg'/>" alt="슈반뷰티아카데미" /></dt>
										<dd>
											슈반뷰티아카데미 : 2017년 2월 2일
											<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과 대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
								<div class="partner_info">
									<dl>
										<dt><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/news_part_47_img.jpg'/>" alt="오라클" /></dt>
										<dd>
											오라클 : 2016
											<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과 대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
										</dd>
									</dl>
									<ul class="info_icon">
										<li class="icon_01">취업연계</li>
										<li class="icon_02">공동연구</li>
										<li class="icon_03">전공지원</li>
									</ul>
								</div>
							</dd>
						</dl>
					</div>
					<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
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
</form>
</body>
</html>