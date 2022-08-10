<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.cmm.util.EgovUserDetailsHelper" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/wcGuide/tips/wcGuideTipsList.do'/>").submit();
	}
	
	// 파일 다운로드
	function fn_download(type, upSeq){
	<% if(EgovUserDetailsHelper.isAuthenticatedUser()){ %>
		location.href = "<c:out value='${pageContext.request.contextPath }/cmmn/file/downloadFile.do'/>?type="+type+"&fileId="+upSeq;
	<% }else{ %>
		alert('로그인후 다운로드가 가능합니다.');
	<% } %>
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
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
            	<jsp:param name="dept2" value="라이팅팁스"/>
            </jsp:include>
			<div class="cont_box">
				<div class="sh_box">
					<div class="sh_l_box">
						게시물 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건
					</div>
					<div class="sh_r_box">
						<form:select path="searchCondition" class="w100">
							<form:option value="title">주제</form:option>
							<form:option value="content">내용</form:option>
						</form:select>
						<form:input path="searchWord" class="w200" />
						<a href="#" class="sh_btn" onclick="fn_list(1); return false;">검색</a>
					</div>
				</div>
				<div class="tips_box">
					<c:forEach items="${resultList }" var="result">
						<div class="tips_s_box">
							<dl>
								<dt><img src="<c:out value='${pageContext.request.contextPath }/showImage.do?filePath=${result.tipImgThumbPath }'/>" /></dt>
								<dd>
									<dl>
										<dt><c:out value="${result.tipTitle }"/></dt>
										<dd>발행일:&nbsp;<c:out value="${result.tipPublicDate }"/></dd>
									</dl>
									<dl class="list" style="max-height: 150px;overflow-y: auto;">
										<dt>&lt;내용&gt;</dt>
										<dd><c:out value="${result.tipContent }" escapeXml="false"/></dd>
									</dl>
									<c:if test="${!empty result.tipFileName }">
									<a href="#" class="pdf_down" onclick="fn_download('WRITINGTIPS', <c:out value='${result.tipSeq }'/>); return false;">PDF 다운로드</a>
									</c:if>
								</dd>
							</dl>
						</div>
					</c:forEach>
				<%--
					<div class="tips_s_box">
						<dl>
							<dt><img src="../img/tips_eximg.jpg" alt="인과적 글쓰기" /></dt>
							<dd>
								<dl>
									<dt>인과적 글쓰기</dt>
									<dd>발행일: 2016년 08월 31일</dd>
								</dl>
								<dl class="list">
									<dt>&lt;목차&gt;</dt>
									<dd>인과란 무엇인가<br>인과의 과정과 전략<br>인과적 연결의 예시</dd>
								</dl>
								<a href="#" class="pdf_down">PDF 다운로드</a>
							</dd>
						</dl>
					</div>
			 	--%>
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