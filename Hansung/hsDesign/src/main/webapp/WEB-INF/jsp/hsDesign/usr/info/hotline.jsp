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
<form id="frm" name="frm">
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
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="학교안내"/>
		            <jsp:param name="dept2" value="조직 및 연락처"/>
	           	</jsp:include>
	           	
	           	<div class="ta_overbox">
					<table class="ta874_ty02" summary="조직 및 연락처를 부서명, 업무 및 담당자, 연락처 순서로 보여줍니다.">
						<caption>조직 및 연락처</caption>
						<colgroup>
							<col style="width:237px;" />
							<col style="width:237px;" />
							<col style="width:200px;" />
							<col style="width:200px;" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">부서명</th>
								<th scope="col" colspan="2">업무 및 담당자</th>
								<th scope="col">연락처</th>
							</tr>
						</thead>

						<tbody>
							<tr style="background-color: #ad7b1f1a;"><td class="ta_left" >교학본부	</td><td class="ta_left">디자인아트교육원 총괄</td><td class="ta_left">원장 안광준	</td><td class="ta_left">02-760-5781	</td></tr>
							<tr style="background-color: #ad7b1f1a;"><td class="ta_left">교학본부	</td><td class="ta_left">업무총괄</td><td class="ta_left">팀장 조중집	</td><td class="ta_left">02-760-5781	</td></tr>
							<tr><td rowspan="4" class="ta_left">입학홍보실(학송관 208호)</td><td class="ta_left">입학 홍보 총괄	</td><td class="ta_left">팀원 정연일	</td><td class="ta_left">02-760-5535	</td></tr>
							<tr><td class="ta_left">신입생 등록	</td><td class="ta_left">팀원 강은창	</td><td class="ta_left">02-760-5537	</td></tr>
							<tr><td class="ta_left">입학 홍보·기획	</td><td class="ta_left">팀원 손현민	</td><td class="ta_left">02-760-5534	</td></tr>
							<tr><td class="ta_left">온라인홍보 및 입학상담</td><td class="ta_left">팀원 성희애	</td><td class="ta_left">02-760-5788	</td></tr>
							<tr><td rowspan="6" class="ta_left">교학팀(학송관 208호)<td class="ta_left">등록 및 장학</td><td class="ta_left">팀원 김연진	</td><td class="ta_left">02-760-5785	</td></tr>
 							<!--200420추가 -->
							<!-- <tr><td rowspan="2" class="ta_left">평가, 성적, 학위	</td><td class="ta_left">팀원 이명근	</td><td class="ta_left">02-760-5786	</td></tr> -->
							<!-- <tr><td class="ta_left">팀원 유하영	</td><td class="ta_left">02-760-4457	</td></tr> -->
							<tr><td class="ta_left">평가, 성적, 학위	</td><td class="ta_left">팀원 유하영	</td><td class="ta_left">02-760-4457	</td></tr>
