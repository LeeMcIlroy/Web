<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">
	<title>학사관리시스템</title>

	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" media="all" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/certipop.css?ver=1112_2'/>">

	<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/front.js?ver=20200817'/>"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/lcms_common.js'/>"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/comm_func.js'/>"></script>

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
</head>
<body onload="pageprint();">
	<div id="print-pop">
		<c:choose>
			<c:when test="${prtType eq 'CERTI' }">
				<c:forEach items="${resultList }" var="result">
					<c:set var="result" value="${result }" scope="request"/>
					<c:import url="/EgovPageLink.do?link=adm/admstr/certi/incCertificationBat"/>
				</c:forEach>
			</c:when>
			<c:when test="${prtType eq 'GRADE' }">
				<c:forEach items="${resultList }" var="result">
					<c:set var="result" value="${result }" scope="request"/>
					<c:import url="/EgovPageLink.do?link=adm/admstr/certi/incGradeCardBat"/>
				</c:forEach>
			</c:when>
			<c:when test="${prtType eq 'ALL' }">
				<c:forEach items="${resultList }" var="result">
					<c:set var="result" value="${result }" scope="request"/>
					<c:choose>
						<c:when test="${result.certiType eq '3' }">
							<c:import url="/EgovPageLink.do?link=adm/admstr/certi/incCertificationBat"/>
						</c:when>
						<c:when test="${result.certiType eq '2' }">
							<c:import url="/EgovPageLink.do?link=adm/admstr/certi/incGradeCardBat"/>
						</c:when>
					</c:choose>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${certiVO.certiType eq '1' }">
						<c:import url="/EgovPageLink.do?link=adm/admstr/certi/incStdShip"/>
					</c:when>
					<c:when test="${certiVO.certiType eq '2' }">
						<c:import url="/EgovPageLink.do?link=adm/admstr/certi/incGradeCard"/>
					</c:when>
					<c:when test="${certiVO.certiType eq '3' }">
						<c:import url="/EgovPageLink.do?link=adm/admstr/certi/incCertification"/>
					</c:when>
					<c:when test="${certiVO.certiType eq '4' }">
						<c:import url="/EgovPageLink.do?link=adm/admstr/certi/incTuition"/>
					</c:when>
					<c:when test="${certiVO.certiType eq '5' }">
						<c:import url="/EgovPageLink.do?link=adm/admstr/certi/incStdShipAll"/>
					</c:when>
					<c:when test="${certiVO.certiType eq '6' }">
						<c:import url="/EgovPageLink.do?link=adm/admstr/certi/incGradeCardAll"/>
					</c:when>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>