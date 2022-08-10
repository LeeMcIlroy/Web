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
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admSatisPrfList.do'/>").submit();
	}

	function fn_list2(idx){
		$("#pageIndex2").val(idx);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admSatisPrfList.do'/>").submit();
	}
	
	function fn_view(seq, mCode){
		$("#searchLecture").val(seq);
		$("#searchMemberCode").val(mCode);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admSatisPrfView.do'/>").submit();
	}

	// 엑셀 다운로드
	function fn_excelDown(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/clss/admAdmSatisPrfLectExcel.do'/>").submit();
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
		            <jsp:param name="dept2" value="강의평가"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
					<form:hidden path="searchLecture"/>
					<form:hidden path="searchMemberCode"/>
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
					<p class="sub-title mt50">교사별 조사결과</p>
					<!--search info-->
					<div class="search-infomation mt20">
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
								<col style="width:5%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<c:set var="mcode" value=""/>
								<c:forEach items="${quelectList }">
									<col />
								</c:forEach>
								<col style="width:5%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>아이디</th>
									<th>이름</th>
									<c:forEach items="${quelectList }" var="lect" varStatus="status">
										<th><c:out value="${lect.lectName }"/> <c:out value="${lect.lectDivi }"/></th>
									</c:forEach>
									<th>평균</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${prfList }" var="prf" varStatus="status">
									<tr>
										<td><c:out value="${((searchVO.pageIndex-1) * searchVO.recordCountPerPage + status.count)}"/></td>
										<td><c:out value="${prf.lectTea }"/></td>
										<td>
											<a href="#" class="underline" onclick="fn_view('','<c:out value="${prf.lectTea }"/>'); return false;">
												<c:out value="${prf.name }"/>
											</a>
										</td>
										<c:set var="avgSum" value="0"/>
										<c:set var="count" value="0"/>
										<c:forEach items="${quelectList }" var="lect">
											<c:set var="chk" value="N"/>
											<c:forEach items="${prfLectQuesList }" var="prfQues" varStatus="status">
												<c:if test="${prfQues.profCode eq prf.lectTea && lect.lectSeq eq prfQues.lectSeq }">
													<c:set var="count" value="${count+1 }"/>
													<c:set var="chk" value="Y"/>
													<c:set var="avgSum" value="${avgSum + prfQues.avgAnsw }"/>
													<td>
														<a href="#" class="underline" onclick="fn_view('<c:out value="${prfQues.lectSeq }"/>','<c:out value="${prfQues.profCode }"/>'); return false;">
															<fmt:formatNumber value="${prfQues.avgAnsw }" pattern="0.00"/>
														</a>
													</td>
												</c:if>
											</c:forEach>
											<c:if test="${chk ne 'Y' }">
												<td></td>
											</c:if>
										</c:forEach>
										<td><fmt:formatNumber value="${avgSum != 0 && avgSum != null && count != 0?avgSum/count:0 }" pattern="0.00"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						</div>
					</div>
					<!-- paging -->
					<div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
					</div>
					<!--// paging -->
					<%-- <p class="sub-title">수업별 조사결과</p>
					<div class="search-infomation mt20">
						<div class="search-count">
							<strong><c:out value="${paginationInfo2.totalRecordCount }"/></strong>건이 검색되었습니다.
						</div>
					</div>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-list-table">
							<colgroup>
								<col style="width:5%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<c:set var="mcode" value=""/>
								<c:forEach items="${quesList }">
									<col />
								</c:forEach>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
								<col style="width:10%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>과목명</th>
									<th>분반</th>
									<th>아이디</th>
									<th>이름</th>
									<c:forEach items="${quesList }" varStatus="status">
										<th>질문<c:out value="${status.count }"/></th>
									</c:forEach>
									<th>평균</th>
									<th>총점</th>
									<th>답변인원</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${lectList }" var="lect" varStatus="status">
									<tr>
										<td><c:out value="${paginationInfo2.totalRecordCount+1 - ((searchVO.pageIndex2-1) * searchVO.recordCountPerPage + status.count)}"/></td>
										<td>
											<a href="#" class="underline" onclick="fn_view('<c:out value="${lect.lectSeq }"/>','<c:out value="${lect.lectTea }"/>'); return false;"><c:out value="${lect.lectName }"/></a>
										</td>
										<td><c:out value="${lect.lectDivi }"/></td>
										<td><c:out value="${lect.lectTea }"/></td>
										<td><c:out value="${lect.name }"/></td>
										<c:set var="avgSum" value="0"/>
										<c:forEach items="${quesList }" var="ques">
											<c:set var="chk" value="N"/>
											<c:forEach items="${prfLectQuesList }" var="prfLectQues" varStatus="status">
												<c:if test="${prfLectQues.profCode eq lect.lectTea && ques.quesSeq eq prfLectQues.quesSeq && lect.lectSeq eq prfLectQues.lectSeq }">
													<c:set var="chk" value="Y"/>
													<c:set var="avgSum" value="${avgSum + prfLectQues.avgAnsw }"/>
													<td><c:out value="${prfLectQues.avgAnsw }"/></td>
												</c:if>
											</c:forEach>
											<c:if test="${chk ne 'Y' }">
												<td>0</td>
											</c:if>
										</c:forEach>
										<td><fmt:parseNumber value="${avgSum != 0 && avgSum != null?avgSum/quesList.size():0 }" integerOnly="true"/></td>
										<td><c:out value="${avgSum }"/></td>
										<td><c:out value="${lect.answCnt }"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<!-- table button -->
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-down">Download</button>
						</div>
					</div>
					<!--// table button -->
					<!-- paging -->
					<div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo2}" type="image" jsFunction="fn_list2" />
							<form:hidden path="pageIndex2" />
						</div>
					</div> --%>
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