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
		            <jsp:param name="dept2" value="산업디자인"/>
		            <jsp:param name="dept3" value="교과과정"/>
	           	</jsp:include>
				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialCourse.do?menuType=01'/>">교과 과정</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialCourse.do?menuType=02'/>">교과목 개요</a></li>
					</ul>
				</div>
				<div class="sub_cont_page">
					<c:if test="${searchVO.menuType eq '01' }">
							<div class="ta_overbox">
								<table class="ta874_ty02"
									summary="교과 과정 정보를 학년, 이수구분, 1학기(교과목명, 학점), 이수구분, 2학기(교과목명, 학점) 순서로 보여줍니다.">
									<caption>교과 과정표</caption>
									<colgroup>
										<col style="width: 110px;" />
										<col style="width: 110px;" />
										<col style="width: 162px;" />
										<col style="width: 110px;" />
										<col style="width: 110px;" />
										<col style="width: 162px;" />
										<col style="width: 110px;" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" rowspan="2">학년</th>
											<th scope="col" rowspan="2">이수구분</th>
											<th scope="col" colspan="2">1학기</th>
											<th scope="col" rowspan="2">이수구분</th>
											<th scope="col" colspan="2">2학기</th>
										</tr>
										<tr>
											<th scope="col">교과목명</th>
											<th scope="col">학점</th>
											<th scope="col">교과목명</th>
											<th scope="col">학점</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<td colspan="2">총계</td>
											<td>전공필수(과목수)</td>
											<td>7</td>
											<td></td>
											<td>전공선택(과목수)</td>
											<td>12</td>
										</tr>
									</tfoot>
									<tbody>
										<tr>
											<td rowspan="6">1학년</td>
											<td>전필</td>
											<td class="ta_left r_txt">디자인론*</td>
											<td>3</td>
											<td>전필</td>
											<td class="ta_left r_txt">색채학*</td>
											<td>3</td>
										</tr>
										<tr>
											<td>전선</td>
											<td class="ta_left">기초디자인</td>
											<td>3</td>
											<td>전선</td>
											<td class="ta_left r_txt">디자인경영과브랜드전략*</td>
											<td>3</td>
										</tr>
										<tr>
											<td>전선</td>
											<td class="ta_left">드로잉 I</td>
											<td>3</td>
											<td>전선</td>
											<td class="ta_left">프리젠테이션</td>
											<td>3</td>
										</tr>
										<tr>
											<td>교양</td>
											<td class="ta_left">생활과디자인</td>
											<td>3</td>
											<td>교양</td>
											<td class="ta_left r_txt">PC활용 I*</td>
											<td>3</td>
										</tr>
										<tr>
											<td>교양</td>
											<td class="ta_left">생활예절</td>
											<td>3</td>
											<td>일선</td>
											<td class="ta_left">디지털조형</td>
											<td>3</td>
										</tr>
										<tr>
											<td>일선</td>
											<td class="ta_left">표현기법</td>
											<td>3</td>
											<td></td>
											<td class="ta_left"></td>
											<td></td>
										</tr>
										
										<tr>
											<td rowspan="5">2학년</td>
											<td>전필</td>
											<td class="ta_left r_txt">CAD*</td>
											<td>3</td>
											<td>전필</td>
											<td class="ta_left r_txt">3D컴퓨터그래픽*</td>
											<td>3</td>
										</tr>
										<tr>
											<td>전선</td>
											<td class="ta_left">타이포그래피</td>
											<td>3</td>
											<td>전선</td>
											<td class="ta_left">인터페이스디자인</td>
											<td>3</td>
										</tr>
										<tr>
											<td>일선</td>
											<td class="ta_left r_txt">디지털조형실습*</td>
											<td>3</td>
											<td>전선</td>
											<td class="ta_left">디자인세미나</td>
											<td>3</td>
										</tr>
										<tr>
											<td>일선</td>
											<td class="ta_left r_txt">제작실습 I*</td>
											<td>3</td>
											<td>교양</td>
											<td class="ta_left">사진촬영과감상</td>
											<td>3</td>
										</tr>
										<tr>
											<td>교양</td>
											<td class="ta_left">영화예술의이해</td>
											<td>3</td>
											<td>일선</td>
											<td class="ta_left">홈페이지설계</td>
											<td>3</td>
										</tr>

										<tr>
											<td rowspan="6">3학년</td>
											<td>전필</td>
											<td class="ta_left">제품기획론</td>
											<td>3</td>
											<td>전필</td>
											<td class="ta_left r_txt">제품디자인 I*</td>
											<td>3</td>
										</tr>
										<tr>
											<td>전선</td>
											<td class="ta_left">프리젠테이션</td>
											<td>3</td>
											<td>전선</td>
											<td class="ta_left">디자인마케팅</td>
											<td>3</td>
										</tr>
										<tr>
											<td>교양</td>
											<td class="ta_left r_txt">경영학개론*</td>
											<td>3</td>
											<td>전선</td>
											<td class="ta_left">사진과디자인</td>
											<td>3</td>
										</tr>
										<tr>
											<td>일선</td>
											<td class="ta_left r_txt">비주얼머천다이징*</td>
											<td>3</td>
											<td>교양</td>
											<td class="ta_left">광고학</td>
											<td>3</td>
										</tr>
										<tr>
											<td>일선</td>
											<td class="ta_left">패션악세사리디자인</td>
											<td>3</td>
											<td>전선</td>
											<td class="ta_left">디자인리서치와마케팅</td>
											<td>3</td>
										</tr>
										<tr>
											<td>전선</td>
											<td class="ta_left">가구디자인</td>
											<td>3</td>
											<td></td>
											<td class="ta_left"></td>
											<td></td>
										</tr>
										<tr>
											<td rowspan="4">4학년</td>
											<td>전필</td>
											<td class="ta_left r_txt">재료와생산공정*</td>
											<td>3</td>
											<td>전선</td>
											<td class="ta_left">포트폴리오</td>
											<td>3</td>
										</tr>
										<tr>
											<td>전선</td>
											<td class="ta_left">디자인세미나</td>
											<td>3</td>
											<td>일선</td>
											<td class="ta_left">디스플레이</td>
											<td>3</td>
										</tr>
										<tr>
											<td>교양</td>
											<td class="ta_left">코디네이트미학</td>
											<td>3</td>
											<td>일선</td>
											<td class="ta_left">전시디자인</td>
											<td>3</td>
										</tr>
										<tr>
											<td>일선</td>
											<td class="ta_left">패션악세사리디자인</td>
											<td>3</td>
											<td>일선</td>
											<td class="ta_left">세일즈프로모션전략 I</td>
											<td>3</td>
										</tr>
										

										<tr>
											<td rowspan="6">자격증</td>
											<td rowspan="6">전필</td>
											<td class="ta_left">제품디자인기사</td>
											<td>20</td>
											<td rowspan="6">일선</td>
											<td class="ta_left">게임그래픽전문가</td>
											<td>20</td>
										</tr>
										<tr>
											<td class="ta_left">제품디자인산업기사</td>
											<td>16</td>
											<td class="ta_left">시각디자인산업기사</td>
											<td>16</td>
										</tr>
										<tr>
											<td class="ta_left">컬러리스트산업기사</td>
											<td>16</td>
											<td class="ta_left">컴퓨터활용능력1급</td>
											<td>14</td>
										</tr>
										<tr>
											<td class="ta_left">서비스.경험디자인기사</td>
											<td>20</td>
											<td class="ta_left">컴퓨터활용능력2급</td>
											<td>6</td>
										</tr>
										<tr>
											<td class="ta_left"></td>
											<td></td>
											<td class="ta_left">유통관리사2급</td>
											<td>10</td>
										</tr>
										<tr>
											<td class="ta_left"></td>
											<td></td>
											<td class="ta_left">워드프로세서</td>
											<td>4</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="ta_txt">
								<ul>
									<li class="r_txt">※ 붉은색으로 표기된 과목은 평가인정 예정과목입니다.</li>
								</ul>
							</div>
					</c:if>
					<c:if test="${searchVO.menuType eq '02' }">
						<dl class="info_dl">
							<dd>
								<dl class="info_dl_txt">
									<dt>드로잉 I</dt>
									 
									<dd>조형예술의 근본이 되는 드로잉을 통하여 대상물에 대한 관찰력과 표현력 및 공간과 사물과의 관계를
										파악하는 능력을 기르며, 대상을 관찰·인식·묘사하는 과정을 연계시켜 드로잉의 개념을 이해한다. 대상을 분석하여
										개념화·기호화하는 과정을 거쳐 드로잉 기법을 연마하고 터득한다.</dd>

									<dt>CAD실습 I</dt>
									 
									<dd>컴퓨터 분야의 발달로 작업의 효율성, 정보의 체계적인 관리 그리고 생산성 향상이 이루어지고
										있다. 본 교과는 컴퓨터 그래픽 주변기기와 소프트웨어인 AUTO CAD 프로그램을 이용하여 실제도면을 KS에
										맞게 완성하여 도면화 하고 관리할 수 있는 능력을 배양한다.</dd>

									<dt>드로잉</dt>
									 
									<dd>드로잉을 통해 디자인의 발상법과 표현 방법을 체계적으로 접근해보고 아이디어 발상과 스케치를 통해
										드로잉 표현 기법 및 전개과정을 연구하고, 제품을 표현하기 위한 기초학습 후 디자인 응용을 전개 할 수 있도록
										하는 수업</dd>
									 
									<dt>색채학</dt>
									<dd>색상·명도·채도의 정확한 정의와 디자인의 가시적 체계를 이해하고 기능적인 색의 개념과 색의
										표시법을 익힘으로써 색의 구조와 종류를 체계적으로 이해한다. 또한 컬러리스트 자격증 대비를 위한 이론 및
										실기를 병행한다.</dd>
									 
									<dt>CAD</dt>
									<dd>산업디자인 프로세스에서 제작 및 대량생산에 근간이 되는 설계도를 수작업이 아닌 컴퓨터를 이용해
										빠르고 정확한 설계 및 도면을 작성해 낼 수 있는 능력을 위한 과목. 소프트웨어 AutoCAD를
										활용하여 3차원의 디자인 형태를 한국산업표준(KS)에 적합한 다양한 투상법 및 수치, 척도 등을 학습하고
										실무에서 컴퓨터를 이용한 설계가 가능하도록 실습한다.</dd>
									 
									<dt>디자인론</dt>
									<dd>근대의 산업혁명에서부터 디자인의 형성기에 나타난 현상·사조 등의 이론적 배경을 파악한다. 특히
										현대 디자인 운동을 계기로 여러 분야에서 일고 있는 포스트모더니즘 현상과 여러 커뮤니케이션 분야에서 발전하는
										디자인의 현상들을 점검하고, 산업 디자인 이해에 필요한 조형 이론을 소개함으로써 디자인의 실재적 효용성에 대한
										학습 및 디자인 전개와 평가를 위한 기초를 습득한다.</dd>
									 
									<dt>평면조형</dt>
									<dd>기본 조형원리인 평면과 공간, 물성, 색의 조화를 기본적으로 추구하며, 색의 강약으로의
										원근법, 반복되는 패턴과 색과 크기의 대비 등으로 새로운 평면조형원리를 재정립하고 평면예술의 개념을 중심으로
										현대적인 조형 이미지를 만들고 연구한다.</dd>
									 
									<dt>2D 컴퓨터그래픽</dt>
									 
									<dd>디지털디자인 분야 중 2차원 평면에 관한 디자인작업을 효과적으로 수행하기 위해 2차원 소프트웨어
										프로그램, 포토샵과 일러스트를 기초의 간단한 기능부터 심화단계의 다양한 효과에 이르기까지 다양한 예제를 통해
										배우고, 나아가 디자인 과정에서 다양하게 활용할 수 있는 능력을 겸비토록 실습한다.</dd>
									 
									<dt>디자인제도</dt>
									 
									<dd>디자인 과정 중에 가장 기본이 되는 형태 표현의 한 방법으로 투시도법과 3면 도법을 습득하고
										모든 형태를 객관성 있는 형태로 전개하여 이에 기준이 되는 도면전개 및 디자인 방법을 체계적으로 이해하고
										적용할 수 있는 능력을 습득한다.</dd>
									 
									<dt>입체조형</dt>
									 
									<dd>창조적인 형태의 미를 연구하는 가장 기초적인 개념으로 2차원의 평면적 형상을 3차원의 입체로
										구현하는 과목. 이를 위해 기본적인 조형요소와 조형원리의 개념을 이해하고, 자연으로 부터 표출되는 조형적
										질서의 관찰과 물리적, 감성적인 형태를 이해한다. 효과적인 조형미의 표현방법과 구조적 형태의 창출방법에 대한
										시도를 입체조형물 표현을 통해 실습한다.</dd>
									 
									<dt>3D 컴퓨터그래픽</dt>
									 
									<dd>산업디자인 프로세스 중 2차원 평면에서 구현한 아이디어 스케치를 시각적, 물리적인 형태의 이해를
										바탕으로 컴퓨터를 이용해 3차원의 형태로 전환할 수 있도록 3D 소프트웨어를 학습하며, 3차원의 모델형태가
										실제제작을 위한 수치와 구조 등이 완벽하게 실현될 수 있도록 연구하고 실습한다. 학습 후
										전공과정에서 3D 모델구현이 자유롭도록 표현능력을 함양한다.</dd>
									 
									<dt>기초디자인</dt>
									 
									<dd>점. 선. 면의 기초 조형 원리를 이용하여 평면 및 입체적인 조형능력을 발전시키는데 필요한
										기초적인 디자인 이론과 조형적 형태의 이해를 배우는 과목으로, 기본적인 조형요소 및 조형원리에 관한 강의와
										평면적·입체적 매체를 이용한 다양한 내용의 실기로 구성된다.</dd>
									 
									<dt>제품기획론</dt>
									 
									<dd>산업디자인의 기초적인 디자인 프로세스를 습득하고 제품기획의 방법을 배우고 실제 제품을
										기획해본다. 제품 기획을 위한 기초 트렌드 분석, 니즈, 정책과 전략, 시장세분화, 조직 및 개발과정 등에
										관련한 이론 수업을 습득하고 기획하는 과정을 이해하고 경험한다.</dd>
									 
									<dt>렌더링I</dt>
									<dd>제품 및 주얼리 디자인에 있어서 제품의 형태를 미리 예상하여 디자인 표현하는 것을
										말하며, 디자인 제작을 위한 기초 과정으로 아이디어 창출을 이해하고, 실무에 있어서 독창성 있는 디자인 형태를
										시각화하여 표현하는 능력을 갖추게 하는 교과목이다.</dd>
									 
									<dt>제품디자인</dt>
									 
									<dd>대량생산에 기반을 두고 제품의 기능성, 심미성, 소비자의 감성 등을 감안해 디자인 형태를
										모색하고 시각적, 물리적으로 디자인을 구체화하는 방법을 학습한다. 소비자의
										필요(Needs), 구매욕구, 경제적, 사회적 가치를 극대화하기 위한 제품 아이디어 콘셉트 개발에서 부터 최종
										생산단계까지 이르는 전반적인 제품디자인 프로세스를 학습하는 과정이다.</dd>
									 
									<dt>보석학</dt>
									 
									<dd>보석의 다양한 종류와 색감을 파악하고 그 특성을 물리적, 화학적 성질로 분석하여 실제 귀금속
										보석 장신구에 접목할 수 있는 이론 및 보석의 감별하는 능력을 기른다.</dd>
									 
									<dt>운송기기디자인</dt>
									<dd>운송수단으로 활용되는 디자인을 전반적으로 이해하여 사용자의 물리적 편의와 동시에 미적 감성을
										만족시켜줄 수 있는 차별화된 운송기기를 디자인하는 능력을 배양한다.효율적인 운송기기를 실현하기 위해 운송기기의
										메커니즘과 구조적인 해석, 인체공학적인 문제들의 상호관계를 고찰하여 실용적이면서도 창의적인 디자인을 모색한다.
									</dd>
									 
									<dt>산업 장신구</dt>
									<dd>장신구 제작 시 세공의 다양한 기법과 귀금속의 성질 및 재료, 가공법의 기초적인 기술을 습득하여
										장신구 제작 및 실무에 필요한 다양한 보석을 통해 작품 제작에 응용하고 기법을 익힌다.</dd>
									 

									<dt>표현기법</dt>
									 
									<dd>재료와 재질을 이용하여 의도적인 효과를 다양하게 도출 해보고 연구하여 결과를 만들어
										낸다. 스크래치, 에칭, 롤 프린팅 등 여러 가지의 기법을 이용하여 새로운 평면 또는 입체로 표현해 내며
										목걸이와 팔찌, 귀걸이, 반지 등을 수작업으로 직접 만들어 보면서 조형 감각을 키우고 다양한 소재의 특성을
										분석하고 아름다음과 기능성 제품을 결합할 수 있도록 한다.</dd>
									 
									<dt>모형제작</dt>
									 
									<dd>자신이 원하는 아이디어 스케치 및 기획안을 사실적, 물리적으로 표현하기 위한 표현방법을 심도
										있게 학습하는 수업. 다양한 재료(종이, 클레이, 금속)를 기반으로 기본적인 제작기법과 도구의
										사용방법, 다양한 가공기법 등을 학습하여 실제 프로토타입 형상을 통해 디자이너의 의도를 구체적으로 전달하는
										능력을 배양한다.</dd>
									 
									<dt>주얼리 CAD</dt>
									<dd>주얼리 산업체에서는 수작업에 의한 소량생산과 대량생산사이에서 소비자의 기호와 다양한 디자인
										개발을 중점적으로 하고자 한다. 이에 맞추어 컴퓨터를 통해 손쉽고 빠르게 렌더링된 쥬얼리 제품을 실물과 제도를
										병행하여 제품을 제작하고 CNC조각과 RP장비를 이용하여 직접 제작하는 과정을 익힌다.</dd>
									 
									<dt>인간중심디자인</dt>
									<dd>일상생활에서 사람이 사용하는 모든 도구, 제품, 시스템 디자인 등 디자인과 인간이 이루는
										상호관계를 심도 있게 관찰 및 연구하는 수업. 인간의 본능, 특성 및 감성을 기반으로 디자인 과정에서
										중시되어야 할 관점을 포괄적으로 파악하여 보다 인간을 배려하는 새로운 디자인경향을 모색하고 시도한다.</dd>
									 
									<dt>인터페이스디자인</dt>
									<dd>인터페이스의 기초개념의 이해를 바탕으로, 새로운 디자인 콘셉트나 현재 존재하지 않는 새로운
										디자인을 모색함에 있어서 인간과 제품 간의 원활한 소통을 위한 새로운 사용 성을 그래픽과 물리적인 형태의
										다양한 시도를 통해 창의적인 인터페이스를 시도하고 모색하는 수업.</dd>
									 
									<dt>보석감정</dt>
									<dd>다이아몬드, 루비, 에메랄드 등의 투명보석과 진주, 오릭스, 옥등의 불투명보석등의 수많은
										보석들의 특성과 성질을 연구하여 감정함으로써 등급을 만들고 그 등급에 맞게 가격을 정하는 것을 연구하는
										수업으로 보석들의 크기, 컬러, 컷팅 등 보석감정의 기본을 배우고 실습한다.</dd>
									 
									<dt>유니버셜디자인</dt>
									<dd>‘모든 사람을 위한 디자인’의 의미처럼 디자인의 공용화를 실현하기 위해 디자인이 일상생활에서
										활용되어지는 다양한 사용 환경을 연구하여 전 세계 많은 다양한 인간(성별,연령, 국적, 문화)의 차이를
										이해하고 새로운 시도를 통해 보다 나은 공공적인 디자인의 가치를 만들어가는 수업.</dd>
									 
									<dt>디자인마케팅</dt>
									<dd>마케팅에 대한 전반적인 개념을 파악하여 보다 구체적이고 과학적인 접근 방법을 통해 디자인의
										전략을 배우는 과목으로, 디자인과 마케팅의 관계를 이해하여 실무에 적응할 수 있도록 한다.</dd>
									 
									<dt>패션 액세서리 디자인</dt>
									<dd>패션 산업과 관련된 핸드백·구두·벨트·지갑과 같은 패션 액세서리의 전반적인 트렌드를 파악하고
										분석하여 패션 및 피혁 등 다양한 분야의 장식품으로 다양한 실물 제작으로 패션 액세서리 제작 과정 및 작업
										방법을 습득한다.</dd>
									 
									<dt>포트폴리오</dt>
									<dd>각 교과목에서 창출된 작품 및 디자인 프로젝트 결과를 자료로 정리하여 클라이언트에게 결과물을
										효과적으로 제시하고 전달할 수 있는 포트폴리오의 제작방법과 프레젠테이션 기법을 익힌다.</dd>
									 
									<dt>사진촬영과 감상</dt>
									<dd>사진 전반에 걸친 기초이론과 실제를 배우고 기존 작품의 해석을 통해 사진에 대한 이해를
										돕는다. 아울러 사진작품을 직접 제작해봄으로써 사진을 통해 제작자의 이상과 현실을 새로운 시각으로 바라보는
										기회를 갖는다.</dd>
									 
									<dt>생활과 디자인</dt>
									<dd>프로그래밍의 기본 문법과 컴퓨터 직접 조작할 수 있는 기본 프로그램능력을 기르고, 이론과 실습을
										통하여 윈도우즈 환경에서 프로그램을 작성하고 실무에 적용할 수 있는 능력을 배양한다. 또한 모바일을 제어 할
										수 있는 기본 프로그램도 함께 익힌다.</dd>


								</dl>
							</dd>
						</dl>
				
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