<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">
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
	// 첨삭 등록&수정
	function fn_update(){
		if($("#hmwkContent2").val() == ''){
			alert("총평을 입력해주세요.");
			return false;
		}
		if(confirm(($("#hmwkUpdtDate").val()==""? "등록":"수정")+ "하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecHomeWorkUpdate.do'/>").submit();
		}
	}

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecHomeWorkList.do'/>").submit();
	}
	
	// 파일 다운로드
	function fn_download(type, upSeq){
		location.href = "<c:url value='/cmmn/file/downloadFile.do?type="+type+"&fileId="+upSeq+"'/>";
	}
	
</script>
<body>
<form:form commandName="homeworkVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="hmwkSeq" />
<form:hidden path="hmwkUpdtDate" />
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
				<table class="view_tbl_03 mt30 mb30" summary="C/L 분류 관리">
					<caption>C/L 분류</caption>
					<colgroup>
						<col width="14%" />
						<col width="20%" />
						<col width="13%" />
						<col width="20%" />
						<col width="13%" />
						<col width="20%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<c:choose>
								<c:when test="${!empty homeworkVO.hmwkNames && !empty homeworkVO.hmwkHakbuns && !empty homeworkVO.hmwkDepts }">
									<th scope="col">이름</th>
									<td><c:out value="${homeworkVO.hmwkNames }"/></td>
									<th scope="col">학과</th>
									<td><c:out value="${homeworkVO.hmwkDepts }"/></td>
									<th scope="col">학번</th>
									<td><c:out value="${homeworkVO.hmwkHakbuns }"/></td>
								</c:when>
								<c:otherwise>
									<th scope="col">이름</th>
									<td><c:out value="${homeworkVO.hmwkRegName }"/></td>
									<th scope="col">학과</th>
									<td><c:out value="${homeworkVO.hmwkRegDept }"/></td>
									<th scope="col">학번</th>
									<td><c:out value="${homeworkVO.hmwkRegId }"/></td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="5"><c:out value="${homeworkVO.hmwkContent }" escapeXml="false"/></td>
						</tr>
						<tr>
							<th scope="col">과제 파일</th>
							<td colspan="3">
								<c:forEach items="${hmwkFileList }" var="hmwkFile">
									<c:if test="${hmwkFile.upType eq 'BEFORE' }">
										<a href="#" onclick="fn_download('HOMEWORK', <c:out value='${hmwkFile.upSeq }'/>); return false;">
											<c:out value="${hmwkFile.upOriginFileName }"/>
										</a><br />
									</c:if>
								</c:forEach>
							</td>
							<th scope="col">제출일</th>
							<td><c:out value="${homeworkVO.hmwkRegDate }"/></td>
						</tr>
						<tr>
							<th scope="row">첨삭 지도 파일</th>
							<td colspan="5">
								<c:if test="${empty homeworkVO.hmwkUpdtDate }">
									<c:forEach begin="1" end="2" step="1" var="fileNo">
										<input type="file" id="attachedFile_${fileNo }" name="attachedFile_${fileNo }"/><br />
									</c:forEach>
								</c:if>
								<c:if test="${!empty homeworkVO.hmwkUpdtDate }">
									<c:set value="0" var="fileNo"/>
									<c:forEach items="${hmwkFileList }" var="hmwkFile" varStatus="status">
										<c:if test="${hmwkFile.upType eq 'AFTER' }">
											<c:set var="fileNo" value="${fileNo+1 }" />
											<c:out value="${hmwkFile.upOriginFileName }" />
											<input type="checkbox" id="fileDeleteChk${fileNo }" name="fileDeleteChk" value="${hmwkFile.upSeq }"/>
											<label for="fileDeleteChk${fileNo }">삭제</label>
											<br />
										</c:if>
									</c:forEach>
									<c:forEach begin="${fileNo+1 }" end="2" step="1" var="num">
										<input type="file" id="attachedFile_${num }" name="attachedFile_${num }"/><br />
									</c:forEach>
								</c:if>
								<div class="alt_txt">
									*첨부파일은 용량 15M 이하의 hwp, doc, txt, ppt, bmp, jpg, gif, pdf 파일만 가능하며, 최대 2개까지 올릴 수 있습니다. <br/>
									*첨부파일의 용량이 클 경우 pdf로 변환하거나 나누어서 올리시길 바랍니다.
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">총평</th>
							<td colspan="5">
								<form:textarea path="hmwkContent2" cols="5" rows="5" style="width:100%; height:100px;"/>
							</td>
						</tr>
						<tr>
							<th scope="row">첨삭상태</th>
							<td colspan="5">
								<c:if test="${homeworkVO.hmwkStatus eq 1 }">
									<a href="#" class="ta_s_btn03">제출</a>
								</c:if>
								<c:if test="${homeworkVO.hmwkStatus eq 2 }">
									<a href="#" class="ta_s_btn01">첨삭완료</a>
								</c:if>
								<c:if test="${homeworkVO.hmwkStatus eq 3 }">
									<a href="#" class="ta_s_btn01">첨삭완료</a>
									<a href="#" class="ta_s_btn02">첨삭확인완료</a>
								</c:if>
								<c:if test="${homeworkVO.hmwkStatus eq 4 }">
									<a href="#" class="ta_s_btn01">첨삭진행중</a>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<!--  버튼 -->
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_update(); return false;">
								<c:if test="${empty homeworkVO.hmwkUpdtDate }">저장</c:if>
								<c:if test="${!empty homeworkVO.hmwkUpdtDate }">수정</c:if>
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
<!-- 목록페이지 조건 -->
<input type="hidden" id="searchClass" name="searchClass" value="${searchVO.searchClass }"/>
<input type="hidden" id="searchSubject" name="searchSubject" value="${searchVO.searchSubject }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="pageIndex2" name="pageIndex2" value="${searchVO.pageIndex2 }"/>
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="searchWord2" name="searchWord2" value="${searchVO.searchWord2 }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>