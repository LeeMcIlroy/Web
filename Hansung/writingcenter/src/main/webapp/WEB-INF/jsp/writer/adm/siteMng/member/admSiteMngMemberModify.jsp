<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>
$(document).ready(function() {
    $('#memMemo').on('keyup', function() {
        if($(this).val().length > 1300) {
            $(this).val($(this).val().substring(0, 1300));
        }
        
        var content = $(this).val();
		$('#counter').html(content.length + '/1300');
    });
});

	function fn_email2(){
		if($("#emailAddress").val()=='1'){
			$("#memEmail2").val('');
			$("#memEmail2").removeAttr("readonly");
			
		}else{
			$("#memEmail2").removeAttr("disabled");
			$("#memEmail2").attr("readonly","true");
			$("#memEmail2").val($("#emailAddress").val());			
		}
	}
	//목록으로 
	function fn_list(){
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberList.do'/>").submit();
	}
	
	//등록하기
	function fn_modify(){
		 var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		 var regMphone = /^\d{3}-\d{3,4}-\d{4}$/;
		if($("#memCode").val()==''){
			alert("사번을 입력하십시오")
			return false;
		}
		if($("#memCode").val().length>10){
			alert("사번은 10자리 이하 영문,숫자 조합입니다.")
			return false;
		}
		if($("#memName").val()==''){
			alert("이름을 입력하십시오")
			return false;
		}
		if($("#memMphone2").val()==''||$("#memphone3").val()==''){
			alert("연락처를 입력하십시오")
			return false;
		}
		if($("#memEmail").val()==''){
			alert("이메일을 입력하십시오")
			return false;
		}
		if(!regEmail.test($("#memEmail1").val()+"@"+$("#memEmail2").val())) {
            alert('이메일 주소가 유효하지 않습니다');
            $("#memEmail1").focus();
            return false;
        }
		if(!regMphone.test($("#memMphone1").val()+"-"+$("#memMphone2").val()+"-"+$("#memMphone3").val())){
			alert('연락처가 유효하지 않습니다');
            $("#memMphone2").focus();
            return false;
		}
		
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberModify.do'/>").submit();
	}
</script>
<body>
<form:form commandName="adminVO" id="frm" name="frm">
<form:hidden path="memSeq" />
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
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
					<jsp:param name="dept1" value="사이트관리"/>
		            <jsp:param name="dept2" value="회원관리"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<table class="view_tbl_03 mb30 mt30" summary="회원관리">
					<caption>회원관리</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">* 사번</th>
							<td>
								<form:input path="memCode" style="width:80%; ime-mode: inactive;"/>
							</td>
						</tr>
						<tr>
							<th scope="row">* 이름</th>
							<td>
								<form:input path="memName" style="width:80%; ime-mode:active;" maxlength="60"/>
							</td>
						</tr>
						<tr>
							<th scope="row">* 이메일</th>
							<td>
								<form:input path="memEmail1" style="width:20%; ime-mode:inactive;" maxlength="100"/> 
								@ <form:input path="memEmail2" style="width:20%; ime-mode:inactive;" readonly="true" maxlength="100"/>								
								<select id="emailAddress" onchange="fn_email2(); return false;">
									<option value="">선택하세요</option>
									<option value="naver.com">naver.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="gmail.com">gmail.com</option>
									<option value="1">직접입력</option>
								</select>							
							</td>
						</tr>
						<tr>
							<th scope="row">* 휴대전화</th>
							<td>
								<form:select path="memMphone1" class="se_base">
									<form:option value="010">010</form:option>
									<form:option value="011">011</form:option>
								</form:select>
								- <form:input path="memMphone2" style="width:6%; ime-mode:disabled;" maxlength="4" onkeydown="return showKeyCode(event);"/>
								- <form:input path="memMphone3" style="width:6%; ime-mode:disabled;" maxlength="4" onkeydown="return showKeyCode(event);"/>
							</td>
						</tr>
						<tr>
							<th scope="row">회원레벨</th>
							<td>
								<form:select path="memLevel" class="se_base">
									<form:option value="1">관리자</form:option>
									<form:option value="2">교수</form:option>
									<form:option value="3">연구원</form:option>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">첨삭여부</th>
							<td>
								<form:select path="memUpdtYn" class="se_base">
									<form:option value="Y">가능</form:option>
									<form:option value="N">불가능</form:option>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">관리자 메모</th>
							<td>
								<form:textarea path="memMemo" cols="5" rows="5" style="width:100%; height:100px; ime-mode:active;"/>
								<div id="counter" style="text-align: right;">0/1300</div>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_modify(); return false;">저장</a>
							<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
						</div>
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