<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<c:choose>
	<c:when test="${fn:indexOf(sessionScope.leftMeneNo, '40') > -1 }">
		<div class="left_menu left_mit" id="left_menu">
			<!-- <div class="left_title"><p class="left_icon02">기상정보</p></div>-->
			 <div class="left_title"><p class="left_icon02">상세관측정보</p></div>
			
			<ul>
				 <li>
				 	<a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/periodWeatherInfo.do'/>"
				 	<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '401') > -1 }">class="on"</c:if> 
				 	>시간대별기상현황</a>
				 </li>
				 <li>
				 	<a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/periodLevelInfo.do'/>"
				 	<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '402') > -1 }">class="on"</c:if>
				 	>기간별수위정보</a>
				 </li>
				 <li>
				 	<a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/weatherInfo.do'/>"
				 	<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '403') > -1 }">class="on"</c:if>
				 	>기상정보</a>
				 </li>
				 <li>
				 	<a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/tideInfo.do'/>"
				 	<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '405') > -1 }">class="on"</c:if>
				 	>조위정보</a>
				 </li>
				 <li>
				 	<a href="https://www.metoc.navy.mil/jtwc/jtwc.html" target="_blank">미국기상청</a>
				 </li>
				 <li>
				 	<a href="https://tenki.jp/bousai/typhoon/" target="_blank">일본기상청</a>
				 </li>
				 <li>
				 	<a href="http://www.hrfco.go.kr/main.do" target="_blank">한강홍수통제소</a>
				 </li>
			</ul>
		</div>
	</c:when>
	<c:when test="${fn:indexOf(sessionScope.leftMeneNo, '50') > -1 }">
		<div class="left_menu left_as"" id="left_menu">
			<div class="left_title"><p class="left_icon02">수방매뉴얼</p></div>
			<ul>
				<li>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/floodCenter/noticeList.do'/>"
					<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '501') > -1 }">class="on"</c:if>
					>공지사항</a>
				</li>
				<li>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/floodCenter/floodAlarmList.do'/>"
					<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '502') > -1 }">class="on"</c:if> 
					>기간별알람현황</a>
				</li>
				<li>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/hotLine/hotLineList.do'/>"
					<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '601') > -1 }">class="on"</c:if>
					>비상연락망</a>
				</li>
			</ul>
		</div>
	</c:when>
	<c:when test="${fn:indexOf(sessionScope.leftMeneNo, '60') > -1 }">
		<div class="left_menu left_cont" id="left_menu">
			<div class="left_title"><p class="left_icon02">수방매뉴얼</p></div>
			<ul>
				<li>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/floodCenter/noticeList.do'/>"
					<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '501') > -1 }">class="on"</c:if>
					>공지사항</a>
				</li>
				<li>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/floodCenter/floodAlarmList.do'/>"
					<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '502') > -1 }">class="on"</c:if> 
					>기간별알람현황</a>
				</li>
				<li>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/hotLine/hotLineList.do'/>"
					<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '601') > -1 }">class="on"</c:if>
					>비상연락망</a>
				</li>
			</ul>
		</div>
	</c:when>
</c:choose>