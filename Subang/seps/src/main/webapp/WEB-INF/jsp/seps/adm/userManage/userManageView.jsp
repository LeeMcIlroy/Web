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
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/userManage/userManageList.do'/>").submit();
	}
	
	// 저장
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/userManage/userManageModify.do'/>").submit();
	}

	// 삭제
	function fn_remove(){
		if(confirm('정말로 삭제하시겠습니까?\n삭제한 데이터는 복구 불가능합니다.')){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/userManage/userManageDelete.do'/>").submit();
		}
	}
</script>
<body>
<form:form commandName="userInfoVO" id="frm" name="frm">
<form:hidden path="userInfoId"/>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">사용자관리</div>
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
										<th>이름</th>
										<td>
											<c:out value="${userInfoVO.userNm}"/>
										</td>
									</tr>
									<tr>
										<th>아이디</th>
										<td>
											<c:out value="${userInfoVO.userId}"/>
										</td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td>
											<c:choose>
											<c:when test="${userInfoVO.useYn == 'Y' }">사용</c:when>
											<c:when test="${userInfoVO.useYn != 'Y' }">미사용</c:when>
											</c:choose>
										</td>
									</tr>
									<tr>
										<th>카톡공유여부</th>
										<td>
											<c:choose>
											<c:when test="${userInfoVO.alarmYn == 'Y' }">사용</c:when>
											<c:when test="${userInfoVO.alarmYn != 'Y' }">미사용</c:when>
											</c:choose>
										</td>
									</tr>
									<tr>
										<th>사용권한</th>
										<td>
											<c:forEach items="${menuList }"  var="menu" varStatus="status">
												<input type="checkbox" 
													value="<c:out value="${menu.authId }"/>" 
													name="menuIds" 
													alt="<c:out value="${menu.authNm }"/>"
													disabled="disabled"
													<c:forEach items="${userInfoVO.menuIds }" var="voMenu" varStatus="status2">
														<c:if test="${menu.authId eq voMenu }">
														checked="checked"
														</c:if>
													</c:forEach> 
												>&nbsp;<c:out value="${menu.authNm }"/>&nbsp;&nbsp;
											</c:forEach>
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