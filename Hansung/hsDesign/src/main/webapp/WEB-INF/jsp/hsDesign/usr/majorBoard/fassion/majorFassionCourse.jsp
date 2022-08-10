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
		            <jsp:param name="dept2" value="패션디자인학"/>
		            <jsp:param name="dept3" value="교과과정"/>
	           	</jsp:include>
				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionCourse.do?menuType=01'/>">교과 과정</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionCourse.do?menuType=02'/>">교과목 개요</a></li>
					</ul>
				</div>
				<div class="sub_cont_page">
					<c:if test="${searchVO.menuType eq '01' }">
						<!-- 	200416수정 -->
<!-- 						<div class="ta_overbox"> 
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
									<td>8</td>
									<td></td>
									<td>전공선택(과목수)</td>
									<td>21</td>
								</tr>
							</tfoot>
							<tbody>
								<tr><td rowspan="6">1학년</td><td>전필</td><td>패션디자인론</td><td>3</td><td>전필</td><td>의복과색채</td><td>3</td></tr>
								<tr><td>전필</td><td>패션소재연구</td><td>3</td><td>전필</td><td>의복구성Ⅰ</td><td>3</td></tr>
								<tr><td>전선</td><td>패션일러스트레이션Ⅰ</td><td>3</td><td>전선</td><td>패션일러스트레이션Ⅱ</td><td>3</td></tr>
								<tr><td>전선</td><td>플랫패턴디자인Ⅰ</td><td>3</td><td>전선</td><td>패션이미지메이킹</td><td>3</td></tr>
								<tr><td>교양</td><td>생활예절</td><td>3</td><td>교양</td><td>생활과컴퓨터</td><td>3</td></tr>
								<tr><td>교양</td><td>영화예술의이해</td><td>3</td><td>교양</td><td>사진촬영과감상</td><td>3</td></tr>
								<tr><td rowspan="6">2학년</td><td>전필</td><td>서양복식사</td><td>3</td><td>전필</td><td>한국의상구성</td><td>3</td></tr>
								<tr><td>전선</td><td>패션드레이핑Ⅰ</td><td>3</td><td>전선</td><td>패션머천다이징</td><td>3</td></tr>
								<tr><td>전선</td><td>패션디자인실습</td><td>3</td><td>전선</td><td>패션악세서리디자인</td><td>3</td></tr>
								<tr><td>전선</td><td>컴퓨터패션디자인</td><td>3</td><td>전선</td><td>텍스타일디자인</td><td>3</td></tr>
								<tr><td>일선</td><td>뷰티트렌드</td><td>3</td><td>일선</td><td>복식문화</td><td>3</td></tr>
								<tr><td>교양</td><td>생활과디자인</td><td>3</td><td>일선</td><td>사진과디자인</td><td>3</td></tr>
								<tr><td rowspan="6">3학년</td><td>전필</td><td>패션마케팅</td><td>3</td><td>전필</td><td>테일러링</td><td>3</td></tr>
								<tr><td class="r_txt">전선</td><td class="r_txt">남성복구성실습</td><td class="r_txt">3</td><td>전선</td><td>특수소재의복제작</td><td>3</td></tr>
								<tr><td>전선</td><td>섬유조형실습</td><td>3</td><td>전선</td><td>패션코디네이션</td><td>3</td></tr>
								<tr><td>전선</td><td>패션CAD실습</td><td>3</td><td>전선</td><td>비주얼머천다이징</td><td>3</td></tr>
								<tr><td>일선</td><td>세일즈프로모션전략</td><td>3</td><td>교양</td><td>코디네이트미학</td><td>3</td></tr>
								<tr><td>교양</td><td>광고학</td><td>3</td><td>일선</td><td>사진학개론Ⅰ</td><td>3</td></tr>
								<tr><td rowspan="6">4학년</td><td>전선</td><td>무대의상제작실습</td><td>3</td><td>전선</td><td>패션컬렉션</td><td>3</td></tr>
								<tr><td>전선</td><td>패션스타일링</td><td>3</td><td>전선</td><td>패션포트폴리오</td><td>3</td></tr>
								<tr><td>전선</td><td>패션프로모션기획</td><td>3</td><td>일선</td><td>패션유통론</td><td>3</td></tr>
								<tr><td>전선</td><td>의상사회심리</td><td>3</td><td></td><td></td><td></td></tr>
								<tr><td>교양</td><td>경영학개론</td><td>3</td><td></td><td></td><td></td></tr>
								<tr><td>일선</td><td>패션산업론</td><td>3</td><td></td><td></td><td></td></tr>
								<tr><td rowspan="7">자격증</td><td rowspan="7">전공</td><td>의류기술사</td><td>45</td><td rowspan="7">일선</td><td>컬러리스트 산업기사</td><td>16</td></tr>
								<tr><td>의류기사</td><td>20</td><td>정보처리 산업기사</td><td>16</td></tr>
								<tr><td>섬유디자인 산업기사</td><td>16</td><td>컴퓨터활용능력 1급</td><td>14</td></tr>
								<tr><td>양복산업기사</td><td>16</td><td>유통관리사 2급</td><td>10</td></tr>
								<tr><td>패션디자인산업기사</td><td>16</td><td>컴퓨터활용능력 2급</td><td>6</td></tr>
								<tr><td>한복산업기사</td><td>16</td><td>워드프로세서 1급</td><td>4</td></tr>
								<tr><td>패션머천다이징 산업기사</td><td>16</td><td></td><td></td></tr>

							</tbody>
						</table>
					</div>-->


