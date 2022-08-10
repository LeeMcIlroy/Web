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
							<jsp:param name="dept2" value="산업디자인" />
							<jsp:param name="dept3" value="전공안내" />
						</jsp:include>
						<div class="top_tab type_li2">
							<ul>
								<li
									<c:if test="${searchVO.menuType eq '01' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialInfo.do?menuType=01'/>">전공
										소개</a></li>
								<li
									<c:if test="${searchVO.menuType eq '02' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialInfo.do?menuType=02'/>">자격증
										정보</a></li>
							</ul>
						</div>
						<div class="sub_cont_page">
							<c:if test="${searchVO.menuType eq '01' }">
								<dl class="info_dl">
									<dd>
										<p>
											산업디자인은 인간이 영위하고 있는 일상생활과 사회 환경의 영역에서 우리가 접하고 있는 모든 사물을 디자인의
											대상으로 삼고 있는 디자인분야입니다. 과학기술의 발달, 경제성장 그리고 디지털 정보시대의 도래는 우리의
											라이프스타일을 새로운 형태로 변화시키고 있으며, 그 변화에 의해 산업디자인 영역은 디자인이 우리에게 기본적인
											생활환경의 편리함을 추구하는 것 이외의 인간과 인간이 가지고 있는 주변요소들의 통찰을 통해 본질적이고,
											다각적인 의미를 찾고 있습니다. 이러한 흐름에 맞춰, 한디원 산업디자인 전공에서는 미래사회가 지향하는 사회적
											스펙트럼에 대한 연구와 이해를 바탕으로, 실무전문가들의 창의적 디자인 교육과 철저한 실무 중심적 학습을
											접목함으로써 합리적인 디자인 사고능력과 독창적인 조형능력을 갖춘 <span>[제품디자이너]
												[리빙·주얼리디자이너] [운송·자동차디자이너] </span>를 양성하고, 다변화하는 사회적 수요에 적합한
											전문 디자이너를 키우는데 그 목표를 두고 있습니다.
										</p>

										<p>산업디자인 전공은 1년간의 공통기초과정을 이수한 후, 각 분야별 현직 실무자로 구성된 교수진과 실무
											중심의 수업을 진행합니다. 또한, 실무전문가들의 경험과 디자인철학을 디자인전반에 적용하여 고부가가치를 내포한
											제품을 창출할 수 있는 전문적인 프로세스를 구축하고 있습니다.</p>

										<p>
											<strong>교육목표</strong> <br />① 실무에 충실한 교육으로 전문디자이너의 양성 <br />②
											실무에서 필요로 하는 디자이너로서의 소양과 인격 함양 <br />③ 독창적이고 창의적인 인재 양성

										</p>
									</dd>
								</dl>
								<div class="sub_cont_box">
									<div class="tit_3rd">산업디자인 전공과정</div>
									<img src="${pageContext.request.contextPath }/assets/usr/img/industrial/industrialInfo_01.jpg"/>
									<%--
									<div class="ta_type_dl">
										<dl>
											<dt><span>1학년</span></dt>
											<dd><span>[공통기초과정]&nbsp;디자인론, 색채학, 기초디자인, 드로잉I, 디자인경영과브랜드전략, 표현기법, 생활과디자인, PC활용I, 생활예절</span></dd>
										</dl>
										<dl>
											<dt><span>2학년</span></dt>
											<dd><span>[2D, 3D 능력배양]&nbsp;CAD, 3D컴퓨터그래픽, 타이포그래피, 인터페이스디자인, 디자인세미나, 디지털조형실습, 제작실습I, 영화예술의이해, 사진촬영과감상, 홈페이지설계</span></dd>
										</dl>
										<dl>
											<dt><span>3학년</span></dt>
											<dd><span>[전문성강화과정]&nbsp;제품기획론, 제품디자인I, 프리젠테이션, 디자인마케팅, 사진과디자인, 가구디자인, 경영학개론, 광고학, 비주얼머천다이징, 패션악세사리디자인, 디자인리서치와마케팅</span></dd>
										</dl>
										<dl>
											<dt><span>4학년</span></dt>
											<dd><span>[진로 및 취업준비과정]&nbsp;재료와생산공정, 포트폴리오, 디스플레이, 전시디자인, 코디네이트미학, 세일즈프로모션전략I</span></dd>
										</dl>
									</div>
									--%>
								</div>
							</c:if>
							<c:if test="${searchVO.menuType eq '02' }">
								<div class="ta_overbox">
									<table class="ta874"
										summary="자격증 정보를 내용, 인정학점(전공, 일선) 순서로 보여줍니다.">
										<caption>자격증정보표</caption>
										<colgroup>
											<col style="width: 146px;" />
											<col style="width: 573px;" />
											<col style="width: 76px;" />
											<col style="width: 76px;" />
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
													<!-- 타이틀, 20학점 -->
													<table>
														<colgroup>
															<col style="width: 146px;" />
															<col style="width: 573px;" />
															<col style="width: 76px;" />
															<col style="width: 76px;" />
														</colgroup>
														<tbody>
															<tr class="ta_title">
																<td colspan="4">전공 학점인정과목</td>
															</tr>
															<tr class="ta_score">
																<td>자격증명</td>
																<td>컬러리스트 기사</td>
																<td>20</td>
																<td></td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>색채심리·마케팅, 색채디자인, 색채관리, 색채지각론, 색채체계론</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>산업디자인, 시각디자인학 전공</td>
															</tr>
														</tbody>
													</table> <!--// 타이틀, 20학점 --> <!-- 16학점 -->
													<table>
														<colgroup>
															<col style="width: 146px;" />
															<col style="width: 573px;" />
															<col style="width: 76px;" />
															<col style="width: 76px;" />
														</colgroup>
														<tbody>
															<tr class="ta_score">
																<td>자격증명</td>
																<td>컬러리스트 산업기사</td>
																<td>16</td>
																<td></td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>색채디자인, 색채관리, 색채심리, 색채지각의이해, 색채체계의이해</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>산업디자인, 시각디자인학 전공</td>
															</tr>
														</tbody>
													</table> <!--// 16학점 --> <!-- 타이틀, 20학점 -->
													<table>
														<colgroup>
															<col style="width: 146px;" />
															<col style="width: 573px;" />
															<col style="width: 76px;" />
															<col style="width: 76px;" />
														</colgroup>
														<tbody>
															<tr class="ta_score">
																<td>자격증명</td>
																<td>제품디자인 산업기사</td>
																<td>16</td>
																<td></td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>인간공학, 색채학, 공업재료 및 모형제작론, 제품디자인론</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>산업디자인 전공</td>
															</tr>
														</tbody>
													</table> <!--// 16학점 --> <!-- 타이틀, 20학점 -->

													<table>
														<colgroup>
															<col style="width: 146px;" />
															<col style="width: 573px;" />
															<col style="width: 76px;" />
															<col style="width: 76px;" />
														</colgroup>
														<tbody>
															<tr class="ta_score">
																<td>자격증명</td>
																<td>제품디자인 기사</td>
																<td>20</td>
																<td></td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>
																	<p>필기 : 1. 제품디자인론</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		2. 인간공학</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		3. 공업재료 및 모형제작론</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.
																		색채학</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.
																		제품관리 -실기 : 제품디자인계획 및 실무</p>
																</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>산업디자인 전공</td>
															</tr>
														</tbody>
													</table>




													<table>
														<colgroup>
															<col style="width: 146px;" />
															<col style="width: 573px;" />
															<col style="width: 76px;" />
															<col style="width: 76px;" />
														</colgroup>
														<tbody>
															<tr class="ta_title">
																<td colspan="4">일반선택 학점인정 과목</td>
															</tr>
															<tr class="ta_score">
																<td>자격증명</td>
																<td>게임프로그래밍 전문가</td>
																<td></td>
																<td>20</td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>게임제작개론, 게임그래픽 디자인, 게임그래픽 제작, 그래픽 디자인론</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>시각디자인학 전공, 멀티미디어학 전공, 게임프로그래밍학 전공</td>
															</tr>

															<tr class="ta_score">
																<td>자격증명</td>
																<td>정보처리 산업기사</td>
																<td></td>
																<td>16</td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>전자계산기구조, 정보통신개론, 운영체제, 시스템분석설계, 데이터베이스</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공,정보보호학 전공, 멀티미디어학
																	전공</td>
															</tr>

															<tr class="ta_score">
																<td>자격증명</td>
																<td>컴퓨터활용능력 1급</td>
																<td></td>
																<td>14</td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>대한상공회의소</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>컴퓨터 일반, 스프레드시트 일반, 데이터베이스 일반</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공, 멀티미디어학 전공</td>
															</tr>

															<tr class="ta_score">
																<td>자격증명</td>
																<td>유통관리사 2급</td>
																<td></td>
																<td>10</td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>상권분석, 유통마케팅, 유통정보, 유통물류일반관리</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공, 멀티미디어학 전공</td>
															</tr>

															<tr class="ta_score">
																<td>자격증명</td>
																<td>귀금속가공 산업기사</td>
																<td></td>
																<td>16</td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>
																	<p>필기 : 1. 장신구디자인론</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		2. 보석재료 및 가공기법</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		3. 귀금속재료 및 가공기법- 실기 : 금속공예 실무</p>
																</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>공예학 전공</td>
															</tr>

															<tr class="ta_score">
																<td>자격증명</td>
																<td>귀금속가공 기능사</td>
																<td></td>
																<td></td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>
																	<p>필기 : 1.보석재료</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		2.보석가공</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		3.보석감정- 실기 : 보석가공작업</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		4. 보석가공기법- 실기 : 보석감정 실무</p>
																</td>
															</tr>
															<tr>
																<td></td>
																<td></td>
															</tr>

															<tr class="ta_score">
																<td>자격증명</td>
																<td>보석감정사</td>
																<td></td>
																<td>4</td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>
																	<p>필기 : 1. 보석학일반</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		2. 다이아몬드감정법</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		3. 보석감별법</p>
																	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		4. 보석가공기법- 실기 : 보석감정 실무</p>
																</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td></td>
															</tr>

															<tr class="ta_score">
																<td>자격증명</td>
																<td>주얼리마스터</td>
																<td></td>
																<td>4</td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국보석협회</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>필기 : 1.객관식(주얼리 마케팅, 보석감별및 감정,</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td></td>
															</tr>
														</tbody>
													</table> <!--// 타이틀, 20학점 -->
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="ta_txt">
									<ul>
										<li>* 학사학위 취득 예정자는 총 3개의 자격증을 학점으로 인정받을 수 있습니다.<br>&nbsp;&nbsp;&nbsp;단,
											전공필수 학점으로 인정되는 자격증은 최대 2개, 일반선택 학점으로 인정되는 자격증은 최대 1개입니다.
										</li>
										<li>*동일직무(대분류-중분류-직무번호 동일)내에 속하는 자격증은 여러 개를 취득하여도 학생이
											선택하는 1개의 자격에 대해서만 학점인정이 가능하니 주의하시기 바랍니다.<br>&nbsp;&nbsp;&nbsp;예)
											컴퓨터활용능력과 워드프로세서 1급은 동일직무자격으로 1개만 인정됨.
										</li>
										<li>*자격<br>&nbsp;&nbsp;&nbsp;학점환산표는 자격 취득 시기 및 학점인정
											신청 접수 시기 등에 따라 다르게 계산될 수 있으므로 정확한 인정학점은 국가평생교육진흥원의 공지를 따르시기
											바랍니다.
										</li>
										<li>*자격증<br>&nbsp;&nbsp;&nbsp;취득 후 학점인정신청은 학생 개인별로
											진행해야 하며 자세한 내용은 학점은행제 콜센터(1600-0400)에 문의하시기 바랍니다.
										</li>
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