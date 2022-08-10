<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript" language="javascript">
	function RunFile() {
		WshShell = new ActiveXObject("WScript.Shell");
		WshShell.Run("C:/Windows/SysWOW64/notepad.exe", 1, false);
	}
	
	function fn_exe(){
		location.href="/usr/exeTest.do";	
	}
</script>
<body>
<p>테스트 화면</p>
<button onclick="fn_exe(); return false;">외부 exe 실행</button>
<button onclick="RunFile(); return false;">메모장 실행</button>
</body>
</html>