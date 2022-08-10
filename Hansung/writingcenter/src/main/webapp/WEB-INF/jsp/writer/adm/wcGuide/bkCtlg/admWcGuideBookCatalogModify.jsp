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
		
		if($("#searchType").val() != ''){
			if($("#searchType").val() == 'NORMAL'){
				$("#ctlType").val('NORMAL');
			}else if($("#searchType").val() == 'RECOMMAND'){
				$("#ctlType").val('RECOMMAND');
			}
		}
	});

	// 등록&수정
	function fn_update(){
		$("#ctlContent").val(CKEDITOR.instances.ctlContent.getData());
		
		if($("#ctlTitle").val() == ''){
			alert("제목을 입력해주세요.");
			return false;
		}else if($("#ctlWriter").val() == ''){
			alert("지은이를 입력해주세요.");
			return false;
		}else if($("#ctlPublisher").val() == ''){
			alert("출판사를 입력해주세요.");
			return false;
		}else if($("#ctlContent").val() == ''){
			alert("내용을 입력해주세요.");
			return false;
	<c:if test="${empty bookcatalogVO.ctlSeq}">
		}else if($("#titleImg").val() == ''){
			alert("첨부파일을 선택해주세요.");
			return false;
	</c:if>
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogUpdate.do'/>").submit();
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogList.do'/>").submit();
	}
</script>
<body>
<form:form commandName="bookcatalogVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="ctlSeq" />
<form:hidden path="ctlImgName" />
<form:hidden path="ctlImgPath" />
<form:hidden path="ctlImgThumbPath" />
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
            	<jsp:param name="dept2" value="도서목록"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<div class="tbl_top_area2" style="height:10px;">
					<div class="btn_r">
						* 는 필수 입력항목입니다.
					</div>
				</div>
				<table class="view_tbl_03 mb30" summary="우수과제">
					<caption>우수과제</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">* 게시판 구분</th>
							<td>
								<form:select path="ctlType" class="se_base">
									<form:option value="NORMAL">서가목록</form:option>
									<form:option value="RECOMMAND">추천도서</form:option>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">* 대표이미지</th>
							<td>
						 		<input type="file" id="titleImg" name="titleImg"/>
						 		<c:if test="${!empty bookcatalogVO.ctlImgName }"><c:out value="${bookcatalogVO.ctlImgName }"/></c:if>
								<div class="alt_txt">
									*대표이미지는 170X239 사이즈이며, 용량 5M 이하의 bmp, jpg, gif 이미지 파일만 가능합니다.
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">* 책분류</th>
							<td>
								<form:select path="ctlBkType" class="se_base">
									<form:option value="KOR">한글책</form:option>
									<form:option value="ENG">영문책</form:option>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">* 제목</th>
							<td>
								<form:input path="ctlTitle" style="width:100%" />
							</td>
						</tr>
						<tr class="first">
							<th scope="row">* 지은이</th>
							<td>
								<form:input path="ctlWriter" style="width:100%" />
							</td>
						</tr>
						<tr class="first">
							<th scope="row">* 출판사</th>
							<td>
								<form:input path="ctlPublisher" style="width:100%" />
							</td>
						</tr>
						<tr>
							<td colspan="2" class="editer">
								<form:textarea path="ctlContent" />
								<script type="text/javascript">
									CKEDITOR.replace( 'ctlContent', {
										filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_update(); return false;">
								<c:if test="${empty bookcatalogVO.ctlSeq }">저장</c:if>
								<c:if test="${!empty bookcatalogVO.ctlSeq }">수정</c:if>
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
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>