<div class="ta_overbox"> 
							<table class="ta874_ty10" summary="교과 과정 정보를 학년, 이수구분, 1학기(교과목명, 학점), 이수구분, 2학기(교과목명, 학점) 순서로 보여줍니다.">
							<caption>교과 과정표</caption>
							<colgroup>
								<col style="width:20%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td>패션 디자인<br/>Fashion Design
									</td>
									<td>패션디자인의 이론과 실기를 기초로 국내외 여성복, 남성복, 캐주얼의류에서 특수의복까지 차별화된 감각을 갖춘 창의적인 디자이너를 양성하는 전공 과정이다. 패션디자인의 기초부터 일러스트레이션, 의복제작, 패션역사, 마케팅, 창작디자인 등 고급과정까지 현장실무 경력이 풍부한 교수진의 지도로 실습위주의 수업을 진행한다. </td>
								</tr>
								<tr>
									<td>패션 스타일링<br/>Fashion Styling</td>
									<td>패션아이템을 활용한 브랜드이미지연출 및 패션브랜드의 컨셉을 관리하는 총책임자 역할과 패션트렌드를 종합적으로 예측하여 컨설팅부터 패션무대 및 패션현장을 총괄할 수 있는 능력을 가진 크리에이티브한 기술과 감각을 가진 스타일 전문가 양성을 목표로 한 전공이다.<br/>
									이를 위해 패션디자인 기초에 더하여 컬러코디네이션, 패션스타일링, 패션이미지메이킹 등의 연구를 통해 넓은 의미의 패션연출자 양성을 목표로 한다.</td>
								</tr>
								<tr>
									<td>패션 MD/마케팅<br/>Fashion MD/Marketing<br/>(패션MD, 패션VMD, 패션Buyer)</td>
									<td>패션마케팅 전공은 글로벌 시대에 경쟁력 있는 패션머천다이저 및 비주얼머천다이저를 양성하는 전공 과정이다. 패션사업과 마케팅의 전반적 이해를 토대로 패션상품기획, 패션브랜드런칭, 패션트렌드 분석력 및 머천다이징 능력을 기른다. 또한 패션유통에 대한 이해를 바탕으로 판매촉진과 매장의 효과적 연출 및 운영에 관한 능력을 배양하기 위해 슬무중심의 교육을 받게 된다.  </td>
								</tr>
								<tr>
									<td>패션창업<br/>Fashion Foundation<br/>(소자본 패션창업, 글로벌패션 전자상거래)</td>
									<td>패션창업전공은 G마켓/옥션 및 전자상거래 솔루션 카페24 등 대기업과 산학협력하여 인터넷이나 모바일을 기반으로 한다. 예비 창업자 및 소자본으로 패션 비즈니스 창업을 준비하는 예비 창업자들에게 좋은 기회를 제공해줄 것으로 확신한다. 창업 컨설팅부터 정부지원사업까지 패션사업에 누구나 쉽게 접근할 수 있도록 돕고 또한 패션기업의 온라인 관련 분야에 적합한 인재를 배출하기 위해 심화교육을 제공한다.</td>
								</tr>
							</tbody>
						</table>
					</div>
					<br/>
					<br/>
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
							<tbody>
								<tr><td rowspan="5">1학년</td>
								<td>전필</td><td>패션디자인론</td><td>3</td><td>전필</td><td class="r_txt">의복과색채*</td><td>3</td></tr>
								<tr><td>전필</td><td>패션소재연구</td><td>3</td><td>전선</td><td>플랫패턴디자인 I</td><td>3</td></tr>
								<tr><td>전필</td><td class="r_txt">패션마케팅*</td><td>3</td><td>전선</td><td>패션일러스트레이션 II</td><td>3</td></tr>
								<tr><td>전필</td><td>의복구성 I</td><td>3</td><td>전선</td><td>텍스타일디자인</td><td>3</td></tr>
								<tr><td>전선</td><td>패션일러스트레이션 I</td><td>3</td><td>일선</td><td>패션산업론</td><td>3</td></tr>
								
								<tr><td rowspan="6">2학년</td>
								<td>전필</td><td class="r_txt">서양복식사*</td><td>3</td><td>전필</td><td>한국의상구성</td><td>3</td></tr>
								<tr><td>전선</td><td>컴퓨터패션디자인</td><td>3</td><td>전선</td><td>패션머천다이징</td><td>3</td></tr>
								<tr><td>전선</td><td>플랫패턴디자인II</td><td>3</td><td>전선</td><td>패션악세서리디자인</td><td>3</td></tr>
								<tr><td>전선</td><td>패션드레이핑I</td><td>3</td><td>전선</td><td class="r_txt">남성복구성실습*</td><td>3</td></tr>
								<tr><td>전선</td><td>패션디자인실습I</td><td>3</td><td>전선</td><td class="r_txt">비주얼머천다이징*</td><td>3</td></tr>
								<tr><td>일선</td><td class="r_txt">패션미디어*</td><td>4</td><td>일선</td><td class="r_txt">패션e-비즈니스*</td><td>3</td></tr>
								
								<tr><td rowspan="7">3학년</td>
								<td>전필</td><td>테일러링</td><td>3</td><td>전선</td><td>섬유조형실습</td><td>3</td></tr>
								<tr><td>전선</td><td>패션컬렉션</td><td>3</td><td>전선</td><td class="r_txt">패션상품기획*</td><td>3</td></tr>
								<tr><td>전선</td><td>의상사회심리</td><td>3</td><td>전선</td><td>의복구성 II</td><td>3</td></tr>
								<tr><td>전선</td><td>패션CAD실습</td><td>3</td><td>전선</td><td>패션프로모션기획</td><td>3</td></tr>
								<tr><td>전선</td><td>패션스타일링</td><td>3</td><td>일선</td><td>세일즈프로모션전략 I</td><td>3</td></tr>
								<tr><td>전선</td><td>패션트렌드분석</td><td>3</td><td>일선</td><td>패션유통론</td><td>3</td></tr>
								<tr><td>일선</td><td>패션소비자행동론</td><td>3</td><td></td><td></td><td></td></tr>
								
								<tr><td rowspan="5">4학년</td>
								<td>전선</td><td>창작디자인실습</td><td>3</td><td>전선</td><td>패션포트폴리오</td><td>3</td></tr>
								<tr><td>전선</td><td>패션이미지메이킹</td><td>3</td><td>전선</td><td class="r_txt">패션산업체연수실습*</td><td>3</td></tr>
								<tr><td>전선</td><td>무대의상제작실습</td><td>3</td><td>일선</td><td class="r_txt">패션프레젠테이션*</td><td>3</td></tr>
								<tr><td>전선</td><td>글로벌패션비즈니스</td><td>3</td><td>전선</td><td class="r_txt">어패럴MD실습 I*</td><td>3</td></tr>
								<tr><td>전선</td><td>패션기업경영론</td><td>3</td><td>일선</td><td class="r_txt">패션마켓과리서치*</td><td>3</td></tr>
								
								<tr><td rowspan="6">자격증</td>
								<td rowspan="6">전필</td><td>의류기술사</td><td>45</td><td rowspan="6">일선</td><td>컬러리스트산업기사</td><td>16</td></tr>
								<tr><td>의류기사</td><td>20</td><td>정보처리산업기사</td><td>16</td></tr>
								<tr><td>섬유디자인산업기사</td><td>16</td><td>유통관리사2급</td><td>10</td></tr>
								<tr><td>한복산업기사</td><td>16</td><td>컴퓨터활용능력 1급</td><td>14</td></tr>
								<tr><td>패션디자인산업기사</td><td>16</td><td>컴퓨터활용능력 2급</td><td>6</td></tr>
								<tr><td>패션머천다이징산업기사</td><td>16</td><td>워드프로세서</td><td>4</td></tr>								
							</tbody>
							<tfoot>
									<tr>
										<td colspan="2">총계</td>
										<td>전공필수(과목수)</td>
										<td>8</td>
										<td></td>
										<td>전공선택(과목수)</td>
										<td>29</td>
									</tr>
							</tfoot>
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
									<dt>	드로잉 I</dt>
									<dd>	조형예술의 근본이 되는 드로잉을 통하여 대상물에 대한 관찰력과 표현력 및 공간과 사물과의 관계를 파악하는 능력을 기르며, 대상을 관찰·인식·묘사하는 과정을 연계시켜 드로잉의 개념을 이해한다.</dd>
									<dt>디스플레이</dt>
									<dd>	효율적인 구매를 위한 상품의 전시와 진열에 대하여 학습하고 인간과 디스플레이 대상의 주위 환경과의 유기적인 질서, 조화를 도출할 수 있는 이론과 실제를 탐구한다.</dd>
									<dt>디자인론</dt>
									<dd>	효율적인 구매를 위한 상품의 전시와 진열에 대하여 학습하고 인간과 디스플레이 대상의 주위 환경과의 유기적인 질서, 조화를 도출할 수 있는 이론과 실제를 탐구한다.</dd>
									<dt>무대의상 제작실습</dt>
									<dd>	무대의상 디자인의 의미를 시대적·지역적으로 고찰하며 디자인의 실행과정을 실제적인 의상디자인의 방법과 제작방법을 학습하여 무대의상디자이너의 기초능력을 배양한다.</dd>
									<dt>미학개론</dt>
									<dd>	미학의 기본 개념들과 주요이론을 각 부문별로 고찰하고 미와 미학적 사고의 여러 흐름을 연대적으로 살펴봄으로써 문화와 예술을 포함한 여러 분야에서 현대미학이 해결해야 할 과제와 문제점을 진단해 본다.</dd>
									<dt>사진촬영과 감상</dt>
									<dd>	사진 전반에 걸친 기초이론과 실제를 배우고 기존 작품의 해석을 통해 사진에 대한 이해를 돕는다. 아울러 사진작품을 직접 제작해봄으로써 사진을 통해 제작자의 이상과 현실을 새로운 시각으로 바라보는 기회를 갖는다.</dd>
									<dt>생활과 컴퓨터</dt>
									<dd>	실생활에서 다양하게 활용되는 컴퓨터를 올바르게 이해하고 생활 속에서 컴퓨터를 효율적으로 이용하는 다양한 방법과 활용법을 학습한다.</dd>
									<dt>서양복식사</dt>
									<dd>	복식의 기원에서 현대에 이르기까지 서양복식의 변천사를 각 시대의 문화, 역사적 배경, 착용된 의복, 장식품 별로 살펴본다. 시대적인 배경과 복식과의 관련성과 영향등에 대하여 연구하고 새로운 디자인 발상의 모티브로 디자인에 적극 활용토록 한다.</dd>
									<dt>실용영어회화</dt>
									<dd>	영어의 발음 및 어휘, 표현등의 기초적인 문법에서 독해에 이르기까지 영어 전반을 학습하고 실생활에서 활용 할 수 있는 영어 대화 및 문형연습을 통하여 청취와 회화를 동시에 학습한다.</dd>
									<dt>한국의상구성 I</dt>
									<dd>	우리 고유 복식인 한복의 형태미, 내용미를 살펴보고 형태와 색채에 있어서 시대적 감각을 지닌 한복을 구성할 수 있도록 실습한다.</dd>
									<dt>의복과 색채</dt>
									<dd>	패션의 요소 중 하나인 색채와 의복과의 관계를 고찰하여 색채가 패션에 미치는 영향을 분석하고, 이를 바탕으로 새로운 의상문화를 개척할 수 있는 창조적인 능력을 키운다.</dd>
									<dt>의복과 현대사회</dt>
									<dd>	인간문화의 대표적인 조형물로서의 의복에 대한 전반적인 개론을 학습하고, 현대사회와 의복과의 관계를 재조명하며, 이를 바탕으로 현대사회에 적합한 복식활동을 학습한다.</dd>
									<dt>의복구성 I</dt>
									<dd>	평면재단에 의해 만들어진 의복이 입체인 인체에 착용되는 과정을 이해하고, 의도하는 디자인을 정확히 표현하기 위한 패턴제작의 올바른 제도법과 봉제방법을 터득하여 좀 더 합리적인 봉제능력을 배양한다.</dd>
									<dt>중국문화의 이해</dt>
									<dd>	중국의 역사, 정치, 풍습, 언어 등을 중심적으로 살펴봄으로써 중국문화 전반을 이해한다.</dd>
									<dt>직물조직학</dt>
									<dd>	직물 3원조직을 기초로 변화조직 등 직물의 조직구조를 이해하고 직물디자인 이론을 배우며, 직물의 제작과정과 디자인방법을 배워 의복 제작의 기초가 되는 소재의 개발과 새로운 디자인 개발에 응용할 수 있도록 한다.</dd>
									<dt>컴퓨터 패션 디자인</dt>
									<dd>	패션 트랜드 분석과 상품기획과정에 Illustrator, Photoshop 기법 등 컴퓨터를 접목시켜 정보화 시대에 필요한 Fashion Portfolio를 CAD로 제작한다.</dd>
									<dt>테일러링</dt>
									<dd>	의복제작의 최고기술인 재킷 제작 과정으로, 패턴제작 및 디자인응용과 창작을 병행하여 고급 의상디자인을 의복으로 제작할 수 있는 실력을 갖출 수 있도록 학습한다.</dd>
									<dt>텍스타일 디자인</dt>
									<dd>	섬유시장 조사 및 트랜드분석을 토대로 패션분야의 직물디자인 현황을 파악하고 아이디어와 기법의 훈련을 통해 다양한 텍스타일 디자인 창출을 실습한다.</dd>
									<dt>패션 드레이핑 I</dt>
									<dd>	패션디자인의 아이디어를 3차원적인 방법을 통해 신속히 재단할 수 있는 이론을 학습하고 실습함으로써 다양한 의상 디자인을 옷으로 제작할 수 있는 기초적인 능력을 배양한다.</dd>
									<dt>패션 디자인론</dt>
									<dd>	패션디자인 요소와 원리를 학습하여 미적 표현감각을 패션에 적용할 수 있는 능력을 키우고 학습한 이론을 실제 패션디자인 업무에 활용할 수 있는 능력을 함양한다.</dd>
									<dt>패션 디자인 실습 I</dt>
									<dd>	트랜드에 적합한 감각적인 패션디자인 창출을 위해 이미지를 창조적으로 시각화하여 디자인 요소를 종합해 표현하는 능력을 키우며, 나아가 패션디자인 프리젠테이션의 기초를 습득한다.</dd>
									<dt>패션 마케팅</dt>
									<dd>	의복의 상품화에 따른 복식산업의 기본개념 및 환경적인 요인을 파악하고, 유행의 속성을 지닌 패션상품과 관련하여 상품과 소비자를 이해하며, 패션 상품의 기획, 생산, 판매 등의 과정을 학습한다.</dd>
									<dt>패션 머천다이징</dt>
									<dd>	패션머천다이징의 개념과 필요성을 이해하고, 실제 패션 머천다이징 업무가 진행되는 과정에 따라 단계별로 구체적인 이론과 사례의 연구를 통해 산업현장지향적인 감각 배양을 목적으로 한다.</dd>
									<dt>패션 소재 연구</dt>
									<dd>	패션소재로 사용되는 다양한 섬유의 종류와 특징, 용도에 대하여 학습함으로써 패션소재기획 시 소재의 선택, 사용 및 관리를 보다 체계적이고 합리적으로 기획하고 사용할 수 있는 능력을 키운다.</dd>
									<dt>패션 스타일링</dt>
									<dd>	스타일링의 구성요소인 패션 아이템의 활용으로 패션스타일링의 조화로운 기법을 익힘으로서 패션스타일리스트의 감각과 응용력을 배양한다.</dd>
									<dt>패션 이미지 메이킹</dt>
									<dd>	외모에 대한 이해 및 자신의 감성에 대한 선행 학습과 의상 착용의 미학적 방법 등의 연구를 중심으로 패션 이미지 메이킹 부문의 종사자로서의 전문가 자격을 갖추는 데 필요한 지식을 학습하고 자질을 함양한다.</dd>
									<dt>패션 일러스트레이션 I</dt>
									<dd>	창의적인 디자인 전개를 위한 표현도구로 기초적인 인체의 포즈 및 디자인 컨셉에 따른 의상 착장법과 도식화법을 실습한다. 다양한 접근에 따른 디자인을 연구함으로써 디자인 개발 능력과 디자인 전개 방법을 키우는 것을 수업의 목표로 한다.</dd>
									<dt>패션 일러스트레이션 II</dt>
									<dd>	디자인 표현 방법으로서, 각각 재료의 특성별로 표현법을 익혀서 다양한 소재 및 디자인을 자유자재로 표현할 수 있도록 확장된 패션일러스트의 표현능력을 배양한다.</dd>
									<dt>패션 트렌드 분석</dt>
									<dd>	패션 트렌드를 종합적으로 분석하고 미래 패션 예측능력을 배양하여 패션 트렌드 변화에 반영되는 요소들을 이해하고, 이미지 메이킹 및 상품 지식, 브랜드 이미지를 소비자에게 전달할 수 있도록 학습한다.</dd>
									<dt>패션 포트폴리오</dt>
									<dd>	창출된 작품 및 디자인 프로젝트 결과를 자료로 정리하여 시각화하는 기법을 연구하며, 수요자에게 결과물을 효과적으로 제시하고 전달할 수 있는 포트폴리오의 제작방법과 프리젠테이션 기법을 익힌다.</dd>
									<dt>플랫 패턴 디자인 I</dt>
									<dd>	인체의 구조를 이해하고 기초적인 패턴을 제작할 수 있도록 의복의 기본 아이템 에 대한 원형을 실습한다.</dd>
									<dt>한국복식사</dt>
									<dd>	한국복식의 변천을 이해하고 복식의 일반적인 특징과 의복의 종류를 연구, 고찰함으로써 한국복식 전반에 걸친 사항과 복식과 시대와의 상관성 및 영향등에 대하여 학습한다.</dd>	
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