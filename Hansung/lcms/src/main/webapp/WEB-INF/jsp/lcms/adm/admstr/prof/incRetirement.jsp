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
								<p>퇴&nbsp;직&nbsp;증&nbsp;명&nbsp;서</p>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="prof-prt-table" id="contentTable">
					<colgroup>
						<col style="width:25%;"/>
						<col />
					</colgroup>
					<tbody class="list">
						<tr>
							<td>1.&nbsp;성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>
							<td>&nbsp;<c:out value="${result.name }"/></td>
						</tr>
						<tr>
							<td>2.&nbsp;생&nbsp;년&nbsp;월&nbsp;일</td>
							<fmt:formatDate value="${result.birth }" var="birth" pattern="yyyy년 MM월 dd일"/>
							<td>&nbsp;<c:out value="${birth }"/></td>
						</tr>
						<tr>
							<td>3.&nbsp;소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;속</td>
							<td>&nbsp;<c:out value="${result.prfTBelong }"/></td>
						</tr>
						<tr>
							<td>4.&nbsp;직종&nbsp;/&nbsp;직위</td>
							<td>&nbsp;<c:out value="${result.prfFGubun }"/></td>
						</tr>
						<tr>
							<td>5.&nbsp;사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;번</td>
							<td>&nbsp;<c:out value="${result.memberCode }"/></td>
						</tr>
						<tr>
							<td>6.&nbsp;임&nbsp;용&nbsp;기&nbsp;간</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: left;">
								<c:forEach items="${appoList }" var="list">
									<fmt:formatDate value="${list.prfFSDate }" pattern="yyyy년 MM월 dd일" var="prfFSDate"/>
									<fmt:parseDate value="${list.prfFEDate }" var="dateFmt" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${dateFmt }" pattern="yyyy년 MM월 dd일" var="prfFEDate"/>
									&nbsp;&nbsp;&nbsp;ㆍ&nbsp;<c:out value="${prfFSDate }"/>&nbsp;~&nbsp;<c:out value="${prfFEDate }"/><br/>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td>7.&nbsp;퇴&nbsp;직&nbsp;일&nbsp;자</td>
							<fmt:formatDate value="${result.resDate }" pattern="yyyy년 MM월 dd일" var="resDate"/>
							<td>
								&nbsp;<c:out value="${resDate }"/>
							</td>
						</tr>
						<tr>
							<td>
								<c:forEach begin="1" end="${12 - appoList.size()}"> 
									<br/>
								</c:forEach>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="prof-prt-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td>
								위의 강사는 <c:out value="${resDate }"/> 한성대학교 국제교류원 한국어 교육과정을<br>
								퇴직하였음을 증명합니다<br>
							</td>
						</tr>
						<tr>
							<td>
								<br/>
								<fmt:parseDate value="${result.prfPDateIssue }" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:formatDate value="${dateFmt }" var="prfPDateIssue" pattern="yyyy년 MM월 dd일"/>
								<c:out value="${prfPDateIssue }"/>
								<br/>
							</td>
						</tr>
				</table>
				<table class="prof-prt-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								<p>한&nbsp;성&nbsp;대&nbsp;학&nbsp;교&nbsp;국&nbsp;제&nbsp;교&nbsp;류&nbsp;원</p><br/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</html>