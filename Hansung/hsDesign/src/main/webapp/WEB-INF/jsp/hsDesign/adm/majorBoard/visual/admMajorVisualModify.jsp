<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko" >
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>
	
	$(function(){
		
		$("input:file").change(function() {
			var fileSize = -1;
			if(this.files){
				fileSize = this.files[0].size;
			}
			fileCheck_adm(this.id, fileSize);
			
		})		
		
		// 초기 화면 셋팅
		if($("#mbthType").val() == "VIDEO"){
			$("#mbthTypeSel").append('<input type="text" id="mbthUrl" name="mbthUrl" value="${majorBoardVO.mbthUrl}" class="in_base" style="width:400px; height:25px; margin-left:5px;" />');
			$(".alt_txt").html("YouTube 또는 Vimeo에서 제공하는 공유 주소를 입력해 주세요.");
		}else{
			$("#mbthTypeSel").append('<input type="file" id="attachedFile_1" name="attachedFile_1"/>');
			//파일첨부 추가
			$("#mbthFile").append('<input type="file" id="attachedFile" name="attachedFile"/>');

		<c:if test="${!empty majorBoardVO.mbthImgName}">
			<c:if test="${majorBoardVO.mbOldYn eq 'Y'}">
				$("#mbthTypeSel").append("<a href=\"#\" onclick=\"fn_filedownload(${majorBoardVO.mbSeq}, 'old'); return false;\"><c:out value='${majorBoardVO.mbthImgName}'/></a>");
			</c:if>
			<c:if test="${majorBoardVO.mbOldYn ne 'Y'}">
				$("#mbthTypeSel").append("<a href=\"#\" onclick=\"fn_filedownload(${majorBoardVO.mbSeq}, 'major'); return false;\"><c:out value='${majorBoardVO.mbthImgName}'/></a>");
			</c:if>
		</c:if>
		//파일첨부 추가
		<c:if test="${!empty majorBoardVO.mbthFileName}">
		$("#mbthFile").append("<a onclick=\"fn_filedownload(${majorBoardVO.mbthFileSeq}, 'majorFile'); return false;\"><c:out value='${majorBoardVO.mbthFileName}'/></a>");
		</c:if>
			$(".alt_txt").html("JPG, GIF 형식으로 입력해 주세요. (최대 15MB)");
		}
		
		$(document).on("change", "#mbthType", function(){
			$("#mbthTypeSel").empty();
			if($(this).val() == "VIDEO"){
				var agent = navigator.userAgent.toLowerCase();
	
				if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
					// ie 일때 
					$("#attachedFile_1").replaceWith( $("#attachedFile_1").clone(true) ); 
				} else { 
					// other browser 일때 
					$("#attachedFile_1").val(""); 
				}
				$("#mbthTypeSel").append('<input type="text" id="mbthUrl" name="mbthUrl" value="${majorBoardVO.mbthUrl}" class="in_base" style="width:400px; height:25px; margin-left:5px;" />');
				$(".alt_txt").html("YouTube 또는 Vimeo에서 제공하는 공유 주소를 입력해 주세요.");
			}else{
				$("#mbthTypeSel").append('<input type="file" id="attachedFile_1" name="attachedFile_1"/>');
				<c:if test="${!empty majorBoardVO.mbthImgName}">
					<c:if test="${majorBoardVO.mbOldYn eq 'Y'}">
						$("#mbthTypeSel").append("<a href=\"#\" onclick=\"fn_filedownload(${majorBoardVO.mbSeq}, 'old'); return false;\"><c:out value='${majorBoardVO.mbthImgName}'/></a>");
					</c:if>
					<c:if test="${majorBoardVO.mbOldYn ne 'Y'}">
						$("#mbthTypeSel").append("<a href=\"#\" onclick=\"fn_filedownload(${majorBoardVO.mbSeq}, 'major'); return false;\"><c:out value='${majorBoardVO.mbthImgName}'/></a>");
					</c:if>
				</c:if>
				$(".alt_txt").html("JPG, GIF 형식으로 입력해 주세요. (최대 15MB)");
			}
		});
	});
	
	// 파일 다운로드
	function fn_filedownload(cbSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+cbSeq+"&type="+type;
	}
	
	//등록
	function fn_update(){
		$("#mbContent").val(CKEDITOR.instances.mbContent.getData());
		
		
		if($("#mbGubun1").val() == ''){
			alert("게시판 구분을 선택해주세요");
			return false;
		}else if($("#mbGubun2").val() == ''){
			alert("게시판 구분을 선택해주세요");
			return false;
		}else if(!$("input:radio[name='mbNoticeYn']").is(":checked")){
			alert("공지여부를 선택해주세요.");
			return false;
		}else if($("#mbTitle").val() == ''){
			alert("제목을 입력해주세요.");
			$("#mbTitle").focus();
			return false;
		}else if($("#mbContent").val() == ''){
			alert("내용을 입력해주세요.");
			return false;
	<c:if test="${empty majorBoardVO.mbSeq}">
		}else if($("#mbthType option:selected").val() == 'IMAGE' && $("#attachedFile_1").val() == ''){
			alert("썸네일을 등록해주세요");
			return false;
	</c:if>
		}else if($("#mbthType option:selected").val() == 'VIDEO' && $("#mbthUrl").val() == ''){
			alert("동영상URL을 등록해주세요");
			return false;			
		}
		 
		$("#frm").attr("method","post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/visual/admMajorVisualUpdate.do'/>").submit();
	}
	
	// 목록으로 이동
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/visual/admMajorVisualList.do'/>").submit();
	}
	
	
	function fn_change(){
		$("#mbGubun2 option").remove();
		$("#mbGubun2").append("<option value=''>선택</option>");
		var mmSeq = $("#mbGubun1 option:selected").val();
		$.ajax({
			url: "<c:url value='/qxerpynm/majorBoard/admMajorHeadList.do'/>"
			, type: "post"
			, data: "mmSeq="+mmSeq
			, dataType:"json"
			, success: function(data){
				listVO = data.listVO;
				console.log(listVO);
				
								
				$.each(listVO, function(i, result){
					var tags = '';
					tags += "<option value='"+result.bcSeq+"'>"+result.bcName+"</option>";
					$("#mbGubun2").append(tags);
				});
				
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
		
	}
	
	
</script>
<body>
<form:form commandName="majorBoardVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="mbSeq"/>
<form:hidden path="mbthSeq"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
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
				<jsp:include page="/WEB-INF/jsp/hsDesign/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="전공"/>
		            <jsp:param name="dept2" value="시각디자인"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<!-- table -->
				<div class="tbl_top_area2 mt30">
					<div class="btn_r">
						* 는 필수 입력항목입니다.
					</div>
				</div>
				<table class="view_tbl_03 mb30" summary="시각디자인">
					<caption>시각디자인</caption>
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">게시판 구분</th>
							<td>
								<form:select path="mbGubun1" class="se_base w150" onchange="fn_change(); return false;">
									<form:option value="">선택</form:option>
									<c:forEach var="list" items="${bCodeList }">
										<form:option value="${list.mmSeq }"><c:out value="${list.bcName }"/></form:option>
									</c:forEach>
								</form:select>
								<c:if test="${empty majorBoardVO.mbSeq }">
									<form:select path="mbGubun2" class="se_base w150">
										<form:option value="">선택</form:option>
									</form:select>
								</c:if>
								<c:if test="${!empty majorBoardVO.mbSeq }">
									<form:select path="mbGubun2" class="se_base w150">
										<form:option value="">선택</form:option>
										<c:forEach var="list" items="${listVO }">
											<form:option value="${list.bcSeq }"><c:out value="${list.bcName }"/></form:option>
										</c:forEach>
									</form:select>
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">* 공지여부</th>
							<td>
								<form:radiobutton path="mbNoticeYn" value="N" label="일반"/>&nbsp;&nbsp;&nbsp;
								<form:radiobutton path="mbNoticeYn" value="Y" label="공지"/>
							</td>
						</tr>
						<tr>
							<th scope="row">* 제목</th>
							<td>
								<input id="mbTitle" name="mbTitle" type="text" class="in_base" style="width:80%;" maxlength="50" value="<c:out value='${majorBoardVO.mbTitle }' escapeXml='false'/>"/>
							</td>
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td>
								<c:out value="${sessionScope.adminSession.admName }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">* 썸네일 이미지</th>
							<td>
								<ul class="file_up">
									<li style="margin-right: 15px;">
										<form:select path="mbthType">
											<form:option value="IMAGE">이미지</form:option>
											<form:option value="VIDEO">동영상</form:option>
										</form:select>
									</li>
									<li id="mbthTypeSel"></li>
								</ul>
								<div class="alt_txt" style="padding-top:5px;">JPG, GIF 형식으로 입력해 주세요 (최대 15MB)</div>
							</td>
						</tr>
						<tr>
								<th scope="row">파일첨부</th>
								<td>
									<ul class="file_up">
										<li style="margin-right: 15px;">

											<select name="fileType">
												<option value="File" selected="selected">&nbsp파&nbsp&nbsp일</option>
											</select>
											
										</li>
										<li id="mbthFile"></li>
									</ul>

									<div class="alt_txt1"></div>
								</td>
						</tr> 
						<tr>
							<td colspan="2" class="editer">
								<form:textarea path="mbContent" style="width:100%;height: 250px;margin-top: 5px;margin-bottom: 5px;ime-mode:active;"/>
								<script type="text/javascript">
									CKEDITOR.replace( 'mbContent', {
										filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath}/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#" class="b_type04" onclick="fn_update(); return false;">저장</a>
						<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
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
</form:form>
</body>
</html>