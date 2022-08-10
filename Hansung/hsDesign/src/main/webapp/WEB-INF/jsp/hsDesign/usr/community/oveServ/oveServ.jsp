<!-- 200408추가 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<form:form commandName="searchVO" id="frm" name="frm">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
		<!-- header area -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
		<!-- //header area -->
		<div class="main_content" id="content">
			<div class="width_box">
				<!-- left menu area-->
				<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
				<!-- //left menu area-->
				<div class="sub_content">
					<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">
						<c:param name="dept1" value="캠퍼스생활"/>
						<c:param name="dept2" value="해외프로그램"/>
						<c:param name="dept3" value="해외봉사 안내"/>
					</c:import>
					
					
           	 	<!-- 200420추가 -->
	           	<div class="top_tab type_li2">
					<ul>
						<li class="active"><a href="<c:out value='${pageContext.request.contextPath }/usr/community/oveServ/oveServ.do'/>">해외봉사 안내</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/oveServ/oveServList.do'/>">해외봉사 보고서</a></li>
					</ul>
				</div>
				<!-- 200422추가 -->
					<div class="sub_cont_page">
					<dl class="info_dl">
						<dd>
							<p style="font-weight: bold;">해외봉사</p>
							<p>
								-학점은행제 교육기관 최초 해외연수 프로그램 운영<br/>
								-다양한 파견국에서 디자인 교육봉사와 미용봉사를 통해 학생의 전공별 역량을 강화하고, 세계화에 걸맞은 글로벌 마인드를 함양함<br/>
								-봉사 종료 후 추가 현지 문화 체험 기회 제공<br/>
 							</p>
						</dd>
						<dd>
							<p style="font-weight: bold;">[연혁]</p>
							  디자인아트 평생교육원 1기 미용 해외봉사단(2013, 우즈베키스탄)<br/>
							 &nbsp;&nbsp;엄용화 외 4명<br/>
							  디자인아트 평생교육원 2기 미용 해외봉사단(2014, 우즈베키스탄)<br/>
							 &nbsp;&nbsp;엄*비 외 4명<br/>
							  디자인아트 평생교육원 3기 미용 해외봉사단(2015 동계, 태국)<br/>
							 &nbsp;&nbsp;엄*비 외 4명<br/>
							  디자인아트 평생교육원 4기 미술디자인 및 미용 해외봉사단(2015 하계, 카자흐스탄)<br/>
							 &nbsp;&nbsp;류*진 외 9명<br/>
							  디자인아트 평생교육원 5기 동계 미용 해외봉사단(2016 동계, 라오스)<br/>
							 &nbsp;&nbsp;엄*비 외 3명<br/>
							  디자인아트 평생교육원 6기 하계 미용 해외봉사단(2016 하계, 키르키즈스탄)<br/>
							 &nbsp;&nbsp;엄*비 외 2명<br/>
							  디자인아트 평생교육원 7기 해외봉사단- 도깨비(2017 동계, 바누아투)<br/>
							 &nbsp;&nbsp;김*규 외 11명<br/>
							  디자인아트 평생교육원 8기 해외봉사단- 아우름(2017 하계, 몽골)<br/>
							 &nbsp;&nbsp;이*묵 외 13명<br/>
							  디자인아트 평생교육원 9기 해외봉사단- 그린나래(2018, 몽골)<br/>
							 &nbsp;&nbsp;한*민 외 15명<br/>
							  디자인아트 평생교육원 10기 해외봉사단 – 미리내(2019, 몽골)<br/> 
							 &nbsp;&nbsp;염*연 외 16명<br/>
						</dd>
					</dl>
					</div> 					
				
					<!-- rolling banner -->
					
					<!-- //rolling banner -->
				</div>
			</div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!-- //footer -->
	</div>
	<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>