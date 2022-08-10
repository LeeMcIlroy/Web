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
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="진로&교양과정"/>
		            <jsp:param name="dept2" value="진로체험안내"/>
	           	</jsp:include>
				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do?menuType=01'/>">디자인분야 진로체험스쿨(school) 안내</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do?menuType=02'/>">진로체험 직업분야 소개</a></li>
					</ul>
				</div>
				
				<c:if test="${searchVO.menuType eq '01' }">
					<ol class="ag_box">
						<li>디자인분야 진로체험스쿨(school) 안내
							<dl>
								<dt>1. 교육목적</dt>
								<dd>
									- 중·고등학생들에게 미래유망 분야인 디자인 세계의 직업에 대한 정보를 제공하고, 진로체험을 통해 향후 가지게 될 직업에 대한 문화적, 환경적 트랜드를 체험함으로써 미래직업에 대한 전문가적인 진로설계 지원
								</dd>
							</dl>
							<dl>
								<dt>2. 교육일정</dt>
								<dd>
									- 전형일정 : 진로스쿨 - 1. 2학기중. 방중 캠프 운영<br>
									- 진행장소 : 한성대학교 한디원 전용 강의실 &amp; 뷰티센터 &amp; 상상관
								</dd>
							</dl>
							<dl>
								<dt>3. 교육내용</dt>
								<dd>
									- 중·고등학생 대상 진로분야 디자인 진로체험 및 직업관련 진로 멘토링<br>
									- 진로분야 대학전공 수업체험<br>
									- 디자인분야 관심학생 대상 테마별 트렌드 현장체험<br>
									- 다양한 디자인분야 직업군 정보 공유<br>
									- 디자인분야 현직 전문가들에 의한 진로 및 취업상담
								</dd>
							</dl>
							<dl>
								<dt>4. 교육분야 (진로체험 12개 분야)</dt>
								<dd>
									- 시각패키지디자이너 / 광고디자이너(광고마케팅) / 웹디자이너<br>
									- 영상디자이너·방송PD / 웹툰·게임그래픽작가<br>
									- 실내건축디자이너 / 동화일러스트작가 / 주얼리디자이너<br>
									- 패션디자이너 / 패션코디·패션스타일리스트<br>
									- 뷰티메이크업 코디네이터 / 헤어코디네이터
								</dd>
							</dl>
							<dl>
								<dt>5. 신청방법</dt>
								<dd>
									- 관내 : 성북진로직업체험센터(미래창창) 문의 / 02-2038-2132<br>
									- 기타지역 : 한성대학교 한디원 교학팀 문의 / 02-760-5781<br>
									&nbsp;&nbsp;&nbsp;※&nbsp;“진로체험 꿈길”&nbsp;등록 가능
								</dd>
							</dl>
							<dl>
								<dt>6. 기대효과</dt>
								<dd>
									- 진학분야와 관련된 전공 수업 실제 체험을 통해 학문적 필요성을 깨달음<br>
									- 디자인 분야 진로 체험을 통해 미래의 꿈을 구체화하고 기대 함양<br>
									- 자기 재능을 발견할 기회를 제공함에 따라 향후 진로 직업 선택에 이바지함
								</dd>
							</dl>
						</li>
					</ol>
				</c:if>
				<c:if test="${searchVO.menuType eq '02' }">
					<ol class="ag_box">
						<li>진로체험 직업분야 소개
							<dl>
								<dt>1. 시각패키지디자이너</dt>
								<dd>
									- 상품 포장에 이미지를 입히는 작업, 라벨 형태, 종이 포장형태, 케이스디자인, 쇼핑백디자인 등 제품별 패키지 도안을 만들어 입체 형태로 포장디자인 완성해보는 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="시각패키지디자이너">
											<caption>시각패키지디자이너</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 시각, 패키지디자이너란?</th>
													<td class="ta_left">
														<p>- 시각디자인 분야의 패키지디자인 영역</p>
														<p>- 패키지디자이너 진출분야</p>
														<p>- 패키지의 트렌드 / 패키지 관련 기업 상품 소개</p>
														<p>- 시각디자인전공과 패키지디자이너분야 비전</p>
													</td>
												</tr>
												<tr>
													<th>2. 패키지디자이너 체험실습</th>
													<td class="ta_left">
														<p>- 패키지 관련 상품군(식품, 생활, 전자, 문구, 의류 등)</p>
														<p>- 패키지 이미지 패턴 만들기<br>&nbsp;&nbsp;&nbsp;이미지 도식화 표현, 기하학적 표현(패턴화), 색상 적용</p>
														<p>- 패키지 지기구조 만들기<br>&nbsp;&nbsp;&nbsp;포장지 / 상자 / 라벨 / 쇼핑백 구조 등 - 패키지 제작 및 구성</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>2. 광고디자이너(광고마케팅)</dt>
								<dd>
									- 광고는 소비자들에게 상품 고유 이미지로 소통하고, 팔고자 하는 상품의 장점을 소비자들에게 가장 효과적으로 전달하는 시각적 소통방법에 대해 아이디어와 광고 발상을 통한 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="광고디자이너(광고마케팅)">
											<caption>광고디자이너(광고마케팅)</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 광고디자이너란?</th>
													<td class="ta_left">
														<p>- 광고란?</p>
														<p>- 광고디자이너의 역할</p>
														<p>- 광고디자인 관련 취업 분야 소개</p>
														<p>- 유행하는 광고, 재미있는 광고, 아이디어 광고, 매체 광고</p>
													</td>
												</tr>
												<tr>
													<th>2. 상품/공익광고 체험실습</th>
													<td class="ta_left">
														<p>- 광고와 판매를 위한 광고 소개</p>
														<p>- 광고의 아이디어 발상</p>
														<p>- 광고 스토리 만들기(스토리보드)</p>
														<p>- 광고제작 가상 연출</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/exper_info_01.jpg" style="margin-top: 10px;">
								</dd>
							</dl>
							<dl>
								<dt>3. 동화일러스트작가</dt>
								<dd>
									- 일러스트레이터에 대해 이해하고, 청소년의 무한한 상상력을 이야기로 풀어나가면서, 내가 동화책 주인공이 되어 나만의 동화책을 직접 만들어 보는 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="동화일러스트작가">
											<caption>동화일러스트작가</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 일러스트레이터란?</th>
													<td class="ta_left">
														<p>- 일러스트레이터의 의미와 역할</p>
														<p>- 일러스트레이터의 세부 직업군 탐색</p>
													</td>
												</tr>
												<tr>
													<th>2. 일러스트레이터 직업체험</th>
													<td class="ta_left">
														<p>- 일러스트레이션을 활용한 아트상품‘핸드메이드 노트’제작<br>&nbsp;&nbsp;&nbsp;자유 드로잉을 확인하여 노트 표지 내지 구성 및 제본</p>
														<p>- 일러스트레이션을 활용한 아트상품‘greeting card’제작<br>&nbsp;&nbsp;&nbsp;기념일에 대한 연상 드로잉 또는 페인팅<br>&nbsp;&nbsp;&nbsp;카드 구조 설계 / 제작 / 레터링지를 이용하여 문구 장식</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>4. 웹디자이너</dt>
								<dd>
									- 온라인으로 효과적으로 정보전달을 할 수 있는 웹디자인에 대해 알아보고, 직접 웹디자이너가 되어 나만의 홈페이지를 제작해보는 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="웹디자이너">
											<caption>웹디자이너</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 웹디자이너란?</th>
													<td class="ta_left">
														<p>- 온라인 커뮤니케이션 디자인</p>
														<p>- 인터넷을 통한 정보 전달 방법</p>
														<p>- 홈페이지 디자이너 이해</p>
													</td>
												</tr>
												<tr>
													<th>2 웹디자이너 체험</th>
													<td class="ta_left">
														<p>- 기본 HTML을 이용하여 디자인하기</p>
														<p>- 나만의 홈페이지 디자인 만들기</p>
														<p>- 웹에디터를 이용한 나만의 홈페이지 제작</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/exper_info_02.jpg" style="margin-top: 10px;">
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/exper_info_03.jpg" style="margin-top: 10px;">
								</dd>
							</dl>
							<dl>
								<dt>5. 영상디자이너/방송PD</dt>
								<dd>
									- 영상공모전, 영상편집, 모션그래픽, 영화 VFX 및 영상합성, 디지털애니메이션 등 다양한 분야에 대해 알아보고 제작과정을 입체적으로 풀어 영상제작의 비밀을 학습하고 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="영상디자이너/방송PD">
											<caption>영상디자이너/방송PD</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 영상디자이너란?</th>
													<td class="ta_left">
														<p>- 영상디자이너 직업 종류</p>
														<p>- 영상디자이너가 되기 위한 조건</p>
													</td>
												</tr>
												<tr>
													<th>2. 영상디자이너 직업체험</th>
													<td class="ta_left">
														<p>- 영상디자이너 작업 툴 알아보기</p>
														<p>- Premiere 툴 기초 배워보기</p>
														<p>- AfterEffect 툴 기초 배워보기</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>6. 웹툰/게임그래픽작가</dt>
								<dd>
									- 그래픽 작업에 속하는 원화작업, 캐릭터, 배경 및 UI제작 분야 등 게임과 웹툰의 다양한 분야에 대해 알아롭고, 전체적인 작업 프로세스 과정과 기본적인 프로그램을 직접 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="웹툰/게임그래픽작가">
											<caption>웹툰/게임그래픽작가</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 웹툰작가란?</th>
													<td class="ta_left">
														<p>- 웹툰작가란 직업 알아보기</p>
														<p>- 웹툰작가가 되기 위한 조건</p>
													</td>
												</tr>
												<tr>
													<th>2. 웹툰작가 직업체험</th>
													<td class="ta_left">
														<p>- 웹툰작가 작업 툴 알아보기</p>
														<p>- 기초드로잉 배워보기</p>
														<p>- 신티크를 이용해서 그림그리기</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>7. 실내건축디자이너</dt>
								<dd>
									- 실내건축디자인이 무엇인지 이해하고 라이프 스타일을 반영한 주거의 형태를 표현해 봄. 주거공간, 상업공간, 업무공간, 전 시공간 외 공간을 이해하고 평면도, 입면도, 투시도등의 공간을 이해하고 컬러링 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="실내건축디자이너">
											<caption>실내건축디자이너</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1 인테리어디자이너란? </th>
													<td class="ta_left">
														<p>- 미래의 라이프 스타일을 예측한 주거의 형태 알아보기</p>
														<p>- 인테리어디자이너 직업군 탐색</p>
													</td>
												</tr>
												<tr>
													<th>2 인테리어디자이너 직업체험</th>
													<td class="ta_left">
														<p>- 다양한 공간 이미지 중에 관심 있는 2~3개의 공간이미지 선정</p>
														<p>- 채색도구(마카, 색연필) 사용법과 컬러링 방법을 실습</p>
														<p>- 컬러링 페이퍼에 컬러링 실습</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>8. 주얼리디자이너</dt>
								<dd>
									- 주얼리디자인에 대한 이해와 자신만의 금속공예 디자인을 반영하여 직접 착용할 수 있는 반지를 제작해보는 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="주얼리디자이너">
											<caption>주얼리디자이너</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 주얼리디자이너란?</th>
													<td class="ta_left">
														<p>- 주얼리에 대한 설명과 주얼리 디자이너의 미래와 전망</p>
														<p>- 주얼리에 사용되는 장비와 재료 설명</p>
														<p>- 반지 디자인의 종류 설명</p>
													</td>
												</tr>
												<tr>
													<th>2. 주얼리디자인 직업체험</th>
													<td class="ta_left">
														<p>- 자기만의 반지 디자인 구상</p>
														<p>- 손가락 치수에 맞추어 은반지 제작<br>&nbsp;&nbsp;&nbsp;(절단, 열풀림, 땜, 건조 등 실제 은 제작)</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/exper_info_04.jpg" style="margin-top: 10px;">
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/exper_info_05.jpg" style="margin-top: 10px;">
								</dd>
							</dl>
							<dl>
								<dt>9. 패션디자이너</dt>
								<dd>
									- 패션디자이너의 의미와 역할에 대해 소개하고, 자신만의 개성이 담긴 티셔츠에 홀치기 염색을 활용하여 의상 제작을 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="패션디자이너">
											<caption>패션디자이너</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 패션디자이너란?</th>
													<td class="ta_left">
														<p>- 패션디자이너의 의미와 역할</p>
														<p>- 패션디자이너의 세부 직업군 탐색</p>
													</td>
												</tr>
												<tr>
													<th>2. 패션디자이너 직업체험 </th>
													<td class="ta_left">
														<p>- 홀치기 염색을 활용한 티셔츠 제작<br>&nbsp;&nbsp;&nbsp;염료 만들기 / 티셔츠 방염 / 색상 염색</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>10. 패션코디/패션스타일리스트</dt>
								<dd>
									- 패션 코디 및 패션 스타일리스트에 대한 소개와 나에게 어울리는 이미지와 스타일을 찾아 직접 패션코디를 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="패션코디/패션스타일리스트">
											<caption>패션코디/패션스타일리스트</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 이미지 찾기</th>
													<td class="ta_left">
														<p>- 이미지란?</p>
														<p>- 친구들이 생각하는 이미지(롤링 페이퍼)</p>
														<p>- 내가 생각하는 나의 이미지(브레인 스토밍)</p>
													</td>
												</tr>
												<tr>
													<th>2. 패션스타일 찾기</th>
													<td class="ta_left">
														<p>- 내가 좋아하는 패션 스타일 찾기</p>
														<p>- 나에게 어울리는 패션스타일 찾기</p>
														<p>- 패션이미지맵 만들기</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>11. 뷰티메이크업 코디네이터</dt>
								<dd>
									- 자신에게 또는 상대방에게 어울리는 컬러를 찾고 다양한 메이크업 재료를 이용하여 아름답게 해주는 직업을 직접 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="뷰티메이크업 코디네이터">
											<caption>뷰티메이크업 코디네이터</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 뷰티메이크업 코디네이터?</th>
													<td class="ta_left">
														<p>- 개인에게 어울리는 컬러의 이해</p>
														<p>- 연예인, 정치인, 일반인에게 메이크업으로 어울리는 컬러개성 표현</p>
														<p>- 의상 및 네일 컬러도 이해하여 전체 코디 체험</p>
													</td>
												</tr>
												<tr>
													<th>2. 뷰티메이크업 코디네이터 체험</th>
													<td class="ta_left">
														<p>- 다양한 색조메이크업 재료 소개</p>
														<p>- 시연 및 상호 체험을 통해 분장 과정 체험</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>12. 헤어코디네이터</dt>
								<dd>
									- 헤어코디네이터에 대한 소개와 자신에게 어울리는 헤어 스타일링을 통해 이미지에 맞는 커트, 펌, 업스타일 등을 체험
								</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05" summary="헤어코디네이터">
											<caption>헤어코디네이터</caption>
											<colgroup>
												<col style="" />
												<col style="" />
											</colgroup>
											<tbody>
												<tr>
													<th>1. 헤어코디네이터란?</th>
													<td class="ta_left">
														<p>- 종합적인 뷰티 스타일링 파악</p>
														<p>- 헤어코디네이터 종류와 역할 탐색</p>
														<p>- 헤어코디 도구 활용 및 체험</p>
													</td>
												</tr>
												<tr>
													<th>2 헤어코디네이터 직업체험</th>
													<td class="ta_left">
														<p>- 개인의 결점을 보완하고 장점을 살리는 외모의 이미지 파악</p>
														<p>- 자신에게 어울리는 스타일 진단</p>
														<p>- 이미지에 맞는 헤어스타일, 메이크업, 패션 스타일링 체험</p>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/exper_info_06.jpg" style="margin-top: 10px;">
								</dd>
							</dl>
						</li>
					</ol>
				</c:if>
				<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
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