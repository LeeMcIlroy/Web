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
			$("input[name=lectSeq]").prop("checked", $(this).prop('checked'));
		});
	});
	
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admGradeList.do'/>").submit();
	}
	
	function fn_dtl(lectSeq, gradeYn){
		if(gradeYn != 'Y'){
			alert('성적을 제출한 강의실만 조회하실 수 있습니다.');
			return;
		}
		$("#lectSeq").val(lectSeq);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admGradeDtl.do'/>").submit();
	}
	
	function fn_admis(){
		if($("input[name=lectSeq]").length == 0){
			alert('강의실을 선택해 주세요.');
			return;
		}
		
		$.ajax({
			url: "<c:url value='/qxsepmny/clss/admAjaxGradeAdmis.do'/>"
			, type: "post"
			, data: $("input[name=lectSeq]:checked").serialize()
			, dataType:"json"
			, success: function(data){
				alert(data.message);
				if(data.status == 'success'){
					window.location.reload();
				}
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
		            <jsp:param name="dept2" value="성적"/>
	           	</jsp:include>
	           	<form:form commandName="searchVO" id="frm" name="frm">
	           	<input type="hidden" id="lectSeq" name="lectSeq"/>
				<!-- search -->
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
								<th><input type="checkbox" id="all-chk"></th>
								<th>과목명</th>
								<th>분반</th>
								<th>담임</th>
								<th>교사</th>
								<th>강의실</th>
								<th>수강인원</th>
								<th>성적등록</th>
								<th>미등록</th>
								<th>제출</th>
								<th>승인</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><input type="checkbox" name="lectSeq" value="<c:out value='${result.lectSeq }'/>"></td>
									<td><span class="underline imgSelect" onclick="fn_dtl('<c:out value="${result.lectSeq }"/>', '<c:out value="${result.gradeYn }"/>'); return false;"><c:out value="${result.lectName }"/></span></td>
									<td><span class="underline imgSelect" onclick="fn_dtl('<c:out value="${result.lectSeq }"/>', '<c:out value="${result.gradeYn }"/>'); return false;"><c:out value="${result.lectDivi }"/></span></td>
									<td><c:out value="${result.lectClaTea }"/></td>
									<td><c:out value="${result.lectTea }"/></td>
									<td><c:out value="${result.lectClassroom }"/></td>
									<td><c:out value="${result.attCnt }"/></td>
									<td><c:out value="${result.gradeUsed }"/></td>
									<td><span class="txt-red"><c:out value="${result.attCnt-result.gradeUsed }"/></span></td>
									<td><c:out value="${result.gradeYn }"/></td>
									<td><c:out value="${result.admisYn  }"/></td>
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
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-type1" onclick="fn_admis(); return false;">승인</button>
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