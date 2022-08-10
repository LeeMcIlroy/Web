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
							<jsp:param name="dept2" value="미용학(one-day)" />
							<jsp:param name="dept3" value="전공안내" />
						</jsp:include>

						<div class="top_tab type_li2">
							<ul>
								<li
									<c:if test="${searchVO.menuType eq '01' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneInfo.do?menuType=01'/>">전공
										소개</a></li>
								<li
									<c:if test="${searchVO.menuType eq '02' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneInfo.do?menuType=02'/>">함께하는 기업들</a></li>
									<%-- 	
								<li
									<c:if test="${searchVO.menuType eq '03' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneInfo.do?menuType=04'/>">진출분야
										및 자격증</a></li>
										 --%>
							</ul>
						</div>
						<c:if test="${searchVO.menuType eq '01' }">
							<div class="sub_cont_page">
								<dl class="info_dl">
									<dd>
										<p>
											<span>미용은 디자이너가 되어야 한다!</span><br> 한디원 미용학 전공(One Day)은
											“미용은 디자인종합예술이다.“라는 모토를 바탕으로 미용 산업체와 미용관련분야의 전문 인력양성을 목적으로 하고
											있습니다.
										</p>

										<p>이에 한디원 미용학 전공은 다양한 기업과 MOU를 맺고, 살아 숨 쉬는 실무교육을 진행하고자, 현직
											CEO 및 각 분야의 전문가 분들을 초빙하여 미래지향적 인재교육을 펼쳐가고 있습니다. 뿐만 아니라 급변하는
											미용 산업체에서 우위를 선점하기 위해, 멀티플레이능력과 1인 2역할 능력함양을 통해, 사회적
											니즈(needs)또한 충족할 수 있는 교육커리큘럼을 준비하고 있습니다.</p>

										<p>
											한디원 미용학 전공에서는 최근 시대적 관심을 받고 있는 디자인베이스를 바탕으로 <span>[헤어디자이너,
												메이크업디자이너, 네일디자이너, 피부디자이너, 래쉬·컨투어코디네이터] </span>분야로 진출할 수 있도록, 미용분야뿐만
											아니라 디자인분야에 이르기까지 미용인으로써 갖추어야할 폭넓은 기반지식을 학습 할 수 있도록 하고 있습니다.
										</p>

										<p>
											<strong>1. 교원능력개발프로그램(차별교육)</strong> <br />진정한 1%의 미용전문인
											“교원능력개발 프로그램” 으로  현장과 교육기관에서 요구되는 교원을 양성합니다.
										</p>

										<p>
											<strong>2. 졸업 전 조기 취업</strong> <br />
											<span>“TWINS(쌍둥이)실무시스템 프로그램”</span> 으로  현재 헤어샵, 네일샵, 피부샵,
											메이크업샵 등과 똑같은 시설에서 실제 고객을 대상으로 수업이 진행됨으로 숙련가 완성 과정의 시간을 절약하여
											산업체에서 빠르게 개인의 부가가치를 높일 수 있게 합니다.
										</p>

										<p>
											<strong>3. 주1일/ 주2일 체계적인 수업이 진행됩니다.</strong>

										</p>

										<p>
											<strong>4. 학업과 직장생활 병행</strong> <br />주1회 또는 주2회(화,목, 토, 일요일
											중 택1)를 기본으로 이론수업과 실습수업을 진행하여 학교를 다니면서 취업이 가능하며, 직장생활을 병행하여
											학위를 취득할 수 있습니다.
										</p>

										<p>
											<strong>5. 시간 활용 가능</strong> <br />수업이 진행되는 시간 외에 여유시간을 공부,
											취업, 외부활동 등에 활용할 수 있어 자기계발이 가능합니다.
										</p>

										<p>
											<strong>6. 미용학(One Day) 또한 교원능력개발 프로그램과 쌍둥이 실무시스템 모두
												적용됩니다.</strong>

										</p>

									</dd>
								</dl>
								<dt>&nbsp;</dt>
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
						</c:if>
						<c:if test="${searchVO.menuType eq '02' }">
							<div class="sub_cont_page">
								<dl class="info_dl">
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_01_img.jpg'/>"
														alt="오라클" />
												</dt>
												<dd>
													오라클: 2016
													<p>산학협력의 취지에 입각하여 산업체에세 필요로 하는 경쟁력을 갖춘 창조적 전문 인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_02_img.jpg'/>"
														alt="빨간풍선뷰티아카데미" />
												</dt>
												<dd>
													빨간풍선뷰티아카데미 : 2017년 03월 08일
													<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_03_img.jpg'/>"
														alt="슈반뷰티아카데미" />
												</dt>
												<dd>
													슈반뷰티아카데미 : 2017년 2월 2일
													<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_04_img.jpg'/>"
														alt="KBS 미디어텍 뷰티아카데미" />
												</dt>
												<dd>
													KBS 미디어텍 뷰티아카데미 : 2017년 2월 2일
													<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_05_img.jpg'/>"
														alt="(사)월드뷰티아트협회" />
												</dt>
												<dd>
													(사)월드뷰티아트협회 : 2016년 2월
													<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_06_img.jpg'/>"
														alt="ALL THAT BEAUTY ACADEMY" />
												</dt>
												<dd>
													ALL THAT BEAUTY ACADEMY : 2016년 1월 26일
													<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반
														업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_07_img.jpg'/>"
														alt="(사)한국미용건강총연합회중앙회" />
												</dt>
												<dd>
													(사)한국미용건강총연합회중앙회 : 2014년 11월 13일
													<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문이력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_08_img.jpg'/>"
														alt="㈜빗경" />
												</dt>
												<dd>
													㈜빗경 : 2016년 11월 22일
													<p>양사 관계증진과 미용〮뷰티헬스케어 등의 뷰티산업과 교육산업에서 주도적인 역할을 하며, 우수
														인재의 양성을 통한 지식기반 일자리 창출에 공동 노력함과 동시에 대학의 지역사회 공헌과 기업의 사회적
														의무를 성실히 수행하기 위해 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_09_img.jpg'/>"
														alt="Dusol By BEAUTY ACADEMY" />
												</dt>
												<dd>
													Dusol By BEAUTY ACADEMY : 2016년 6월 3일
													<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반
														업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_10_img.jpg'/>"
														alt="가인미가" />
												</dt>
												<dd>
													가인미가 : 2016년 4월 23일
													<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하며 양 기관의 제반
														업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_11_img.jpg'/>"
														alt="Hestia" />
												</dt>
												<dd>
													Hestia : 2016년 4월 23일
													<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반
														업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_12_img.jpg'/>"
														alt="혜미인뷰티 아카데미" />
												</dt>
												<dd>
													혜미인뷰티 아카데미 : 2012년 11월 1일
													<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반
														업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_13_img.jpg'/>"
														alt="이가자 미용학원" />
												</dt>
												<dd>
													이가자 미용학원 : 2014년 9월 5일
													<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반
														업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_14_img.jpg'/>"
														alt="속눈썹 전문샵 쉬즈 아이래쉬" />
												</dt>
												<dd>
													속눈썹 전문샵 쉬즈 아이래쉬 : 2014년 11월 13일
													<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_15_img.jpg'/>"
														alt="국제속눈썹전문가협회" />
												</dt>
												<dd>
													국제속눈썹전문가협회 : 2014년 10월 08일
													<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_16_img.jpg'/>"
														alt="㈜Medinex" />
												</dt>
												<dd>
													㈜Medinex
													<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반
														업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_17_img.jpg'/>"
														alt="㈜올가휴" />
												</dt>
												<dd>
													㈜올가휴 : 2016년 11월 28일
													<p>양사 관계증진과 미용〮뷰티헬스케어 등의 뷰티산업과 교육산업에서 주도적인 역할을 하며, 우수
														인재의 양성을 통한 지식기반 일자리 창출에 공동 노력함과 동시에 대학의 지역사회 공헌과 기업의 사회적
														의무를 성실히 수행하기 위해 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_18_img.jpg'/>"
														alt="레인보우 코스메팅" />
												</dt>
												<dd>
													레인보우 코스메팅 : 2014년 11월 13일
													<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_19_img.jpg'/>"
														alt="루디아 헤어디자인 아카데미" />
												</dt>
												<dd>
													루디아 헤어디자인 아카데미 : 2016년 6월 12일
													<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반
														업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_20_img.jpg'/>"
														alt="RUIKD" />
												</dt>
												<dd>
													RUIKD : 2016년 10월 18일
													<p>미용ㆍ뷰티코디네이트 등의 교육산업에서 주도적인 역할을 할 수 있도록 협력하여 양 기관 이미지
														제고와 미래교육산업 증대에 기여하기 위해 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_21_img.jpg'/>"
														alt="크리스챤소보 뷰티 아카데미" />
												</dt>
												<dd>
													크리스챤소보 뷰티 아카데미 : 2010년 9월 16일
													<p>국가산업발전에 필요한 인재 양성과 경영기술 및 정보를 개발, 공유하여 양 기관의 제반
														업무협력을 통한 상호 발전도모를 목표로 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_22_img.jpg'/>"
														alt="컬러니크 ㈜더유핏" />
												</dt>
												<dd>
													컬러니크 ㈜더유핏
													<p>‘산∙학 연계를 통해 창의적이며 고객친화적인 화장품 개발과 다양한 프로젝트 진행, 취업연계
														프로그램을 통해, 양 기관의 발전과 기업의 사회적 의무를 성실히 수행하기 위해 실무산학협약을 맺었습니다.</p>
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
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_23_img.jpg'/>"
														alt="(사)월드뷰티아트협회" />
												</dt>
												<dd>
													(사)월드뷰티아트협회 : 2016년 2월
													<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
												</dd>
											</dl>
											<ul class="info_icon">
												<li class="icon_01">취업연계</li>
												<li class="icon_02">공동연구</li>
												<li class="icon_03">전공지원</li>
												<li class="icon_05">취업지원</li>
											</ul>
										</div>
									</dd>
								</dl>
							</div>
							<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
						</c:if>
						<%-- <c:if test="${searchVO.menuType eq '03' }">
							<div class="sub_cont_page">
								<dl class="info_dl">
									<dt>진출분야</dt>
									<dd class="major_icon">
										<div class="area_info">
											<ul>
												<li><p>- 헤어/메이크업/피부/네일/스킨아트/웨딩/모발두피관리 디자이너 및 창업</p>
													<p>- 피부과/성형외과/일반병원 뷰티코디/모발두피관리병원 매니저 및 코디네이터</p>
													<p>- 뷰티 마네킨 디자이너, 뷰티 에디터, 뷰티 텔레마케터</p>
													<p>- 소자본 미용관련 On/off Line 창업</p>
													<p>- 모발 및 두피 관리 전문가</p>
													<p>- 뷰티 스타일리스트</p>
													<p>- 학원 강사 및 교육 전문가</p>
													<p>- 선생님</p>
													<p>- 방과 후 지도교사</p>
													<p>- 대학교 평생교육원 강사 및 교수</p>
													<p>- 대학교 강사 및 교수</p>
													<p>- 미용관련 산업체 입사</p></li>
											</ul>
										</div>
									</dd>
								</dl>
							</div>

							<div class="sub_cont_page">
								<dl class="info_dl">
									<dt>자격증정보</dt>
									<dd class="major_icon">
										<div class="area_info">
											<ul>
												<li><p>- 헤어/메이크업/네일/피부미용 국가 자격증</p>
													<p>- 아로마 테라피</p>
													<p>- 병원 코디네이터</p>
													<p>- 경락</p>
													<p>- 체형관리사</p>
													<p>- 타이 마사지</p>
													<p>- 비만 관리사</p>
													<p>- 이미지 메이킹 국제 체형관리사 자격증</p>
													<p>- 이용사 자격증</p>
													<p>- 미용사 면허증</p>
													<p>- 모발 및 두피관리사 자격증</p>
													<p>- 헤어스타일리스트 1, 2급 강사 자격증</p>
													<p>- 컬러리스트 자격증</p>
													<p>- 메이크업 3급, 2급,1급 기술 강사 자격증</p>
													<p>- 헤나타투 3급, 2급 자격증</p>
													<p>- 헤나타투 인증강사 자격증</p>
													<p>- 네일 2급, 1급 기술 강사 자격증</p>
													<p>- 발 관리 자격증</p>
													<p>- 족구반사 자격증</p>
													<p>- 속눈썹연장 2급, 1급 자격증 등</li>
											</ul>
										</div>
									</dd>
								</dl>
							</div>
						</c:if>
						--%>
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