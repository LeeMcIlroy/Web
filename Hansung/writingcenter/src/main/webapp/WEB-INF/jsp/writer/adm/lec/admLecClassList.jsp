<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">
	// 조회
	function fn_select(clsSeq){
		$("#searchClass").val(clsSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecSubjectList.do'/>").submit();
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchSemester" />
<form:hidden path="searchClass" />
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!--// header -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<c:forEach items="${smtrList }" var="smtr">
        		<c:if test="${smtr.choiceYn eq 'Y'}"><c:set var="dept2" value="${smtr.smtrTitle }"/></c:if>
        	</c:forEach>
            <jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의실"/>
            	<jsp:param name="dept2" value="${dept2 }"/>
            </jsp:include>
			<!--// 타이틀 영역 -->
			
			<div class="cont_box mt20">
			<!-- content -->
				<c:forEach items="${deptList }" var="dept">
					<c:if test="${dept.clsCnt > 0 }">
						<div class="mid_tit"><c:out value="${dept.deptTitle }"/></div>	
						<div class="w_box02 mb50 tx_l">
							<c:forEach items="${clsList }" var="cls">
								<c:if test="${dept.deptSeq eq cls.deptSeq }">
									<ul class="w_box02ul">
										<li>
											<a href="#" onclick="fn_select(<c:out value='${cls.clsSeq }'/>); return false;">
												<c:out value="${fn:replace(cls.clsTitle, '-', '<br/>') }" escapeXml="false"/>
											</a>
										</li>
									</ul>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
				</c:forEach>
			<%--
				<div class="w_box02 mt20 tx_l">
					<c:forEach items="${clsList }" var="cls">
						<ul class="w_box02ul">
							<li>
								<a href="#" onclick="fn_select(<c:out value='${cls.clsSeq}'/>); return false;">
									<c:out value="${cls.deptTitle }"/>&nbsp;|&nbsp;<c:out value="${cls.clsTitle }"/>
								</a>
							</li>
						</ul>
					</c:forEach>
				</div>
			 --%>
			<!-- //content -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
</div>

<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>