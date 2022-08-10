<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_list(idx){
		$("#pageIndex").val(idx);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admSatisList.do'/>").submit();
	}
	
	function fn_view(seq){
		$("#searchLecture").val(seq);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admSatisView.do'/>").submit();
	}
	function fn_excelDown(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/clss/admAdmSatisListExcel.do'/>").submit();
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
		            <jsp:param name="dept2" value="수업만족도"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
					<form:hidden path="searchLecture"/>
					<div class="search-box none-option">
						<input type="checkbox" id="search-option-open" />
						<div class="search">
							<div class="search-input">
								<table class="shearch-option">
									<colgroup>
										<col style="width:8%;" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<td>대상학기</td>
											<td>
												<form:select path="searchCondition1" onchange="fn_search_seme(this);">
													<form:options items="${yearList }"/>
												</form:select>
												<form:select path="searchCondition2" id="semEster">
													<c:forEach items="${semeList }" var="seme">
														<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
													</c:forEach>
												</form:select>
											</td>
										</tr>
									</tbody>
								</table>
								<a href="#" onclick="fn_list(1); return false;">검색하기</a>
							</div>
							<!--// 확장 검색조건항목 -->
						</div>
					</div>
					<!--// search -->
					<!-- table -->
					<div class="list-table-box mt50">
						<table class="normal-list-table">
							<colgroup>
								<col style="width:5%;"/>
								<c:forEach items="${totalList }">
								<col />
								</c:forEach>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>항목</th>
									<c:forEach items="${totalList }" var="total" varStatus="status">
										<th>질문<c:out value="${status.count }"/></th>
									</c:forEach>
									<th>평균</th>
									<th>총점</th>
								</tr>
							</thead>
							<tbody>
								<tr class="imgSelect" onclick="fn_view(''); return false;">
									<td>평점</td>
									<c:set var="avgSum" value="0"/>
									<c:forEach items="${totalList }" var="total" varStatus="status">
										<c:set var="avgSum" value="${avgSum + total.avgNum }"/>
										<td><c:out value="${total.avgNum }"/></td>
									</c:forEach>
									<td><fmt:formatNumber value="${avgSum != 0 && avgSum != null?avgSum/totalList.size():0 }" pattern="0.00"/></td>
									<td><fmt:formatNumber value="${avgSum }" pattern="0.00"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<!-- <div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-down">Download</button>
						</div>
					</div> -->
					<!--search info-->
					<div class="search-infomation mt50">
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
								<col />
								<col />
								<col />
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>과목명</th>
									<th>분반</th>
									<th>담임</th>
									<th>교사</th>
									<th>수강인원</th>
									<th>참여인원</th>
									<th>평점</th>
									<th>총점</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr>
										<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + status.count)}"/></td>
										<td>
											<a href="#" class="underline" onclick="fn_view('<c:out value="${result.lectSeq }"/>'); return false;">
												<c:out value="${result.lectName }"/>
											</a>
										</td>
										<td><c:out value="${result.lectDivi }"/></td>
										<td><c:out value="${result.name }"/></td>
										<td><c:out value="${result.teaName }"/></td>
										<td><c:out value="${result.enroNum }"/></td>
										<td><c:out value="${result.answNum }"/></td>
										<td><c:out value="${result.avgAnsw }"/></td>
										<td><c:out value="${result.sumAnsw }"/></td>
									</tr>
								</c:forEach>
								<c:if test="${resultList.size() == 0 }">
									<tr>
										<td colspan="9">검색된 내용이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<!-- table button -->
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">미참여 학생 리스트</button>
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
					<!-- table -->
					<%-- <div class="list-table-box mt50">
						<table class="normal-list-table">
							<colgroup>
								<col style="width:5%;"/>
								<col style="width:15%;"/>
								<col />
								<col style="width:10%;"/>
								<col style="width:8%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>학기</th>
									<th>설문구분제목</th>
									<th>Language</th>
									<th>총답변수</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${surveyList }" var="survey" varStatus="status">
									<tr>
										<td><c:out value="${surveyList.size() - status.index }"/></td>
										<td><a class="underline" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admSatisView.do'/>"><c:out value="${survey.year }"/>년도 <c:out value="${survey.semeNm }"/></a></td>
										<td><a class="underline" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admSatisView.do'/>"><c:out value="${survey.title }"/></a></td>
										<td class="txt-l"><span class="underline"><c:out value="${survey.lang }"/></span></td>
										<td><span class="underline"><c:out value="${survey.cntAnsw }"/></span></td>
										<td><c:out value="${survey.regName }"/></td>
										<td><c:out value="${survey.regDate }"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div> --%>
					<!--// table -->
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