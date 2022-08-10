<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="title-area">
	<p class="page-lv01">${param.dept2 }</p>
	<div class="navi">
		<span class="icon-home">Home</span>
		<c:if test="${!empty param.dept1 }">
			<span>${param.dept1 }</span>
		</c:if>
		<span>${param.dept2 }</span>
	</div>
</div>