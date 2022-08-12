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
		$("#hpNo").focus();
		$("#hpNo").keyup(function(e){
			if(e.keyCode == 13){
				fn_login();
			}
		});
		
		//핸드폰로그인 여부 확인 
		/* var ynhplogin = '<c:out value="${hplogin}"/>';
		alert(ynhplogin);
		switch (ynhplogin){
	      case "Y" : //핸드폰로그인
	    	  $("#idlogin").hide();
	          break;
	      case "N" : //아이디 비번 로그인
	    	  $("#hplogin").hide();
	          break;
	      default :
	          document.write("nothing");
	    } */
		
	});
	
	function fn_login(){
		//var userId = $('#userId').val();
		var hpNo = $('#hpNo').val();
		if(hpNo=='') {
			alert('핸드폰번호를 입력해주세요.')
			$('#hpNo').focus();
			return;	
		}
		
		$("#frm").attr("action", "<c:url value='/usr/login/loginProcCtr.do'/>").submit();
		/* if(fn_validate('frm')){
			$("#frm").attr("action", "<c:url value='/usr/login/loginProc.do'/>").submit();
		} */
	}
	
	function fn_keydown(){
		if(event.keyCode == 13){
			fn_login();
			return;
		}
	}
</script>
<body>
<!-- wrap -->
<div class="login_wrap">
	<form:form commandName="sb1000mVO" id="frm" name="frm" method="post">
	<input type="hidden" id="ctrlogin" name="ctrlogin"/>
	<input type="hidden" id="hplogin" name="hplogin"/>
		<!-- 로그인영역 -->
		<div class="login">
			<!-- 로고 -->
			<h1>H&amp;Bio</h1>
			<div class="login_top">
				<h2>로그인(임상시험센터)</h2>
				임상시험관리시스템에 로그인하시려면<br />핸드폰번호를 입력해주세요.
			</div>
			<!-- 로그인 -->
			<fieldset id="idlogin">
				<legend>로그인</legend>
				<p>아래에 핸드폰번호를 입력하세요('-'빼고 입력)</p>
				<label for="hpNo" class="hidden">핸드폰번호</label>
				<form:input path="hpNo" placeholder="핸드폰번호" class="required" title="핸드폰번호" value="01036100135" />
				<a href="#" onclick="fn_login(); return false;">로그인</a>
				<!-- SNS 로그인 -->
				<div>
<!-- 					<ul>
						<li><a href="#"><i></i>카카오톡 로그인</a></li>
						<li><a href="#"><i></i>네이버 로그인</a></li>
					</ul> -->
				</div>
			</fieldset>
			<!-- //로그인 -->
			<!-- 로그인 하단 -->
			<div class="login_btm">
				<div>
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/login/joinMem.do'/>">회원가입</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/login/searchId.do'/>">아이디 찾기</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/login/searchPw.do'/>">비밀번호 찾기</a></li>
					</ul>
				</div>
				<p>회원가입은 무료입니다.</p>
				<p>인가된 사용자만 접속할 수 있으며 불법으로 접속시에는 제재를 받을 수 있습니다. 시스템을 사용하기 위해서는 등록과정이 필요하며, 시스템 담당자에게 문의하시기 바랍니다.</p>
				<%-- <input type="text" id="strmac" name="strmac" value="<c:out value="${strmac }" />"  /> --%>				
			</div>

			<!-- //로그인 하단 -->
		</div>
		<!-- //로그인영역 -->	
		<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
	</form:form>
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooterLogin"/>
	<!-- //footer -->
</div>
<!-- //wrap -->
</body>
</html>