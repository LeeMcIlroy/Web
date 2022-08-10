<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	function fn_list(searchType){
		$("#searchType").val(searchType);
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/majorBoard/beauty/majorBeautyTeacherList.do'/>").submit();
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="pageIndex"/>
<form:hidden path="searchType"/>
<form:hidden path="menuType"/>
<form:hidden path="searchCondition2"/>
<form:hidden path="searchWord"/>
<input type="hidden" id="mbSeq" name="mbSeq">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<!-- container -->
	<div class="main_content" id="content">
		<div class="width_box">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
			<!--// lnb -->
		</div>
		<!-- content -->
		<div class="sub_content">
			<!-- 타이틀 영역 -->
			<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle2.jsp">
				<jsp:param name="dept1" value="전공"/>
	            <jsp:param name="dept2" value="미용학"/>
	            <jsp:param name="dept3" value="교수소개"/>
           	</jsp:include>
			<div class="top_tab type_li5">
				<ul>
					<li <c:if test="${empty searchVO.searchType }"> class="active" </c:if>><a href="#" onclick="fn_list(); return false;">ALL</a></li>
					<li <c:if test="${searchVO.searchType eq '헤어디자인' }"> class="active" </c:if>><a href="#" onclick="fn_list('헤어디자인'); return false;">헤어디자인</a></li>
					<li <c:if test="${searchVO.searchType eq '메이크업디자인' }"> class="active" </c:if>><a href="#" onclick="fn_list('메이크업디자인'); return false;">메이크업디자인</a></li>
					<li <c:if test="${searchVO.searchType eq '네일디자인' }"> class="active" </c:if>><a href="#" onclick="fn_list('네일디자인'); return false;">네일디자인</a></li>
					<li <c:if test="${searchVO.searchType eq '피부디자인' }"> class="active" </c:if>><a href="#" onclick="fn_list('피부디자인'); return false;">피부디자인</a></li>
				</ul>
			</div>
			<div class="pro_info">
				<c:forEach var="result" items="${resultList }">
					<dl>
						<dt><img src="<c:out value='/showImage.do?filePath=${result.tcupSaveFilepath }'/>" alt="<c:out value='${result.tcupOriginFilename }'/>" /></dt>
						<dd>
							<div class="pro_info_txt">
								<div><c:out value="${result.tcName }"/></div>
								<c:out value="${result.tcContent }" escapeXml="false"/>
							</div>
						</dd>
					</dl>
				</c:forEach>
			</div>
			<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>