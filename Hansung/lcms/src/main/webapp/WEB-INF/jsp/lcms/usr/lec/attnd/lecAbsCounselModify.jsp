<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script>
	function fn_save(){
		$("#frm").attr("action", "<c:url value='/usr/lec/attnd/lecAbsCounselSubmit.do'/>").submit();
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">결석자상담</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>출결</span>
						<span>결석자상담</span>
					</div>
				</div>
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
				<!-- 학생정보 -->
				<p class="sub-title">학생 정보</p>
				<div>
					<!-- table -->
					<div class="list-table-box web">
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
					<div class="mob mb20">
						<div class="mob-write">
							<dl>
								<dt>결석일자</dt>
								<dd><c:out value="${absentConsultVO.absentDate }"/>&nbsp;</dd>
							</dl>
							<dl>
								<dt>출석율(%)</dt>
								<dd><c:out value="${absentConsultVO.attRate }"/>&nbsp;</dd>
							</dl>
							<dl>
								<dt>이름</dt>
								<dd><c:out value="${absentConsultVO.memberName }"/>&nbsp;</dd>
							</dl>
							<dl>
								<dt>급/반</dt>
								<dd><c:out value="${absentConsultVO.memberGrade }급"/>&nbsp;<c:out value="${absentConsultVO.lectDivi }"/>&nbsp;</dd>
							</dl>
							<dl>
								<dt>국적</dt>
								<dd><c:out value="${absentConsultVO.memberNation }"/>&nbsp;</dd>
							</dl>
						</div>
					</div>
					<!--// table -->
				</div>
				<!-- //학생정보 -->
				<!-- 1차상담 -->
				<p class="sub-title">1차 상담</p>
				<div>
					<!-- table -->
					<div class="list-table-box web">
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
										<form:checkbox path="firstTel" label=" 전화" value="Y"/>&nbsp;&nbsp;
										<form:checkbox path="firstSns" label=" SNS" value="Y"/>&nbsp;&nbsp;
										<form:checkbox path="firstTeam" label=" 국제교류팀" value="Y"/>&nbsp;&nbsp;
										<form:checkbox path="firstEtc" label=" 기타" value="Y"/>
									</td>
								</tr>
								<tr>
									<th>결석사유</th>
									<td colspan="3"><form:textarea path="firstReason" cols="130" rows="6"/></td>
								</tr>
								<tr>
									<th>후속조치</th>
									<td colspan="3"><form:textarea path="firstFolup" cols="130" rows="6"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="mob mb20">
						<div class="mob-write">
							<dl>
								<dt>상담자</dt>
								<dd><c:out value="${absentConsultVO.firstSelorName }"/>&nbsp;</dd>
							</dl>
							<dl>
								<dt>상담방법</dt>
								<dd>
									<form:checkbox path="firstTel" label=" 전화" value="Y"/>&nbsp;&nbsp;
									<form:checkbox path="firstSns" label=" SNS" value="Y"/>&nbsp;&nbsp;
									<form:checkbox path="firstTeam" label=" 국제교류팀" value="Y"/>&nbsp;&nbsp;
									<form:checkbox path="firstEtc" label=" 기타" value="Y"/>&nbsp;
								</dd>
							</dl>
							<dl>
								<dt>결석사유</dt>
								<dd><form:textarea path="firstReason" cols="40" rows="10"/>&nbsp;</dd>
							</dl>
							<dl>
								<dt>후속조치</dt>
								<dd><form:textarea path="firstFolup" cols="40" rows="10"/>&nbsp;</dd>
							</dl>
						</div>
					</div>
					<!--// table -->
				</div>
				<!-- //1차상담 -->
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/attnd/lecAbsCounselList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
					</div>
				</div>
				<!--// table button -->
				</form:form>
				<!-- 2차상담 -->
				<c:if test="${absentConsultVO.secondYn eq 'Y' }">
					<p class="sub-title">2차 상담</p>
					<div>
						<!-- table -->
						<div class="list-table-box web">
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
											<c:out value="${absentConsultVO.secondTel eq 'Y'?'전화':'' }"/>
											<c:out value="${absentConsultVO.secondSns eq 'Y'?absentConsultVO.secondTel eq 'Y'?', SNS':'SNS':'' }"/>
											<c:out value="${absentConsultVO.secondTeam eq 'Y'?(absentConsultVO.secondSns eq 'Y' || absentConsultVO.secondTel eq 'Y')?', 국제교류팀':'국제교류팀':'' }"/>
											<c:out value="${absentConsultVO.secondEtc eq 'Y'?(absentConsultVO.secondTeam eq 'Y' || absentConsultVO.secondSns eq 'Y' || absentConsultVO.secondTel eq 'Y')?', 기타':'기타':'' }"/>
										</td>
									</tr>
									<tr>
										<th>결석사유</th>
										<td colspan="3"><c:out value="${absentConsultVO.secondReason }"/></td>
									</tr>
									<tr>
										<th>후속조치</th>
										<td colspan="3"><c:out value="${absentConsultVO.secondFolup }"/></td>
									</tr>
								</tbody>
							</table>
						</div><div class="mob mb20">
						<div class="mob-write">
							<dl>
								<dt>상담자</dt>
								<dd><c:out value="${absentConsultVO.secondSelorName }"/>&nbsp;</dd>
							</dl>
							<dl>
								<dt>상담방법</dt>
								<dd>
									<c:out value="${absentConsultVO.secondTel eq 'Y'?'전화':'' }"/>
									<c:out value="${absentConsultVO.secondSns eq 'Y'?absentConsultVO.secondTel eq 'Y'?', SNS':'SNS':'' }"/>
									<c:out value="${absentConsultVO.secondTeam eq 'Y'?(absentConsultVO.secondSns eq 'Y' || absentConsultVO.secondTel eq 'Y')?', 국제교류팀':'국제교류팀':'' }"/>
									<c:out value="${absentConsultVO.secondEtc eq 'Y'?(absentConsultVO.secondTeam eq 'Y' || absentConsultVO.secondSns eq 'Y' || absentConsultVO.secondTel eq 'Y')?', 기타':'기타':'' }"/>
								&nbsp;</dd>
							</dl>
							<dl>
								<dt>결석사유</dt>
								<dd><c:out value="${absentConsultVO.secondReason }"/>&nbsp;</dd>
							</dl>
							<dl>
								<dt>후속조치</dt>
								<dd><c:out value="${absentConsultVO.secondFolup }"/>&nbsp;</dd>
							</dl>
						</div>
					</div>
						<!--// table -->
					</div>
				</c:if>
				<!-- //2차상담 -->
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->
	<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
</body>
</html>