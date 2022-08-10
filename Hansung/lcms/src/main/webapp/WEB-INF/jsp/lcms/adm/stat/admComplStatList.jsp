<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib  prefix = "fn" 	uri = "http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
function fn_list(){
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/stat/admComplStatList.do'/>").submit();
}

// 엑셀 다운로드
function fn_excelDown(){
	$("#listForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/stat/admComplStatExcel.do'/>").submit();
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
					<jsp:param name="dept1" value="현황통계"/>
		            <jsp:param name="dept2" value="수료형태별통계"/>
	           	</jsp:include>
				<!-- search -->
			<form:form commandName="searchVO" id="listForm" name="listForm">
				<input type="hidden" name="lectSeq" id="lectSeq"/>
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
											<td> <!-- onchange="this.form.submit()" -->
												<form:select path="searchCondition1">
													<form:options items="${yearList }"/>
												</form:select>
												<form:select path="searchCondition2">
													<c:forEach var="year" begin="1" end="10">
														<form:option value="${year}"><c:out value="최근${year }년"/></form:option>
													</c:forEach>
												</form:select>
												<form:select path="searchCondition3">
													<c:forEach items="${progList }" var="prog">
														<form:option value="${prog }"><c:out value="${prog }"/></form:option>
													</c:forEach>
												</form:select>
											</td>
										</tr>
									</tbody>
								</table>
								<a href="#" onclick="fn_list(); return false;">검색하기</a>
							</div>
						</div>
					</div>
					<!--// search -->
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-list-table">
							<colgroup>
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
									<th>교육학기</th>
									<th>총수강생</th>
									<th>수료</th>
									<th>유급</th>
									<th>자퇴</th>
									<th>퇴학</th>
									<th>행방불명</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status" >
									<tr>
										<td><c:out value="${result.semester}"/></td>
										<td><c:out value="${result.totCnt}"/></td>
										<td><c:out value="${result.compleCnt}"/></td>
										<td><c:out value="${result.nonCompleCnt}"/></td>
										<td><c:out value="${result.dropCnt}"/></td>
										<td><c:out value="${result.outCnt}"/></td>
										<td><c:out value="${result.missingCnt}"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						</div>
					</div>
					<!--// table -->
					<p class="sub-title">교육년도별 집계</p>
					<div id="year-chart"></div>
				</form:form>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
<script type="text/javascript">
var nchart = c3.generate({
	bindto: '#year-chart',
    data: {
        columns: [
			<c:forEach var="type" begin="1" end="2">
				<c:if test="${type == 1}">
				['수료',
				</c:if>
				<c:if test="${type == 2}">
				['유급',
				</c:if>
					<c:forEach var="i" begin="1" end="${resultList.size()}" varStatus="status" >
						<c:if test="${type == 1}">
							<c:out value="${resultList[resultList.size()-i].compleCnt}"/>,
						</c:if>
						<c:if test="${type == 2}">
							<c:out value="${resultList[resultList.size()-i].nonCompleCnt}"/>,
						</c:if>
					</c:forEach>
				],
            </c:forEach>
        ],
        type : 'bar',
    },
    bar: {
        width: {
            ratio: 0.5 // this makes bar width 50% of length between ticks
        }
    },
    axis: {
    	x: {
    		type: 'category',
    		categories: [
				<c:forEach var="i" begin="1" end="${resultList.size()}" varStatus="status" >
					'<c:out value="${resultList[resultList.size()-i].semester}"/>',
				</c:forEach>
			]
    	}
    }
});
</script>
</html>