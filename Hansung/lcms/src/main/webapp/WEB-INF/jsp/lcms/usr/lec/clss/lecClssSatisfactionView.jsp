<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<body>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<div class="pop-content">
				<form:form commandName="surveyAnswVO" id="frm" name="frm">
					<!-- table -->
					<c:forEach items="${resultList }" var="result" varStatus="status">
					<%-- <p class="sub-title">
						<img alt="<c:out value='${prof.imgName }'/>" src="<c:url value='/showImage.do?filePath=${prof.imgPath }'/>" style="width:113px; height:151px;">
						선생님 : <c:out value="${prof.name }"/>
					</p> --%>
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:40%;"/>
								<col />
								<col />
							</colgroup>
							<thead>
								<tr>
									<th>구분</th>
									<th>질문</th>
									<th>평균</th>
									<th>총점</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr>
										<td><c:out value="${result.phrTitle }"/></td>
										<td><c:out value="${result.question }"/></td>
										<td class="txt-c"><c:out value="${result.avgAnsw }"/></td>
										<c:if test="${status.first }">
											<td class="txt-c" rowspan="<c:out value='${resultList.size() }'/>"><c:out value="${result.totAnsw }"/></td>
										</c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					</c:forEach>
				</form:form>
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="#" class="white btn-cancel">취소</a>
					</div>
				</div>
				<!--// table button -->
			</div>
		</div>
	</div>
	<!--// contents -->
</body>
</html>