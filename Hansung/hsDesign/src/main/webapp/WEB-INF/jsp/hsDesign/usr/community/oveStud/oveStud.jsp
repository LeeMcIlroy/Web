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
						<c:param name="dept3" value="해외연수 안내"/>
					</c:import>
					
					
           	 	<!-- 200420추가 -->
	           	<div class="top_tab type_li2">
					<ul>
						<li class="active"><a href="<c:out value='${pageContext.request.contextPath }/usr/community/oveStud/oveStud.do'/>">해외연수 안내</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/oveStud/oveStudList.do'/>">해외연수 보고서</a></li>
					</ul>
				</div>
				<!-- 200422추가 -->
					<div class="sub_cont_page">
					<dl class="info_dl">
						<dd>
							<p style="font-weight: bold;">해외 연수(H-Beauty Global Field Trip)</p>
							<p>
								-학점은행제 교육기관 최초 해외연수 프로그램 운영<br/>
								-미용학 전공 학생들이 미국 뉴욕에 위치한 Miracle Nail & Spa에서 해당 전공 분야의    심화 훈련 및 실무 경험 취득<br/>
								-인턴십 종료 후 추가 여행 기회 제공<br/>
 							</p>
						</dd>
						<dd>
							<p style="font-weight: bold;">[연혁]</p>
								H-Beauty Global Field Trip 1기(2017 동계)<br/>
								&nbsp;김*빈 외 2명<br/>
								H-Beauty Global Field Trip 2기(2018 하계)<br/>
								&nbsp;국*헌 외 9명<br/>
								H-Beauty Global Field Trip 3기(2018 동계)<br/>
								&nbsp;장*수 외 7명<br/>
								H-Beauty Global Field Trip 4기(2019 하계)<br/>
								&nbsp;박*현 외 9명<br/>
								H-Beauty Global Field Trip 5기(2019 동계)<br/>
								&nbsp;김*미 외 1명<br/>
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