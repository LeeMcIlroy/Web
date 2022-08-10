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
		            <jsp:param name="dept2" value="타일디자인시공"/>
		            <jsp:param name="dept3" value="교과과정"/>
	           	</jsp:include>
				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorCourse.do?menuType=01'/>">교과 과정</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorCourse.do?menuType=02'/>">교과목 개요</a></li>
					</ul>
				</div>
				<div class="sub_cont_page">
					<c:if test="${searchVO.menuType eq '01' }">
							<div class="ta_overbox">
								<table class="ta874_ty02" summary="교과 과정 정보를 학년, 이수구분, 1학기(교과목명, 학점), 이수구분, 2학기(교과목명, 학점) 순서로 보여줍니다.">
								<caption>교과 과정표</caption>
								<colgroup>
									<col style="width:110px;" />
									<col style="width:110px;" />
									<col style="width:162px;" />
									<col style="width:110px;" />
									<col style="width:110px;" />
									<col style="width:162px;" />
									<col style="width:110px;" />
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
										<td>7</td>
									</tr>
								</tfoot>
								<tbody>
									<tr><td rowspan="8">1학년</td><td>전필</td><td class="ta_left">표현기법</td><td>3</td><td>전필</td><td class="ta_left">드로잉 I</td><td>3</td></tr>
									<tr><td>전필</td><td class="ta_left">CAD실습 I</td><td>3</td><td>전필</td><td class="ta_left">실내건축제도</td><td>3</td></tr>
									<tr><td>전필</td><td class="ta_left">실내디자인론</td><td>3</td><td>전필</td><td class="ta_left">실내디자인실습 I</td><td>3</td></tr>
									<tr><td>일선</td><td class="ta_left">컴퓨터그래픽스 I</td><td>3</td><td>전선</td><td class="ta_left">CAD실습 II</td><td>3</td></tr>
									<tr><td>전선</td><td class="ta_left">기초디자인</td><td>3</td><td>전선</td><td class="ta_left">인테리어그래픽 I</td><td>3</td></tr>
									<tr><td>교양</td><td class="ta_left">색채학</td><td>3</td><td class="r_txt">교양</td><td class="ta_left r_txt">건축과주거환경</td><td class="r_txt">3</td></tr>
									<tr><td></td><td class="ta_left"></td><td></td><td class="r_txt">교양</td><td class="ta_left r_txt">미학개론</td><td class="r_txt">3</td></tr>
									<tr><td></td><td class="ta_left"></td><td></td><td>교양</td><td class="ta_left">생활과디자인</td><td>3</td></tr>

									<tr><td rowspan="6">2학년</td><td>전필</td><td class="ta_left">실내디자인실습 II</td><td>3</td><td>전선</td><td class="ta_left">공간디자인실습</td><td>3</td></tr>
									<tr><td>전선</td><td class="ta_left">디자인론</td><td>3</td><td>전선</td><td class="ta_left">구조학</td><td>3</td></tr>
									<tr><td class="r_txt">전선</td><td class="ta_left r_txt">인테리어그래픽 II</td><td class="r_txt">3</td><td>일선</td><td class="ta_left">컴퓨터애니메이션</td><td>3</td></tr>
									<tr><td>전선</td><td class="ta_left">실내디자인사 I</td><td>3</td><td>전선</td><td class="ta_left">현대건축론</td><td>3</td></tr>
									<tr><td>교양</td><td class="ta_left">사진촬영과감상</td><td>3</td><td>교양</td><td class="ta_left">사진촬영과감상</td><td>3</td></tr>
									<tr><td>교양</td><td class="ta_left">영화예술의이해</td><td>3</td><td>교양</td><td class="ta_left">영화예술의이해</td><td>3</td></tr>

									<tr><td rowspan="7">3학년</td><td>전선</td><td class="ta_left">시각디자인</td><td>3</td><td>전선</td><td class="ta_left">실시설계</td><td>3</td></tr>
									<tr><td>전선</td><td class="ta_left">프리젠테이션</td><td>3</td><td>전선</td><td class="ta_left">사진과디자인</td><td>3</td></tr>
									<tr><td>전선</td><td class="ta_left">실내의장</td><td>3</td><td>전선</td><td class="ta_left">디스플레이</td><td>3</td></tr>
									<tr><td>전선</td><td class="ta_left">조명디자인 I</td><td>3</td><td class="r_txt">일선</td><td class="ta_left r_txt">무대미술 I</td><td class="r_txt">3</td></tr>
									<tr><td class="r_txt">전선</td><td class="ta_left r_txt">가구디자인</td><td class="r_txt">3</td><td class="r_txt">전선</td><td class="ta_left r_txt">가구디자인실습</td><td class="r_txt">3</td></tr>
									<tr><td class="r_txt">교양</td><td class="ta_left r_txt">미니정원만들기</td><td class="r_txt">3</td><td class="r_txt">교양</td><td class="ta_left r_txt">미니정원만들기</td><td class="r_txt">3</td></tr>
									<tr><td>교양</td><td class="ta_left">코디네이트미학</td><td>3</td><td>교양</td><td class="ta_left">코디네이트미학</td><td>3</td></tr>

									<tr><td rowspan="6">4학년</td><td>전선</td><td class="ta_left">전시디자인</td><td>3</td><td>전선</td><td class="ta_left">포트폴리오</td><td>3</td></tr>
									<tr><td>일선</td><td class="ta_left">시각디자인실습 I</td><td>3</td><td>전선</td><td class="ta_left">디자인세미나</td><td>3</td></tr>
									<tr><td>전선</td><td class="ta_left">디자인마케팅</td><td>3</td><td class="r_txt">전선</td><td class="ta_left r_txt">실내환경론</td><td class="r_txt">3</td></tr>
									<tr><td class="r_txt">전선</td><td class="ta_left r_txt">재료와시공</td><td class="r_txt">3</td><td>전선</td><td class="ta_left">건축설비 I</td><td>3</td></tr>
									<tr><td>전선</td><td class="ta_left">한국건축과실내</td><td>3</td><td></td><td class="ta_left"></td><td></td></tr>
									<tr><td>일선</td><td class="ta_left">홈페이지설계</td><td>3</td><td></td><td class="ta_left"></td><td></td></tr>

									<tr><td rowspan="7">자격증</td><td>전공</td><td class="ta_left">실내건축기사</td><td>20</td><td>일선</td><td class="ta_left">컬러리스트기사</td><td>20</td></tr>
									<tr><td></td><td class="ta_left">실내건축산업기사</td><td>16</td><td></td><td class="ta_left">컬러리스트산업기사</td><td>16</td></tr>
									<tr><td></td><td class="ta_left">건축목공산업기사</td><td>16</td><td></td><td class="ta_left">컴퓨터활용능력1급</td><td>14</td></tr>
									<tr><td></td><td class="ta_left">목재창호산업기사</td><td>16</td><td></td><td class="ta_left">컴퓨터활용능력2급</td><td>6</td></tr>
									<tr><td></td><td class="ta_left"></td><td></td><td></td><td class="ta_left">워드프로레서1급</td><td>4</td></tr>
									<tr><td></td><td class="ta_left"></td><td></td><td></td><td class="ta_left">GTQ(그래픽기술)1급</td><td>5</td></tr>
									<tr><td></td><td class="ta_left"></td><td></td><td></td><td class="ta_left">GTQ(그래픽기술)2급</td><td>3</td></tr>
								</tbody>
							</table>
						</div>
						<div class="ta_txt">
							<ul>
								<li class="r_txt">* 붉은색으로 표기된 과목은 평가인정 예정과목입니다.</li>
							</ul>
						</div>
					</c:if>
					<c:if test="${searchVO.menuType eq '02' }">
						<dl class="info_dl">
							<dd>
								<dl class="info_dl_txt">
									<dt>드로잉 I	</dt>
									<dd>조형예술의 근본이 되는 드로잉을 통하여 대상물에 대한 관찰력과 표현력 및 공간과 사물과의 관계를 파악하는 능력을 기르며, 대상을 관찰·인식·묘사하는 과정을 연계시켜 드로잉의 개념을 이해한다. 대상을 분석하여 개념화·기호화하는 과정을 거쳐 드로잉 기법을 연마하고 터득한다.</dd>
									<dt>CAD실습 I	</dt>
									<dd>컴퓨터 분야의 발달로 작업의 효율성, 정보의 체계적인 관리 그리고 생산성 향상이 이루어지고 있다. 본 교과는 컴퓨터 그래픽 주변기기와 소프트웨어인 AUTO CAD 프로그램을 이용하여 실제도면을 KS에 맞게 완성하여 도면화 하고 관리할 수 있는 능력을 배양한다.</dd>
									<dt>디자인론	</dt>
									<dd>근대 디자인의 형성기에 나타난 현상·사조 등의 이론적 배경을 파악한다. 특히 현대 디자인 운동을 계기로 여러 분야에서 일고 있는 포스트모더니즘 현상과 여러 커뮤니케이션 분야에서 발전하는 디자인의 현상들을 점검하고, 디자인의 시대상황을 예측하는 능력을 기른다.</dd>
									<dt>컴퓨터그래픽스 I	</dt>
									<dd>Illustrator의 사용과 운용체계 등을 공부하고, 수작업을 컴퓨터에 옮겨 손쉽게 Print해 낼 수 있도록 실습한다.</dd>
									<dt>평면조형	</dt>
									<dd>2차원 예술의 기본 조형원리와 그 특성인 공간의 요리, 물성의 이해, 색의 조화 를 기본적으로 추구한다. 구성원리와 원근법, 반복과 대비 등 전통의 미학과 현 대의 평면조형원리를 재정립하여 평면예술의 개념을 환기시키고, 지적이며 현대 적인 조형 이미지를 창출한다.</dd>
									<dt>색채학	</dt>
									<dd>색상·명도·채도의 정확한 정의와 디자인의 가시적 체계를 이해하고 기능적인 색의 개념과 색의 표시법을 익힘으로써 색의 구조와 종류를 체계적으로 이해한다.</dd>
									<dt>사진촬영과 감상	</dt>
									<dd>사진 전반에 걸친 기초이론과 실제를 배우고 기존 작품의 해석을 통해 사진에 대한 이해를 돕는다. 아울러 사진작품을 직접 제작해봄으로써 사진을 통해 제작자의 이상과 현실을 새로운 시각으로 바라보는 기회를 갖는다.</dd>
									<dt>표현기법	</dt>
									<dd>표현양식에는 여러 가지 기법과 또한 재료들이 산재해 있다. 이러한 모든 방법들 을 제시하고 이끌어 가는 과정으로 소프트한 소재로부터 하드한 소재까지 다양 한 재료를 다루어 적절한 표현력을 갖도록 학습한다.</dd>
									<dt>실내디자인론	</dt>
									<dd>표현양식에는 여러 가지 기법과 또한 재료들이 산재해 있다. 이러한 모든 방법들 을 제시하고 이끌어 가는 과정으로 소프트한 소재로부터 하드한 소재까지 다양 한 재료를 다루어 적절한 표현력을 갖도록 학습한다.</dd>
									<dt>실내건축제도	</dt>
									<dd>제도의 기본적인 지식을 중심적으로 이해하며, 공간표현의 기초적인 방법들을 개별적인 유형으로 해결함으로써 추상적 개념에서 구체적 개념으로의 전환이라는 사실적 표현능력을 학습한다.</dd>
									<dt>CAD 실습 II	</dt>
									<dd>본 교과는 CADⅠ에서 배운 2차원의 일반도면을 기본으로 향상된 제도기술을 학습하고, 더욱 효율적인 도면 제작 방법과 3차원 모델링 능력을 습득한다.</dd>
									<dt>기초디자인	</dt>
									<dd>평면 및 입체적인 조형능력을 함양하는데 필요한 기초적인 디자인 이론과 조형언어를 교수하는 과목으로, 기본적인 조형요소 및 조형원리에 관한 강의와 평면적·입체적 매체를 이용한 다양한 내용의 실기로 구성된다. 이 과목을 통해 평면적·입체적 형태에 관한 미적 조형능력을 함양한다.</dd>
									<dt>구조학	</dt>
									<dd>합리적인 공간을 디자인하기 위해 건축의 기본 구조를 이해하고, 인테리어와 연계시켜 문제점을 최대한 보완하여 경제적이고 실용적으로 디자인하는 능력을 기른다.</dd>
									<dt>건축과 주거환경	</dt>
									<dd>문명의 발달이나 도시의 출현으로 변화된 인간의 주거생활을 이해하고, 건축과 관련된 주거환경의 문화적 지표, 변천과정, 관련 법규 등을 학습한다.</dd>
									<dt>미학개론	</dt>
									<dd>미와 미학적 사고의 여러 흐름을 연대적으로 살펴보고 미학의 기본 개념들과 주요이론을 각 부문별로 고찰하며, 현대미학이 해결해야 할 과제와 문제점을 진단해 본다.</dd>
									<dt>실내 디자인 실습 I	</dt>
									<dd>이론 및 일련의 실내디자인 프로젝트를 통하여 디자인 과정과 방법을 터득하고, 디자인 아이디어를 도면을 통해 합리적으로 표현할 수 있도록 실습한다.</dd>
									<dt>컴퓨터그래픽스 II	</dt>
									<dd>실무에서 가장 많이 쓰이는 Photoshop의 색상ㆍ입체ㆍFilter 효과를 이용하여 CD재킷이나 Poster 등을 편집할 수 있도록 실습하며 Sketch up의 사용법을 실습한다.</dd>
									<dt>실내 디자인사 I	</dt>
									<dd>실내디자인 역사의 기본이 되는 동서양의 문화를 이해한다. 이를 위해서 건축, 환경, 실내공간 디자인, 가구, 조명에 대한 역사적인 배경을 고찰하고, 고대·중세·근대·현대에 이르는 건축양식의 특징과 내부공간 구성에 나타난 디자인적 특성을 살펴봄으로써 실내공간을 계획할 때 고유성과 다양성을 표현하도록 한다.</dd>
									<dt>실내환경론	</dt>
									<dd>실내환경은 우리가 살아가는 실내건축공간을 과학적이고 합리적이며 환경친화적인 거주 활동으로 만드는데 필수 불가결한 분야이다. 자연을 분리하여 건축물을 설계할 수 없는 없다는 인식과 삶의 질적인 향상으로 인해 현실에 부합하는 환경적 요소들을 실내환경에 적용하는 것이 고려되고 있다. 본 교과목에서는 실내건축환경의 여러 인자에 대한 이해를 근거로 하여 각 단원별 환경적인 요소들을 체계적으로 학습한다.</dd>
									<dt>사진학개론 I	</dt>
									<dd>사진의 일반적인 이론을 체계적으로 분류하여 공부한다. 사진공부의 첫 과정에서부터 사진제작에 필요한 문제들을 다루며 사진의 개념, 정의, 촬영의 각종 조건, 구도의 변화, 색채의 각종 요소와 사진의 윤리적인 측면 등 다양한 이론적 기초를 쌓는다. 안정된 작품제작과 창작 및 표현기술의 숙련을 위한 과목이다.</dd>
									<dt>디지털 디자인 I	</dt>
									<dd>컴퓨터 그래픽 활용을 위한 제반 지식과 기본 기법을 습득하여 디자인 프로세스에서의 적응력을 기르며, 최종 인쇄물에 이르는 디자인 과정을 학습한다.</dd>
									<dt>미니정원 만들기	</dt>
									<dd>콘크리트 건물 속에서 생활하는 현대인에게 식물과 첨경(添景) 소재를 이용하여 작은 공간이라도 즐겁게 자연을 접할 수 있는 기술을 습득함으로써 Green Life 를 실현할 수 있는 가능성을 모색한다.</dd>
									<dt>실용영어회화	</dt>
									<dd>기초적인 의사소통 상황에서 외국인과 효과적인 대화를 할 수 있도록 언어적·문화적·담화적 능력을 기르도록 한다.</dd>
									<dt>실내 디자인 실습 II	</dt>
									<dd>실내디자인Ⅰ에서 학습한 자료를 토대로 문제점을 발견할 수 있는 안목을 배양하며 계획단계에서 나타난 문제점을 해결하여 아이디어를 구체적으로 전개함으로써 더욱 향상된 디자인 실무 능력을 배양한다.</dd>
									<dt>재료와 시공	</dt>
									<dd>실내건축에 주로 사용되는 재료의 성질과 용도를 연구하고, 디자인 실무에 적용할 수 있는 재료의 시공법 및 가공법과 도구사용법 등을 실습을 통하여 숙지함으로써 실내디자이너로서의 기술을 습득한다.</dd>
									<dt>현대 건축론	</dt>
									<dd>산업혁명 이후부터 현대까지의 사회, 문화, 경제, 기술의 변화 발전에 따른 예술과 건축의 사조를 알게 하고 여러 사조와 경향에서 만들어져 온 건축 작품을 분석하여 작가의 정신과 기량을 정확히 파악하도록 한다.</dd>
									<dt>디자인 세미나	</dt>
									<dd>최근 디자인분야에서 주목을 끄는 주제를 선정하여 관련 서적 및 자료를 조사·탐독하고 토론을 전개함으로써 산업디자인의 전개에 도움을 줄 기본적인 디자인 안목을 수립하고 최신 디자인 경향에 대한 이해를 높이기 위해 마련된 과목이다.</dd>
									<dt>컴퓨터 애니메이션	</dt>
									<dd>2D 및 3D 애니메이션의 기초개념과 제작과정, 기법 등을 학습하고 3D MAX와 같은 3D 애니메이션 소프트웨어를 사용한 기본적인 애니메이션 제작을 실습한다.</dd>
									<dt>생활과 디자인	</dt>
									<dd>프로그래밍의 기본 문법과 컴퓨터 직접 조작할 수 있는 기본 프로그램능력을 기르고, 이론과 실습을 통하여 윈도우즈 환경에서 프로그램을 작성하고 실무에 적용할 수 있는 능력을 배양한다. 또한 모바일을 제어 할 수 있는 기본 프로그램도 함께 익힌다.</dd>
									<dt>건축 설비 I	</dt>
									<dd>건물의 유형 및 거주자의 활동목적에 따라 요구되는 각종 성능을 고려함으로써 건축물의 질을 높이고 재실자의 쾌적도 및 작업능률을 향상시키려는 측면에서 건축설비의 중요성이 고조되고 있다. 쾌적한 실내 환경을 조성하기 위한 각종 설비 시스템의 기본원리를 이해하고 습득할 수 있도록 한다.</dd>
									<dt>디자인 마케팅	</dt>
									<dd>디자인 마케팅에 대한 전략적 원리와 지침, 기법 등을 학습하여 조형적인 창작활동과 여러 분야 학문에 응용함으로써 디자인 프로세스에 대한 전문적인 지식을 갖추도록 한다.</dd>
									<dt>공간 디자인 실습	</dt>
									<dd>디자인의 기본적인 요소를 이해하고 표현하고자 하는 모티브나 아이디어를 형상화하여 창조적인 표현활동과 조형감각을 경험한다. 또한 다양한 개성을 합리적으로 표출하는 방법을 학습한다.</dd>
									<dt>조명 디자인 I	</dt>
									<dd>공간의 4차원 디자인 요소인 빛의 미학적, 광학적 기본원리를 익히고, 조명의 종류 및 특성을 파악하며 조명의 효과 및 기능을 이해하여 공간계획시 활용할 수 있는 조명 설계 능력을 배양한다.</dd>
									<dt>프리젠테이션	</dt>
									<dd>기획서 및 시안을 통해 자신의 작품에 대한 의도, 발상, 효과 등을 제3자에게 효과적으로 전달할 수 있도록 과학적인 접근방법, 자료추출 및 정리, 표현방법 및 기법 등을 분석하고 연마할 수 있는 능력을 배양한다.</dd>
									<dt>편집 디자인 실습 I	</dt>
									<dd>시각적 질서를 통해 가장 효과적인 커뮤니케이션이 이루어져야 하므로 편집디자인의 중추적인 요소인 레이아웃과 그리드 시스템의 활용방법에 중점을 두고 인쇄체를 실습한다.</dd>
									<dt>광고학	</dt>
									<dd>광고의 개념과 본질을 이론적으로 파악하여 광고의 기본 원리를 이해하고, 광고의 사회적·산업적 환경과 기능을 살펴봄으로써 광고의 사회적 의의와 업무 구조 및 환경을 이해한다. 광고업무 및 광고교육의 구성 및 내용을 학습하여 광고에 대한 이해를 돕는다.</dd>
									<dt>포트폴리오	</dt>
									<dd>각 교과목에서 창출된 작품 및 디자인 프로젝트 결과를 자료로 정리하여 시각화하는 기법을 연구하며, 클라이언트에게 결과물을 효과적으로 제시하고 전달할 수 있는 포트폴리오의 제작방법과 프리젠테이션 기법을 익힌다.</dd>
									<dt>시각디자인론	</dt>
									<dd>디자인 개념과 시각 디자인의 다양한 적용 그리고 관련 분야와의 상호 관계를 일별한다. 시각 디자인 이해에 필요한 조형 이론을 소개함으로써 디자인의 실재적 효용성에 대한 학습 및 디자인 전개와 평가를 위한 기초를 습득한다.</dd>
									<dt>시각 디자인	</dt>
									<dd>시각디자인의 전반적인 원리와 이론을 분석하고 Lay-Out의 구성과 광고 효과를 고려한 포스터 및 내용과 관련된 북 디자인의 기본 원리 및 제작과정 등을 학습 한다.</dd>
									<dt>디스플레이	</dt>
									<dd>전시와 진열, 구매의 효과적인 도모를 위하여 인간과 디스플레이 대상의 주위 환경과의 유기적인 질서와 조화를 도출할 수 있는 이론과 실제를 탐구한다.</dd>
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