<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<link rel="stylesheet" media="print" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/style.css'/>">
<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/dvspop.css'/>">
<link rel="stylesheet" media="print" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/dvspop.css'/>">
<style type="text/css" media="print">
html, body { height: auto;}

@page {
    size: 80%;  /* auto is the initial value */
    margin: 0 auto;  /* this affects the margin in the printer settings */
}
</style>
<script type="text/javascript">
	function pageprint() {
		var g_oBeforeBody = document.getElementById('print-pop').innerHTML;
		
		window.onbeforeprint = function (ev) {
			document.body.innerHTML = g_oBeforeBody;
		};
		
 		window.print();
	}
</script>
<body onload="pageprint();">
	<div id="print-pop">
		<c:choose>
			<c:when test="${prtType eq 'STDLIST'}">
<%-- 				<c:import url="/EgovPageLink.do?link=adm/clss/inc/incStdList"/> --%>
				<c:forEach items="${resultList }" var="result">
					<c:set var="result" value="${result }" scope="request"/>
					<c:import url="/EgovPageLink.do?link=adm/clss/inc/incStdList"/>
				</c:forEach>
			</c:when>
			<c:when test="${prtType eq 'DVSTBL' }">
				<c:import url="/EgovPageLink.do?link=adm/clss/inc/incDvsList"/>
			</c:when>
			<c:when test="${prtType eq 'ALLSTD' }">
				<c:forEach items="${resultList }" var="result" varStatus="status">
					<c:set var="result" value="${result }" scope="request"/>
					<c:set var="num" value="${resultList.size()}" scope="request"/>
					<c:set var="i" value="${status.index}" scope="request"/>
					<c:set var="a" value="stdList${i}" />
					<c:set var="size" value="${requestScope[a].size() }"  scope="request"/>
					<c:if test="${size ne 0 }">
						<c:import url="/EgovPageLink.do?link=adm/clss/inc/incStdAllList"/>
					</c:if>
				</c:forEach>
			</c:when>
		</c:choose>
	</div>
</body>
</html>