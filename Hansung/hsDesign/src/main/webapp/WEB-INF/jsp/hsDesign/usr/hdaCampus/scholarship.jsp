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
						<c:param name="dept1" value="학사안내"/>
						<c:param name="dept2" value="장학제도"/>
					</c:import>
					
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
				</div>
			</div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!-- //footer -->
	</div>
	<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>