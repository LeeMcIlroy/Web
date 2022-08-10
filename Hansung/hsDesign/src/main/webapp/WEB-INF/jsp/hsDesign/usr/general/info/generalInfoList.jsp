<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/general/info/generalInfoList.do'/>").submit();
	}

	// 조회
	function fn_select(geSeq){
		$("#geSeq").val(geSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/general/info/generalInfoView.do'/>").submit();
	}
	
	// 신청가능 외부 appliForm
	function fn_appliForm_open(){
		var tags = '';
		tags += '<div class="pop_pw" style="display:block;">';
		tags += '	<div class="pop_frame">';
		tags += '		<iframe src="https://edulms.hansung.ac.kr/application/application2_check1.php?edu_type=G" name="iframe_online" title="온라인 원서접수" frameborder="0"></iframe>';
		tags += '		<div class="frame_close" >';
		tags += '			<label for="pop_close" onclick="fn_appliForm_close(); return false;">X</label>';
		tags += '		</div>';
		tags += '	</div>';
		tags += '</div>';
		
		$(".content").append(tags);	
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
						<div class="list_sh">
							<ul>
								<li style="margin-right: 5px;">연도</li>
								<li><form:select path="searchCondition3"
										onchange="submit();">
										<form:option value="all">전체</form:option>
										<form:option value="2022">2022</form:option>
										<form:option value="2021">2021</form:option>
										<form:option value="2020">2020</form:option>
										<form:option value="2019">2019</form:option>
										<form:option value="2018">2018</form:option>
										<form:option value="2017">2017</form:option>
										<form:option value="2016">2016</form:option>
										<form:option value="2015">2015</form:option>
									</form:select></li>
								<li style="margin-right: 5px;">학기</li>
								<li><form:select path="searchCondition4"
										onchange="submit();">
										<form:option value="전체">전체</form:option>
										<form:option value="1학기">1학기</form:option>
										<form:option value="하계학기">하계학기</form:option>
										<form:option value="2학기">2학기</form:option>
										<form:option value="동계학기">동계학기</form:option>
									</form:select></li>
								<li><form:select path="searchCondition1">
										<form:option value="title">과정명</form:option>
										<form:option value="expanse">수강료</form:option>
									</form:select></li>
								<li><form:input path="searchWord" class="in_base w150" id="searchword"/></li>
								<li><a href="#" onclick="fn_list(1); return false;"><img
										src="<c:out value='${pageContext.request.contextPath  }/assets/usr/img/icon_sh.png'/>"
										alt="찾기" /></a></li>
							</ul>
						</div>
						<div class="transform_table cul_type">
							<!-- content -->
							<ul class="tbl_th">
								<li>과정명</li>
								<li>교육기간</li>
								<li>수업시간</li>
								<li>교강사</li>
								<li>강의실</li>
								<li>학습비</li>
								<li>강의계획서</li>
								<li>수강신청</li>
							</ul>
							<div class="tbl_td">
								<c:forEach var="list" items="${resultList }">
									<ul>
										<li class="txt_left"><a href="#"
											onclick="fn_select(<c:out value='${list.geSeq }'/>); return false;">
												<c:out value="${list.geName }" escapeXml="false" />
										</a></li>
										<li><c:out value="${list.geLectureBegin }" /> <br/>~<br/> <c:out
												value="${list.geLectureEnd }" /></li>
										<li><c:if test="${!empty list.geClasstime }">
												<c:out value="${list.geClasstime }" />
											</c:if> <c:if test="${empty list.geClasstime }">&nbsp;</c:if></li>
										<li><c:if test="${!empty list.geTeacher }">
												<c:out value="${list.geTeacher }" />
											</c:if> <c:if test="${empty list.geTeacher }">&nbsp;</c:if></li>
										<li><c:if test="${!empty list.geClassrome }">
												<c:out value="${list.geClassrome }" />
											</c:if> <c:if test="${empty list.geClassrome }">&nbsp;</c:if></li>
										<li><c:if test="${list.geExpense ne 0 }">
												<fmt:formatNumber value="${list.geExpense }" type="currency"
													groupingUsed="true" />
											</c:if> <c:if test="${list.geExpense eq 0 }">
										무료
									</c:if></li>
										<li><c:choose>
												<c:when test="${list.geupSeq != null }">
													<a href="#"
														onclick="fn_filedownload(<c:out value='${list.geupSeq }'/>, 'GENERALEDU'); return false;">
														다운로드 </a>
												</c:when>
												<c:otherwise>
										&nbsp;
										</c:otherwise>
											</c:choose></li>
										<c:if test="${list.geType eq '1' }">
											<li class="tbl_btn01"><a href="#"
												onclick="fn_appliForm_open(); return false;">신청가능</a></li>
										</c:if>
										<c:if test="${list.geType eq '2' }">
											<li class="tbl_btn02"><a href="#">준비중</a></li>
										</c:if>
										<c:if test="${list.geType eq '3' }">
											<li class="tbl_btn03"><a href="#">신청마감</a></li>
										</c:if>
									</ul>
								</c:forEach>
							</div>
						</div>
						<div class="pager">
							<ui:pagination paginationInfo="${paginationInfo }" type="image2"
								jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>

						<!-- rolling banner -->
						<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner" />
						<!-- //rolling banner -->
						<!-- //content -->
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