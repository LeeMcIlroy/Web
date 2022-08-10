<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring"	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	$(function(){
		// datepicker input click
		$(document).on("click", ".datepicker", function(){
			$(this).next().click();
		});
	});

	// 등록&수정
	function fn_update(){
		
		var regExp = /^[0-9]*$/;
		
		if($.trim($("#geName").val()) == ""){
			alert("과정명을 입력해주세요.");
			return false;
		}else if($("#geType").val() == ""){
			alert("수강신청을 선택해주세요.");
			return false;
		}
		/* 
		else if($("#geAplyBegin").val() == "" || $("#geAplyEnd").val() == ""){
			alert("신청기간을 선택해주세요.");
			return false;
		}
		 
		else if($("#geLectureBegin").val() == "" || $("#geLectureEnd").val() == ""){
			alert("수강기간을 선택해주세요.");
			return false;
		}
		 
		 */
		else if($("#geExpense").val() == ""){
			alert("수강료를 입력해주세요.");
			return false;
		}
		else if(!regExp.test($("#geExpense").val())){
			alert("수강료는 숫자만 입력가능합니다.");
			return false;
		}
		/* 
		// 파일 첨부여부 확인
		var fileFlag = false;
		for(var i = 0; i < $("input:file").length; i++){
			if($("input:file:eq("+i+")").val() != ""){
				fileFlag = true;
			}
		}
	<c:if test="${empty generalEduVO.geSeq}">
		if(!fileFlag){
			alert("파일을 첨부해주세요.");
			return false;
		}
	</c:if>
	<c:if test="${!empty generalEduVO.geSeq}">
		if(!fileFlag && ($("input:checkbox").length == $("input:checkbox:checked").length)){
			alert("파일을 첨부해주세요.");
			return false;
		}
	</c:if>
	 */
		$("#geContent").val(CKEDITOR.instances.geContent.getData());
		if($.trim($("#geContent").val()) == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/general/info/admGeneralInfoUpdate.do'/>").submit();
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/general/info/admGeneralInfoList.do'/>").submit();
	}

	// 파일 다운로드
	function fn_filedownload(geupSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+geupSeq+"&type="+type;
	}

</script>
<body>
<form:form commandName="generalEduVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="geSeq" />
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
					<c:param name="dept1" value="교양과정"/>
					<c:param name="dept2" value="교양과정안내"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<!-- table -->
					<div class="tbl_top_area2 mt30">
						<div class="btn_r">
							* 는 필수 입력항목입니다.
						</div>
					</div>
					<table class="view_tbl_03 mb30" summary="교양과정안내">
						<caption>교양과정안내</caption>
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<tr class="first">
								<th scope="row">* 과정명</th>
								<td>
									<%-- <form:input path="geName" class="in_base" style="width:80%;" /> --%>
									<input type="text" id="geName" name="geName" value="<c:out value='${generalEduVO.geName }' escapeXml='false'/>"/>
								</td>
							</tr>
							<tr>
								<th scope="row">* 수강신청</th>
								<td>
									<form:select path="geType" class="se_base w100">
										<form:option value="aply">신청가능</form:option>
										<form:option value="ready">준비중</form:option>
										<form:option value="finish">신청마감</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th scope="row">연도</th>
								<td>
									<form:select path="geYear" class="se_base w100">
									    <form:option value="2022">2022</form:option>
									    <form:option value="2021">2021</form:option>
										<form:option value="2020">2020</form:option>
										<form:option value="2019">2019</form:option>
										<form:option value="2018">2018</form:option>
										<form:option value="2017">2017</form:option>
										<form:option value="2016">2016</form:option>
										<form:option value="2015">2015</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th scope="row">학기</th>
								<td>
									<form:select path="geSemester" class="se_base w100">
										<form:option value="1학기">1학기</form:option>
										<form:option value="하계학기">하계학기</form:option>
										<form:option value="2학기">2학기</form:option>
										<form:option value="동계학기">동계학기</form:option>
									</form:select>
								</td>
							</tr>
							<%-- 
							<tr>
								<th scope="row">* 신청기간</th>
								<td>
									<form:input path="geAplyBegin" class="datepicker w100" readonly="true"/>&nbsp;~&nbsp;<form:input path="geAplyEnd" class="datepicker w100" readonly="true"/>
								</td>
							</tr>
							 --%>
							<tr>
								<th scope="row">교육기간</th>
								<td>
									<form:input path="geLectureBegin" class="datepicker w100" readonly="true"/>
									&nbsp;~&nbsp;
									<form:input path="geLectureEnd" class="datepicker w100" readonly="true"/>
								</td>
							</tr>
							<tr>
								<th scope="row">수업시간</th>
								<td>
									<input type="text" id="geClasstime" name="geClasstime" value="<c:out value='${generalEduVO.geClasstime }' escapeXml='false'/>" />
								</td>
							</tr>
							<tr>
								<th scope="row">교강사</th>
								<td>
									<input type="text" id="geTeacher" name="geTeacher" value="<c:out value='${generalEduVO.geTeacher }' escapeXml='false'/>" />
								</td>
							</tr>
							<tr>
								<th scope="row">강의실</th>
								<td>
									<input type="text" id="geClassrome" name="geClassrome" value="<c:out value='${generalEduVO.geClassrome }' escapeXml='false'/>" />
								</td>
							</tr>
							<%-- 
							<tr>
								<th scope="row">* 수강시간</th>
								<td>
									<form:select path="geLectureBeginTm1">
										<c:forEach begin="0" end="23" varStatus="status">
											<c:set value="0${status.index }" var="bTm1"/>
											<c:if test="${fn:length(bTm1) eq 3 }">
												<c:set value="${status.index }" var="bTm1"/>
											</c:if>
											<form:option value="${bTm1 }"/>
										</c:forEach>
									</form:select>
									:
									<form:select path="geLectureBeginTm2">
										<c:forEach begin="0" end="55" step="5" varStatus="status">
											<c:set value="0${status.index }" var="bTm2"/>
											<c:if test="${fn:length(bTm2) eq 3 }">
												<c:set value="${status.index }" var="bTm2"/>
											</c:if>
											<form:option value="${bTm2 }"/>
										</c:forEach>
									</form:select>
									&nbsp;~&nbsp;
									<form:select path="geLectureEndTm1">
										<c:forEach begin="0" end="23" varStatus="status">
											<c:set value="0${status.index }" var="eTm1"/>
											<c:if test="${fn:length(eTm1) eq 3 }">
												<c:set value="${status.index }" var="eTm1"/>
											</c:if>
											<form:option value="${eTm1 }"/>
										</c:forEach>
									</form:select>
									:
									<form:select path="geLectureEndTm2">
										<c:forEach begin="0" end="55" step="5" varStatus="status">
											<c:set value="0${status.index }" var="eTm2"/>
											<c:if test="${fn:length(eTm2) eq 3 }">
												<c:set value="${status.index }" var="eTm2"/>
											</c:if>
											<form:option value="${eTm2 }"/>
										</c:forEach>
									</form:select>
								</td>
							</tr>
							 --%>
							<tr>
								<th scope="row">* 수강료</th>
								<td>
									<form:input path="geExpense" class="in_base w150" />
								</td>
							</tr>
							<tr>
								<th scope="row">파일첨부</th>
								<td><c:choose>
										<c:when test="${empty geUpfileListVO.egovList }">
											<c:forEach begin="1" end="1" varStatus="status">
												<input type="file" id="attachedFile_${status.count }" name="attachedFile_${status.count }"/>
												<c:if test="${status.count%2 eq 0 }"><br/></c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach items="${geUpfileListVO.egovList }" var="geUpfile" varStatus="status">
												<a href="#" onclick="fn_filedownload(<c:out value='${geUpfile.geupSeq }'/>, 'GENERALEDU'); return false;">
													<c:out value="${geUpfile.geupOriginFilename }"/>
												</a>&nbsp;&nbsp;&nbsp;
												<input type="checkbox" id="geUpfileDelChk${status.count }" name="geUpfileDelChk" value="<c:out value='${geUpfile.geupSeq }'/>"/>
												<label for="geUpfileDelChk${status.count }">삭제</label>
												<br />
											</c:forEach>
											<c:forEach begin="1" end="${2 - geUpfileListVO.totalRecordCount }" varStatus="status">
												<input type="file" id="attachedFile_${status.count }" name="attachedFile_${status.count }"/>
											</c:forEach>
										</c:otherwise>
									</c:choose>
									<%-- <c:choose>
										<c:when test="${empty geUpfileListVO.egovList }">
											<c:forEach begin="1" end="5" varStatus="status">
												<input type="file" id="attachedFile_${status.count }" name="attachedFile_${status.count }"/>
												<c:if test="${status.count%2 eq 0 }"><br/></c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach items="${geUpfileListVO.egovList }" var="geUpfile" varStatus="status">
												<a href="#" onclick="fn_filedownload(<c:out value='${geUpfile.geupSeq }'/>, 'GENERALEDU'); return false;">
													<c:out value="${geUpfile.geupOriginFilename }"/>
												</a>&nbsp;&nbsp;&nbsp;
												<input type="checkbox" id="geUpfileDelChk${status.count }" name="geUpfileDelChk" value="<c:out value='${geUpfile.geupSeq }'/>"/>
												<label for="geUpfileDelChk${status.count }">삭제</label>
												<br />
											</c:forEach>
											<c:forEach begin="1" end="${5 - geUpfileListVO.totalRecordCount }" varStatus="status">
												<input type="file" id="attachedFile_${status.count }" name="attachedFile_${status.count }"/>
											</c:forEach>
										</c:otherwise>
									</c:choose>
									<div class="alt_txt" style="margin-top: 5px;">첨부파일은 최대 5개까지 첨부 가능합니다.</div> --%>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="editer">
									<form:textarea path="geContent" style="ime-mode:active;"/>
									<script type="text/javascript">
										CKEDITOR.replace( 'geContent', {
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
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<!--// 목록 검색 조건 -->
</form:form>
</body>
</html>