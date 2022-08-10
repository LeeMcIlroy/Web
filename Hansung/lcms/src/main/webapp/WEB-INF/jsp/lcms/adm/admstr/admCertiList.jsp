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
		$("#frm").attr("action", "<c:url value='/qxsepmny/admstr/admCertiList.do'/>").submit();
	}
	
	function fn_print(seq){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admCertiPop.do?certiSeq='/>"+seq, '상장 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_select(seq){
		$.ajax({
			url: "<c:url value='/qxsepmny/admstr/admAjaxCertiEtc.do'/>"
			, type: "post"
			, data: "certiSeq="+seq
			, dataType:"json"
			, success: function(data){
				var etc = data.certiEtc;
				$("#etc").html(etc);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_excelDown(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/admstr/admCertiExcel.do'/>").submit();
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
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="증명서"/>
	           	</jsp:include>
	           	<form:form commandName="searchVO" id="frm" name="frm">
				<!-- search -->
				<div class="search-box">
					<input type="checkbox" id="search-option-open" />
					<div class="search">
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:5%;" />
									<col style="width:21%;" />
									<col style="width:10%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>학기</th>
										<td>
											<form:select path="searchCondition2" onchange="fn_search_seme(this);">
												<form:option value="">-- 선택 --</form:option>
												<form:options items="${yearList }"/>
											</form:select>
											<form:select path="searchCondition3" id="semEster">
												<form:option value="">-- 선택 --</form:option>
												<c:forEach items="${semeList }" var="seme">
													<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
												</c:forEach>
											</form:select>
										</td>
										<th>증명서구분</th>
										<td>
											<form:select path="searchCondition1">
												<form:option value="">전체</form:option>
												<form:option value="1">재학</form:option>
												<form:option value="2">성적</form:option>
												<form:option value="3">수료</form:option>
												<form:option value="4">납부</form:option>
											</form:select>
											<form:input path="searchWord" class="input-data" placeholder="이름, 발급번호를 입력하세요" />
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
											<th>발급일자</th>
											<td>
												<div>
													<form:input path="startDate" id="datepicker01" placeholder="0000-00-00"/> -
													<form:input path="endDate" id="datepicker02" placeholder="0000-00-00"/>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="shearch-btn">
								<div class="btn-box">
									<button type="button" class="green" onclick="fn_list(1); return false;">검색</button>
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
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>발급번호</th>
								<th>증명서</th>
								<th>발급일시</th>
								<th>학번</th>
								<th>이름</th>
								<th>영문이름</th>
								<th>부수</th>
								<th>발행</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td><c:out value="${result.certiNum }"/></td>
									<td>
										<c:out value="${result.certiType }"/>
										<c:if test="${result.certiEtc ne '' }">
											&nbsp;<a class="normal-btn imgSelect" href="#" onclick="fn_select('<c:out value="${result.certiSeq }"/>'); return false;">사유</a>
										</c:if>
									</td>
									<td><c:out value="${result.regDate }"/></td>
									<td><c:out value="${result.memberCode }"/></td>
									<td><c:out value="${result.name }"/></td>
									<td><c:out value="${result.eName }"/></td>
									<td><c:out value="${result.printNum }"/></td>
									<td><a class="underline imgSelect2" onclick="fn_print('<c:out value="${result.certiSeq }"/>'); return false;">인쇄</a></td>
								</tr>
							</c:forEach>
							<c:if test="${resultList.size() == 0 }">
								<tr>
									<td colspan="9">조회된 내용이 없습니다.</td>
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
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admCertiView.do'/>" class="white btn-newwrite">증명서발급</a>
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
		<!-- 입학신청자 입력폼 -->
		<div class="popupLayer">
			<table class="pop-table">
				<colgroup>
					<col style="width:100px;" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">발급사유</th>
						<td id="etc"></td>
					</tr>
				</tbody>
			</table>
			<div class="btn-box01">
				<button onClick="closeLayer(this)" class="pop-close" style="cursor:pointer;" title="닫기">닫기</button>
			</div>
		</div>
		<!--// 입학신청자 입력폼 -->
	</div>
	<!--// contents -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>