<html>
<head>
<title>sample</title>

<Script Language="javascript">
function send(){
	document.frm.submit();
}              
</script>

</head>

<body>
<form name="frm" action="/board/board_write_action.aspx" method="post">
<table class="view1" title="보기" summary="보기입니다.">
	<tr>
		<td>제목</td>
		<td><input type="text" name="subject"></td>
	</tr>	
	<tr>
		<td>내용</td>
		<td><textarea name="content" style="display:none" cols="60" rows="10"></textarea></td>
	</tr>	
</table>
<input type="button" value="등록" onclick="send();">
</form>
<!--  웹필터 수정 C#-->  
<% Server.Execute("/webfilter/inc/initCheckWebfilter.aspx"); %>
<!--  웹필터 수정 C#-->

<!--  웹필터 수정 VB-->  
<!--% Server.Execute("/webfilter/inc/initCheckWebfilter.aspx") %-->
<!--  웹필터 수정 VB-->
</body>
</html>

