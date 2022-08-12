<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<meta charset="utf-8">
<title>H&amp;Bio 관리자</title>
<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/ui/adm_common.css'/>">


<!-- 로그인화면과 관리자화면 충돌 -->
<!-- <link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/ui/common.css'/>">  -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href='fullcalendar/main.css' rel='stylesheet' />
<script src='fullcalendar/main.js'></script>

<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/jquery-1.7.1.min.js'/>"></script>
<!-- fullcalendar 태그 -->
<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/fullcalendar/packages/daygrid/main.css'/>">
<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/fullcalendar/packages/core/main.css'/>">
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/fullcalendar/packages/core/main.js'/>"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.0/moment.min.js" ></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/fullcalendar/packages/daygrid/main.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/fullcalendar/lib/locales/ko.js'/>"></script>


<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/jquery-ui.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/common.ui.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/comm_func.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/ctms_common.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/ctms_date.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/front.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/jquery.simple-sidebar.min.js'/>"></script>
<!-- 다움주소 검색용도 + front.js , adm_common.css에 pop관련 추가  2020.12.15 개발2-->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- CKEditor사용 -->
<script src="<c:out value='${pageContext.request.contextPath }/assets/ckeditor_4.7.1_full/ckeditor.js'/>"></script>


<!--[if lt IE 9]>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/html5.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/respond.min.js'/>"></script>
<![endif]-->
<!-- contextMenu사용 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.ui.position.js"></script>	
</head>