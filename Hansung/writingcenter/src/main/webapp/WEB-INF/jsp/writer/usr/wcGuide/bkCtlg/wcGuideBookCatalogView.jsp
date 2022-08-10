<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/wcGuide/bkCtlg/wcGuideBookCatalogList.do'/>").submit();
	}
</script>
<body>
<form:form commandName="bookcatalogVO" id="frm">
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<hr />
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="글쓰기 길잡이"/>
            	<jsp:param name="dept2" value="도서목록"/>
            </jsp:include>
			<div class="cont_box">
				<dl class="view_dl mb20">
					<dt><c:out value="${bookcatalogVO.ctlTitle }"/></dt>
					<dd class="font12">지은이 : <c:out value="${bookcatalogVO.regName }"/>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;출판사 : <c:out value="${bookcatalogVO.ctlPublisher }"/></dd>
					<dd class="view_dl_cont">
						<ul class="ta_ul03">
							<li>
								<c:choose>
									<c:when test="${!empty bookcatalogVO.ctlImgThumbPath }">
										<img src="<c:out value='${pageContext.request.contextPath }/showImage.do?filePath=${bookcatalogVO.ctlImgThumbPath }'/>" alt="<c:out value='${bookcatalogVO.ctlImgName }'/>" />
									</c:when>
									<c:when test="${empty bookcatalogVO.ctlImgThumbPath && !empty bookcatalogVO.ctlImgPath }">
										<img src="<c:out value='${pageContext.request.contextPath }/showImage.do?filePath=${bookcatalogVO.ctlImgPath }'/>" alt="<c:out value='${bookcatalogVO.ctlImgName }'/>" />
									</c:when>
									<c:otherwise>
										<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/noimg.gif'/>" alt="이미지를 준비중입니다" />
									</c:otherwise>
								</c:choose>
							</li>
							<li><c:out value="${bookcatalogVO.ctlContent }" escapeXml="false" /></li>
						</ul>
					</dd>
				</dl>
				<!-- 하단 영역 -->
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="btn_list" onclick="fn_list(); return false;">목록</a>
						</div>
					</div>
				</div>
				<!-- 하단 영역 -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" name="message" value="${message }"/>
<!-- 목록페이지 조건 -->
<input type="hidden" id="menuType" name="menuType" value="${searchVO.menuType }"/>
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>