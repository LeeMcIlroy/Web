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
	function fn_list(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#frm").attr("action","<c:out value='${pageContext.request.contextPath}/usr/main/searchList.do'/>").submit();
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" namr="frm">
<form:hidden path="pageIndex"/>
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
			<!-- content -->
			<div class="sub_content02">
				<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">					
					<c:param name="dept2" value="통합검색"/>
				</c:import>
				<div class="all_sh">
					<strong>Search</strong> <form:input path="searchWord" placeholder="검색어를 입력하세요" /> <a href="#" onclick="fn_list(1); return false;">검색</a>
				</div>
				<div class="sh_info">
					<strong><c:out value="${searchVO.searchWord }"/></strong> 에 관한 전체 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건의 검색 결과를 찾았습니다.
				</div>
				<div class="img_list_type">
					<c:forEach var="list" items="${resultList }">
						<c:choose>
							<c:when test="${list.boardCode eq 'MB' }">
								<c:if test="${list.boardType eq 'interior' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorView.do?mbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq 'visual' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualView.do?mbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq 'industrial' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialView.do?mbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq 'fassion' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionView.do?mbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq 'fbusiness' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessView.do?mbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq 'digitalArt' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtView.do?mbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq 'beauty' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyView.do?mbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq 'beautyOne' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneView.do?mbSeq=${list.seq }'/>" target="_blank">
								</c:if>
							</c:when>
							<c:otherwise >
								<c:if test="${list.boardType eq '0601' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/news/proud/proudView.do?cbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq '0602' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataView.do?cbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq '0603' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseasView.do?cbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq '0610' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/community/oveStud/oveStudView.do?cbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq '0611' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/community/oveServ/oveServView.do?cbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq '0701' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/news/festival/festivalView.do?cbSeq=${list.seq }'/>" target="_blank">
								</c:if>
								<c:if test="${list.boardType eq '0801' }">
									<a href="<c:out value='${pageContext.request.contextPath }/usr/news/ucc/uccView.do?cbSeq=${list.seq }'/>" target="_blank">
								</c:if>
							</c:otherwise>
						</c:choose>
							<ul <c:if test="${empty list.imgPath }">class="sum_img_none"</c:if>>
								<c:if test="${!empty list.imgPath }">
									<c:if test="${list.oldYn eq 'Y' }">
										<li><img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"'  src="<c:out value='/showOldImage.do?filePath=${list.imgPath}'/>" alt="<c:out value='${list.imgName }'/>" /></li>
									</c:if>
									<c:if test="${list.oldYn eq 'N' }">
										<c:if test="${fn:contains(list.imgPath,'/old/') }">
											<li><img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"' src="<c:out value='/showImage.do?filePath=${list.imgPath}'/>" alt="<c:out value='${list.imgName }'/>" /></li>
										</c:if>
										<c:if test="${!fn:contains(list.imgPath,'/old/') }">
											<li><img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"' src="<c:out value='/showImage.do?filePath=${fn:split(list.imgPath,".")[0]}_thumbnail.${fn:split(list.imgPath,".")[1]}'/>" alt="<c:out value='${list.imgName }'/>" /></li>
										</c:if>
										<%-- <img onerror='this.src="<c:out value='/assets/usr/img/no_img.jpg'/>"' src="<c:out value='/showImage.do?filePath=${fn:split(list.mbthImgPath,".")[0]}_thumbnail.${fn:split(list.mbthImgPath,".")[1]}'/>" alt="<c:out value='${list.mbthImgName }'/>" /> --%>
									</c:if>
								</c:if>
								<li>
									<dl>
										<dt>
											<div class="title"><c:out value="${list.title }"/></div>
											<div class="date"><c:out value="${list.regDate }"/></div>
										</dt>
										<dd>
											<c:if test="${fn:length(list.content) > 200 }">
												<c:out value="${fn:substring(list.content,0,200) }" escapeXml="false"/>...
											</c:if>
											<c:if test="${fn:length(list.content) <= 200 }">
												<c:out value="${list.content }" escapeXml="false"/>
											</c:if>
										</dd>
										<dd class="navi_link">
											<ul>
												<c:if test="${list.boardCode eq 'MB' }">
													<li>전공게시판</li>
												</c:if>
												<c:if test="${list.boardCode eq 'CB' }">
													<li>한디원행사</li>
												</c:if>
												<li><c:out value="${list.boardName }"/></li>
											</ul>									
										</dd>
									</dl>
								</li>
							</ul>
						</a>
					</c:forEach>
				</div>
				<div class="pager">
					<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list"/>
					<form:hidden path="pageIndex"/>						
				</div>
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
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>