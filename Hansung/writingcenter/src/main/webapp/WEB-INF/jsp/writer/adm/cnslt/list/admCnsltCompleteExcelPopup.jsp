<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<body>
<form id="frm" name="frm">
	<div class="title_area" style="margin-top: 10px; margin-left: 10px;">
		<h2>상담완료 엑셀 다운로드</h2>
	</div>
	<div class="cont_box" style="width: 450px;margin-right: 10px;margin-top: 10px;margin-left: 10px;">
		<table class="view_tbl_03 mb30" summary="상담일정 등록">
		<caption>상담일정</caption>
		<colgroup>
			<col width="20%" />
			<col width="*" />
			<col width="*" />
		</colgroup>
		<tbody>
			<tr class="first">
				<th scope="row">상담일자</th>
				<td>
					<input type="text" id="startDate" name="startDate" class="common_datepicker w100" readonly="true"/> 
					~
					<input type="text" id="endDate" name="endDate" class="common_datepicker w100" readonly="true"/> 
				</td>
			</tr>
			</tbody>
		</table>
		<div class="btn_box">
			<div class="btn_r">
				<a href="#" class="b_type03" onclick="fn_excel_down(); return false;">엑셀 다운로드</a>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript">

	// 엑셀 다운로드
	function fn_excel_down(){
		if($("#startDate").val() == "" && $("#endDate").val() == ""){
			if(!confirm("기간을 정하시지 않으면 전체가 다운됩니다.\n그래도 진행하시겠습니까?")){
				return false;
			}
		}
		$.fileDownload("<c:out value='${pageContext.request.contextPath}/xabdmxgr/cnslt/list/cnsltCompleteExcelDown.do'/>", {
			data : $("#frm").serialize()
			, httpMethod: "POST"
			, successCallback : function(url){
				// 로딩 end
				window.close();
			}
		});
		//$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/xabdmxgr/cnslt/list/cnsltCompleteExcelDown.do'/>").submit();
	}
</script>
</body>
</html>