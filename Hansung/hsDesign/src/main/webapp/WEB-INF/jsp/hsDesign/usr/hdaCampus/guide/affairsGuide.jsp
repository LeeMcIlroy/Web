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
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="학사안내"/>
		            <jsp:param name="dept2" value="학사정보"/>
	           	</jsp:include>
				
				<div class="top_tab type_li4">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/guide/affairsGuide.do?menuType=01'/>">Ⅰ. 수강신청 / 계절학기</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/guide/affairsGuide.do?menuType=02'/>">Ⅱ. 등록 / 장학</a></li>
						<li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/guide/affairsGuide.do?menuType=03'/>">Ⅲ. 학적변동(휴․복학, 자퇴, 제적, 재입학)</a></li>
						<li <c:if test="${searchVO.menuType eq '04' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/guide/affairsGuide.do?menuType=04'/>">Ⅳ. 증명서 및 학생증 발급 / 시설이용</a></li>
					</ul>
				</div>
				<c:if test="${searchVO.menuType eq '01' }">
					<div class="s_tit">Ⅰ. 수강신청 / 계절학기</div>
					<ol class="ag_box">
						<li>1. 수강신청
							<dl>
								<dt>가. 수강신청 기간</dt>
								<dd>
									- 수강신청은 일반적으로 개강 2주~3주전에 실시한다.<br>
									- 공휴일 및 학사일정에 따라 매년 달라지니 교학팀의 공지를 따른다.
								</dd>
							</dl>
							<dl>
								<dt>나. 수강신청 방법</dt>
								<dd>
									- 신입생 : 전공사무실의 안내에 따름<br>
									&nbsp;&nbsp;&nbsp;* 입학식 및 오리엔테이션 중 일괄 공지<br>
									- 재학생 : 학사정보시스템(http://edulms.hansung.co.kr/)을 통해 개별신청
								</dd>
							</dl>
							<dl>
								<dt>다. 수강신청 정정</dt>
								<dd>
									- 수강신청 정정은 개강 후 1주일이 지난 뒤 수강신청 정정기간에만 가능하다.<br>
									- 수강신청 정정기간은 공휴일 및 학사일정에 따라 매년 달라지니 교학팀의 공지를 따른다.<br>
									- 수강신청 정정 절차 : 수강신청 정정원 작성 → 학송관 208호 교학팀 제출
								</dd>
							</dl>
							<dl>
								<dt>라. 관련 주의사항</dt>
								<dd>
									- 수강신청 정정은 정원, 분반 등의 이유로 학생이 원하는 대로 정정이 어려울 수 있으니 반드시 최초 수강신청 때 신중을 기하도록 한다.<br>
									- 학사학위 취득희망자의 학점이수는 한 교육기관에서 105학점 이상을 넘을 수 없다.<br>
									- 연간 인정학점은 42학점을 넘을 수 없으며, 학기당 인정학점은 24학점을 넘을 수 없음을 유의한다.<br>
									&nbsp;&nbsp;&nbsp;* 예) 1학기에 24학점 수강 시 2학기에는 18학점 수강가능 /1학기에 21학점 수강 시 2학기에 21학점 수강<br>
									- 학사학위 취득을 위해서는 전체 140학점 이상을 취득해야 하며, 이수구분(전공, 교양, 일반선택)별 취득학점, 전공별 필수이수과목 및 자신의 학업계획을 잘 고려하여 수강신청 한다.<br>
									- 외부강의(타 기관 시간제)는 수강신청 정정이 불가하다.<br>
									- 외부강의(타 기관 시간제)는 외부 교육기관의 일정 및 규정을 따른다.
								</dd>
							</dl>
							<dl>
								<dt>마. 재수강</dt>
								<dd>
									- 재수강 과목은 연간 인정학점 제한에 포함된다. 재수강 시 학기당 인정학점인 24학점, 연간 인정학점인 42학점을 초과하지 않도록 주의한다.<br>
									- 동일한 과목은 2번 이상 수강하여도 1개의 과목으로 학점 인정된다. 이에 학생은 자신이 원하는 과목을 선택하여 인정받도록 한다.<br>
									- 재수강 혹은 학점 초과 등의 이유로 국가평생교육진흥원에서 학점인정을 받은 과목을 취소해야 할 시에는 학점인정 신청 기간에국가평생교육진흥원 웹사이트를 통해서 직접 취소하거나 학송관 208호 교학팀을 방문하여 취소할 수 있다.<br>
									- F학점을 받은 과목은 학점취득 실패로 이수학점으로 인정되지 않는다. 해당 과목의 재수강은 학생의 의사에 따라 결정한다.
								</dd>
							</dl>
							<dl>
								<dt>바. 계절학기</dt>
								<dd>
									- 계절학기는 종강 1주일 뒤부터 8주간 진행된다.<br>
									- 계절학기는 직전학기 F학점 취득 예정자, 재수강 희망자, 자격시험 응시를 위한 최소학점 미달자에 한해 수강 가능하다.<br>
									&nbsp;&nbsp;&nbsp;* 산업기사자격증시험에 응시하기 위해서는 총 41학점 이상을 이수해야 함<br>
									- 수강신청기간에 학사정보시스템을 통해 신청하거나 교학팀에서 직접 신청한다.<br>
									- 과목별 수강정원에 따라 수강신청이 조기에 마감될 수 있으며, 반면에 수강신청 인원이 15명 미만인 과목은 폐강 될 수 있다.<br>
									- 성적평가는 정규학기 성적평가 방법과 동일하다.<br>
									- 하계 계절학기는 1학기 이수학점, 동계 계절학기는 2학기 이수학점에 포함된다. 따라서 1학기에 2과목 이상에서 F학점을 받았을 경우, 동계 계절학기에 한꺼번에 이수할 수 없다.아래의 이수학점제한 규정을 숙지하고 수강신청을 하도록 한다.<br>
									&nbsp;&nbsp;&nbsp;* 예) 1학기 24학점 수강 시 하계 계절학기 수강불가, 2학기 18학점 수강 가능
								</dd>
							</dl>
						</li>
					</ol>
				</c:if>
				<c:if test="${searchVO.menuType eq '02' }">
					<div class="s_tit">Ⅱ. 등록 / 장학</div>
					<ol class="ag_box">
						<li>1. 등록금 분할납부제
							<dl>
								<dt>가. 등록금 분할납부제</dt>
								<dd>
									- 본원에서는 학생들의 등록금부담을 줄이기 위하여 등록금 분할납부제를 실시하고 있다.<br>
									- 등록금 분할납부를 희망하는 학생은 분할납부신청 및 서약서를 작성하고 분할납부 신청기간에 이를 제출해야한다.<br>
									- 다음 학기의 등록금 분할납부 신청은 직전 학기 말에 시행하나 학사 행정일정에 따라 달라지니 교학팀의 공지를 참조한다.
								</dd>
							</dl>
							<dl>
								<dt>나. 등록금 분할납부 신청 절차</dt>
								<dd>
									- 분할납부 신청 및 서약서 작성 → 학송관 208호 교학팀 제출<br>
									- 1,2,3차 등록금 분할납부는 일반적으로 1학기에는 2월, 3월, 5월, 2학기에는 8월, 9월, 10월에 나누어 납부하지만 학사일정에 따라 변경될 수 있다.<br>
									- 등록금 분할납부 신청자가 2차, 3차 분할납부 금액을 미납하였을 시에는 학칙에 의거 미등록제적 처리되며, 이미 납부한 등록금은 학칙에 따라 반환되지 않는다.<br>
									- 등록금 분할납부 신청자가 등록금 환불 신청을 할 경우, 기 납부한 금액에서 학습비 징수 기간을 제하고 환불된다.&nbsp;&nbsp;&nbsp;*등록금 환불에 관한 규정 참고
								</dd>
							</dl>
						</li>
						<li>2. 등록금 환불에 관한 규정
							<dl>
								<dt>가. 등록금환불 규정</dt>
								<dd>
									- 본원의 등록금 환불 규정은 평가인정 학습과정 운영에 관한 규정 제 4조 제2항을 준용한다.<br>
									- 신입생 또는 재학생이 개강일 전일까지 환불을 요청할 경우 등록금 전액을 환불한다.<br>
									- 수업이 시작된 후 환불을 원하는 재학생의 경우 아래 규정을 따른다.
									<table class="ta874_ty02" style="width:100%;" summary="반환사유, 반환사유 발생시점, 반환 금액 순서로 보여줍니다.">
										<caption></caption>
										<colgroup>
											<col style="width:20%;" />
											<col style="width:20%;" />
											<col style="width:30%;" />
											<col style="width:30%;" />
										</colgroup>
										<thead>
											<tr style="height:50px;">
												<th scope="col" colspan="2">반환사유</th>
												<th scope="col" >반환사유 발생시점</th>
												<th scope="col" >반환 금액</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="ta_left">제4조 제2항 제1호에 해당하는 경우</td>
												<td class="ta_left">과오납</td>
												<td class="ta_left"></td>
												<td class="ta_left">과오납된 금액 전액</td>
											</tr>
											<tr>
												<td rowspan="5" class="ta_left">제4조 제2항 제2호부터<br>제4호까지의 규정에<br>해당하는 경우</td>
												<td rowspan="5" class="ta_left">병역의무에 따라 학습을<br>계속할 수 없는 경우,<br>학습자의  학습포기</td>
												<td class="ta_left">수업시작 전일 까지</td>
												<td class="ta_left">학습비  전액</td>
											</tr>
											<tr>
												<td class="ta_left">수업시작일부터 총 수업시간의 1/6 경과 전</td>
												<td class="ta_left">학습비의  6분의 5에 해당하는 금액</td>
											</tr>
											<tr>
												<td class="ta_left">총 수업시간의 1/6 이상부터 1/3 미만까지의 기간동안</td>
												<td class="ta_left">학습비의  3분의 2에 해당하는 금액</td>
											</tr>
											<tr>
												<td class="ta_left">총 수업시간의 1/3 이상부터 1/2미만까지의 기간동안</td>
												<td class="ta_left">학습비의  2분의 1에 해당하는 금액</td>
											</tr>
											<tr>
												<td class="ta_left">총 수업시간의 1/2 이상 경과</td>
												<td class="ta_left">반환하지  않음</td>
											</tr>
										</tbody>
									</table>
								</dd>
							</dl>
							<dl>
								<dt>나. 등록금 환불 절차</dt>
								<dd>
									- 학생의 등록금 환불신청서 및 필요서류 준비 → 학송관 208호 교학팀 제출
								</dd>
							</dl>
							<dl>
								<dt>다. 필요서류</dt>
								<dd>
									- 등록금 환불신청서<br>
									- 등록금 환불 받을 통장의 사본 1부<br>
									- 본인 신분증 사본 1부<br>
									- 가족관계증명서 *본인명의가 아닌 가족 명의의 통장으로 등록금 환불받을 경우에만 제출
								</dd>
							</dl>
						</li>
						<li>3. 장학금
							<dl>
								<dt>가. 장학금의 종류</dt>
								<dd>
