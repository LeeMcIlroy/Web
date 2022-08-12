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

	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0708/ech0708List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0708/ech0708Modify.do'/>").submit();
	}
	
	//공지 페이지 삭제
	function fn_delete(){
		if (confirm("공통코드 정보를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0708/ech0708Delete.do'/>").submit();
			
		}
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>기준정보</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="기준정보"/>
	            <jsp:param name="dept2" value="공통코드"/>
           	</jsp:include>
			<!-- //타이틀 -->			
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>공통코드</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="commCodeNo" name="commCodeNo" value="${result.commCodeNo }"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
            <!-- 공통코드 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">분류코드</th>
						<td colspan="3">
							<c:out value="${result.commCodeclsNo}" />
						</td>
					</tr>
					<tr>
						<th scope="row">분류명</th>
						<td colspan="3">
							<c:out value="${result.commCodeclsName}" />
						</td>
					</tr>
					<tr>
						<th scope="row">공통코드</th>
						<td>
							<c:out value="${result.commCode}" />
						</td>
						<th scope="row" class="bl">사용여부</th>
						<td>
							<c:out value="${result.useYn}" />
						</td>
					</tr>
					<tr>
						<th scope="row">코드명</th>
						<td>
							<c:out value="${result.codeName}" />
						</td>
						<th scope="row" class="bl">정렬순서</th>
						<td>
							<c:out value="${result.ordSeq}" />
						</td>
					</tr>
					<tr>
						<th scope="row">설명</th>
						<td colspan="3">
							<c:out value="${result.codeDesc}" />
						</td>
					</tr>
					<tr>
						<th scope="row">참조1</th>
						<td>
							<c:out value="${result.refer1}" />
						</td>
						<th scope="row" class="bl">참조2</th>
						<td>
							<c:out value="${result.refer1}" />
						</td>
					</tr>
					<tr>
						<th scope="row">회사코드</th>
						<td colspan="3">
							<c:out value="${result.corpCd}" />
						</td>
					</tr>
				</tbody>
			</table>
            <!-- //공통코드 -->
			</form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_delete(); return false;" >삭제</a>
				<a href="#" onclick="fn_update(); return false;" >수정</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>