<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<body>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">데이터연계현황</div>
			<!--// PAGE_TITLE -->
			<div class="content">
				<div class="cont_box white_bg">
					<!-- 단일 GRAPH_BOX -->
					<div class="box_div_1" style="margin-bottom:0;">
						<div>
							<!-- box graph table -->
							<table class="box_table_t01">
								<colgroup>
									<col width="10%" />
									<col width="%" />
									<col width="%" />
									<col width="%" />
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>종류</th>
										<th>제공처</th>
										<th>최근 Update 일시</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${resultList }" var="result" varStatus="status">
										<tr>
											<td><c:out value="${resultList.size() - status.index }"/></td>
											<td><c:out value="${result.type }"/></td>
											<td><c:out value="${result.type2 }"/></td>
											<td><c:out value="${result.regDttm }"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 웹페이징 -->
							<!-- // 웹페이징 -->
						</div>
					</div>
					<!--// 단일 GRAPH_BOX -->
				</div>
			</div>
		</div>
	</div>
	<!-- footer - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=inc/incFooter"/>
	<!-- footer - end -->
<input type="hidden" id="message" name="message" value="${message }">
</body>
</html>