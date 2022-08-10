<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">
	<title>한성대학교 | 언어교육센터 한국어교육과정</title>
	
	<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/usr/css/style.css'/>">
	<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/usr/css/layout.css'/>">
	<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/usr/css/mobile-layout.css'/>">
	<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/usr/css/popStyle.css'/>">
	<link rel="shortcut icon" href="<c:out value='${pageContext.request.contextPath }/assets/img/favicon.ico'/>">
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	 <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/front.js'/>"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/lcms_common.js'/>"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/comm_func.js'/>"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/ckeditor_4.7.1_full/ckeditor.js'/>"></script>

	<script type="text/javascript">
		$(function(){
			var opemSem = '<c:out value="${openSem.semYear }"/>'+'<c:out value="${openSem.semester }"/>';
			var semester = '<c:out value="${semester.semYear }"/>'+'<c:out value="${semester.semester }"/>';
			
			if(opemSem != semester){
				$(".sem-chk").addClass('dpn');
			}
		});
	</script>
</head>