<!-- 								200420 주석 -->
								<!--	<table class="ta874_ty03" style="width:100%;" summary="장학금의 종류를 장학종류, 선발 및 지급기준, 장학 종류, 선발 및 지급기준 순서로 보여줍니다.">
										<caption>장학금의 종류</caption>
										<colgroup>
											<col style="width:20%;" />
											<col style="width:30%;" />
											<col style="width:20%;" />
											<col style="width:30%;" />
										</colgroup>
										<thead>
											<tr style="height:50px;">
												<th scope="col">장학 종류</th>
												<th scope="col">선발 및 지급기준</th>
												<th scope="col">장학 종류</th>
												<th scope="col">선발 및 지급기준</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th class="ta_left">총장 장학금</th>
												<td class="ta_left">총학생회장을 맡고 있는 자로 공로가 인정된 자</td>
												<th class="ta_left">형제자매 장학금</th>
												<td class="ta_left">민법상 2촌 이내의 형제자매가 동시에 본원에 재학할 경우 등록금 일정액 지급</td>
											</tr>
											<tr>
												<th class="ta_left">평생교육원장 장학금</th>
												<td class="ta_left">총학생회 부회장을 맡고 있는 자로 공로가 인정된 자</td>
												<th class="ta_left">보훈 장학금</th>
												<td class="ta_left">국가유공자 및 그 직계자녀에게 등록금 전액지급</td>
											</tr>
											<tr>
												<th class="ta_left">성적 우수 장학금</th>
												<td class="ta_left">직전학기 평점평균 성적을 기준으로 등위를 결정하며, 지도교수 추천을 받은 자 중에서 선발</td>
												<th class="ta_left">교직원 자녀 장학금</th>
												<td class="ta_left">교직원 자녀로서 성적이 우수하고 품행이 방정한 자에게 등록금 전액 지급</td>
											</tr>
											<tr>
												<th class="ta_left">공로 장학금</th>
												<td class="ta_left">전공발전에 기여한 공로에 따라 총학생회임원 및 각 학년 임원에게 직급별 차등 지급</td>
												<th class="ta_left">근로 장학금</th>
												<td class="ta_left">재학생 중 가정형편이 어려운 학생으로 디자인아트교육원에서 근로를 한 자</td>
											</tr>
											<tr>
												<th class="ta_left">기술 우수 장학금</th>
												<td class="ta_left">기능경기대회 수상자로 관련전공에 입학한 자에게 입상등급에 따라 차등지급</td>
												<th class="ta_left">기초생활 수급자</th>
												<td class="ta_left">국민기초생활보호대상자로 성적이 우수한 학생에게 일정액 지급</td>
											</tr>
										</tbody>
 									</table> -->
