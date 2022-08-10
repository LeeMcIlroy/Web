<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type='text/javascript'>
	window.parent.CKEDITOR.tools.callFunction('<c:out value='${CKEditorFuncNum}'/>', '<c:out value='${file_path}'/>', '<c:out value='${message}'/>');
</script>