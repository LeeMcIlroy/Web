<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">

	$(function(){
		$(document).on("change", "#searchCondition1", function(){
			$("#pageIndex").val(1);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/webtoon/webtoonList.do'/>").submit();	
		});
	});

	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/webtoon/webtoonList.do'/>").submit();
	}
	
	// 조회
	function fn_select(wSeq){
		$("#wSeq").val(wSeq);
		$("#frm").attr("method", "get").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/webtoon/webtoonView.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="wSeq" name="wSeq">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
		<!-- header area -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
		<!-- //header area -->
		<div class="main_content" id="content">
			<div class="width_box">
				<!-- left menu area-->
				<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
				<!-- //left menu area-->
				<div class="sub_content">
					<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">
						<c:param name="dept1" value="캠퍼스생활"/>
						<c:param name="dept2" value="작품자료실"/>
						<c:param name="dept3" value="한툰()"/>
					</c:import>
					<%-- <div class="top_tab type_li2">
						<ul>
							<li <c:if test="${searchVO.menuType eq '0801' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/community/ucc/uccList.do'/>">동영상&amp;UCC</a></li>
							<li <c:if test="${searchVO.menuType eq '0802' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/webtoon/webtoonList.do'/>">한툰(한디원 웹툰)</a></li>
						</ul>
					</div> --%>
					<div class="list_sh">
						<ul>
							<li>
								<form:select path="searchCondition1">
									<form:option value="">전체</form:option>
									<form:options items="${webtoonCategory }" itemLabel="wcTitle" itemValue="wcSeq"/>
								</form:select>
							</li>
							<%--
							<li>
								<form:input path="searchWord"/>
							</li>
							<li>
								<a href="#" onclick="fn_list(1); return false">
									<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_sh.png'/>" alt="찾기" />
								</a>
							</li>
							--%>
						</ul>
					</div>
					<div class="mov_list_type">
						<c:forEach items="${resultList }" var="result">
							<dl onclick="fn_select(<c:out value='${result.wSeq }'/>); return false;" style="cursor: pointer;" >
								<dt>
									<img src="<c:out value='/showImage.do?filePath=${result.wThImgPath }'/>" alt="" style="width: 100%;"/>
								</dt>
								<dd>
									<a href="#">
										<p>
											[<c:out value="${result.wcTitle }"/>]
											<span style="color:#3c56a0;"><c:out value="${result.wOrder }"/>화</span>
											<c:out value="${result.wTitle}"/>
										</p>
									</a>
								</dd>
							</dl>
						</c:forEach>
					</div>
					<div class="pager">
						<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
					</div>
					<!-- rolling banner -->
					
					<!-- //rolling banner -->
				</div>
			</div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!-- //footer -->
	</div>
	<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>