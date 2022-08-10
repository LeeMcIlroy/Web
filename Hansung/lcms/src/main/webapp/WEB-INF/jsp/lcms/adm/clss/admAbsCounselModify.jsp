<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>
	function fn_save(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admAbsCounselSubmit.do'/>").submit();
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="수업" />
					<jsp:param name="dept2" value="결석자상담" />
				</jsp:include>
				<form:form commandName="absentConsultVO" id="frm" name="frm">
				<form:hidden path="absentSeq"/>
				<form:hidden path="attSeq"/>
				<form:hidden path="lectSeq"/>
				<form:hidden path="lectName"/>
				<form:hidden path="lectDivi"/>
				<form:hidden path="memberCode"/>
				<form:hidden path="memberName"/>
				<form:hidden path="memberGrade"/>
				<form:hidden path="memberNation"/>
				<form:hidden path="absentDate"/>
				<form:hidden path="attRate"/>
				<p class="sub-title">학생 정보</p>
				<div>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:10%;" />
								<col style="width:25%;" />
								<col style="width:10%;" />
								<col style="width:25%;" />
								<col style="width:10%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th>결석일자</th>
									<td><c:out value="${absentConsultVO.absentDate }"/></td>
									<th>출석율(%)</th>
									<td><c:out value="${absentConsultVO.attRate }"/></td>
									<th>&nbsp;</th>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<th>이름</th>
									<td><c:out value="${absentConsultVO.memberName }"/></td>
									<th>급/반</th>
									<td><c:out value="${absentConsultVO.memberGrade }급"/>&nbsp;<c:out value="${absentConsultVO.lectDivi }"/></td>
									<th>국적</th>
									<td><c:out value="${absentConsultVO.memberNation }"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
				</div>
				
				<c:if test="${absentConsultVO.firstYn eq 'Y' }">
					<p class="sub-title">1차 상담</p>
					<div>
						<!-- table -->
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:10%;" />
									<col style="width:25%;" />
									<col style="width:10%;" />
									<col style="width:55%;" />
								</colgroup>
								<tbody>
									<tr>
										<th>상담자</th>
										<td><c:out value="${absentConsultVO.firstSelorName }"/></td>
										<th>상담방법</th>
										<td>
											<c:out value="${absentConsultVO.firstTel eq 'Y'?'전화':'' }"/>
											<c:out value="${absentConsultVO.firstSns eq 'Y'?absentConsultVO.firstTel eq 'Y'?', SNS':'SNS':'' }"/>
											<c:out value="${absentConsultVO.firstTeam eq 'Y'?(absentConsultVO.firstSns eq 'Y' || absentConsultVO.firstTel eq 'Y')?', 국제교류팀':'국제교류팀':'' }"/>
											<c:out value="${absentConsultVO.firstEtc eq 'Y'?(absentConsultVO.firstTeam eq 'Y' || absentConsultVO.firstSns eq 'Y' || absentConsultVO.firstTel eq 'Y')?', 기타':'기타':'' }"/>
										</td>
									</tr>
									<tr>
										<th>결석사유</th>
										<td colspan="3"><c:out value="${absentConsultVO.firstReason }"/></td>
									</tr>
									<tr>
										<th>후속조치</th>
										<td colspan="3"><c:out value="${absentConsultVO.firstFolup }"/></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table -->
					</div>
				</c:if>
				<p class="sub-title">2차 상담</p>
				<div>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:10%;" />
								<col style="width:25%;" />
								<col style="width:10%;" />
								<col style="width:55%;" />
							</colgroup>
							<tbody>
								<tr>
									<th>상담자</th>
									<td><c:out value="${absentConsultVO.secondSelorName }"/></td>
									<th>상담방법</th>
									<td>
										<form:checkbox path="secondTel" label=" 전화" value="Y"/>&nbsp;&nbsp;
										<form:checkbox path="secondSns" label=" SNS" value="Y"/>&nbsp;&nbsp;
										<form:checkbox path="secondTeam" label=" 국제교류팀" value="Y"/>&nbsp;&nbsp;
										<form:checkbox path="secondEtc" label=" 기타" value="Y"/>
									</td>
								</tr>
								<tr>
									<th>결석사유</th>
									<td colspan="3"><form:textarea path="secondReason" cols="130" rows="6"/></td>
								</tr>
								<tr>
									<th>후속조치</th>
									<td colspan="3"><form:textarea path="secondFolup" cols="130" rows="6"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
				</div>
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admAbsCounselList.do'/>" class="white btn-list">목록</a>
						<c:if test="${!empty absentConsultVO.absentSeq }">
							<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
						</c:if>
					</div>
				</div>
				<!--// table button -->
				</form:form>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
	<form:form commandName="searchVO" id="listFrm" name="listFrm">
		<form:hidden path="searchCondition1" />
		<form:hidden path="searchCondition2" />
		<form:hidden path="recordCountPerPage" />
	</form:form>
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
</body>
</html>