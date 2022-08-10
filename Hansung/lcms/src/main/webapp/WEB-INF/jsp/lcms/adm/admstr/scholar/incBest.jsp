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
								발급번호:<c:out value="${resultMap.scholarNum }"/><br/>
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
								<p>우&nbsp;수&nbsp;상</p>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="certi-pop-table">
					<colgroup>
						<col style="width:25%;"/>
						<col />
					</colgroup>
					<tbody class="list">
						<tr>
							<td>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</td>
							<td><c:out value="${resultMap.name }"/> (<c:out value="${resultMap.eName }"/>)</td>
						</tr>
						<tr>
							<td>국&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;적</td>
							<td><c:out value="${resultMap.nation }"/></td>
						</tr>
						<tr>
							<td>단&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;계</td>
							<td><c:out value="${resultMap.step }"/> 급 (Level <c:out value="${resultMap.step }"/>)</td>
						</tr>
						<tr>
							<td>학&nbsp;습&nbsp;기&nbsp;간</td>
							<td><c:out value="${resultMap.enterRegiS }"/> ~ <c:out value="${resultMap.enterRegiE }"/></td>
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
								위의 사람은 한성대학교 국제교류원 한국어과정에서<br/>
								<c:out value="${resultMap.year }"/>학년도 <c:out value="${resultMap.semeNm }"/> 동안 열심히 공부하여 우수한 성적을<br/>
								거두었기에 이 상장을 수여합니다.
							</td>
						</tr>
				</table>
				<table class="certi-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>
								<c:out value="${resultMap.scholarDate }"/>
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