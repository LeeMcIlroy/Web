<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
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
								<!-- 한성대학교 국제교류원 한국어과정<br/>
								Institute of Language Education<br/>
								Korean Program -->
							</td>
							<td>
								<!-- HANSUNG UNIVERSITY<br/>
								116 Samseon-gyoro 16,<br/>
								Seoul, KOREA<br/>
								(Tel) +82-2-760-4374 -->
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
								<p>성&nbsp;적&nbsp;증&nbsp;명&nbsp;서</p>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="gcard-pop-table ml50">
					<colgroup>
						<col style="width:36%;"/>
						<col />
					</colgroup>
					<tbody class="list">
						<tr>
							<td>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름 (Name in Full)</td>
							<td><c:out value="${certiVO.name }"/> (<c:out value="${certiVO.eName }"/>)</td>
						</tr>
						<tr>
							<td>생&nbsp;년&nbsp;월&nbsp;일 ( Date of Birth )</td>
							<td><c:out value="${certiVO.birth }"/></td>
						</tr>
						<tr>
							<td>국&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;적 ( Nationality )</td>
							<td><c:out value="${certiVO.nation }"/></td>
						</tr>
						<tr>
							<td>학&nbsp;습&nbsp;기&nbsp;간 ( T e r m )</td>
							<td><c:out value="${resultMap.enterRegiS }"/> ~ <c:out value="${resultMap.enterRegiE }"/></td>
						</tr>
						<tr>
							<td>성&nbsp;적&nbsp;현&nbsp;황 ( G r a d e )</td>
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
						<col />
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>교육기간</td>
							<td>급수</td>
							<td>말하기</td>
							<td>쓰기</td>
							<td>듣기</td>
							<td>읽기</td>
							<td>평균</td>
							<td>수료여부</td>
							<td>출석시간</td>
						</tr>
						<c:forEach items="${resultList }" var="result">
							<tr>
								<td><c:out value="${result.enterRegiS }"/> ~ <c:out value="${result.enterRegiE }"/></td>
								<td><c:out value="${result.grade }"/> 급</td>
								<td><c:out value="${result.gradeExprSpeak }"/></td>
								<td><c:out value="${result.gradeExprWrite }"/></td>
								<td><c:out value="${result.gradeCompListen }"/></td>
								<td><c:out value="${result.gradeCompRead }"/></td>
								<td><c:out value="${result.gradeAvg }"/></td>
								<td><c:out value="${result.compleSta }"/></td>
								<td><c:out value="${result.attend }"/>/200</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- <table class="certi-pop-table std">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>
							</td>
						</tr>
				</table> -->
				<table class="certi-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>
								<c:out value="${certiVO.certiDate }"/>
							</td>
						</tr>
						<tr>
							<td>
								담당교수 : <c:out value="${resultMap.lectClaTea }"/>
							</td>
						</tr>
				</table>
				<table class="certi-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								<p>한성대학교&nbsp;국제교류원장</p><br/>
								Institute of Language Education Hansung University
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</html>