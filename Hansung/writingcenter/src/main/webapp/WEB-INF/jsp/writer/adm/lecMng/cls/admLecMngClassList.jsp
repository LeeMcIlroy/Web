<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">

	$(function(){
		$("#searchSemester").change(function(){
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/cls/admLecMngClassList.do'/>").submit();
		});
		$("#searchDepartment").change(function(){
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/cls/admLecMngClassList.do'/>").submit();
		});
	});

	// 등록&수정화면
	function fn_modify(clsSeq){
		$("#clsSeq").val(clsSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/cls/admLecMngClassModify.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(clsSeq){
		if(confirm("강의실을 삭제하시겠습니까?")==true){
			$("#clsSeq").val(clsSeq);
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/cls/admLecMngClassDelete.do'/>").submit();
			
		}else{
			return false;
		}
	}

	/* pagination 페이지 링크 function */
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/cls/admLecMngClassList.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="clsSeq" name="clsSeq"/>
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
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의실관리"/>
            	<jsp:param name="dept2" value="교수님 생성"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<!-- table -->
				<div class="tbl_top_area2">
					<form:select path="searchSemester" class="se_base">
						<form:option value="">학기 강의실 선택</form:option>
						<form:options items="${smtrList }" itemLabel="smtrTitle" itemValue="smtrSeq" />
					</form:select>

					<form:select path="searchDepartment" class="se_base">
						<form:option value="">계열선택</form:option>
						<form:options items="${deptList }" itemLabel="deptTitle" itemValue="deptSeq" />
					</form:select>
				</div>
				<table class="list_tbl_03" summary="교수님 생성 목록">
					<caption>교수님 생성</caption>
					<colgroup>
						<col style="width:6%" />
						<col style="width:18%" />
						<col style="width:22%" />
						<col style="width:18%" />
						<col style="width:6%" />
						<col style="width:15%" />
						<col style="width:15%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">타이틀</th>
							<th scope="col">학기강의실</th>
							<th scope="col">계열</th>
							<th scope="col">순서</th>
							<th scope="col">View 여부</th>
							<th scope="col">수정/삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
                       		<tr>
                       			<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td><c:out value="${fn:replace(result.clsTitle, '-', '') }" escapeXml="false"/></td>
								<td class="ta_left"><c:out value="${result.smtrTitle }"/></td>
								<td><c:out value="${result.deptTitle }"/></td>
								<td><c:out value="${result.clsSort }"/></td>
								<td>
									<c:if test="${result.clsViewYn eq 'Y' }">보이기</c:if>
									<c:if test="${result.clsViewYn eq 'N' }">숨기기</c:if>
								</td>
								<td>
									<a href="#" class="btn_s_modi" onclick="fn_modify(${result.clsSeq}); return false;">수정</a>
									<a href="#" class="btn_s_del" onclick="fn_delete(${result.clsSeq}); return false;">삭제</a>
								</td>
                       		</tr>
                       	</c:forEach>
                       	<%--
						<tr>
							<td>10</td>
							<td>A반 홍길동 교수</td>
							<td class="ta_left"><a href="#">2016년 제2학기 강의실</a></td>
							<td>인문대학</td>
							<td>1</td>
							<td>보이기</td>
							<td><a href="#" class="btn_s_modi">수정</a><a href="#" class="btn_s_del">삭제</a></td>
						</tr>
						--%>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type01" onclick="fn_modify(); return false;">등록</a>
						</div>
					</div>
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
                        <form:hidden path="pageIndex" />
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