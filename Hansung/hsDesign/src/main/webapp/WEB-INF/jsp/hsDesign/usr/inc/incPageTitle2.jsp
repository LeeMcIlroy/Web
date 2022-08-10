<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- sns -->
<div class="top_sns">
	<ul>
		<%-- <li><a href="<c:url value='http://cafe.naver.com/edubankhs'/>" title="[새창] 네이버 블로그 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_n.jpg'/>" alt="네이버 블로그" /></a></li> --%>
<%-- 		<li><a href="<c:url value='http://blog.naver.com/edubankhs'/>" title="[새창] 네이버 블로그 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_n.jpg'/>" alt="네이버 블로그" /></a></li> --%>
		<li><a href="<c:url value='https://www.instagram.com/handione_official/'/>" title="[새창] 인스타그램 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_i.jpg'/>" alt="인스타그램" /></a></li>
		<li><a href="<c:url value='https://www.facebook.com/hansungart'/>" title="[새창] 페이스북 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_f.jpg'/>" alt="페이스북" /></a></li>
		<li><a href="<c:url value='https://www.youtube.com/channel/UCCCqSlEk1kmlnbc669O-xwQ'/>" title="[새창] 유튜브 바로가기" target="_blank"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/sns_y.jpg'/>" alt="유투브" /></a></li>
	</ul>
</div>
<!-- //sns -->
<div class="sub_top_area">
	<c:if test="${empty param.dept4 || param.dept4 eq ''}">
		<div class="sub_title">${param.dept3 }</div>
	</c:if>
	<c:if test="${!empty param.dept4 || param.dept4 ne ''}">
		<div class="sub_title">${param.dept4 }</div>
	</c:if>
	<div class="page_navi">
		<span><a href="#">Home</a> <c:if test="${!empty param.dept1 }">&gt; ${param.dept1 }</c:if> &gt; ${param.dept2 } &gt; ${param.dept3 } 
			<c:if test="${!empty param.dept4}">
				&gt; ${param.dept4 }
			</c:if>
		</span>
	</div>
</div>