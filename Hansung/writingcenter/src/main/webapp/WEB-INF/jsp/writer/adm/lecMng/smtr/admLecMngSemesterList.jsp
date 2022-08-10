<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">

	// 등록&수정화면
	function fn_modify(smtrSeq){
		$("#smtrSeq").val(smtrSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/smtr/admLecMngSemesterModify.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(smtrSeq){
		if(confirm("정말 삭제하시겠습니까?") == true){
			$("#smtrSeq").val(smtrSeq);
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/smtr/admLecMngSemesterDelete.do'/>").submit();
			
		}else{
			return false;
		}
	}

	/* pagination 페이지 링크 function */
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/smtr/admLecMngSemesterList.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="smtrSeq" name="smtrSeq"/>
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
            	<jsp:param name="dept2" value="강의실 생성"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<!-- table -->
				<table class="list_tbl_03 mt30" summary="강의실 생성 목록">
					<caption>강의실 생성</caption>
					<colgroup>
						<col style="width:10%" />
						<col style="width:60%" />
						<col style="width:15%" />
						<col style="width:15%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">타이틀</th>
							<th scope="col">View 여부</th>
							<th scope="col">수정/삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td class="ta_left"><c:out value="${result.smtrTitle }"/></td>
								<td>
									<c:if test="${result.smtrViewYn eq 'Y' }">보이기</c:if>
									<c:if test="${result.smtrViewYn eq 'N' }">숨기기</c:if>
								</td>
								<td>
									<a href="#" class="btn_s_modi" onclick="fn_modify(${result.smtrSeq}); return false;">수정</a>
									<a href="#" class="btn_s_del" onclick="fn_delete(${result.smtrSeq}); return false;">삭제</a>
								</td>
							</tr>
						</c:forEach>
						<%--
						<tr>
							<td>10</td>
							<td class="ta_left"><a href="#">2016년 제2학기 강의실</a></td>
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