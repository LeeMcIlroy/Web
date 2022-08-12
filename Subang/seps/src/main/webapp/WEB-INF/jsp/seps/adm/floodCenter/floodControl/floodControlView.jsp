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
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/floodCenter/floodControlList.do'/>").submit();
	}
	
	// 수정
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/floodCenter/floodControlModify.do'/>").submit();
	}
	
	// 삭제
	function fn_remove(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/floodCenter/floodControlDelete.do'/>").submit();
	}
	
	
</script>
<body>
<form:form commandName="floodControlVO" id="frm" name="frm">
<form:hidden path="floodControlId"/>
<form:hidden path="issueDate"/>
<form:hidden path="issueTime"/>
<form:hidden path="regNm"/>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">수방단계설정</div>
			<!--// PAGE_TITLE -->
			<div class="content">
				<div class="cont_box">
					<div>
						<div>
							<table class="input_table">
								<colgroup>
									<col width="15%" />
									<col width="85%" />
								</colgroup>
								<tbody>
									<tr>
										<th>단계</th>
										<td>
											<c:out value="${floodControlVO.floodLevel }"/>
										</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td>
											<c:out value="${floodControlVO.regNm }"/>
										</td>
									</tr>
									<tr>
										<th>작성일시</th>
										<td>
											<c:out value="${floodControlVO.regDttm }"/>
										</td>
									</tr>
									<tr>
										<th>조회</th>
										<td>
											<c:out value='${floodControlVO.hitCnt }'/>
										</td>
									</tr>
									<tr>
										<th>발령일시</th>
										<td>
											<c:out value='${floodControlVO.issueDate }'/>&nbsp;<c:out value="${floodControlVO.issueTime }"/>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="btn_box">
								<button class="btn_list" onclick="fn_modify(); return false;">수정</button>
								<button class="btn_list" onclick="fn_remove(); return false;">삭제</button>
								<button class="btn_list" onclick="fn_list(); return false;">목록</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=inc/incFooter"/>
	<!-- footer - end -->
	
<!-- 목록 검색조건 - start -->
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }">
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }">
<!-- 목록 검색조건 - end -->
</form:form>
</body>
</html>