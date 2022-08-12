<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<script type="text/javascript">
	//검색
	function fn_list(pageNo){
		$('#pageIndex').val(pageNo);
		$('#frm').attr('method', 'post').attr('action', '<c:out value="${pageContext.request.contextPath}/adm/floodCenter/snsList.do"/>').submit();
	}

</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">기간별알람현황</div>
			<!--// PAGE_TITLE -->
			<div class="content">
				<fieldset>
					<legend>검색하기</legend>

					<div class="top_sh_box">
						<div class="sh_box02">
							<form:select path="searchCondition1" style="text-indent:0;">
								<form:option value="TITLE">제목</form:option>
								<form:option value="CONTENT">내용</form:option>
							</form:select>
							<form:input path="searchWord"/>
							<div class="btn_sh03"><button onclick="fn_list(1); return false;">검색</button></div>
						</div>
					</div>
				</fieldset>
				<div class="cont_box white_bg">
					<!-- 단일 GRAPH_BOX -->
					<div class="box_div_1" style="margin-bottom:0;">
						<div>
							<!-- box graph table -->
							<table class="box_table_t01">
								<colgroup>
									<col width="5%" />
									<col width="30%" />
									<col width="*" />
									<col width="10%" />
									<col width="15%" />
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>내용</th>
										<th>작성자</th>
										<th>작성일시</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${resultList }" var="result" varStatus="status">
										<tr>
											<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
											<td><c:out value="${result.snsTitle }"/></td>
											<td><c:out value="${result.snsContent }"/></td>
											<td><c:out value="${result.regNm }"/></td>
											<td><c:out value="${result.regDttm }"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 웹페이징 -->
							<div class="paging">
								<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list"/>
								<form:hidden path="pageIndex"/>
							</div>
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
</form:form>
</body>
</html>