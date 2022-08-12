<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%@ page import="egovframework.rte.psl.dataaccess.util.EgovMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="ctms.valueObject.Sb1000mVO" %>
<%@ page import="ctms.valueObject.AdminVO" %>
<%
	AdminVO adminVO = ((AdminVO)session.getAttribute("adminSessionCtms")!=null)?(AdminVO)session.getAttribute("adminSessionCtms"):null;
%>
<div class="header background01">
	<div class="header_con">
		<!-- <h1>H&amp;Bio 피부임상연구센터</h1> -->
		<h1>KSRC 한국피부임상연구센터</h1>
		<div class="util">
			<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/lgn/admLogout.do'/>" title="로그아웃">로그아웃</a>
			<span><a class="mkRpt" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0105/ech0105List.do'/>" title="보고서작성">보고서작성</a></span>
		</div>
		<div class="gnb">
			<ul>
			<% if("Y".equals(adminVO.getMcrf()) || "1".equals(adminVO.getAdminType())){ %>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ecr0101/ecr0101List.do'/>">eCRF작성</a></li>
			<% } %>	
			<% if("Y".equals(adminVO.getAcrf()) || "1".equals(adminVO.getAdminType())){ %>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ecr0201/ecr0201List.do'/>">종료확인</a></li>
				<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/ecf0201/ecf0201List.do'/>">사용체크</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/ecf0301/ecf0301List.do'/>">설문참여</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/ecf0401/ecf0401List.do'/>">시험지원</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/ecf0501/ecf0501Modify.do'/>">회원정보</a></li> --%>
			<% } %>	
			</ul>
		</div>
		<!-- 모바일 메뉴 -->
		<div class="gnb_mobile">
			<a href="#" id="toggle-sidebar" onclick="return false;">메뉴</a>	
			<div id="main-sidebar">
				<div class="sidebar_top">
					<span>H&amp;Bio  Menu</span>
					<div class="util_logout">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/lgn/admLogout.do'/>" title="로그아웃">로그아웃</a>
						<a class="mkRpt" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0105/ech0105List.do'/>" title="보고서작성">보고서작성</a>
					</div>
					<a href="#" class="close_menu" onclick="return false;">닫기</a>
				</div>
				<ul>
				<% if("Y".equals(adminVO.getMcrf()) || "1".equals(adminVO.getAdminType())){ %>
					<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ecr0101/ecr0101List.do'/>">eCRF작성</a></li>
				<% } %>	
				<% if("Y".equals(adminVO.getAcrf()) || "1".equals(adminVO.getAdminType())){ %>	
					<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ecr0201/ecr0201List.do'/>">종료확인</a></li>
					<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/ecf0201/ecf0201List.do'/>">사용체크</a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/ecf0301/ecf0301List.do'/>">설문참여</a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/ecf0401/ecf0401List.do'/>">시험지원</a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/ecf0501/ecf0501Modify.do'/>">회원정보</a></li> --%>
				<% } %>
				</ul>	
			</div>
			<!-- //모바일 메뉴 -->
		</div>
		<!--  <p>참여일정<span>시험 참여 스케쥴을 안내해드립니다.</span></p> -->
		<p>KSRC 한국피부임상연구센터는<span>전문성과 신뢰성 기반의 세계 일류 인체적용시험 기관입니다</span></p>
		
	</div>
</div>