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
<form name="frm" action="/board/board_write_action.asp" method="post">
<table class="view1" title="����" summary="�����Դϴ�.">
	<tr>
		<td>����</td>
		<td><input type="text" name="subject"></td>
	</tr>	
	<tr>
		<td>����</td>
		<td><textarea name="content" style="display:none" cols="60" rows="10"></textarea></td>
	</tr>	
</table>
<input type="button" value="���" onclick="send();">
</form>
<!--  ������ ���� -->  
<%Server.Execute "/webfilter/inc/initCheckWebfilter.asp"%>
<!--  ������ ���� -->
</body>
</html>
