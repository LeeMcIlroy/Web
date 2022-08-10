<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="header">
	<div class="top">
		<h1 class="logo"><a href="<c:url value='/xabdmxgr/lec/admLecClassList.do'/>"><img src="<c:url value='/assets/adm/img/top_logo.jpg'/>" alt="한성대학교 글쓰기 센터 Hansung Ynivertsity Wtiring Center" /></a></h1>
		<div class="util">
			<a href="<c:url value='/xabdmxgr/lgn/admLogout.do'/>" class="gnb_btn">LOGOUT</a>
			<%-- <a href="<c:url value='https://hansung.ac.kr/c/portal/logout?redirect=http://writingcenter.hansung.ac.kr/xabdmxgr/lgn/admLogout.do'/>" class="gnb_btn">LOGOUT</a> --%>
<%-- 			<a style="display:inline-block; right: -20px;" href="<c:url value='https://hansung.ac.kr/c/portal/logout?redirect=http://writingcenter.hansung.ac.kr/xabdmxgr/lgn/admLogout.do'/>" class="gnb_btn">LOGOUT</a> --%>
<!-- 			<a style="display:inline-block;" href="https://writingcenter.hansung.ac.kr/" class="gnb_btn">메인</a> -->
			<%--
			<a href="<c:url value='/xabdmxgr/lgn/admLogout.do'/>" class="gnb_btn">LOGOUT</a>
			 --%>
		</div>
	</div>
	<ul class="gnb">
<%-- 		<c:if test="${sessionScope.adminSession.memLevel eq 1 }"></c:if> --%>
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${sessionScope.adminSession.memLevel eq 1 }"> --%>
				<li><a href="<c:url value='/usr/main/index.do'/>">메인</a></li>
				<li><a href="<c:url value='/xabdmxgr/lec/admLecClassList.do'/>">강의실</a></li>
				<li><a href="<c:url value='/xabdmxgr/cnslt/list/admCnsltList.do'/>">상담</a></li>
				<li><a href="<c:url value='/xabdmxgr/wcGuide/tips/admWcGuideTipsList.do'/>">글쓰기 길잡이</a></li>
				<li><a href="<c:url value='/xabdmxgr/boardMng/notice/admBoardMngNoticeList.do'/>">게시판 관리</a></li>
				<li><a href="<c:url value='/xabdmxgr/lecMng/smtr/admLecMngSemesterList.do'/>">강의실 관리</a></li>
				<li><a href="<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberList.do'/>">사이트 관리</a></li>
				<li><a href="<c:url value='/xabdmxgr/qestnar/admQuestionaireList.do'/>" >설문조사</a></li>
<%-- 			</c:when> --%>
<%-- 			<c:when test="${sessionScope.adminSession.memLevel eq 2 || sessionScope.adminSession.memLevel eq 3 }"> --%>
<!-- 				<li><a href="https://writingcenter.hansung.ac.kr/">메인</a></li> -->
<%-- 				<li><a href="<c:url value='/xabdmxgr/lec/admLecClassList.do'/>">강의실</a></li> --%>
<%-- 				<li><a href="<c:url value='/xabdmxgr/cnslt/list/admCnsltList.do'/>">상담</a></li> --%>
<%-- 				<li><a href="<c:url value='/xabdmxgr/wcGuide/tips/admWcGuideTipsList.do'/>">글쓰기 길잡이</a></li> --%>
<%-- 				<li><a href="<c:url value='/xabdmxgr/boardMng/notice/admBoardMngNoticeList.do'/>">게시판 관리</a></li> --%>
<%-- 			</c:when> --%>
<%-- 		</c:choose> --%>
	</ul>
</div>
