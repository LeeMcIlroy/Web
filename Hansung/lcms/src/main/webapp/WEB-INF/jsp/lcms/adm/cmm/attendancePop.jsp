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
<link rel="stylesheet" media="screen" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/certipop.css?ver=20200709'/>">
<link rel="stylesheet" media="print" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/certipop.css?ver=20200709'/>">
<style type="text/css" media="print">
html, body { height: auto;}

button {display:none;}

.attend-table-scroll {height:auto;}

.pop-table-box .attend-pop-table {margin-top:0;}
.pop-table-box .attend-pop-table thead {position:static;}

@page {
    size: 70%;  /* auto is the initial value */
    margin: 0 auto;  /* this affects the margin in the printer settings */
	width: 90%;
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
			<div class="attend-contents">
				<div class="pop-table-box">
					<table class="certi-pop-table mb50">
						<colgroup>
							<col>
						</colgroup>
						<tbody>
							<tr>
								<td class="lh25">
									<p><c:out value="${lecture.lectYear }"/>년도 <c:out value="${lecture.lectSemNm }"/> <c:out value="${lecture.lectName }"/> <c:out value="${lecture.lectDivi }"/></p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="table-button">
					<div class="btn-box">
						<caption>"○" = 출석, "Ø" = 지각, "/" = 결석</caption>
						<button type="button" class="white" onclick="pageprint(); return false;">인쇄</button>
					</div>
				</div>
				<div class="pop-table-box attend-table-scroll">
					<table class="attend-pop-table">
						<colgroup>
							<col width="2%"/>
							<col width="10%" />
							<col width="2%" />
							<c:forEach items="${dates }" var="date">
								<col width="2%" />
							</c:forEach>
							<col width="6%" />
						</colgroup>
						<thead>
							<tr>
								<th class="wi-2p" rowspan="4">
									순서
								</th>
								<th class="wi-10p">
									주
								</th>
								<th class="wi-2p" rowspan="4">
									수업시간
								</th>
								<c:forEach items="${weekOfMonth }" var="week" varStatus="status">
									<th colspan="<c:out value='${week }'/>"><c:out value="${status.count }주"/></th>
								</c:forEach>
								<th class="wi-6p" rowspan="4">
									현재<br/>출석률(%)
								</th>
							</tr>
							<tr>
								<th class="wi-10p">
									월
								</th>
								<c:forEach items="${dates }" var="date">
									<th class="wi-2p"><c:out value="${date.month }"/></th>
								</c:forEach>
							</tr>
							<tr>
								<th class="wi-10p">
									일
								</th>
								<c:forEach items="${dates }" var="date">
									<th class="wi-2p"><c:out value="${date.date }"/></th>
								</c:forEach>
							</tr>
							<tr>
								<th class="wi-10p">
									요일
								</th>
								<c:forEach items="${dates }" var="date">
									<th class="wi-2p"><c:out value="${date.week }"/></th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${memberList }" var="member" varStatus="status">
								<c:forEach items="${timeList }" var="time" varStatus="status2">
									<tr>
										<c:if test="${status2.first }">
										<td class="wi-2p" rowspan="<c:out value='${timeList.size() }'/>"><c:out value="${status.count }"/></td>
										<td class="wi-10p" rowspan="<c:out value='${timeList.size() }'/>">
											<c:out value="${member.name }"/><br/>
											<c:if test="${member.funcState ne '' && member.funcState != null }">
												<c:out value="${member.funcState }"/><br/>
											</c:if>
											(<c:out value="${member.memberCode }"/>)
										</td>
										</c:if>
										<td class="wi-2p"><c:out value="${time.clstmCode }"/></td>
										<c:forEach items="${dates }" var="date">
											<c:set var="check" value="0"/>
											<c:forEach items="${attendList }" var="attend">
												<c:if test="${attend.memberCode eq member.memberCode && attend.attDate eq date.currDate && attend.lectClass eq time.clstmCode }">
													<c:set var="check" value="1"/>
													<td class="wi-2p"><c:out value="${attend.attend eq '1'?'○':attend.attend eq '2'?'/':attend.attend eq '3'?'Ø':'' }"/></td>
												</c:if>
											</c:forEach>
											<c:if test="${check eq '0' }">
												<td class="wi-2p">&nbsp;</td>
											</c:if>
										</c:forEach>
										<c:if test="${status2.first }">
											<td class="wi-6p" rowspan="<c:out value='${timeList.size() }'/>">
												<c:out value="${member.cntAttend }"/>/<c:out value="${member.totAttend }"/><br/>
												<c:out value="${member.avgAttend }"/>%
											</td>
										</c:if>
									</tr>
								</c:forEach>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>