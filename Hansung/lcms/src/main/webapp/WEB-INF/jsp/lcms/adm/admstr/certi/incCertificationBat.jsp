<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<style type="text/css" media="print">
	body {
		zoom: 70%;
		margin-top: 10%;
	}

	td {
		font-weight: bold;
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
								한성대학교 국제교류원 한국어교육과정<br/>
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
								<p>수&nbsp;료&nbsp;증</p><br/>
								CERTIFICATION
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
							<td><c:out value="${result.name }"/> (<c:out value="${result.eName }"/>)</td>
						</tr>
						<tr>
							<td>단&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;계</td>
							<td><c:out value="${result.grade }"/> 급 (Level <c:out value="${result.grade }"/>)</td>
						</tr>
						<tr>
							<td>학&nbsp;습&nbsp;기&nbsp;간</td>
							<td><c:out value="${result.enterRegiS }"/> ~ <c:out value="${result.enterRegiE }"/></td>
						</tr>
						<tr>
							<td>수&nbsp;료&nbsp;번&nbsp;호</td>
							<td><c:out value="${result.compleNum }"/></td>
						</tr>
					</tbody>
				</table>
				<table class="certi-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td style="word-spacing:-6px;">
								위의 사람은 한성대학교 국제교류원 언어교육센터<br/>
								<c:out value="${result.lectYear }"/>학년도 <c:out value="${result.semeNm }"/> 한국어교육과정을 훌륭하게 수료하였습니다.
							</td>
						</tr>
				</table>
				<table class="certi-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="eng">
								THIS IS TO CERTIFY THAT <c:out value="${result.eName }"/> HAS COMPLETED WITH<br/>
								EXCEPTIONAL ATTENDANCCE THE <c:out value="${fn:toUpperCase(result.semeEnm) }"/> <c:out value="${result.lectYear }"/> COURSE OF KOREAN PROGRAM<br/>
								LEVEL <c:out value="${result.grade }"/> 급 (Level <c:out value="${result.grade }"/>) FROM <c:out value="${result.regiS }"/> TO <c:out value="${result.regiE }"/>,<br/>
								OFFERED BY THE HANSUNG INSTITUTE OF LANGUAGE EDUCATION.<br/>
								<c:out value="${result.regiE }"/>
							</td>
						</tr>
				</table>
				<table class="certi-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25 pt85">
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