<!-- 							<tr><td class="ta_left">평가, 학사	</td><td class="ta_left">팀원 유하영	</td><td class="ta_left">02-760-4457	</td></tr> -->
							<!-- //200420추가 -->
							<tr><td class="ta_left">행사, 기자재, 비학위 </td><td class="ta_left">팀원 성수빈	</td><td class="ta_left">02-760-5783	</td></tr>
							<tr><td class="ta_left">평가, 수업, 실헙실습비 </td><td class="ta_left">팀원 김은주	</td><td class="ta_left">02-760-5782	</td></tr>
							<tr><td class="ta_left">증명서, 학적변동, 기숙사	</td><td class="ta_left">팀원 김민아	</td><td class="ta_left">02-760-5782	</td></tr>
							<tr><td class="ta_left">강의실 기자재</td><td class="ta_left"> - </td><td class="ta_left"> - </td></tr>
							<tr><td class="ta_left">기숙사</td><td class="ta_left"> - </td><td class="ta_left"> - </td></tr>

							<tr style="background-color: #ad7b1f1a;"><td class="ta_left">교학본부<td class="ta_left">교수 및 학생지원 총괄	</td><td class="ta_left">교수부장 박보석	</td><td class="ta_left">02-760-5509	</td></tr>
							<tr><td rowspan="2" class="ta_left">실내디자인학(학송관 201호)<td class="ta_left">전공총괄 / 상담	</td><td class="ta_left">주임교수 장월상	</td><td class="ta_left">02-760-5500</td></tr>
							<tr><td class="ta_left">전공교육 / 상담	</td><td class="ta_left">교수 임은지	</td><td class="ta_left">02-760-5502	</td></tr>
							<tr><td rowspan="2" class="ta_left">시각디자인학(학송관 202호)<td class="ta_left">전공총괄 / 상담	</td><td class="ta_left">주임교수 박동주	</td><td class="ta_left">02-760-5503	</td></tr>
							<tr><td class="ta_left">전공교육 / 상담	</td><td class="ta_left">교수 한승민	</td><td class="ta_left">02-760-5510	</td></tr>
							<tr><td rowspan="2" class="ta_left">디지털아트학(학송관 210호)<td class="ta_left">전공총괄 / 상담	</td><td class="ta_left">주임교수 박동일	</td><td class="ta_left">02-760-5503	</td></tr>
							<tr><td class="ta_left">전공교육 / 상담	</td><td class="ta_left">교수 정상혁	</td><td class="ta_left">02-760-5511	</td></tr>
							<tr><td rowspan="2" class="ta_left">미용학(학송관 204호)</td><td class="ta_left">전공총괄 / 상담	</td><td class="ta_left">주임교수 오경헌	</td><td class="ta_left">02-760-5505	</td></tr>
							<tr><td class="ta_left">전공총괄 / 상담	</td><td class="ta_left">교수 전수영	</td><td class="ta_left">02-760-5515	</td></tr>
<!-- 20210402 관리자요청							<tr><td class="ta_left">패션비즈니스학(학송관 205호) <td class="ta_left">전공총괄 / 상담	</td><td class="ta_left">주임교수 김보경	</td><td class="ta_left">02-760-5508	</td></tr> -->
							<tr><td class="ta_left">패션디자인학(학송관 205호)<td class="ta_left">전공총괄 / 상담	</td><td class="ta_left">주임교수 서은영	</td><td class="ta_left">02-760-5506	</td></tr>
							<tr><td class="ta_left">산업디자인(학송관 207호)<td class="ta_left">전공총괄 / 상담	</td><td class="ta_left">주임교수 유지연	</td><td class="ta_left">02-760-5501	</td></tr>
							<!-- 200420수정 -->							
<!-- 							<tr><td  rowspan="3" class="ta_left">총학생회(진리관314호)<td class="ta_left">학생회 총괄	</td><td class="ta_left">학생회장 이건희 </td><td class="ta_left">-</td></tr> -->
<!-- 							<tr><td class="ta_left">학생행사	</td><td class="ta_left">부학생회장 강주연	</td><td class="ta_left">-</td></tr> -->
<!-- 							<tr><td class="ta_left">학생회비 관리, 사물함 관리	</td><td class="ta_left">총무부장 이승욱	</td><td class="ta_left">-</td></tr> -->
							<tr><td  rowspan="3" class="ta_left">총학생회(진리관 314호)<td class="ta_left">학생회 총괄	</td><td class="ta_left">학생회장 권용현 </td><td class="ta_left">-</td></tr>
							<tr><td class="ta_left">학생행사	</td><td class="ta_left">학생부회장  김선찬	</td><td class="ta_left">-</td></tr>
							<tr><td class="ta_left">학생회비 관리, 사물함 관리	</td><td class="ta_left">총무부장 김의현	</td><td class="ta_left">-</td></tr>
							<!-- //200420수정 -->
						</tbody>
					</table>
					<script>$("td.ta_left").css("text-align","center");</script>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- content -->
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<form id="frm" name="frm">
</body>
</html>