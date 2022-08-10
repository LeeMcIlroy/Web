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
		$("#frm").attr('action', '<c:out value="${pageContext.request.contextPath }/qxsepmny/clss/admMeetLogList.do"/>').submit();
	}
	
	function fn_print(meetSeq){
		window.open("<c:url value='/qxsepmny/cmm/meetLogPop.do'/>?meetSeq="+meetSeq+'&prog='+'<c:out value="${searchVO.searchCondition4 }"/>'
					, '급별회의록 인쇄', 'width=800, height=850, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_week(){
		$.ajax({
			url: "<c:url value='/qxsepmny/clss/admAjaxWeekList.do'/>"
			, type: "post"
			, data: $("#frm").serialize()
			, dataType:"json"
			, success: function(data){
				var weekList = data.weekList;
				var html = "";
				
				for(var i = 0; i < weekList.length; i++){
					html += "<option value='"+weekList[i]+"'>"+weekList[i]+"주차</option>";
				}
				
				$("#searchCondition3").html(html);
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
		            <jsp:param name="dept2" value="급별회의록"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
				<input type="hidden" id="meetSeq" name="meetSeq"/>
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
											<form:select path="searchCondition4" onchange="fn_week(); return false;">
												<c:forEach items="${progList }" var="prog">
													<form:option value="${prog }"><c:out value="${prog }"/></form:option>
												</c:forEach>
											</form:select>
											<form:select path="searchCondition3">
												<c:forEach items="${weekList }" var="week">
													<form:option value="${week }"><c:out value="${week }"/>주차</form:option>
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


				<!--search info-->
				<div class="search-infomation">
					<div class="search-count">
						<strong><c:out value="${resultList.size() }"/></strong>건이 검색되었습니다.
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
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>급</th>
								<th>수업교사</th>
								<th>분반</th>
								<th>제출여부</th>
								<th>급별회의록</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><c:out value="${resultList.size() - status.index}"/></td>
									<td><span class="underline"><c:out value="${result.lectGrade }"/>급</span></td>
									<td><span class="underline"><c:out value="${result.profName }"/></span></td>
									<td><c:out value="${result.lectDivi }"/></td>
									<td><c:out value="${result.submisYn }"/></td>
									<td>
										<c:if test="${result.submisYn eq '제출' }">
											<a href="#" class="underline" onclick="fn_print('<c:out value="${result.meetSeq }"/>'); return false;">인쇄</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
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