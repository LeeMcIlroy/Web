<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<form:form commandName="searchVO" id="frm" name="frm">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
		<!-- header area -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
		<!-- //header area -->
		<div class="main_content" id="content">
			<div class="width_box">
				<!-- left menu area-->
				<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
				<!-- //left menu area--> 
				<div class="sub_content">
					<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">
						<c:param name="dept1" value="한디원소개"/>
						<c:param name="dept2" value="한디원소개"/>
					</c:import>
					
					<div class="hd_intro_box">
						<!-- <div class="int_title">디자인의 미래, 기업과 함께하는 한디원</div>
						<ul>
							<li>
								<dl>
									<dt>1. 한성대학교 총장명의 학사학위 취득</dt>
									<dd>
										<div><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/int_img01.jpg'/>" alt="한성대학교 총장명의 학사학위 취득" /></div>
										<ul>
											<li class="hd_icon">실력과 열정으로 4년제 학위 취득</li>
											<li class="hd_icon">대졸취업 OK! 편입 및 대학원 진학 OK!</li>
										</ul>
										<p>
											한디원은 디자인 분야만을 전문으로 다루는 대학부설교육기관으로 졸업 후 한성대학교 총장명의의 4년제 학사학위를 취득할 수 있습니다. 한디원 졸업생들은 4년제 대학졸업자와 동등한 자격으로 원하는 분야로의 취업과 대학원 진학을 활발하게 하고 있습니다.<br><br>
											입학은 쉽지만 졸업은 어려운 선진화된 교육 철학에 따라 수능과 내신성적을 반영하지 않고 잠재력을 지닌 신입생을 선발합니다. 미래를 이끌어갈 최고의 디자이너가 되는 길! 한디원은 누구에게나 열려 있습니다.
										</p>
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt>2. 한디원, 기업을 디자인하다</dt>
									<dd>
										<div><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/int_img02.jpg'/>" alt="기업과 함께하는 한디원" /></div>
										<ul>
											<li class="hd_icon">‘기업연계형 프로젝트 수업(CLPC)’ 확대</li>
											<li class="hd_icon">기업의 상품 디자인 개발을 통한 실무능력 향상</li>
										</ul>
										<p>
											산학혁력(MOU) 기업의 상품개발 디자인 프로젝트를 전공별 수업과제와 연계 진행(학기중 3~4개월)하여 우수한 디자인은 기업이 채택하고 기업은 교육기관에 장학금을 지원하는 선순환적 산학연계교육시스템입니다.<br><br>
											지도교수와 기업관계자의 긴밀한 교류 및 협력 관계를 구축하고, 기업명을 이용한 장학금(빙그레장학금, 삼천리장학금)을 수여하기 때문에 프로젝트에 참여한 학생들은 취업을 위한 스펙을 쌓는데 큰 도움이 됩니다.
										</p>
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt>3. 실무에 강하다! 취업으로 답하다!</dt>
									<dd>
										<div><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/int_img03.jpg'/>" alt="실무에 강하다! 실력에 반하다!" /></div>
										<ul>
											<li class="hd_icon">현장에 강한 실무중심의 교육</li>
											<li class="hd_icon">실질취업률 85%, 전공일치율 86% 달성	</li>
										</ul>
										<p>
											한디원의 교수님은 아무나 될 수 없습니다. 사회 각 분야에서 최고의 디자인 전문가로 인정받은 교수님들이 기업이 원하는 인재를 길러내기 위하여 지금 이 순간에도 한디원 학생들과 함께 끊임없이 연구하고 있습니다.<br><br>
											한디원은 철저한 실무 중심, 실력 위주의 교육을 추구합니다. 화려한 스타 교수를 내세우기보다 인재를 키우는 진정한 교육자가 되겠습니다.
										</p>
									</dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt>4. 지도교수 1:1 멘토링 시스템</dt>
									<dd>
										<div><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/int_img04.jpg'/>" alt="지도교수 1:1 멘토링 시스템" /></div>
										<ul>
											<li class="hd_icon">입학부터 취업까지 밀착 관리</li>
											<li class="hd_icon">진로상담을 통한 높은 재학생 만족도</li>
										</ul>
										<p>
											입학부터 졸업 후 취업까지 책임지는 1:1 멘토링 시스템을 구축하여 한디원 학생들의 대학생활 만족도는 지난 10년간 꾸준히 높아져 왔습니다. 신입생 면접에서 교수님과 학생이 인사를 나누는 그 순간부터 학생을 위한 체계적인 1:1 멘토링 시스템이 시작됩니다.<br><br>
											“재등록률 100%”를 향한 한디원만의 철저한 학생 관리 시스템은 공모전 수상 실적, 대학원 진학률, 취업률 향상으로 검증되고 있습니다.
										</p>
									</dd>
								</dl>
							</li>
						</ul> -->
						<!--<div class="int_title">한성대학교에서 운영하는 학점은행제 교육기관으로 학사학위를 수여합니다.</div>
						<div class="ta_overbox">
							<table class="ta874_ty03" summary="학사학위를 수여를 전공, 학위, 이수내용 순서로 보여줍니다.">
								<caption>학사학위를 수여</caption>
								<colgroup>
									<col style="width:250px;" />
									<col style="width:250px;" />
									<col style="width:374px;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">전공</th>
										<th scope="col">학위(총장명의)</th>
										<th scope="col">이수내용</th>
									</tr>
								</thead>
								<tbody>
									<tr><td>실내디자인</td><td>디자인학사<br>(인테리어디자인전공)</td><td rowspan="6" class="ta_left">
										<ul style="margin-left:40px;">
											<li class="hd_icon">교양학점 30학점 이상</li>
											<li class="hd_icon">전공학점(전공필수/전공선택) 60학점 이상</li>
											<li class="hd_icon">일반선택 제한 없음</li>
											<li class="hd_icon">총합계 140점 이상</li>
										</ul></td></tr>
									<tr><td>시각디자인학</td><td>디자인학사<br>(시각·영상디자인전공)</td></tr>
									<tr><td>산업디자인</td><td>디자인학사<br>(제품디자인전공)</td></tr>
									<tr><td>디지털아트학</td><td>디자인학사<br>(애니메이션전공)</td></tr>
									<tr><td>패션디자인학</td><td>패션학사<br>(패션디자인/패션마케팅전공)</td></tr>
									<tr><td>미용학</td><td>미용학사<br>(뷰티디자인매니지먼트전공)</td></tr>
								</tbody>
							</table>
							<br><br>
							<img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/intor_txt_img07.jpg'/>" alt="" style="margin-top: 10px;"/>
						</div>-->
						<!-- <img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/handiwon-3.png'/>" alt="" style="margin-top: 10px; width:100%;"/> -->
						<img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/handiwon-4.png'/>" alt="" style="margin-top: 10px; width:100%;"/>
						<div class="intro_txt_box">
							<dl>
								<dt>학점은행제란 무엇인가요?</dt>
								<dd>학점은행제(Academic Credit Bank System)란‘학점인정 등에 관한 법률 ’에 따라 학교 안팎에서 이루어지는 다양한 형태의 학습이나 자격을 학점으로 인정하고, 학점이 누적되어 일정 기준을 충족하면 학위취득을 할 수 있는 개방형 학습제도입니다.</dd>
								<dd><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/intor_txt_img01.jpg'/>" alt=""  style="width:30%; height: auto;"/></dd>
							</dl>
						</div>
						<!-- <div class="int_title">한디원만의 교육 철학 교육 3.0</div>
						<p style="line-height:24px; margin-bottom:30px;">
							교육3.0은 전공 간 서로의 경계를 개방하고 학생들 개인별 맞춤형 교육을 바탕으로 학생들의 미래를 최우선으로 한 학생중심적 교육 혁신을 말합니다.<br><br>
							21세기 현대교육은 지금까지 살아온 교육 패러다임으로는 해석할 수 없는 새로운 진화에 직면하게 되었습니다. 정부도 참여와 개방 그리고 찾아가는 서비스를 바탕으로 맞춤형 정부를 외치며 정부3.0시대를 열어가고 있습니다.<br><br>
							이에 한디원은 교육분야에서도‘교육1.0’을 넘어 양방향의‘ 교육2.0’를 구현하고, 이를 발전시켜 개인별 ‘맞춤교육’을 구축하여 ‘교육3.0시대’를 열어가고 있습니다.
						</p>
						<div class="page_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/intor_txt_img05.jpg'/>"></div>
						<div class="int_title">한디원 교육패러다임의 변화</div>
						<div class="page_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/intor_txt_img06.jpg'/>"></div>
						<p style="line-height:24px; margin-top:30px;">
							한디원은 교육3.0을 추진하기 위해 교육커리큘럼에 기업을 적극적으로 참여시키며, 실무현장의 프로젝트를 학교수업에 적용하여 학생들 개개인이 향후 해야 될 업무를 미리 경험하게 하고, 국제적 안목을 높이기 위해 해외답사, 해외디자인봉사, 해외인턴십 등 학생들이 적극적으로 참여하여 본인의 역량을 높일 수 있는 다양한 프로그램들을 제공하고 있습니다.
						</p> -->
					</div>
				
				</div>
			</div>
			<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!-- //footer -->
	</div>
	<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>