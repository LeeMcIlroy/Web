<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<script type="text/javascript">

	$(function(){
		
		$("input:file").change(function() {
			var fileSize = -1;
			if(this.files){
				fileSize = this.files[0].size;
			}
			fileCheck_adm(this.id, fileSize);
			
		})
	});

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/floodCenter/noticeList.do'/>").submit();
	}
	
	// 저장
	function fn_modify(){
		$("#content").val(CKEDITOR.instances.content.getData());
		
		if($('#title').val() == ''){
			alert('제목을 입력해주세요.');
			return false;
		}else if($('#title').val().length > 50){
			alert('제목은 50자 이하로 작성해주세요.');
			return false;
		}else if(!$('input:radio[name=noticeYn]').is(':checked')){
			alert('공지여부를 선택해주세요.');
			return false;
		}else if($('#content').val() == ''){
			alert('내용을 입력해주세요.');
			return false;
		}
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/floodCenter/noticeSubmit.do'/>").submit();
	}
	
	// 첨부파일 삭제
	function fn_attachedFileDelete(attachFileId){
		if(confirm('정말로 삭제하시겠습니까?\n삭제한 데이터는 복구가 불가능합니다.')){
			/*
			$('#attachFileId').val(attachFileId);
			$('#frm').attr('method', 'post').attr('action', '<c:out value="${pageContext.request.contextPath}/usr/floodCenter/noticeUploadFileDelete.do"/>').submit();
			*/
			$.ajax({
				url: "<c:out value='${pageContext.request.contextPath }/usr/floodCenter/noticeUploadFileDelete.do'/>"
				, type: "post"
				, data: { attachFileId : attachFileId }
				, dataType:"json"
				, success: function(data){
					if(data.result == 0){
						alert("선택된 첨부파일이 삭제되었습니다.");
						var tags = '<input type="file" name="attachFile" id="attachFile" class="ch_file"/>';
						tags += '<span class="alt_txt">첨부파일은 최대 5MB까지 첨부 가능합니다.  (jpg, png, doc, hwp, pdf 파일만 첨부 됩니다)</span>';
						
						$('.mb15').append(tags);
						$('.file_list').empty();
					}else{
						alert("첨부파일을 삭제할 수 없습니다.");
						return false;
					}
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
</script>
<body class="sub_page">
<form:form commandName="noticeVO" id="frm" name="frm" enctype="multipart/form-data">
	<form:hidden path="noticeId"/>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body" >
		<!-- left menu - start -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incLeftnav"/>
		<!-- left menu - end -->
		<div class="main_content">
			<div class="content">
				<div class="m_title">
					<div class="title">공지사항</div>
					<div class="navi">
						<ul>
							<li>HOME</li>
							<li>수방매뉴얼</li>
							<li>공지사항</li>
						</ul>
					</div>
				</div>
				<div class="cont_box ptb_50">
					<div class="transform_table notice_type">
						<div class="tbl_write">
							<ul class="tbl_view_m">
								<li>* 제목</li>
								<li><form:input path="title" style="width:100%;"/></li>
							</ul>
							<ul class="tbl_view_m">
								<li>작성자</li>
								<li>
									<form:hidden path="regNm"/>
									<c:out value="${noticeVO.regNm }"/>
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li>공지여부</li>
								<li>
									<form:radiobutton path="noticeYn" value="Y" label=" 예"/> &nbsp;&nbsp;&nbsp;
									<form:radiobutton path="noticeYn" value="N" label=" 아니오" checked="true"/>
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li>* 파일첨부</li>
								<li>
									
									<c:if test="${empty fileVO}">
									<div class="mb15">
										<input type="file" name="attachFile" id="attachFile" class="ch_file"/>
										<%--
										<button class="ch_file">파일선택</button> 선택된파일 없음  <button class="add_file">파일추가</button> 
										--%>
										<span class="alt_txt">첨부파일은 최대 5MB까지 첨부 가능합니다.  (jpg, png, doc, hwp, pdf 파일만 첨부 됩니다)</span>
									</div>
									</c:if>
									<c:if test="${!empty noticeVO.noticeId && !empty fileVO}">
									<div class="mb15"></div>
									<div class="file_list">
										 <span style="text-decoration: none;">
										 	<c:out value="${fileVO.orgFileNm }"/>
										 	&nbsp;&nbsp;<a href="#" onclick="fn_attachedFileDelete(<c:out value='${fileVO.attachFileId }'/>); return false;">Χ</a>
										 	<%--
										 	&nbsp;&nbsp;<input type="checkbox" id="fileDelChk" name="fileDelChk" value="<c:out value="${fileVO.attachFileId }"/>"/>
											<label for="fileDelChk">삭제</label>
										 	--%>
										</span>
									</div>
									<br />
									</c:if>
									
								</li>
							</ul>
							<div class="tbl_editer">
								<form:textarea path="content" style="width:100%;height: 250px;margin-top: 5px;margin-bottom: 5px;ime-mode:active;"/>
								<script type="text/javascript">
									CKEDITOR.replace( 'content', {
										filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							</div>
						</div>
					</div>
					<div class="btn_box">
						<a href="#" class="btn_save" onclick="fn_modify(); return false;">저장</a>
						<a href="#" class="btn_list" onclick="fn_list(); return false;">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- footer -->
	</form:form>
</body>
</html>
