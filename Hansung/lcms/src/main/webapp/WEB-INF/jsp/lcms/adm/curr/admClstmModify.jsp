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
function fn_add(seq){
	var clstmName = $('#clstmName');
	
	if(confirm("등록 하시겠습니까 ?")){
		$('#detaleList').attr("method", "post").attr("action","<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/addClstm.do'/>").submit();
		}
	};
	
</script>
<body>
<form:form commandName="clstmVO" id="detaleList" name="detaleList">
<input type="hidden" name="clstmSeq" id="clstmSeq" value="${clstmVO.clstmSeq }"/>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="교육과정"/>
		            <jsp:param name="dept2" value="수업시간"/>
	           	</jsp:include>
				<p class="sub-title">수업시간</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>학기</th>
								<td>
									<form:select path="clstmYear" onchange="fn_search_seme(this);">
										<form:options items="${yearList }"/>
									</form:select>
									<form:select path="clstmSeme" id="semEster">
										<c:forEach items="${semeList }" var="seme">
											<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
										</c:forEach>
									</form:select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>프로그램</th>
								<td>
									<select id="clstmName" name="clstmName">
										<c:forEach var="result" items="${progName}">
											<option value="${result.progName}" <c:if test="${result.progName eq clstmVO.clstmName}">selected="selected"</c:if>>${result.progName}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>교시</th>
								<td>
									<select id="clstmCode" name="clstmCode">
										<option>교시선택</option>
										<option value="1" <c:if test="${clstmVO.clstmCode eq '1'}">selected="selected"</c:if> >1교시</option>
										<option value="2" <c:if test="${clstmVO.clstmCode eq '2'}">selected="selected"</c:if> >2교시</option>
										<option value="3" <c:if test="${clstmVO.clstmCode eq '3'}">selected="selected"</c:if> >3교시</option>
										<option value="4" <c:if test="${clstmVO.clstmCode eq '4'}">selected="selected"</c:if> >4교시</option>
										<option value="5" <c:if test="${clstmVO.clstmCode eq '5'}">selected="selected"</c:if> >5교시</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>수업시작시간</th>
								<td>
									<form:select path="clstmStimeS">
										<c:forEach begin="0" end="23" var="sHour">
											<form:option value="${sHour }"><c:out value="${sHour }"/></form:option>
										</c:forEach>
									</form:select>&nbsp;시&nbsp;&nbsp;:&nbsp;&nbsp;
									<form:select path="clstmStimeE">
										<c:forEach begin="0" end="59" var="sMin">
											<form:option value="${sMin }"><c:out value="${sMin }"/></form:option>
										</c:forEach>
									</form:select>&nbsp;분
								</td>
							</tr>
							<tr>
								<th>수업종료시간</th>
								<td>
									<form:select path="clstmEtimeS">
										<c:forEach begin="0" end="23" var="eHour">
											<form:option value="${eHour }"><c:out value="${eHour }"/></form:option>
										</c:forEach>
									</form:select>&nbsp;시&nbsp;&nbsp;:&nbsp;&nbsp;
									<form:select path="clstmEtimeE">
										<c:forEach begin="0" end="59" var="eMin">
											<form:option value="${eMin }"><c:out value="${eMin }"/></form:option>
										</c:forEach>
									</form:select>&nbsp;분
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">상태정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:11%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>운영여부</th>
								<td>
									<input type="radio" id="rad01" name="clstmState" value="Y" <c:if test="${clstmVO.clstmState eq 'Y'}"> checked = "checked" </c:if> checked/> <label for="rad01">운영</label> &nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" id="rad02" name="clstmState" value="N" <c:if test="${clstmVO.clstmState eq 'N'}"> checked = "checked" </c:if> /> <label for="rad02">미운영</label>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admClstmList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_add()" id="add" >저장</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
	</form:form>
</body>
</html>