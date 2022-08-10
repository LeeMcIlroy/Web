<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<style type="text/css" media="print">
	body {
		zoom: 70%;
		margin-top: 10%;
	}
</style>
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
								발급번호:<c:out value="${result.certiNum }"/><br/>
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
				<table class="certi-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								<p><c:out value="${result.semYear }"/>년도 여름학기 성적표</p>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="certi-pop-table std">
					<colgroup>
						<col style="width:20%;"/>
						<col />
					</colgroup>
					<tbody class="list">
						<tr>
							<td class="lh25 txt-r">
								이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름<br/>
								(&nbsp;&nbsp;N&nbsp;a&nbsp;m&nbsp;e&nbsp;&nbsp;)
							</td>
							<td class="lh25"><c:out value="${result.name }"/> (<c:out value="${result.eName }"/>)</td>
						</tr>
						<tr>
							<td class="lh25 txt-r">
								단&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;계<br/>
								(&nbsp;L&nbsp;e&nbsp;v&nbsp;e&nbsp;l&nbsp;)
							</td>
							<td class="lh25"><c:out value="${result.grade }"/> 급 (Level <c:out value="${result.grade }"/>)</td>
						</tr>
						<tr>
							<td class="lh25 txt-r">
								학&nbsp;&nbsp;습&nbsp;&nbsp;기&nbsp;&nbsp;간<br/>
								(&nbsp;&nbsp;T&nbsp;e&nbsp;r&nbsp;m&nbsp;&nbsp;)
							</td>
							<td class="lh25"><c:out value="${result.enterRegiS }"/> ~ <c:out value="${result.enterRegiE }"/></td>
						</tr>
						<tr>
							<td class="lh25 txt-r">
								출&nbsp;&nbsp;석&nbsp;&nbsp;시&nbsp;&nbsp;간<br/>
								<span style="font-size:12pt;">(Attendance Hour)</span>
							</td>
							<td class="lh25"><c:out value="${result.attend }"/> / 200 시간</td>
						</tr>
						<tr>
							<td class="lh25 txt-r">
								성&nbsp;&nbsp;적&nbsp;&nbsp;평&nbsp;&nbsp;균<br/>
								(&nbsp;G&nbsp;r&nbsp;a&nbsp;d&nbsp;e&nbsp;)
							</td>
							<td class="lh25"><c:out value="${result.gradeAvg }"/> / 100 점</td>
						</tr>
					</tbody>
				</table>
				<table class="grade-pop-table">
					<colgroup>
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td colspan="2">
								영역<br/>
								(Skills)
							</td>
							<td>
								성적<br/>
								(Point)
							</td>
							<td>
								담당교수 의견<br/>
								(Teacher's Comments)
							</td>
						</tr>
						<tr>
							<td rowspan="2">
								표현능력<br/>
								(Presentation)
							</td>
							<td>
								말하기<br/>
								(Speaking)
							</td>
							<td>
								<c:out value="${result.gradeExprSpeak }"/>
							</td>
							<td rowspan="4">
								<c:out value="${result.evalue }" escapeXml="false"/>
							</td>
						</tr>
						<tr>
							<td>
								쓰기<br/>
								(Writing)
							</td>
							<td>
								<c:out value="${result.gradeExprWrite }"/>
							</td>
						</tr>
						<tr>
							<td rowspan="2">
								이해능력<br/>
								(Comprehension)
							</td>
							<td>
								듣기<br/>
								(Listening)
							</td>
							<td>
								<c:out value="${result.gradeCompListen }"/>
							</td>
						</tr>
						<tr>
							<td>
								읽기<br/>
								(Reading)
							</td>
							<td>
								<c:out value="${result.gradeCompRead }"/>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="certi-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>
								<c:out value="${result.certiDate }"/>
							</td>
						</tr>
						<tr>
							<td>
								담당교수 : <c:out value="${result.lectClaTea }"/>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="certi-pop-table">
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