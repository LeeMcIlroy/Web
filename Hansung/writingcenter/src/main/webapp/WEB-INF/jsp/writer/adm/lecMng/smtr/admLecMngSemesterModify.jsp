<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">
	
	// 등록
	function fn_update(){
		if($("#smtrTitle").val() == ''){
			alert("타이틀을 입력해주세요.");
			$("#smtrTitle").focus();
			return false;
		}else if($("#smtrContent").val() == ''){
			alert("안내문구를 입력해주세요.");
			$("#smtrContent").focus();
			return false;
		}
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/smtr/admLecMngSemesterUpdate.do'/>").submit();
	}

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/smtr/admLecMngSemesterList.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="semesterVO" id="frm" name="frm">
<form:hidden path="smtrSeq" />
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
				<table class="view_tbl_03 mb30 mt30" summary="강의실 생성 관리">
					<caption>강의실 생성</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">* 타이틀</th>
							<td><form:input path="smtrTitle" style="width:100%;" /></td>
						</tr>
						<tr>
							<th scope="row">* 안내문구</th>
							<td><form:input path="smtrContent" style="width:100%;"/>
						</tr>
						<tr>
							<th scope="row">View 여부</th>
							<td>
								<form:select path="smtrViewYn" class="se_base">
                               		<form:option value="Y">보이기</form:option>
                               		<form:option value="N">숨기기</form:option>
                               	</form:select>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#" class="b_type02" onclick="fn_update(); return false;">
							<c:if test="${empty semesterVO.smtrSeq }">저장</c:if>
							<c:if test="${!empty semesterVO.smtrSeq }">수정</c:if>
						</a>
						<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
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
<input type="hidden" id="pageIndex" value="${searchVO.pageIndex }"/>
</form:form>
</body>
</html>