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
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admConsulList.do'/>").submit();
	}
	
	function fn_view(seq){
		$("#consultSeq").val(seq);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admConsulView.do'/>").submit();
	}
	
	function fn_modify(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admConsulModify.do'/>").submit();
	}
	
	function fn_search_cour(ele){
		$.ajax({
			url: "<c:url value='/qxsepmny/cmm/admAjaxSearchCour.do'/>"
			, type: "post"
			, data: "searchWord="+$(ele).val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = '<option value="">-- 선택 --</option>';
				
				for(var i=0; i<resultList.length; i++){
					html += '<option value="'+resultList[i]+'">'+resultList[i]+'</option>';
				}
				
				$("#searchCondition5").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
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
		            <jsp:param name="dept2" value="상담"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
				<input type="hidden" id="consultSeq" name="consultSeq"/>
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
											<form:input path="searchWord" class="input-data" placeholder="이름, 학번, 국적을 입력하세요" />
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
											<col style="width:35%;" />
											<col style="width:15%;" />
											<col style="width:35%;" />
										</colgroup>
										<tbody>
											<tr>
												<th>교육과정</th>
												<td>
													<div>
														<form:select path="searchCondition3">
															<form:option value="">-- 선택 --</form:option>
															<form:options items="${currList }"/>
														</form:select>
													</div>
												</td>
											</tr>
											<tr>
												<th>프로그램</th>
												<td>
													<div>
														<form:select path="searchCondition4" onchange="fn_search_cour(this); return false;">
															<form:option value="">-- 선택 --</form:option>
															<form:options items="${progList }"/>
														</form:select>
													</div>
												</td>
												<th>교과목</th>
												<td>
													<div>
														<form:select path="searchCondition5">
															<form:option value="">-- 선택 --</form:option>
															<form:options items="${courList }"/>
														</form:select>
													</div>
												</td>
											</tr>
											<tr>
												<th>분반</th>
												<td colspan="3">
													<div>
														<form:select path="searchCondition6">
															<form:option value="">-- 선택 --</form:option>
															<c:forEach items="${diviList }" var="divi">
																<form:option value="${divi.name }"><c:out value="${divi.name }"/></form:option>
															</c:forEach>
														</form:select>
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
								<th>상담일자</th>
								<th>상담자</th>
								<th>상담구분</th>
								<th>학번</th>
								<th>이름</th>
								<th>영문이름</th>
								<th>급수</th>
								<th>상담장소</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + status.count)}"/></td>
									<td><c:out value="${result.consultDate }"/></td>
									<td><c:out value="${result.profName }"/></td>
									<td><c:out value="${result.consultType }"/></td>
									<td><span class="underline imgSelect" onclick="fn_view('<c:out value="${result.consultSeq }"/>'); return false;"><c:out value="${result.memberCode }"/></span></td>
									<td><span class="underline imgSelect" onclick="fn_view('<c:out value="${result.consultSeq }"/>'); return false;"><c:out value="${result.name }"/></span></td>
									<td><c:out value="${result.eName }"/></td>
									<td><c:out value="${result.step }"/>급</td>
									<td><c:out value="${result.place }"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="table-button">
					<div class="btn-box">
						<a href="#" onclick="fn_modify(); return false;" class="white btn-newwrite">상담등록</a>
					</div>
				</div>
				<!--// table -->
				<!-- paging -->
				<div class="paginate">
					<div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
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