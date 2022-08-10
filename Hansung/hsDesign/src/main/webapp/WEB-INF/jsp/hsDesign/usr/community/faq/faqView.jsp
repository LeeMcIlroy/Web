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
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/community/faq/faqList.do'/>").submit();
	}

	
	// 파일 다운로드
	function fn_filedownload(cbupSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+cbupSeq+"&type="+type;
	}
	
	
</script>
<body>
<form:form commandName="cmmBoardVO" id="frm" name="frm">
<form:hidden path="cbSeq"/>
<input type="hidden" id="cbcoSeq" name="cbcoSeq" />

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
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="학사안내"/>
		            <jsp:param name="dept2" value="학사FAQ"/>
	           	</jsp:include>
				<div class="transform_table notice_type">
					<div class="tbl_view">
						<ul class="tbl_view_m">
							<li class="txt_left"><c:out value="${cmmBoardVO.cbTitle }" escapeXml="false"/></li>
							<li>작성자 : <c:out value="${cmmBoardVO.regName }"/></li>
							<li><c:out value="${cmmBoardVO.cbRegDate }"/></li>
							<li><c:out value="${cmmBoardVO.cbCount }"/></li>
						</ul>
						<div class="tbl_cont">
							<c:out value="${cmmBoardVO.cbContent }" escapeXml="false"/>
						</div>
						<c:if test="${!empty cbUpfileList }">
							<ul class="tbl_file">
								<li>첨부파일</li>
								<li>
									<c:forEach items="${cbUpfileList }" var="cbUpfile">
										<a href="#" onclick="fn_filedownload(<c:out value='${cbUpfile.cbupSeq }'/>, 'CMMBOARD'); return false;">
											<c:out value="${cbUpfile.cbupOriginFilename }"/>
										</a>
									</c:forEach>
								</li>
							</ul>
						</c:if>
					</div>
				</div>
				
				<div class="btn_box">
					<a href="#" class="btn_go_list" onclick="fn_list(); return false;">목록</a>
				</div>
				<!-- rolling banner -->
				<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
				<!-- //rolling banner -->
				<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
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
<!-- 목록 검색 조건 -->
<input type="hidden" id="menuType" name="menuType" value="${searchVO.menuType }"/>
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<!--// 목록 검색 조건 -->
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>