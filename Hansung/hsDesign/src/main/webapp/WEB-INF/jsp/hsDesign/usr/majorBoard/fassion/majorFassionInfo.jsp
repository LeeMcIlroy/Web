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
		            <jsp:param name="dept2" value="패션디자인"/>
		            <jsp:param name="dept3" value="전공안내"/>
	           	</jsp:include>

				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionInfo.do?menuType=01'/>">전공 소개</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionInfo.do?menuType=02'/>">자격증 정보</a></li>
					</ul>
				</div>				
				<div class="sub_cont_page">
					<c:if test="${searchVO.menuType eq '01' }">
						<dl class="info_dl">
							<dd>
<!-- 							200416수정 -->
<!-- 								<p>패션디자인 전공은 변화와 혁신의 창의기반 사회에 적합한 참신하고 창의력을 갖춘 패션전문 인재육성을 목표로 하는 전공입니다.</p> 
								<p>최근의 패션산업은 우리의 문화, 경제, 생활공간 전역에 걸쳐 지대한 영향을 미치는 가운데 비약적 발전 또한 이루고 있으며, 그 발전 추세에 부응하여 고부가가치를 창출하는 창조적 전문 인력을 필요로 하고 있습니다.</p>
								<p>패션디자인 전공은 현장경험이 풍부한 현업 최고의 교수진의 지도하에 의상학 전반에 걸친 이론과 실기를 병행 학습함으로써 현대 패션산업에서 요구하는 차별화된 감각과 개성 있는 패션을 창조할 수 있는 창의적 전문가 양성에 적합한 체계적인 교육시스템을 갖추고 있습니다.</p>-->
								<p>패션디자인 전공은 변화와 혁신의 창의기반 사회에 적합한 참신하고 창의력을 갖춘 패션전문 인 재 육성을 목표로 하는 전공입니다. </p>
								<p>최근의 패션산업은 우리의 문화, 경제, 생활공간 전역에 걸쳐 지대한 영향을 미치는 가운데 비약 적 발전 또한 이루고 있으며, 그 발전 추세에 부응하여 고부가가치를 창출하는 창조적 전문 인력 을 필요로 하고 있습니다. 
								또한 패션산업은 현 시대를 읽고 트렌드를 파악하여 매력적인 패션상 품을 제공해야 하며 더불어 패션정보나 라이프 스타일 제안까지 요구되고 있어 패션시장에서 상 품기획력과 홍보, 마케팅 능력은 브랜드의 성공을 좌우합니다.</p> 
								<p>패션디자인 전공은 이러한 시대적 흐름에 맞춰 광범위한 패션 관련 업종에서 성공할 역동적인 패션인 양성을 목표로 하며 현장경험이 풍부한 현업 최고의 교수진의 지도하에 의상학 전반에 걸 친 이론과 실기를 병행 학습함으로써 
								현대 패션산업에서 요구하는 차별화된 감각과 개성 있는 패 션을 창조할 수 있는 창의적 전문가 양성에 적합한 체계적인 교육시스템을 갖추고 있습니다.</p> 
							</dd>
						</dl>
						<dt>&nbsp;</dt>
						<dt>&nbsp;</dt>
						<div class="s_tit">취득가능 자격증</div>
						<div class="sub_cont_page">
							<dl class="info_dl">
								<dd>
									<p>
									 패션디자인산업기사, 패션머천다이징산업기사, 섬유디자인산업기사, 양복산업기사, 의류기사, 의류기술사, 한복산업기사 등
	
									</p>
								</dd>
							</dl>
						</div>
						<dt>&nbsp;</dt>
						<div class="sub_cont_box">
							<div class="tit_3rd">패션디자인 전공과정</div>
