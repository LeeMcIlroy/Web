<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@page import="lcms.valueObject.AdminVO"%>
<%
	String admMenuNo = ((String)session.getAttribute("admMenuNo")!=null)?(String)session.getAttribute("admMenuNo"):"";
	AdminVO adminVO = ((AdminVO)session.getAttribute("adminSessionLcms")!=null)?(AdminVO)session.getAttribute("adminSessionLcms"):null;
%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>

<script type="text/javascript" src="../jquery-latest.js"></script>
<script type="text/javascript" src="../jquery-tablesorter/jquery.tablesorter.min.js"></script>

<script type="text/javascript">
function fn_list(pageNo){
	$("#pageIndex").val(pageNo);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/student/admStatusList.do'/>").submit();
}

function fn_view(memberSeq){
 	$("#memberSeq").val(memberSeq);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/student/admStatusView.do'/>").submit();
}

function cAll() {
    if ($("#checkAll").is(':checked')) {
        $(".all").prop("checked", true);
    } else {
        $(".all").prop("checked", false);
    }
}

// // 테이블 소팅
// var table_html;
// function re_table(line, cols, table_position) {
// 	table_html = "";
// 	for(var i = 0; i<line; i++) {
// 		table_html += "<tr>";
// 		for(var j = 0; j<cols; j++) {
// 			table_html += "<td>"+new_array[i][j]+"</td>";
// 		}
// 		table_html += "</tr>";
// 	}
// 	$(table_position.find("tbody")).html(table_html);
// }

