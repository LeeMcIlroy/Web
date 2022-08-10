<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_list(idx){
		$("#pageIndex").val(idx);
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admRefList.do'/>").submit();
	}
	
	function fn_modify(seq){
		$("#refSeq").val(seq);
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admRefModify.do'/>").submit();
	}
	
	function fn_excelDown(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admRefExcel.do'/>").submit();
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
					<jsp:param name="dept1" value="등록"/>
		            <jsp:param name="dept2" value="환불"/>
	           	</jsp:include>
	           	<form:form commandName="searchVO" id="frm" name="frm">
	           	<input type="hidden" id="refSeq" name="refSeq"/>
				<!-- search -->
				<div class="search-box">
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
										<th>대상학기</th>
										<td>
											<form:select path="searchCondition1" onchange="fn_search_seme(this);">
												<form:options items="${yearList }"/>
											</form:select>
											<form:select path="searchCondition2" id="semEster">
												<c:forEach items="${semeList }" var="seme">
													<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
												</c:forEach>
											</form:select>
											<input type="text" class="input-data" placeholder="학번,이름,국적,학적을 입력하세요" />
										</td>
									</tr>
								</tbody>
							</table>

							<a href="#" onclick="fn_list(1); return false;">검색하기</a>
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
											<th>환불일자</th>
											<td>
												<div>
													<form:input path="startDate" id="datepicker01" placeholder="0000-00-00"/> -
													<form:input path="endDate" id="datepicker02" placeholder="0000-00-00"/>
												</div>
											</td>
										</tr>
										<tr>
											<th>신청구분</th>
											<td>
												<input type="checkbox" id="option-gubun01" /> <label for="option-gubun01">신규</label>&nbsp;&nbsp;&nbsp;
												<input type="checkbox" id="option-gubun02" /> <label for="option-gubun02">재등록</label>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="shearch-btn">
								<div class="btn-box">
									<button type="button" class="green">검색</button>
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
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>환불일자</th>
								<th>학번</th>
								<th class="sorting">
									이름
									<button>오름차순 정렬</button>
									<button>내림차순 정렬</button>
								</th>
								<th>국적</th>
								<th>구분</th>
								<th>환불금액</th>
								<th>사유</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + status.count)}"/></td>
									<td><c:out value="${result.refDate }"/></td>
									<td><span class="underline imgSelect" onclick="fn_modify('<c:out value="${result.refSeq }"/>'); return false;"><c:out value="${result.memberCode }"/></span></td>
									<td><span class="underline"><c:out value="${result.enterName }"/></span></td>
									<td><c:out value="${result.enterNation }"/></td>
									<td><c:out value="${result.enterType }"/></td>
									<td class="txt-r"><fmt:formatNumber value="${result.refFee }" pattern="#,###"/></td>
									<td><c:out value="${result.refType }"/></td>
								</tr>
							</c:forEach>
							<c:if test="${resultList.size() == 0 }">
								<tr>
									<td colspan="8">조회된 내용이 없습니다.</td>
								</tr>
							</c:if>
							<!-- <tr>
								<td>2</td>
								<td>2019.10.10</td>
								<td><span class="underline">19K2999</span></td>
								<td><span class="underline">홍길동</span></td>
								<td>대한민국</td>
								<td>신규</td>
								<td>4,800,000</td>
								<td>장학</td>
								<td></td>
							</tr>
							<tr>
								<td>2</td>
								<td>2019.10.10</td>
								<td><span class="underline">19K2999</span></td>
								<td><span class="underline">홍길동</span></td>
								<td>대한민국</td>
								<td>신규</td>
								<td>4,800,000</td>
								<td>미등록</td>
								<td></td>
							</tr> -->
						</tbody>
					</table>
				</div>
				<!--// table -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						<a class="white btn-type10" href="#" onclick="fn_modify(''); return false;">환불등록</a>
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
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->

</body>
</html>