<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javaScript">
	
	$(function() {
		// 파일업로드 조건 확인
		$(document).on("change", "input:file", function(){
			var fileSize = -1;
			if(this.files.length > 0){
				fileSize = this.files[0].size;
				fileCheck(this.id, fileSize);
			}
		});
	});
	
	// 등록
	function fn_update(){
	<c:if test="${sessionScope.userSession.memType eq 'PROF'}">
		$("#ntContent").val(CKEDITOR.instances.ntContent.getData());
	</c:if>
		if($("#ntTitle").val() == ''){
			alert("제목을 입력해주세요.");
			$("#ntTitle").focus();
			return false;
		}
		
		if(confirm(($("#ntSeq").val()==""? "등록":"수정") + "하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardUpdate.do'/>").submit();
		}
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardList.do'/>").submit();
	}
<c:if test="${!empty clsNoticeVO.ntSeq}">	
	// 첨부파일 삭제
	var inputId;
	$(document).on("click", "input:image[id*=fileDeleteImg]", function(){
		inputId = this.id;
		if(confirm("정말로 삭제하시겠습니까?\n삭제한 첨부파일은 복구하실 수 없습니다.")){
			$.ajax({
				url: "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardUpfileDetele.do'/>"
				, type: "post"
				, data: { 
							upSeq : this.value
							, ntSeq : $("#ntSeq").val()
						}
				, dataType:"json"
				, success: function(data){
					if(data.result == 0){
						alert("선택된 첨부파일이 삭제되었습니다.");
						var replId = inputId.replace("fileDeleteImg", "attachedFile_");
						var tags = '<p class="mb10"><input type="file" id="'+replId+'" name="'+replId+'" style="height:100%;"/></p>';
						$("#"+inputId).parent().after(tags);
						$("#"+inputId).parent().remove();
					}else{
						alert("첨부파일을 삭제할 수 없습니다.");
						return false;
					}
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	});
</c:if>
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
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<hr />
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의실"/>
            	<jsp:param name="dept2" value="${smtrClsInfo.smtrTitle }"/>
            </jsp:include>
			<div class="cont_box">
				<div class="btm_area mb50">
					<div class="ta_caption">
						* 는 필수 입력항목입니다.
					</div>
					<table class="view_type01 mb30" summary="상세보기">
						<caption>상세보기</caption>
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr class="first">
								<th scope="row">* 제목</th>
								<td><form:input path="ntTitle" style="width:100%" /></td>
							</tr>
							<tr>
								<td colspan="2" class="editer" style="padding: 5px;">
									<c:choose>
										<c:when test="${sessionScope.userSession.memType eq 'PROF' }">
											<form:textarea path="ntContent" />
											<script type="text/javascript">
												CKEDITOR.replace( 'ntContent', {
													filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
												});
											</script>
										</c:when>
										<c:when test="${sessionScope.userSession.memType eq 'STUD' }">
											<form:textarea path="ntContent" cols="5" rows="5" style="width:100%; height:150px;"/>
										</c:when>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th scope="row">첨부파일</th>
								<td>
									<div class="cont mt10">
										<c:if test="${empty clsNoticeVO.ntSeq }">
											<c:forEach begin="1" end="2" step="1" var="fileNo">
												<p class="mb10">
													<input type="file" id="attachedFile_${fileNo }" name="attachedFile_${fileNo }"/>
												</p>
											</c:forEach>
		                               	</c:if>
		                               	<c:if test="${!empty clsNoticeVO.ntSeq }">
		                               		<c:forEach items="${notiUpfileList }" var="notiUpfile" varStatus="status">
		                               		<%--
		                               			<input type="checkbox" id="fileDeleteChk${status.count }" name="fileDeleteChk" value="${notiUpfile.upSeq }"/>
		                               			<label for="fileDeleteChk${status.count }"><c:out value="${notiUpfile.upOriginFileName }"/></label>
		                               		--%>
		                               			<p class="mb10">
			                               			<c:out value="${notiUpfile.upOriginFileName }"/>
			                               			<input type="image" src="${pageContext.request.contextPath }/assets/usr/img/btn_del_bg.png" id="fileDeleteImg${status.count }" value="${notiUpfile.upSeq }" onclick="return false;" class="ml5" style="height: 100%;"/>
		                               			</p>
		                               			<c:set var="fileCnt" value="${status.count }" />
		                               		</c:forEach>
		                               		<c:forEach begin="${fileCnt+1 }" end="2" var="fileNo">
			                               		<p class="mb10">
													<input type="file" name="attachedFile_${fileNo }" id="attachedFile_${fileNo }"/>
			                               		</p>
											</c:forEach>
		                               	</c:if>
									</div>
									<div class="alt_txt tx_l pa_all2010 mb10">
										<p class="mb10">*첨부파일은 용량 15M 이하의 hwp, doc, txt, ppt, bmp, jpg, gif, pdf 파일만 가능하며, 최대 2개까지 올릴 수 있습니다.</p>
										<p>*첨부파일의 용량이 클 경우 pdf로 변환하거나 나누어서 올리시길 바랍니다.</p>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#" class="btn_save" onclick="fn_update(); return false;">
							<c:if test="${empty clsNoticeVO.ntSeq }">저장</c:if>
							<c:if test="${!empty clsNoticeVO.ntSeq }">수정</c:if>
						</a>
						<a href="#" class="btn_list" onclick="fn_list(); return false;">목록</a>
					</div>
				</div>
				<!-- 하단 영역 -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
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