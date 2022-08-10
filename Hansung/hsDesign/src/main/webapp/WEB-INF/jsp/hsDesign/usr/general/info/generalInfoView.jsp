<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
   
   // 목록
   function fn_list(){
      $("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/general/info/generalInfoList.do'/>").submit();
   }

   // 파일 다운로드
   function fn_filedownload(geupSeq, type){
      location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+geupSeq+"&type="+type;
   }
</script>
<body>
	<form:form commandName="searchVO" id="frm" name="frm">
		<form:hidden path="pageIndex" />
		<form:hidden path="searchType" />
		<form:hidden path="menuType" />
		<form:hidden path="searchCondition2" />
		<form:hidden path="searchWord" />
		<input type="hidden" id="geSeq" name="geSeq">
		<!-- skip_navigation -->
		<dl id="skip_nav">
			<dt>바로가기 메뉴</dt>
			<dd>
				<a href="#content">본문 바로가기</a>
			</dd>
			<dd>
				<a href="#top_menu">메뉴 바로가기</a>
			</dd>
			<dd>
				<a href="#footer">페이지 하단 바로가기</a>
			</dd>
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
					<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
					<!--// lnb -->
					<!-- content -->
					<div class="sub_content">
						<!-- 타이틀 영역 -->
						<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
							<jsp:param name="dept1" value="비학위과정" />
							<jsp:param name="dept2" value="과정안내" />
						</jsp:include>
						<div class="transform_table notice_type">
							<div class="tbl_view">
								<ul class="tbl_view_m">
									<li class="txt_left"><c:out
											value="${generalEduVO.geName }" escapeXml="false" /></li>
								</ul>
								<div class="tbl_td_ul">
									<ul>
										<li>연도</li>
										<li><c:out value="${generalEduVO.geYear }"
												escapeXml="false" /></li>
										<li>학기</li>
										<li><c:out value="${generalEduVO.geSemester }"
												escapeXml="false" /></li>
										<li>교육기간</li>
										<li><c:out value="${generalEduVO.geLectureBegin }" /> ~
											<c:out value="${generalEduVO.geLectureEnd }" />
										<li>수업시간</li>
										<li><c:out value="${generalEduVO.geClasstime }"
												escapeXml="false" /></li>
										<li>교강사</li>
										<li><c:out value="${generalEduVO.geTeacher }"
												escapeXml="false" /></li>
										<li>강의실</li>
										<li><c:out value="${generalEduVO.geClassrome }"
												escapeXml="false" /></li>
										<li>학습비</li>
										<li><c:choose>
												<c:when test="${generalEduVO.geExpense eq '0'}">
													<c:out value="무료" />
												</c:when>
												<c:otherwise>
													<c:out value="${generalEduVO.geExpense }" escapeXml="false" />
												</c:otherwise>
											</c:choose></li>
										<li>수강신청</li>
										<li><c:choose>
												<c:when test="${generalEduVO.geType eq 'aply'}">
													<c:out value="신청가능" />
												</c:when>
												<c:when test="${generalEduVO.geType eq 'ready'}">
													<c:out value="준비중" />
												</c:when>
												<c:otherwise>
													<c:out value="신청마감" />
												</c:otherwise>
											</c:choose>
										<li>강의계획서</li>
										<li><c:forEach items="${geUpfileList }" var="geUpfile">
												<a href="#"
													onclick="fn_filedownload(<c:out value='${geUpfile.geupSeq }'/>, 'GENERALEDU'); return false;">
													<c:out value="${geUpfile.geupOriginFilename }" />
												</a>
												<br />
											</c:forEach></li>
										<li><c:out value="${generalEduVO.geContent }" escapeXml="false" /></li>
									</ul>
								</div>
								<%-- <ul class="tbl_file">
									<li>강의계획서</li>
									<li><c:forEach var="list" items="${geUpfileList }">
											<a href="#"
												onclick="fn_filedownload(<c:out value='${list.geupSeq }'/>, 'GENERALEDU'); return false;"><c:out
													value="${list.geupOriginFilename }" /> </a>
										</c:forEach></li>
								</ul> --%>
							</div>
						</div>
						<div class="btn_box">
							<a href="#" class="btn_go_list"
								onclick="fn_list(); return false;">목록</a>
						</div>
						<div class="go_top">
							<a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a>
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