<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script>
	function closeLayer( obj ) {
		$(obj).parent().parent().hide();
	}

	$(function(){

		/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
		$('.imgSelect').click(function(e)
		{
			var sWidth = window.innerWidth;
			var sHeight = window.innerHeight;

			var oWidth = $('.popupLayer').width();
			var oHeight = $('.popupLayer').height();

			// 레이어가 나타날 위치를 셋팅한다.
			var divLeft = e.clientX + 10;
			var divTop = e.clientY + 5;

			// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
			if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
			if( divTop + oHeight > sHeight ) divTop -= oHeight;

			// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
			if( divLeft < 0 ) divLeft = 0;
			if( divTop < 0 ) divTop = 0;

			$('.popupLayer').css({
				"top": divTop,
				"left": divLeft,
				"position": "absolute"
			}).show();
		});
		
		var typ = $(".mob").css("display");
		
		if( typ != "none" ){
			var ynVal = '<c:out value="${syllabusVO.syllaYn}"/>';
			
			if(ynVal == '게시'){
				$("#rad03").attr('checked', 'checked');
			}else{
				$("#rad04").attr('checked', 'checked');
			}
		}
		
	});
	
	
	function fn_save(){
		var syllaStnd = $('#syllaStnd').val(CKEDITOR.instances.syllaStnd.getData());

		if(syllaStnd == ''){
			alert('내용을 입력해주세요.')
			$('#syllaStnd').focus();
			return;
		}
		$("#detailForm").attr("method", "post").attr('action', "<c:url value='/usr/lec/clss/lecAddSyll.do'/>").submit();
		/* var syllaweekNm = $('#syllaweekNm1').val();
		var syllaweekMon1 = $('#syllaweekMon1').val();
		var syllaweekMon2 = $('#syllaweekMon2').val();
		var syllaweekMonRmk = $('#syllaweekMonRmk').val();
		var syllaweekTue1 = $('#syllaweekTue1').val();
		var syllaweekTue2 = $('#syllaweekTue2').val();
		var syllaweekTueRmk = $('#syllaweekTueRmk').val();
		var syllaweekWed1 = $('#syllaweekWed1').val();
		var syllaweekWed2 = $('#syllaweekWed2').val();
		var syllaweekWedRmk = $('#syllaweekWedRmk').val();
		var syllaweekThu1 = $('#syllaweekThe1').val();
		var syllaweekThu2 = $('#syllaweekThe2').val();
		var syllaweekThuRmk = $('#syllaweekTheRmk').val();
		var syllaweekFri1 = $('#syllaweekFri1').val();
		var syllaweekFri2 = $('#syllaweekFri2').val();
		var syllaweekFriRmk = $('#syllaweekFriRmk').val(); */
		//var fromData = $("#detailForm").serialize();
		
		//$("#syllaStnd").val(syllaStnd.getData());
		
		
	};

		function fn_add(web){
			var cnt = $("."+web+" .file-upload").length;
			
			if(cnt >= 5){
				alert('파일첨부는 5개까지만 가능합니다.');
				return false;
			}
			else{
			
				var html = '';
				
				html += '<p class="file-upload" id="'+web+'_'+cnt+'">';
				html += '	<input type="text" value="파일선택" class="input-data" id="fileName_'+cnt+'" readonly="readonly">';
				html += '	<label for="upload_file_'+cnt+'" class="btn-upload-file">파일업로드</label>';
				html += '	<input type="file" class="hidden" id="upload_file_'+cnt+'" name="upload_file_'+cnt+'" onchange="fn_file(this); return false;"/>';
				html += '	<button class="white" onclick="fn_remove(\''+web+'\','+cnt+'); return false;">x</button>';
				html += '</p>';
				
				$("#file_"+web).append(html);
			}
		}
		
		function fn_del(seq){
			
			var html = '<input type="hidden" name="delSeqList" value="'+seq+'"/>';
			
			$("#delAtt").append(html);
			$("#fileDiv"+seq).remove();
		}
		
		function fn_remove(web, cnt){
			$("#"+web+"_"+cnt).remove();
		}
		
		function fn_file(ele){
			var eleId = ele.id;
			var cnt = eleId.split('_')[2];
			if(fileCheck_adm(eleId)){
				var fileValue = $(ele).val().split("\\");
				var fileName = fileValue[fileValue.length-1];
				var extension = fileName.split(".")[1].toUpperCase();
			
		 		/* if(extension != 'JPG'){
					alert('JPG만이 첨부 가능합니다');
					$('#upload_file').val('');
					return;
				} */
		 		
				$("#fileName_"+cnt).val(fileName);
			}else{
				$(this).val('');
				$("#fileName_"+cnt).val('파일선택');
			}
		}
		
		// 게시여부 확인
		var radioVal = $(':radio[name="syllaYn"]:checked').val();

		
		
		// 주차별 계획 추가
		/* function fn_create_week(){
			var cnt = $(".week_wrap").length;
			var index =$("p[name=week"+cnt+"]").length;
			
			
			var html = '';
			
			html += '<div class="week_wrap">';
			html +='<div class="list-table-box">';
			html +='<table class="normal-wmv-table">';
			html +='<colgroup>';
			html +='<col style="width:15%;" />';
			html +='<col />';
			html +=		'<col />';
			html +=		'<col style="width:15%;" />';
			html +=	'</colgroup>';
			html +=	'<thead>';
			html +=		'<tr>';
			html +=			'<th>';
			html +=				'<input style="width:50%;" type="text" id="syllaweekNm1" name="syllabusList['+cnt+'].syllaweekNm" value="${syllabusVO.syllaweekNm }" />';
			html +=				'<button type="button" class="normal-btn" id="fn_clear_weeknm">x</button>';
			html +=			'</th>';
			html +=			'<th>1교시~2교시</th>';
			html +=			'<th>3교시~4교시</th>';
			html +=			'<th>비고</th>';
			html +=		'</tr>';
			html +=	'</thead>';
			html +=	'<tbody>';
			html +=		'<tr>';
			html +=			'<th>월</th>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekMon1" name="syllabusList['+cnt+'].syllaweekMon1" /></td>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekMon2" name="syllabusList['+cnt+'].syllaweekMon2" /></td>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekMonRmk" name="syllabusList['+cnt+'].syllaweekMonRmk" /></td>';
			html +=		'</tr>';
			html +=		'<tr>';
			html +=			'<th>화</th>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekTue1" name="syllabusList['+cnt+'].syllaweekTue1" /></td>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekTue2" name="syllabusList['+cnt+'].syllaweekTue2" /></td>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekTueRmk" name="syllabusList['+cnt+'].syllaweekTueRmk" /></td>';
			html +=		'</tr>';
			html +=		'<tr>';
			html +=			'<th>수</th>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekWed1" name="syllabusList['+cnt+'].syllaweekWed1" /></td>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekWed2" name="syllabusList['+cnt+'].syllaweekWed2" /></td>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekWedRmk" name="syllabusList['+cnt+'].syllaweekWedRmk" /></td>';
			html +=		'</tr>';
			html +=		'<tr>';
			html +=			'<th>목</th>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekThu1" name="syllabusList['+cnt+'].syllaweekThu1" /></td>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekThu2" name="syllabusList['+cnt+'].syllaweekThu2" /></td>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekThuRmk" name="syllabusList['+cnt+'].syllaweekThuRmk" /></td>';
			html +=		'</tr>';
			html +=		'<tr>';
			html +=			'<th>금</th>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekFri1" name="syllabusList['+cnt+'].syllaweekFri1" /></td>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekFri2" name="syllabusList['+cnt+'].syllaweekFri2" /></td>';
			html +=			'<td><input type="text" class="input-data w100pc" id="syllaweekFriRmk" name="syllabusList['+cnt+'].syllaweekFriRmk" /></td>';
			html +=		'</tr>';
			html +=	'</tbody>';
			html +='</table>';
			html +='</div>';
			html +='</div>';
			
			
			
			$("#week_wrap").append(html);
			
		}; */
		

		/* // 주차계획 삭제
		$(document).on("click", "#fn_clear_weeknm", function(){
			var Html = $(this).closest("div");
			Html.remove();
		}); */


		/* // 주차계획 초기화
		$(function(){
			$('#fn_reset_week').click(function(){
				$('input[name=syllaweekMon1]').val('');
				$('input[name=syllaweekMon2]').val('');
				$('input[name=syllaweekMonRmk]').val('');
				$('input[name=syllaweekTue1]').val('');
				$('input[name=syllaweekTue2]').val('');
				$('input[name=syllaweekTueRmk]').val('');
				$('input[name=syllaweekWed1]').val('');
				$('input[name=syllaweekWed2]').val('');
				$('input[name=syllaweekWedRmk]').val('');
				$('input[name=syllaweekThu1]').val('');
				$('input[name=syllaweekThu2]').val('');
				$('input[name=syllaweekThuRmk]').val('');
				$('input[name=syllaweekFri1]').val('');
				$('input[name=syllaweekFri2]').val('');
				$('input[name=syllaweekFriRmk]').val('');
			});
		}); */

