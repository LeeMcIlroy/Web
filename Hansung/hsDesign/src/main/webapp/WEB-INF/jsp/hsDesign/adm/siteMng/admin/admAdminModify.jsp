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
				<h3>관리자관리</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 사이트관리 &gt; 관리자관리 &nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
			<div class="cont_box">
			<!-- content -->
			<form:form commandName="adminVO" id="frm" name="frm">
			<form:hidden path="admSeq"/>
			<input type="hidden" name="admIdCheck" id="admIdCheck"/>
				<!-- table -->
				<table class="view_tbl_03 mb30" summary="관리자관리">
					<caption>관리자관리</caption>
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">* 이름</th>
							<td colspan="3">
								<c:if test='${empty system}'>
									<form:input path="admName" class="in_base" style="width:31%;" />
								</c:if>
								<c:if test='${!empty system}'>
									<c:if test="${system eq 'Y'}">
										<form:input path="admName" class="in_base" style="width:31%;" />
									</c:if>
									<c:if test="${system eq 'N'}">
										<c:out value="${adminVO.admName }"/>
										<form:hidden path="admName" />
									</c:if>
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">* 아이디</th>
							<td colspan="3">
								<c:if test='${empty system}'>
									<form:input path="admId"  class="in_base" style="width:31%;" />
									<a href="#" class="btn_id_check" onclick="fn_idCheck(); return false;"> 중복확인</a>
									<p class="alt_txt">6~20 자리로 영문, 숫자, 특수문자만 사용 가능 합니다.</p>
								</c:if>
								<c:if test='${!empty system}'>
									<c:out value="${adminVO.admId }" />
									<form:hidden path="admId" />
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">* 비밀번호</th>
							<td colspan="3">
								<c:if test='${empty system}'>
								＊ 초기 비밀번호는 qwer$1234로 저장됩니다.
								</c:if>
								<c:if test='${!empty system}'>
									<c:if test="${system eq 'Y'}">
										<form:password path="admPwd" class="in_base" style="width:31%;" />
									</c:if>
									<c:if test="${system eq 'N'}">
										<a href="#" class="btn_id_check" onclick="fn_pwClear(); return false;">비밀번호 초기화</a>
									</c:if>
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td><form:input path="admTel" class="in_base" style="width:80%;" /></td>
							<th scope="row">이메일</th>
							<td><form:input path="admEmail"  class="in_base" style="width:80%;" /></td>
						</tr>
						<tr>
							<th scope="row">사용여부</th>
							<td colspan="3">
								<form:select path="admUseYn" class="se_base w150">
									<form:option value="Y">사용</form:option>
									<form:option value="N">미사용</form:option>
								</form:select>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#" onclick="fn_save(); return false;" class="b_type04">저장</a>
						<a href="#" onclick="fn_list(); return false;" class="b_type03">목록</a>
					</div>
				</div>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex }'/>"/>
				<input type="hidden" name="searchCondition1" value="<c:out value='${searchVO.searchCondition1 }'/>"/>
				<input type="hidden" name="searchCondition2" value="<c:out value='${searchVO.searchCondition2 }'/>"/>
				<input type="hidden" name="searchWord" value="<c:out value='${searchVO.searchWord }'/>"/>
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
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admin/admAdminList.do'/>").submit();
	}
	
	// 등록&수정
	function fn_save(){
		if($("#admName").val() == ''){
			alert("이름을 입력해주세요.");
			return false;
		}
		if($("#admId").val() == ''){
			alert("아이디를 입력해주세요.");
			return false;
		}
		<c:if test='${empty system}'>
		if($("#admIdCheck").val() == ''){
			alert("아이디 중복확인을 해주세요.");
			return false;
		}
		if($("#admIdCheck").val() != $("#admId").val()){
			alert("아이디 중복확인을 해주세요.");
			return false;
		}
		</c:if>
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admin/admAdminUpdate.do'/>").submit();
	}

	
	// 중복확인
	function fn_idCheck(){
		var admId = $("#admId").val();
		$.ajax({
			url: "<c:url value='/qxerpynm/siteMng/admin/ajaxAdmAdminIdCheck.do'/>"
			, type: "post"
			, data: "admId="+admId
			, dataType:"json"
			, success: function(data){
				if(data.result == 'Y'){
					alert("이미 등록된 아이디 입니다.");
				}else{
					alert("사용 가능한 아이디 입니다.");
					$("#admIdCheck").val($("#admId").val());
				}
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	//비밀번호 초기화
	function fn_pwClear(){
		if(confirm("해당 아이디의 비밀번호를 초기화 하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admin/admAdminPwdClear.do'/>").submit();
		}
	}
</script>
</body>
</html>