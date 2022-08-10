<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>한성대학교 디자인아트 교육원</title>
<!-- header -->
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<!--// header -->
</head>
<body>
<div class="wrap">
	<!-- topnav -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!-- topnav -->
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
			<div class="title_area">
				<h3>비밀번호관리</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 비밀번호관리</span>
				</div>
			</div>
			<div class="cont_box">
			<!-- content -->
			<form:form commandName="adminVO" id="frm" name="frm">
			<form:hidden path="admSeq"/>
			<input type="hidden" name="admIdCheck" id="admIdCheck"/>
				<!-- table -->
				<table class="view_tbl_03 mb30" summary="비밀번호관리">
					<caption>비밀번호관리</caption>
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">이름</th>
							<td colspan="3">
								<c:out value="${adminVO.admName }"/>
								<form:hidden path="admName" />
							</td>
						</tr>
						<tr>
							<th scope="row">아이디</th>
							<td colspan="3">
								<c:out value="${adminVO.admId }" />
								<form:hidden path="admId" />
							</td>
						</tr>
						<tr>
							<th scope="row">비밀번호</th>
							<td colspan="3">
								<form:password path="admPwd" class="in_base" style="width:31%;" />
								* 비밀번호 변경시 입력해주세요.
							</td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td><form:input path="admTel" class="in_base" style="width:80%;" /></td>
							<th scope="row">이메일</th>
							<td><form:input path="admEmail"  class="in_base" style="width:80%;" /></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#" onclick="fn_save(); return false;" class="b_type04">수정</a>
					</div>
				</div>
			</form:form>
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
<script type="text/javascript">
	
	// 등록&수정
	function fn_save(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admin/admUserUpdate.do'/>").submit();
	}
	
</script>
</body>
</html>