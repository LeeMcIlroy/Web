<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="title_area">
	<h3>${param.dept2 }</h3>
	<div class="navi">
		<span><a href="/">Home</a> &gt; ${param.dept1 } &gt; ${param.dept2 }</span>
	</div>
</div>