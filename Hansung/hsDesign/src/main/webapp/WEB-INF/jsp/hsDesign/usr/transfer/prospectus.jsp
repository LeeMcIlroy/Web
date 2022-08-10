<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
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
							<c:param name="dept1" value="편입" />
							<c:param name="dept2" value="모집요강" />
						</c:import>

						<div class="pros_box">
							<div class="pros_title">
								한성대학교 학사학위를 받는 또 하나의 방법!<br>한성대학교 부설 디자인아트교육원에서~
							</div>
							<p class="pros_txt">한성대학교 부설 디자인아트교육원은 한성대학교에서 운영하는 학점은행제
								학사학위과정으로 디자인분야만 특성화한 디자인 종합예술학교입니다.</p>
							<p class="pros_txt">실내디자인, 시각디자인학, 패션디자인학, 패션비즈니스학, 산업디자인,
								디지털아트학, 미용학 등 7개 전공으로 구성되어 있으며 31개의 특성화된 디자인 전공심화과정을 두고 있습니다.</p>
							<div class="s_tit" style="margin-top: 30px;">모집일정</div>
							<div class="ta_overbox">
								<table class="ta874_ty04"
									summary="모집일정을 모집시기, 접수일정, 비고 순서로 보여줍니다.">
									<caption>모집일정</caption>
									<colgroup>
										<col style="width: 20%;" />
										<col style="width: 30%;" />
										<col style="width: 50%;" />
									</colgroup>
									<thead>
										<tr style="height: 50px;">
											<th scope="col">모집시기</th>
											<th scope="col">접수일정</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1차</td>
											<td>2017년 04월 01일 ~ 08월 31일</td>
											<td rowspan="4">면접전형일은 개별적으로 공지</td>
										</tr>
										<tr>
											<td>2차</td>
											<td>2017년 09월 01일 ~ 12월 31일</td>
										</tr>
										<tr>
											<td>3차</td>
											<td>2018년 01월 01일 ~ 01월 31일</td>
										</tr>
										<tr>
											<td>4차</td>
											<td>2018년 02월 01일 ~ 02월 25일</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="s_tit" style="margin-top: 30px;">모집전공</div>
							<div class="ta_overbox">
								<table class="ta874_ty04"
									summary="모집전공을 계열, 전공, 졸업학위, 비고 순서로 보여줍니다.">
									<caption>모집전공</caption>
									<colgroup>
										<col style="width: 20%;" />
										<col style="width: 20%;" />
										<col style="width: 20%;" />
										<col style="width: 40%;" />
									</colgroup>
									<thead>
										<tr style="height: 50px;">
											<th scope="col">계열</th>
											<th scope="col">전공</th>
											<th scope="col">졸업학위</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td rowspan="4">디자인계열</td>
											<td>실내디자인</td>
											<td>디자인학사<br>(인테리어디자인전공)
											</td>
											<td rowspan="8">한성대학교 총장명의<br>4년제 학사학위과정
											</td>
										</tr>
										<tr>
											<td>시각디자인학</td>
											<td>디자인학사<br>(시각영상디자인전공)
											</td>
										</tr>
										<tr>
											<td>산업디자인</td>
											<td>디자인학사<br>(제품디자인전공)
											</td>
										</tr>
										<tr>
											<td>디지털아트학</td>
											<td>디자인학사<br>(애니메이션전공)
											</td>
										</tr>
										<tr>
											<td rowspan="2">패션계열</td>
											<td>패션디자인학</td>
											<td>패션학사<br>(패션디자인전공)
											</td>
										</tr>
										<tr>
											<td>패션비즈니스학</td>
											<td>패션학사<br>(패션마케팅전공)
											</td>
										</tr>
										<tr>
											<td rowspan="2">뷰티계열</td>
											<td>미용학</td>
											<td>미용학사<br>(미용학전공)
											</td>
										</tr>
										<tr>
											<td>미용학<br>(OneDay)
											</td>
											<td>미용학사<br>(미용학전공)
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="s_tit" style="margin-top: 30px;">전형방법</div>
							<div class="ta_overbox">
								<table class="ta874_ty02"
									summary="전형방법을 전형요소, 전공, 전형방법 순서로 보여줍니다.">
									<caption>전형방법</caption>
									<colgroup>
										<col style="width: 20%;" />
										<col style="width: 20%;" />
										<col style="width: 60%;" />
									</colgroup>
									<thead>
										<tr style="height: 50px;">
											<th scope="col">전형요소</th>
											<th scope="col">전공</th>
											<th scope="col">전형방법</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td rowspan="2">전공적성</td>
											<td>디자인계열<br>패션계열
											</td>
											<td class="ta_left">1. 지원동기 및 학업계획에 관한 서술형 문항<br>2.
												전공 관련 객관식 및 스케치 문항
											</td>
										</tr>
										<tr>
											<td>뷰티계열</td>
											<td class="ta_left">1. 지원동기 및 학업계획에 대한 서술형 문항<br>2.
												전공 관련 객관식 문항
											</td>
										</tr>
										<tr>
											<td>면접</td>
											<td>공통</td>
											<td class="ta_left">1. 태도 및 커뮤니케이션 능력 평가<br>2. 전공
												관련 기초 소양 평가
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
											<td class="ta_left">1. 고등학교 졸업(예정)자<br>2. 법령에 의하여
												위와 동등한 학력이 인정되는 자(검정고시 합격 등)<br>3. 전적대학에서 36학점 미만 취득한 자
											</td>
										</tr>
										<tr>
											<td>편입학</td>
											<td class="ta_left">1. 전문대학 및 대학교 졸업자<br>2. 전적대학에서
												36학점 이상 취득한 자<br>3. 학점은행제 기관에서 36학점 이상 취득한 자
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="s_tit" style="margin-top: 30px;">선발과정</div>
							<div class="ta_overbox">
								<table class="ta874_ty02" summary="선발과정을 구분, 지원자격 순서로 보여줍니다.">
									<caption>선발과정</caption>
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
											<td>원서접수</td>
											<td class="ta_left">1~4차 모집기간 중 홈페이지를 통해 접수</td>
										</tr>
										<tr>
											<td>전형일정</td>
											<td class="ta_left">홈페이지 공지, 전화 안내</td>
										</tr>
										<tr>
											<td>합격자 발표</td>
											<td class="ta_left">면접 후 1주일 이내 홈페이지 및 SMS 통지</td>
										</tr>
										<tr>
											<td>등록금 납부</td>
											<td class="ta_left">합격자 대상 개별 안내</td>
										</tr>
										<tr>
											<td>입학식</td>
											<td class="ta_left">2018년 2월 말 예정(추후 공지)</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="s_tit" style="margin-top: 30px;">선발기준</div>
							<p style="line-height: 24px;">
								- 전공적성평가 및 심층면접<br>- 수능 및 내신성적 미반영
							</p>
							<div class="s_tit" style="margin-top: 30px;">구비서류</div>
							<div class="ta_overbox">
								<table class="ta874_ty02" summary="구비서류를 구분, 구비서류 순서로 보여줍니다.">
									<caption>구비서류</caption>
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
											<td class="ta_left">- 고등학교 생활기록부 1부<br> - 증명사진 2매
											</td>
										</tr>
										<tr>
											<td>편입학</td>
											<td class="ta_left">- 전적대학 성적증명서 1부<br> - 증명사진 2매
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="s_tit" style="margin-top: 30px;">편입 상담</div>
							<p style="line-height: 24px;">- 전화 : 02-760-5533~5</p>
							<div class="btn_box">
								<a href="<c:out value='${pageContext.request.contextPath }/usr/transfer/consult/consultList.do'/>" class="btn_cun">편입상담 바로가기</a>&nbsp;&nbsp; 
								<a href="<c:url value='https://nid.naver.com/nidlogin.login?svctype=64&url=https%3A%2F%2Ftalk.naver.com%2Fct%2Fwca9kn%3Fref%3Dhttps%253A%252F%252Fedubank.hansung.ac.kr%252F%26nidref%23nafullscreen'/>" target="_blank" class="btn_naver">네이버 톡톡 실시간 상담</a>
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