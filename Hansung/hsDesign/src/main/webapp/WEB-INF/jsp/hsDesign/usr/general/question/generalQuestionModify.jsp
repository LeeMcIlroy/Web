<!-- 200407추가 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	
	// 목록
	function fn_list(pageNo){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/general/question/generalQuestionList.do'/>").submit();
	}
	
	// 등록
	function fn_update(){
		if($("#cbTitle").val() == ''){
			alert("제목을 입력해주세요.");
			$("#cbTitle").focus();
			return false;
		}else if($("#cbPassword").val() == '' && $("#cbSeq").val() == ''){
			alert("비밀번호를 입력해주세요.");
			$("#cbPassword").focus();
			return false;
		}else if($("#regName").val() == '' && $("#cbSeq").val() == ''){
			alert("작성자를 입력해주세요.");
			$("#regName").focus();
			return false;
		}else if($("#cbContent").val() == ''){
			alert("내용을 입력해주세요.");
			$("#cbContent").focus();
			return false;
		}
		
		 
		$("#frm").attr("method","post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/general/question/generalQuestionUpdate.do'/>").submit();
	}

	// 파일 다운로드
	function fn_filedownload(cbupSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+cbupSeq+"&type="+type;
	}
</script>
<body>
<form:form commandName="cmmBoardVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="cbSeq"/>



	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<!-- container -->
	<div class="main_content" id="content">
		<div class="width_box">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
			<!--// lnb -->
			<!-- content -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="비학위과정"/>
		            <jsp:param name="dept2" value="개설문의"/>
	           	</jsp:include>
	           	<div class="transform_table notice_type">
					<div class="tbl_write">
						<ul class="tbl_view_m">
							<li class="txt_left">* 제목</li>
							<li><input type="text" id="cbTitle" name="cbTitle" style="width:100%;" maxlength="50" value="<c:out value='${cmmBoardVO.cbTitle }' escapeXml='false'/>"/></li>
						</ul>
						<c:if test="${empty cmmBoardVO.cbSeq }"> <!--게시글 등록 게시판의 번호가 비어있다면 --> 
							<ul class="tbl_view_m">
								<li class="txt_left">* 비밀번호</li>
								<li><input type="password" name="cbPassword" maxlength="19" /></li>
							</ul>
								<ul class="tbl_view_m">
									<li class="txt_left">* 작성자</li>
									<li><input type="text" name="regName" maxlength="20"/></li>
								</ul>
								<ul>
									<li class="txt_left">* 파일첨부</li>
									<li>
										<c:choose>
											<c:when test="${empty cbUpfileListVO.egovList }">
												<input type="file" id="attachedFile_1" name="attachedFile_1"/>
												<!-- <input type="file" id="attachedFile_2" name="attachedFile_2"/><br />
												<input type="file" id="attachedFile_3" name="attachedFile_3"/>
												<input type="file" id="attachedFile_4" name="attachedFile_4"/><br />
												<input type="file" id="attachedFile_5" name="attachedFile_5"/> -->
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
												<c:forEach begin="1" end="${2 - cbUpfileListVO.totalRecordCount }" varStatus="status">
													<input type="file" id="attachedFile_${status.count }" name="attachedFile_${status.count }"/>
												</c:forEach>
											</c:otherwise>
										</c:choose>
										<div class="alt_txt">첨부파일은 최대 5M까지 첨부 가능합니다.</div>
									</li>
								</ul>
						</c:if>
						<c:if test="${!empty cmmBoardVO.cbSeq }"> <!--게시글 수정 게시판의 번호가 기존에 있다면  -->
							<ul class="tbl_view_m">
								<li class="txt_left">* 작성자</li>
								<li><c:out value="${cmmBoardVO.regName }"/></li>
							</ul>
							<ul>
								<li class="txt_left">* 파일첨부</li>
								<li>
									<c:choose>
										<c:when test="${empty cbUpfileListVO.egovList }">
											<input type="file" id="attachedFile_1" name="attachedFile_1"/>
											<!-- <input type="file" id="attachedFile_2" name="attachedFile_2"/><br />
											<input type="file" id="attachedFile_3" name="attachedFile_3"/>
											<input type="file" id="attachedFile_4" name="attachedFile_4"/><br />
											<input type="file" id="attachedFile_5" name="attachedFile_5"/> -->
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
											<c:forEach begin="1" end="${2 - cbUpfileListVO.totalRecordCount }" varStatus="status">
												<input type="file" id="attachedFile_${status.count }" name="attachedFile_${status.count }"/>
											</c:forEach>
										</c:otherwise>
									</c:choose>
									<div class="alt_txt">첨부파일은 최대 5M까지 첨부 가능합니다.</div>
								</li>
								</ul>
							<input type="hidden" name="regName" value="${cmmBoardVO.regName }" />
                            <input type="hidden" name="cbPassword" value="${cmmBoardVO.cbPassword }" />						
                        </c:if> 
						<textarea id="cbContent" name="cbContent" style="width:100%;height: 250px;margin-top: 5px;margin-bottom: 5px;ime-mode:active;"><c:out value='${cmmBoardVO.cbContent }' escapeXml="false"/></textarea>
						<%--
						<form:textarea path="cbContent" style="width:100%;height: 250px;margin-top: 5px;margin-bottom: 5px;ime-mode:active;"/>
						--%>
					</div>
				</div>
				<div class="btn_box">
					<a href="#" class="btn_go_save" onclick="fn_update(); return false;">저장</a>
					<a href="#" class="btn_go_list" onclick="fn_list(); return false;">목록</a>
				</div>
				<!-- rolling banner -->
				<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
				<!-- //rolling banner -->
				<!-- //content -->
			</div>			
			<!--// content -->
		</div>
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
</form:form>
</body>
</html>