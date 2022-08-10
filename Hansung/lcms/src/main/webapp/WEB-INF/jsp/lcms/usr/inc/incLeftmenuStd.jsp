<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String stdMenuNo = ((String)session.getAttribute("stdMenuNo")!=null)?(String)session.getAttribute("stdMenuNo"):"";
%>
<div id="cssmenu" class="web">
	<%if( stdMenuNo.indexOf("10")==0 ){%>
	<div class="left-title"><span>강의실</span></div>
	<ul>
		<!-- 2뎁스 메뉴추가시 li class="has-sub" 추가됨.-->
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/std/lecRoom/stdLecNoticeList.do'/>" <% if( stdMenuNo.indexOf("101")==0 ){ %> class="on" <%}%>>강의공지</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/std/lecRoom/stdSyllabusView.do'/>" <% if( stdMenuNo.indexOf("102")==0 ){ %> class="on" <%}%>>강의계획서</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/std/lecRoom/stdLecTaskList.do'/>" <% if( stdMenuNo.indexOf("103")==0 ){ %> class="on" <%}%>>과제</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/std/lecRoom/stdLecResultList.do'/>" <% if( stdMenuNo.indexOf("104")==0 ){ %> class="on" <%}%>>출결/성적</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/std/lecRoom/stdLecEvalList.do'/>" <% if( stdMenuNo.indexOf("105")==0 ){ %> class="on" <%}%>>수업만족도</a></li>
	</ul>
	<%}else if( stdMenuNo.indexOf("20")==0 ){%>
	<div class="left-title"><span>마이페이지</span></div>
	<ul>
		<!-- 2뎁스 메뉴추가시 li class="has-sub" 추가됨.-->
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/std/myPage/stdNoticeList.do'/>" <% if( stdMenuNo.indexOf("201")==0 ){ %> class="on" <%}%>>공지사항</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/std/myPage/stdScheduleView.do'/>" <% if( stdMenuNo.indexOf("202")==0 ){ %> class="on" <%}%>>수업시간표</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/std/myPage/stdDormitoryList.do'/>" <% if( stdMenuNo.indexOf("203")==0 ){ %> class="on" <%}%>>기숙사</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/std/myPage/stdCompletionList.do'/>" <% if( stdMenuNo.indexOf("204")==0 ){ %> class="on" <%}%>>수료현황</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/std/myPage/stdProfileView.do'/>" <% if( stdMenuNo.indexOf("205")==0 ){ %> class="on" <%}%>>Profile</a></li>
	</ul>
	<%} %>

</div>




