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
	<div class="pop-box_grade">
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
				<table class="certi-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								<p><c:out value="${certiVO.semYear }"/>년도 <c:out value="${resultMap.semeNm }"/> 성적표</p><br/>
								(Transcript for <c:out value="${certiVO.semYear }"/> <c:out value="${resultMap.semeEnm }"/>)
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
							<td class="lh25 pb15">
								이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름<br/>
								<span style="font-size:16pt;">(&nbsp;N&nbsp;a&nbsp;m&nbsp;e&nbsp;)</span>
							</td>
							<td class="lh25"><c:out value="${certiVO.name }"/> (<c:out value="${certiVO.eName }"/>)</td>
						</tr>
						<tr>
							<td class="lh25 pb15">
								단&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;계<br/>
								<span style="font-size:16pt;">(L&nbsp;e&nbsp;v&nbsp;e&nbsp;l)</span>
							</td>
							<td class="lh25"><c:out value="${resultMap.grade }"/> 급 (Level <c:out value="${resultMap.grade }"/>)</td>
						</tr>
						<tr>
							<td class="lh25 pb15">
								학&nbsp;습&nbsp;기&nbsp;간<br/>
								<span style="font-size:16pt;">(&nbsp;T&nbsp;e&nbsp;r&nbsp;m&nbsp;)</span>
							</td>
							<td class="lh25"><c:out value="${resultMap.enterRegiS }"/> ~ <c:out value="${resultMap.enterRegiE }"/></td>
						</tr>
						<tr>
							<td class="lh25 pb15">
								출&nbsp;석&nbsp;시&nbsp;간<br/>
								<span style="font-size:12pt;">(Attendance Hour)</span>
							</td>
							<c:if test="${resultMap.lectNm eq '온라인반' }">
								<td class="lh25"><c:out value="${resultMap.attend }"/> / 150 시간</td>
						    </c:if>
							<c:if test="${resultMap.lectNm ne '온라인반' }">
								<td class="lh25"><c:out value="${resultMap.attend }"/> / 200 시간</td>
						    </c:if>
						

						</tr>
						<tr>
							<td class="lh25">
								성&nbsp;적&nbsp;평&nbsp;균<br/>
								<span style="font-size:16pt;">(G&nbsp;r&nbsp;a&nbsp;d&nbsp;e)</span>
							</td>
							<td class="lh25"><c:out value="${resultMap.gradeAvg }"/> / 100 점</td>
								
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
								<c:out value="${resultMap.gradeExprSpeak }"/>
							</td>
							<td rowspan="4" style="text-align:justify;">
								<c:out value="${resultMap.evalue }" escapeXml="false"/>
							</td>
						</tr>
						<tr>
							<td>
								쓰기<br/>
								(Writing)
							</td>
							<td>
								<c:out value="${resultMap.gradeExprWrite }"/>
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
								<c:out value="${resultMap.gradeCompListen }"/>
							</td>
						</tr>
						<tr>
							<td>
								읽기<br/>
								(Reading)
							</td>
							<td>
								<c:out value="${resultMap.gradeCompRead }"/>
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
								<c:out value="${resultMap.enterRegiE }"/>
							</td>
						</tr>
						<tr>
							<td>
								담당교수 : <c:out value="${resultMap.lectClaTea }"/>
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
								<p>한성대학교 국제교류원장</p><br/>
								Institute of Language Education Hansung University
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</html>