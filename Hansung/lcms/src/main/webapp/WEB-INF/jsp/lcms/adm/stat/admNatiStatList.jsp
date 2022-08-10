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
	$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/stat/admNatiStatList.do'/>").submit();
}

// 엑셀 다운로드
function fn_excelDown(){
	$("#listForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/stat/admNatiStatExcel.do'/>").submit();
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
		            <jsp:param name="dept2" value="수강생국적통계"/>
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
												<form:select path="searchCondition1" onchange="fn_search_seme(this);">
													<form:options items="${yearList }"/>
												</form:select>
												<form:select path="searchCondition2" id="semEster">
													<c:forEach var="seme" items="${semeList}">
														<form:option value="${seme.semester}"><c:out value="${seme.semeNm }"/></form:option>
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
							</colgroup>
							<thead>
								<tr>
									<th rowspan="2">국적</th>
									<th colspan="3">인원수(명)</th>
									<th rowspan="2">구성비율(%)</th>
								</tr>
								<tr>
									<th>남</th>
									<th>여</th>
									<th>계</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status" >
									<tr>
										<td><c:out value="${result.nation}"/></td>
										<td><c:out value="${result.manCnt}"/></td>
										<td><c:out value="${result.womCnt}"/></td>
										<td><c:out value="${result.natiCnt}"/></td>
										<td><fmt:formatNumber value="${(result.natiCnt/resultMap.totCnt)*100}" pattern="0.0"/></td>
									</tr>
								</c:forEach>
								<tr>
									<td>계</td>
									<td><c:out value="${resultMap.manTcnt }"/></td>
									<td><c:out value="${resultMap.womTcnt}"/></td>
									<td><c:out value="${resultMap.totCnt}"/></td>
									<td>100</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						</div>
					</div>
					<!--// table -->
					<p class="sub-title">남녀별 집계</p>
					<div id="gender-chart"></div>
					<p class="sub-title mt20">국적별 집계</p>
					<div id="nation-chart"></div>
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
var gchart = c3.generate({
	bindto: '#gender-chart',
    data: {
        columns: [
            ['남', <c:out value="${resultMap.manTcnt}"/>],
            ['여', <c:out value="${resultMap.womTcnt}"/>]
        ],
        type : 'pie',
    }
});

var nchart = c3.generate({
	bindto: '#nation-chart',
    data: {
        columns: [
			<c:forEach var="result" items="${resultList}" varStatus="status" >
	            ['<c:out value="${result.nation}"/>', <c:out value="${result.natiCnt}"/>],
			</c:forEach>
        ],
        type : 'pie',
    }
});
</script>
</html>