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
					<jsp:param name="dept1" value="전공" />
					<jsp:param name="dept2" value="일학습엘리트과정" />
					<jsp:param name="dept3" value="글로벌패션창업" />
		            <jsp:param name="dept4" value="교과과정"/>
	           	</jsp:include>
	           	<%--
				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessCourse.do?menuType=01'/>">교과 과정</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessCourse.do?menuType=02'/>">교과목 개요</a></li>
					</ul>
				</div>
	           	--%>
				<div class="sub_cont_page">
					<c:if test="${searchVO.menuType eq '01' }">
						<div class="ta_overbox">
							<table class="ta874_ty02"
								summary="교과 과정 정보를 학년, 이수구분, 1학기(교과목명, 학점), 이수구분, 2학기(교과목명, 학점) 순서로 보여줍니다.">
								<caption>교과 과정표</caption>
								<colgroup>
									<col style="width: ;" />
									<col style="width: ;" />
									<col style="width: ;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">학기</th>
										<th scope="col">전자상거래 교과정</th>
										<th scope="col">패션 교과정</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th style="background-color: #dae6eb;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;">1학기</th>
										<td>
											<p>광고기초 : SNS마케팅 실무</p>
											<p>패션 이밎 실무(사진+포토샵)</p>
											<p>상품기획 실무(포트폴리오&amp;사입)</p>
										</td>
										<td>
											<p>패션과 색채</p>
											<p>패션소재연구</p>
										</td>
									</tr>
									<tr>
										<th style="background-color: #dae6eb;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;">2학기</th>
										<td>
											<p>온라인 채널별 판매 실무</p>
											<p>콘텐츠 크리에이터 전문가 실무</p>
											<p>패션마케팅(4P) 계획서(MD계획서)</p>
										</td>
										<td>
											<p>세일즈프로모션전략</p>
											<p>패션MD</p>
										</td>
									</tr>
									<tr>
										<th style="background-color: #dae6eb;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;">3학기</th>
										<td>
											<p>국내패션쇼핑몰 구축 및 운영</p>
											<p>광고 심화 : 콘텐츠 크리에이터 전문가</p>
											<p>정부지원사업 사업계획서 작성 실무</p>
										</td>
										<td>
											<p>패션VMD</p>
											<p>패션미디어</p>
										</td>
									</tr>
									<tr>
										<th style="background-color: #dae6eb;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;">4학기</th>
										<td>
											<p>글로벌패션쇼핑몰 구축 및 운영(SCM 포함)</p>
											<p>글로벌 마케팅 - 글로벌 광고 실무(영, 중, 일)</p>
											<p>글로벌 입점전략 및 브랜드 관리</p>
										</td>
										<td>
											<p>패션정보기획</p>
											<p>패션포트폴리오</p>
										</td>
									</tr>
									<tr>
										<th style="background-color: #dae6eb;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;">5학기</th>
										<td>
											<p>패션빅데이터 관리(통계기초 포함)</p>
											<p>SEO 최적화 코딩 기초</p>
											<p>O2O 시작확장 전략</p>
										</td>
										<td>
											<p>패션마켓리서치</p>
											<p>패션회계연구 및 기획</p>
										</td>
									</tr>
									<tr>
										<th style="background-color: #dae6eb;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;">6학기</th>
										<td>
											<p>기업가 정신</p>
											<p>투자분석론(재무포함)</p>
											<p>창업인턴십</p>
										</td>
										<td>
											<p>패션기업경영론</p>
											<p>패션소비자행동론</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<%--
						<div class="ta_txt">
							<ul>
								<li>※ 한성대학교 의류학사 의류패션산업전공 학위수여 / <span class="r_txt">*
										붉은색으로 표기된 과목은 평가인정 예정과목입니다.</span></li>
							</ul>
						</div>
						--%>
					</c:if>
					<c:if test="${searchVO.menuType eq '02' }">
					<%--
						<dl class="info_dl">
							<dd>
								<dl class="info_dl_txt">
									<dt>의복과 색채</dt>
									<dd>의상디자인의 3요소 중 하나인 색채에 대한 이론적 학습을 위하여 색의 기본 개념, 색의 체계와
										혼색, 색채 대비 및 조화, 톤, 색채 이미지 등을 학습한다. 또한 의복의 배색과 조화, 의복 색채의 효과,
										의복 색채의 감정 효과, 이미지별 배색효과, 색채 코디네이션 등의 내용을 학습한다.</dd>
									<dt>의복구성 1</dt>
									<dd>의복구성에 대한 기본적인 원리를 이론과 실습으로 습득 학습하고 의복의 종류에 따른 실제
										작품제작의 과정을 익힌다.</dd>
									<dt>의상 사회심리</dt>
									<dd>의복의 사회적, 심리적 측면을 학습하는 과정이다. 인상형성과, 의복의 상징성, 성격 및
										자아개념과 의복, 흥미태도, 가치관과 의복, 의류의 소비행동, 연령에 따른 의복행동 등이 다루어진다.</dd>
									<dt>패션디자인론</dt>
									<dd>패션디자인의 이해를 위한 이론 과목으로 패션디자인의 발상, 패션의 개념, 패션과 디자인,
										색채, 재질, 장식에 대해 공부한다. 비례, 균형, 리듬, 강조 등 패션디자인의 원리를 이해하고 사례를
										살펴본다.</dd>
									<dt>패션마케팅</dt>
									<dd>패션에 대한 이해를 바탕으로 마케팅의 중요한 이론들을 학습하여 패션산업에 적용한다.</dd>
									<dt>패션머천다이징</dt>
									<dd>패션머천다이징의 개념 및 체계를 학습하고 머천다이징 컨셉을 바탕으로 실제적인 브랜드 런칭을
										연습하여 실무지식을 익힌다.</dd>
									<dt>패션상품기획</dt>
									<dd>변화하는 시대의 트렌드를 읽어내어 시장이 요구하는 패션상품을 프로모션하고 그 이미지를
										브랜드화하여 마케팅 전략을 수립하는 다양한 과정을 학습하고 실사례를 연구해 본다.</dd>
									<dt>패션소재연구</dt>
									<dd>의류소재에 관한 과학적 이론과 특성을 통해 패션소재에 대한 이해를 도모한다. 의류 소재의
										소비적 성능, 구성, 섬유의 성질, 실의 성질, 천의 성질 등에 대해 다룬다. 또한, 적절한 소재의 선택,
										취급 및 활동을 위해 의복소재의 구성 원료인 섬유의 물리, 화학적 성질을 공부한다.</dd>
									<dt>복식미학</dt>
									<dd>미학의 기본 개념과 이론을 학습하고 미학적 사고와 관련하여 복식의 의미를 살펴봄으로써 문화와
										예술, 패션의 내적 의미와 지향점을 연구해본다.</dd>
									<dt>비주얼머천다이징</dt>
									<dd>시각적 요소를 통해 상품을 효과적으로 구성하여 기업과 점포의 고유이미지를 확립한다.
										디스플레이, 광고 pop 등을 통해 고객에게 메시지를 전달하고 상품판매의 효율을 높이는 방법을 습득한다.</dd>
									<dt>서양복식사</dt>
									<dd>복식의 기원에서부터 이집트, 르네상스, 바로크 등 시대별 복식의 특징을 살펴본다. 나아가
										복식의 변천사를 통하여 문화와 복식과의 긴밀한 연관성 뿐 아니라 현재의 양식에 대한 이해를 높인다.</dd>
									<dt>패션 e비즈니스</dt>
									<dd>인터넷 및 모바일을 기반으로 하는 비즈니스 이론과 실전 마케팅을 이해하여 쇼핑몰을 운영함에
										있어 필요한 정보 및 능력을 배양한다.</dd>
									<dt>패션 드레이핑 1</dt>
									<dd>의복의 원형을 Dress Form 위에서 Draping 하여 직접 구성하는 것으로 먼저
										기본적인 기초 원형을 만든 후 의복의 디자인에 따른 입체구성을 연습한다.</dd>
									<dt>패션디자인실습 1</dt>
									<dd>의복을 디자인하는데 있어서 기본이 되는 시각 디자인의 기본요소와 기본 원리를 이해하고 응용하여
										의복의 실루엣, 디테일. 트리밍 등을 반영하여 구체적인 디자인 연습을 한다.</dd>
									<dt>패션스타일링</dt>
									<dd>패션스타일링은 대인지각 차원에서 개인의 신체적,사회적 이미지 증진을 위하여 이론과 활용사례를
										학습하고 실습한다.</dd>
									<dt>패션유통론</dt>
									<dd>의복이 완성되어 판매되는 여러 경로를 살펴보고 이 과정에서 발생되는 여러 상황에 대한 이론 및
										실제사례를 연구하고 학습한다.</dd>
									<dt>패션일러스트레이션</dt>
									<dd>패션일러스트레이션은 인체 드로잉과 창작 드로잉, 컬러링과 도식화 등을 통하여 패션 디자인을
										위한 창조적이고 전문적인 표현기법을 익힌다. 포토샵, 일러스트레이터를 활용하여 창의적인 작품을 완성해본다.</dd>
									<dt>패션트렌드분석</dt>
									<dd>현대패션의 변천과정과 유행의 흐름에 대해 학습하고 트렌드를 읽고 예측할 수 있는 능력을
										배양한다.</dd>
									<dt>패션포트폴리오</dt>
									<dd>취업을 앞두고 졸업작품을 정리하는 포트폴리오와 취업용 포트폴리오를 제작하는 과정으로 보다
										효과적인 프리젠테이션 기법을 학습하고 패션기획서를 작성한다.</dd>
									<dt>패션프로모션기획</dt>
									<dd>효과적인 프로모션 방법들을 학습하고 다양한 홍보, 판매촉진, 인적판매의 요소에 대해 연구한다.</dd>

								</dl>
							</dd>
						</dl>
					--%>
					</c:if>
					<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
				</div>
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