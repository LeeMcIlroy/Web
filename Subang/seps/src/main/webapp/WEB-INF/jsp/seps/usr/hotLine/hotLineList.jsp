<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
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
					<div class="title">비상연락망</div>
					<div class="navi">
						<ul>
							<li>HOME</li>
							<li>비상연락망</li>
						</ul>
					</div>
				</div>
				<fieldset>
					<legend>검색하기</legend>
					<div class="top_sh_box">
						<div class="sh_box">
							<dl>
								<dt></dt>
								<dd>
									<form:select path="searchCondition1" class="select_box">
										<form:option value="">전체</form:option>
										<c:forEach items="${deptList }" var="dept" varStatus="status">
											<form:option value="${dept.hotLineDept }"><c:out value="${dept.hotLineDept }"/></form:option>
										</c:forEach>
									</form:select>
									<form:select path="searchCondition2" class="select_box">
										<form:option value="1">이름</form:option>
										<form:option value="2">연락처</form:option>
										<form:option value="3">이메일</form:option>
									</form:select>
								</dd>
							</dl>
							<dl>
								<dt></dt>
								<dd>
									<form:input path="searchWord"/>
									<%--
									<input type="text" id="day_st" />
									--%>
								</dd>
							</dl>
						</div>
						<div class="btn_sh"><button onclick="fn_list(1); return false;">검색</button></div>
					</div>
				</fieldset>
				<div class="cont_box ptb_50">
					<div class="transform_table notice_type3">
						<ul class="tbl_th">
							<li>기관</li>
							<li>성명</li>
							<li>연락처</li>
							<li>이메일</li>
						</ul>
						<div class="tbl_td2">
							<c:forEach items="${resultList }" var="result">
								<ul>
									<li class="tbl_ntc">
										<span>
											<c:out value="${result.hotLineDept }"/>
										</span>
									</li>
									<li><c:out value="${result.hotLineName }"/></li>
									<li><a href="tel:<c:out value="${result.hotLineTel }"/>"><c:out value="${result.hotLineTel }"/></a></li>
									<li>
										<c:if test="${empty result.hotLineEmail }">-</c:if>
										<c:if test="${!empty result.hotLineEmail }">
											<a href="mailto:<c:out value="${result.hotLineEmail }"/>"><c:out value="${result.hotLineEmail }"/></a>
										</c:if>
									</li>
								</ul>
							</c:forEach>
						</div>
					</div>
					<div class="pager">
						<!-- 웹페이징 -->
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
						<!-- // 웹페이징 -->
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
	// 검색
	function fn_list(pageNo){
		$('#pageIndex').val(pageNo);
		$('#frm').attr('method', 'post').attr('action', '<c:out value="${pageContext.request.contextPath}/usr/hotLine/hotLineList.do"/>').submit();
	}
</script>
</body>
</html>
