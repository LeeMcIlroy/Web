<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	   	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<style type="text/css" media="print">
/* 	body {
		zoom: 70%;
		margin-top: 10%;
	} */
</style>
	<div class="pop-box">
		<div class="contents">
			<div class="pop-table-box">
				<table class="prof-prt-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								<p>출&nbsp;석&nbsp;&nbsp;경&nbsp;고</p>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
								<c:forEach items="${resultList }" var="list" begin="0" end="0">
									<span>(<c:out value="${list.absYear }"/>년 <c:out value="${list.absSem }"/>)</span>
								</c:forEach>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="prof-list-table" id="contentTable">
					<colgroup>
						<col style="width:10%;"/>
						<col style="width:35%;"/>
						<col style="width:45%;"/>
						<col style="width:10%;"/>
					</colgroup>
					<tbody class="list">
						<c:forEach items="${resultList }" var="list">
							<tr>
								<td></td>
								<td><c:out value="${list.absGrade }"/> <c:out value="${list.absDivi }"/></td>
								<td><c:out value="${list.absName }"/></td>
								<td></td>
							</tr>
						</c:forEach>
						<c:forEach begin="1" end="${15 - resultList.size()}"> 
							<tr>
								<td>&nbsp;</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<table class="prof-list-bot-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>
								<p>
									※ 출석률 80%가 넘지 않으면 유급입니다.<br/>
									※ 출석률이 나쁘면 비자가 취소될 수 있습니다.
								</p>
							</td>
						</tr>
				</table>
			</div>
		</div>
	</div>
</html>