<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<div class="n_main_content02" id="btmRollingBanner" style="visibility: hidden; background-color:#fafafa;">
	<div class="width_box">
		<div class="row_banner">
			<ul class="btmBxslider">
				<c:forEach items="${btmRollingBannerList }" var="btmRollingBanner">
					<li>
						<c:if test="${empty btmRollingBanner.banUrl }">
							<img src="<c:out value='/showImage.do?filePath=${btmRollingBanner.banImgPath }'/>" alt="<c:out value='${btmRollingBanner.banImgName }'/>" />
						</c:if>
						<c:if test="${!empty btmRollingBanner.banUrl }">
							<a href="<c:out value='${btmRollingBanner.banUrl }'/>" <c:if test="${btmRollingBanner.banNewWindow eq 'Y' }">target="_blank"</c:if>>
								<img src="<c:out value='/showImage.do?filePath=${btmRollingBanner.banImgPath }'/>" alt="<c:out value='${btmRollingBanner.banImgName }'/>" />
							</a>
						</c:if>
					</li>
				</c:forEach>
				<%--
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner01.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner02.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner03.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner04.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner05.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner06.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner07.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner09.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner10.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner11.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner12.jpg'/>" alt="" /></a></li>
				<li><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/row_banner13.jpg'/>" alt="" /></a></li>
				--%>
			</ul>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function(){
		btmSlider = $(".btmBxslider").bxSlider({
			controls : false
			, auto : true
			, speed : 300
			, pager : false
			, slideWidth: 90
			, maxSlides: 12
			, moveSlides: 1
			, slideMargin: 0
		});
	});
</script>