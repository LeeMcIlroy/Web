<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<style type="text/css" media="print">
	body {
		zoom: 70%;
		margin-top: 10%;
	}
</style>
<html lang="ko">
	<div class="pop-box">
		<div class="contents">
			<div class="pop-table-box">
				<table class="head-pop-table">
					<colgroup>
						<col />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>
								발급번호:<c:out value="${certiVO.certiNum }"/><br/>
								한성대학교 국제교류원 한국어과정<br/>
								Institute of Language Education<br/>
								Korean Program
							</td>
							<td>
								HANSUNG UNIVERSITY<br/>
								116 Samseon-gyoro 16,<br/>
								Seoul, KOREA<br/>
								(Tel) +82-2-760-4374
							</td>
						</tr>
					</tbody>
				</table>
				<table class="stdship-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								<p>재&nbsp;학&nbsp;증&nbsp;명&nbsp;서</p><br/>
								Certificate of Studentship
							</td>
						</tr>
					</tbody>
				</table>
				<table class="stdship-pop-table std">
					<colgroup>
						<col style="width:38%;"/>
						<col />
					</colgroup>
					<tbody class="list">
						<tr>
							<td>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름 (Name in Full)</td>
							<td><c:out value="${certiVO.name }"/> (<c:out value="${certiVO.eName }"/>)</td>
						</tr>
						<tr>
							<td>생&nbsp;년&nbsp;월&nbsp;일 (Date of Birth)</td>
							<td><c:out value="${certiVO.birth }"/></td>
						</tr>
						<tr>
							<td>국&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;적 (Nationality)</td>
							<td><c:out value="${certiVO.nation }"/></td>
						</tr>
						<tr>
							<td>여&nbsp;권&nbsp;번&nbsp;호 (Passport No.)</td>
							<td><c:out value="${certiVO.pNumber }"/></td>
						</tr>
						<tr>
							<td>재&nbsp;학&nbsp;기&nbsp;간 (Period of Study)</td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<table class="grade-pop-table mt10">
					<colgroup>
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>교육기간</td>
							<td>강의명</td>
							<td>급수</td>
							<td>출석시간(출석률)</td>
						</tr>
						<c:forEach items="${resultList }" var="result">
							<tr>
								<td><c:out value="${result.enterRegiS }"/> ~ <c:out value="${result.enterRegiE }"/></td>
								<td><c:out value="${result.lectName }"/></td>
								<td><c:out value="${result.grade }"/>급</td>
								<td><c:out value="${result.attend }"/>시간 / <c:out value="${result.totAttend }"/>시간 (<c:out value="${result.attPer }"/>%)</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<table class="stdship-pop-table std">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>
								위 학생은 한성대학교 국제교류원 한국어교육과정에 재학하고 있음을 증명합니다.<br/>
								This is to certify that above student is studying Korean language program<br/>
								at Hansung Institute of Language Education as of this date
							</td>
						</tr>
				</table>
				<table class="stdship-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>
								<c:out value="${certiVO.certiDate }"/>
							</td>
						</tr>
				</table>
				<table class="stdship-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								<p>한&nbsp;성&nbsp;대&nbsp;학&nbsp;교&nbsp;&nbsp;국&nbsp;제&nbsp;교&nbsp;류&nbsp;원&nbsp;장</p><br/>
								Institute of Language Education Hansung University
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</html>