<!--  									200420추가 -->
<div class="ta_overbox">
						<table class="ta874_ty02" style="width:100%;" summary="장학제도를 장학명, 대상 및 선발기준(신입생, 재학생) 장학금액 순서로 보여줍니다.">
							<caption>장학제도</caption>
							<colgroup>
								<col style="width:;" />
								<col style="width:;" />
								<col style="width:;" />
								<col style="width:;" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">장학명</th>
									<th scope="col">대상 및 선발기준</th>
									<th scope="col">장학금액</th>
									<th scope="col">기간</th>
								</tr>
							</thead>
							<tbody>
								 <tr>
								 	<td>입학실기우수장학금</td>
								 	<td>
										<p>입학전형에서 가장 우수한 실기고사 성적으로 입학한 자</p>
										<p>(디자인계열 실기전형 지원자에 한함)</p>
									</td>
								 	<td>수업료 100% 감면</td>
								 	<td rowspan="7">입학 첫 학기</td>
								 </tr>
								 <tr>
								 	<td>실기우수장학금</td>
								 	<td>4년제 대학 주최 미술 실기대회 수상자로서 입학한 자</td>
								 	<td style="border-right: 1px solid #cccccc;">
								 		<p>1등상 : 수업료 50% 감면</p>
								 		<p>2등상 : 수업료 30% 감면</p>
								 		<p>3등상 : 수업료 20% 감면</p>
								 	</td>
								 </tr>
								 <tr>
								 	<td>한캠장학금</td>
								 	<td>한디원 주최 진로캠프 수료 후 입학한 자<br>(면접 시 수료증 사본 제출)</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 40% 감면</td>
								 </tr>
								 <tr>
								 	<td>교류협력고교장학금</td>
								 	<td>한디원과 교류 협력하고 있는 고교를 졸업하고 입학한 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 20% 감면</td>
								 </tr>
								 <!-- <tr>
								 	<td>얼리버드장학금</td>
								 	<td>12월까지 등록하여 입학한 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 20% 감면</td>
								 </tr> -->
								 <tr>
								 	<td>추천서장학금</td>
								 	<td>고등학교 및 학원장으로부터 추천서를 받고 입학한 자<br>(면접시 제출한 추천서에 한함)</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 20% 감면</td>
								 </tr>
								 <tr>
								 	<td>한성가족장학금</td>
								 	<td>한성여고를 졸업하고 입학한 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 20% 감면</td>
								 </tr>
								 <tr>
								 	<td>성적학년최우수장학금</td>
								 	<td>학년 성적이 가장 우수한 자</td>
								 	<td>수업료 100% 감면</td>
								 	<td rowspan="5">다음 학기</td>
								 </tr>
								 <tr>
								 	<td>성적최우수장학금</td>
								 	<td>학년 성적이 차순위로 우수한 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 70% 감면</td>
								 </tr>
								 <tr>
								 	<td>성적우수장학금</td>
								 	<td>학년 성적이 최우수장학 차순위로 우수한 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 50% 감면</td>
								 </tr>
								 <tr>
								 	<td>성적장려장학금</td>
								 	<td>학년 성적이 우수장학 차순위로 우수한 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 30% 감면</td>
								 </tr>
								 <tr>
								 	<td>성적준장려장학금</td>
								 	<td>학년 성적이 장려장학 차순위로 우수한 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 10% 감면</td>
								 </tr>
								 <tr>
								 	<td>공로장학금</td>
								 	<td>학생회 간부로 활동 중인 자</td>
								 	<td>
								 		<p>총학생회장 : 수업료 100% 감면</p>
								 		<p>부총학생회장 : 수업료 50% 감면</p>
								 		<p>총학집행부 : 수업료 25% 감면</p>
								 		<p>전공대표 : 수업료 20% 감면</p>
								 		<p>전공부대표 : 수업료 10% 감면</p>
								 		<p>전공별학년대표 : 수업료 10% 감면</p>
								 	</td>
								 	<td rowspan="3">해당 학기</td>
								 </tr>
								 <tr>
								 	<td>근로장학금</td>
								 	<td>근로학생으로 선발된 자</td>
								 	<td style="border-right: 1px solid #cccccc;">
								 		<p>일반근로 : 700,000원</p>
								 		<p>영상편집 : 500,000원</p>
								 		<p>홍보대사 : 500,000원</p>
								 	</td>
								 </tr>
								 <tr>
								 	<td>총장특별장학금</td>
								 	<td>대외적으로 학교의 명예를 높인 공로가 인정된 자<br>(전국 규모 공모전 등 수상자)</td>
								 	<td style="border-right: 1px solid #cccccc;">
								 		<p>1등상 : 300,000원</p>
								 		<p>2등상 : 200,000원</p>
								 		<p>3등상 : 100,000원</p>
								 	</td>
								 </tr>
								 <tr>
								 	<td>기업산학장학금</td>
								 	<td>기업연계형 프로젝트수업 참여 학생 중<br>기업으로부터 디자인이 채택된 자<br>"기업명 + 산학장학금"</td>
								 	<td>프로젝트별 지정된<br>장학금 지급</td>
								 	<td rowspan="4">재학 중</td>
								 </tr>
								 <tr>
								 	<td rowspan="2">한디원열정장학금</td>
								 	<td>전공 관련 기사 자격증을 취득한 자</td>
								 	<td style="border-right: 1px solid #cccccc;">200,000원</td>
								 </tr>
								 <tr>
									<td>
								 		<p>전공 관련 산업기사 자격증을 취득한 자(아래에 한함)</p>
										<p>실내디자인 : 실내건축산업기사</p>
										<p>시각디자인학 : 시각디자인산업기사</p>
										<p>산업디자인 : 제품디자인산업기사</p>
										<p>디지털아트학 : 게임그래픽전문가, 멀티미디어콘텐츠제작전문가</p>
										<p>패션디자인학 : 패션디자인산업기사</p>
										<p>패션비즈니스학 : 패션머천다이징산업기사</p>
										<p>미용학 : 컬러리스트산업기사</p>
								 	</td>
								 	<td style="border-right: 1px solid #cccccc;">100,000원</td>
								 </tr>
								 <tr>
								 	<td>어학우수장학금</td>
								 	<td>
										<p>공인 어학능력 검정시험의 기준을 충족한 자(아래에 한함)</p>
										<p>영어 : TOEIC 700점 이상 또는 TOEIC Speaking 130점 이상</p>
										<p>일본어 : JPT 600점 이상 또는 JLPT N2 이상</p>
										<p>중국어 : HSK 5급 이상</p>
									</td>
								 	<td style="border-right: 1px solid #cccccc;">200,000원</td>
								 </tr>
								 <tr>
								 	<td>한디원행복장학금</td>
								 	<td>다자녀(3자녀 이상) 가정의 자녀로 입학한 자</td>
								 	<td>수업료 30% 감면</td>
								 	<td rowspan="9">등록 8학기</td>
								 </tr>
								 <tr>
								 	<td>한디원사랑장학금</td>
								 	<td>국민기초생활 보호대상자 및 차상위계층으로 심의에 통과한 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 30% 감면</td>
								 </tr>
								 <tr>
								 	<td>한디원희망장학금</td>
								 	<td>본인이 미혼모(부)로 지원 요건을 충족하는 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 70% 감면</td>
								 </tr>
								 <tr>
								 	<td>다문화가정장학금</td>
								 	<td>지원대상자 자녀로서 요건을 충족하는 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 30% 감면</td>
								 </tr>
								 <tr>
								 	<td>한디원키다리장학금</td>
								 	<td>지원대상자가 가정위탁보호대상자로 요건을 충족하고, <br> 가사가 곤란한자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 70% 감면</td>
								 </tr>
								 <tr>
								 	<td>한디원새출발장학금</td>
								 	<td>북한이탈주민의 보호 및 정착지원에 관한 법률이<br>규정하는 요건을 충족하는 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 100% 감면</td>
								 </tr>
								 <tr>
								 	<td>보훈장학금</td>
								 	<td>국가/독립유공자 본인 혹은 자녀로서 재학 중인 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 100% 감면</td>
								 </tr>
								 <tr>
								 	<td>형제자매장학금</td>
								 	<td>민법상 2촌 이내인 형제/자매가 동시에 재학 중인 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 10% 감면</td>
								 </tr>
								 <tr>
								 	<td>교직원자녀장학금</td>
								 	<td>교직원 자녀로서 성적이 우수하고 품행이 바른 자</td>
								 	<td style="border-right: 1px solid #cccccc;">수업료 100% 감면</td>
								 </tr>
							</tbody>
						</table>
						<div class="ta_txt">
							<ul>
								<li class="">
									* 대상 및 선발기준이 중복되는 경우 <font style="color: red;">상위 장학금 지급</font>을 원칙으로 합니다. (개별 지정된 일부 항목의 경우 중복 적용 가능)
									<br/>* 입학실기우수장학금, 교류협력고교장학금, 한디원열정장학금, 어학우수장학금의 경우 2020학년도부터 시행됩니다.
									<br/>단, 한디원열정장학금, 어학우수장학금의 경우 모든 재학 기간에 대해 소급 적용됩니다.
									<br/>* 재학생 장학금 수여 성적기준은 다음과 같습니다.
									<br/>1. 직전학기 15학점 이상 이수
									<br/>2. “F"학점이 없는 자로 평점평균 3.0 이상
									<br/>3. 총장특별장학생, 총장장학생, 디자인아트교육원장장학생, 공로장학생, 근로장학생, 교직원자녀장
									<br/> 학생의 경우에는 제39조 제2항 제1호의 예외로 함.
									<br/>* 장학금 선정 관련하여 자세한 사항은 홈페이지 및 교학팀(02-760-5781)으로 문의주시기 바랍니다.
								</li>
							</ul>
						</div>
					</div>
								</dd>
							</dl>
							<dl>
								<dt>나. 장학금 지급 세부 규정</dt>
								<dd>
									- 장학금의 종류에 따라 직전학기 성적 또는 수강학점 제한이 있으며 이는 학사정보시스템 공지를 통해 안내 하니 이를 참고 한다.
								</dd>
							</dl>
							<dl>
								<dt>다. 관련 주의사항</dt>
								<dd>
									- 등록금 분할납부자의 경우 등록금 완납 후 장학금이 지급된다.<br>
									- 장학금 수령자가 등록금환불을 원할 경우에는 장학금을 제외한 금액이 환불된다.<br>
									- 휴학생은 장학금을 수혜할 수 없다. 단, 등록 후 휴학생은 장학금 수혜가 가능하다.
								</dd>
							</dl>
						</li>
						<li>4. 초과학기자의 등록 및 장학
							<dl>
								<dt>가. 초과학기자의 등록</dt>
								<dd>
									- 2017.12.01 삭제
								</dd>
							</dl>
							<dl>
								<dt>나. 초과학기자의 장학금</dt>
								<dd>
									- 초과학기자는 장학금 수여대상에서 제외된다.

								</dd>
							</dl>
						</li>
					</ol>
	
				</c:if>
				<c:if test="${searchVO.menuType eq '03' }">
					<div class="s_tit">Ⅲ. 학적변동(휴․복학, 자퇴, 제적, 재입학)</div>
					<ol class="ag_box">
						<li>1. 일반휴학 * 군입영 휴학은 하단 참고
							<dl>
								<dt>가. 일반휴학</dt>
								<dd>
									- 정의 : 질병으로 인한 휴학(4주 이상의 진단을 받은 경우), 개인사정으로 인한 휴학<br>
									- 기간 : 최소 6개월(1학기) ~ 최대 3년까지(6학기) 가능<br>&nbsp;&nbsp;&nbsp;* 단, 휴학 신청 시 1회 최대 1년(2학기)에 한함
								</dd>
							</dl>
							<dl>
								<dt>나. 일반 휴학 신청 절차</dt>
								<dd>
									- 일반 휴학원 작성 → 지도교수 상담 후 지도교수 확인 서명 → 학송관 208호 교학팀 제출
								</dd>
							</dl>
							<dl>
								<dt>다. 관련 주의사항</dt>
								<dd>
									- 미등록자 혹은 등록자의 휴학은 개강 이전까지 가능하다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;* 개강 후 휴학은 학기 중도 포기로 환불규정에 따라 등록금의 일부만 환불된다.<br>
									- 신입생과 편입생의 입학 첫 학기의 일반휴학(질병휴학, 군입영 휴학은 가능)은 허가하지 않는다.<br>
									- 휴학 신청 시, 1회 최대 1년까지만 휴학이 가능하다.<br>
									&nbsp;&nbsp;&nbsp;&nbsp;* 예) 3년 휴학을 원하는 학생은 1년씩 세 번 휴학 신청<br>
									- 휴학자가 자퇴를 하는 경우에는 해당학기 최초 휴학일을 기준으로 환불규정에 따라 환불한다.<br>
									- 일반 휴학자가 입영을 할 경우 반드시 군입영 휴학원을 작성하여 일반휴학을 군입영 휴학으로 변경해야 한다.
								</dd>
							</dl>
						</li>
						<li>2. 군입영 휴학 및 군입영 연기
							<dl>
								<dt>가. 군입영 휴학</dt>
								<dd>
									- 정의 : 군입영으로 인한 휴학(군복무 기간 동안 휴학)<br>- 기간 : 2년(4학기)
								</dd>
							</dl>
							<dl>
								<dt>나. 군입영 휴학 신청 절차</dt>
								<dd>
									- 군입영휴학원 작성 → 입영통지서 첨부 → 학송관 208호 교학팀 제출
								</dd>
							</dl>
							<dl>
								<dt>다. 관련 주의사항</dt>
								<dd>
									- 군입영 휴학은 신청 시 2년 동안(4학기) 휴학처리 된다.<br>
									- 군입영 휴학은 상시 가능하며, 수업일수의 80%을 이수했을 경우 학생의 의사에 따라서 해당학기의 성적을 인정받을 수 있다.<br>
									- 군입영 휴학 희망자는 군입영휴학원과 함께 군입영통지서를 반드시 첨부하여야 한다.<br>&nbsp;&nbsp;&nbsp;
									* 입영통지서가 없는 경우에는 우선 일반휴학 후 차후에 군입영통지서를 제출하여 군입영 휴학으로 전환
								</dd>
							</dl>
							<dl>
								<dt>라. 군입영 연기</dt>
								<dd>
									- 학점은행제 학습자도 군복무에 따른 군 입영기일 연기가 가능하다. 출석수업 기반인 평가인정 학습과목을 1개 이상 수강하고 있는 재학생이라면 모두 신청가능하며 통산 2년의 입영기일 연기기간 내에서 기간을 정하여 연기할 수 있다.<br>&nbsp;&nbsp;&nbsp;* 단, 온라인 학습과목만으로 수강 중인 학습자는 신청대상에서 제외되니 주의<br>- 자세한 내용은 병무청(1588-9090)과 상담한다.
								</dd>
							</dl>
						</li>
						<li>3. 복학
							<dl>
								<dt>가. 복학 신청 절차</dt>
								<dd>
									- 복학원 작성 → 학송관 208호 교학팀 제출
								</dd>
							</dl>
							<dl>
								<dt>나. 관련 주의사항</dt>
								<dd>
									- 복학을 원하는 학생은 복학 학기의 수강신청 기간이전에 복학신청을 완료해야한다.<br>&nbsp;&nbsp;&nbsp;
									* 수강신청 기간 이후 복학을 원하는 학생은 교학팀 및 학생지원팀과 상담<br>
									- 복학기간 안에 복학신청을 하지 않을 경우 제적으로 처리된다. *제적규정에 따름
								</dd>
							</dl>
						</li>
						<li>4. 자퇴
							<dl>
								<dt>가. 자퇴 신청 절차</dt>
								<dd>
									- 재학생 : 자퇴원 작성 → 지도교수 상담 후 지도교수 확인서명 및 보호자 확인서명 → 등록금환불신청서 작성 → 등록금 환불 관련 서류 준비→ 학송관 208호 교학팀 제출<br>
									- 신입생 : 등록금환불신청서와 등록금 환불 관련 서류 준비 → 학송관 208호 교학팀 제출
								</dd>
							</dl>
							<dl>
								<dt>나. 필요 서류</dt>
								<dd>
									- 자퇴원, 등록금 환불 신청서<br>
									- 등록금 환불 받을 통장의 사본 1부<br>
									- 본인 신분증 사본 1부<br>
									- 가족관계증명서<br>&nbsp;&nbsp;&nbsp;
									* 본인명의가 아닌 가족 명의의 통장으로 등록금 환불받을 경우에만 제출
								</dd>
							</dl>
							<dl>
								<dt>다. 관련 주의사항</dt>
								<dd>
									- 자퇴 시, 자퇴 신청 일에 따라 등록금의 일부만 환불이 되니 주의한다.<br>&nbsp;&nbsp;&nbsp;
									* 등록금 환불에 관한 규정 반드시 참고<br>
									- 각종 장학금수령자가 등록금환불을 원할 경우에는 장학금을 제외한 금액이 환불된다.
								</dd>
							</dl>
						</li>
						<li>5. 제적
							<dl>
								<dt>가. 제적 기준</dt>
								<dd>
									- 등록금 납입 마감일 초과<br>
									- 휴학 기간 초과 후 미등록
								</dd>
							</dl>
							<dl>
								<dt>나. 제적 처리 절차</dt>
								<dd>
									- 제적처리 전 제적 예정통보(전화 또는 문자) → 우편 통보 및 제적 처리
								</dd>
							</dl>
							<dl>
								<dt>다. 관련 주의사항</dt>
								<dd>
									- 제적자가 추후 재입학을 원할 시에는 재입학원을 작성하고 재입학 절차를 따른다.<br>
									- 등록금을 완납 한 후에도 제적 처리 예정 문자, 우편을 받은 경우 교학팀으로 연락한다.
								</dd>
							</dl>
						</li>
						<li>6. 재입학
							<dl>
								<dt>가. 재입학</dt>
								<dd>
									- 정의 : 자퇴 혹은 제적자가 다시 본원에 등록하여 수학하고자 할 경우 재입학 할 수 있다.
								</dd>
							</dl>
							<dl>
								<dt>나. 재입학 절차</dt>
								<dd>
									- 재입학원 작성 → 전공주임교수 상담 후 교수추천서 및 확인 서명 → 학송관 208호 교학팀 제출
								</dd>
							</dl>
							<dl>
								<dt>다. 필요 서류</dt>
								<dd>
									- 재입학원
								</dd>
							</dl>
							<dl>
								<dt>라. 관련 주의사항</dt>
								<dd>
									- 재입학자는 과거에 수강한 학점 및 학기를 모두 인정받을 수 있다. 단, 학기 중 혹은 강좌 이수 도중 학업을 중단한 경우는 해당하지 않는다.<br>&nbsp;&nbsp;&nbsp;
									* 예) 2학년 1학기 도중 자퇴 혹은 제적 → 2학년 1학기로 재입학 가능, 2학년 1학기 수강과목 인정 불가. 2학년 1학기 마치고 자퇴 → 2학년 2학기로 재입학 가능, 2학년 1학기까지 수강한 과목 모두 인정가능<br>
									- 재입학은 재입학을 원하는 학기의 수강신청 기간 이전에 재입학 신청을 완료하여야 한다.
								</dd>
							</dl>
						</li>
					</ol>
				</c:if>
				<c:if test="${searchVO.menuType eq '04' }">
					<div class="s_tit">Ⅳ. 증명서 발급 및 시설 이용</div>
					<ol class="ag_box">
						<li>1. 학점은행제, 학사 행정 관련 주요 문의처
							<dl>
								<dt>가. 국가평생교육진흥원</dt>
								<dd>
									- 학점은행제 학습자콜센터(1600-0400) : 학점은행제, 학습자 등록, 학점인정 신청, 자격증 등<br>
									- 운영시간 : 09:00 ~ 18:00
								</dd>
							</dl>
							<dl>
								<dt>나. 교내 문의처</dt>
								<dd>
									- 교학팀(학송관 208호, 02)760-5781) : 학사전반, 학사행정, 등록금 및 장학금, 졸업 및 학위<br>
									- 운영시간 : 학기중 09:00 ~ 17:30 / 방중 10:00~17:00 / 점심시간 : 12:00~13:00
								</dd>
							</dl>
						</li>
						<li>2. 각종 증명서 발급
							<dl>
								<dt>가. 증명서 발급 종류</dt>
								<dd>
									- 입학증명서, 납입증명서, 재학증명서(국/영문), 휴학증명서, 출석확인서(예비군제출용), 제적증명서, 성적증명서(국/영문), 성적확인서(국/영문), 학위수여예정증명서(국/영문), 학위수여증명서(국문)를 발급한다.<br>&nbsp;&nbsp;&nbsp;
									* 증명서 발급 시 소정의 수수료 발생
								</dd>
							</dl>
							<dl>
								<dt>나. 발급장소</dt>
								<dd>
									- 입학(국문), 제적(국문), 재학 증명서(국문), 학위증명서(국문) 인터넷 발급(edu-hansung.webminwon.kr)이 가능(2015.09.07부터)하며 그외 증명서의 발급은 학송관 208호 교학팀에 방문하여야 한다.<br>
									- 단, 학습자 등록 및 학점인정 신청이 완료된 학생은 인정 완료된 학점과 자격증에 한하여 국가평생교육진흥원 웹페이지에서 성적증명서를 발급 받을 수 있다.
								</dd>
							</dl>
							<dl>
								<dt>다. 관련 주의사항</dt>
								<dd>
									- 모든 증명서 발행은 본인에 한한다.<br>
									- 성적증명서의 경우, 교학팀에서 발행 시 발급작업에 따라 일정 시간이 소요될 수 있으니 주의한다.<br>&nbsp;&nbsp;&nbsp;
									* 국가평생교육진흥원 웹사이트에서 인정 완료된 학점에 한해 바로 발급 및 출력 가능<br>
									- 증명서에 따라 발급 시 소정의 수수료가 발생한다.
								</dd>
							</dl>
						</li>
						<li>3. 학생증 발급
							<dl>
								<dt>가. 학생증 발급 안내</dt>
								<dd>
									- 장소 : 학송관 208호 교학팀<br>
									- 제출 서류 : 반명함 사진 1매<br>
									- 비용 : 2,000원 * 신입생 및 편입생은 최초 발급 시 수수료 면제
								</dd>
							</dl>
						</li>
						<li>4. 교내시설
							<dl>
								<dt>가. 한디원(한성대 부설 디자인아트교육원)</dt>
								<dd>
									- 교학팀(학송관 208호) : 02)760-5781<br>
									- 입학홍보실(학송관 208호) : 02)760-5533~5<br>
									- 총학생회실(진리관 310호)
								</dd>
							</dl>
							<dl>
								<dt>나. 그 외 </dt>
								<dd>
									- 학술정보관(미래관 1층~6층) : 02)760-4283<br>
									- 컴퓨터실습실(미래관 지하1층)<br>
									- 스터디라운지(미래관 지하 1층) : 02)760-5836<br>
									- 체력단련실(낙산관 4층) : 02)760-4360<br>
									- 학생식당(창의관 지하 1층) : 02)760-4499<br>&nbsp;&nbsp;&nbsp;* 더 자세한 내용은 본교 웹사이트(http://www.hansung.ac.kr/) – 한성소개 – 캠퍼스맵 참고
								</dd>
							</dl>
							<dl>
								<dt>다. 야간잔류</dt>
								<dd>
									- 학생들은 야간작업, 졸업 작품 작업, 과제 등을 위해 야간에도 본원에 잔류하여 작업을 할 수 있다.<br>
									- 야간잔류 신청기간 : 야간잔류 희망 전날 저녁 17:30 이전까지 신청<br>
									- 야간잔류 가능시간 : 저녁 18:00 ~ 24:00<br>
									- 신청절차 : 야간잔류 신청서 작성 → 지도교수 확인서명 → 학송관 208호 교학팀 확인 서명 → 야간잔류<br>
									- 신청서 원본은 교학팀 제출, 사본 1부는 본인 소지, 1부는 1층 경비실 제출<br>
									- 관련 주의 사항 : 야간잔류 목적 및 전공, 학년에 따라 배정되는 강의실이 다르며, 이는 전공사무실에 문의를 통해 알 수 있다.
								</dd>
							</dl>
						</li>
						<li>5. 셔틀버스 안내
							<dl>
								<dt>가. 운행시간표</dt>
								<dd>- 운행시간이 학기중,방중 상이하니 한성대학교 홈페이지를 참조한다.</dd>
							</dl>
							<dl>
								<dt>나. 관련 주의사항</dt>
								<dd>
									- 본교 출발은 본교 정문에서 출발하며, 대학로 출발은 한디원 정문에서 출발한다.<br>
									- 셔틀버스 운행시간은 학과 및 기타 학교 행사 시 변경 또는 취소될 수 있다.<br>
									- 셔틀버스 운행시간은 변동될 수 있으며 방학 때는 제한 운행된다.<br>
									- 셔틀버스는 무료로 운행된다.<br>
									(02)760-4239 | 기타 문의사항은 정문안내실(02)760-4239로 문의한다.
								</dd>
							</dl>
						</li>
					</ol>
				</c:if>
			</div>
			<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
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