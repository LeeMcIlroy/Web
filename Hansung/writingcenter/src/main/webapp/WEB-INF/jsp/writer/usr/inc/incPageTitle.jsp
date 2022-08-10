<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="page_tit"><c:out value="${param.dept2 }"/>
<c:if test="${!empty param.subTitle }"><span><c:out value="${param.subTitle }"/></span></c:if>
	<div class="navi">홈&nbsp;&nbsp;&gt;&nbsp;&nbsp;<c:out value="${param.dept1 }"/>&nbsp;&nbsp;&gt;&nbsp;&nbsp;<c:out value="${param.dept2 }"/></div>
</div>