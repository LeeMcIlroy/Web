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
	//관리자 비밀번호 변경
	function fn_modify_pw(){
		var pw1 = $("#pw1").val();
		var pw2 = $("#pw2").val();
		var pw3 = $("#pw3").val();
		var num = pw2.search(/[0-9]/g);
		var eng = pw2.search(/[a-z]/ig);
		var spe = pw2.search(/[`~!@#$^*|₩₩₩'₩";:₩/?]/gi);
		
		if(pw1 == ''){
			alert('비밀번호를 입력해주세요.');
			$("#pw1").focus();
			return;
		}
		else if($("#pwChkTxt").hasClass('dpn')){
			alert('현재 비밀번호가 일치하지 않습니다.');
			$("#pw1").focus();
			return;
		}
		else if(pw2 == ''){
			alert('비밀번호를 입력해주세요.');
			$("#pw2").focus();
			return;
		}
		else if(pw3 == ''){
			alert('비밀번호를 입력해주세요.');
			$("#pw3").focus();
			return;
		}
		else if(pw2 != pw3){
			alert('비밀번호가 일치하지 않습니다.');
			$("#pw3").focus();
			return;
			
		}
		else if(pw2.length < 8 || num < 0 || eng < 0 || spe < 0){
			alert('비밀번호는 영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.');
			$("pw2").focus();
			return;
		}		
		else{
			$("#detailForm").attr("action", "<c:url value= '/qxsepmny/ech0702/ech0702AjaxPasswordUpdate.do'/>").submit();
			alert('변경 되었습니다.');
		}
		
	
	};
	
	function fn_cancel(){
		$("#detailForm").attr("action", "<c:url value= '/qxsepmny/oper/admAdminProfileView.do'/>").submit();
		alert('취소 되었습니다.');
	};
	
	// 현재 비밀번호 유효성 검사
	function fn_pwChk(ele){
		var adminPw = $(ele).val();
		
		$.ajax({
			url: "<c:url value='/qxsepmny/ech0702/ech0702AjaxAdminPwChk.do'/>"
			, type: "post"
			, data: "adminPw="+adminPw
			, dataType: "json"
			, success: function(data){
				var status = data.status;
				console.log(status);
				if(status){
						$("#pwChkTxt").removeClass('dpn');
						$("#pwChkTxt2").addClass('dpn');
						$("#pwChk").val('Y');
				}else{
						$("#pwChkTxt").addClass('dpn');
						$("#pwChkTxt2").removeClass('dpn');
						$("#pwChk2").val('N');
				}
			},error: function(){
				
			}
		});
	};
	
	// 새 비밀번호 변경 유효성검사
	$(function(){
		$("#alert-pw-guide").removeClass('dpn');
		$("#alert-danger").addClass('dpn');
		$("#alert-success_1").addClass('dpn');
		$("#alert-success_2").addClass('dpn');
		$("#alert-danger_1").addClass('dpn');
		$("#alert-pw-check").addClass('dpn');
		$("#alert-pw-check_1").addClass('dpn');
	
		$("input").keyup(function(){
			var pw2 = $("#pw2").val(); // 새 비밀번호
			var pw3 = $("#pw3").val(); // 새비밀번호 확인
			var num = pw2.search(/[0-9]/g);
			var eng = pw2.search(/[a-z]/ig);
			var spe = pw2.search(/[`~!@#$^*|₩₩₩'₩";:₩/?]/gi);
			
			if(pw2 == ""){
				$("#alert-pw-guide").removeClass('dpn');
				$("#alert-pw-check").addClass('dpn');
				$("#alert-success_1").addClass('dpn');
				$("#alert-success_2").addClass('dpn');
				$("#alert-danger_1").addClass('dpn');
				$("#alert-pw-check_1").addClass('dpn');
			}
			
			// 비밀번호 영문,숫자,특수문자 조합 8자리 이상 체크
			else{
			
			 if(pw2.length < 8 || num < 0 || eng < 0 || spe < 0){
				$("#alert-pw-check").removeClass('dpn');
				$("#alert-pw-guide").addClass('dpn');
				$("#alert-success_1").addClass('dpn');
				$("#alert-success_2").addClass('dpn');
				$("#submit").attr("disabled", "disabled");
				return false;
			
			 }else{
				 $("#alert-success_1").removeClass('dpn');
				 $("#alert-pw-check").addClass('dpn');
				 $("#alert-pw-guide").addClass('dpn');
			 }
			}
			
			if(pw3 == ""){
				$("#alert-pw-check").addClass('dpn');
				$("#alert-pw-check_1").addClass('dpn');
				$("#alert-success_2").addClass('dpn');
				$("#alert-danger_1").addClass('dpn');
			}
			else{
				if(pw2 != pw3){
				$("#alert-danger_1").removeClass('dpn');
				$("#alert-pw-check_1").addClass('dpn');
				$("#alert-success_2").addClass('dpn');
				$("#submit").attr("disabled", "disabled");
				return false;
				}
				else{
					$("#alert-success_2").removeClass('dpn');
					$("#alert-danger_1").addClass('dpn');
					$("#alert-pw-check").addClass('dpn');
					$("#alert-pw-check_1").addClass('dpn');
					$("#alert-pw-guide").addClass('dpn');
					$("#submit").removeAttr("disabled");
				}
			}
	
		});
		
	});


	$(function(){
		
		$("#auth-all").click(function(){
			var checked = $(this).is(":checked");
			
			$(".auth input[type=checkbox]").prop("checked", checked);
		});
		
		var ynVal = '<c:out value="${ct1030mVO.ipAllYn}"/>';
		if(ynVal == 'Y'){
			$("#ipAllYn1").attr('checked', 'checked');
		}else{
			$("#ipAllYn2").attr('checked', 'checked');
		}
		
		
		var ynVal = '<c:out value="${ct1030mVO.userSt}"/>';
		if (ynVal == '1') {
			$("#userSt1").attr('checked', 'checked');
		} else if (ynVal == '2') {
			$("#userSt2").attr('checked', 'checked');
		} else {
			$("#userSt1").attr('checked', 'checked');
		}
		
		var ynEmail = '<c:out value="${ct1030mVO.email}"/>';
		if(ynEmail == ''){
			$("#emailAdr").attr('value', 'hanmail.net');
		}
		
		// 등록, 수정 구분? 
		
		// $("#datepicker01").datepicker();

	});

	function fn_mailadr(el){
		var addr = $(el).val();
		
		if('' == addr){
			$("#emailAdr").removeAttr('disabled');
		}else{
			$("#emailAdr").attr('disabled', 'true');
		}
		$("#emailAdr").val(addr);
	}

	function fn_idChk(ele){
		var adminId = $(ele).val();
		
		$.ajax({
			url: "<c:url value='/qxsepmny/ech0702/ech0702AjaxAdminIdChk.do'/>"
			, type: "post"
			, data: "adminId="+adminId
			, dataType:"json"
			, success: function(data){
				var status = data.status;
				
				if(!status){
					$("#idChkTxt").removeClass('dpn');
					$("#idChk").val('N');
				}else{
					$("#idChkTxt").addClass('dpn');
					$("#idChk").val('Y');
				}
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0702/ech0702List.do'/>").submit();
	}
	
	function fn_save(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var stat = $('#userSt').val();
		var name = $('#empName').val();
		var userId = $('#userId').val();
		
		
		if(userId==''){
			alert('아이디를 입력해주세요.')
			$('#userId').focus();
			return;
		}
		
		if(name==''){
			alert('이름을 입력해주세요.')
			$('#name').focus();
			return;
		}
				
		if(stat==''){
			alert('상태항목을 선택해주세요.');
			$('#userSt').focus();
			return;
		}
	
		$("#emailAdr").removeAttr('disabled'); 
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0702/ech0702Update.do'/>").submit();
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
	            <jsp:param name="dept2" value="사용자Profile"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="ct1030mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${ct1030mVO.corpCd}">
				<input type="hidden" id="empNo" name="empNo" value="${ct1030mVO.empNo}">
				<input type="hidden" id="userId" name="userId" value="${ct1030mVO.userId}">
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
							<th scope="row">사용자ID</th>
							<td>
								<c:out value="${ct1030mVO.userId}" />
							</td>
							<th scope="row" class="b1">이름</th>
							<td>
								<c:out value="${ct1030mVO.empName}" />
							</td>
						</tr>
						
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 서브타이틀 -->
				<div class="sub_title_area">
					<h4>비밀번호 변경</h4>
				</div>
				<!-- //서브타이틀 -->
	            <!-- 비밀번호 변경 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">현재비밀번호</th>
							<td colspan="3">
								<input  type="password" id="pw1" class="input-data p20" placeholder="현재 비밀번호를 입력해주세요" onkeyup="fn_pwChk(this); return false;"/>
								<span class="alt-txt dpn" id="pwChkTxt">비밀번호가 일치합니다.</span>
								<input type="hidden" id="pwChk" value="Y"/>
								<span class="alt-txt dpn" id="pwChkTxt2">비밀번호가 일치하지 않습니다.</span>
								<input type="hidden" id="pwChk2" value="N"/>
							</td>
						</tr>
						<tr>
							<th scope="row" >새비밀번호</th>
							<td colspan="3">
								<input type="password" id="pw2" name="adminPw" class="input-data p20" placeholder="영문,숫자, 특수문자를 혼합하여 8자리 이상" />
								<span class="alt-txt dpn" id="alert-pw-guide">영문,숫자,특수문자 조합으로 8자 이상 설정</span>
								<span class="alt-txt dpn" id="alert-pw-check">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다(일부 특수문자 제한)</span>
								<!-- <span class="alt-txt" id="alert-pw-space-check" >비밀번호는 공백없이 입력해주세요.</span> -->
								<span class="ok-signature dpn" id="alert-success_1">O.K</span>
							</td>
						</tr>
						<tr>
							<th scope="row" >새비밀번호확인</th>
							<td colspan="3">
								<input type="password" id="pw3" class="input-data p20" placeholder="비밀번호 확인"/>
								<span class="alt-txt dpn" id="alert-danger_1">비밀번호가 일치하지 않습니다.</span>
								<span class="alt-txt dpn" id="alert-pw-check_1">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.</span>
								<span class="ok-signature dpn" id="alert-success_2">O.K</span>
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //사용자정보 -->	            
            </form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_modify_pw(); return false;" >저장</a>
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