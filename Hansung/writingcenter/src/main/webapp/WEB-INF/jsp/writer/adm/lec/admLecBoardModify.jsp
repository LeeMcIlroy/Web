<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">
	$(function() {
		// 파일업로드 조건 확인
		$(document).on("change", "input:file", function(){
			var fileSize = -1;
			if(this.files.length > 0){
				fileSize = this.files[0].size;
				fileCheck_adm(this.id, fileSize);
			}
		});
	});
	// 등록
	function fn_update(){
		$("#ntContent").val(CKEDITOR.instances.ntContent.getData());
		
		if($("#ntTitle").val() == ''){
			alert("제목을 입력해주세요.");
			$("#ntTitle").focus();
			return false;
		}else if(!$("input:radio[name='ntNoticeYn']").is(':checked')){
			alert("공지여부를 선택해주세요.");
			return false;
		}
		if(confirm(($("#ntSeq").val()==""? "등록":"수정") + "하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecBoardUpdate.do'/>").submit();
		}
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecBoardList.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="clsNoticeVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="ntSeq" />
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
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의실"/>
            	<jsp:param name="dept2" value="${smtrClsInfo.smtrTitle }"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<!-- table -->
				<div class="tbl_top_area2" style="height:10px;">
					<div class="btn_r">
						* 는 필수 입력항목입니다.
					</div>
				</div>
				<table class="view_tbl_03 mb30" summary="주제 출제하기 관리">
					<caption>주제 출제하기</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">* 제목</th>
							<td><form:input path="ntTitle" style="width:100%;" /></td>
						</tr>
						<tr>
							<th scope="row">공지여부</th>
							<td>
								<form:radiobutton path="ntNoticeYn" value="N" label="일반글"/>&nbsp;&nbsp;&nbsp;
								<form:radiobutton path="ntNoticeYn" value="Y" label="공지글"/>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="editer">
								<form:textarea path="ntContent" />
								<script type="text/javascript">
									CKEDITOR.replace( 'ntContent', {
										filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							</td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td>
								<c:if test="${empty clsNoticeVO.ntSeq }">
									<c:forEach begin="1" end="2" step="1" var="fileNo">
										<input type="file" id="attachedFile_${fileNo }" name="attachedFile_${fileNo }"/><br />
									</c:forEach>
                               	</c:if>
                               	<c:if test="${!empty clsNoticeVO.ntSeq }">
                               		<c:forEach items="${notiUpfileList }" var="notiUpfile" varStatus="status">
                               			<c:out value="${notiUpfile.upOriginFileName }"/>
                               			<input type="checkbox" id="fileDeleteChk${status.count }" name="fileDeleteChk" value="${notiUpfile.upSeq }"/>
                               			<label for="fileDeleteChk${status.count }">삭제</label>
                               			<c:set var="fileCnt" value="${status.count }" /><br />
                               		</c:forEach>
                               		<c:forEach begin="${fileCnt+1 }" end="2" var="fileNo">
										<input type="file" name="attachedFile_${fileNo }" id="attachedFile_${fileNo }"/><br/>
									</c:forEach>
                               	</c:if>
								<div class="alt_txt">
									*첨부파일은 용량 15M 이하의 hwp, doc, txt, ppt, bmp, jpg, gif, pdf 파일만 가능하며, 최대 2개까지 올릴 수 있습니다. <br/>
									*첨부파일의 용량이 클 경우 pdf로 변환하거나 나누어서 올리시길 바랍니다.
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<!--  버튼 -->
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_update(); return false;">
								<c:if test="${empty clsNotice.ntSeq }">저장</c:if>
								<c:if test="${!empty clsNotice.ntSeq }">수정</c:if>
							</a>
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
<input type="hidden" id="message" name="message" value="${message}" />
<!-- 목록페이지 조건 -->
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchClass" name="searchClass" value="${searchVO.searchClass }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>