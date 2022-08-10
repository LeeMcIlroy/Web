<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sub_top_area">
	<c:if test="${empty param.dept3 || param.dept3 eq ''}">
		<div class="sub_title">${param.dept2 }</div>
	</c:if>
	<c:if test="${!empty param.dept3 || param.dept3 ne ''}">
		<div class="sub_title">${param.dept3 }</div>
	</c:if>
	
	<div class="page_navi">
		<span><a href="#">Home</a> <c:if test="${!empty param.dept1 }">&gt; ${param.dept1 }</c:if> &gt; ${param.dept2 }</span>
		<c:if test="${!empty param.dept3}">
			&gt; ${param.dept3 }
		</c:if>
	</div>
</div>