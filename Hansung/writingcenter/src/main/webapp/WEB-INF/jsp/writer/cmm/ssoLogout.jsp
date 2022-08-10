<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
<%
	String type = (String) request.getAttribute("type");
	if("USR".equals(type)){
%>
		var message = "로그인에 실패하셨습니다.\n사고와표현 관계자및 학생들만 로그인 가능합니다.\n기타문의사항은 관리자에게 문의해주세요.(02-760-4354)"
		var url = "http://writingcenter.hansung.ac.kr/usr/lgn/logout.do";
<%
	}else if("ADM".equals(type)){
%>
		var message = "로그인에 실패하셨습니다.\n사고와표현 관계자만 로그인 가능합니다.\n기타문의사항은 관리자에게 문의해주세요.(02-760-4354)"
		var url = "http://writingcenter.hansung.ac.kr/xabdmxgr/lgn/admLogout.do";
<%
	}else{
%>
		var message = "오류발생";
		var url = "/";
<%
	}
%>
	alert(message);
	location.href="https://hansung.ac.kr/c/portal/logout?redirect="+url;
</script>