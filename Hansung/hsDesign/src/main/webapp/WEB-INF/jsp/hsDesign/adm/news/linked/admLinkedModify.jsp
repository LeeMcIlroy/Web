<!-- 200408 추가 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	$(function(){
		// 초기 화면 셋팅
		if($("#cbThType").val() == "AVI"){
			$("#cbThTypeSel").append('<input type="text" id="cbThUrl" name="cbThUrl" value="${cmmBoardVO.cbThUrl}" class="in_base" style="width:400px; height:25px; margin-left:5px;" />');
			$(".alt_txt").html("YouTube 또는 Vimeo에서 제공하는 공유 주소를 입력해 주세요.");
		}else{
			$("#cbThTypeSel").append('<input type="file" id="attachedFile_1" name="attachedFile_1"/>');
		<c:if test="${!empty cmmBoardVO.cbThImgName}">
			$("#cbThTypeSel").append("<a href=\"#\" onclick=\"fn_filedownload(${cmmBoardVO.cbSeq}, 'CMMBOARD_THUMB'); return false;\"><c:out value='${cmmBoardVO.cbThImgName}'/></a>");
		</c:if>
			$(".alt_txt").html("JPG, GIF 형식으로 입력해 주세요.");
		}
		
		$(document).on("change", "#cbThType", function(){
			$("#cbThTypeSel").empty();
			if($(this).val() == "AVI"){
				var agent = navigator.userAgent.toLowerCase();

				if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
					// ie 일때 
					$("#attachedFile_1").replaceWith( $("#attachedFile_1").clone(true) ); 
				} else { 
					// other browser 일때 
					$("#attachedFile_1").val(""); 
				}
				$("#cbThTypeSel").append('<input type="text" id="cbThUrl" name="cbThUrl" value="${cmmBoardVO.cbThUrl}" class="in_base" style="width:400px; height:25px; margin-left:5px;" />');
				$(".alt_txt").html("YouTube 또는 Vimeo에서 제공하는 공유 주소를 입력해 주세요.");
			}else{
				$("#cbThTypeSel").append('<input type="file" id="attachedFile_1" name="attachedFile_1"/>');
				<c:if test="${!empty cmmBoardVO.cbThImgName}">
					$("#cbThTypeSel").append("<a href=\"#\" onclick=\"fn_filedownload(${cmmBoardVO.cbSeq}, 'CMMBOARD_THUMB'); return false;\"><c:out value='${cmmBoardVO.cbThImgName}'/></a>");
				</c:if>
				$(".alt_txt").html("JPG, GIF 형식으로 입력해 주세요.");
			}
		});
	});

	// 등록&수정
	function fn_update(){
		$("#cbContent").val(CKEDITOR.instances.cbContent.getData());
		
		if($.trim($("#cbTitle").val()) == ""){
			alert("제목을 입력해주세요.");
			return false;
		}else if(!$("input:radio[name='cbNoticeYn']").is(":checked")){
			alert("공지여부를 선택해주세요.");
			return false;
	<c:if test="${empty cmmBoardVO.cbSeq}">
		}else if($("#cbThType").val() == "IMG" && $("input:file:eq(0)").val() == ""){
			alert("파일을 첨부해주세요.");
			return false
	</c:if>
		}else if($("#cbThType").val() == "AVI" && $("#cbThUrl").val() == ""){
			alert("동영상 URL을 입력해주세요.");
			return false;
		}else if($.trim($("#cbContent").val()) == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		$("#cbType").val("0605");
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/cmmBoard/admCmmBoardUpdate.do'/>").submit();
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/cmmBoard/admCmmBoardList.do'/>").submit();
	}
	
	// 파일 다운로드
	function fn_filedownload(cbSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+cbSeq+"&type="+type;
	}
</script>
<body>
<form:form commandName="cmmBoardVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="cbSeq" />
<form:hidden path="cbType" />
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
				<c:import url="/EgovPageLink.do?link=adm/inc/incPageTitle">
					<c:param name="dept1" value="한디원뉴스"/>
					<c:param name="dept2" value="기업 · 지역연계수업 현황"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<!-- table -->
					<div class="tbl_top_area2 mt30">
						<div class="btn_r">
							* 는 필수 입력항목입니다.
						</div>
					</div>
					<table class="view_tbl_03 mb30" summary="기업 · 지역연계수업 현황">
						<caption>기업 · 지역연계수업 현황</caption>
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<tr class="first">
								<th scope="row">* 제목</th>
								<td>
									<input type="text" id="cbTitle" name="cbTitle" class="in_base" style="width: 80%;" value="<c:out value='${cmmBoardVO.cbTitle }' escapeXml='false'/>"/>
									<%--
										<form:input path="cbTitle" class="in_base" style="width:80%;"/>
									--%>
								</td>
							</tr>
							<tr>
								<th scope="row">* 공지여부</th>
								<td>
									<form:radiobutton path="cbNoticeYn" value="N" label="일반"/>&nbsp;&nbsp;&nbsp;
									<form:radiobutton path="cbNoticeYn" value="Y" label="공지"/>
								</td>
							</tr>
							<tr>
								<th scope="row">작성자</th>
								<td><c:out value="${sessionScope.adminSession.admName }"/></td>
							</tr>
							<tr>
								<th scope="row">* 썸네일 이미지</th>
								<td>
									<ul class="file_up">
										<li style="margin-right: 15px;">
											<form:select path="cbThType">
												<form:option value="IMG">이미지</form:option>
												<form:option value="AVI">동영상</form:option>
											</form:select>
										</li>
										<li id="cbThTypeSel"></li>
									</ul>
									<div class="alt_txt" style="padding-top:5px;">JPG, GIF 형식으로 입력해 주세요</div>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="editer">
									<form:textarea path="cbContent" style="ime-mode:active;"/>
									<script type="text/javascript">
										CKEDITOR.replace( 'cbContent', {
											filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
										});
									</script>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" onclick="fn_update(); return false;" class="b_type04">저장</a>
							<a href="#" onclick="fn_list(); return false;" class="b_type03">목록</a>
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
<!-- 목록 검색 조건 -->
<input type="hidden" id="menuType" name="menuType" value="${searchVO.menuType }"/>
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<!--// 목록 검색 조건 -->
</form:form>
</body>
</html>