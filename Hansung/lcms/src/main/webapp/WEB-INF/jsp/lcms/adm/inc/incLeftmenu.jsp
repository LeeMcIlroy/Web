<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="lcms.valueObject.UserInfoVO" %>
<%
	String admMenuNo = ((String)session.getAttribute("admMenuNo")!=null)?(String)session.getAttribute("admMenuNo"):"";
%>

<div id="cssmenu">
	<%if( admMenuNo.indexOf("10")==0 ){%>
	<div class="left-title"><span>입학</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/entran/admEntranList.do'/>" <% if( admMenuNo.indexOf("101")==0 ){ %> class="on" <%}%>>신입학</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/entran/admReregList.do'/>" <% if( admMenuNo.indexOf("102")==0 ){ %> class="on" <%}%>>재등록</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/entran/admStudentList.do'/>" <% if( admMenuNo.indexOf("103")==0 ){ %> class="on" <%}%>>학생명단</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/entran/admDelayList.do'/>" <% if( admMenuNo.indexOf("104")==0 ){ %> class="on" <%}%>>입학연기</a></li>
	</ul>
	<%}else if( admMenuNo.indexOf("20")==0 ){%>
	<div class="left-title"><span>등록</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/regist/admAccoList.do'/>" <% if( admMenuNo.indexOf("201")==0 ){ %> class="on" <%}%>>가상계좌발급</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/regist/admTuinotiList.do'/>" <% if( admMenuNo.indexOf("202")==0 ){ %> class="on" <%}%>>등록금고지</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/regist/admTuipayList.do'/>" <% if( admMenuNo.indexOf("203")==0 ){ %> class="on" <%}%>>등록금납부</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/regist/admRefList.do'/>" <% if( admMenuNo.indexOf("204")==0 ){ %> class="on" <%}%>>환불</a></li>
	</ul>
	<%}else if( admMenuNo.indexOf("30")==0 ){%>
	<div class="left-title"><span>학생</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admStatusList.do'/>" <% if( admMenuNo.indexOf("301")==0 ){ %> class="on" <%}%>>학생현황</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admFuncList.do'/>" <% if( admMenuNo.indexOf("302")==0 ){ %> class="on" <%}%>>학적변동</a></li>
	</ul>
	<%}else if( admMenuNo.indexOf("40")==0 ){%>
	<div class="left-title"><span>수업</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admEnroList.do'/>" <% if( admMenuNo.indexOf("401")==0 ){ %> class="on" <%}%>>수강신청</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admComplList.do'/>" <% if( admMenuNo.indexOf("402")==0 ){ %> class="on" <%}%>>수료산정</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admAttendList.do'/>" <% if( admMenuNo.indexOf("403")==0 ){ %> class="on" <%}%>>출결</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admGradeList.do'/>" <% if( admMenuNo.indexOf("404")==0 ){ %> class="on" <%}%>>성적</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admConsulList.do'/>" <% if( admMenuNo.indexOf("405")==0 ){ %> class="on" <%}%>>상담</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admAbsentStatusList.do'/>" <% if( admMenuNo.indexOf("408")==0 ){ %> class="on" <%}%>>결석자현황</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admAbsCounselList.do'/>" <% if( admMenuNo.indexOf("409")==0 ){ %> class="on" <%}%>>결석자상담</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admAbsWrnList.do'/>" <% if( admMenuNo.indexOf("40A")==0 ){ %> class="on" <%}%>>결석경고</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admSatisList.do'/>" <% if( admMenuNo.indexOf("406")==0 ){ %> class="on" <%}%>>수업만족도</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admSatisPrfList.do'/>" <% if( admMenuNo.indexOf("407")==0 ){ %> class="on" <%}%>>강의평가</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admMeetLogList.do'/>" <% if( admMenuNo.indexOf("40B")==0 ){ %> class="on" <%}%>>급별회의록</a></li>
	</ul>
	<%}else if( admMenuNo.indexOf("50")==0 ){%>
	<div class="left-title"><span>행정</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admNoticeList.do'/>" <% if( admMenuNo.indexOf("505")==0 ){ %> class="on" <%}%>>공지사항</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admCertiList.do'/>" <% if( admMenuNo.indexOf("501")==0 ){ %> class="on" <%}%>>증명서</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admScholarList.do'/>" <% if( admMenuNo.indexOf("502")==0 ){ %> class="on" <%}%>>장학/수상</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admDormList.do'/>" <% if( admMenuNo.indexOf("503")==0 ){ %> class="on" <%}%>>기숙사</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admProfList.do'/>" <% if( admMenuNo.indexOf("504")==0 ){ %> class="on" <%}%>>교사</a></li>
	</ul>
	<%}else if( admMenuNo.indexOf("60")==0 ){%>
	<div class="left-title"><span>현황통계</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/stat/admNatiStatList.do'/>" <% if( admMenuNo.indexOf("601")==0 ){ %> class="on" <%}%>>수강생국적통계</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/stat/admStdStatList.do'/>" <% if( admMenuNo.indexOf("602")==0 ){ %> class="on" <%}%>>학생구분별통계</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/stat/admComplStatList.do'/>" <% if( admMenuNo.indexOf("603")==0 ){ %> class="on" <%}%>>수료형태별통계</a></li>
	</ul>
	<%}else if( admMenuNo.indexOf("70")==0 ){%>
	<div class="left-title"><span>운영</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/oper/admAdminList.do'/>" <% if( admMenuNo.indexOf("701")==0 ){ %> class="on" <%}%>>사용자관리</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/oper/admLogList.do'/>" <% if( admMenuNo.indexOf("702")==0 ){ %> class="on" <%}%>>개인정보처리(로그)</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/oper/admLoginLogList.do'/>" <% if( admMenuNo.indexOf("703")==0 ){ %> class="on" <%}%>>접속이력</a></li>
	</ul>
	<% }else if(admMenuNo.indexOf("80")==0){ %>
	<div class="left-title"><span>교육과정</span></div>
	<ul>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admSemeList.do'/>" <% if( admMenuNo.indexOf("801")==0 ){ %> class="on" <%}%>>학기</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admCurrList.do'/>" <% if( admMenuNo.indexOf("802")==0 ){ %> class="on" <%}%>>교육과정</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admProgList.do'/>" <% if( admMenuNo.indexOf("803")==0 ){ %> class="on" <%}%>>프로그램</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admClstmList.do'/>" <% if( admMenuNo.indexOf("804")==0 ){ %> class="on" <%}%>>수업시간</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admCourList.do'/>" <% if( admMenuNo.indexOf("805")==0 ){ %> class="on" <%}%>>교과목</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admLectList.do'/>" <% if( admMenuNo.indexOf("806")==0 ){ %> class="on" <%}%>>강의개설</a></li>
	   <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admSatisList.do'/>" <% if( admMenuNo.indexOf("807")==0 ){ %> class="on" <%}%>>수업만족도항목</a></li>
	</ul>
	<% }else if(admMenuNo.indexOf("90")==0){ %>
	<div class="left-title"><span>마이페이지</span></div>
	<ul>
		<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/oper/admAdminProfileView.do'/>" <% if( admMenuNo.indexOf("901")==0 ){ %> class="on" <%}%>>Profile</a></li>
	</ul> 
	<%}%>
</div>