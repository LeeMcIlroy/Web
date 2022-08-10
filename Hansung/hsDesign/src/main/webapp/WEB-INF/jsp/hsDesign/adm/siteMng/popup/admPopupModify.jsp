<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>한성대학교 디자인아트 교육원</title>
<!-- header -->
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<!--// header -->
</head>
<body>
<div class="wrap">
	<!-- topnav -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!-- topnav -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<div class="title_area">
				<h3>팝업관리</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 사이트관리 &gt; 팝업관리 &nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
			<form:form commandName="popupVO" id="frm" name="frm" enctype="multipart/form-data">
			<form:hidden path="popSeq"/>
			<div class="cont_box">
			<!-- content -->
			<div class="tbl_top_area2 mt30">
				<div class="btn_r">
					* 는 필수 입력항목입니다.
				</div>
			</div>
				<!-- table -->
				<table class="view_tbl_03 mb30" summary="팝업관리">
					<caption>팝업관리</caption>
					<colgroup>
							<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">* 팝업창 제목</th>
							<td>
								<form:input path="popTitle" class="in_base" style="width:80%;" />
							</td>
						</tr>
						<tr>
							<th scope="row">* 팝업창 크기</th>
							<td>
								<ul class="pop_size">
									<li>
										<dl>
											<dt>width(넓이)</dt>
											<dd><form:input path="popWidth" class="in_base" style="width:50px;" /> px</dd>
										</dl>
									</li>
									<li>
										<dl>
											<dt>height(높이)</dt>
											<dd><form:input path="popHeight" class="in_base" style="width:50px;" /> px</dd>
										</dl>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row">* 팝업창 위치</th>
							<td>
								<ul class="pop_size">
									<li>
										<dl>
											<dt>top</dt>
											<dd><form:input path="popTop" class="in_base" style="width:50px;" /> px</dd>
										</dl>
									</li>
									<li>
										<dl>
											<dt>left</dt>
											<dd><form:input path="popLeft" class="in_base" style="width:50px;" /> px</dd>
										</dl>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row">스크롤여부</th>
							<td>
								<form:radiobutton path="popScrollYn" value="Y" checked="checked"/> <label for="radio_ck0201">가능</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<form:radiobutton path="popScrollYn" value="N"/> <label for="radio_ck0202">불가능</label>
							</td>
						</tr>
						<tr>
							<th scope="row">창크기변동여부</th>
							<td>
								<form:radiobutton path="popResizeYn" value="Y" checked="checked"/> <label for="radio_ck0201">가능</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<form:radiobutton path="popResizeYn" value="N"/> <label for="radio_ck0202">불가능</label>
							</td>
						</tr>
						<tr>
							<th scope="row">사용여부</th>
							<td>
								<form:radiobutton path="popUseYn" value="Y" checked="checked"/> <label for="radio_ck01">YES</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<form:radiobutton path="popUseYn" value="N"/> <label for="radio_ck02">NO</label>
							</td>
						</tr>
						<tr>
							<th scope="row">* 팝업 이미지</th>
							<td>
								<input type="file" id="attachedFile_1" name="attachedFile_1"/>
								<br />
								<c:if test="${empty popupVO.popSeq}">
									<input type="hidden" id="popupDelChk" name="popupDelChk" value="new"/>
								</c:if>
								<c:if test="${!empty popupVO.popSeq}">
									<c:out value="${popupVO.popImgName }"/>
									<input type="checkbox" id="popupDelChk" name="popupDelChk" value="<c:out value="${popupVO.popImgName }"/>"/>
									<label for="popupDelChk">삭제</label>
								<br />
								</c:if>
							</td>
						</tr>
						<tr class="first">
							<th scope="row">팝업 URL</th>
							<td>
								<form:input path="popUrl" class="in_base" style="width:80%;" />
								<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* http를 포함한 전체 URL 주소를 입력해 주세요</div>
							</td>
						</tr>
					</tbody>
				</table>
				</div>
				<div class="btn_box">
					<div class="btn_r">
						<c:if test="${!empty popupVO.popSeq }"><a href="#" onclick="fn_delete(); return false;" class="b_type02">삭제</a></c:if>
						<a href="#" onclick="fn_save(); return false;" class="b_type04">저장</a>
						<a href="#" onclick="fn_list(); return false;" class="b_type03">목록</a>
					</div>
				</div>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex }'/>"/>
				<input type="hidden" name="searchCondition1" value="<c:out value='${searchVO.searchCondition1 }'/>"/>
				<input type="hidden" name="searchCondition2" value="<c:out value='${searchVO.searchCondition2 }'/>"/>
				<input type="hidden" name="searchWord" value="<c:out value='${searchVO.searchWord }'/>"/>
			</form:form>
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
<script type="text/javascript">
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/popup/admPopupList.do'/>").submit();
	}
	
	// 등록&수정
	function fn_save(){
		
		if($("#popTitle").val() == ''){
			alert("팝업명은 필수 입력항목입니다.");
			return false;
		}else if($("#popWidth").val() == '' || $("#popHeight").val() == '' ){
			alert("팝업창 크기를 지정해 주십시오.");
			return false;
		}else if($("#popTop").val() == '' || $("#popLeft").val() == '' ){
			alert("팝업창 위치를 지정해 주십시오.");
			return false;
		}
		
		if($("#popOrder").val() == ''){
			$("#popOrder").val("1");
		}
		
		if($("#popSeq").val() != ''){
			if($("#popupDelChk").prop("checked") && $("#attachedFile_1").val() == ""){
				alert("PC이미지는 필수 입력항목입니다.");
				return false;
			}
		}else{
			if($("#attachedFile_1").val() == ""){
				alert("PC이미지는 필수 입력항목입니다.");
				return false;
			}
		}		
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/popup/admPopupUpdate.do'/>").submit();
	}
	
	//삭제
	function fn_delete(){
		if(confirm("삭제하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/popup/admPopupDelete.do'/>").submit();	
		}	
	}
</script>
</body>
</html>