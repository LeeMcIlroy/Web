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
	// 목록
	function fn_list(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/systemManage/systemManageList.do'/>").submit();
	}

	// 등록
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/systemManage/systemManageModify.do'/>").submit();
	}
	
	// 조회
	function fn_select(userInfoId){
		$("#userInfoId").val(userInfoId);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/systemManage/systemManageView.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="userInfoId" name="userInfoId">
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">관리자관리</div>
			<!--// PAGE_TITLE -->
			<div class="content">
				<fieldset>
					<legend>검색하기</legend>

					<div class="top_sh_box">
						<div class="sh_box02">
							<form:select path="searchCondition1" style="text-indent:0;">
								<form:option value="">전체</form:option>
								<form:option value="Y">사용</form:option>
								<form:option value="N">미사용</form:option>
							</form:select>
							<form:select path="searchCondition2" style="text-indent:0;">
								<form:option value="1">이름</form:option>
								<form:option value="2">소속</form:option>
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
									<col width="15%" />
									<col width="15%" />
									<col width="15%" />
									<col width="*" />
									<col width="10%" />
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>이름</th>
										<th>아이디</th>
										<th>연락처</th>
										<th>이메일</th>
										<th>사용여부</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${resultList }" var="result" varStatus="status">
										<tr>
											<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
											<td class="tal_l tint_10">
												<a href="#" onclick="fn_select(<c:out value='${result.userInfoId }'/>); return false;">
													<c:out value="${result.userNm }"/>
												</a>
											</td>
											<td><c:out value="${result.userId }"/></td>
											<td><c:out value="${result.userTel }"/></td>
											<td><c:out value="${result.userMail }"/></td>
											<td><c:if test="${result.useYn == 'Y' }">사용</c:if><c:if test="${result.useYn != 'Y' }">미사용</c:if></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 웹페이징 -->
							<div class="paging">
								<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list"/>
								<form:hidden path="pageIndex"/>
								<div class="paging_button">
									<button onclick="fn_modify(); return false;">등록</button>
								</div>
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