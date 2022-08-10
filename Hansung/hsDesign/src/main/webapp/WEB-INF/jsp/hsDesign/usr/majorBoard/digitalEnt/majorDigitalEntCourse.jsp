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
		            <jsp:param name="dept2" value="디지털아트학(게임)"/>
		            <jsp:param name="dept3" value="교과과정"/>
	           	</jsp:include>
				<div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntCourse.do?menuType=01'/>">교과 과정</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntCourse.do?menuType=02'/>">교과목 개요</a></li>
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
										<td>30</td>
									</tr>
								</tfoot>
								<tbody>
									<!-- 1학년 - start -->
									<tr>
										<td rowspan="8">1학년</td>
										<td>교양</td>
										<td class="ta_left">생활과디자인</td>
										<td>3</td>
										<td>교양</td>
										<td class="ta_left">생활예절</td>
										<td>3</td>
									</tr>
									<tr>
										<td>교양</td>
										<td class="ta_left">사진촬영과감상</td>
										<td>3</td>
										<td>교양</td>
										<td class="ta_left">영화예술의 이해</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전필</td>
										<td class="ta_left r_txt">디지털미디어개론*</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">디지털미디어영상스튜디오 I</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">디지털조형</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">디지털일러스트레이션 I</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">디지털스토리텔링</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">멀티미디어저작도구 I</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">게임아트</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">그래픽사용자환경디자인</td>
										<td>3</td>
									</tr>
									
									<tr>
										<td>일선</td>
										<td class="ta_left r_txt">게임분석*</td>
										<td>3</td>
										<td>일선</td>
										<td class="ta_left r_txt">게임학개론*</td>
										<td>3</td>
									</tr>
										<tr>
										<td>비학점</td>
										<td class="ta_left">e스포츠개론</td>
										<td>-</td>
										<td>비학점</td>
										<td class="ta_left">e스포츠 트레이닝</td>
										<td>-</td>
									</tr>
									<!-- 1학년 - end -->

									<!-- 2학년 - start -->
									<tr>
										<td rowspan="8">2학년</td>
										<td>전필</td>
										<td class="ta_left r_txt">제작실습 I*</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">3D캐릭터애니메이션</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">인터페이스디자인</td>
										<td>3</td>
										<td>전필</td>
										<td class="ta_left r_txt">디지털콘텐츠기획*</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">기초디자인</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">디지털미디어영상스튜디오 II</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">영상디자인스튜디오 I</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">디지털미디어프로덕션스튜디오 I</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전필</td>
										<td class="ta_left r_txt">기초디지털애니메이션*</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">디지털콘텐츠마케팅</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left r_txt">프로그래밍언어실습*</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">디지털미디어예술의 발달사</td>
										<td>3</td>
									</tr>
									
									<tr>
										<td>교양</td>
										<td class="ta_left r_txt">생활스포츠*</td>
										<td>3</td>
										<td>일선</td>
										<td class="ta_left r_txt">게임커뮤니케이션방법론*</td>
										<td>3</td>
									</tr>
									<tr>
										<td>비학점</td>
										<td class="ta_left">e스포츠 행정과 법</td>
										<td>-</td>
										<td>비학점</td>
										<td class="ta_left">e스포츠엔터테인먼트 산업론</td>
										<td>-</td>
									</tr>
									<!-- 2학년 - end -->
									
									<!-- 3학년 - start -->
									<tr>
										<td rowspan="10">3학년</td>
										<td>교양</td>
										<td class="ta_left r_txt">의사소통과대인관계*</td>
										<td>3</td>
										<td>일선</td>
										<td class="ta_left r_txt">게임서비스운영*</td>
										<td>3</td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left">사진과디자인</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">컴퓨터애니메이션</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">디지털애니메이션 I</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">디지털인터랙티브스토리텔링</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">멀티미디어디자인 I</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">멀티미디어콘텐츠개발</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전필</td>
										<td class="ta_left">제작실습 II</td>
										<td>3</td>
										<td>전필</td>
										<td class="ta_left r_txt">실험영상*</td>
										<td>3</td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left">색채디자인실습</td>
										<td>3</td>
										<td>일선</td>
										<td class="ta_left">웹디자인</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전필</td>
										<td class="ta_left">소프트웨어공학</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">디지털게임프로그래밍</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">인터랙션디자인</td>
										<td>3</td>
										<td>일선</td>
										<td class="ta_left">프리젠테이션</td>
										<td>3</td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left">일러스트레이션 I</td>
										<td>3</td>
										<td>일선</td>
										<td class="ta_left">표현기법</td>
										<td>3</td>
									</tr>
									<tr>
										<td>비학점</td>
										<td class="ta_left">e스포츠 미디어기획과 연출</td>
										<td>-</td>
										<td>비학점</td>
										<td class="ta_left">게임커뮤니케이션방법론</td>
										<td>-</td>
									</tr>
									
									<!-- 3학년 - end -->
									
									<!-- 4학년 - start -->
									<tr>
										<td rowspan="8">4학년</td>

										<td>교양</td>
										<td class="ta_left r_txt">경영학개론*</td>
										<td>3</td>
										<td>교양</td>
										<td class="ta_left r_txt">의복과현대사회*</td>
										<td>3</td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left r_txt">사진학개론 I*</td>
										<td>3</td>
										<td>교양</td>
										<td class="ta_left">사진촬영과 감상</td>
										<td>3</td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left">홈페이지설계</td>
										<td>3</td>
										<td>일선</td>
										<td class="ta_left">일러스트레이션 II</td>
										<td>3</td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left">디지털애니메이션 II</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">포트폴리오</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">디지털미디어프로덕션스튜디오II</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left">인터랙티브인스톨레이션스튜디오</td>
										<td>3</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left r_txt">인터넷프로그래밍*</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left r_txt">오디오포스트프로덕션*</td>
										<td>3</td>
									</tr>
								
									
									<tr>
										<td>전선</td>
										<td class="ta_left r_txt">디지털콘텐츠제작을위한특수효과 I*</td>
										<td>3</td>
										<td>전선</td>
										<td class="ta_left r_txt">디지털콘텐츠제작을위한특수효과 II*</td>
										<td>3</td>
									</tr>
									<tr>
										<td>비학점</td>
										<td class="ta_left">e스포츠 대획기획과 운영</td>
										<td>-</td>
										<td>비학점</td>
										<td class="ta_left">게임서비스 운영</td>
										<td>-</td>
									</tr>
									<!-- 4학년 - end -->

									<!-- 자격증 - start -->
									<tr>
										<td rowspan="8">자격증</td>
										<td rowspan="8">전필</td>
										<td class="ta_left">게임그래픽전문가</td>
										<td>20</td>
										<td rowspan="8">일선</td>
										<td class="ta_left">게임프로그래밍전문가</td>
										<td>20</td>
									</tr>
									<tr>
										<td class="ta_left">게임기획전문가</td>
										<td>20</td>
										<td class="ta_left">정보처리산업기사</td>
										<td>16</td>
									</tr>
									<tr>
										<td class="ta_left">멀티미디어콘텐츠제작전문가</td>
										<td>18</td>
										<td class="ta_left">컴퓨터활용능력1급</td>
										<td>14</td>
									</tr>
									<tr>
										<td class="ta_left">GTQ(그래픽기술)1급</td>
										<td>5</td>
										<td class="ta_left">컴퓨터활용능력2급</td>
										<td>6</td>
									</tr>
									<tr>
										<td class="ta_left">GTQ(그래픽기술)2급</td>
										<td>3</td>
										<td class="ta_left">유통관리사2급</td>
										<td>10</td>
									</tr>
									<tr>
										<td class="ta_left"></td>
										<td></td>
										<td class="ta_left">워드프로세서</td>
										<td>4</td>
									</tr>
									<tr>
										<td class="ta_left"></td>
										<td></td>
										<td class="ta_left">시각디자인산업기사</td>
										<td>16</td>
									</tr>
									<tr>
										<td class="ta_left"></td>
										<td></td>
										<td class="ta_left">컬러리스트산업기사</td>
										<td>16</td>
									</tr>
									<!-- 자격증 - end -->
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
									<dt>	디자인사	</dt>
									<dd>	전반적인 디자인의 역사적 발달과 개별 디자인 양식의 조형적·시대적 특징을 이해하고, 개별 디자인 분야와의 연관성을 연구함으로써 미의식을 고취시키고, 이로써 급변하는 시대에 대처할 수 있도록 현장성과 미래성을 갖춘 디자이너를 양성한다.	</dd>
									<dt>	평면조형	</dt>
									<dd>	2차원 예술의 기본 조형원리와 그 특성인 공간의 요리, 물성의 이해, 색의 조화 를 기본적으로 추구한다. 구성원리와 원근법, 반복과 대비 등 전통의 미학과 현 대의 평면조형원리를 재정립하여 평면예술의 개념을 환기시키고, 지적이며 현대 적인 조형 이미지를 창출한다.	</dd>
									<dt>	타이포 그래피	</dt>
									<dd>	이 수업의 목적은 타이포그래피란 무엇이며, 타이포그래피에 대한 전통적 규범과 관례 그리고 지침을 충분히 이해하는데 있다. 서체의 종류, 글자가 주는 Image, 서체의 크기, 어간, 행간, 편집디자인의 기본 요소인 Typography요소를 통해 작품화와 편집의 기본요소를 학습한다. 실무를 중심으로 현장감 있는 내용을 기반으로 창조적인 작품을 기획하고 있는 학생을 위해 고안되어 졌다.	</dd>
									<dt>	디지털미디어영상스튜디오I	</dt>
									<dd>	프리미어(Premire)를 이용하여 뮤직 비디오·비디오 블레이크·다큐멘터리·교육 매체 등과 같은 텔레비전 CF 및 광고나 영화 외의 다양한 영역에서 필요한 동영상 이미지의 기획과 촬영·편집에 이르는 기초적인 동영상 표현 기법을 익히고, 여러 가지 CD 타이틀, 홈페이지 디자인, 인터넷 정보검색 등을 감상하고 멀티미디어 디자인의 원리를 이론적으로 이해하며, 관련 소프트웨어를 효과적으로 활용하는 능력을 기른다.	</dd>
									<dt>	시각디자인론	</dt>
									<dd>	디자인 개념과 시각 디자인의 다양한 적용 그리고 관련 분야와의 상호 관계를 일별한다. 시각 디자인 이해에 필요한 조형 이론을 소개함으로써 디자인의 실재적 효용성에 대한 학습 및 디자인 전개와 평가를 위한 기초를 습득한다.	</dd>
									<dt>	시각디자인 실습	</dt>
									<dd>	특정한 시각전달 매체를 설정하고 이에 대한 문제해결을 위해, 창의적 디자인 발상과 합목적적인 전개와 표현에 이르는 종합적인 과정을 경험함으로써 전문적인 디자인 능력을 배양한다.	</dd>
									<dt>	컴퓨터 그래픽 I	</dt>
									<dd>	일러스트레이션을 중심으로 컴퓨터 응용 그래픽 이미지 제작기법을 이해하며 관련 그래픽 활용 예를 비교 분석 연구한다. 또한 벡터이미지의 장단점을 중심으로 실무적 실습을 진행한다.	</dd>
									<dt>	컴퓨터 그래픽 II(인가예정)	</dt>
									<dd>	실무에서 가장 많이 쓰이는 Photoshop의 색상ㆍ입체ㆍFilter 효과를 이용하여 CD재킷이나 Poster 등을 편집할 수 있도록 실습한다.	</dd>
									<dt>	색채학	</dt>
									<dd>	색상·명도·채도의 정확한 정의와 디자인의 가시적 체계를 이해하고 기능적인 색의 개념과 색의 표시법을 익힘으로써 색의 구조와 종류를 체계적으로 이해한다.	</dd>
									<dt>	영상디자인 스튜디오	</dt>
									<dd>	에프터이팩트(After Effect)를 기본으로 조명, 녹음, 믹싱, 편집 등 영상물 제작에 필요한 실질적인 테크닉을 연습한다. 특수영상을 만드는 기법과 다양한 플로그인을 실습한다. 또한 기본적인 기술을 바탕으로 전달성·창의성을 갖춘 영상 이미지를 연출할 수 있도록 학습한다.	</dd>
									<dt>	영상론(인가예정)	</dt>
									<dd>	영상물의 발전과 전개를 이해하고 실질적인 영상 디자인을 기획·제작하는데 요구되는 다양한 미학적 근거와 이론적 체계를 학습한다.	</dd>
									<dt>	영상정보처리(인가예정)	</dt>
									<dd>	영상시스템의 모델링, 샘플링, 양자화, 영상 개선과 복구, 2차원 데이터의 필터링과 변환 이론 등의 영상 처리 기법을 소개하고, 영상정보를 자동으로 처리하기 위한 영상분할 기법과 영상인식 기법을 다룬다.	</dd>
									<dt>	디지털 디자인(인가예정)	</dt>
									<dd>	컴퓨터 그래픽 활용을 위한 제반 지식과 기본 기법을 습득하여 디자인 프로세스에서의 적응력을 기르며, 최종 결과물에 이르는 디지털 디자인 과정을 학습한다.	</dd>
									<dt>	게임그래픽기초(인가예정)	</dt>
									<dd>	게임 그래픽의 이론과 실제 개발 사례를 분석함으로써 해당 분야에 대한 전반적인 흐름을 이해할 수 있도록 한다. 이를 위해 본 교과목은 게임 그래픽의 세부 작업 영역 및 게임의 장르별 그래픽 특징을 이해하는 한편, 기초적인 실습을 통하여 게임 그래픽 등에 대해서 기초 소양을 습득한다.	</dd>
									<dt>	게임아트(인가예정)	</dt>
									<dd>	게임의 정의와 역사, 게임의 종류와 장르별 분류, 게임 산업의 전망과 시장성, 게임 하드웨어의 구성, 게임 제작과정, 게임과 인간의 상호작용 및 게임과 현대사회, 게임 기획, 게임 프로그래밍 이론, 게임 그래픽 이론, 게임과 디지털 음악 등을 학습한다.	</dd>
									<dt>	제작실습I	</dt>
									<dd>	기본적인 영상제작의 이론과 제작 방법을 토대로 창의적인 디지털 영상 제작 능력을 기르고, 영상제작의 새로운 가능성을 시도해보며, 단순한 편집도구의 사용 능력만이 아니라 새로운 창의력, 디지털 영상의 기술적 의미 등 단순한 업무처리 능력 외에 전문적인 지식 및 안목을 습득한다.	</dd>
									<dt>	인터페이스 디자인	</dt>
									<dd>	멀티미디어나 컴퓨터그래픽의 기초 과목으로써 인터페이스 디자인의 필요성을 인식하고, 기초개념의 이해와 효과적인 멀티미디어 분석을 통해 신기술 개발의 응용력을 높인다.	</dd>
									<dt>	인터랙션 디자인	</dt>
									<dd>	정보의 창출, 저장, 송출 과정에서 쌍방향 대화형식에 의한 교류가 원활하게 이루어질 수 있도록 제반 사항을 익히고 이에 따른 디자인 프로세스를 학습한다.	</dd>
									<dt>	컴퓨터 애니메이션	</dt>
									<dd>	2D 및 3D 애니메이션의 기초개념과 제작과정, 기법 등을 학습하고 3D MAX와 같은 3D 애니메이션 소프트웨어를 사용한 기본적인 애니메이션 제작을 실습한다.	</dd>
									<dt>	디지털 애니메이션	</dt>
									<dd>	애니메이션에 대한 이론적 이해를 기반으로 동작연출, 컴퓨터 프로그램의 적용 등 디지털 애니메이션 제작에 필요한 전반적인 작업과정을 경험하며 애니메이션 전체를 연출해내는 능력을 배양한다.	</dd>
									<dt>	기초디지털애니메이션	</dt>
									<dd>	애니메이션 작품제작에 앞서 기본적으로 알아야 할 애니메이션 기본이론과 표현기법을 실제 제작과정을 통해 학습한다.	</dd>
									<dt>	사진과디자인	</dt>
									<dd>	정보화 시대의 첨단 기술이 어떻게 예술분야에 적용될 수 있는지 그리고 어떻게 하면 그 기술을 더욱 효율적으로 사용할 것인가를 학습한다. 또한 새로운 매체를 처음 접하는 학생들을 감안하여 모든 교육을 디지털 이미지에 국한하지 않고 본질적인 이해와 응용을 위해 컴퓨터의 구조와 작동 원리, 인터넷, 멀티미디어를 포함한 폭넓은 분야를 다룬다.	</dd>
									<dt>	디자인론	</dt>
									<dd>	근대 디자인의 형성기에 나타난 현상·사조 등의 이론적 배경을 파악한다. 특히 현대 디자인 운동을 계기로 여러 분야에서 일고 있는 포스트모더니즘 현상과 여러 커뮤니케이션 분야에서 발전하는 디자인의 현상들을 점검하고, 디자인의 시대상황을 예측하는 능력을 기른다.	</dd>
									<dt>	인터넷 프로그래밍	</dt>
									<dd>	HTML, Dynamic HTML, JavaScript등을 사용하여 인터넷 환경에서 필요한 각종 동적인 웹 응용 프로그램을 개발할 수 있는 기본적인 프로그래밍 기법과 응용방법을 실습하여 웹브라우저에서 실행되는 프로그램을 작성할 수 있도록 한다.	</dd>
									<dt>	홈페이지 설계	</dt>
									<dd>	홈페이지 저작툴인 드림위버를 이용하여 홈페이지를 만들 수 있는 기본 구조를 만든다.	
										월드와이드웹과 HTML의 정의 및 기본 구조를 이해하며, 실기를 중심으로 다양한 형태의 홈페이지를 설계해 본다.	</dd>
									<dt>	운영체제(인가예정)	</dt>
									<dd>	초기의 시스템부터 최근의 다중 프로그램 시스템의 발전 과정, 운영체제의 구성 요소와 조직 형태, 스케줄링, 메모리관리, 파일 시스템 입문과 접근법, 할당 방법 등을 숙지하여 컴퓨터를 이해하는 능력을 갖도록 학습한다. 또한 운영체제에서 사용하는 보안 메커니즘에 대해 학습함으로써 시스템의 안전성 확보 방안에 대해 숙지한다.	</dd>
									<dt>	멀티미디어 저작도구	</dt>
									<dd>	멀티미디어 저작프로그램을 학습하고 CD-title 구성을 위한 기획 및 스토리보드 작성방법 등을 배운다. 저작도구의 사용방법과 스크립트 언어를 통한 인터랙티브 콘텐츠 생성방법을 습득하여 CD타이트 및, 홍보물 등의 CD-title 제작에 필요한 이론과 실무를 익힌다.	</dd>
									<dt>	2D게임그래픽(인가예정)	</dt>
									<dd>	2D 기반의 게임그래픽 사례를 분석하고 각종 저작 도구의 개요, 사용법, 제작 기법 및 2D 게임배경그래픽 배경 구분과 게임 장르에 따른 배경 선정, 게임배경 제작을 위한 기초 설계와  모델링 기초, 배경 제작을 위한 라이트닝 기초 및 게임배경의 기타 요소 등의 내용을 다룰 수 있도록 실제 실습을 병행해 학습한다.	</dd>
									<dt>	프로그래밍 언어실습	</dt>
									<dd>	프로그래밍의 기본 문법과 컴퓨터 직접 조작할 수 있는 기본 프로그램능력을 기르고, 이론과 실습을 통하여 윈도우즈 환경에서 프로그램을 작성하고 실무에 적용할 수 있는 능력을 배양한다. 또한 모바일을 제어 할 수 있는 기본 프로그램도 함께 익힌다.	</dd>
									<dt>	미학개론(인가예정)	</dt>
									<dd>	미와 미학적 사고의 여러 흐름을 연대적으로 살펴보고 미학의 기본 개념들과 주요이론을 각 부문별로 고찰하며, 현대미학이 해결해야 할 과제와 문제점을 진단해 본다.	</dd>
									<dt>	생활과 디자인	</dt>
									<dd>	작은 일상용품으로부터 거대한 규모의 건축물에 이르기까지 우리의 환경을 구축하고 있는 디자인의 현황과 그 의미를 개괄적으로 살펴보고, 디자인의 올바른 개념과 심미성과 기능성의 다양한 가치 및 디자인의 역할을 학습한다.	</dd>
									<dt>	디지털일러스트레이션	</dt>
									<dd>	일러스트레이션의 개념과 기능 그리고 역할을 학습하고, 기본드로잉을 전제로 인물, 동물, 정물, 사물, 풍경 등을 메시지에 맞도록 시각적으로 묘사하고 표현하는 일러스트레이션의 테크닉과 재료 선택의 다양성을 익힌다. 또한 재료 매체별 표현기법을 통하여 대상 묘사력과 평면공간의 지배력을 길러 일러스트레이터의 기초적 감각을 연마하도록 학습한다.	</dd>
									<dt>	편집디자인 실습	</dt>
									<dd>	시각적 질서를 통해 가장 효과적인 커뮤니케이션이 이루어져야 하므로 편집디자인의 중추적인 요소인 레이아웃과 그리드 시스템의 활용방법에 중점을 두고 인쇄체를 실습한다.	</dd>
									<dt>	3D모델링과 애니메이션	</dt>
									<dd>	3D 맥스(Max), 3D 마야(Maya) 등의 3D 그래픽 프로그램에 대해 학습한다. 2D 그래픽에 대한 전반적인 이해력을 바탕으로 툴의 실질적인 사용법을 습득하고 모델링을 통해 실무적 능력을 기른다. 이를 통해 실재를 가장 가깝게 재현할 수 있는 기술인 3D 그래픽을 습득하여 독창적인 디자인 능력을 보여주는 창작의 도구로 자유롭게 활용할 수 있도록 한다.	</dd>


								</dl>
							</dd>
						</dl>
						
					</c:if>
				</div>
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