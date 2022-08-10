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

	function fn_list(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#listForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admDormList.do'/>").submit();
	}
	
	
	function fn_regist(){
		$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admDormRegistView.do'/>").submit();
	}
	
	function rowClick(dormSeq){
		
		if(dormSeq != ''){
			$('#dormSeq').val(dormSeq);
			$("#listForm").attr("action", "<c:url value='/qxsepmny/admstr/admDormView.do'/>").submit()
		}
	}
	
	function fn_excelDown(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/admstr/admDormExcel.do'/>").submit()
	}

</script>
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	
<form:form commandName="searchVO" id="listForm" name="listForm">
	
	<!-- 접수번호를 히든값으로 넘긴다. -->
	<input type="hidden" name="dormSeq" id="dormSeq" />
	
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="기숙사"/>
	           	</jsp:include>
				<!-- search -->
				<div class="search-box">
					<input type="checkbox" id="search-option-open" />
					<div class="search">
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:10%;" />
									<col style="width:18%;" />
									<col style="width:10%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>신청학기</th>
											<td>
												<form:select path="searchCondition5" >
												<form:options items="${yearList }"/>
											</form:select>
											<form:select path="searchCondition6" id="semEster">
												<c:forEach items="${semeList }" var="seme">
													<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
												</c:forEach>
											</form:select>
										</td>
										<th>신청구분</th>
										<td>
											<select name="searchCondition1" onchange="fn_list('1')">
												<option value="">선택</option>
												<option value="1"  <c:if test="${searchVO.searchCondition1 eq '1'}">selected</c:if>>신입사</option>
												<option value="2" <c:if test="${searchVO.searchCondition1 eq '2'}">selected</c:if>>재입사</option>
											</select>
											<input type="text" name="searchWord" class="input-data" placeholder="이름, 학번을 입력하세요" />
										</td>
									</tr>
								</tbody>
							</table>
							<a href="#" onclick="fn_list('1'); return false;">검색하기</a>
						</div>
						<div class="search-option">
							<label for="search-option-open"><span>조건항목검색</span></label>
						</div>
						<!-- 확장 검색조건항목 -->
						<div class="shearch-option-box">
							<div class="shearch-option-list">
								<table class="shearch-option">
									<colgroup>
										<col style="width:15%;" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th>접수일자</th>
											<td>
												<div>
													<form:input type="text" path="searchCondition3" id="datepicker01" placeholder="0000-00-00" readonly="readonly" /> -
													<form:input type="text" path="searchCondition4" id="datepicker02" placeholder="0000-00-00" readonly="readonly" />
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="shearch-btn">
								<div class="btn-box">
									<button type="button" class="green"	onclick="fn_list(1); return false;">검색</button>
								</div>
							</div>
						</div>
						<!--// 확장 검색조건항목 -->
					</div>
				</div>
				<!--// search -->

				<!--search info-->
				<div class="search-infomation">
					<div class="search-count">
						<strong><c:out value="${paginationInfo.totalRecordCount }" /></strong>건이 검색되었습니다.
					</div>
					<div class="paging-select">
						<c:out value="${paginationInfo.currentPageNo }"/> / <c:out value="${totalPageCount }"/>&nbsp;page &nbsp;&nbsp;
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
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th rowspan="2">No.</th>
								<th  rowspan="2">접수번호</th>
								<th  rowspan="2">신청구분</th>
								<th  rowspan="2">접수일자</th>
								<th  rowspan="2"> 학번</th>
								<th  rowspan="2">이름</th>
								<th  rowspan="2">영문명</th>
								<th colspan="2">기숙사</th>
								<!-- <th colspan="2">인실</th> -->
								<th  rowspan="2">입사여부</th>
							</tr>
							<tr>
								<th>1순위</th>
								<th>2순위</th>
								<!-- <th>1순위</th>
								<th>2순위</th> -->
							</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td><c:out value="${result.dormRecepnum }" /></td>
								<td>
									<c:if test="${result.dormRenewgubun eq '1'}">신입사</c:if>
									<c:if test="${result.dormRenewgubun eq '2'}">재입사</c:if>
								</td>
								<td><c:out value="${result.dormRegistdate }" /></td>
								<td><a href="#" class="underline imgSelect" onclick="rowClick('<c:out value='${result.dormSeq }'/>', this); return false;"><c:out value="${result.dormMemcode }"/></a></td>
								<td><a href="#" class="underline imgSelect" onclick="rowClick('<c:out value='${result.dormSeq }'/>', this); return false;"><c:out value="${result.name }"/></a></td>
								<td><a href="#" class="underline imgSelect" onclick="rowClick('<c:out value='${result.dormSeq }'/>', this); return false;"><c:out value="${result.eName }"/></a></td>
								<td><c:out value="${result.dormDormfirst }" /></td>
								<td><c:out value="${result.dormDormsecond }" /></td>
								<td>
									<c:if test="${result.dormJoinyn eq 'Y'}">입사</c:if>
									<c:if test="${result.dormJoinyn eq 'N'}">신청</c:if>
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
						<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						<button type="button" class="white btn-type13"  onclick="fn_regist()">신청등록</button>
					</div>
				</div>
				<!--// table button -->
				<!-- paging -->
				<div class="paging_wrap">
					<div class="paging">
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
					</div>
				</div>
				<!--// paging -->
			</div>
		</div>
	</div>
</form:form>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>