<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>

$(function(){
	$('#popContent').on('keyup', function() {
        if($(this).val().length > 2000) {
            $(this).val($(this).val().substring(0, 1300));
        }
		
	});

});

	//목록으로
	function fn_list(){
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/popup/admSiteMngPopupList.do'/>").submit();
	}
	
	//저장
	function fn_modify(){
		if($("#popTitle").val() == ''){
			alert("제목을 입력하십시오");
			return false;
		}
		if($("#popWidth").val() == ''){
			alert("넓이를 지정하세요");
			return false;
		}
		if($("#popHeight").val() == ''){
			alert("높이를 지정하세요");
			return false;
		}
		
		
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/popup/admSiteMngPopupModify.do'/>").submit();
	}
</script>
<body>
<form:form commandName="popupVO" id="frm" name="frm">
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<form:hidden path="popSeq" />
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!--// header -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<div class="title_area">
				<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="사이트관리"/>
		            <jsp:param name="dept2" value="팝업관리"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<table class="view_tbl_03 mb30 mt30" summary="팝업관리">
					<caption>팝업관리</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">팝업창 제목</th>
							<td><form:input path="popTitle" style="width:100%;" maxlength="150"/></td>
						</tr>
						<tr>
							<th scope="row">팝업창 크기</th>
							<td>
								<dl class="pop_dl">
									<dt>width(넓이)</dt>
									<dd><form:input path="popWidth" style="width:50px; ime-mode: disabled;" onkeydown="return showKeyCode(event);" maxlength="5"/> px</dd>
									<dt>height(높이)</dt>
									<dd><form:input path="popHeight" style="width:50px; ime-mode: disabled;" onkeydown="return showKeyCode(event);" maxlength="5" /> px</dd>
								</dl>
							</td>
						</tr>
						<tr>
							<th scope="row">팝업창 위치</th>
							<td>
								<dl class="pop_dl">
									<dt>top</dt>
									<dd><form:input path="popTop" style="width:50px; ime-mode: disabled; "  onkeydown="return showKeyCode(event);" maxlength="5" /> px</dd>
									<dt>left</dt>
									<dd><form:input path="popLeft" style="width:50px; ime-mode: disabled; " onkeydown="return showKeyCode(event);" maxlength="5" /> px</dd>
								</dl>
							</td>
						</tr>
						<tr>
							<th scope="row">팝업창 환경</th>
							<td>
								<dl class="pop_dl">
									<dt>Scrollbars</dt>
									<dd><form:radiobutton path="popScrollYn" value="N" label="없음" checked="true" />&nbsp;&nbsp;&nbsp;<form:radiobutton path="popScrollYn" value="Y" label="있음"/></dd>
									<dt>resizable</dt>
									<dd><form:radiobutton path="popResizeYn" value="N" label="없음" checked="true" />&nbsp;&nbsp;&nbsp;<form:radiobutton path="popResizeYn" value="Y" label="있음"/></dd>
								</dl>
							</td>
						</tr>
						<tr>
							<th scope="row">팝업창 View</th>
							<td>
								<dl class="pop_dl">
									<dd><form:radiobutton path="popViewYn" value="Y" label="보이기" checked="true" />&nbsp;&nbsp;&nbsp;<form:radiobutton path="popViewYn" value="N" label="숨기기"/></dd>
								</dl>
							</td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td>
								<form:textarea path="popContent" />
								<script type="text/javascript">
									CKEDITOR.replace( 'popContent', {
										filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_modify(); return false;">저장</a>
							<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
						</div>
					</div>
				</div>
			<!-- //content -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>