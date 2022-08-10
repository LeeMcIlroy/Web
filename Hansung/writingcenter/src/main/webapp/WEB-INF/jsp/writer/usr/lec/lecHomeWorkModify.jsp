<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
/*
	// 파일 선택
	function fn_select_file(num){
		$("#attachedFile_"+num).click();
	}
*/
	
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

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHomeWorkList.do'/>").submit();
	}
	
	// 등록&수정
	function fn_update(){
		
		if($("#hmwkContent").val() == ''){
			alert("내용을 입력해주세요.");
			return false;
		}
<c:if test="${empty homeworkVO.hmwkSeq}">
		var flag = false;
		for(var i = 0; i < $("input:file").length; i++){
			if($("input:file").eq(i).val() != ''){
				flag = true;
			}
		}
		if(!flag){
			alert("적어도 1개 과제파일을 선택해주세요.");
			return false;
		}
</c:if>

		if(confirm(($("#hmwkSeq").val()==""? "등록":"수정")+"하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHomeWorkUpdate.do'/>").submit();
		}
	}
	
<c:if test="${!empty homeworkVO.hmwkSeq}">	
	// 첨부파일 삭제
	var inputId;
	$(document).on("click", "input:image[id*=fileDeleteImg]", function(){
		if($("input:image[id*=fileDeleteImg]").length == 1){
			alert("첨부파일을 모두 삭제하실 수 없습니다.");
			return false;
		}
		
		inputId = this.id;
		if(confirm("정말로 삭제하시겠습니까?\n삭제한 첨부파일은 복구하실 수 없습니다.")){
			$.ajax({
				url: "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHomeWorkUpfileDetele.do'/>"
				, type: "post"
				, data: { 
							upSeq : this.value
							, hmwkSeq : $("#hmwkSeq").val()
						}
				, dataType:"json"
				, success: function(data){
					if(data.result == 0){
						alert("선택된 첨부파일이 삭제되었습니다.");
						var replId = inputId.replace("fileDeleteImg", "attachedFile_");
						var tags = '<p class="mb10"><input type="file" id="'+replId+'" name="'+replId+'" /></p>';
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
<form:form commandName="homeworkVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="hmwkSeq" />
<input type="hidden" id="startDate" name="startDate" value="<c:out value='${subjectVO.sbjtStartDate}'/>"/>
<input type="hidden" id="endDate" name="endDate" value="<c:out value='${subjectVO.sbjtEndDate}'/>"/>
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
				<dl class="view_dl mb20">
					<dt><c:out value="${subjectVO.sbjtTitle}"/></dt>
					<dd class="font12">
						제출기간 : <c:out value="${subjectVO.sbjtStartDate}"/>&nbsp;<c:out value="${subjectVO.sbjtStartTime }"/>~<c:out value="${subjectVO.sbjtEndDate}"/>&nbsp;<c:out value="${subjectVO.sbjtEndTime }"/>
						&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;등록일 : <c:out value="${subjectVO.regDate}"/>
					</dd>
					<dd class="view_dl_cont"><c:out value="${subjectVO.sbjtContent }" escapeXml="false"/></dd>
					<dd class="font12">
						첨부파일 :
						<c:forEach items="${sbjtUpfileList }" var="sbjtUpfile" varStatus="status">
							<a href="#"><c:out value="${sbjtUpfile.upOriginFileName }"/></a>
							<c:if test="${status.last == false}">
								&nbsp;|&nbsp;
							</c:if>
						</c:forEach>
					</dd>
				</dl>

				<div class="g_box03 mb50">
					<div class="g_s_box" >
						<p class="tx_l tit">
							※ 조별 과제인 경우 아래 입력란에 조별 인원 정보를 입력해 주세요. <br/>
							※ 조별 인원은 ","로 구분해 주세요</p>
						<ul class="n_input02">
							<li>이름</li>
							<li><form:input path="hmwkNames" /></li>
						</ul>
						<ul class="n_input02">
							<li>학과</li>
							<li><form:input path="hmwkDepts" /></li>
						</ul>
						<ul class="n_input02">
							<li>학번</li>
							<li><form:input path="hmwkHakbuns" /></li>
						</ul>
					</div>
				</div>
				<div class="mid_tit">내용</div>
				<div class="aw_box mb50">
					<div class="cont"><form:textarea path="hmwkContent" cols="5" rows="5" style="width:100%; height:100px;"/></div>
				</div>
				<div class="mid_tit">과제 파일</div>
				<div class="aw_box mb50">
					<div class="cont">
						<c:if test="${empty homeworkVO.hmwkSeq }">
						<%--
							<c:forEach begin="1" end="3" var="fileNo">
						--%>
							<c:forEach begin="1" end="2" var="fileNo">
								<p>
									<input type="file" id="attachedFile_${fileNo }" name="attachedFile_${fileNo }"/>
								</p>
							</c:forEach>
						</c:if>
						<c:if test="${!empty homeworkVO.hmwkSeq }">
							<c:forEach items="${hmwkFileList }" var="hmwkFile" varStatus="status">
								<p class="mb10">
									<c:out value="${hmwkFile.upOriginFileName }"/>
									<input type="image" src="${pageContext.request.contextPath }/assets/usr/img/btn_del_bg.png" id="fileDeleteImg${status.count }" value="${hmwkFile.upSeq }" onclick="return false;" style="margin-left: 5px;"/>
								</p>
								<c:set var="fileCnt" value="${status.count }" />
							</c:forEach>
							<%--
							<c:forEach begin="${fileCnt+1 }" end="3" var="fileNo">
							--%>
							<c:forEach begin="${fileCnt+1 }" end="2" var="fileNo">
								<p class="mb10">
									<input type="file" id="attachedFile_${fileNo }" name="attachedFile_${fileNo }"/>
								</p>
							</c:forEach>
						</c:if>
					</div>
					<div class="g_box alt_txt tx_l pa_all2010">
						<p class="mb10">*첨부파일은 용량 15M 이하의 hwp, doc, txt, ppt, bmp, jpg, gif, pdf 파일만 가능하며, 최대 2개까지 올릴 수 있습니다.</p>
						<p>*첨부파일의 용량이 클 경우 pdf로 변환하거나 나누어서 올리시길 바랍니다.</p>
					</div>
				</div>
				<!-- 하단 영역 -->
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
						<c:if test="${empty homeworkVO.hmwkSeq }">
							<a href="#" class="btn_save" onclick="fn_update(); return false;">저장</a>
						</c:if>
						<c:if test="${!empty homeworkVO.hmwkSeq && homeworkVO.hmwkStatus eq '1' }">
							<a href="#" class="btn_save" onclick="fn_update(); return false;">수정</a>
						</c:if>
							<a href="#" class="btn_list" onclick="fn_list(); return false;">목록</a>
						</div>
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
<input type="hidden" id="message" name="message" value="${message }"/>
<!-- 목록페이지 조건 -->
<input type="hidden" id="searchClass" name="searchClass" value="${searchVO.searchClass }"/>
<input type="hidden" id="searchSubject" name="searchSubject" value="${searchVO.searchSubject }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>