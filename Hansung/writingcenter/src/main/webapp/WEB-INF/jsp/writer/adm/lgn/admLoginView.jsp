<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">

/*
	$(function(){
	
	    var message = $("#message").val();
	    if (message != "") {
	        alert(message);
	        $("#message").val('');
	    }
		$("#memCode").val("admin");
		$("#memCode").focus();
		
		//enter
		$("#memCode").on("keydown", function(e) {
			if (e.keyCode == 13) {
				fn_login();
				return false;
			}
		}); 
	});
*/
	
	// 로그인(sso 화면으로 이동)
	function fn_login(){
		/*
		if( $.trim($("#memCode").val())==""){
			alert("사번을 입력해주세요.");
			$("#memCode").focus();
			return false;
		}
		$("#detailForm").submit();
		*/
		location.href = "https://hansung.ac.kr/hansung/link_login.jsp?p_p_id=58&_58_redirect=http://writingcenter.hansung.ac.kr/xabdmxgr/lgn/admLogin.do";
	}

</script>
<body>
<div class="main_top">
	<div id="header02">
		<div>
			<img src="<c:url value='/assets/adm/img/top_logo.jpg'/>"/>
		</div>
	</div>

	<div id="loginWrap">
		<div class="inner">
			<p class="log_tit">한성대학교 사고와 표현 관리자</p>
			<div class="log_box">
				<p>
					한성대학교 종합정보시스템 <span>ID, PW</span>로 로그인 가능합니다.
				</p>
				<div>
					<%--
					<form id="detailForm" name="detailForm" method="post" action="<c:url value='/xabdmxgr/lgn/admLogin.do'/>">
						<input type="text" id="memCode" name="memCode" style="width:30%;" />
					</form>
					--%>
					<a href="#" onclick="fn_login(); return false;" style="display: inline-block;">로그인</a>
				</div>
			</div>
			<div class="icon_li">
				<ul>
					<li>한성대 사고와 표현 관리자 공간입니다.</li>
					<li>권한이 없는 사용자는 접근하실 수 없습니다.</li>
					<li>문의사항이 있으시면 <a href="mailto:writingcenter@hansung.ac.kr">writingcenter@hansung.ac.kr</a>로
						메일을 보내주세요
					</li>
				</ul>
			</div>
			<div id="log_foot">Copyright@한성대학교. All Rights reserved.</div>
		</div>
	</div>
</div>
<input type="hidden" id="message" name="message" value="${message }"/>
</body>
</html>