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
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/ucc/uccList.do'/>").submit();
	}
	
	
	// 조회
	function fn_select(cbSeq){
		$("#cbSeq").val(cbSeq);
		
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/ucc/uccView.do'/>?cbSeq="+cbSeq).submit();
	}
	
	$("iframe").click(function(e){
		e.stopPropagation();
	});
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
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
						<c:param name="dept3" value="동영상&UCC"/>
					</c:import>
<!-- 					<div class="top_tab type_li2"> -->
<!-- 						<ul> -->
<%-- 							<li <c:if test="${searchVO.menuType eq '0801' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/community/ucc/uccList.do'/>">동영상&amp;UCC</a></li> --%>
<%-- 							<li <c:if test="${searchVO.menuType eq '0802' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/community/webtoon/webtoonList.do'/>">한툰(한디원 웹툰)</a></li> --%>
<!-- 						</ul> -->
<!-- 					</div> -->
					<%-- 
					<div class="list_sh">
						<ul>
							<li>
								<form:select path="searchCondition1">
									<form:option value="">전체</form:option>
									<form:option value="title">제목</form:option>
									<form:option value="writer">작성자</form:option>
								</form:select>
							</li>
							<li>
								<form:input path="searchWord"/>
							</li>
							<li>
								<a href="#" onclick="fn_list(1); return false">
									<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_sh.png'/>" alt="찾기" />
								</a>
							</li>
						</ul>
					</div>
					 --%>
					<div class="mov_list_type">
						<c:forEach var="list" items="${resultList }">
							<dl onclick="fn_select(<c:out value='${list.cbSeq }'/>); return false;"  >
								<dt>
									<c:set var="fileChk" value="0"/>
									<c:forEach items="${fileList }" var="cbUpfileList">
										<c:forEach items="${cbUpfileList }" var="cbUpfile">
											<c:if test="${cbUpfile.cbSeq eq list.cbSeq }">
												<c:set var="fileChk" value="${fileChk + 1 }"/>
												<video width="100%" height="250" controls>
													<source src='<c:out value='${pageContext.request.contextPath }'/>/showVideo.do?filePath=<c:url value="${cbUpfile.cbupSaveFilepath }"/>' type="video/mp4">
												</video>
											</c:if>
										</c:forEach>
									</c:forEach>
									<c:if test="${fileChk == 0 }">
										<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'youtu')}">
											<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'https:')}">
												<iframe src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"https://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen></iframe>
											</c:if>
											<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'http:')}">
												<iframe src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"http://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen></iframe>
											</c:if>
										</c:if>
										<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'/vimeo')}">
											<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'https:')}">
												<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"https://vimeo.com/","")) }'/>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
											</c:if>
											<c:if test="${fn:containsIgnoreCase(list.cbThUrl,'http:')}">
												<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.cbThUrl,"http://vimeo.com/","")) }'/>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
											</c:if>
										</c:if>
									</c:if>
								</dt>
								<dd>
									<a href="#">
										<p>
											<c:out value="${list.cbTitle }"/>
										</p>
										<div>
											<c:if test="${fn:length(list.cbContent) > 200 }">
												<c:out value="${fn:substring(list.cbContent,0,200) }" escapeXml="false"/>...
											</c:if>
											<c:if test="${fn:length(list.cbContent) <= 200 }">
												<c:out value="${list.cbContent }" escapeXml="false"/>
											</c:if>
										</div>
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