// 정렬
$(document).ready(function() {
	var text_array;

	$("button.up, button.down").on("click", function() {
		var $this = $(this);
		var $this_table = $this.parents("table");
		var $this_start_number = $this.parent().index();
		
		var table_th_length = $this.parents("table").find("thead th").length; //테이블 칸의 갯수
		var table_tr_length = $this.parents("table").find("tbody tr").length; //테이블 내용 줄 갯수

		new_array = new Array();
		for(var i = 0; i<table_tr_length; i++) {
			new_array[i] = [];
			for(var j = 0 ; j < table_th_length; j++) {
				text_array = $this_table.find("tbody tr").eq(i).find("td").eq(j).text(); // 값땡겨오는거
				new_array[i][j] = text_array;
			}	
		}

		//테이블 클래스 active 지정
		$this_table.find("th button").removeClass("active");
		$this.addClass("active");

		/* 정렬 */
		new_array.sort(function (a, b) { 
			if($this.hasClass("up")) {
				return a[$this_start_number] < b[$this_start_number] ? -1 : a[$this_start_number] > b[$this_start_number]? 1 : 0;  
			} else {
				return a[$this_start_number] > b[$this_start_number] ? -1 : a[$this_start_number] < b[$this_start_number]? 1 : 0;  
			}
		});

		//값이 들어오는지 확인 소스
// 		console.log(new_array);

		$this_table.find("tbody").empty();
		re_table(table_tr_length, table_th_length, $this_table);
	});
	
})
// 엑셀 다운로드
	function fn_excelDown(){
		$("#listForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/student/admStatusExcel.do'/>").submit();
	}
	
	function fn_delete(){
		if(confirm('삭제 하시겠습니까?')){
			$("#listForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/student/admStatusDelete.do'/>").submit();
		}
	}
	
	function chkStd(std){
		var seq = $(std).attr('value2');
		var html = '<input type="hidden" id="delStdList'+seq+'" name="delStdList" value="'+std.value+'" />';
			if(	$("input:checkbox[id='memberCode"+seq+"']").is(":checked") ==true ){
				$("#delStd").append(html);
			} else if(	$("input:checkbox[id='memberCode"+seq+"']").is(":checked") ==false ){
				$("#delStdList"+seq).remove();
			}
 	}
	function fn_search_sem(ele){
		$.ajax({
			url: "<c:url value='/usr/cmm/ajaxSearchSeme.do'/>"
			, type: "post"
			, data: "year="+$(ele).val()
			, dataType:"json"
			, success: function(data){
				resultList = data.semeList;
				var html = "";
				html += '<option value="">전체</option>';
				for(var i=0; i<resultList.length; i++){
					html += '<option value="'+resultList[i].semester+'">'+resultList[i].semeNm+'</option>';
				}
				$("#semEster").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	function fn_search_grade(ele){
		$.ajax({
			url: "<c:url value='/qxsepmny/student/ajaxSearchGrade.do'/>"
			, type: "post"
			, data: "seme="+$(ele).val()
			, dataType:"json"
			, success: function(data){
				resultList = data.gradeList;
				var html = "";
				html += '<option value="">전체</option>';
				for(var i=0; i<resultList.length; i++){
					html += '<option value="'+resultList[i].grade+'">'+resultList[i].grade+'급</option>';
				}
				$("#grade").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	function fn_search_divi(ele){
		$.ajax({
			url: "<c:url value='/qxsepmny/student/ajaxSearchDivi.do'/>"
			, type: "post"
			, data: "grade="+$(ele).val()
			, dataType:"json"
			, success: function(data){
				resultList = data.diviList;
				var html = "";
				html += '<option value="">전체</option>';
				for(var i=0; i<resultList.length; i++){
					html += '<option value="'+resultList[i].lectDivi+'">'+resultList[i].lectDivi+'</option>';
				}
				$("#division").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_sort(type, sort){
		$("#searchCondition6").val('');
		$("#searchCondition7").val('');
		$("#searchCondition8").val('');
		
		$("#searchCondition"+type).val(sort);
		
		fn_list(1);
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
					<jsp:param name="dept1" value="학생"/>
		            <jsp:param name="dept2" value="학생현황"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="listForm" name="listForm">
				<input type="hidden" name="memberSeq" id="memberSeq"/>
				<form:hidden path="searchCondition6"/>
				<form:hidden path="searchCondition7"/>
				<form:hidden path="searchCondition8"/>
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
										<td>
											<form:input path="searchWord" class="input-data" placeholder="학번,이름,국적,학적을 입력하세요" />
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
											<th>교육학기</th>
											<td>
												<form:select path="searchCondition1" onchange="fn_search_sem(this);">
													<form:option value="">전체</form:option>
													<form:options items="${yearList }"/>
												</form:select>
												<form:select path="searchCondition2" id="semEster" onchange="fn_search_grade(this);">
													<form:option value="">전체</form:option>
													<c:forEach items="${semeList }" var="seme">
														<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
													</c:forEach>
												</form:select>
											</td>
										</tr>
										<tr>
											<th>급/반</th>
											<td>
												<form:select path="searchCondition3" id="grade" onchange="fn_search_divi(this);">
													<form:option value="">전체</form:option>
													<c:forEach items="${gradeList }" var="grade">
														<form:option value="${grade.grade }"><c:out value="${grade.grade }"/>급</form:option>
													</c:forEach>
												</form:select>
												<form:select path="searchCondition4" id="division">
													<form:option value="">전체</form:option>
													<c:forEach items="${diviList }" var="divi">
														<form:option value="${divi.lectDivi }"><c:out value="${divi.lectDivi }"/></form:option>
													</c:forEach>
												</form:select>
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
					<table class="normal-list-table" id="tableSort">
						<colgroup>
							<col style="width:5%;" />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="checkAll" onclick="cAll();"/></th>
								<th class="sorting">
									학번
									<button onclick="fn_sort('6', 'ASC'); return false;">오름차순 정렬</button>
									<button onclick="fn_sort('6', 'DESC'); return false;">내림차순 정렬</button>
								</th>
								<th class="sorting">
									이름
									<button onclick="fn_sort('7', 'ASC'); return false;">오름차순 정렬</button>
									<button onclick="fn_sort('7', 'DESC'); return false;">내림차순 정렬</button>
								</th>
								<th>국적</th>
								<th>급수</th>
								<th class="sorting">
									학적
									<button onclick="fn_sort('8', 'ASC'); return false;">오름차순 정렬</button>
									<button onclick="fn_sort('8', 'DESC'); return false;">내림차순 정렬</button>
								</th>
								<th>구분</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${!empty resultList }">
								<c:forEach var="result" items="${resultList}" varStatus="status" >
									<tr>
										<td><input type="checkbox" class="all" id="memberCode${status.index }" name="memberCode" value="${result.memberCode }" value2="${status.index }" onclick="chkStd(this)"/></td>
		<%-- 								<td><a class="underline" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admStatusView.do'/>"><c:out value="${result.memberCode }" /></a></td> --%>
		<%-- 								<td><a class="underline" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admStatusView.do'/>"><c:out value="${result.name }" /></a></td> --%>
										<td onclick="fn_view('<c:out value="${result.memberSeq }"/>'); return false;"><a><c:out value="${result.memberCode }" /></a></td>
										<td onclick="fn_view('<c:out value="${result.memberSeq }"/>'); return false;"><c:out value="${result.name }" /></td>
										<td><c:out value="${result.nation }" /></td>
										<td><c:out value="${result.step }" />급</td>
										<td><c:out value="${result.status }" /></td>
										<td><c:out value="${result.stdType}"/></td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty resultList }">
								<tr>
									<td colspan="7">검색 결과가 없습니다.</td>
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
						<button type="button" class="white btn-del" onclick="fn_delete(); return false;">선택항목삭제</button>
						<c:set var="dtl" value="<%=adminVO.getDtlYn() %>" />
						<c:if test="${dtl eq 'Y' }">
							<a class="white btn-newwrite" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admStatusModify.do'/>">학생등록</a>
						</c:if>
						<c:if test="${dtl eq 'N' }">
							<a class="white btn-newwrite" href="" onclick="alert('등록 권한이 없습니다.')">학생등록</a>
						</c:if>
					</div>
				</div>
				<!--// table button -->

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
<div id="delStd"></div>
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