<%-- 							<img src="${pageContext.request.contextPath }/assets/usr/img/fassion/fassionInfo_01.jpg"/> --%>
<%-- 							<img src="${pageContext.request.contextPath }/assets/usr/img/fassion/fassionInfo_02.jpg"/> --%>
							<img src="${pageContext.request.contextPath }/assets/usr/img/fassion/fassionInfo_03.jpg"/>
							<%--
							<div class="ta_type_dl">
								<dl>
									<dt><span>1학년</span></dt>
									<dd><span>공통기초과정[일러스트레이션, 플랫패턴디자인, 의복구성1, 패션디자인론, 패션소재연구, 의복과색채, 패션이미지메이킹]</span></dd>
								</dl>
								<dl>
									<dt><span>2학년</span></dt>
									<dd><span>[서양복식사, 패션드레이핑, 패션디자인실습, 컴퓨터패션디자인, 한국의상구성, 패션머천다이징, 패션악세서리디자인, 텍스타일디자인, 복식문화]</span></dd>
								</dl>
								<dl>
									<dt><span>3학년</span></dt>
									<dd><span>[패션마케팅, 남성복 구성실습, 섬유조형실습, 패션CAD실습, 테일러링, 특수소재의복제작, 패션코디네이션, 비주얼머천다이징]</span></dd>
								</dl>
								<dl>
									<dt><span>4학년</span></dt>
									<dd><span>[무대의상제작실습, 패션스타일링,패션멀렉션] 등의 졸업 준비 수업과 [패션포트폴리오, 패션유통론, 패션산업론, 의상사회심리]  등</span></dd>
								</dl>
							</div>
							--%>
						</div>
					</c:if> 
					<c:if test="${searchVO.menuType eq '02' }">
							<div class="ta_overbox">
								<table class="ta874" summary="자격증 정보를 내용, 인정학점(전공, 일선) 순서로 보여줍니다.">
								<caption>자격증정보표</caption>
								<colgroup>
									<col style="width:146px;" />
									<col style="width:573px;" />
									<col style="width:76px;" />
									<col style="width:76px;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col" colspan="2" rowspan="2">내용</th>
										<th scope="col" colspan="2">인정학점</th>
									</tr>
									<tr>
										<th scope="col">전공</th>
										<th scope="col">일선</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td colspan="4">
											<!-- 전공 학점인정과목 -->
																						
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_title"><td colspan="4">전공 학점인정과목</td></tr>
											<tr class="ta_score"><td>자격증명</td><td>의류기술사</td><td>45</td><td></td></tr>
											<td>발급기관</td><td>한국산업인력공단<td colspan="2" rowspan="3"></td></td></tr>
											<td>시험과목</td><td>게임제작개론, 게임그래픽 디자인, 게임그래픽 제작, 그래픽 디자인론</td></tr>
											<td>관련전공(학사)</td><td>시각디자인학 전공, 멀티미디어학 전공, 게임프로그래밍학 전공</td></tr>
											</tbody></table>
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_score"><td>자격증명</td><td>의류기사</td><td>20</td><td></td></tr>
											<td>발급기관</td><td>한국산업인력공단<td colspan="2" rowspan="3"></td></tr>
											<td>시험과목</td><td>색채심리·마케팅, 색채디자인, 색채관리, 색채지각론, 색채체계론</td></tr>
											<td>관련전공(학사)</td><td>시각디자인학 전공, 산업디자인 전공</td></tr>
											</tbody></table>
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_score"><td>자격증명</td><td>섬유디자인 산업기사</td><td>16</td><td></td></tr>
											<td>발급기관</td><td>한국산업인력공단<td colspan="2" rowspan="3"></td></tr>
											<td>시험과목</td><td>멀티미디어개론, 멀티미디어기획및디자인, 멀티미디어저작, 멀티미디어제작기술</td></tr>
											<td>관련전공(학사)</td><td>시각디자인학 전공, 전자계산학 전공, 멀티미디어학 전공</td></tr>
											</tbody></table>
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_score"><td>자격증명</td><td>양복 산업기사</td><td>16</td><td></td></tr>
											<td>발급기관</td><td>한국산업인력공단<td colspan="2" rowspan="3"></td></tr>
											<td>시험과목</td><td>색채디자인, 색채관리, 색채심리, 색채지각의이해, 색채체계의이해</td></tr>
											<td>관련전공(학사)</td><td>시각디자인학 전공, 산업디자인 전공</td></tr>
											</tbody></table>
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_score"><td>자격증명</td><td>패션디자인 산업기사</td><td>16</td><td></td></tr>
											<td>발급기관</td><td>한국산업인력공단<td colspan="2" rowspan="3"></td></tr>
											<td>시험과목</td><td>인쇄 및 사진기법, 시각디자인론, 시각디자인실무이론, 색채학</td></tr>
											<td>관련전공(학사)</td><td>시각디자인학 전공</td></tr>
											</tbody></table>
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_score"><td>자격증명</td><td>한복 산업기사</td><td>16</td><td></td></tr>
											<td>발급기관</td><td>한국산업인력공단<td colspan="2" rowspan="3"></td></tr>
											<td>시험과목</td><td>인쇄 및 사진기법, 시각디자인론, 시각디자인실무이론, 색채학</td></tr>
											<td>관련전공(학사)</td><td>시각디자인학 전공</td></tr>
											</tbody></table>
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_score"><td>자격증명</td><td>패션머천다이징 산업기사</td><td>16</td><td></td></tr>
											<td>발급기관</td><td>한국산업인력공단<td colspan="2" rowspan="3"></td></tr>
											<td>시험과목</td><td>인쇄 및 사진기법, 시각디자인론, 시각디자인실무이론, 색채학</td></tr>
											<td>관련전공(학사)</td><td>시각디자인학 전공</td></tr>
											</tbody></table>


											<!-- 전공 학점인정과목 -->

											<!-- 일반선택 학점인정과목 -->
														
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_title"><td colspan="4">일반선택 학점인정 과목</td></tr>
											<tr class="ta_score"><td>자격증명</td><td>컬러리스트 산업기사</td><td></td><td>16</td></tr>
											<td>발급기관</td><td>한국산업인력공단<td colspan="2" rowspan="3"></td></td></tr>
											<td>시험과목</td><td>색채디자인, 색채관리, 색채심리, 색채지각의이해, 색채체계의이해</td></tr>
											<td>관련전공(학사)</td><td>시각디자인학 전공, 산업디자인 전공</td></tr>
											</tbody></table>
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_score"><td>자격증명</td><td>유통관리사 2급</td><td></td><td>10</td></tr>
											<td>발급기관</td><td>대한상공회의소<td colspan="2" rowspan="3"></td></tr>
											<td>시험과목</td><td>상권분석, 유통마케팅, 유통정보, 유통물류일반관리</td></tr>
											<td>관련전공(학사)</td><td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공, 멀티미디어학 전공</td></tr>
											</tbody></table>
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_score"><td>자격증명</td><td>컴퓨터활용능력 1급</td><td></td><td>14</td></tr>
											<td>발급기관</td><td>대한상공회의소<td colspan="2" rowspan="3"></td></tr>
											<td>시험과목</td><td>컴퓨터 일반, 스프레드시트 일반, 데이터베이스 일반</td></tr>
											<td>관련전공(학사)</td><td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공, 멀티미디어학 전공</td></tr>
											</tbody></table>
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_score"><td>자격증명</td><td>컴퓨터활용능력 2급</td><td></td><td>6</td></tr>
											<td>발급기관</td><td>대한상공회의소<td colspan="2" rowspan="3"></td></tr>
											<td>시험과목</td><td>컴퓨터 일반, 스프레드시트 일반</td></tr>
											<td>관련전공(학사)</td><td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공, 멀티미디어학 전공</td></tr>
											</tbody></table>
											<table><colgroup><col style="width:146px;" /><col style="width:573px;" /><col style="width:76px;" /><col style="width:76px;" /></colgroup><tbody>
											<tr class="ta_score"><td>자격증명</td><td>워드프로세서(구 워드 1급)</td><td></td><td>4</td></tr>
											<td>발급기관</td><td>대한상공회의소<td colspan="2" rowspan="3"></td></tr>
											<td>시험과목</td><td>PC운영체제, 워드프로세싱 용어 및 기능, PC기본상식</td></tr>
											<td>관련전공(학사)</td><td></td></tr>
											</tbody></table>	
							

											<!-- 일반선택 학점인정과목 -->
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="ta_txt">
							<ul>
								<li>* 학사학위 취득 예정자는 총 3개의 자격증을 학점으로 인정받을 수 있습니다.<br>&nbsp;&nbsp;&nbsp;단, 전공필수 학점으로 인정되는 자격증은 최대 2개, 일반선택 학점으로 인정되는 자격증은 최대 1개입니다.</li>
								<li>*동일직무(대분류-중분류-직무번호 동일)내에 속하는 자격증은 여러 개를 취득하여도 학생이 선택하는 1개의 자격에 대해서만 학점인정이 가능하니 주의하시기 바랍니다.<br>&nbsp;&nbsp;&nbsp;예) 컴퓨터활용능력과 워드프로세서 1급은 동일직무자격으로 1개만 인정됨.</li>
								<li>*자격<br>&nbsp;&nbsp;&nbsp;학점환산표는 자격 취득 시기 및 학점인정 신청 접수 시기 등에 따라 다르게 계산될 수 있으므로 정확한 인정학점은 국가평생교육진흥원의 공지를 따르시기 바랍니다.</li>
								<li>*자격증<br>&nbsp;&nbsp;&nbsp;취득 후 학점인정신청은 학생 개인별로 진행해야 하며 자세한 내용은 학점은행제 콜센터(1600-0400)에 문의하시기 바랍니다.</li>
							</ul>
						</div>
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