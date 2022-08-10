<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_list(idx){
		$("#pageIndex").val(idx);
		$("#frm").attr('action', '<c:out value="${pageContext.request.contextPath }/qxsepmny/clss/admEnroList.do"/>').submit();
	}

	function fn_view(seq){
		$("#lectSeq").val(seq);
		$("#frm").attr('action', '<c:out value="${pageContext.request.contextPath }/qxsepmny/clss/admEnroView.do"/>').submit();
	}
	
	function fn_printStd(lectSeq){
		var lectYear = $("#searchCondition1").val();
		var lectSem = $("#searchCondition2").val();
		var lectName = $("#searchCondition3").val();
		var prtType = 'STDLIST';
		if(lectSeq == 'allStd'){
			prtType = 'ALLSTD';
			window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admStdPop.do?'/>prtType="+prtType+"&lectYear="+lectYear+"&lectSem="+lectSem+"&lectSeq="+lectSeq+"&lectName="+encodeURI(lectName)
						, '학생명단 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
		}else if(lectSeq == 'dvsTbl'){
			prtType = 'DVSTBL';
			window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admStdPop.do?'/>prtType="+prtType+"&lectYear="+lectYear+"&lectSem="+lectSem+"&lectSeq="+lectSeq
					, '분반표 인쇄', 'width=1200, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
		}else{
			window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admStdPop.do?'/>prtType="+prtType+"&lectYear="+lectYear+"&lectSem="+lectSem+"&lectSeq="+lectSeq
						, '학생명단 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
		}
	}
	
	function fn_attend(lectSeq){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/cmm/attendancePop.do'/>?lectSeq="+lectSeq
					, '학생명단 인쇄', 'width=1600, height=850, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
</script>
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="수업"/>
		            <jsp:param name="dept2" value="수강신청"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
				<input type="hidden" id="lectSeq" name="lectSeq"/>
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search">
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:8%;" />
									<col style="width:15%;" />
									<col style="width:8%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<td>대상학기</td>
										<td>
											<form:select path="searchCondition1">
												<form:options items="${yearList }"/>
											</form:select>
											<form:select path="searchCondition2">
												<c:forEach items="${semeList }" var="seme">
												<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
												</c:forEach>
											</form:select>
										</td>
										<td>교육과정</td>
										<td>
											<form:select path="searchCondition3">
												<form:options items="${currList }"/>
											</form:select>
										</td>
									</tr>
								</tbody>
							</table>

							<a href="#" onclick="fn_list(1); return false;">검색하기</a>
						</div>
					</div>
				</div>
				<!--// search -->


				<!--search info-->
				<div class="search-infomation">
					<div class="search-count">
						<strong><c:out value="${paginationInfo.totalRecordCount }"/></strong>건이 검색되었습니다.
					</div>
					<div class="paging-select">
						<c:out value="${paginationInfo.currentPageNo }"/> / <c:out value="${totalPageCount }"/>page &nbsp;&nbsp;
						<form:select path="recordCountPerPage" onchange="fn_list(1); return false;">
							<form:option value="10">10</form:option>
							<form:option value="15">15</form:option>
							<form:option value="20">20</form:option>
							<form:option value="25">25</form:option>
							<form:option value="30">30</form:option>
						</form:select>
					</div>
				</div>
				<!--// search info-->

				<!-- table -->
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:5%;" />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col style="width:5%;" />
							<col style="width:5%;" />
							<col />
							<col />
							<col />
							<col  style="width:5%;" />
							<col  style="width:5%;" />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>과목명</th>
								<th>분반</th>
								<th>담임</th>
								<th>교사</th>
								<th>강의실</th>
								<th>정원</th>
								<th>수강</th>
								<th>개설기간</th>
								<th>강의계획표</th>
								<th>강의실</th>
								<th>학생명단</th>
								<th>출석표</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td><span class="underline"><c:out value="${result.lectName }"/></span></td>
									<td><span class="underline"><c:out value="${result.lectDivi }"/></span></td>
									<td><c:out value="${result.lectClaTea }"/></td>
									<td><c:out value="${result.profName }"/></td>
									<td><c:out value="${result.lectClassroom }"/></td>
									<td><c:out value="${result.lectPer }"/></td>
									<td><c:out value="${result.lectStdCnt }"/></td>
									<td><c:out value="${result.lectSdate }"/><br />~<c:out value="${result.lectEdate }"/></td>
									<td><c:out value="${result.syllaYn }"/></td>
									<td><a href="#" class="underline" onclick="fn_view('<c:out value="${result.lectSeq }"/>'); return false;">바로가기</a></td>
									<td>
										<a href="#" class="underline imgSelect2" onclick="fn_printStd('<c:out value="${result.lectSeq }"/>'); return false;">인쇄</a>
									</td>
									<td>
										<a href="#" class="underline imgSelect2" onclick="fn_attend('<c:out value="${result.lectSeq }"/>'); return false;">보기</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-down" onclick="fn_printStd('allStd'); return false;">학생명단(전체)</button>
						<a href="#" class="white btn-newwrite" onclick="fn_printStd('dvsTbl'); return false;">분반표</a>
					</div>
				</div>
				<!--// table button -->

				<!-- paging -->
				<div class="paging_wrap">
					<div class="paging">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
						<form:hidden path="pageIndex" />
					</div>
				</div>
				<!--// paging -->
				</form:form>
			</div>
		</div>

	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>