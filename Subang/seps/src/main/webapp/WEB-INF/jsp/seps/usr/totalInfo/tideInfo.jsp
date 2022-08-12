<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   		uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"			uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="common" 		uri="/WEB-INF/tld/common.tld"%>
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
					<div class="title">조위정보</div>
					<div class="navi">
						<ul>
							<li>HOME</li>
							<li>상세관측정보</li>
							<li>조위정보</li>
						</ul>
					</div>
				</div>
				<fieldset>
					<legend>검색하기</legend>
					<div class="top_sh_box">
						<div class="sh_box">
							<dl>
								<dt>관측소 : 인천관측소</dt>
							</dl>
							<dl>
								<dt></dt>
								<dd>
									<form:input path="searchDate" class="finish_day input_date"  placeholder="날짜" autocomplete="off"/>
								</dd>
							</dl>
						</div>
						<div class="btn_sh"><button onclick="fn_list(); return false;">검색</button></div>
					</div>
				</fieldset>
				<div class="cont_box none_bg pd_0">
					<div class="multi_box">
						<div class="on_bg">
							<div style="min-height:344px;" class="s_wd">
								<div class="wt_title">
									<c:if test="${tideList.size() gt 0 }">
										<p>
											관측시간
											<fmt:formatDate value="${tideList.get(tideList.size()-1).get('regDttm') }" type="both" pattern="yyyy-MM-dd HH:mm:ss"/>
										</p>
										조위 : <c:out value="${tideList.get(tideList.size()-1).get('realValue') }"/>㎝
									</c:if>
								</div>
								<div class="wt_icon">
									<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/sea_icon01.png'/>" alt="" /></div>
								</div>
								<div class="wt_info gf_list">
									<c:forEach items="${tideTphList }" var="result">
										<c:if test="${result.baseDate eq fn:replace(searchVO.searchDate, '-', '') }">
											<ul <c:if test="${result.hlCode eq '고조' }">class="red_txt"</c:if>>
												<li><c:out value="${fn:substring(result.baseTime, 0, 2) }:${fn:substring(result.baseTime, 2, 4) }"/></li>
												<li><c:out value="${result.hlCode }"/></li>
												<li><c:out value="${result.tphLevel }"/></li>
											</ul>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
						<c:set var="stdDate"/>
						<c:forEach items="${tideTphList }" var="result">
							<c:if test="${result.baseDate ne fn:replace(searchVO.searchDate, '-', '') && stdDate ne result.baseDate }">
								<div class="on_bg">
									<div class="grid_table" style="min-height:344px;">
										<div class="gf_stit">
											<ul>
												<li><c:out value="${fn:substring(result.baseDate, 0, 4) }-${fn:substring(result.baseDate, 4, 6) }-${fn:substring(result.baseDate, 6, 8) }"/></li>
												<li>조석예보(cm)</li>
											</ul>
										</div>
										<div class="wt_info gf_list02">
										<c:forEach items="${tideTphList }" var="result2">
											<c:if test="${result.baseDate eq result2.baseDate && stdDate ne result.baseDate}">
												<ul <c:if test="${result2.hlCode eq '고조' }">class="red_txt"</c:if>>
													<li>
														<c:if test="${result2.hlCode eq '저조' }"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/icon_down.png'/>" alt="" /></c:if>
														<c:if test="${result2.hlCode eq '고조' }"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/icon_high.png'/>" alt="" /></c:if>
													</li>											
													<li>
														<div>
															<p><c:out value="${fn:substring(result2.baseTime, 0, 2) }:${fn:substring(result2.baseTime, 2, 4) }"/></p>
															<c:out value="${result2.tphLevel }"/>㎝
														</div>
													</li>
												</ul>
											</c:if>
										</c:forEach>
										<c:set var="stdDate" value="${result.baseDate }"/>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="cont_box">
					<div class="gf_w100p">
						<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/totalInfo/graph/tideInfo_graph"/>
					</div>
					<div class="grid_table_over grid_table_l" id="table">
						<table>
							<tbody>
								<c:choose>
									<c:when test="${tideList.size() gt 0 }">
										<tr>
											<td>시간</td>
											<c:forEach items="${tideList }" var="list" varStatus="status">
												<td>
													<fmt:parseDate value="${list.baseDate } ${list.baseTime }" pattern="yyyyMMdd HHmm" var="dttm"/>
													<fmt:formatDate value="${dttm }" pattern="HH:mm"/>
												</td>
											</c:forEach>
										</tr>
										<tr>
											<td>조위(실측)</td>
											<c:forEach items="${tideList }" var="list" varStatus="status">
												<td><c:out value="${list.realValue }"/></td>
											</c:forEach>
										</tr>
										<tr>
											<td>조위(예측)</td>
											<c:forEach items="${tideList }" var="list" varStatus="status">
												<td <c:if test="${status.last }">id="tdLast"</c:if>><c:out value="${list.prvValue }"/></td>
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
<input type="hidden" id="message" name="message" value="${message }">
<script type="text/javascript">
	
	$(function(){
		//스크롤 제일 끝으로
		var offset = $("#tdLast").offset();
		$("#table").scrollLeft(offset.left);
	});


	// 검색
	function fn_list(){
		$('#frm').attr('method', 'post').attr('action', '<c:out value="${pageContext.request.contextPath}/usr/totalInfo/tideInfo.do"/>').submit();
	}
</script>
</body>
</html>
