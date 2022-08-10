<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	// 수정
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogModify.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(){
		if(confirm("정말 삭제하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogDelete.do'/>").submit();
		}
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogList.do'/>").submit();
	}
</script>
<body>
<form:form commandName="bookcatalogVO" id="frm" name="frm">
<form:hidden path="ctlSeq" />
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
			<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="글쓰기 길잡이"/>
            	<jsp:param name="dept2" value="도서목록"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<table class="view_tbl_03 mb30 mt30" summary="도서목록">
					<caption>도서목록</caption>
					<tbody>
						<tr class="first">
							<th class="tit" colspan="2"><c:out value="${bookcatalogVO.ctlTitle }"/></th>
						</tr>
						<tr>
							<td colspan="2">지은이 : <c:out value="${bookcatalogVO.ctlWriter }"/> | 출판사 : <c:out value="${bookcatalogVO.ctlPublisher }"/></td>
						</tr>
						<tr>
							<td>
								<ul class="ta_ul03">
									<li>
										<c:choose>
											<c:when test="${!empty bookcatalogVO.ctlImgThumbPath }">
												<img src="<c:url value='/showImage.do?filePath=${bookcatalogVO.ctlImgThumbPath }'/>"/>
											</c:when>
											<c:when test="${empty bookcatalogVO.ctlImgThumbPath && !empty bookcatalogVO.ctlImgPath }">
												<img src="<c:url value='/showImage.do?filePath=${bookcatalogVO.ctlImgPath }'/>"/>
											</c:when>
											<c:otherwise>
												<img src="<c:url value='/assets/adm/img/noimg.gif'/>" alt="이미지를 준비중입니다" />
											</c:otherwise>
										</c:choose>
									</li>
									<li><c:out value="${bookcatalogVO.ctlContent }" escapeXml="false"/></li>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type01" onclick="fn_modify(); return false;">수정</a>
							<a href="#" class="b_type02" onclick="fn_delete(); return false;">삭제</a>
							<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
						</div>
					</div>
				</div>
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
<!-- 목록페이지 조건 -->
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>