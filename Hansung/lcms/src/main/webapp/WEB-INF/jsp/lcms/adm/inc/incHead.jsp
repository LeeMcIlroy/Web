<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">
	<title>학사관리시스템</title>

	<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/style.css'/>">
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- Load c3.css -->
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath }/assets/c3-0.7.15/css/c3.css'/>">
	

	<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/front.js'/>"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/lcms_common.js'/>"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/comm_func.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/assets/ckeditor_4.7.1_full/ckeditor.js'/>"></script>
	<!-- datetimepicker -->
 	<script type="text/javascript"  src="<c:out value='${pageContext.request.contextPath }/assets/js/jquery-ui-timepicker-addon.js'/>"></script>
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/jquery-ui-timepicker-addon.css'/>">
	
	<!-- Load d3.js and c3.js -->
	<script src="<c:out value='${pageContext.request.contextPath }/assets/c3-0.7.15/js/d3-5.8.2.min.js'/>" charset="utf-8"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/c3-0.7.15/js/c3.min.js'/>"></script>
</head>