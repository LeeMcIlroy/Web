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
							<jsp:param name="dept2" value="시각디자인" />
							<jsp:param name="dept3" value="전공안내" />
						</jsp:include>
						<div class="top_tab type_li2">
							<ul>
								<li
									<c:if test="${searchVO.menuType eq '01' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualInfo.do?menuType=01'/>">전공
										소개</a></li>
								<li
									<c:if test="${searchVO.menuType eq '02' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualInfo.do?menuType=02'/>">자격증
										정보</a></li>
							</ul>
						</div>
						<div class="sub_cont_page">
							<c:if test="${searchVO.menuType eq '01' }">
								<dl class="info_dl">
									<dd>
										<p>
											시각디자인은 문화와 디지털매체, 소통을 위한 커뮤니케이션 문제 해결을 위한 하나의 방식이 아닌 새로운 답을
											찾기 위한 실무교육의 현장입니다. 시각디자인 교육 과정은 이러한 시대적 요구에 능동적으로 대처 하기위해
											창의적인 아이디어와 감각적인 디자인 능력을 갖춘 디자인 전문가를 양성하기 위해 유연성 있게 변화되어
											왔습니다. 시각디자인 전공은 커뮤니케이션을 하기위한 여러 가지 수단매체 활용 및 기초 시각디자인 과정을 통해
											시각적 전달을 위한 정보화와 시각커뮤니케이션 이론과 실제를 연구하는 전문 <span>[시각·패키지디자이너]
												[광고·브랜드디자이너] [일러스트레이터] [웹UX·UI디자이너]</span> 를 양성한다는 데 전공 목표를 두고
											있습니다.
										</p>

										<p>시각디자인 전공은 실제 실무에서 요구 되어 지고 있는 전문성을 위해 각 분야 기업 디자이너 출신의
											강사진을 통한 현장감 있는 교육 시스템을 갖추고 있습니다. 시각적 커뮤니케이션과정을 통해 학생의 디자인적
											감각 유연성과 기업에서 협업 할수 있는 디자이너로 양성하는데 학습의 의의를 두고 있습니다.</p>
									</dd>
								</dl>
								<div class="sub_cont_box">
									<div class="tit_3rd">시각디자인 전공과정</div>
									<img src="${pageContext.request.contextPath }/assets/usr/img/visual/visualInfo_01.jpg" style="width:100%"/>
									<img src="${pageContext.request.contextPath }/assets/usr/img/visual/visualInfo_02.jpg" style="width:100%"/>
									<img src="${pageContext.request.contextPath }/assets/usr/img/visual/visualInfo_03.jpg" style="width:100%"/>
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
																<td>게임그래픽 전문가</td>
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
																<td>게임제작개론, 게임그래픽 디자인, 게임그래픽 제작, 그래픽 디자인론</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>시각디자인학 전공, 멀티미디어학 전공, 게임프로그래밍학 전공</td>
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
																<td>시각디자인학 전공, 산업디자인 전공</td>
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
																<td>멀티미디어 콘텐츠 제작 전문가</td>
																<td>18</td>
																<td></td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>한국산업인력공단</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>멀티미디어개론, 멀티미디어기획및디자인, 멀티미디어저작, 멀티미디어제작기술</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>시각디자인학 전공, 전자계산학 전공, 멀티미디어학 전공</td>
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
																<td>시각디자인학 전공, 산업디자인 전공</td>
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
															<tr class="ta_score">
																<td>자격증명</td>
																<td>시각디자인 산업기사</td>
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
																<td>인쇄 및 사진기법, 시각디자인론, 시각디자인실무이론, 색채학</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>시각디자인학 전공</td>
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
																<td>GTQ1급</td>
																<td>5</td>
																<td></td>
															</tr>
															<tr class="ta_score">
																<td style="background-color: white;"></td>
																<td style="background-color: white;" >GTQ2급</td>
																<td style="background-color: white;" >3</td>
																<td style="background-color: white;" colspan="2" rowspan="3"></td>
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
																<td>프로그래밍일반, 게임제작개론, 게임알고리즘, 게임프로그램작성</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공, 멀티미디어학 전공,
																	게임프로그래밍학 전공</td>
															</tr>

															<tr class="ta_score">
																<td>자격증명</td>
																<td>제품디자인 산업기사</td>
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
																<td>인간공학, 색채학, 공업재료 및 모형제작론, 제품디자인론</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>산업디자인 전공</td>
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
																<td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공, 정보보호학 전공, 멀티미디어학
																	전공</td>
															</tr>

															<tr class="ta_score">
																<td>자격증명</td>
																<td>유통관리사 2급</td>
																<td></td>
																<td>10</td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>대한상공회의소</td>
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
																<td>컴퓨터활용능력 2급</td>
																<td></td>
																<td>6</td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>대한상공회의소</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>컴퓨터 일반, 스프레드시트 일반</td>
															</tr>
															<tr>
																<td>관련전공(학사)</td>
																<td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공, 멀티미디어학 전공</td>
															</tr>

															<tr class="ta_score">
																<td>자격증명</td>
																<td>워드프로세서(구 워드 1급)</td>
																<td></td>
																<td>4</td>
															</tr>
															<tr>
																<td>발급기관명</td>
																<td>대한상공회의소</td>
																<td colspan="2" rowspan="3"></td>
															</tr>
															<tr>
																<td>시험과목</td>
																<td>PC운영체제, 워드프로세싱 용어 및 기능, PC기본상식</td>
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