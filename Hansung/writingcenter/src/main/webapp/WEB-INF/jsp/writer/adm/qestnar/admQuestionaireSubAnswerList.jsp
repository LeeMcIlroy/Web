<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<body>
	<!-- 타이틀 영역 - s -->
	<div class="title_area">
		<h3>설문조사 주관식 답변 목록</h3>
	</div>
	<!-- 타이틀 영역 - e -->
	<div class="cont_box">
	<!-- content -->
		<table class="list_tbl_03 mt30" summary="설문조사 목록">
			<caption>설문조사</caption>
			<colgroup>
				<col style="width:15%" />
				<col style="width:15%" />
				<col style="width:*" />
			</colgroup>
			<thead>
				<tr class="first">
					<th scope="col">학번</th>
					<th scope="col">이름</th>
					<th scope="col">주관식 답변</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${subAnswerList }" var="subAnswer">
					<tr>
						<td><c:out value="${subAnswer.psnHakbun }"/></td>
						<td><c:out value="${subAnswer.psnName }"/></td>
						<td style="text-align: left;"><c:out value="${subAnswer.pansTxt }" escapeXml="false"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	<!-- //content -->
	</div>
</body>
</html>