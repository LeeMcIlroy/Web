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
						<c:param name="dept1" value="한디원소개"/>
						<c:param name="dept2" value="해외프로그램"/>
						<c:param name="dept3" value="해외인턴십 안내"/>
					</c:import>
					
					
           	 	<!-- 200420추가 -->
	           	<div class="top_tab type_li2">
					<ul>
						<li class="active"><a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외인턴십 안내</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseasList.do'/>">해외인턴십 보고서</a></li>
					</ul>
				</div>
				<!-- 200422추가 -->
					<div class="sub_cont_page">
					<dl class="info_dl">
						<dd>
							<p style="font-weight: bold;">해외인턴십 (ICCE USA 해외인턴십)</p>
							<p>
								-학점은행제 교육기관 최초 해외인턴십 프로그램 운영<br/>
								-미국 국무부에서 관할하는 국제문화 및 기술 교류, 인재육성을 목적으로 하는 유급 인턴십 프로그램으로 해당 전공 분야의 인턴 경험을 통해 졸업 후 취업에 용이한 전공 심화 및 실무 경험 취득<br/>
								-인턴십 종료 후 추가 여행 기회 제공<br/>
 							</p>
						</dd>
						<dd>
							<p style="font-weight: bold;">[연혁]</p>
							  &nbsp;&nbsp;한디원 ICCE 해외인턴십 1기(2018-2019)<br/>
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;나*윤 : IRIS(LA), 패션디자인<br/>
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;채*현 : H Mart(뉴욕), 마케팅디자인<br/>
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;최*원 : Sunrise Apparel(LA), 패션디자인<br/>

							  &nbsp;&nbsp;한디원 ICCE 해외인턴십 2기 (2019-2020)<br/>
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;김*나 : Lialoha(뉴욕), 그래픽디자인<br/>
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;김*율 : Oori Trading(LA), 그래픽디자인<br/>
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;성*지 : Zenobia(LA), 프로덕션<br/>
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이*리 : Hayden(LA), 프로덕션<br/>
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이*민 : IRIS(LA), 패션디자인<br/>
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;홍*화 : IRIS(LA), 패션디자인<br/>
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