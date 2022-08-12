<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script type="text/javascript">

	$(function(){
		///$("#user_pw").keyup(function(){
			//var pw2 = $("#user_pw").val(); // 비밀번호
			//var num = pw2.search(/[0-9]/g);
			//var eng = pw2.search(/[a-z]/ig);
			//var spe = pw2.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
			
			//if(pw2 == ""){
				//$("#alert-pw-guide").removeClass('dpn');
				//$("#alert-pw-check").addClass('dpn');
				//$("#alert-success_1").addClass('dpn');
				//$("#alert-success_2").addClass('dpn');
				//$("#alert-danger_1").addClass('dpn');
				//$("#alert-pw-check_1").addClass('dpn');
			//}	
			
			//if(pw2.length < 8 || num < 0 || eng < 0 || spe < 0){
				//$("#alert-pw-check").removeClass('dpn');
				//$("#alert-pw-guide").addClass('dpn');
				//$("#alert-success_1").addClass('dpn');
				//$("#alert-success_2").addClass('dpn');
				//$("#submit").attr("disabled", "disabled");
				//return false;
			
			 //}else{
				 //$("#alert-success_1").removeClass('dpn');
				 //$("#alert-pw-check").addClass('dpn');
				 //$("#alert-pw-guide").addClass('dpn');
			 //}	
		//}
	});
		
		
	//이용약관 팝업
	function fn_useRulePop(corpCd){
		window.open("<c:out value='${pageContext.request.contextPath }/usr/login/useRulePop.do'/>?corpCd="+corpCd
				, '이용약관', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}	

	//이용약관 팝업
	function fn_privRulePop(corpCd){
		window.open("<c:out value='${pageContext.request.contextPath }/usr/login/privRulePop.do'/>?corpCd="+corpCd
				, '개인정보처리방침', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//아이디중복체크
	function fn_idChk(ele){
		var userId = $(ele).val();
		$.ajax({
			url: "<c:url value='/usr/login/AjaxUserIdChk.do'/>"
			, type: "post"
			, data: "userId="+userId
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
	
	
	
	function fn_save(){
		
		var userId = $('#userId').val();
		if(userId==''){
			alert('아이디를 입력해주세요.')
			$('#userId').focus();
			return;
		}
	
		var userPw = $('#user_pw').val();
		if(userPw==''){
			alert('비밀번호를 입력해주세요.')
			$('#user_pw').focus();
			return;
		}
		
		var num = userPw.search(/[0-9]/g);
		var eng = userPw.search(/[a-z]/ig);
		var spe = userPw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		
		if(userPw.length < 8 || num < 0 || eng < 0 || spe < 0){
			alert('비밀번호는 영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.');
			$("user_pw").focus();
			return;
		}
		
		var name = $('#user_name').val();
		if(name==''){
			alert('이름을 입력해주세요.')
			$('#user_name').focus();
			return;
		}
		
		var name = $('#user_phone').val();
		if(name==''){
			alert('핸드폰 번호를 입력해주세요.')
			$('#user_phone').focus();
			return;
		}
		
		if($("input[name=useRuleYn]:checked").length == 0){
			alert('이용약관에 동의해 주세요.');
			$('#agree02').focus();
			return;
		}
		
		if($("input[name=privRuleYn]:checked").length == 0){
			alert('개인정보처리방침에 동의해 주세요.');
			$('#agree01').focus();
			return;
		}
		
		
		
		//$("#emailAdr").removeAttr('disabled');
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/login/memberSave.do'/>").submit();
	}
	
	
	
</script>
<body>
<!-- wrap -->
<div class="login_wrap">
	<!-- 회원가입 -->
	<div class="signup">
		<!-- 로고 -->
		<h1>H&amp;Bio</h1>
		<div class="signup_top">
			<h2>회원가입</h2>
			회원가입 신청 후 승인을 통해 가입하실 수 있습니다.
		</div>
		<!-- 정보입력 -->		
		<div class="signup_reg">
		<form:form commandName="sb1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${sb1000mVO.corpCd}">
			
			<input type="text" value="<c:out value="${sb1000mVO.userId }" />"  placeholder="아이디" class="input-data required" id="userId" name="userId" onkeyup="fn_idChk(this); return false;"/>							
			<span class="alt-txt dpn" id="idChkTxt">이미 등록되어 있는 아이디입니다.</span>
			<input type="hidden" id="idChk" value="N"/>
			
			<!-- <input type="text" value="<c:out value="${sb1000mVO.userId }" />" placeholder="아이디" class="input-data required" id="userId" name="userId"  />  -->
			
			<!-- <input type="password" id="user_pw" name="pwNo" class="input-data p20" placeholder="영문,숫자, 특수문자를 혼합하여 8자리 이상" />
			<span class="alt-txt dpn" id="alert-pw-guide">영문,숫자,특수문자 조합으로 8자 이상 설정</span>
			<span class="alt-txt dpn" id="alert-pw-check">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.</span>
			<!-- <span class="alt-txt" id="alert-pw-space-check" >비밀번호는 공백없이 입력해주세요.</span> -->
			<!-- <span class="ok-signature dpn" id="alert-success_1">O.K</span>  -->
			
			
			<input type="password" placeholder="비밀번호(영문,특수문자,숫자  조합 8자 이상)" value="<c:out value="${sb1000mVO.pwNo }" />" class="input-data required" id="user_pw" name="pwNo"  />
			
			<p>기본정보</p>
			<input type="text" value="<c:out value="${sb1000mVO.rsjName }" />" placeholder="이름" class="input-data required" id="user_name" name="rsjName"  />
			<input type="text" value="<c:out value="${sb1000mVO.hpNo }" />" placeholder="핸드폰 번호" class="input-data required" id="user_phone" name="hpNo"  />
			(핸드폰번호는 '-'를 제외하고 입력해주세요)
			<div>
				<p>
					<input type="checkbox" id="agree01" name="useRuleYn" class="form_base required" value="Y"/>
					<label for="agree01">이용약관에 동의합니다.</label>
					<a href="#" onclick="fn_useRulePop('<c:out value="${sb1000mVO.corpCd }"/>'); return false;" style="text-decoration: underline;">확인하기</a>
				</p>
				<p>
					<input type="checkbox" id="agree02" name="privRuleYn" class="form_base required" value="Y" />
					<label for="agree02">개인정보처리방침에 동의합니다.</label>
					<a href="#" onclick="fn_privRulePop('<c:out value="${sb1000mVO.corpCd }"/>'); return false;" style="text-decoration: underline;">확인하기</a>
				</p>
			</div>
			</form:form>
			<a href="#" onclick="fn_save(); return false;" >회원가입</a>
			<a href="<c:out value='${pageContext.request.contextPath }/usr/login/loginView.do'/>">로그인</a>
		</div>
		<!-- //정보입력 -->
	</div>
	<!-- //회원가입 -->
</div>
<!-- //wrap -->
</body>
</html>
