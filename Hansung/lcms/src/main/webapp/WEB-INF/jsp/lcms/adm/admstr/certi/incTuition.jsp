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
		zoom: 75%;
		margin-top: 10%;
	}
</style>
	<div class="pop-box">
		<div class="contents mt20 pb50 solbox">
			<div class="pop-table-box">
				<table class="certi-pop-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								한국어프로그램 수강료납부 확인증<br/>
								CERTIFICATE OF TUITION PAID FOR KOREAN PROGRAM
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
							<td class="txt-r">
								이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름
							</td>
							<td><c:out value="${certiVO.name }"/> (<c:out value="${certiVO.eName }"/>)</td>
						</tr>
						<tr>
							<td class="txt-r">
								생&nbsp;&nbsp;년&nbsp;&nbsp;월&nbsp;&nbsp;일
							</td>
							<td><c:out value="${certiVO.birth }"/></td>
						</tr>
						<tr>
							<td class="txt-r">
								납&nbsp;&nbsp;부&nbsp;&nbsp;내&nbsp;&nbsp;역
							</td>
							<td></td>
						</tr>
						<tr>
							<td class="lh25 txt-l" colspan="2">
								(Details of Total Amount Paid)
							</td>
						</tr>
					</tbody>
				</table>
				<table class="grade-pop-table mt10 ml10 w90pc">
					<colgroup>
						<col />
						<col />
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="txt-l">보험료 Insurance</td>
							<td class="txt-r"><fmt:parseNumber value="${resultMap.insuFee }" integerOnly="true"/></td>
							<td></td>
						</tr>
						<tr>
							<td class="txt-l">입학금 Application fee</td>
							<td class="txt-r"><fmt:parseNumber value="${resultMap.enterFee }" integerOnly="true"/></td>
							<td>환불불가 Non-refundable</td>
						</tr>
						<tr>
							<td class="txt-l">등록금 Tuition fee</td>
							<td class="txt-r"><fmt:parseNumber value="${resultMap.regFee }" integerOnly="true"/></td>
							<td></td>
						</tr>
						<tr>
							<td>합계 Total</td>
							<td class="txt-r"><fmt:parseNumber value="${resultMap.insuFee + resultMap.enterFee + resultMap.regFee }" integerOnly="true"/></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<table class="certi-pop-table std mt10">
					<colgroup>
						<col />
					</colgroup>
					<tbody class="list">
						<tr>
							<td class="lh25 txt-l">
								납부 해당기간 : <c:out value="${resultMap.stDate }"/> ~ <c:out value="${resultMap.edDate }"/>
							</td>
						</tr>
						<tr>
							<td class="lh25 txt-l">
								(Study Period by Payment)
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
								상기금액을 납부하였음을 확인함.<br/>
								<c:out value="${resultMap.numDate }"/><br/>
								We hereby certify that he/she<br/>
								has paid his/her tuition as stated above.
							</td>
						</tr>
						<tr>
							<td><c:out value="${resultMap.engDate }"/></td>
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