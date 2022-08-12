<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="title_area">
	<h3>${param.dept2 }</h3>
	<!-- 현재위치 -->
	<div class="breadcrumb">
		<a href="#">홈</a>
		<span>&gt;</span>
		${param.dept1 }
		<span>&gt;</span>
		${param.dept2 }
	</div>
</div>