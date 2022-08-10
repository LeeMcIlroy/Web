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
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtList.do'/>").submit();
	}

	// 조회
	function fn_select(mbSeq){
		$("#mbSeq").val(mbSeq);
		$("#frm").attr("method", "get").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtView.do'/>").submit();
	}
	
	$("iframe").click(function(e){
		e.stopPropagation();
	});
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="pageIndex"/>
<form:hidden path="searchType"/>
<input type="hidden" id="menuNo" name="menuNo" value="${sessionScope.menuNo }">
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
			<!-- content -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle2.jsp">
					<jsp:param name="dept1" value="일학습엘리트과정"/>
		            <jsp:param name="dept2" value="성우콘텐츠크리에이터"/>
		            <jsp:param name="dept3" value="${menuName }"/>
	           	</jsp:include>
	           	<!-- 검색시작 -->
	            <div class="list_sh">
					<ul>
						<li>
							<form:select path="searchCondition3">
								<form:option value="">전체</form:option>
								<c:forEach var="list" items="${menuList }">
									<form:option value="${list.bcSeq }"><c:out value="${list.bcName }"/></form:option>
								</c:forEach>
							</form:select>
						</li>
						<li>
							<form:select path="searchCondition2">
								<form:option value="title">제목</form:option>
								<form:option value="content">내용</form:option>
							</form:select>
						</li>
						<li>
							<form:input path="searchWord" />
						</li>
						<li>
							<a href="#" onclick="fn_list(1); return false;"><img src="<c:out value='${pageContext.request.contextPath  }/assets/usr/img/icon_sh.png'/>" alt="찾기" /></a>
						</li>
					</ul>
				</div>
				<!-- 검색 끝 -->
				<div class="img_list_type">
				<!-- content -->
				<c:if test="${empty resultList }">
					<div style="margin:0px auto; text-align: center; font-size: 20px;">등록된 게시글이 없습니다.</div>
				</c:if>
				<c:if test="${!empty resultList }">
					<c:forEach var="list" items="${resultList }">
						<a href="#" onclick="fn_select(<c:out value='${list.mbSeq }'/>); return false;" >
							<ul>
								<li>
									<c:if test="${list.mbthType eq 'IMAGE' }">
										<c:if test="${list.mbOldYn eq 'Y' }">
											<img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"'  src="<c:out value='/showOldImage.do?filePath=${list.mbthImgPath}'/>" alt="<c:out value='${list.mbthImgName }'/>" />
										</c:if>
										<c:if test="${list.mbOldYn eq 'N' }">
											<img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"'   src="<c:out value='/showImage.do?filePath=${fn:split(list.mbthImgPath,".")[0]}_thumbnail.${fn:split(list.mbthImgPath,".")[1]}'/>" alt="<c:out value='${list.mbthImgName }'/>" />
										</c:if>
									</c:if>
									<c:if test="${list.mbthType eq 'VIDEO' }">
										<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'youtu')}">
											<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'https:')}">
												<iframe src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"https://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen></iframe>
											</c:if>
											<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'http:')}">
												<iframe src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"http://youtu.be/","")) }'/>?rel=0&vq=hd720" frameborder="0" allowfullscreen></iframe>
											</c:if>
										</c:if>
										<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'/vimeo')}">
											<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'https:')}">
												<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"https://vimeo.com/","")) }'/>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
											</c:if>
											<c:if test="${fn:containsIgnoreCase(list.mbthUrl,'http:')}">
												<iframe src="https://player.vimeo.com/video/<c:out value='${fn:trim(fn:replace(list.mbthUrl,"http://vimeo.com/","")) }'/>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
											</c:if>
										</c:if>
									</c:if>
									<c:if test="${list.mbthType eq '' || list.mbthType eq null}">
										<img style="width:291px; height:80%;" src="<c:out value='/assets/usr/img/no_img.jpg'/>" alt="한디원" />
									</c:if>
								</li>
								<li>
									<dl>
										<dt>
											<div class="title">
												<c:if test="${!empty list.mbGubun2Name }">
													<div class="ticon_type01">
															<c:out value="${list.mbGubun2Name }"/>
													</div> 
												</c:if>	
												<c:out value="${list.mbTitle }" escapeXml="false"/>
											</div>
											<div class="date"><c:out value="${list.mbRegDate }"/> | <c:out value="${list.mbCount}"/></div>
										</dt>
										<dd>
											<c:if test="${fn:length(list.mbContent) > 200 }">
												<c:out value="${fn:substring(list.mbContent,0,200) }" escapeXml="false"/>...
											</c:if>
											<c:if test="${fn:length(list.mbContent) <= 200 }">
												<c:out value="${list.mbContent }" escapeXml="false"/>
											</c:if>
										</dd>
									</dl>
								</li>
							</ul>
						</a>
					</c:forEach>
				</c:if>
					<div class="pager">
						<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
					</div>
	
					<!-- rolling banner -->
					<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
					<!-- //rolling banner -->
				<!-- //content -->
				</div>
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