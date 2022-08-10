<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>
	//목록
	function fn_goList(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/wcGuide/exclnt/wcGuideExclntList.do'/>").submit();
	}
	
	// 파일 다운로드
	function fn_download(type, upSeq){
		location.href = "<c:out value='${pageContext.request.contextPath }/cmmn/file/downloadFile.do'/>?type="+type+"&fileId="+upSeq;
	}
</script>
<body>
<form id="frm">
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
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
           		<jsp:param name="dept2" value="우수과제"/>
			</jsp:include>
			<div class="cont_box">
				<dl class="view_dl mb20">
					<dt><c:out value="${boardVO.brdTitle }"/></dt>
					<dd class="font12">글쓴이 : <c:out value="${boardVO.regName }"/>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;작성일 : <c:out value="${boardVO.regDate }"/></dd>
					<dd class="view_dl_cont">
						<c:out value="${boardVO.brdContent }" escapeXml="false"/>
					</dd>
					<c:if test="${empty upfileList }">
					</c:if>
					<c:if test="${!empty upfileList }">
					<dd class="font12">첨부파일 :
						<c:forEach var="list" items="${upfileList }" varStatus="cnt">
							<a href="#" onclick="fn_download('EXCLNT', <c:out value='${list.upSeq }'/>); return false;"><c:out value="${list.upOriginFileName }"/></a><c:if test="${cnt.last == false}">,&nbsp;</c:if>
						</c:forEach>
					</dd>
					</c:if>
				</dl>
				<!-- 하단 영역 -->
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="btn_list" onclick="fn_goList(); return false;">목록</a>
						</div>
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
</form>
</body>
</html>