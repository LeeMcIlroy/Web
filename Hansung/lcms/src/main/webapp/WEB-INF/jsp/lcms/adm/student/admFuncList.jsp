<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
function fn_list(pageNo){
	$("#pageIndex").val(pageNo);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/student/admFuncList.do'/>").submit();
}

function fn_view(funcSeq, memberSeq){
 	$("#funcSeq").val(funcSeq);
 	$("#memberSeq").val(memberSeq);
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/student/admFuncView.do'/>").submit();
}

//엑셀 다운로드
function fn_excelDown(){
	$("#listForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/student/admFuncExcel.do'/>").submit();
}

function pad(n, width) {
	  n = n + '';
	  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	}

$(function() {

	//input을 datepicker로 선언
	$("#funcpicker01, #funcpicker02").datepicker({
		dateFormat: 'yy-mm-dd' //Input Display Format 변경
		,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
		,changeYear: true //콤보박스에서 년 선택 가능
		,changeMonth: true //콤보박스에서 월 선택 가능                		
		,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
		,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
		,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
		,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
		,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
		,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
		,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
		,minDate: "-10Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		,maxDate: "+10Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)   
		,yearRange: "c-20:c+20" // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
	});          
	
});
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
		            <jsp:param name="dept2" value="학적변동"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="listForm" name="listForm">
				<input type="hidden" name="memberSeq" id="memberSeq"/>
				<input type="hidden" name="funcSeq" id="funcSeq"/>
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
										<td>
											<form:input path="searchCondition1" type="text" id="funcpicker01" class="w173px bl-r"/>&nbsp;&nbsp;~&nbsp;&nbsp;
											<form:input path="searchCondition2" type="text" id="funcpicker02" class="w173px bl-l bl-r" />
											<form:input path="searchWord" type="text" class="input-data" placeholder="학번,이름,국적을 입력하세요" />
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
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th class="sorting">
									변동일자
									<form:button path="searchCondition3">오름차순 정렬</form:button>
									<form:button path="searchCondition4">내림차순 정렬</form:button>
								</th>
								<th class="sorting">
									학적
									<form:button path="searchCondition5">오름차순 정렬</form:button>
									<form:button path="searchCondition6">내림차순 정렬</form:button>
								</th>
								<th>학번</th>
								<th class="sorting">
									이름
									<form:button path="searchCondition7">오름차순 정렬</form:button>
									<form:button path="searchCondition8">내림차순 정렬</form:button>
								</th>
								<th>영문이름</th>
								<th>국적</th>
								<th>최종급수</th>
								<th>작업자</th>
								<th>작업일자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
								<td><c:out value="${result.funcDate }" /></td>
								<td><c:out value="${result.funcState }" /></td>
								<td><a class="underline" href="" onclick="fn_view('<c:out value="${result.funcSeq }"/>','<c:out value="${result.memberSeq }"/>'); return false;"><c:out value="${result.memberCode }" /></a></td>
								<td><a class="underline" href="" onclick="fn_view('<c:out value="${result.funcSeq }"/>','<c:out value="${result.memberSeq }"/>'); return false;"><c:out value="${result.name }" /></a></td>
								<td><c:out value="${result.eName }" /></td>
								<td><c:out value="${result.nation }" /></td>
								<td><c:out value="${result.step }" />급</td>
								<td><c:out value="${result.funcWriter }" /></td>
								<td><c:out value="${result.funcChangeDate }" /></td>
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
						<a class="white btn-newwrite" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admFuncModify.do'/>">신규등록</a>
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