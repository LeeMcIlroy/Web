<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath }/assets/css/main_animate.css'/>">
<!-- Custom Stylesheet -->
<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath }/assets/css/main_style.css'/>">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<body>
	<div style="width:100%; height: 100%">
		<img src="<c:out value='${pageContext.request.contextPath}/assets/img/solution/4_001.png'/>" alt="4_001"  width="100%"  height="100%"/>
		<img src="<c:out value='${pageContext.request.contextPath}/assets/img/solution/4_002.png'/>" alt="4_002"  width="100%"  height="100%"/>
	</div>
</body>
</html>