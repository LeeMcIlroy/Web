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
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/hotLine/hotLineList.do'/>").submit();
	}
	
	// 수정
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/hotLine/hotLineModify.do'/>").submit();
	}
	
	// 삭제
	function fn_remove(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/hotLine/hotLineDelete.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="hotLineVO" id="frm" name="frm">
<form:hidden path="hotLineId"/>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">비상연락망</div>
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
										<th>*소속</th>
										<td>
											<c:out value="${hotLineVO.hotLineDept }"/>
										</td>
									</tr>
									<tr>
										<th>*이름</th>
										<td>
											<c:out value="${hotLineVO.hotLineName }"/>
										</td>
									</tr>
									<tr>
										<th>*연락처</th>
										<td>
											<c:out value="${hotLineVO.hotLineTel }"/>
										</td>
									</tr>
									<tr>
										<th>이메일</th>
										<td>
												<c:out value="${hotLineVO.hotLineEmail }"/>
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
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }">
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }">
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }">
<!-- 목록 검색조건 - end -->
</form:form>
</body>
</html>