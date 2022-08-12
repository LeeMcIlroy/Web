<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DASHBOARD :: 기후경영 도로관리시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=2, user-scalable=yes" />

<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/tmp/hg_common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/tmp/hg_style.css'/>" />

<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/tmp/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/tmp/hg_lib.js'/>"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/tmp/hg_common.js'/>"></script>

</head>

<body class="error">
	<div class="error_wrap">
		<div class="er_cts">
			<h2 class="tit">죄송합니다.<br /><span class="er_key">요청하신 페이지를</span> 찾을 수 없습니다.</h2>

			<p class="er_txt">
				존재하지 않는 주소를 입력하셨거나,<br />
				요청하신 페이지의 주소가 변경·삭제되어 찾을 수 없습니다.<br />
				입력하신 주소를 다시 한번 확인해주시기 바랍니다.
			</p>

			<div class="er_btn">
				<a href="#" onclick="javascript: history.back(-1); return false;" class="hgbtn green01">홈페이지 돌아가기</a>
			</div>
		</div>
	</div>


</body>
</html>