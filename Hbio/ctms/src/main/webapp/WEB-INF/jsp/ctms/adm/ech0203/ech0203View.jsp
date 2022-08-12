<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_list(){
		$("#searchFrm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0203/ech0203List.do'/>").submit();
	}
	
	function fn_update(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0203/ech0203Modify.do'/>").submit();
	}
	
	// 삭제 DEL_YN = 'Y' 설정
	function fn_delete(){
		if (confirm("질문/답변정보를 삭제합니다. 삭제된 정보는  복구 되지 않습니다. \r\n삭제하시겠습니까?")) {
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0203/ech0203Delete.do'/>").submit();
			
		}
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>eCRF관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="질문답변관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="searchFrm" name="searchFrm" method="post">
				<form:hidden path="searchCondition1"/>
				<form:hidden path="searchCondition2"/>
				<form:hidden path="searchCondition3"/>
				<form:hidden path="startDate"/>
				<form:hidden path="endDate"/>
				<form:hidden path="searchType"/>
				<form:hidden path="searchWord"/>
			</form:form>
			<form:form commandName="cr2030mVO" id="frm" name="frm" method="post">
				<form:hidden path="quesNo"/>
	            <!-- 기본정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">질문/답변명</th>
							<td colspan="3">
								<c:out value="${cr2030mVO.quesNm }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">유형</th>
							<td>
								<c:out value="${cr2030mVO.quesType eq 'S'?'단일응답':cr2030mVO.quesType eq 'S'?'복수응답':'자유기재형' }"/>
							</td>
							<th scope="row" class="bl">사용여부</th>
							<td>
								<c:out value="${cr2030mVO.useYn eq 'Y'?'사용':'미사용' }"/>
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 서브타이틀 -->
				<div class="sub_title_area">
					<h4>질문/답변</h4>
				</div>
				<!-- //서브타이틀 -->
	            <!-- 기본정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><i>*</i>질문</th>
							<td>
								<c:out value="${cr2030mVO.quesCon }"/>
								<c:out value="${cr2030mVO.quesAbb }"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><i>*</i>답변</th>
							<td id="answTd">
								<c:forEach items="${cr2040List }" var="cr2040mVO" varStatus="status">
									<div class="que_item">
										<span>항목<c:out value="${status.count }"/></span>
										<c:out value="${cr2040mVO.answCon }"/>
									</div>
								</c:forEach>
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 버튼 -->
				<div class="btn_area">
					<a href="#" class="type02" onclick="fn_list();">취소</a>
					<a href="#" onclick="fn_delete();">삭제</a>
					<a href="#" onclick="fn_update();">수정</a>
				</div>
				<!-- //버튼 -->
			</form:form>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>