<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
<style>
@page {
    size: 70%;  /* auto is the initial value */
    margin: 0 auto;  /* this affects the margin in the printer settings */
}
</style>
<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy. MM. dd");
	String strdate = simpleDate.format(date);
%>
	<div class="pop-dvs-box">
		<div class="contents">
			<div class="pop-table-box">
				<table class="dvs-top-table-header">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								<c:forEach items="${resultList }" var="list" begin="0" end="0">
									<p><c:out value="${list.lectYear }"/>년 <c:out value="${list.lectSem }"/> 한국어과정 분반표(<%= strdate %>)</p>
								</c:forEach>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<br/>
			<div class="pop-table-box">
				<table class="dvs-top-table-header">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td style="text-align: right;">
								<span style="color:#FF0000;">신입생(빨간색)</span>, <span style="color:#FF48FF;">유급생(분홍색)</span>, <span style="color:black;">과정생(검은색)</span>, <span style="color:#007200;">교환학생(초록색)</span>, <span style="color:#0000FF; margin-right: 50px;">학부생(파란색)</span><br/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<br/>
			<div class="dvs-table-box">
				<table class="dvs-list-table">
					<colgroup>
						<col />
						<col width="2%"/>
						<col width="2%"/>
						<col width="20%"/>
						<col width="32%"/>
						<col width="17%"/>
						<col width="17%"/>
						<col width="11%"/>
						<col width="6%"/>
						<col width="6%"/>
						<col width="5%"/>
						<col />
					</colgroup>
					<thead>
						<tr>
							<td class="hide"></td>
							<th rowspan="3" colspan="2">급</th>
							<th colspan="5">학생분류</th>
							<th rowspan="3">강의실</th>
							<th rowspan="3">담당강사</th>
							<th rowspan="3">명</th>
							<td class="hide"></td>
						</tr>
						<tr>
							<td class="hide"></td>
							<th colspan="2">한국어과정생</th>
							<th colspan="2">교환학생</th>
							<th rowspan="2">학부생</th>
							<td class="hide"></td>
						</tr>
						<tr>
							<td class="hide"></td>
							<th>신입</th>
							<th>기존</th>
							<th>신입</th>
							<th>기존</th>
							<td class="hide"></td>
						</tr>
					</thead>
						<c:set var="cnt1" value="0"/>
						<c:set var="cnt2" value="0"/>
						<c:set var="cnt3" value="0"/>
						<c:set var="cnt4" value="0"/>
						<c:set var="cnt5" value="0"/>
						<c:set var="totCnt" value="0"/>
					<tbody>
<%-- 						<c:forEach items="${resultList }" var="list" varStatus="i"> --%>
							<c:forEach items="${stdList }" var="std">
<%-- 								<c:if test="${std.lectSeq eq list.lectSeq }"> --%>
									<tr>
										<td class="hide"></td>
										<td><c:out value="${std.lectGrade }"/></td>
										<td><c:out value="${std.lectDivi }"/></td>
										<td style="color:#FF0000;">
											<c:out value="${std.type1}"/>
											<c:set var="cnt1" value="${cnt1 + std.cnt1}"/>
											<c:set var="totCnt" value="${totCnt + std.cnt1}"/>
										</td>
										<td>
											<span style="color:#FF48FF;"><c:out value="${std.type3}"/></span>
											<c:out value="${std.type2}"/>
											<c:set var="cnt2" value="${cnt2 + std.cnt2}"/>
											<c:set var="cnt2" value="${cnt2 + std.cnt3}"/>
											<c:set var="totCnt" value="${totCnt + std.cnt2}"/>
											<c:set var="totCnt" value="${totCnt + std.cnt3}"/>
										</td>
										<td style="color:#007200;">
											<c:out value="${std.type4}"/>
											<c:set var="cnt3" value="${cnt3 + std.cnt4}"/>
											<c:set var="totCnt" value="${totCnt + std.cnt4}"/>
										</td>
										<td style="color:#007200;">
											<c:out value="${std.type5}"/>
											<c:set var="cnt4" value="${cnt4 + std.cnt5}"/>
											<c:set var="totCnt" value="${totCnt + std.cnt5}"/>
										</td>
										<td style="color:#0000FF;">
											<c:out value="${std.type6}"/>
											<c:set var="cnt5" value="${cnt5 + std.cnt6}"/>
											<c:set var="totCnt" value="${totCnt + std.cnt6}"/>
										</td>
										<td><c:out value="${std.lectClassroom }"/></td>
										<td><c:out value="${std.name }"/></td>
										<td>
											<c:out value="${std.cnt}"/>
										</td>
										<td class="hide"></td>
									</tr>
<%-- 								</c:if> --%>
							</c:forEach>
<%-- 						</c:forEach> --%>
						<tr>
							<td class="hide"></td>
							<th colspan="2">계</th>
							<th style="color:#FF0000;"><c:out value="${cnt1 }"/></th>
							<th style="color:#FF48FF;"><c:out value="${cnt2 }"/></th>
							<th style="color:#007200;"><c:out value="${cnt3 }"/></th>
							<th style="color:#007200;"><c:out value="${cnt4 }"/></th>
							<th style="color:#0000FF;"><c:out value="${cnt5 }"/></th>
							<th colspan="3"><c:out value="${totCnt }"/>(명)</th>
							<td class="hide"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</html>