<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script>
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admDelayList.do'/>").submit();
	}
	
	function fn_modify(seq){
		$("#enterSeq").val(seq);
		$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admDelayModify.do'/>").submit();
	}
	
	//엑셀 다운로드
	function fn_excelDown(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/entran/admDelayExcel.do'/>").submit();
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
					<jsp:param name="dept1" value="입학"/>
		            <jsp:param name="dept2" value="입학연기"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
					<input type="hidden" id="enterSeq" name="enterSeq"/>
					<input type="hidden" id="enterType" name="enterStatus"/>
				
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search">
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col />
								</colgroup>
								<tbody>
									<tr>
										<td>								
											<form:input path="searchWord" class="input-data" placeholder="학번,이름,국적을 입력하세요" />
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
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>접수번호</th>
								<th>학번</th>
								<th>이름</th>
								<th>국적</th>
								<th>생년월일</th>
								<th>학생구분</th>
								<th>신청구분</th>
								<th>접수일자</th>
								<th>접수학기</th>
								<th>입학학기</th>
							</tr>
						</thead>
						<tbody id="stdBody">
							<c:forEach items="${resultList }" var="result" varStatus="status">
							
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + status.count)}"/></td>
								<td><a href="#" class="underline imgSelect" onclick="fn_modify('<c:out value='${result.enterSeq }'/>', this); return false;"><c:out value="${result.enterNum }"/></a></td>
								<td><c:out value="${result.enterCode }"/></td>
								<td><c:out value="${result.enterName }"/></td>
								<td><c:out value="${result.enterNation }"/></td>
								<td><c:out value="${result.enterBirth }"/></td>
								<td><c:out value="${result.enterStdType }"/></td>
								<c:if test="${result.enterType eq '신입학' }">
								<td><em><c:out value="${result.enterType }"/></em></td>
								</c:if>
								<c:if test="${result.enterType ne '신입학' }">
									<td><c:out value="${result.enterType }"/></td>
								</c:if>
								<td><c:out value="${result.enterDate }"/></td>
								<td><c:out value="${result.enterYear }"/>-<c:out value="${result.enterSemeNm }"/></td>
								<td>
									<c:if test="${result.delayEntrYear ne '' and result.delayEntrYear != null }">
										<c:out value="${result.delayEntrYear }"/>-<c:out value="${result.delayEntrSemeNm }"/>
									</c:if>
								</td>
							</tr> 
							</c:forEach>
							<c:if test="${resultList.size() == 0 }">
								<tr>
									<td colspan="11">
										검색된 내용이 없습니다.
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
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
					<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>">
				</form:form>
			</div>
		</div>

	</div>
	<!--// contents -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
</body>
</html>