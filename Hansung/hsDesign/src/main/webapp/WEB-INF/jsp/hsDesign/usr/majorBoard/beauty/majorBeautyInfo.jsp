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
		            <jsp:param name="dept3" value="전공안내"/>
	           	</jsp:include>
				
				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyInfo.do?menuType=01'/>">뷰티2+2 본교 연계과정</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyInfo.do?menuType=02'/>">전공 소개</a></li>
					</ul>
				</div>	
				
				<div class="sub_cont_page">
					<c:if test="${searchVO.menuType eq '01' }">
						<p class="area_info">
							한성대학교는 ‘진리(眞理)ㆍ지선(至善)’이라는 교육이념을 바탕으로 공동선(公同善)을 추구하는 창조적 인재를 양성하는데 교육목적을 두고 있다. 산업교육을 진흥하고, 산학협력을 촉진함으로써 산업사회의 요구에 부응하는 창의력있는 산업인력을 양성한다. 
							산업발전에 필요한 새로운 지식과 기술을 개발, 보급하여 산업사회 발전에 이바지하며, 21세기 세계화 시대에 부응하는 실무중심의 현장인력 재교육으로 전문 인력을 양성한다.산업체 수요에 의한 맞춤형 직업교육 체제(Work to School)를 대학교육과정에 도입하여, 
							실무가 가능한 인재양성에 대한 대학의 역할 및 산업체 등의 수요에 대한 맞춤형으로 구성되어 있다.					
						</p>
					
					<div class="s_tit">진출분야</div>
					<p class="area_info">
						<!-- 헤어디자이너, 메이크업, 에스테틱, 네일 -->
						헤어디자이너, 메이크업, 에스테틱, 네일, 특수분장
					</p>
						<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_01.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_02.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_03.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_04.png" style="width: 100%;"/></br>
						<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_05.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_06.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_07.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_08.png" style="width: 100%;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_09.png" style="width: 100%;"/>
					</c:if>
					<c:if test="${searchVO.menuType eq '02' }">
						<dl class="info_dl">
							<dd>
								<p>
								<span>모든 것을 아름답게 디자인한다!</span><br>

								한디원 미용학전공은 “우리 삶의 모든 것을 아름답게 디자인한다. “라는 모토를 가지고 삶의 질 향상과 미용분야의 전문 인력 양성을 목적으로 하고 있습니다.</p>
								<p>
								급변하는 시대적 변화와 4만 불 시대의 사회적 니즈(needs)를 반영하여 미용을 통한 새로운 아름다움을 창출하고 사회가 필요로 하는 인재교육을 담아내고자 교육커리큘럼을 준비하였습니다. 이에 한디원 미용학 전공은 다양한 기업과 MOU를 맺고 살아 있는 실무교육을 진행하고자 현직 CEO 및 각 분야 전문가를 초빙하여 미래지향적 인재교육을 펼쳐가고 있습니다.</p>
							</dd>
							<dd>
								<dl class="info_dl_txt">
									<dt>	한디원만의 차별화된 뷰티 & 헬스 디자이너 양성 교육</dt>
										<dd>	한디원 미용전공에서는 뷰티 & 헬스 전문 교육과 동시에 디자인 전문 교육이 이루어집니다. 최근 웰니스 트랜드에 맞춰 새로운 시장으로 급성장하고 있고 관심을 받고 있는 <span>[헤어 스타일리스트, 뷰티 헬스케어, 메디컬 뷰티코디네이트] </span>분야의 산업체에서 필요한 창의적인 인재 양성을 목표로 하여 뷰티 & 헬스 분야의 기술 교육은 물론 통합의료지식, 예술 및 디자인 교육을 접목하여 폭넓은 지식 기반을 학습하도록 설계되었습니다. 한성대학교 디자인교육의 차별화된 융합교육을 제공함으로써 한디원의 미용학 전공자들은 뷰티 & 헬스 센터의 매니저와 기획 및 디자이너의 기능을 동시에 수행할 수 있는 전문적이고 실용적인 고급 인재로 성장합니다.</dd>


									<dt>	ITEC(International Therapy Exam Council) 국제 자격증 취득	</dt>
										<dd>	한디원 미용학 전공 교과 과정은 글로벌 뷰티&헬스 디자이너 양성을 목표로 하여 전 세계 43개국에서 인정받는 ITEC 국제 뷰티&헬스 테라피스트 자격 인증 센터의 커리큘럼에 맞춰 설계되었습니다. 4년간의 미용학 전공 교과 과정을 마침과 동시에 뷰티, 헬스, 메디컬 분야의 다양한 ITEC 디플로마를 취득할 수 있도록 함으로써 국내·외 뷰티 & 헬스 산업체에 취업이 가능한 전문 기능인 양성으로 글로벌 경쟁력을 갖추게 됩니다.</dd>

										<dd><div class="area_info">
											<ul>
												<li><p>- Complementary Therapies (해부생리, 홀리스틱마사지, 아로마테라피, 헤드마사지, 임상영양 등)</p>
												<p>- Sports & Fitness Training (스포츠마사지, 트레이너 등)</p>
												<p>- Beauty & Spa Therapy (스킨케어, 메디컬스킨케어, 네일아트, 메이크업, 스파트리트먼트 등)</p>
												<p>- Hairdressing (컬러링, 커팅, 바버링, 퍼머너트 등)</p>
												<p>- Customer Service (비지니스 등)</p>
												<p>- Education & Training (교육강사 등)</p>
											</li>
											</ul>
										</div>
									</dd>
								</dl>
							</dd>
						</dl>
						<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_04.png" style="width: 100%;"/>
					
					<%--
					<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_2+2_07.png'/>" alt="뷰티2+2 연계과정">
					<img src="${pageContext.request.contextPath }/assets/usr/img/beauty/beautyInfo_02.jpg"/>
					--%>
					
				
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_2+2_01.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_2+2_02.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_2+2_03.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_2+2_04.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_2+2_05.png'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beautyOne/bt_2+2_06.png'/>" /></li>
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
						<%-- <dl class="info_dl">
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_01_img.jpg'/>" alt="오라클" /></dt>
										<dd>
											오라클: 2016
											<p>산학협력의 취지에 입각하여 산업체에세 필요로 하는 경쟁력을 갖춘 창조적 전문 인력의 양성과 대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_02_img.jpg'/>" alt="빨간풍선뷰티아카데미" /></dt>
										<dd>
											빨간풍선뷰티아카데미 : 2017년 03월 08일
											<p>산학협력의 취지에 입각하여 산업체에서 필요로 하는 경쟁력을 갖춘 창조적 전문인력의 양성과 대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_03_img.jpg'/>" alt="슈반뷰티아카데미" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_04_img.jpg'/>" alt="KBS 미디어텍 뷰티아카데미" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_05_img.jpg'/>" alt="(사)월드뷰티아트협회" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_06_img.jpg'/>" alt="ALL THAT BEAUTY ACADEMY" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_07_img.jpg'/>" alt="(사)한국미용건강총연합회중앙회" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_08_img.jpg'/>" alt="㈜빗경" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_09_img.jpg'/>" alt="Dusol By BEAUTY ACADEMY" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_10_img.jpg'/>" alt="가인미가" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_11_img.jpg'/>" alt="Hestia" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_12_img.jpg'/>" alt="혜미인뷰티 아카데미" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_13_img.jpg'/>" alt="이가자 미용학원" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_14_img.jpg'/>" alt="속눈썹 전문샵 쉬즈 아이래쉬" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_15_img.jpg'/>" alt="국제속눈썹전문가협회" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_16_img.jpg'/>" alt="㈜Medinex" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_17_img.jpg'/>" alt="㈜올가휴" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_18_img.jpg'/>" alt="레인보우 코스메팅" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_19_img.jpg'/>" alt="루디아 헤어디자인 아카데미" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_20_img.jpg'/>" alt="RUIKD" /></dt>
										<dd>
											RUIKD : 2016년 10월 18일
											<p>미용ㆍ뷰티코디네이트 등의 교육산업에서 주도적인 역할을 할 수 있도록 협력하여 양 기관 이미지 제고와 미래교육산업 증대에 기여하기 위해 실무산학협약을 맺었습니다.</p>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_21_img.jpg'/>" alt="크리스챤소보 뷰티 아카데미" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_22_img.jpg'/>" alt="컬러니크 ㈜더유핏" /></dt>
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
										<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part_23_img.jpg'/>" alt="(사)월드뷰티아트협회" /></dt>
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
							</dd>
						</dl> --%>
					<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
					</c:if>
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