<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<title>한성대학교 글쓰기 센터</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/usr/css/common.css?version=20210312'/>" />
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/jquery/jquery-3.3.1.min.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/jquery/jquery-ui-1.12.1.min.js'/>"></script>
<!-- celldio 추가 -->
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/hswc_common.js?v=20200427'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/hswc_date.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/ckeditor_4.5.9_full/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/ui.js'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/usr/fullcalendar/fullcalendar.min.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/usr/fullcalendar/fullcalendar.print.min.css'/>" media="print" />
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/fullcalendar/lib/moment.min.js'/>"></script>
<%--
	190910 김현영 이것 때문에 달력 작동 안됬었음.
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/fullcalendar/lib/jquery.min.js'/>"></script>
--%>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/fullcalendar/fullcalendar.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/fullcalendar/locale-all.js'/>"></script>


</head>
