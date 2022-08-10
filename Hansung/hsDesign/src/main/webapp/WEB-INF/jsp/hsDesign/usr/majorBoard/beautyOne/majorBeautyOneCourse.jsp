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
		            <jsp:param name="dept2" value="미용학(one-day)"/>
		            <jsp:param name="dept3" value="교과과정"/>
	           	</jsp:include>
				<c:if test="${searchVO.menuType eq '01' }">
					<div class="sub_cont_page">
						<div class="ta_overbox">
							<table class="ta874_ty03"
								summary="교과 과정(분야)를 헤어디자이너, 메이크업디자이너, 네일디자이너, 피부미용사, 래쉬컨투어 코디네이터 순서로 보여줍니다.">
								<caption>교과 과정(분야)표</caption>
								<colgroup>
									<col style="width: 80px;" />
									<col style="width: 80px;" />
									<col style="width: 142px;" />
									<col style="width: 142px;" />
									<col style="width: 142px;" />
									<col style="width: 142px;" />
									<col style="width: 142px;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col" colspan="2"></th>
										<th scope="col">헤어디자이너</th>
										<th scope="col">메이크업디자이너</th>
										<th scope="col">네일디자이너</th>
										<th scope="col">피부미용사</th>
										<th scope="col">래쉬컨투어<br>코디네이터
										</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th rowspan="4" scope="col">1</th>
										<th rowspan="2" scope="row">1
										</td>
										<td colspan="5">미용학개론 / 기초미용포토샵 / 기초미용드로잉 / 기초디자인</td>
									</tr>
									<tr>
										<td>기초커트실습</td>
										<td>기초메이크업실습</td>
										<td>네일케어실습</td>
										<td>기초피부관리실습</td>
										<td>래쉬컨투어기초</td>
									</tr>
									<tr>
										<th rowspan="2" scope="row">2
										</td>
										<td colspan="5">미용색채학 / 생활과 컴퓨터 / 미용사진촬영과감상 / 기초미용일러스트
											/ 홈페이지제작 / 코디네이트</td>
									</tr>
									<tr>
										<td>파마실습<br>헤어컬러링
										</td>
										<td>응용메이크업<br>방송M/up
										</td>
										<td>파우더 팁 아트<br>핸드 페인팅
										</td>
										<td>응용피부관리실습</td>
										<td>속눈썹 연장술</td>
									</tr>
									<tr>
										<th rowspan="4" scope="col">2</th>
										<th rowspan="2" scope="row">1
										</td>
										<td colspan="5">뷰티고객이미지분석 / 뷰티트랜드분석 / 화장품 / 사진학개론 /
											서비스디자인 / 미용방송기초(미용영상기초)</td>
									</tr>
									<tr>
										<td>남성커트실습<br>열파마실습1 <br>헤어컬러체인지실습
										</td>
										<td>연예인M/up<br>무대M/up
										</td>
										<td>중급네일케어<br>캐릭터아트
										</td>
										<td>에스테틱트리트먼트<br>바디관리<br>발관리학<br>중급속눈썹 펌<br>스웨디시마사지
										</td>
										<td>중급반영구<br>디자인
										</td>
									</tr>
									<tr>
										<th rowspan="2" scope="row">2</th>
										<td colspan="5">MCN기초 / 미용이미지편집 / 고객만족서비스 / 고객서비스 / 사진과
											촬영<br>미용디자인리서치와 마케팅/ 미용경영과브랜드 전략
										</td>
									</tr>
									<tr>
										<td>여성커트실습<br>열파마실습 2
										</td>
										<td>트랜드M/up<br>웨딩M/up
										</td>
										<td>포크아트 1<br>페브릭 아트<br>아크릴릭 아트<br>고급네일관리
										</td>
										<td>메디컬스킨케어<br>아로마테라피<br>아유르베다<br>스킨테라피
										</td>
										<td>고급아트래쉬<br></td>
									</tr>
									<tr>
										<th rowspan="2" scope="col">3</th>
										<th scope="row">1
										</td>
										<td colspan="5">전공별 기술기획 / 모의실전실무기획 / 사진과디자인 / 미용제품기획</td>
									</tr>
									<tr>
										<th scope="row">2</th>
										<td>실전헤어스타일링<br>특수머리실습
										</td>
										<td>트랜드M/up</td>
										<td>UV 젤 아트<br>포크아트 2<br>트랜드 아트<br>아트 팁<br>살롱
											아트
										</td>
										<td>타이마사지<br>딥티슈마사지<br>인디어헤드마사지<br>비만 및
											체형관리
										</td>
										<td>전공실무<br>래쉬 컨투어
										</td>
									</tr>
									<tr>
										<th rowspan="2" scope="col">4</th>
										<th scope="row">1
										</td>
										<td colspan="5">미용고객시술실습 / 미용세니마 / 미용실전실무 /미용기업산학프로젝트 /
											미용전시디자인 / 졸업작품</td>
									</tr>
									<tr>
										<th scope="row">2
										</td>
										<td colspan="5">프리젠테이션 / 포트폴리오 / 취업활동</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="s_tit" style="margin-top: 30px;">재학 중 학년별 레벨변화</div>
						<div class="ta_overbox">
							<div style="margin-bottom: 10px;">예시) 미용학 전공 헤어 학생-아래 표</div>
							<table class="ta874_ty02"
								summary="재학 중 학년별 레벨변화를 신입생 기준, 한성대학교 안디원 미용학전공 교육, 미용학전공 재학중 수준 정도 순서로 보여줍니다.">
								<caption>재학 중 학년별 레벨변화표</caption>
								<colgroup>
									<col style="width: 191px;" />
									<col style="width: 241px;" />
									<col style="width: 241px;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col" style="height: 50px;">신입생 기준</th>
										<th scope="col">한성대학교 한디원 미용학전공 교육</th>
										<th scope="col">미용학전공 재학중 수준 정도</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1학년</td>
										<td>외부 실제 고객 모델 교육</td>
										<td>외부 중~상급 인턴 수준</td>
									</tr>
									<tr>
										<td>2학년</td>
										<td>뷰티센터 중급<br>디자이너 교육
										</td>
										<td>외부 상급~1년차 디자이너<br>수준의 실력
										</td>
									</tr>
									<tr>
										<td>3학년</td>
										<td>뷰티센터 고급<br>디자이너 교육
										</td>
										<td>외부 중~상급 디자이너 수준의 실력</td>
									</tr>
									<tr>
										<td>4학년(자격증 취득 시 조기졸업)</td>
										<td>뷰티센터 직영점, 가맹점 창업,<br>뷰티아카데미 고급인력 교육
										</td>
										<td>외부 상급~ 실장급 수준의 실력</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="s_tit" style="margin-top: 30px;">교원능력개발프로그램/TWINS(쌍둥이)실무시스템</div>
						<div class="dl_caption" style="margin-bottom: 30px;">
							<dl>
								<dt>
									<img
										src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/ex_pptimg.jpg'/>"
										alt="" />
								</dt>
								<dd>
									<dl>
										<dt>교원능력 개발 프로그램이란?</dt>
										<dd>미용산업이 빠른 변화를 하고 있으며 양적·질적으로 고속성장과 급진적 발전을 이루어 내고
											있습니다. 이러한 상황속에서 미용기술력, 미용정보력, 실무능력은 탄탄히 발전하고 있으나 이를 쉽고
											효과적으로 가르치고 전수할 수 있는 학원강사, 학교선생님, 학교 방과 후 지도교사, 대학교 평생교육원 강사
											및 교수, 대학교 강사 및 교수 등등의 교원인력이 절실히 요구 되고 있다. 또한 이와 같은 교원을
											체계적으로 양성하는 기관도 거의 없는 실정입니다. 한성대학교 한디원 미용학 전공 교원능력개발 프로그램에서는
											4년제 학위취득, 자격증 취득(학원연계), 실전미용기술습득, 현장 창업능력습득, 미용대회 및 전시, 서비스
											인성 및 경영과정, 교원실습, 대학원 진학 프로그램 등 체계적인 과정을 통하여 경쟁력 있는 교원을 배출해
											내고 있습니다.</dd>
									</dl>
								</dd>
							</dl>
						</div>
						<div class="dl_caption">
							<dl>
								<dt>
									<img
										src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/ex_pptimg02.jpg'/>"
										alt="" />
								</dt>
								<dd>
									<dl>
										<dt>TWINS(쌍둥이)실무시스템프로그램이란?</dt>
										<dd>
											TWINS(쌍둥이)실무시스템프로그램 에서는 학교 교육시스템과 산업체 현장이 똑같이 이루어져 있어서
											이론과목과 교양과목을 제외한 전공실습과목은 실제 산업체 현장과 실제 고객을 상대로 수업을 하는 것을
											말합니다.<br>
											<br> 대부분 미용인이 되기를 희망하는 사람들은 학원에서 기초과정을 하여 바람직하게 시작하지만
											이에 학위를 취득하고 좀더 프로페셔널한 미용이 되기 위하여 대학교에 들어오게 됩니다. 그러나 통계에 따르면
											미용대학교를 경험한 학생들의 많은 퍼센트가 미용을 그만두거나 업종 변경을 하는 경우가 연구 결과 나타나고
											있습니다. 이는 대학교 기간 동안 본인 전공에 대하여 프로페셔널한 인재가 되어야만 산업체에서 잘 적응 할
											수 있게 되고 또한 어렵게 시작한 미용을 포기하지 않고 성공할 수 있게 된다는 사실을 보여줍니다. <br>
											<br> 한성대학교 한디원 미용학전공 TWINS(쌍둥이)실무시스템프로그램 에서는 이러한
											노하우를 가지고 매년 프로페셔널한 졸업생을 배출해 내고 있습니다.
										</dd>
									</dl>
								</dd>
							</dl>
						</div>
					</div>
					<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
				</c:if>
				<c:if test="${searchVO.menuType eq '02' }">
				</c:if>
			<!--// content -->
			</div>		
		</div>
	<!--// container -->
	<hr />
	</div>
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>