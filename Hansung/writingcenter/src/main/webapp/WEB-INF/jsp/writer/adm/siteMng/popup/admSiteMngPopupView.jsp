<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<div class="pop_wrap">
	<div class="pop_cont02">
		<div class="pop_txt02">
			<c:out value="${popupVO.popContent }" escapeXml="false"/>
			<div class="pop_txt03">
				<span>(02-760-4354)</span>이나 <span>Q&amp;A 게시판</span>에 문의바랍니다
			</div>
		</div>
	</div>
	<div class="pop_foot">
		<ul>
			<li><input type="checkbox" name="" id="day_close" /> <label for="day_close">하루 창 열지 않기</label> </li>
			<li><a href="#" onclick="javascript: window.close();">닫기</a></li>
		</ul>
	</div>
</div>
<style>
	a {color: blue; font-weight: bold;}
</style>
</body>
</html>