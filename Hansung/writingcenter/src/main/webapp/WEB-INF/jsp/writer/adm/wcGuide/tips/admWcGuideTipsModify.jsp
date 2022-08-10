<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

	// 등록&수정
	function fn_update(){
		
		if($("#tipTitle").val() == ''){
			alert("제목을 입력해주세요.");
			return false;
	<c:if test="${empty writingtipsVO.tipSeq }">
		}else if($("#titleImg").val() == ''){
			alert("대표이미지를 선택해주세요.");
			return false;
	</c:if>
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/tips/admWcGuideTipsUpdate.do'/>").submit();
	}

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/tips/admWcGuideTipsList.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="writingtipsVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="tipSeq" />
<form:hidden path="tipImgName" />
<form:hidden path="tipImgPath" />
<form:hidden path="tipImgThumbPath" />
<form:hidden path="tipFileName" />
<form:hidden path="tipFilePath" />
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
            	<jsp:param name="dept1" value="글쓰기 길잡이"/>
            	<jsp:param name="dept2" value="라이팅팁스"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<div class="tbl_top_area2" style="height:10px;">
					<div class="btn_r">
						* 는 필수 입력항목입니다.
					</div>
				</div>
				<table class="view_tbl_03 mb30" summary="라이팅팁스">
					<caption>라이팅팁스</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">*제목</th>
							<td><form:input path="tipTitle" style="width:100%;" /></td>
						</tr>
						<tr>
							<th scope="row">*대표이미지</th>
							<td>
							 	<c:if test="${!empty writingtipsVO.tipImgName }"><c:out value="${writingtipsVO.tipImgName }"/><br /></c:if>
							 	<input type="file" id="titleImg" name="titleImg"/>
								<div class="alt_txt">
									*첨부파일은 용량 5M 이하의  bmp, jpg, gif 이미지 파일만 가능합니다.
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">발행일</th>
							<td><form:input path="tipPublicDate" class="common_datepicker w100" readonly="true"/></td>
						</tr>
						<tr>
							<th scope="row">목차</th>
							<td>
								<form:textarea path="tipContent" style="width:100%; height:100px;"/>
							</td>
						</tr>
						<tr>
							<th scope="row">PDF 파일</th>
							<td>
						 		<c:if test="${!empty writingtipsVO.tipFileName }"><c:out value="${writingtipsVO.tipFileName }"/><br /></c:if>
						 		<input type="file" id="attachedFile_PDF" name="attachedFile_PDF"/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_update(); return false;">저장</a>
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
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<!-- //목록페이지 조건 -->
</form:form>
</body>
</html>