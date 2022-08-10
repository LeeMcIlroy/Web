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
			
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="전공"/>
		            <jsp:param name="dept2" value="일학습엘리트과정이란?"/>
	           	</jsp:include>
				<div class="sub_cont_page">
					<dl class="info_dl">
						<dd>
							<p>한디원의 ‘일학습엘리트과정’이란 한디원과 기업체가 서로 계약을 맺고, 기업 및 현장에서 요구하는 맞춤형 인재를 양성하여 한디원 졸업과 동시에<br/> 직업을 갖도록 하기 위한 직업중심 학위과정을 말한다.</p>
							<p>특히 한디원의 일학습엘리트과정은 학사에서 석사까지 연결되는 프로그램이다. 학사과정동안 등록금의 40%를 장학금으로 수여 하며,<br/>한성대학교 석사과정으로 진학할 경우, 등록금의 30~50%를 장학금으로 수여한다.</p>
							<p>일학습병행이라는 취지에 맞도록 평일 1일 또는 2일 수업으로 이루어져 있으며, 한성대학교 총장명의 학사학위를 취득할 수 있는 스페셜한 과정이다.</p>
						</dd>
						<div class="tit_3rd">학비부담은 줄이고 직업 만족도는 높이고</div>
						<dd>
							<p>- 학습자 장학금 40% 지급 / 대학원 진학 시 30~50% 장학금 지급</p>
							<p>- 평일 야간 하루 & 토요일 하루 수업</p>
							<p>- 3년만에 학사학위 취득 가능</p>
							<p>- 직무 실습형 산업현장교육 실시</p>
							<p>- 기업이 주도적으로 육성하는 인재교육</p>
						</dd>
					</dl>
					<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/elite_prospect.jpg'/>" />
					<dl class="info_dl">						
						<div class="tit_3rd">일학습엘리트과정 교육기간, 개설전공 및 교육 참여기업</div>
						<dd>
							<p>과정기간 : 3년 총 6학기</p>
							<p>수업일정 : 평일야간 1일 + 주말</p>							
						</dd>
					</dl>				
					<div class="ta_overbox">
						<div class="tit_3rd">개설 전공 및 과정</div>
						<table class="ta874_ty02" summary="일학습엘리트과정 교육기간, 개설전공 및 교육 참여기업">
							<caption>일학습엘리트과정 교육기간, 개설전공 및 교육 참여기업</caption>
							<colgroup>
								<col style="width:25%;" />
								<col style="width:25%;" />
								<col style="width:25%;" />
								<col style="width:25%;" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col" >전공</th>
									<th scope="col" >진로직업 분야</th>
									<th scope="col" >참여기관</th>
									<th scope="col" >전공명/학위명</th>
								</tr>
							</thead>
							<tbody>	
								<tr>
									<td scope="col">패션비즈니스</td>
									<td scope="col">글로벌패션창업</td>
									<td scope="col">주)카페24</td>
									<td scope="col">패션마케팅/패션학사</td>
								</tr>
								<tr>
									<td scope="col" rowspan="2">미용학</td>
									<td scope="col">뷰티교육자</td>
									<td scope="col">사)월드뷰티아트협회</td>
									<td scope="col" rowspan="2">뷰티매니지먼트디자인/미용학사</td>
								</tr>
								<tr>
									<td scope="col">하야시두피모발</td>
									<td scope="col" style="border-right: 1px solid #cccccc;">주)하야시</td>
								</tr>
								<tr>
									<td scope="col">부동산</td>
									<td scope="col">자산관리전문가</td>
									<td scope="col" colspan="2">(개설예정)</td>
								</tr>
								<tr>
									<td scope="col" colspan="4" class="ta_left r_txt">
										* 초대졸 및 동등학점 취득자 편입가능<br> 
										* 관련분야 자격증 미 취득 시 졸업 기간이 늘어날 수 있음
									</td>										
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