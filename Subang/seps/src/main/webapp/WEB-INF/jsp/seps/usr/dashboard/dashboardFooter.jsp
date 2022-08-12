<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
	$(function(){
		var paldang ='${paldang }';		
		var paldang2 =	Math.round(paldang * 100) / 100;

		document.getElementById("paldang").innerHTML = paldang2;
	})
		
	
</script>
<div class="end_info<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '30') > -1 }"> line_type</c:if>">
	<div>
		<ul>
			<li>
				<p>한강대교수위</p>
				<c:out value="${hangang }"/>m
			</li>
		</ul>
	</div>
	<div>
		<ul>
			<li>
				<p>팔당댐방류량</p>
 				<span id="paldang"></span>㎥/s	
<%--  				<c:out value="${paldang }"/>㎥/s		 --%>
			</li>
		</ul>
	</div>
</div>
<script type="text/javascript">
	// 종합상황판&동부간선도로&올림픽대로 setInterval - start
	setInterval(function() { location.reload(); }, 1000*60*10);
	// 종합상황판&동부간선도로&올림픽대로 setInterval - end
</script>