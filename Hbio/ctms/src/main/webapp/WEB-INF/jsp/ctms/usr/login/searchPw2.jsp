<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
</head>
<body>
<!-- wrap -->
<div class="com_wrap">
	<h1>H&amp;Bio</h1>
	<div class="com_top">
		<h2>비밀번호 찾기</h2>
		하단정보를 입력 후 비밀번호 찾기를 클릭하세요.
	</div>
	<!-- 정보입력 -->
	<div class="com_reg">
		<input type="text" placeholder="아이디(이메일주소)" id="user_id" />
		<p>
			<input type="text" placeholder="핸드폰 번호" id="user_phone" />
			<a href="#">인증코드발송</a>
		</p>		
		<input type="text" placeholder="인증번호" id="cert_num" />
		<div>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/login/joinMem.do'/>">회원가입</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/login/searchId.do'/>">아이디 찾기</a></li>
			</ul>
		</div>
		<a href="#">비밀번호 찾기</a>
	</div>
	<!-- //정보입력 -->
</div>
<!-- //wrap -->
</body>
</html>

