<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>
//타입에 따른 목록	
function fn_view(type){
	$("#searchType").val(type);
	$("#pageIndex").val(1);
	$("#searchWord").val("");
	$("#menuType").val("");
	$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/wcGuide/bkCtlg/wcGuideBookCatalogList.do'/>").submit();
	
}

//페이징에 따른 목록
function fn_list(pageNo){
	$("#pageIndex").val(pageNo);
	$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/wcGuide/bkCtlg/wcGuideBookCatalogList.do'/>").submit();
}

//초성에 따른 목록
function fn_list_char(menuType){
	$("#pageIndex").val(1);
	$("#menuType").val(menuType);
	$("#searchWord").val("");
	$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/wcGuide/bkCtlg/wcGuideBookCatalogList.do'/>").submit();
}


//조회
function fn_select(ctlSeq){
	$("#ctlSeq").val(ctlSeq);
	$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/wcGuide/bkCtlg/wcGuideBookCatalogView.do'/>").submit();
}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchType" />
<form:hidden path="menuType" />
<input type="hidden" id="ctlSeq" name="ctlSeq"/>
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
				<div class="tab li02 mb20">
					<ul>
						<li><a href="#" onclick="fn_view('NORMAL'); return false;" <c:if test="${searchVO.searchType eq 'NORMAL' }"> class="active" </c:if> >서가목록</a></li>
						<li><a href="#" onclick="fn_view('RECOMMAND'); return false;" <c:if test="${searchVO.searchType eq 'RECOMMAND' }"> class="active" </c:if> >추천도서</a></li>
					</ul>
				</div>
				<div class="tab02 mb20">
					<ul>
						<li><a href="#" onclick="fn_list_char('0'); return false;" <c:if test="${searchVO.menuType == 0}"> class="active" </c:if>>전체</a></li>
						<li><a href="#" onclick="fn_list_char('1'); return false;" <c:if test="${searchVO.menuType == 1}"> class="active" </c:if>>ㄱ</a></li>
						<li><a href="#" onclick="fn_list_char('2'); return false;" <c:if test="${searchVO.menuType == 2}"> class="active" </c:if>>ㄴ</a></li>
						<li><a href="#" onclick="fn_list_char('3'); return false;" <c:if test="${searchVO.menuType == 3}"> class="active" </c:if>>ㄷ</a></li>
						<li><a href="#" onclick="fn_list_char('4'); return false;" <c:if test="${searchVO.menuType == 4}"> class="active" </c:if>>ㄹ</a></li>
						<li><a href="#" onclick="fn_list_char('5'); return false;" <c:if test="${searchVO.menuType == 5}"> class="active" </c:if>>ㅁ</a></li>
						<li><a href="#" onclick="fn_list_char('6'); return false;" <c:if test="${searchVO.menuType == 6}"> class="active" </c:if>>ㅂ</a></li>
						<li><a href="#" onclick="fn_list_char('7'); return false;" <c:if test="${searchVO.menuType == 7}"> class="active" </c:if>>ㅅ</a></li>
						<li><a href="#" onclick="fn_list_char('8'); return false;" <c:if test="${searchVO.menuType == 8}"> class="active" </c:if>>ㅇ</a></li>
						<li><a href="#" onclick="fn_list_char('9'); return false;" <c:if test="${searchVO.menuType == 9}"> class="active" </c:if>>ㅈ</a></li>
						<li><a href="#" onclick="fn_list_char('10'); return false;" <c:if test="${searchVO.menuType == 10}"> class="active" </c:if>>ㅊ</a></li>
						<li><a href="#" onclick="fn_list_char('11'); return false;" <c:if test="${searchVO.menuType == 11}"> class="active" </c:if>>ㅋ</a></li>
						<li><a href="#" onclick="fn_list_char('12'); return false;" <c:if test="${searchVO.menuType == 12}"> class="active" </c:if>>ㅌ</a></li>
						<li><a href="#" onclick="fn_list_char('13'); return false;" <c:if test="${searchVO.menuType == 13}"> class="active" </c:if>>ㅍ</a></li>
						<li><a href="#" onclick="fn_list_char('14'); return false;" <c:if test="${searchVO.menuType == 14}"> class="active" </c:if>>ㅎ</a></li>
						<li><a href="#" onclick="fn_list_char('15'); return false;" <c:if test="${searchVO.menuType == 15}"> class="active" </c:if>>A~Z</a></li>
					</ul>
				</div>
				<div class="sh_box">
					<div class="sh_l_box">
						게시물 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건
					</div>
					<div class="sh_r_box">
						<form:select path="searchCondition" class="w100">
							<form:option value="title">제목</form:option>
							<form:option value="content">내용</form:option>
						</form:select>
						<form:input path="searchWord" class="w200" onkeydown="" />
						<a href="#" onclick="fn_list(1); return false;" class="sh_btn">검색</a>
					</div>
				</div>
				<div class="tips_box">
					<c:forEach var="list"  items="${resultList }">
						<div class="book_s_box">
							<dl>
								<dt>
									<a href="#" onclick="fn_select(${list.ctlSeq}); return false;">
										<c:choose>
											<c:when test="${!empty list.ctlImgThumbPath }">
												<img src="<c:out value='${pageContext.request.contextPath }/showImage.do?filePath=${list.ctlImgThumbPath }'/>" alt="<c:out value='${list.ctlImgName }'/>" />
											</c:when>
											<c:when test="${empty list.ctlImgThumbPath && !empty list.ctlImgPath }">
												<img src="<c:out value='${pageContext.request.contextPath }/showImage.do?filePath=${list.ctlImgPath }'/>" alt="<c:out value='${list.ctlImgName }'/>" />
											</c:when>
											<c:otherwise>
												<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/noimg.gif'/>" alt="이미지를 준비중입니다" />
											</c:otherwise>
										</c:choose>
									</a>
								</dt>
								<dd>
									<dl>
										<dt><c:out value="${list.ctlTitle }"/></dt>
										<dd><c:out value="${list.ctlWriter }"/></dd>
										<dd><c:out value="${list.ctlPublisher }"/></dd>
									</dl>
								</dd>
							</dl>
						</div>
					</c:forEach>
				</div>
				<!-- 하단 영역 -->
				<div class="btm_area">
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image2" jsFunction="fn_list" />
						<form:hidden path="pageIndex" />
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
</form:form>
</body>
</html>