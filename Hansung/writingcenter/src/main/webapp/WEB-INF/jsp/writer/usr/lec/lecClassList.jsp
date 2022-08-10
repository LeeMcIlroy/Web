<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	// 조회
	function fn_select(clsSeq){
		$("#searchClass").val(clsSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecSubjectList.do'/>").submit();
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
			<c:forEach items="${smtrList }" var="smtr">
        		<c:if test="${smtr.choiceYn eq 'Y'}">
        			<c:set var="dept2" value="${smtr.smtrTitle }"/>
        			<c:set var="subTitle" value="${smtr.smtrContent }"/>
        		</c:if>
        	</c:forEach>
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의실"/>
            	<jsp:param name="dept2" value="${dept2 }"/>
            	<jsp:param name="subTitle" value="${subTitle }"/>
            </jsp:include>
			<div class="cont_box">
				<div class="mid_tit">나의 강의실</div>
				<div class="w_box02 mb50 tx_l">
					<c:if test="${empty myClsList }">지정된 강의실이 없습니다.</c:if>
					<c:if test="${!empty myClsList }">
						<c:forEach items="${myClsList }" var="myCls">
							<ul class="w_box02ul">
								<li>
									<a href="#" onclick="fn_select(<c:out value='${myCls.clsSeq }'/>); return false;">
										<c:out value="${fn:replace(myCls.clsTitle, '-', '<br/>') }" escapeXml="false"/>
									</a>
								</li>
							</ul>
						</c:forEach>
					</c:if>
				</div>
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
			</div>
			<!--// content -->
		</div>
		<!--// container -->
		<hr />
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!--// footer -->
	</div>
</div>
</form:form>
</body>
</html>