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
		            <jsp:param name="dept2" value="디지털아트(게임)"/>
		            <jsp:param name="dept3" value="전공안내"/>
	           	</jsp:include>
				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntInfo.do?menuType=01'/>">전공 소개</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntInfo.do?menuType=02'/>">자격증 정보</a></li>
					</ul>
				</div>
				
				<div class="sub_cont_page">
					<c:if test="${searchVO.menuType eq '01' }">
						<dl class="info_dl">
							<dd>
							<p><strong> 전공소개</strong></p>                               
							<%-- <p>21세기 세계는 더 복잡해지고 직업의 경계는 사라져가고 있다.  개인의 잠재력을 키우고 개발하여 자신에게 적합한 직업을 선택하는 것은 개인적 행복과 성취감을 느낄 수 있는 중요한 삶의 길이다. 산업혁명 이후 직업은 봉건사회이후 지배계층을 만들기 위한 보이지 않는 계급을 만드는데 이용되어 왔다. 그러나 21세기 IT기술의 발달과 자아가치가 보편화되면서 직업세계에서 개인의 직업적 잠재능력을 최대한 개발하고 만족한 삶을 살도록 하는 것은 국가의 중요과제로 대두되고 있다.</p>
							<p>최근 새롭게 다양한 직업군들이 등장하면서 개인의 재능과 끼 그리고 직업적 잠재능력을 개발하고 급변하는 사회환경 속에서 능동적으로 적응하고 빠른 변화에 부응 할 수 있는 유연한 창조적 능력의 인재를 키워내는 것은 학교가 해야 될 중요한 임무이다.</p>
							<p>디지털아트(엔터테인먼트)과정은 학생들의 재능과 끼를 바탕으로 4차산업을 이끌 신직업인을 키워내는 혁신적 인재양성을 목표로 하고 있다.  이를 위해 감성능력을 키워내는 수업과 재능을 키워내는 수업을 병행하여 잠재되어 있는 개인능력을 발휘할 수 있도록 창조적 프로그램을 커리큘럼에 적용하고 있다.</p> --%>
							<p>21세기 세계는 더 복잡해지고 직업의 경계는 사라져가고 있다. 개인의 잠재력을 키우고 개발하여 자신에게 적합한 직업을 선택하는 것은 개인적 행복과 성취감을 느낄 수 있는 중요한 삶의 길이다. 또한 21세기 IT 기술의 발달과 자아 가치가 보편화되면서 직업세계에서 개인의 직업적 잠재능력을 최대한 개발하고 만족스러운 삶을 살도록 하는 것이 국가의 중요과제로 대두되고 있다.</p>
							<p>최근 새롭게 다양한 직업군들이 등장하면서 개인의 재능과 끼 그리고 직업적 잠재능력을 개발하고 급변하는 사회환경 속에서 능동적으로 적응하고, 빠른 변화에 부응 할 수 있는 유연한 창조적 능력을 갖춘 인재를 키워내는 것은 학교가 해야 할 중요한 임무이다.</p>
							<p>디지털아트(게임)과정은 학생들의 재능과 끼를 바탕으로 4차산업을 이끌 신직업인을 키워내는 혁신적 인재양성을 목표로 하고 있다. 이를 위해 감성능력을 키워내는 수업과 재능을 키워내는 수업을 병행하여 잠재되어 있는 개인능력을 발휘할 수 있도록 창조적 프로그램을 커리큘럼에 적용하고 있다.</p>
							</dd>
						</dl>
						<!--<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_info_02.png" width="100%"/>-->
							<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/roadMap_digitalArt_game.jpg" width="100%"/>
						<br>
						<%-- <dl class="info_dl">
							<dd>
							<p><strong>“재능중심교육 교육으로 4차산업을 이끌 인재양성”</strong></p>                               
							<p>
								디지털아트(엔터테인먼트) 학위과정은 크리에이터, 성우, e스프츠로 구성되어 있으며 재능있는 인재를 양성하기 위해 관련 협회 및 기업등과 MOU를 통해 지속적 교육커리큘럼 개발과 취업연계를 이뤄가고 있다. 또한 학생들이 참여하는 다양한 행사를 개최함으로써 실전 경험을 할 수 있도록 꾸준히 학생참여 형 행사를 진행하고 있다. 
							</p>
							</dd>
						</dl>
						<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_info_03.png" style="width:48%; height:200px;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_info_04.png" style="width:48%; height:200px;"/>
						<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_info_05.png" />
						<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_info_06.png" />
						<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_info_07.png" />
						<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_info_08.png" />
						<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_info_09.png" /><br>
						<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/dae_info_10.png" /> --%>
						<%-- <div class="sub_cont_box">
							<div class="tit_3rd">디지털아트 전공과정</div>
							<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/digitalEntInfo_01.jpg"/>
							<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/digitalEntInfo_02.jpg"/>
							<img src="${pageContext.request.contextPath }/assets/usr/img/digitalEnt/digitalEntInfo_03.jpg"/>
						</div> --%>
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
												<!-- 타이틀, 20학점 -->
												<table>
													<colgroup>
														<col style="width:146px;" />
														<col style="width:573px;" />
														<col style="width:76px;" />
														<col style="width:76px;" />
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
															<td>
																게임제작개론, 게임그래픽 디자인, 게임그래픽 제작, 그래픽 디자인론
															</td>
														</tr>
														<tr>
															<td>관련전공(학사)</td>
															<td>
																디지털아트학전공, 시각디자인학 전공, 멀티미디어학 전공, 게임프로그래밍학 전공
															</td>
														</tr>
													</tbody>
												</table>
												<!--// 타이틀, 20학점 -->
												<!-- 16학점 -->
												<table>
													<colgroup>
														<col style="width:146px;" />
														<col style="width:573px;" />
														<col style="width:76px;" />
														<col style="width:76px;" />
													</colgroup>
													<tbody>
														<tr class="ta_score">
															<td>자격증명</td>
															<td>게임기획전문가</td>
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
																게임제작개론, 게임콘셉디자인, 게임시스템디자인, 게임서비스디자인, 게임기획실무
															</td>
														</tr>
														<tr>
															<td>관련전공(학사)</td>
															<td>디지털아트학전공,  멀티미디어학 전공, 게임프로그래밍학 전공</td>
														</tr>
													</tbody>
												</table>
												<!--// 16학점 -->
												<!-- 타이틀, 20학점 -->
												<table>
													<colgroup>
														<col style="width:146px;" />
														<col style="width:573px;" />
														<col style="width:76px;" />
														<col style="width:76px;" />
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
															<td>
																멀티미디어개론, 멀티미디어기획및디자인, 멀티미디어저작, 멀티미디어제작기술
															</td>
														</tr>
														<tr>
															<td>관련전공(학사)</td>
															<td>디지털아트학 전공, 시각디자인학 전공, 전자계산학 전공, 멀티미디어학 전공</td>
														</tr>
													</tbody>
												</table>
												<!--// 16학점 -->
												<!-- 타이틀, 20학점 -->
												<table>
													<colgroup>
														<col style="width:146px;" />
														<col style="width:573px;" />
														<col style="width:76px;" />
														<col style="width:76px;" />
													</colgroup>
													<tbody>
														<tr class="ta_score">
															<td>자격증명</td>
															<td>GTQ1급</td>
															<td>5</td>
															<td></td>
														</tr>
														<tr class="ta_score">
															<td>자격증명</td>
															<td>GTQ2급</td>
															<td>3</td>
															<td></td>
														</tr>
													</tbody>
												</table>
												<table>
													<colgroup>
														<col style="width:146px;" />
														<col style="width:573px;" />
														<col style="width:76px;" />
														<col style="width:76px;" />
													</colgroup>
													<tbody>
														<tr class="ta_title">
															<td colspan="4">일반선택 학점인정 과목</td>
														</tr>
														
														<tr class="ta_score">
															<td>자격증명</td>
															<td>시각디자인 산업기사</td>
															<td></td>
															<td>16</td>
														</tr>
														<tr>
															<td>발급기관명</td>
															<td>한국산업인력공단</td>
															<td rowspan="2" colspan="2"></td>
														</tr>
														<tr>
															<td>시험과목</td>
															<td>인쇄 및 사진기법, 시각디자인론, 시각디자인실무이론, 색채학</td>
														</tr>
														
														<tr class="ta_score">
															<td>자격증명</td>
															<td>컬러리스트 산업기사</td>
															<td></td>
															<td>16</td>
														</tr>
														<tr>
															<td>발급기관명</td>
															<td>한국산업인력공단</td>
															<td rowspan="3" colspan="2"></td>
														</tr>
														<tr>
															<td>시험과목</td>
															<td>색채디자인, 색채관리, 색채심리, 색채지각의이해, 색채체계의이해</td>
														</tr>
														<tr>
															<td>관련전공(학사)</td>
															<td>시각디자인학 전공, 산업디자인 전공</td>
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
															<td rowspan="3" colspan="2"></td>
														</tr>
														<tr>
															<td>시험과목</td>
															<td>프로그래밍일반, 게임제작개론, 게임알고리즘, 게임프로그램작성</td>
														</tr>
														<tr>
															<td>관련전공(학사)</td>
															<td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공, 멀티미디어학 전공</td>
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
															<td rowspan="3" colspan="2"></td>
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
															<td rowspan="3" colspan="2"></td>
														</tr>
														<tr>
															<td>시험과목</td>
															<td>전자계산기구조, 정보통신개론, 운영체제, 시스템분석설계, 데이터베이스</td>
														</tr>
														<tr>
															<td>관련전공(학사)</td>
															<td>전자계산학 전공, 컴퓨터공학 전공, 정보통신공학 전공, 정보보호학 전공, 멀티미디어학 전공</td>
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
															<td rowspan="3" colspan="2"></td>
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
															<td rowspan="3" colspan="2"></td>
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
															<td rowspan="3" colspan="2"></td>
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
															<td rowspan="3" colspan="2"></td>
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
												</table>
										</td>
									</tr>
								</tbody>
							</table>
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