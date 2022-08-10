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
		            <jsp:param name="dept2" value="디지털아트"/>
		            <jsp:param name="dept3" value="전공안내"/>
	           	</jsp:include>
				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtInfo.do?menuType=01'/>">전공 소개</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtInfo.do?menuType=02'/>">자격증 정보</a></li>
					</ul>
				</div>
				
				<div class="sub_cont_page">
					<c:if test="${searchVO.menuType eq '01' }">
						<dl class="info_dl">
							<dd>
							<p><strong>디지털시대의 창조적 교육, 미래 유망직업 디지털아트!</strong></p>
                                   <p>오늘날 우리는 새로운 매체들을 통해 장소에 상관없이 많은 정보를 더욱 쉽고 빠르게 접할 수 있는 시대에 살고 있습니다. 디지털 산업은 방송제작환경과 컴퓨터 기술 및 새로운 트렌드의 콘텐츠에 대한 수요의 증가에 따라 끊임없이 변화하고 여러 가지 분야에 적용되며 계속해서 발전하고 있습니다. 이러한 변화는 대중의 의식과 감각을 한층 업그레이드시키고 소비자들의 욕구를 충족시키기 위한 새롭고 다양한 콘텐츠(영상,애니메이션,웹툰,게임일러스트레이션)를 요구 하고 있습니다.</p>
								
								<p>따라서 차별화되고 독창적이며 수준 있는 디지털 콘텐츠 제작을 위해 디자인에 대한 이해와 색채, 타이포에 대한 교육을 바탕으로 한 방송영상 기획 및 촬영, 영상편집, 영상CG, 모션그래픽, 캐릭터 컨셉 디자인, 3D 캐릭터 모델링, 애니메이션, 게임캐릭터, 게임배경, UI디자인, 출판만화, 웹툰, 편집디자인 등의 전문적인 교육을 실시합니다.</p>
								
								<p>디지털아트전공에서는 빠르게 변하는 21세기에 다양한 콘텐츠를 기획하고 실무에서 바로 적응할 수 있는 제작 인력 양성을 목표로 영상디자인, 디지털애니메이션, 웹툰 콘텐츠디자인, 게임일러스트레이션의 세부화된 진출분야를 통해 다양한 콘텐츠를 제작할 수 있는 창의적 인재육성을 목표로 하여 디자인교육을 기본으로 한 실무 중심교육을 실시하고 있습니다.

                                   </p>
							</dd>
						</dl>
						<div class="sub_cont_box">
							<div class="tit_3rd">디지털아트 전공과정</div>
<%-- 							<img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/digitalArtInfo_01.jpg"/>
							<img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/digitalArtInfo_02.jpg"/>
							<img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/digitalArtInfo_03.jpg"/> --%>
							<img src="${pageContext.request.contextPath }/assets/usr/img/digitalArt/test.jpg"/>
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