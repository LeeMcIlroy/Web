<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="egovframework.com.cmm.util.EgovUserDetailsHelper" %>
<%@ page import="seps.valueObject.UserInfoVO" %>
<%
	UserInfoVO userVO = (UserInfoVO) session.getAttribute("userSession");
%>
<!-- PAGE_HEAD -->
<div class="m_header">
	<div class="t_logo">
		<a href="/"><img src="<c:out value='${pageContext.request.contextPath }/assets/img/top_logo.png'/>" alt="ESS" /></a>
	</div>
	<%-- <button id="clickme" onclick="return false;"><img src="<c:out value='${pageContext.request.contextPath }/assets/img/mobile_menu_open.png'/>" alt="메뉴열기" /></button> --%>
	<!-- TOP_MENU -->
	<div class="t_menu">
		<!-- PC_TOP_MENU -->
		<div class="pc_menu">
			<ul>
				<li>
					<a href="<c:out value='${pageContext.request.contextPath }/adm/userManage/userManageList.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '10') > -1 }">class="on"</c:if>
					>사용자관리</a>
				</li>
				<li>
					<a href="<c:out value='${pageContext.request.contextPath }/adm/floodCenter/floodControlList.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '20') > -1 }">class="on"</c:if>
					>수방센터</a>
				</li>
				<li>
					<a href="<c:out value='${pageContext.request.contextPath }/adm/hotLine/hotLineList.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '30') > -1 }">class="on"</c:if>
					>비상연락망</a>
				</li>
				<li>
					<a href="<c:out value='${pageContext.request.contextPath }/adm/systemManage/systemManageList.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '40') > -1 }">class="on"</c:if>
					>운영관리</a>
				</li>
			</ul>
			<div class="log_in">
				<ul>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/dashboard/main.do'/>">[사용자 바로가기]</a></li>
					<li><a href="#"><%=userVO.getUserNm() %></a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/logout.do'/>">로그아웃</a></li>
				</ul>
			</div>
		</div>
		<!--// PC_TOP_MENU -->
	</div>
	<!--// TOP_MENU -->
</div>
<!-- //PAGE_HEAD-->