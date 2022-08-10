<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html >
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<div class="pop_wrap">	
	<%-- <c:out value="${popupVO.popContent }" escapeXml="false"/> --%>
<%-- 	<c:if test="${!empty popupVO.popUrl }">
		
			<a href="${popupVO.popUrl }" target="_blank">
				<img src="<c:out value='/showImage.do?filePath=${popupVO.popImgPath}'/>" alt="<c:out value='${popupVO.popImgName }'/>" style="width:100%;"/>			
			</a>
		
	</c:if> --%>
	<c:if test="${popupVO.popUrl eq 'http'}">
			<script>
		
			window.open("${pageContext.request.contextPath }/html/test.html", "new", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=700, height=700, left=0, top=0" );
			</script>
		</c:if>
	
	<c:if test="${empty popupVO.popUrl }">
		<img src="<c:out value='/showImage.do?filePath=${popupVO.popImgPath}'/>" alt="<c:out value='${popupVO.popImgName }'/>" style="width:100%;"/>
	</c:if>
	
	<div class="pop_foot" style="position: relative;">
		<ul>
			<li><input type="checkbox" name="" id="day_close" /> <label for="day_close">하루 창 열지 않기</label> </li>
			<li><a href="#" onclick="javascript: window.close();">닫기</a></li>
		</ul>
	</div>
</div>
<script>


</script>
</body>
</html>