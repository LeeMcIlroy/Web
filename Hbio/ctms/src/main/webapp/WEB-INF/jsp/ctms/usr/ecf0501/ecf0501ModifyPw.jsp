<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
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
			$("#detailForm").attr("action", "<c:url value= '/usr/ecf0501/ecf0501AjaxPasswordUpdate.do'/>").submit();
		}
		
	
	};
	
	function fn_cancel(){
		$("#detailForm").attr("action", "<c:url value= '/usr/ecf0501/ecf0501Modify.do'/>").submit();
		alert('취소 되었습니다.');
	};
	
	// 현재 비밀번호 유효성 검사
	function fn_pwChk(ele){
		var adminPw = $(ele).val();
		var pass = 'OK';
		$.ajax({
			url: "<c:url value='/usr/ecf0501/ecf0501AjaxUsrPwChk.do'/>"
			, type: "post"
			, data: "adminPw="+adminPw+"&"+"pass="+pass
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




	function fn_save(){

		var name = $('#userId').val();
		if(name==''){
			alert('아이디를 입력해주세요.')
			$('#userId').focus();
			return;
		}
			
		var name = $('#rsjName').val();
		if(name==''){
			alert('이름을 입력해주세요.')
			$('#rsjName').focus();
			return;
		}
		
		$("#emailAdr").removeAttr('disabled');
		$("#usrId").removeAttr('disabled');
		$("#rsjName").removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/ecf0501/ecf0501Update.do'/>").submit();
	}
</script>	
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<form:form commandName="sb1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
	<input type="hidden" id="corpCd" name="corpCd" value="${sb1000mVO.corpCd}">
	<input type="hidden" id="rsjNo" name="rsjNO" value="${sb1000mVO.rsjNo}">
	<input type="hidden" id="userId" name="userId" value="${sb1000mVO.userId}">
	<!-- contents -->
	<div class="contents">
		<!-- 회원정보 -->
		<div class="com_reg">			
			<ul>
				<li>
					<div>
						<p>현재비밀번호</p>
						<div>
							<input  type="password" id="pw1" class="input-data p20" placeholder="현재 비밀번호를 입력해주세요" onkeyup="fn_pwChk(this); return false;"/>
							<span class="alt-txt dpn" id="pwChkTxt">비밀번호가 일치합니다.</span>
							<input type="hidden" id="pwChk" value="Y"/>
							<span class="alt-txt dpn" id="pwChkTxt2">비밀번호가 일치하지 않습니다.</span>
							<input type="hidden" id="pwChk2" value="N"/>
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>새비밀번호</p>
						<div>
							<input type="password" id="pw2" name="adminPw" class="input-data p20" placeholder="영문,숫자, 특수문자를 혼합하여 8자리 이상" />
							<span class="alt-txt dpn" id="alert-pw-guide">영문,숫자,특수문자 조합으로 8자 이상 설정</span>
							<span class="alt-txt dpn" id="alert-pw-check">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다(일부 특수문자 제한)</span>
							<!-- <span class="alt-txt" id="alert-pw-space-check" >비밀번호는 공백없이 입력해주세요.</span> -->
							<span class="ok-signature dpn" id="alert-success_1">O.K</span>
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>새비밀번호 확인</p>
						<div>
							<input type="password" id="pw3" class="input-data p20" placeholder="비밀번호 확인"/>
							<span class="alt-txt dpn" id="alert-danger_1">비밀번호가 일치하지 않습니다.</span>
							<span class="alt-txt dpn" id="alert-pw-check_1">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다(일부 특수문자 제외)</span>
							<span class="ok-signature dpn" id="alert-success_2">O.K</span>
						</div>
					</div>
				</li>
			</ul>
		</div>
		<!-- //회원정보 -->
		</form:form>
		<!-- 하단버튼 -->
		<div class="btn_area">
			<span><a href="#" onclick="fn_cancel(); return false;" class="type02">취소</a></span>
			<span><a href="#" onclick="fn_modify_pw(); return false;" >저장</a></span>
		</div>
		<!-- //하단버튼 -->
	</div>
	<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	<!-- //contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- //footer -->
	<!-- 팝업 -->
	<input type="checkbox" id="modi-pop" class="hidden" />
	<div class="black-pop">&nbsp;</div>
	<!-- 주소찾기 -->
	<div class="modi-popup" id="addrPop">
	</div>
	<!--// 주소찾기 -->	
</div>
<!-- //wrap -->
</body>
</html>