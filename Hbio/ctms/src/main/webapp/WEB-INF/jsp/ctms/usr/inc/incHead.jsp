<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<meta charset="utf-8">
<meta name="format-detection" content="telephone=no, address=no, email=no">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>H&amp;Bio 피부임상연구센터</title>
<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/usr/css/ui/common.css'/>">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/jquery-1.7.1.min.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/common.ui.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/comm_func.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/ctms_common.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/ctms_date.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/front.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/jquery.ezmark.min.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/jquery.simple-sidebar.min.js'/>"></script>

<!-- 다움주소 검색용도 + front.js , adm_common.css에 pop관련 추가  2020.12.15 개발2-->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- CKEditor사용 -->
<script src="<c:out value='${pageContext.request.contextPath }/assets/ckeditor_4.7.1_full/ckeditor.js'/>"></script>

<!--[if lt IE 9]>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/html5.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/respond.min.js'/>"></script>
<![endif]-->

</head>
