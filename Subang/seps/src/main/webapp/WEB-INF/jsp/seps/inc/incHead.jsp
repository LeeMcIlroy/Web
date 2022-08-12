<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="format-detection" content="telephone=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=3, minimum-scale=1.0, user-scalable=yes" />
	<c:choose>
		<c:when test="${adminPage == 'Y' }">
			<link href="<c:out value='${pageContext.request.contextPath }/assets/css/common.css?v=201803272'/>" rel="stylesheet" type="text/css" />
			<link href="<c:out value='${pageContext.request.contextPath }/assets/css/menu.css'/>" rel="stylesheet" type="text/css" />
		</c:when>
		<c:when test="${adminPage == 'N' }">
			<link href="<c:out value='${pageContext.request.contextPath }/assets/css_usr/common.css?v=201805301'/>" rel="stylesheet" type="text/css" />
			<link href="<c:out value='${pageContext.request.contextPath }/assets/css_usr/menu.css'/>" rel="stylesheet" type="text/css" />
		</c:when>
	</c:choose>
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css" type="text/css" />
	<script src="http://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script>

	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/menu.js'/>" type="text/javascript"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/common.js?ver=20200826'/>" type="text/javascript"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/jquery.flexslider.js'/>" type="text/javascript"></script>
	<script src="<c:out value='${pageContext.request.contextPath }/assets/js/jquery.flexslider-min.js'/>" type="text/javascript"></script>	
	
	<!-- Google Fonts -->
	<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700|Lato:400,100,300,700,900' rel='stylesheet' type='text/css'>
	
	<script>	
		var userAgent = navigator.userAgent.toLowerCase(); // 접속 핸드폰 정보 
		//모바일 홈페이지 바로가기 링크 생성 
		if(userAgent.match('iphone')) { 
		 document.write('<link rel="apple-touch-icon" href="/assets/img/home_icon01.png" />')
		} else if(userAgent.match('ipad')) { 
		 document.write('<link rel="apple-touch-icon" sizes="72*72" href="/assets/img/home_icon02.png" />') 
		} else if(userAgent.match('ipod')) { 
		 document.write('<link rel="apple-touch-icon" href="/assets/img/home_icon03.png.png" />') 
		} else if(userAgent.match('android')) { 
		 document.write('<link rel="shortcut icon" href="/assets/img/home_icon01.png" />') 
		}
	</script>

	<title>:: 기후경영 도로관리정보시스템 ::</title>
	<!-- celldio 추가 -->
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/ckeditor_4.7.1_full/ckeditor.js'/>"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/seps_common.js?v=201806261'/>"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/seps_date.js'/>"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/js/jquery.fileDownload.js'/>"></script>
	
	<!-- c3 -->
	<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/c3/c3.css?v=201806261'/>" />
	<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/c3/c3.js'/>"></script>
	
</head>
<style>
/* 로딩*/
	#loading {height: 100%;left: 0px;position: fixed;_position:absolute;top: 0px;width: 100%;filter:alpha(opacity=50);-moz-opacity:0.5;opacity : 0.5;}
	.loading {background-color: white;z-index: 199;}
	#loading_img{position:absolute;top:50%;left:50%;z-index: 200;}
</style>
<script type="text/javascript">
$(function(){
	$(document).on("submit", "html", function(){
		fn_loading_on();
	});
});
function fn_loading_on(){
	var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="/assets/img/loading.gif" />');
	$("body").append(loading);
	$(".m_header").css("background-color", "white").css("z-index", "199");
	loading.show();
}
function fn_loading_off(){
	$(".m_header").css("background-color", "#2d343a").css("z-index", "999");
	$("#loading").remove();
	$("#loading_img").remove();
}
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<c:out value='${sessionScope.KAKAO_API_KEY }'/>"></script>

