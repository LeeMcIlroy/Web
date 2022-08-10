<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		$("#brdContent").val(CKEDITOR.instances.brdContent.getData());
		
		if($("#brdTitle").val() == ''){
			alert("주제명을 입력해주세요.");
			$("#brdTitle").focus();
			return false;
		}else if(!$("input:radio[name='brdNoticeYn']").is(':checked')){
			alert("공개여부를 선택해주세요.");
			return false;
		}
		
		$("#frm").attr("method","post").attr("action", "<c:url value='/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoModify.do'/>").submit();
	}
	
	// 목록으로 이동
	function fn_goList(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoList.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="boardVO" id="frm" enctype="multipart/form-data">
<input type="hidden" id="searchType" name="searchType" value="WINFO"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<form:hidden path="brdSeq" />
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
					<jsp:param name="dept1" value="글쓰기 길잡이"/>
		            <jsp:param name="dept2" value="글쓰기 정보"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<div class="tbl_top_area2" style="height:10px;">
					<div class="btn_r">
						* 는 필수 입력항목입니다.
					</div>
				</div>
				<table class="view_tbl_03 mb30" summary="글쓰기정보">
					<caption>글쓰기정보</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">* 제목</th>
							<td>
								<form:input path="brdTitle" style="width:100%; ime-mode:active;" maxlength="60"/>
							</td>
						</tr>
						<tr>
							<th scope="row">공지 여부</th>
							<td>
								<form:radiobutton path="brdNoticeYn" value="Y" label="공지글"/>&nbsp;&nbsp;&nbsp;
								<c:if test="${empty boardVO.brdSeq }">  
									<form:radiobutton path="brdNoticeYn" value="N" label="일반글" checked="true" />
								</c:if>
								<c:if test="${!empty boardVO.brdSeq }">
									<form:radiobutton path="brdNoticeYn" value="N" label="일반글"  />
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="editer">
								<form:textarea path="brdContent" style="ime-mode:active;" />
								<script type="text/javascript">
									CKEDITOR.replace( 'brdContent', {
										filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							</td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td>
								<c:if test="${empty boardVO.brdSeq }">
									<ul class="file_up">
										<li>
											<input type="file" id="attachedFile_1" name="attachedFile_1" class="file"/> <br/>
											<input type="file" id="attachedFile_2" name="attachedFile_2" class="file"/>
											<%--
											<input type="file" id="attachedFile_3" name="attachedFile_3" class="file"/>
											--%>
										</li>
									</ul>
								</c:if>
                              	<c:if test="${!empty boardVO.brdSeq }">
                               		<c:forEach items="${boardUpfileList }" var="Upfile" varStatus="status">
                               			<c:out value="${Upfile.upOriginFileName }"/>
                               			<input type="checkbox" id="fileDeleteChk${status.count }" name="fileDeleteChk" value="${Upfile.upSeq }"/>
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
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_update(); return false;">
								<c:if test="${empty boardVO.brdSeq }">저장</c:if>
								<c:if test="${!empty boardVO.brdSeq }">수정</c:if>
							</a>
							<a href="#" class="b_type03" onclick="fn_goList(); return false;">목록</a>
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