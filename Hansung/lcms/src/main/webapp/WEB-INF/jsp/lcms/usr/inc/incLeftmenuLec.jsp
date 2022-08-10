<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String lecMenuNo = ((String)session.getAttribute("lecMenuNo")!=null)?(String)session.getAttribute("lecMenuNo"):"";
%>


<div id="cssmenu" class="web"> <!-- 모바일 수정 -->
	<%if( lecMenuNo.indexOf("10")==0 ){%>
	<div class="left-title"><span>수업</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecSyllabusView.do'/>" <% if( lecMenuNo.indexOf("101")==0 ){ %> class="on" <%}%>>강의계획서</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssNoticeList.do'/>" <% if( lecMenuNo.indexOf("102")==0 ){ %> class="on" <%}%>>강의공지</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssPeopleList.do'/>" <% if( lecMenuNo.indexOf("103")==0 ){ %> class="on" <%}%>>수강인원</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssCounselList.do'/>" <% if( lecMenuNo.indexOf("104")==0 ){ %> class="on" <%}%>>상담</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssAppraiseList.do'/>" <% if( lecMenuNo.indexOf("105")==0 ){ %> class="on" <%}%>>학생평가</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssSatisfactionList.do'/>" <% if( lecMenuNo.indexOf("106")==0 ){ %> class="on" <%}%>>수업만족도</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssMeetList.do'/>" <% if( lecMenuNo.indexOf("107")==0 ){ %> class="on" <%}%>>급별회의록</a></li>
	</ul>
	<%}else if( lecMenuNo.indexOf("20")==0 ){%>
	<div class="left-title"><span>과제</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/task/lecTaskList.do'/>" <% if( lecMenuNo.indexOf("201")==0 ){ %> class="on" <%}%>>과제</a></li>
	</ul>
	<%}else if( lecMenuNo.indexOf("30")==0 ){%>
	<div class="left-title"><span>출결</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/attnd/lecAttndList.do'/>" <% if( lecMenuNo.indexOf("301")==0 ){ %> class="on" <%}%>>출결</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/attnd/lecAbsCounselList.do'/>" <% if( lecMenuNo.indexOf("302")==0 ){ %> class="on" <%}%>>결석자상담</a></li>
	</ul>
	<%}else if( lecMenuNo.indexOf("40")==0 ){%>
	<div class="left-title"><span>성적</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/result/lecResultList.do'/>" <% if( lecMenuNo.indexOf("401")==0 ){ %> class="on" <%}%>>성적</a></li>
	</ul>
	<%}else if( lecMenuNo.indexOf("50")==0 ){%>
	<div class="left-title"><span>마이페이지</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/myPage/lecNoticeList.do'/>" <% if( lecMenuNo.indexOf("501")==0 ){ %> class="on" <%}%>>공지사항</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/myPage/lecScheduleList.do'/>" <% if( lecMenuNo.indexOf("502")==0 ){ %> class="on" <%}%>>강의시간표</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/myPage/lecProfileView.do'/>" <% if( lecMenuNo.indexOf("503")==0 ){ %> class="on" <%}%>>Profile</a></li>
	</ul>
	<%} %>
</div>