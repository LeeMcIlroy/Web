<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>한성대학교 디자인아트 교육원</title>
<!-- header -->
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">  
	function delChk(i){
		$("#bannerDelChk"+i).prop('checked', true);
	}
</script>
<!--// header -->
</head>
<body>
<div class="wrap">
	<!-- topnav -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!-- topnav -->
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
			<div class="title_area">
				<h3>배너관리</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 사이트관리 &gt; 배너관리 &nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
			<div class="cont_box">
			<!-- content -->
			<form:form commandName="bannerVO" id="frm" name="frm" enctype="multipart/form-data">
			<form:hidden path="banSeq"/>
			<div class="tbl_top_area2 mt30">
				<div class="btn_r">
					* 는 필수 입력항목입니다.
				</div>
			</div>
				<!-- table -->
				<table class="view_tbl_03 mb30" summary="배너관리">
					<caption>배너관리</caption>
					<colgroup>
							<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">배너구분</th>
							<td colspan="3">
								<c:if test="${empty bannerVO.banSeq }">
								<form:select path="banType" class="se_base w150" onchange="fn_bannerType(); return false;">
									<form:option value="M">메인배너</form:option>
									<form:option value="S">서브배너</form:option>
									<form:option value="L">중간배너</form:option>
									<form:option value="U">영상배너</form:option>
									<form:option value="R">롤링배너</form:option>
									<form:option value="F">좌측배너</form:option>
								</form:select>
								</c:if>
								<c:if test="${!empty bannerVO.banSeq }">
									<c:if test="${bannerVO.banType == 'M' }">메인배너</c:if>
									<c:if test="${bannerVO.banType == 'S' }">서브배너</c:if>
									<c:if test="${bannerVO.banType == 'L' }">중간배너</c:if>
									<c:if test="${bannerVO.banType == 'U' }">영상배너</c:if>
									<c:if test="${bannerVO.banType == 'R' }">롤링배너</c:if>
									<c:if test="${bannerVO.banType == 'F' }">좌측배너</c:if>
									<form:hidden path="banType" />
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">* 배너명</th>
							<%-- <td><form:input path="banName" class="in_base" style="width:80%;" /></td> --%>
							<td>
								<form:textarea path="banName" style="width:80%;"  />
							</td>
						</tr>
						<tr>
							<th scope="row">사용여부</th>
							<td>
								<form:radiobutton path="banUseYn" value="Y" checked="checked"/> <label for="radio_ck01">YES</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<form:radiobutton path="banUseYn" value="N"/> <label for="radio_ck02">NO</label>
							</td>
						</tr>
						<tr>
							<th scope="row">새창여부</th>
							<td>
								<form:select path="banNewWindow" class="se_base w150">
									<form:option value="Y">새창</form:option>
									<form:option value="N">현재창</form:option>
									<form:option value="01">원서접수</form:option>
									<form:option value="02">원서접수확인</form:option>
									<form:option value="03">합격자확인</form:option>
								</form:select>
							</td>
						</tr>
						<tr id="pcImage">
							<th scope="row">PC 이미지</th>
							<td>
								<input type="file" id="attachedFile_1" name="attachedFile_1" onchange="delChk('1')"/>
								<br />
								<c:if test="${empty bannerVO.banSeq}">
								<input type="hidden" id="bannerDelChk" name="bannerDelChk" value="new"/>
								</c:if>
								<c:if test="${!empty bannerVO.banSeq  && bannerVO.banType ne 'U' }">
								<c:out value="${bannerVO.banImgName }"/>
								<input type="hidden" id="banVal" value="<c:out value="${bannerVO.banImgName }"/>"/>
								<input type="checkbox" id="bannerDelChk1" name="bannerDelChk" value="IMG" onclick="chChk('1');"/>
								<label for="bannerDelChk1">삭제</label>
								<br />
								</c:if>
								<div class="alt_txt" style="padding-top:5px; clear:both; display:block;" id="imageSize"></div>
							</td>
						</tr>
						<!-- 200410추가 -->
 						<tr id="pcVideo"> 
							<th scope="row">PC 동영상</th>
							<td>
								<input type="file" id="attachedFile_2" name="attachedFile_2" onchange="delChk('2')"/>
								<br />
								<c:if test="${empty bannerVO.banSeq}">
								<input type="hidden" id="bannerDelChk" name="bannerDelChk" value="new"/>
								</c:if>
								<c:if test="${!empty bannerVO.banSeq  && bannerVO.banType ne 'U' }">
								<c:out value="${bannerVO.banMp4Name }"/>
								<input type="hidden" id="banVal" value="<c:out value="${bannerVO.banMp4Name }"/>"/>
								<c:if test="${!empty bannerVO.banMp4Name}">
									<input type="checkbox" id="bannerDelChk2" name="bannerDelChk" value="MP4" onclick="chChk('2');"/>
									<label for="bannerDelChk2">삭제</label>
									<br />
								</c:if>
								</c:if>
								<div class="alt_txt" style="padding-top:5px; clear:both; display:block;" id="imageSize"></div>
								<label style="font-size:11px; color:#FF8000;">
									* 사이즈는 기본1280*720 사이즈로 올리시면 됩니다.<br/>
									* 용량은 5메가 전후를 권장합니다. <!-- (용량은 최대 10메가까지 첨부 가능합니다.) -->
								</label>
								
							</td>
						</tr>
						<!-- //200410추가 -->
						<!-- 20200522추가 -->
						<tr id="mp4Url"> 
							<th scope="row">동영상 URL</th>
							<td>
								<form:input path="banMp4Url" class="in_base" style="width:80%;"/>
								<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">
									* youtube 또는 vimeo URL을 입력해 주세요<br/>
									* http를 포함한 전체 URL 주소를 입력해 주세요
								</div>
							</td>
						</tr>
						<!-- //20200522추가 -->
						<tr id="url">
							<th scope="row">URL</th>
							<td>
								<form:input path="banUrl" class="in_base" style="width:80%;" />
								<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* http를 포함한 전체 URL 주소를 입력해 주세요</div>
							</td>
						</tr>
						<tr>
							<th scope="row">배너 노출 순서</th>
							<td>
								<form:input path="banOrder" class="in_base w100" />
								<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">
									* 입력한 배너 노출 순서에 따라 사용자 화면에 순서대로 노출됩니다.<br>
									* 노출 순서가 같은 배너가 여러 개일 경우 최근에 등록한 배너가 위에 노출됩니다.
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<div id="addBanner">
					<c:if test="${!empty bannerVO.banSeq && (bannerVO.banType eq'M' || bannerVO.banType eq 'S' || bannerVO.banType eq 'L')}">
					<br/>
					<table class="view_tbl_03 mb30" summary="배너관리">
					<caption>배너관리</caption>
					<colgroup>
							<col width="20%" />
							<col width="80%" />
					</colgroup>
					<tbody>
					<c:if test="${bannerVO.banType eq 'M'}">
						<tr class="first">
							<th scope="row">말머리1</th>
							<td colspan="3">
								<form:textarea path="banAddName1" class="in_base" style="width:80%; height:80%;" />
								<script type="text/javascript">
									CKEDITOR.replace( 'banAddName1', {
										filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
								<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* 메인배너 첫번째 줄에 들어갈 내용을 작성해 주세요.</div>
							</td>
						</tr>
						<tr>
							<th scope="row">말머리2</th>
							<td colspan="3">
								<form:textarea path="banAddName2" class="in_base" style="width:80%; height:80%;" />
								<script type="text/javascript">
									CKEDITOR.replace( 'banAddName2', {
										filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							</td>
						</tr>
						<tr>
							<th scope="row">말머리3</th>
							<td colspan="3">
								<form:input path="banAddName3" class="in_base" style="width:80%; height:80%;" />
								<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* 메인배너 세번째 줄에 들어갈 내용을 작성해 주세요.</div>
							</td>
						</tr>
						</c:if>
						<c:if test="${bannerVO.banType eq 'S'}">
						<tr class="first">
							<th scope="row">말머리1</th>
							<td colspan="3">
								<form:textarea path="banAddName1" class="in_base" style="width:80%;" />
								<script type="text/javascript">
									CKEDITOR.replace( 'banAddName1', {
										filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
								<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* 서브배너 첫번째 버튼에 들어갈 내용을 작성해 주세요.</div>
							</td>
						</tr>
						</c:if>
						<c:if test="${bannerVO.banType eq 'L'}">
						<tr class="first">
							<th scope="row">내용</th>
							<td colspan="3">
								<form:textarea path="banAddName1" class="in_base" style="width:80%; height:80%;" />
								<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* 중간배너에 들어갈 내용을 작성해 주세요.</div>
							</td>
						</tr>
					</c:if>
					</tbody>
					</table>
					</c:if>
				</div>
				<div class="btn_box">
					<div class="btn_r">
						<c:if test="${!empty bannerVO.banSeq }"><a href="#" onclick="fn_delete(); return false;" class="b_type02">삭제</a></c:if>
						<a href="#" onclick="fn_save(); return false;" class="b_type04">저장</a>
						<a href="#" onclick="fn_list(); return false;" class="b_type03">목록</a>
					</div>
				</div>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex }'/>"/>
				<input type="hidden" name="searchCondition1" value="<c:out value='${searchVO.searchCondition1 }'/>"/>
				<input type="hidden" name="searchWord" value="<c:out value='${searchVO.searchWord }'/>"/>
			</form:form>
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
<input type="hidden" id="message" value="${message}" />
<script type="text/javascript">
	
	$(function(){
		
		<c:if test='${empty bannerVO.banSeq}'>
			fn_bannerType();
		</c:if>
		<c:if test='${!empty bannerVO.banSeq}'>
			fn_imageUseYn();
		</c:if>
			
		//파일사이즈 체크
		/* $("input:file").change(function() {
			var fileSize = -1;
			if(this.files){
				fileSize = this.files[0].size;
			}
			fileCheck_adm(this.id, fileSize);
			
		}) */
	});
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/banner/admBannerList.do'/>").submit();
	}
	
	// 등록&수정
	function fn_save(){
		
		if($("#banName").val() == ''){
			alert("배너명은 필수 입력항목입니다.");
			$("#banName").focus();
			return false;
		}
		
		if($("#banOrder").val() == ''){
			$("#banOrder").val("1");
		}
		
		if($("#banSeq").val() != ''){
			if($("#bannerDelChk").prop("checked") && $("#attachedFile_1").val() == "" && $("#banType").val() != 'U' && $("#banType").val() != 'S' && $("#banType").val() != 'L' ){
				alert("PC이미지는 필수 입력항목입니다.");
				return false;
			}
		}else{
			if($("#attachedFile_1").val() == "" && $("#banType option:selected").val() != 'U' && $("#banType option:selected").val() != 'S' && $("#banType option:selected").val() != 'L'){
				alert("PC이미지는 필수 입력항목입니다.");
				return false;
			}
		}		
		
		var banType = fn_imageUseYn();
		if(banType == 'M'){
			$("#banAddName1").val(CKEDITOR.instances.banAddName1.getData());
			$("#banAddName2").val(CKEDITOR.instances.banAddName1.getData());
			
		}else if(banType == 'S'){
			$("#banAddName1").val(CKEDITOR.instances.banAddName1.getData());
		}
		
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/banner/admBannerUpdate.do'/>").submit();
	}
	
	//삭제
	function fn_delete(){
		if(confirm("삭제하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/banner/admBannerDelete.do'/>").submit();	
		}	
	}
	
	function fn_imageUseYn(){
		var banType = $("#banType option:selected").val();
		if(banType == null){
			banType = '<c:out value="${searchVO.searchCondition1}"/>';
		}
		
		if(banType != 'M'){
			$("#mp4Url").attr("style","display:none;");
			$("#pcVideo").attr("style","display:none;");
		}
		
		if( banType == 'S' || banType == 'U' || banType == 'L' ){
			$("#pcImage").attr("style","display:none;");
		}else{
			$("#pcImage").attr("style","display;");
			if(banType == 'M') {
				$("#imageSize").html("* 사이즈는 1598*834 에 맞춰 올려주세요.");
			}else if(banType == 'F'){
				$("#imageSize").html("* 사이즈는 200*138 에 맞춰 올려주세요.");
			}else if(banType == 'R'){
				$("#imageSize").html("* 사이즈는 81*30 에 맞춰 올려주세요.");
			}
		}
		
		return banType;
	}
	
	//배너구분
	function fn_bannerType(){
	
		var banType = fn_imageUseYn();
		
		$("#addBanner").empty();
		if(banType == 'M' || banType == 'S' || banType == 'L'){
			var tags = '<br/>';
			tags += '<table class="view_tbl_03 mb30" summary="배너관리">';
			tags += '<caption>배너관리</caption>';
			tags += '<colgroup>';
			tags += '		<col width="20%" />';
			tags += '		<col width="80%" />';
			tags += '</colgroup>';
			tags += '<tbody>';
			if(banType=='M'){
				tags += '	<tr class="first">';
				tags += '		<th scope="row">말머리1</th>';
				tags += '		<td colspan="3">';
				tags += '			<textarea name="banAddName1" class="in_base" style="width:80%; height:80%;"></textarea>';
				tags += '			<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* 메인배너 첫번째 줄에 들어갈 내용을 작성해 주세요.</div>';
				tags += '		</td>';
				tags += '	</tr>';
				tags += '	<tr>';
				tags += '		<th scope="row">말머리2</th>';
				tags += '		<td colspan="3">';
				tags += '			<textarea name="banAddName2" class="in_base" style="width:80%; height:80%;" ></textarea>';
				tags += '			<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* 메인배너 두번째 줄에 들어갈 내용을 작성해 주세요.</div>';
				tags += '		</td>';
				tags += '	</tr>';
				tags += '	<tr>';
				tags += '		<th scope="row">말머리3</th>';
				tags += '		<td colspan="3">';
				tags += '			<input type="text" name="banAddName3" class="in_base" style="width:80%;" />';
				tags += '			<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* 메인배너 세번째 줄에 들어갈 내용을 작성해 주세요.</div>';
				tags += '		</td>';
				tags += '	</tr>';
				 
				 
			}else if(banType=='S'){
				tags += '	<tr class="first">';
				tags += '		<th scope="row">말머리1</th>';
				tags += '		<td colspan="3">';
				tags += '			<input type="text" name="banAddName1" class="in_base" style="width:80%;" />';
				tags += '			<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* 서브배너 첫번째 버튼에 들어갈 내용을 작성해 주세요.</div>';
				tags += '		</td>';
				tags += '	</tr>';

				
			}else if(banType == 'L'){
				tags += '	<tr class="first">';
				tags += '		<th scope="row">내용</th>';
				tags += '		<td colspan="3">';
				tags += '			<textarea name="banAddName1" class="in_base" style="width:80%; height:80%;" ></textarea>';
				tags += '			<div class="alt_txt" style="padding-top:5px; clear:both; display:block;">* 중간배너에 들어갈 내용을 작성해 주세요.</div>';
				tags += '		</td>';
				tags += '	</tr>';
			}
				
			tags+='</tbody>';
			tags+='</table>';
			$("#addBanner").append(tags);
			
			if(banType == 'M'){
				CKEDITOR.replace( 'banAddName1', {
					filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
				});
				CKEDITOR.replace( 'banAddName2', {
					filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
				});
			}else if(banType == 'S'){
				CKEDITOR.replace( 'banAddName1', {
					filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
				});
				
			}
		}
	}
</script>
</body>
</html>