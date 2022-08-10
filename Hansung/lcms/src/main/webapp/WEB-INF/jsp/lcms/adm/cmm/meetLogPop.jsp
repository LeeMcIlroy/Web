<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<link rel="stylesheet" media="print" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/style.css'/>">
<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/certipop.css'/>">
<link rel="stylesheet" media="print" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/certipop.css'/>">
<style type="text/css" media="print">
html, body { height: auto;}

button {display:none;}

@page {
    margin: 0 auto;  /* this affects the margin in the printer settings */
}
</style>
<script type="text/javascript">
	function pageprint() {
		var g_oBeforeBody = document.getElementById('print-pop').innerHTML;
		
		window.onbeforeprint = function (ev) {
			document.body.innerHTML = g_oBeforeBody;
		};

 		window.print();
	}
</script>
<body>
	<div id="print-pop">
		<div>
			<div class="contents">
				<div class="pop-table-box">
					<div class="meet-main-title">【<c:out value="${meetLogMap.year }"/>년 <c:out value="${meetLogMap.semeNm }"/> 급별 회의록】</div>
					<div class="meet-border-box">
						<table class="meet-pop-table">
							<colgroup>
								<col style="width:15%;" />
								<col style="width:15%;" />
								<col style="width:15%;" />
								<col style="width:15%;" />
								<col style="width:15%;" />
								<col style="width:25%;" />
							</colgroup>
							<tbody>
								<tr>
									<th>급</th>
									<td><c:out value="${meetWeek.lectGrade }"/></td>
									<th>주차</th>
									<td><c:out value="${meetWeek.week }"/></td>
									<th>일정</th>
									<td><c:out value="${meetWeek.monday }"/> ~ <c:out value="${meetWeek.friday }"/></td>
								</tr>
								<tr>
									<th>참가 교사</th>
									<td colspan="5"><c:out value="${meetLogMap.partProf }"/></td>
								</tr>
							</tbody>
						</table>
						<div class="meet-title">◈ 수업 담당 교사</div>
						<c:forEach items="${lectList }" var="lect" varStatus="status">
							<c:set value="${timeList.size()* status.index }" var="cnt"/>
							<div class="meet-title"><<c:out value="${lect.lectGrade }"/>급<c:out value="${lect.lectDivi }"/>반></div>
							<table class="meet-pop-table">
								<colgroup>
									<col />
									<col />
									<col />
									<col />
									<col />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<td class="backslash"><div>요일</div>교시</td>
										<td><c:out value="${meetWeek.monday }"/></td>
										<td><c:out value="${meetWeek.tuesday }"/></td>
										<td><c:out value="${meetWeek.wednesday }"/></td>
										<td><c:out value="${meetWeek.thursday }"/></td>
										<td><c:out value="${meetWeek.friday }"/></td>
									</tr>
									<c:forEach items="${timeList }" var="time" varStatus="stat">
										<tr>
											<td><c:out value="${time.clstmCode }"/>교시</td>
											<td><c:out value="${meetProfList[stat.index+cnt].monProfName }"/></td>
											<td><c:out value="${meetProfList[stat.index+cnt].tueProfName }"/></td>
											<td><c:out value="${meetProfList[stat.index+cnt].wedProfName }"/></td>
											<td><c:out value="${meetProfList[stat.index+cnt].thuProfName }"/></td>
											<td><c:out value="${meetProfList[stat.index+cnt].friProfName }"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:forEach>
						<div class="meet-title">◈ 이번 주 수업 진행 사항</div>
						<table class="meet-pop-table">
							<colgroup>
								<col style="width:15%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th></th>
									<th>문제점 및 특이사항</th>
								</tr>
								<tr>
									<th>교과</th>
									<td class="txt-l"><c:out value="${meetLogMap.thisSubject }"/></td>
								</tr>
								<tr>
									<th>학생 관리</th>
									<td class="txt-l"><c:out value="${meetLogMap.thisStdMng }"/></td>
								</tr>
								<tr>
									<th>기타</th>
									<td class="txt-l"><c:out value="${meetLogMap.thisEtc }"/></td>
								</tr>
							</tbody>
						</table>
						<div class="meet-title">◈ 다음 주 수업 계획</div>
						<table class="meet-pop-table">
							<colgroup>
								<col style="width:15%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th>교과</th>
									<td class="txt-l"><c:out value="${meetLogMap.nextSubject }"/></td>
								</tr>
								<tr>
									<th>학생 관리</th>
									<td class="txt-l"><c:out value="${meetLogMap.nextStdMng }"/></td>
								</tr>
								<tr>
									<th>기타</th>
									<td class="txt-l"><c:out value="${meetLogMap.nextEtc }"/></td>
								</tr>
							</tbody>
						</table>
						<div class="meet-title">◈ 공지사항 및 교사 전달사항</div>
						<table class="meet-pop-table">
							<colgroup>
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td class="txt-l"><c:out value="${meetLogMap.notice }" escapeXml="false"/></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="table-button">
				<div class="btn-box">
					<button type="button" class="white" onclick="pageprint(); return false;">인쇄</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>