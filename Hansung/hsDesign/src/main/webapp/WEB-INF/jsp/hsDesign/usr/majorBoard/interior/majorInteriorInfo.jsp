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
			
				<!-- sns -->
				<%-- 
				<div class="top_sns">
					<ul>
						<li><a href="<c:url value='http://cafe.naver.com/edubankhs'/>" title="[새창] 네이버 블로그 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_n.jpg'/>" alt="네이버 블로그" /></a></li>
						<li><a href="<c:url value='https://www.facebook.com/hansungart'/>" title="[새창] 페이스북 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_f.jpg'/>" alt="페이스북" /></a></li>
						<li><a href="<c:url value='https://www.youtube.com/channel/UCnb-63kSFrD6o84QfIKt2SQ'/>" title="[새창] 유튜브 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_y.jpg'/>" alt="유투브" /></a></li>
					</ul>
				</div>
				 --%>
				<!-- //sns -->
				
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle2.jsp">
					<jsp:param name="dept1" value="전공"/>
		            <jsp:param name="dept2" value="실내디자인"/>
		            <jsp:param name="dept3" value="전공안내"/>
	           	</jsp:include>
				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorInfo.do?menuType=01'/>">전공 소개</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorInfo.do?menuType=02'/>">자격증 정보</a></li>
					</ul>
				</div>
				<div class="sub_cont_page">
					<c:if test="${searchVO.menuType eq '01' }">
						<dl class="info_dl">
							<dd>
								<p> 실내디자인전공은 실내공간을 인간이 생활하기에 편리하고 아름답고 쾌적한 환경으로 디자인할 수 있는 능력을 배양하여 미래의 공간 문화를 선도할 수 있는 ‘공간연출디자이너’를 양성하는 전공과정이다.</p>
                         <p>이를 위해 주거공간, 상업공간, 복합 및 문화공간 등에 대해 학습하고, 건축요소, 재료, 가구, 색채, 조명 등 실내구성요소에 대한 다양한 교육과정이 편성되어 있습니다. 또한 쾌적하고 아름다운 공간을 연출하기 위하여 각 product[가구, 마감재, 색채, 조명, 패브릭 등]의 특성을 정확하게 관찰, 분석한 후, 이들의 적절한 선택을 통하여 공간을 스타일링하는 능력을 키우고자 한다.</p> 
                         <p>이를 통하여 공간연출에서 요구되는 창의적이고 합리적인 사고과정의 학습을 통해 예술과 기능성이 높은 공간을 창출할 수 있는 능력 있는 <span>[건축디자이너]</span>, <span>[인테리어디자이너]</span>,<span>[전시디자이너]</span>, <span>[부동산컨설턴트]</span> 등의 미래 공간문화 선도자를 양성하는데 교육목표를 두고 있다.</p>
                        
                        <p>매년 수차례 진행되는 견학, 국내건축답사, 해외건축답사, 특강, 실무연계수업 등을 통하여 유연한 사고와 생동감 있는 디자인 특성화수업을 진행하며, 배출된 많은 졸업생들이 실무현장에서 두각을 나타내고 있고, 국내외 다양한 공모전에서도 매년 우수한 성적을 보여주고 있다.</p>
                        
                        <p>또한, 대학원 진학을 희망하는 학생들이 100% 진학률을 나타내고 있으며, 입학부터 취업(대학원진학/유학)까지의 다양한 진로에 맞게 개인별 1:1 상담을 추구한다.</p>			
				</dd>
						</dl>
						<div class="sub_cont_box">
							<div class="tit_3rd">실내디자인 전공과정</div>
							<%-- 2020-06-02
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/interiorInfo_01.jpg"/>
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/interiorInfo_02.jpg"/>
							<br><br><br>
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/interiorInfo_03.jpg"/>
							<br><br><br>
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/interiorInfo_04.jpg"/>
							<br><br><br>
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/interiorInfo_05.jpg"/>
							--%>

							<%-- 2020-06-28
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/interiorInfo_06.png"/>
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/interiorInfo_07.png"/>
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/interiorInfo_08.png"/>--%>

							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/roadMap_interior_01.jpg"/>
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/roadMap_interior_02.jpg"/>		
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/roadMap_interior_03.jpg"/>
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/roadMap_interior_04.jpg"/>
							<img src="${pageContext.request.contextPath }/assets/usr/img/interior/roadMap_interior_05.jpg"/>
							<%--
							<div class="ta_type_dl">
								<dl>
									<dt><span>1학년</span></dt>
									<dd><span>공통기초과정[기초디자인1/2, 드로잉, 디자인 이론, 컴퓨터그래픽, 표현기법, 실내디자인 이론, 실내건축제도, 인테리어그래픽, 조형실습, 건축과주거] 등</span></dd>
								</dl>
								<dl>
									<dt><span>2학년</span></dt>
									<dd><span>[인테리어설계3/4, 디자인세미나, 사진과디자인, 가구디자인, 가구설계실습, 모형제작, 3DS MAX, 인테리어마감재 코디네이션, 생활과디자인]</span></dd>
								</dl>
								<dl>
									<dt><span>3학년</span></dt>
									<dd><span>[인테리어설계5/6, 인테리어 코디네이션, 공간디자인 실습(무대디자인), 시각디자인, 디자인경영과 브랜드전략, 디자인리서치와 마케팅, 전시기획 및 디스플레이]</span></dd>
								</dl>
								<dl>
									<dt><span>4학년</span></dt>
									<dd><span>[인테리어설계7, 졸업설계, 전시디자인, 포트폴리오제작, 인테리어 디테일, 프리젠테이션, 실시설계] 외 실무연계수업 & 기업인턴</span></dd>
								</dl>
							</div>
							--%>
							<!-- <div class="ta_txt">
								<ul>
									<li>매년 수차례 진행되는 견학, 국내건축답사, 해외건축답사, 특강, 실무연계수업 등을 통하여 유연한 사고와 생동감 있는 디자인 특성화수업을 진행하며, 배출된 많은 졸업생들이 실무현장에서 두각을 나타내고 있고, 국내외 다양한 공모전에서도 매년 우수한 성적을 보여주고 있다.</li>
									<li>또한, 대학원 진학을 희망하는 학생들이 100% 진학률을 나타내고 있으며, 입학부터 취업(대학원진학/유학)까지의 다양한 진로에 맞게 개인별 1:1 상담을 추구한다.</li>
								</ul>
							</div> -->
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
								<thead >
									<tr>
										<th scope="col" colspan="2" rowspan="2" >내용</th>
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
														<td>실내건축 기사</td>
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
															- 필기 1. 실내디자인론 2. 색채학 3. 인간공학 4. 건축재료 5. 건축일반 6. 건축환경<br>
															- 실기 : 건축실내의 설계 및 시공 실무검정방법<br>
															- 필기 : 객관식 4지 택일형 과목당 20문항(과목당 30분)<br>
															&nbsp;&nbsp;&nbsp;– 실기 : 복합형[필답형(1시간) + 작업형(6시간 정도)]합격기준<br>
															- 필기 : 100점을 만점으로 하여 과목당 40점 이상, 전과목 평균 60점 이상<br>
															&nbsp;&nbsp;&nbsp;– 실기 : 100점을 만점으로 하여 60점 이상
														</td>
													</tr>
													<tr>
														<td>관련전공(학사)</td>
														<td>실내디자인 전공, 건축공학 전공</td>
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
														<td>실내건축 산업기사</td>
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
														<td>
															- 필기 : 1. 실내디자인론 2. 색채 및 인간공학 3. 건축재료 4. 건축일반<br>
															- 실기 : 건축실내의 설계 및 시공 실무검정방법<br>
															&nbsp;&nbsp;&nbsp;– 필기 : 객관식 4지 택일형 과목당 20문항(과목당 30분)<br>
															&nbsp;&nbsp;&nbsp;– 실기 : 복합형[필답형(1시간) + 작업형(5시간 정도)]합격기준<br>
															- 필기 : 100점을 만점으로 하여 과목당 40점 이상, 전과목 평균 60점 이상.<br>
															&nbsp;&nbsp;&nbsp;– 실기 : 100점을 만점으로 하여 60점 이상.
														</td>
													</tr>
													<tr>
														<td>관련전공(학사)</td>
														<td>실내디자인 전공, 건축공학 전공</td>
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
													<tr class="ta_title">
														<td colspan="4">일반선택 학점인정 과목</td>
													</tr>
													<tr class="ta_score">
														<td>자격증명</td>
														<td>컬러리스트 기사</td>
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
														<td>
															- 필기 1. 색채심리.마케팅 2. 색채디자인 3. 색채관리 4. 색채지각론 5. 색채체계론<br>
															- 실기 : 색채계획 실무검정방법 - 필기 : 객관식 4지 택일형 과목당 20문항(과목당 30분)<br>
															&nbsp;&nbsp;&nbsp;– 실기 : 작업형(6시간 정도)합격기준 <br>
															&nbsp;&nbsp;&nbsp;– 필기 : 100점 만점 40점 이상, 전과목 평균 60점 이상 <br>
															&nbsp;&nbsp;&nbsp;– 실기 : 100점 만점 60점 이상
														</td>
													</tr>
													<tr>
														<td>관련전공(학사)</td>
														<td></td>
													</tr>

													<tr class="ta_score">
														<td>자격증명</td>
														<td>시각디자인 기사</td>
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
														<td>
															시각디자인론, 사진 및 인쇄제판론, 색채학, 광고학, 조형심리학
														</td>
													</tr>
													<tr>
														<td>관련전공(학사)</td>
														<td>시각디자인학 전공</td>
													</tr>

													<tr class="ta_score">
														<td>자격증명</td>
														<td>게임그래픽 전문가</td>
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
														<td>
															게임제작개론, 게임그래픽디자인, 게임그래픽제작, 그래픽 디자인론
														</td>
													</tr>
													<tr>
														<td>관련전공(학사)</td>
														<td>시각디자인학 전공, 멀티미디어학 전공, 게임프로그래밍학 전공</td>
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
														<td colspan="2" rowspan="3"></td>
													</tr>
													<tr>
														<td>시험과목</td>
														<td>
															인쇄 및 사진기법, 시각디자인론, 시각디자인 실무이론, 색채학
														</td>
													</tr>
													<tr>
														<td>관련전공(학사)</td>
														<td>시각디자인학 전공</td>
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
														<td colspan="2" rowspan="3"></td>
													</tr>
													<tr>
														<td>시험과목</td>
														<td>
															- 필기: 1. 색채심리 2. 색채디자인 3. 색채관리 4. 색채지각의 이해 5. 색채체계의 이해<br>
															- 실기 : 색채계획 실무검정방법<br>
															&nbsp;&nbsp;&nbsp;– 필기 : 객관식 4지 택일형, 과목당 20문항(과목당 30분)<br>
															&nbsp;&nbsp;&nbsp;– 실기 : 작업형(5시간 정도)합격기준 <br>
															&nbsp;&nbsp;&nbsp;– 필기 : 100점을 만점으로 하여 과목당 40점 이상, 전과목 평균 60점 이상. <br>
															&nbsp;&nbsp;&nbsp;– 실기 : 100점을 만점으로 하여 60점 이상.
														</td>
													</tr>
													<tr>
														<td>관련전공(학사)</td>
														<td></td>
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
														<td>
															컴퓨터 일반, 스프레드시트 일반, 데이터베이스 일반
														</td>
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
														<td>
															컴퓨터 일반, 스프레드시트 일반
														</td>
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
														<td>
															PC운영체제, 워드프로세싱 용어 및 기능, PC기본상식
														</td>
													</tr>
													<tr>
														<td>관련전공(학사)</td>
														<td></td>
													</tr>
												</tbody>
											</table>
											<!--// 타이틀, 20학점 -->
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