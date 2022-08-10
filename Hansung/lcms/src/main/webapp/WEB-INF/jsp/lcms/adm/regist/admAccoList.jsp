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
	$(function(){
		$("#all-chk").change(function(){
			$("input[name=enterSeq]").prop("checked", $(this).prop('checked'));
		});
	});

	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admAccoList.do'/>").submit();
	}
	
	function fn_tab(menu){
		$("#menuType").val(menu);
		fn_list(1);
	}
	
	function fn_acco_save(){
		$.ajax({
			url: "<c:url value='/qxsepmny/regist/admAjaxAdmAccoSave.do'/>"
			, type: "post"
			, data: $("input[type='checkbox']").serialize()
			, dataType:"json"
			, success: function(data){
				alert(data.message);
				window.location.reload();
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_excelDown(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admAccoExcel.do'/>").submit();
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
		            <jsp:param name="dept2" value="가상계좌발급"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
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
										<th>접수학기</th>
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
					</div>
				</div>
				<!--// search -->
				<div class="tab-box">
					<form:hidden path="menuType"/>
					<input id="tab1" type="radio" name="tabs" <c:out value="${searchVO.menuType eq '1'?'checked':'' }"/>>
					<input id="tab2" type="radio" name="tabs" <c:out value="${searchVO.menuType eq '2'?'checked':'' }"/>>
					<div class="tab-btn">
						<label for="tab1" class="tab1" onclick="fn_tab('1'); return false;">발급대상자</label>
						<label for="tab2" class="tab2" onclick="fn_tab('2'); return false;">발급현황</label>
					</div>
					<div id="content">
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
										<c:if test="${searchVO.menuType eq '1' }">
											<th><input type="checkbox" id="all-chk"/></th>
										</c:if>
										<c:if test="${searchVO.menuType eq '2' }">
											<th>No.</th>
										</c:if>
										<th>접수번호</th>
										<th>이름</th>
										<th>국적</th>
										<th>생년월일</th>
										<th>학생구분</th>
										<th>신청구분</th>
										<th><c:out value="${searchVO.menuType eq '1'?'접수일자':'발급일시' }"/></th>
										<th>가상계좌번호</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${resultList }" var="result" varStatus="status">
										<tr>
											<c:if test="${searchVO.menuType eq '1' }">
												<td><input type="checkbox" value="<c:out value='${result.enterSeq }'/>" name="enterSeq" /></td>
											</c:if>
											<c:if test="${searchVO.menuType eq '2' }">
												<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + status.count)}"/></td>
											</c:if>
											<td><c:out value="${result.enterNum }"/></td>
											<td><c:out value="${result.enterName }"/></td>
											<td><c:out value="${result.enterNation }"/></td>
											<td><c:out value="${result.enterBirth }"/></td>
											<td><c:out value="${result.enterStdType }"/></td>
											<td><c:out value="${result.enterType }"/></td>
											<td><c:out value="${searchVO.menuType eq '1'?result.enterDate:result.startDate }"/></td>
											<td><c:out value="${result.bankAccount }"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!--// table -->
						<!-- table button -->
						<div class="table-button">
							<div class="btn-box">
								<c:if test="${searchVO.menuType eq '2' }">
									<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
								</c:if>
								<c:if test="${searchVO.menuType eq '1' }">
									<button type="button" class="white btn-type07" onclick="fn_acco_save(); return false;">발급처리</button>
								</c:if>
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
					</div>
				</div>
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