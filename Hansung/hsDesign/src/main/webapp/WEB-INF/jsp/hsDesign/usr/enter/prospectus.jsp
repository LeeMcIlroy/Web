<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<!-- <style>
	.ta874_ty06 > thead > tr > th {background-color: #ff9786;}

</style> -->
<body>
	<form:form commandName="searchVO" id="frm" name="frm">
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
			<!-- header area -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
			<!-- //header area -->
			<div class="main_content" id="content">
				<div class="width_box">
					<!-- left menu area-->
					<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
					<!-- //left menu area-->
					<div class="sub_content">
						<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">
							<c:param name="dept1" value="입학안내" />
							<c:param name="dept2" value="신ㆍ편입생 모집요강" />
						</c:import>
						
	           	<!-- 200420추가 -->
	           	<div class="top_tab type_li2">
					<ul>
						<li class="active"><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/prospectus.do'/>">신ㆍ편입생 모집요강</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/eliteProspect.do'/>">일학습엘리트 모집요강</a></li>
					</ul>
				</div>

						<div class="pros_box">
							<div class="pros_title">
								한성대학교 총장명의 학사학위를 받는 또 하나의 방법!<br>한성대학교 부설 디자인아트교육원에서
							</div>
							<p class="pros_txt">한성대학교 부설 디자인아트교육원은 한성대학교에서 운영하는 학점은행제
								학사학위과정으로 디자인분야만 특성화한 디자인 종합예술학교입니다.<br>
								실내디자인, 시각디자인학, 산업디자인, 디지털아트학, 패션디자인학, 미용학 등 6개 전공으로 
								구성되어 있으며 25개의 특성화된 디자인 전공심화과정을 두고 있습니다.</p>
							<!-- <p class="pros_txt">실내디자인, 시각디자인학, 산업디자인, 디지털아트학, 패션디자인학, 미용학 등 6개 전공으로 
								구성되어 있으며 25개의 특성화된 디자인 전공심화과정을 두고 있습니다.</p> -->
							
							<div class="s_tit" style="margin-top: 30px;">모집전공</div>
							<div class="ta_overbox">
								<table class="ta874_ty04"
									summary="모집전공을 구분, 전공, 진출분야, 정원, 학사학위 순서로 보여줍니다.">
									<caption>모집전공</caption>
									<colgroup>
										<col style="width: 15%;" />
										<col style="width: 15%;" />
										<col style="width: %;" />
										<col style="width: 10%;" />
										<col style="width: %;" />
									</colgroup>
									<thead>
										<tr style="height: 50px;">
											<th scope="col">구분</th>
											<th scope="col">전공</th>
											<th scope="col">진출분야</th>
											<th scope="col">정원</th>
											<th scope="col">학사학위</th>
										</tr>
									</thead>
									<tbody>
										
										<tr>
											<td rowspan="7">2+2본교연계과정</td>
											<td>실내디자인</td>
											<td>건축디자인/인테리어디자인<br>VMD·가구디자인 /부동산마케팅</td>
											<td>20</td>
											<td rowspan="6" style="border-right:0;">공간융합디자인학과<br>디자인학사</td>
										</tr>
										<tr>
											<td>시각디자인학</td>
											<td>시각·패키지디자인/광고·브랜드디자인<br>일러스트레이션/웹UX·UI디자인</td>
											<td>30</td>
										</tr>
										<tr>
											<td>산업디자인</td>
											<td>제품·리빙디자인/금속·주얼리디자인<br>운송·자동차디자인</td>
											<td>15</td>
										</tr>
										<tr>
											<td>디지털아트학<br>(디자인)</td>
											<td>영상디자인/성우크리에이터<br>디지털애니메이션/웹툰만화콘텐츠</td>
											<td>15</td>
										</tr>
										<tr>
											<td>디지털아트학<br>(게임)</td>
											<td>게임일러스트레이션/게임개발<br>e스포츠</td>
											<td>15</td>
										</tr>
										<tr>
											<td>패션디자인학</td>
											<td>패션디자인/패션스타일링<br>패션MD·마케팅/패션창업</td>
											<td>20</td>
										</tr>
										<tr>
											<td>미용학</td>
											<td>헤어디자인/메이크업디자인<br>피부디자인</td>
											<td>35</td>
											<td style="border-right:0;">뷰티매니지먼트학과<br>미용학사</td>
										</tr>
										<tr>
											<td rowspan="7">학사학위<br>일반과정</td>
											<td>실내디자인</td>
											<td>건축디자인/인테리어디자인<br>VMD·가구디자인 /부동산마케팅</td>
											<td>20</td>
											<td style="border-right:0;">인테리어디자인전공<br>디자인학사</td>
										</tr>
										<tr>
											<td>시각디자인학</td>
											<td>시각·패키지디자인/광고·브랜드디자인<br>일러스트레이션/웹UX·UI디자인</td>
											<td>30</td>
											<td style="border-right:0;">브랜드·패키지디자인전공<br>디자인학사</td>
										</tr>
										<tr>
											<td>산업디자인</td>
											<td>제품·리빙디자인/금속·주얼리디자인<br>운송·자동차디자인</td>
											<td>15</td>
											<td style="border-right:0;">제품·서비스디자인전공<br>디자인학사</td>
										</tr>
										<tr>
											<td>디지털아트학<br>(디자인)</td>
											<td>영상디자인/성우크리에이터<br>디지털애니메이션/웹툰만화콘텐츠</td>
											<td>15</td>
											<td rowspan="2" style="border-right:0;">영상·애니메이션디자인전공<br>디자인학사</td>
										</tr>
										<tr>
											<td>디지털아트학<br>(게임)</td>
											<td>게임일러스트레이션/게임개발<br>e스포츠</td>
											<td>15</td>
										</tr>
										<tr>
											<td>패션디자인학</td>
											<td>패션디자인/패션스타일링<br>패션MD·마케팅/패션창업</td>
											<td>20</td>
											<td style="border-right:0;">패션디자인전공<br>패션학사</td>
										</tr>
										<tr>
											<td>미용학</td>
											<td>헤어디자인/메이크업디자인<br>피부디자인</td>
											<td>35</td>
											<td style="border-right:0;">뷰티디자인매니지먼트전공<br>미용학사</td>
										</tr>
										<tr>
											<td class="ta_left" colspan="5" style="border-right:0; border-bottom:0;">
												<p>※ 2+2본교연계과정은 한디원에서 2년 동안 일종 요건 충족 후, 한성대학교(계약학과) 3학년으로 편입학하는 과정</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="s_tit" style="margin-top: 30px;">모집일정</div>
							<div class="ta_overbox">
								<table class="ta874_ty04"
									summary="모집일정을 모집시기, 접수일정, 비고 순서로 보여줍니다.">
									<caption>모집일정</caption>
									<colgroup>
										<col style="width: 20%;" />
										<col style="width: 40%;" />
										<col style="width: 40%;" />
									</colgroup>
									<thead>
										<tr style="height: 50px;">
											<th scope="col">모집시기</th>
											<th scope="col">원서접수일정</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1차</td>
											<td>2021. 07. 26 ~ 2021. 08. 12</td>
											<td rowspan="5">상세 전형일정은<br>홈페이지 및 개별 전화 안내</td>
										</tr>
										<tr>
											<td>2차</td>
											<td>2021. 09. 06 ~ 2021. 09. 17</td>
										</tr>
										<tr>
											<td>3차</td>
											<td>2021. 10. 27 ~ 2021. 11. 11</td>
										</tr>
										<tr>
											<td>4차</td>
											<td>2021. 12. 20 ~ 2022. 01. 03</td>
										</tr>
										<tr>
											<td>5차</td>
											<td>2022. 01. 20 ~ 2022. 02. 10</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="s_tit" style="margin-top: 30px;">전형방법</div>
							<div class="ta_overbox">
								<table class="ta874_ty02"
									summary="전형방법을 전공, 전형, 내용, 제출서류  순서로 보여줍니다.">
									<caption>전형방법</caption>
									<colgroup>
										<col style="width: 20%;" />
										<col style="width: 20%;" />
										<col style="width: %;" />
										<col style="width: 15%;" />
										<col style="width: 15%;" />
									</colgroup>
									<thead>
										<tr style="height: 50px;">
											<th scope="col" rowspan="2">전공</th>
											<th scope="col" rowspan="2">전형</th>
											<th scope="col" rowspan="2">내용</th>
											<th scope="col" colspan="2">제출서류</th>
										</tr>
										<tr style="height: 50px;">
											<th scope="col">필수</th>
											<th scope="col">선택</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td rowspan="2">실내디자인<br>시각디자인<br>산업디자인<br>디지털아트학</td>
											<td>실기<br>(100%)</td>
											<td class="ta_left">-방식: 제시된 주제에 대한 콘셉트 드로잉<br>-화지: A3 켄트지(현장 제공)<br>-시간: 120분<br>-화구: 연필, 볼펜, 색연필 등 건식재료<br>-평가기준: 디자인 요소의 이해, 주제해석 <br>및 창의적 표현능력</td>
											<td>학교생활기록부</td>
											<td>학원·학교장 추천서<br>수상실적 증명서</td>
										</tr>
										<tr>
											<td>면접<br>(100%)</td>
											<td class="ta_left">-방식: 개별 면접<br>-시간: 15분 내외<br>-평가기준: 전공 관련 기초소양, 지원동기  <br>및 학업계획(자기소개서 내용 반영)</td>
											<td>자기소개서<br>학교생활기록부</td>
											<td>학원·학교장 추천서<br>수상실적 증명서</td>
										</tr>
										<tr>
											<td>패션디자인학</td>
											<td>면접<br>(100%)</td>
											<td class="ta_left">-방식: 개별 면접<br>-시간: 15분 내외<br>-평가기준: 전공 관련 기초소양, 지원동기   <br>및 학업계획(자기소개서 내용 반영)</td>
											<td>자기소개서<br>학교생활기록부</td>
											<td>학원·학교장 추천서<br>수상실적 증명서</td>
										</tr>
										<tr>
											<td>미용학</td>
											<td>면접<br>(100%)</td>
											<td class="ta_left">-방식: 개별 면접<br>-시간: 15분 내외<br>-평가기준: 전공 관련 기초소양, 지원동기  <br>및 학업계획(자기소개서 내용 반영)</td>
											<td>자기소개서<br>학교생활기록부</td>
											<td>학원·학교장 추천서<br>미용관련 자격증 사본<br>포트폴리오</td>
										</tr>
										<tr>
											<td class="ta_left" colspan="5" style="border-bottom:0;">
												<p>※ 실내디자인, 시각디자인학, 산업디자인, 디지털아트학 전공 지원자는 실기전형과 면접전형 중 선택 지원</p>
												<p>※ 실기전형 지원자에 한해 입학실기우수장학금(첫 학기 수업료 100%) 선정 자격 부여</p>
												<p>※ 디지털아트학 전공의 성우크리에이터, 게임개발, e스포츠 지원자는 면접전형으로만 지원 가능</p>
												<p>※ 학원‧학교장 추천서 제출 시 첫 학기 수업료 20% 장학혜택 부여(전형일 제출에 한함)</p>
												<p>※ 편입학 지원자는 학교생활기록부 대신 전적대학 성적증명서 제출</p>
												<a href="https://edubank.hansung.ac.kr/usr/community/notice/noticeView.do?cbSeq=16904"> <p>※ <u>2022학년도 실기고사 전공별 주제 안내 바로가기</u></p></a>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="s_tit" style="margin-top: 30px;">지원자격</div>
							<div class="ta_overbox">
								<table class="ta874_ty02" summary="지원자격을 구분, 지원자격 순서로 보여줍니다.">
									<caption>지원자격</caption>
									<colgroup>
										<col style="width: 20%;" />
										<col style="width: 80%;" />
									</colgroup>
									<thead>
										<tr style="height: 50px;">
											<th scope="col">구분</th>
											<th scope="col">지원자격</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>신입학</td>
											<td class="ta_left">
												<p>-고등학교 졸업(예정)자</p>
												<p>-법령에 의하여 위와 동등한 학력이 인정되는 자(검정고시)</p>
												<p>-전적대학 또는 학점은행제 기관에서 36학점 미만 취득한 자</p>
											</td>
										</tr>
										<tr>
											<td>편입학</td>
											<td class="ta_left">
												<p>-전문대학 및 대학교 졸업자</p>
												<p>-전적대학 또는 학점은행제 기관에서 36학점 이상 취득한 자</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="s_tit" style="margin-top: 30px;">선발과정</div>
							<div class="ta_overbox">
								<ul class="ctm_ul">
									<li>
										<table class="ta874_ty06">
											<thead>
												<tr>
													<th>원서접수</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>한디원 홈페이지<br/>인터넷 접수</td>
												</tr>
											</tbody>
										</table>
									</li>
									<li class="ctm_ul_li2"><img src="${pageContext.request.contextPath }/assets/usr/img/left_2d_icon_on.png"></li>
									<li>
										<table class="ta874_ty06">
											<thead>
												<tr>
													<th>전형일정</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>홈페이지 및<br>개별 전화 안내</td>
												</tr>
											</tbody>
										</table>
									</li>
									<li class="ctm_ul_li2"><img src="${pageContext.request.contextPath }/assets/usr/img/left_2d_icon_on.png"></li>
									<li>
										<table class="ta874_ty06">
											<thead>
												<tr>
													<th>합격자발표</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>홈페이지 및<br/>SMS 공지</td>
												</tr>
											</tbody>
										</table>
									</li>
									<li class="ctm_ul_li2"><img src="${pageContext.request.contextPath }/assets/usr/img/left_2d_icon_on.png"></li>
									<li>
										<table class="ta874_ty06">
											<thead>
												<tr>
													<th>등록금납부</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>합격자 대상<br/>개별 안내</td>
												</tr>
											</tbody>
										</table>
									</li>
									<li class="ctm_ul_li2"><img src="${pageContext.request.contextPath }/assets/usr/img/left_2d_icon_on.png"></li>
									<li>
										<table class="ta874_ty06">
											<thead>
												<tr>
													<th>입학식</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>2022년<br/>2월말 예정</td>
												</tr>
											</tbody>
										</table>
									</li>
								</ul>
							
							<%--
								<table class="ta874_ty02" summary="선발과정을 구분, 지원자격 순서로 보여줍니다.">
									<caption>선발과정</caption>
									<colgroup>
										<col style="width: 20%;" />
										<col style="width: 80%;" />
									</colgroup>
									<thead>
										<tr style="height: 50px;">
											<th scope="col">구분</th>
											<th scope="col">내용</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>원서접수</td>
											<td class="ta_left">한디원 홈페이지 인터넷 접수</td>
										</tr>
										<tr>
											<td>면접전형일정</td>
											<td class="ta_left">홈페이지 및 개별 전화 안내</td>
										</tr>
										<tr>
											<td>합격자발표</td>
											<td class="ta_left">면접 후 1주일 이내 홈페이지 및 SMS 공지</td>
										</tr>
										<tr>
											<td>등록금납부</td>
											<td class="ta_left">합격자 대상 개별 안내</td>
										</tr>
										<tr>
											<td>입학식</td>
											<td class="ta_left">2019년 2월 말 예정(추후공지)</td>
										</tr>
									</tbody>
								</table>
							--%>
							</div>
							<div class="s_tit" style="margin-top: 30px;">입학 상담</div>
							<p style="line-height: 24px;">1. 전화상담 : 02-760-5533</p>
							<div class="btn_box">
								<a href="<c:out value='${pageContext.request.contextPath }/usr/enter/consult/consultList.do'/>" class="btn_cun">입학상담 바로가기</a>&nbsp;&nbsp; 
								<a href="#" onclick="fn_appliForm_open_sub('01'); return false;" class="btn_aply">신・편입학 원서접수 바로가기</a>&nbsp;&nbsp;
								<a href="<c:url value='https://edubank.hansung.ac.kr/usr/enter/consult/consultView.do?cbSeq=16834'/>" target="_blank" class="btn_kakao">카카오톡 실시간 입학상담</a>
							</div>
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