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
		            <jsp:param name="dept2" value="일학습엘리트과정"/>
		            <jsp:param name="dept3" value="헤어디자이너"/>
		            <jsp:param name="dept4" value="교과과정"/>
	           	</jsp:include>
				<div class="sub_cont_page">
					<div class="ta_overbox">
						<table class="ta874_ty02" summary="교과 과정 정보를 학년, 이수구분, 1학기(교과목명, 학점), 이수구분, 2학기(교과목명, 학점) 순서로 보여줍니다.">
						<caption>교과 과정표</caption>
						<colgroup>
							<col style="width:;" />
							<col style="width:;" />
							<col style="width:;" />
							<col style="width:;" />
							<col style="width:;" />
						</colgroup>
						<thead>
							<tr style="height:40px;">
								<th scope="col" rowspan="2">학년</th>
								<th scope="col" colspan="2">뷰티교육자 단계별 교육과정</th>
								<th scope="col" colspan="2">뷰티엘리트 단계별 교육과정</th>
							</tr>
							<tr>
								<th>과정</th>
								<th>상세내용</th>
								<th>과정</th>
								<th>상세내용</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th style="background-color: #dae6eb;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;">1학년</th>
								<td>기초 및 중급 과정</td>
								<td>모발과학<br>색채학<br>기본두피 및 모발케어 이론<br>기본컬러이론<br>뷰티산업CS</td>
								<td>기초 및 중급 과정</td>
								<td>기초메이크업<br>기초피부관리<br>왁싱기초<br>속눈썹기초<br>색채학<br>관상학<br>토털코디네이션</td>
							</tr>
							<tr>
								<th rowspan="2" style="background-color: #dae6eb;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;">2학년</th>
								<td>미용장, 이용장 과정</td>
								<td>컷트 이론 및 실습<br>화학시술 이론<br>응용컬러 이론 및 실습</td>
								<td rowspan="2">중급 및 고급 과정</td>
								<td rowspan="2">메디컬 스킨케어<br>메티컬 특수메이크업<br>속눈썹실무<br>메디컬 타투실무<br>특수바디메이크업<br>뷰티일러스트</td>
							</tr>
							<tr>
								<td>디자인 창조 교육 과정</td>
								<td style="border-right: 1px solid #cccccc;">퍼머넌트웨이브<br>헤어컬러링<br>드라이스타일링<br>뷰티디자인현장</td>
							</tr>
							<tr>
								<th rowspan="2" style="background-color: #dae6eb;border-right: 1px solid #cccccc;border-bottom: 1px solid #cccccc;">3학년</th>
								<td>CEO 과정</td>
								<td>뷰티트랜드<br>기획<br>마케팅</td>
								<td rowspan="2">CEO 과정</td>
								<td rowspan="2">기업연계<br>현장실무실습<br>창업<br>디자인교육<br>서비스경영</td>
							</tr>
							<tr>
								<td>뷰티 디자인 문화 창출 과정</td>
								<td style="border-right: 1px solid #cccccc;">뷰티경영<br>뷰티디자인현장실습<br>뷰티마케팅<br>포트폴리오</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
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