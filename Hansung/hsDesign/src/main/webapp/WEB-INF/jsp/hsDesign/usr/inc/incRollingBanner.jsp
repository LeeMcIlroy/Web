<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="left_rolling_banner">
	<ul>
		<c:forEach var="list" items="${bannerList }">
			<li>
				<a href="<c:url value='${list.banUrl }'/>" <c:if test="${list.banNewWindow eq 'Y' }"> target="_blank" </c:if> >
					<img src="<c:out value='/showImage.do?filePath=${list.banImgPath }'/>" alt="<c:out value='${list.banName }'/>" />
				</a>
			</li>
		</c:forEach>
	</ul>
</div> --%>