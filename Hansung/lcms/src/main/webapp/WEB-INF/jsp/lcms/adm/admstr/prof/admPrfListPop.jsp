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
<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/profpop.css'/>">
<link rel="stylesheet" media="print" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/profpop.css'/>">
<style type="text/css" media="print">
html, body { height: auto; }

@page {
    size: auto;  /* auto is the initial value */
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
			<c:when test="${prtType eq 'PRFLIST' }">
				<c:import url="/EgovPageLink.do?link=adm/admstr/prof/incProfList"/>
			</c:when>
			<c:when test="${prtType eq 'RETIR' }">
				<c:forEach items="${resultList }" var="result">
					<c:set var="result" value="${result }" scope="request"/>
					<c:set var="length" value="${result.prfPIncidental }"  scope="request"/>
					<c:forEach begin="1" end="${length }">
						<c:import url="/EgovPageLink.do?link=adm/admstr/prof/incRetirement"/>
					</c:forEach>
				</c:forEach>
			</c:when>
		</c:choose>
	</div>
</body>
</html>