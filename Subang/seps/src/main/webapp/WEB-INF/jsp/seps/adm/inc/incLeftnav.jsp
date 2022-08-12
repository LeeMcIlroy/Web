<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<c:choose>
	<c:when test="${fn:indexOf(sessionScope.leftMeneNo, '20') > -1 }">
		<div class="left_menu left_mit" id="left_menu">
			<div class="left_title"><p class="left_icon02">사용자관리</p></div>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/adm/userManage/userManageList.do'/>">사용자관리</a></li>
			</ul>
		</div>
	</c:when>
	<c:when test="${fn:indexOf(sessionScope.leftMeneNo, '30') > -1 }">
		<div class="left_menu left_as"" id="left_menu">
			<div class="left_title"><p class="left_icon02">수방센터</p></div>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/adm/floodCenter/floodControlList.do'/>">수방단계설정</a>
				<li><a href="<c:out value='${pageContext.request.contextPath }/adm/floodCenter/noticeList.do'/>">공지사항</a>
				<li><a href="<c:out value='${pageContext.request.contextPath }/adm/floodCenter/floodAlarmList.do'/>">기간별알람현황</a>
			</ul>
		</div>
	</c:when>
	<c:when test="${fn:indexOf(sessionScope.leftMeneNo, '40') > -1 }">
		<div class="left_menu left_cont" id="left_menu">
			<div class="left_title"><p class="left_icon02">비상연락망</p></div>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/adm/hotLine/hotLineList.do'/>">비상연락망</a></li>
			</ul>
		</div>
	</c:when>
	<c:when test="${fn:indexOf(sessionScope.leftMeneNo, '50') > -1 }">
		<div class="left_menu left_meni" id="left_menu">
			<div class="left_title"><p>운영관리</p></div>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/adm/systemManage/systemManageList.do'/>">관리자관리</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/adm/systemManage/apiStatusView.do'/>">데이터연계현황</a></li>
			</ul>
		</div>
	</c:when>
</c:choose>
