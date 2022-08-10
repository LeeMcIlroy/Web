<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>

	function fn_list(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#frm").attr("method","post").attr("action", "<c:url value='/xabdmxgr/qestnar/admQuestionaireAnswererList.do'/>").submit();
	}
	
	//설문조사 목록
	function fn_goList(){
		location.href="<c:url value='/xabdmxgr/qestnar/admQuestionaireList.do'/>";
	}
</script>
<body>
<form:form commandName="searchVO" id="frm">
<form:hidden path="searchSemester" />
<form:hidden path="searchWord" />
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!--// header -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<div class="title_area">
				<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="설문조사"/>
		            <jsp:param name="dept2" value="설문조사"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<div class="tbl_top_area2">
					<p class="total_count">총 <span><c:out value="${paginationInfo.totalRecordCount }"/></span> 명</p>
					<div class="btn_r">
						<form:select path="searchDepartment" class="se_base w150" onchange="fn_list(1); return false;">
							<form:option value="">계열선택</form:option>
							<form:options items="${deptList }" itemLabel="deptTitle" itemValue="deptSeq"/>
						</form:select>
						<form:select path="searchClass" class="se_base w150" onchange="fn_list(1); return false;">
							<form:option value="">수강교실 선택</form:option>
							<form:options items="${clsList }" itemLabel="clsTitle" itemValue="clsSeq"/>
						</form:select>
					</div>
				</div>
				<table class="list_tbl_03" summary="설문조사 관리 목록">
					<caption>설문조사</caption>
					<colgroup>
						<col style="width:10%" />
						<col style="width:22%" />
						<col style="width:23%" />
						<col style="width:22%" />
						<col style="width:23%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">소속대학</th>
							<th scope="col">수강교실</th>
							<th scope="col">학번</th>
							<th scope="col">이름</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList }" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td><c:out value="${result.deptTitle }"/></td>
								<td><c:out value="${result.clsTitle }"/></td>
								<td><c:out value="${result.psnHakbun }"/></td>
								<td><c:out value="${result.psnName }"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type03" onclick="fn_goList(); return false;">목록</a>
						</div>
					</div>
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
					</div>
				</div>
			<!-- //content -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>