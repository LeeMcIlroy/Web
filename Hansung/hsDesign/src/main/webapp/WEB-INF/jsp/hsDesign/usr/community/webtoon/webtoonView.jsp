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
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/webtoon/webtoonList.do'/>").submit();
	}

	// 조회
	function fn_select(wSeq){
		$("#wSeq").val(wSeq);
		$("#frm").attr("method","get").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/webtoon/webtoonView.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="wSeq" name="wSeq">
<form:hidden path="pageIndex"/>
<form:hidden path="menuType"/>
<form:hidden path="searchCondition1"/>
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
			<!-- content -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="커뮤니티"/>
		            <jsp:param name="dept2" value="웹툰&동영상"/>
	           	</jsp:include>
	           	<div id="viewPage">
					<div class="transform_table notice_type">
						<div class="tbl_view">
							<ul class="tbl_view_m title">
								<li class="txt_left">
									[<c:out value="${resultVO.wcTitle }"/>]
									<span style="color:#3c56a0;"><c:out value="${resultVO.wOrder }"/>화</span>
									<c:out value="${resultVO.wTitle }" escapeXml="false"/>
								</li>
								<li>작성자 : <c:out value="${resultVO.regName }"/></li>
								<li><c:out value="${resultVO.regDate }"/></li>
								<li><c:out value="${resultVO.wCount }"/></li>
							</ul>
							<div class="tbl_cont">
								<c:out value="${resultVO.wContent }" escapeXml="false" />
							</div>
						</div>
					</div>
					<div class="btn_box">
						<c:if test="${!empty resultVO.beforeWSeq }">
							<a href="#" class="btn_go_del" onclick="fn_select(<c:out value='${resultVO.beforeWSeq }'/>); return false;">이전화</a>
						</c:if>
						<a href="#" class="btn_go_list" onclick="fn_list(); return false;">목록</a>
						<c:if test="${!empty resultVO.afterWSeq }">
							<a href="#" class="btn_go_del" onclick="fn_select(<c:out value='${resultVO.afterWSeq }'/>); return false;">다음화</a>
						</c:if>
					</div>
				</div>
				<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
			</div>
			<!--// content -->
		</div>
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