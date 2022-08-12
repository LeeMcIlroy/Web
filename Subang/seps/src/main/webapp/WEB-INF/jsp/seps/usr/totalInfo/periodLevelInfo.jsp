<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"			uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring"		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common"		uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"			uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<body class="sub_page">
<form:form commandName="searchVO" id="frm" name="frm">
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body" >
		<!-- left menu - start -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incLeftnav"/>
		<!-- left menu - end -->
		<div class="main_content">
			<div class="content">
				<div class="m_title">
					<div class="title">기간별 수위정보</div>
					<div class="navi">
						<ul>
							<li>HOME</li>
							<li>상세관측정보</li>
							<li>기간별 수위정보</li>
						</ul>
					</div>
				</div>
				<fieldset>
					<legend>검색하기</legend>
					<div class="top_sh_box">
						<div class="sh_box">
							<dl>
								<dt>대상</dt>
								<dd>
									<form:select path="searchCondition1" class="select_box">
										<form:option value="0000001">월계1교 </form:option>
										<form:option value="0000002">여의상류</form:option>
										<form:option value="0000003">월릉교</form:option>
										<form:option value="1018675">중랑교</form:option>
										<form:option value="1018665">신곡교</form:option>
										<form:option value="1018683">한강대교</form:option>
										<form:option value="1018662">청담대교</form:option>
										<form:option value="1017310">팔당댐(방류량)</form:option>
										<form:option value="1018697">오금교(안양천)</form:option>
										<form:option value="1018655">대곡교(탄천)</form:option>
										<form:option value="1018630">진관교(왕숙천)</form:option>
									</form:select>
								</dd>
							</dl>
							<dl>
								<dt>기간</dt>
								<dd>
									<form:input path="startDate" class="start_day input_date" autocomplete="off"/> ~ <form:input path="endDate" class="finish_day input_date" autocomplete="off"/>
								</dd>
							</dl>
						</div>
						<div class="btn_sh"><button onclick="fn_list(); return false;">검색</button></div>
					</div>
				</fieldset>
				<div class="cont_box ptb_50">
					<div class="gf_w100p">
						<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/totalInfo/graph/periodLevelInfo_graph"/>
					</div>
					<div class="grid_table_over grid_table_l" id="table">
						<table>
							<tbody>
								<c:choose>
									<c:when test="${waterLevelOrDamList.size() gt 0 }">
										<tr>
											<td>시간</td>
											<c:forEach items="${waterLevelOrDamList }" var="list" varStatus="status">
												<td>
													<fmt:parseDate value="${list.baseDate } ${list.baseTime }" pattern="yyyyMMdd HHmm" var="dttm"/>
													<fmt:formatDate value="${dttm }" pattern="MM.dd HH:mm"/>
												</td>
											</c:forEach>
											<%--
											<c:forEach items="${waterLevelOrDamList }" var="result">
												<td>
													<fmt:parseDate value="${result.baseDate } ${result.baseTime }" pattern="yyyyMMdd HHmm" var="dttm"/>
													<fmt:formatDate value="${dttm }" pattern="HH:mm"/>
												</td>
											</c:forEach>
											--%>
										</tr>
										<tr>
											<td>
												<c:choose>
													<c:when test="${searchVO.searchCondition1 eq '1017310' }">방류량</c:when>
													<c:otherwise>수위</c:otherwise>
												</c:choose>
											</td>
											<c:forEach items="${waterLevelOrDamList }" var="list" varStatus="status">
												<td><c:out value="${list.val }"/></td>
											</c:forEach>
										</tr>
										<tr>
											<td>단계</td>
											<c:forEach items="${waterLevelOrDamList }" var="list" varStatus="status">
												<td <c:if test="${status.last }">id="tdLast"</c:if>>
													<c:choose>
														<c:when test="${list.level eq 3 }">침수</c:when>
														<c:when test="${list.level eq 2 }">경고</c:when>
														<c:when test="${list.level eq 1 }">준비</c:when>
														<c:when test="${list.level eq 0 }">평시</c:when>
													</c:choose>
												</td>
											</c:forEach>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td>데이터가 없습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- footer -->
</form:form>
<script type="text/javascript">

	$(function(){
		//스크롤 제일 끝으로
		var offset = $("#tdLast").offset();
		$("#table").scrollLeft(offset.left);
	});

	// 검색
	function fn_list(){
		$('#frm').attr('method', 'post').attr('action', '<c:out value="${pageContext.request.contextPath}/usr/totalInfo/periodLevelInfo.do"/>').submit();
	}
</script>
</body>
</html>