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
	<div class="pop-list-box">
		<div class="contents">
			<div class="pop-table-box">
				<table class="prof-prt-table">
					<colgroup>
						<col style="width:25%;"/>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								<p>교&nbsp;사&nbsp;명&nbsp;단</p>
							</td>
						</tr>
						<tr>
							<td>
								<c:if test="${semList.size() eq 1 }">
									<c:forEach items="${semList}" var="list" >
										<c:out value="${list.semYear }"/>년&nbsp;<c:out value="${list.semester }"/>&nbsp;(<c:out value="${list.enterRegiS}"/>&nbsp;~&nbsp;<c:out value="${list.enterRegiE }"/>)
									</c:forEach>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="prof-list-table" id="contentTable">
					<colgroup>
						<col width="15%"/>
						<col width="15%"/>
						<col width="25%"/>
						<col />
					</colgroup>
					<tbody class="list">
						<c:forEach items="${resultList }" var="result">
							<tr>
								<td rowspan="4"><img src="<c:url value='/showImage.do?filePath=${result.imgPath}'/>"  alt="<c:out value="${result.imgName}"/>" style="width:140px; height:170px; text-align: center;" onerror="this.src='<c:url value='/assets/adm/img/nophoto.jpg'/>'"/></td>
								<td><c:out value="${result.name }"/></td>
								<td><c:out value="${result.memberCode }"/></td>
								<td><c:out value="${result.prfSStep }"/>/<c:out value="${result.prfSDivi }"/>/<c:out value="${result.prfSPosition }"/></td>
							</tr>
							<tr>
								<td><c:out value="${result.birth }"/></td>
								<td><c:out value="${result.prfFGubun }"/>/<c:out value="${result.prfFGrade }"/></td>
								<fmt:parseNumber var="sumhour" value="${result.sumhour }" integerOnly="true" />
								<td><c:out value="${result.prfFHour }"/>/${sumhour }</td>
							</tr>
							<tr>
								<td><c:out value="${result.appDate }"/></td>
								<td><c:out value="${result.prfTBelong }"/> <c:out value="${result.prfTPosition }"/></td>
								<td><c:out value="${result.lectWeek }"/></td>
							</tr>
							<tr>
								<td><c:out value="${result.tel }"/></td>
								<td><c:out value="${result.email }"/></td>
								<td><c:out value="${result.addr1 }"/> <c:out value="${result.addr2 }"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</html>