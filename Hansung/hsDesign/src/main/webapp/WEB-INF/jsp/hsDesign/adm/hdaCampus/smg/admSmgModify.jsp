<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	// 등록&수정
	function fn_update(){
		
		
		if($.trim($("#cbTitle").val()) == ""){
			alert("제목을 입력해주세요.");
			return false;
		}
		/* 
		else if(!$("input:radio[name=cbNoticeYn]").is(":checked")){
			alert("공지여부를 선택해주세요.");
			return false;
		}
		
		// 파일 첨부여부 확인
		var fileFlag = false;
		for(var i = 0; i < $("input:file").length; i++){
			if($("input:file:eq("+i+")").val() != ""){
				fileFlag = true;
			}
		}
	<c:if test="${empty cmmBoardVO.cbSeq}">
		if(!fileFlag){
			alert("파일을 첨부해주세요.");
			return false;
		}
	</c:if>
	<c:if test="${!empty cmmBoardVO.cbSeq}">
		if(!fileFlag && ($("input:checkbox").length == $("input:checkbox:checked").length)){
			alert("파일을 첨부해주세요.");
			return false;
		}
	</c:if>
	 */
		$("#cbContent").val(CKEDITOR.instances.cbContent.getData());
		if($.trim($("#cbContent").val()) == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		$("#cbType").val("1001");
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/cmmBoard/admCmmBoardUpdate.do'/>").submit();
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/cmmBoard/admCmmBoardList.do'/>").submit();
	}
	
	// 파일 다운로드
	function fn_filedownload(cbupSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+cbupSeq+"&type="+type;
	}
</script>
<body>
<form:form commandName="cmmBoardVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="cbSeq" />
<form:hidden path="cbType" />
<form:hidden path="cbNoticeYn" value="Y" />
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
					<c:param name="dept1" value="캠퍼스생활"/>
					<c:param name="dept2" value="한디원신문고"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<!-- table -->
					<div class="tbl_top_area2 mt30">
						<div class="btn_r">
							* 는 필수 입력항목입니다.
						</div>
					</div>
					<table class="view_tbl_03 mb30" summary="학사Q&A">
						<caption>학사Q&amp;A</caption>
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<%-- 
							<tr class="first">
								<th scope="row">게시판 구분</th>
								<td>
									<form:select path="cbType" class="se_base w150">
										<form:option value="0201">입학상담</form:option>
										<form:option value="0202">편입상담</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th scope="row">공지여부</th>
								<td>
									<form:radiobutton path="cbNoticeYn" value="N" label="일반"/>&nbsp;&nbsp;&nbsp;
									<form:radiobutton path="cbNoticeYn" value="Y" label="공지"/>
								</td>
							</tr>
							 --%>
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
								<th scope="row">작성자</th>
								<td><c:out value="${sessionScope.adminSession.admName }"/></td>
							</tr>
							<tr>
								<th scope="row">파일첨부</th>
								<td>
									<c:choose>
										<c:when test="${empty cbUpfileListVO.egovList }">
											<input type="file" id="attachedFile_1" name="attachedFile_1"/>
											<input type="file" id="attachedFile_2" name="attachedFile_2"/><br />
											<input type="file" id="attachedFile_3" name="attachedFile_3"/>
											<input type="file" id="attachedFile_4" name="attachedFile_4"/><br />
											<input type="file" id="attachedFile_5" name="attachedFile_5"/>
										</c:when>
										<c:otherwise>
											<c:forEach items="${cbUpfileListVO.egovList }" var="cbUpfile" varStatus="status">
												<a href="#" onclick="fn_filedownload(<c:out value='${cbUpfile.cbupSeq }'/>, 'CMMBOARD'); return false;">
													<c:out value="${cbUpfile.cbupOriginFilename }"/>
												</a>&nbsp;&nbsp;&nbsp;
												<input type="checkbox" id="cbUpfileDelChk${status.count }" name="cbUpfileDelChk" value="<c:out value='${cbUpfile.cbupSeq }'/>"/>
												<label for="cbUpfileDelChk${status.count }">삭제</label>
												<br />
											</c:forEach>
											<c:forEach begin="1" end="${5 - cbUpfileListVO.totalRecordCount }" varStatus="status">
												<input type="file" id="attachedFile_${status.count }" name="attachedFile_${status.count }"/>
											</c:forEach>
										</c:otherwise>
									</c:choose>
									<%--
									<ul class="file_up">
										<li><a href="#" class="file">파일선택</a></li>
										<li>
											<p>선택된 파일 없음 <a href="#">X</a> <a href="#" class="file_add">파일추가</a></p>
										</li>
									</ul>
									--%>
									<div class="alt_txt">첨부파일은 최대 5M까지 첨부 가능합니다.</div>
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