</script>
<body>
	<form:form commandName="syllabusVO" id="detailForm" name="detailForm" enctype="multipart/form-data">
	<input type="hidden" name="clssSeq" id="clssSeq" value="${lectSession.lectSeq }"/>
	<input type="hidden" name="syllaSeq" id="syllaSeq" value="${syllabusVO.syllaSeq }"/>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">강의계획서 – 강의계획서작성</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>강의계획서</span>
					</div>
				</div>

				<p class="sub-title">기본 정보</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:15%;" />
							<col style="width:10%;" />
							<col style="width:15%;" />
							<col style="width:10%;" />
							<col style="width:15%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>프로그램</th>
								<td>
									<c:out value="${lectSession.lectProg }"/>
								</td>
								<th>교과목명</th>
								<td>
									<c:out value="${lectSession.lectName }"/>
								</td>
								<th>분반</th>
								<td>
									<c:out value="${lectSession.lectDivi }"/>
								</td>
								<th>담임</th>
								<td>
									<c:out value="${lectSession.name }"/>(<c:out value="${lectSession.lectClaTea }"/>)
								</td>
							</tr>
							<tr>
								<th>수업시간</th>
								<td colspan="3" class="txt-l">
									월요일 ~ 금요일 1교시(09:00) ~ 4교시(12:50)
								</td>
								<th><sup>*</sup>게시여부</th>
								<td>
									<input type="radio" id="rad01" name="syllaYn" value="Y" <c:if test="${syllabusVO.syllaYn eq '게시' }">checked = "checked" </c:if> checked/> 
									<label for="rad01">게시</label> &nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" id="rad02" name="syllaYn" value="N" <c:if test="${syllabusVO.syllaYn eq '게시안함'}">checked = "checked"</c:if>/> 
									<label for="rad02">게시안함</label>
								</td>	
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				 <div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>프로그램</dt> 
							<dd><c:out value="${lectSession.lectProg }"/></dd>
						</dl>
						<dl>
							<dt>교과목명</dt>
							<dd><c:out value="${lectSession.lectName }"/></dd>
						</dl>
						<dl>
							<dt>분반</dt>
							<dd><c:out value="${lectSession.lectDivi }"/></dd>
						</dl>
						<dl>
							<dt>담임</dt>
							<dd><c:out value="${lectSession.name }"/>(<c:out value="${lectSession.lectClaTea }"/>)</dd>
						</dl>
						<dl>
							<dt>수업시간</dt>
							<dd>월요일 ~ 금요일 1교시(09:00) ~ 4교시(12:50)</dd>
						</dl>
						<dl>
							<dt><sup>*</sup>게시여부</dt>
							<dd>
								<input type="radio" id="rad03" name="syllaYn" value="Y"/> 
								<label for="rad03">게시</label> &nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="rad04" name="syllaYn" value="N"/> 
								<label for="rad04">게시안함</label>
							</dd>
						</dl>
					</div>
				</div>

				<p class="sub-title">평가기준</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table" style="height:200px;"> 
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>평가기준</th>
								<td>
									<form:textarea path="syllaStnd" />
									<script type="text/javascript">
										CKEDITOR.replace( 'syllaStnd', {
											height: 300,
											filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
										});
									</script>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				 <div class="mob mb20">
					<div class="mob-write">
						<dl>
							<!-- <dt><sup>*</sup>평가기준</dt>
							<dd> -->
								<form:textarea path="syllaStnd" id="content"/>
								<script type="text/javascript">
									CKEDITOR.replace( 'content', {
										height: 300,
										filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							<!-- </dd> -->
						</dl>
					</div>
				</div> 

				<p class="sub-title">첨부파일</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>첨부파일</th>
								<td id="file_web">
									<c:forEach items="${attachList }" var="attach" varStatus="status">
										<p class="file-upload" id="fileDiv<c:out value='${attach.attachSeq }'/>">
											<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>"><c:out value="${attach.orgFileName }"/></a>
											<button class="white" onclick="fn_del('<c:out value="${attach.attachSeq }"/>'); return false;">x</button>
										</p>
									</c:forEach>
									<p class="file-upload">
										<input type="text" value="파일선택" class="input-data" disabled="disabled" id="fileName_0" readonly="readonly">
										<label for="upload_file_0" class="btn-upload-file">파일업로드</label>
										<input type="file" class="hidden" id="upload_file_0" name="upload_file_0" onchange="fn_file(this); return false;"/>
										<button class="white" onclick="fn_add('web'); return false;">+</button>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>첨부파일</dt>
							<dd>
								<ul>
									<li id="file_mob">
										<c:forEach items="${attachList }" var="attach" varStatus="status">
											<p class="file-upload" id="fileDiv<c:out value='${attach.attachSeq }'/>">
												<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>"><c:out value="${attach.orgFileName }"/></a>
												<button class="white" onclick="fn_del('<c:out value="${attach.attachSeq }"/>'); return false;">x</button>
											</p>
										</c:forEach>
										<p class="file-upload">
											<input type="text" value="파일선택" class="input-data" disabled="disabled" id="fileName_0" readonly="readonly">
											<label for="upload_file_0" class="btn-upload-file">파일업로드</label>
											<input type="file" class="hidden" id="upload_file_0" name="upload_file_0" onchange="fn_file(this); return false;"/>
											<button class="white" onclick="fn_add('mob'); return false;">+</button>
										</p>
									</li>
								</ul>  
							</dd>
						</dl>
					</div>
				</div>

				<%-- <p class="sub-title">주차별 계획 <button type="button" class="normal-btn" onclick="fn_create_week();">주차 추가+</button></p>
				<!-- table -->
				<div  id="week_wrap">
					<c:forEach items="${weekList }" var="week" varStatus="status">
					<div class="week_wrap">
						<input type="hidden" name="syllabusList[<c:out value='${status.index}'/>].syllaSeq" value='<c:out value='${week.syllaSeq }'/>'/>
						<input type="hidden" name="syllabusList[<c:out value='${status.index}'/>].syllaweekSeq" value='<c:out value='${week.syllaweekSeq }'/>'/>
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:15%;" />
									<col />
									<col />
									<col style="width:15%;" />
								</colgroup>
						<thead>
							<tr>
								<th>
									<p class="file-upload" name="week<c:out value='${status.index}'/>">
										<input style="width:50%;" type="text" id="syllaweekNm1" name="syllabusList[<c:out value='${status.index}'/>].syllaweekNm" value="<c:out value="${week.syllaweekNm}"/>" />
										<button type="button" class="normal-btn" id="fn_clear_weeknm">x</button>'
									</p>
								</th>
								
								<th>1교시~2교시</th>
								<th>3교시~4교시</th>
								<th>비고</th>
							</tr>
					   </thead>
						<tbody>
							<tr>
								<th>월</th>
								
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekMon1" name="syllabusList[<c:out value='${status.index}'/>].syllaweekMon1" value="<c:out value="${week.syllaweekMon1}"/>" /></p></td>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekMon2" name="syllabusList[<c:out value='${status.index}'/>].syllaweekMon2" value="<c:out value="${week.syllaweekMon2}"/>"/></p></td>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekMonRmk" name="syllabusList[<c:out value='${status.index}'/>].syllaweekMonRmk" value="<c:out value="${week.syllaweekMonRmk}"/>"/></p></td>
								
							</tr>
							<tr>
								<th>화</th>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekTue1" name="syllabusList[<c:out value='${status.index}'/>].syllaweekTue1" value="<c:out value="${week.syllaweekTue1}"/>"/></p></td>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekTue2" name="syllabusList[<c:out value='${status.index}'/>].syllaweekTue2" value="<c:out value="${week.syllaweekTue2}"/>"/></p></td>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekTueRmk" name="syllabusList[<c:out value='${status.index}'/>].syllaweekTueRmk" value="<c:out value="${week.syllaweekTueRmk}"/>"/></p></td>
							</tr>
							<tr>
								<th>수</th>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekWed1" name="syllabusList[<c:out value='${status.index}'/>].syllaweekWed1" value="<c:out value="${week.syllaweekWed1}"/>"/></p></td>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekWed2" name="syllabusList[<c:out value='${status.index}'/>].syllaweekWed2" value="<c:out value="${week.syllaweekWed2}"/>"/></p></td>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekWedRmk" name="syllabusList[<c:out value='${status.index}'/>].syllaweekWedRmk" value="<c:out value="${week.syllaweekWedRmk}"/>"/></p></td>
							</tr>
							<tr>
								<th>목</th>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekThu1" name="syllabusList[<c:out value='${status.index}'/>].syllaweekThu1" value="<c:out value="${week.syllaweekThu1}"/>"/></p></td>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekThu2" name="syllabusList[<c:out value='${status.index}'/>].syllaweekThu2" value="<c:out value="${week.syllaweekThu2}"/>"/></p></td>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekThuRmk" name="syllabusList[<c:out value='${status.index}'/>].syllaweekThuRmk" value="<c:out value="${week.syllaweekThuRmk}"/>"/></p></td>
							</tr>
							<tr>
								<th>금</th>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekFri1" name="syllabusList[<c:out value='${status.index}'/>].syllaweekFri1" value="<c:out value="${week.syllaweekFri1}"/>"/></p></td>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekFri2" name="syllabusList[<c:out value='${status.index}'/>].syllaweekFri2" value="<c:out value="${week.syllaweekFri2}"/>"/></p></td>
									<td><p class="file-upload" name="week<c:out value='${status.index}'/>"><input type="text" class="input-data w100pc" id="syllaweekFriRmk" name="syllabusList[<c:out value='${status.index}'/>].syllaweekFriRmk" value="<c:out value="${week.syllaweekFriRmk}"/>"/></p></td>
							</tr>
						</tbody>
						</table>
					</div>
				</div>
				</c:forEach>
			</div> --%>
			<p class="sub-title">주차별 계획</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:15%;" />
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">교시</th> 
								<th scope="col">시간</th>
								<th scope="col">월</th>
								<th scope="col">화</th>
								<th scope="col">수</th>
								<th scope="col">목</th>
								<th scope="col">금</th> 
							</tr>
						</thead>
						<tbody>
							
							<c:forEach items="${timeTableList }" var="result" varStatus="status">
								<c:set value="9" var="hour"/>
								<tr>
									<td scope="row"><c:out value="${status.count }"/>교시</td>
									<td scope="row"><c:out value="${hour+status.index }"/>:00 ~ <c:out value="${hour+status.index }"/>:50</td>
									<td scope="row"><c:out value="${result.mon}"/></td>
									<td scope="row"><c:out value="${result.tue}"/></td>
									<td scope="row"><c:out value="${result.wed}"/></td>
									<td scope="row"><c:out value="${result.thu}"/></td>
									<td scope="row"><c:out value="${result.fri}"/></td>
								</tr>
							</c:forEach>
								<%-- <td><c:out value="${result.lectSclass }"/></td>
								
								<td><c:out value="${result.lectWeek }"/></td> --%>
						</tbody>
					</table>
				</div> 
				
				
				
				<!-- 
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:15%;" />
							<col />
							<col />
							<col style="width:15%;" />
						</colgroup>
						<thead>
							<tr>
								<th>
									<input style="width:50%;" type="text" id="syllaweekNm1" name="syllaweekNm" value="" />
									<button type="button" class="normal-btn" onclick="fn_clear_weeknm('1');">x</button>
								</th>
								<th>1교시~2교시</th>
								<th>3교시~4교시</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>월</th>
								<td><input type="text" id="syllaweekMon1" name="syllaweekMon1" class="input-data w100pc" /></td>
								<td><input type="text" class="input-data w100pc" /></td>
								<td><input type="text" class="input-data w100pc" /></td>
							</tr>
							<tr>
								<th>화</th>
								<td><input type="text" class="input-data w100pc" /></td>
								<td><input type="text" class="input-data w100pc" /></td>
								<td><input type="text" class="input-data w100pc" /></td>
							</tr>
							<tr>
								<th>수</th>
								<td><input type="text" class="input-data w100pc" /></td>
								<td><input type="text" class="input-data w100pc" /></td>
								<td><input type="text" class="input-data w100pc" /></td>
							</tr>
							<tr>
								<th>목</th>
								<td><input type="text" class="input-data w100pc" /></td>
								<td><input type="text" class="input-data w100pc" /></td>
								<td><input type="text" class="input-data w100pc" /></td>
							</tr>
							<tr>
								<th>금</th>
								<td><input type="text" class="input-data w100pc" /></td>
								<td><input type="text" class="input-data w100pc" /></td>
								<td><input type="text" class="input-data w100pc" /></td>
							</tr>
						</tbody>
					</table>
				</div>
				-->
				<!--// table -->
				
				<!-- <div class="mt10 txt-r mb20" style="margin-top:-10px;">
					<button type="button" id="fn_reset_week" style="background-color:#fff;" class="underline">주차계획 초기화</button>
					
				</div> -->
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecSyllabusView.do'/>" class="white btn-list">목록</a>
						<button type="button" onclick="fn_save(); return false;" class="white btn-save">저장</button>
					</div>
				</div>
				<!--// table button -->
			
			</div>
		</div>

	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
	<div id="delAtt"></div>
	</form:form>
</body>
</html>