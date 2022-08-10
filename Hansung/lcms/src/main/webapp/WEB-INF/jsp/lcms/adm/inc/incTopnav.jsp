<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="lcms.valueObject.AdminVO" %>
<%
	String admMenuNo = ((String)session.getAttribute("admMenuNo")!=null)?(String)session.getAttribute("admMenuNo"):"";
	AdminVO adminVO = ((AdminVO)session.getAttribute("adminSessionLcms")!=null)?(AdminVO)session.getAttribute("adminSessionLcms"):null;
%>
<header>
	<div class="top-area">
		<div class="content-box">
			<!-- gnd -->
			<div class="header-info">
				접속시간 : <%= adminVO.getLoginDateTime() %> (<label id="cntTime">0</label>분 경과)
				<i class="icon-user ml20"></i>
				<label for="user-pop"><%= adminVO.getName() %>님</label>
				<input type="checkbox" id="user-pop">
				<div class="user-popup">
					<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/oper/admAdminProfileView.do'/>">Profile</a>
					<a href="">시간연장</a>
					<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/lgn/admLogout.do'/>">Logout</a>
				</div>
			</div>
			<!-- // gnd -->
			<div class="header-menu">
				<!-- logo -->
				<h1><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/entran/admEntranList.do'/>">학사관리시스템</a></h1>
				<!--// logo -->

				<!-- top menu -->
				<nav>
					<% if("Y".equals(adminVO.getEntran()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/entran/admEntranList.do'/>" <%if( admMenuNo.indexOf("10")==0 ){%>class="on"<%}%>><span>입학</span></a>
					<% } %>
					<% if("Y".equals(adminVO.getRegist()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/regist/admAccoList.do'/>" <%if( admMenuNo.indexOf("20")==0 ){%>class="on"<%}%>><span>등록</span></a>
					<% } %>
					<% if("Y".equals(adminVO.getStudent()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admStatusList.do'/>" <%if( admMenuNo.indexOf("30")==0 ){%>class="on"<%}%>><span>학생</span></a>
					<% } %>
					<% if("Y".equals(adminVO.getClss()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admEnroList.do'/>" <%if( admMenuNo.indexOf("40")==0 ){%>class="on"<%}%>><span>수업</span></a>
					<% } %>
					<% if("Y".equals(adminVO.getAdmstr()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admNoticeList.do'/>" <%if( admMenuNo.indexOf("50")==0 ){%>class="on"<%}%>><span>행정</span></a>
					<% } %>
					<% if("Y".equals(adminVO.getStat()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/stat/admNatiStatList.do'/>" <%if( admMenuNo.indexOf("60")==0 ){%>class="on"<%}%>><span>현황통계</span></a>
					<% } %>
					<% if("Y".equals(adminVO.getOper()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/oper/admAdminList.do'/>" <%if( admMenuNo.indexOf("70")==0 ){%>class="on"<%}%>><span>운영</span></a>
					<% } %>
					<% if("Y".equals(adminVO.getCurr()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admSemeList.do'/>" <%if( admMenuNo.indexOf("80")==0 ){%>class="on"<%}%>><span>교육과정</span></a>
					<% } %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/oper/admAdminProfileView.do'/>" <%if( admMenuNo.indexOf("90")==0 ){%>class="on"<%}%> style="display:none"><span>마이페이지</span></a>
				</nav> 
				<!--// top menu -->
			</div>
		</div>
	</div>
   </header>