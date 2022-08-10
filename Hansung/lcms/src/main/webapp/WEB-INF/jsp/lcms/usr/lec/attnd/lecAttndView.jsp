<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script>
	function closeLayer( obj ) {
		$(obj).parent().parent().hide();
	}

	$(function(){

		/* 클릭시 클릭한 위치 근처에 레이어가 나타난다. */
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
		
		/* 클릭시 클릭한 위치 근처에 레이어가 나타난다. */
		$('.imgSelect2').click(function(e)
		{
			var sWidth = window.innerWidth;
			var sHeight = window.innerHeight;

			var oWidth = $('.popupLayer2').width();
			var oHeight = $('.popupLayer2').height();

			// 레이어가 나타날 위치를 셋팅한다.
			var divLeft = e.clientX + 10;
			var divTop = e.clientY + 5;

			// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
			if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
			if( divTop + oHeight > sHeight ) divTop -= oHeight;

			// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
			if( divLeft < 0 ) divLeft = 0;
			if( divTop < 0 ) divTop = 0;

			$('.popupLayer2').css({
				"top": divTop,
				"left": divLeft,
				"position": "absolute"
			}).show();
		});
		
		$("#datepicker01").change(function(){
			$("#frm").attr("action", "<c:url value='/usr/lec/attnd/lecAttndView.do'/>").submit();
		});

	});
	
	function fn_search(){
		$("#frm").attr("action", "<c:url value='/usr/lec/attnd/lecAttndView.do'/>").submit();
	}
	
	function fn_etc(memberCode, name){
		var attDate = $("#datepicker01").val();
		$.ajax({
			url: "<c:url value='/usr/lec/attnd/lecAjaxAttndEtc.do'/>"
			, type: "post"
			, data: "attDate="+attDate+"&memberCode="+memberCode
			, dataType:"json"
			, success: function(data){
				
				$("#name").html(name);
				$("#mCode").html(memberCode);
				$("#date").html(attDate);
				$("#name2").html(name);
				$("#mCode2").html(memberCode);
				$("#date2").html(attDate);
				
				$("#memberCode").val(memberCode);
				$("#attDatePop").val(attDate);
				
				var resultMap = data.resultMap;
				var attachList = data.attachList;
				var html = "";
				var attEtc = "";
				
				if(resultMap != null){
					attEtc = resultMap.attEtc;
					$("#etcSeq").val(resultMap.etcSeq);
				}else{
					$("#etcSeq").val('');
				}
				
				html += '<tr>';
				html += '	<td>';
				html += '		<textarea name="attEtc" rows="5" class="w100pc">'+attEtc+'</textarea>';
				html += '	</td>';
				html += '</tr>';
				html += '<tr>';
				html += '	<td>';
				html += '		<p class="file-upload">';
				html += '			<input type="text" value="파일선택" class="input-data" readonly="readonly" id="fileName">';
				html += '			<label for="upload_file" class="btn-upload-file">파일업로드</label>';
				html += '			<input type="file" class="hidden" id="upload_file" name="upload_file">';
				
				if(attachList != null && attachList[0] != null){
					html += '		<br/><br/>';
					html += '		<a href="<c:url value="/cmmn/file/downloadFile.do"/>?fileId='+attachList[0].attachSeq+'&type='+attachList[0].boardType+'">';
					html += '			'+attachList[0].orgFileName;
					html += '		</a>';
					html += '		<input type="hidden" id="deleteFile" name="deleteFile" value="'+attachList[0].attachSeq+'" />';
				}
				
				html += '		</p>';
				html += '	</td>';
				html += '</tr>';
				
				$("#stdBody").html(html);
				$("#stdBody2").html(html);
				
				$("#upload_file").change(function(){
					var eleId = this.id;
					if(fileCheck_adm(eleId)){
						var fileValue = $(this).val().split("\\");
						var fileName = fileValue[fileValue.length-1];
						var extension = fileName.split(".")[1].toUpperCase();
					
						$("#fileName").val(fileName);
					}else{
						$(this).val('');
						$("#fileName").val('파일선택');
					}
				});
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_etc_save(){
		fn_grep_typ();
		
		var form = $('#etcFrm')[0];
        var formData = new FormData(form);
        formData.append("fileObj", $("#upload_file")[0].files[0]);

		$.ajax({
			url: "<c:url value='/usr/lec/attnd/lecAjaxAttndEtcUpdate.do'/>"
			, processData: false
			, contentType: false
			, type: "post"
			, data: formData
			, dataType:"json"
			, success: function(data){
				alert(data.message);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_save(){
		$("#frm").attr("action", "<c:url value='/usr/lec/attnd/lecAttndSubmit.do'/>").submit();
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">출결 - 출결등록</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>출결</span>
					</div>
				</div>
				<form:form commandName="attendVO" id="frm" name="frm">
				<form:hidden path="lectSeq" value="${lecSession.lectSeq }"/>
				<form:hidden path="lectClass" value="${lecSession.lectClass }"/>
				<p class="sub-title">대상 출결</p>
				<div>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:10%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th>출석일자</th>
									<td>
										<form:input path="attDate" id="datepicker01" readonly="readonly" value="${lecSession.attDate }"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
				</div>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:5%;"/>
							<col />
							<col style="width:5%;"/>
							<c:forEach items="${lectTimeList }" var="lectTime">
								<c:forEach begin="${lectTime.lectSclass }" end="${lectTime.lectEclass }" var="class">
									<col />
								</c:forEach>
							</c:forEach>
							<col style="width:6%;" />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>학번</th>
								<th>이름</th>
								<c:forEach items="${lectTimeList }" var="lectTime">
									<c:forEach begin="${lectTime.lectSclass }" end="${lectTime.lectEclass }" var="i" varStatus="status">
										<th><c:out value="${i }"/>교시</th>
									</c:forEach>
								</c:forEach>
								<th>비고</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="idx" value="0"/>
							<c:set var="idx2" value="0"/>
							<c:forEach items="${memberList }" var="member" varStatus="status">
								<tr>
									<td>
										<c:out value="${memberList.size()-status.index}"/>
									</td>
									<td>
										<span class="underline"><c:out value="${member.memberCode }"/></span>
									</td>
									<td><span class="underline imgSelect"><c:out value="${member.name }"/></span></td>
									<c:forEach items="${lectTimeList }" var="lectTime">
										<c:set var="cnt2" value="0"/>
										<c:forEach begin="${lectTime.lectSclass }" end="${lectTime.lectEclass }" var="class" varStatus="stt">
											<c:set var="cnt" value="0"/>
											<td>
												<c:forEach items="${attendList }" var="attend">
													<c:if test="${attend.memberCode eq member.memberCode && attend.lectClass eq stt.count && attend.lectTbseq eq lectTime.lectTbseq }">
														<c:set var="cnt" value="1"/>
														<c:set var="cnt2" value="1"/>
														<label for="attendList[<c:out value='${idx }'/>].attend2">
															결석&nbsp;<input type="radio" name="attendList[<c:out value='${idx }'/>].attend" id="attendList[<c:out value='${idx }'/>].attend2" value="2" <c:out value="${attend.attend eq '2'?'checked':'' }"/>>
														</label>
														<label for="attendList[<c:out value='${idx }'/>].attend3">
															지각&nbsp;<input type="radio" name="attendList[<c:out value='${idx }'/>].attend" id="attendList[<c:out value='${idx }'/>].attend3" value="3" <c:out value="${attend.attend eq '3'?'checked':'' }"/>>
														</label>
														<label for="attendList[<c:out value='${idx }'/>].attend1">
															출석&nbsp;<input type="radio" name="attendList[<c:out value='${idx }'/>].attend" id="attendList[<c:out value='${idx }'/>].attend1" value="1" <c:out value="${attend.attend eq '1'?'checked':'' }"/>>
														</label>
														<input type="hidden" name="attendList[<c:out value='${idx }'/>].lectClass" value="<c:out value='${stt.count }'/>"/>
														<input type="hidden" name="attendList[<c:out value='${idx }'/>].attSeq" value="<c:out value="${attend.attSeq }"/>"/>
													</c:if>
												</c:forEach>
												<c:if test="${cnt == 0}">
													<label for="attendList[<c:out value='${idx }'/>].attend2">
														결석&nbsp;<input type="radio" name="attendList[<c:out value='${idx }'/>].attend" id="attendList[<c:out value='${idx }'/>].attend2" value="2">
													</label>
													<label for="attendList[<c:out value='${idx }'/>].attend3">
														지각&nbsp;<input type="radio" name="attendList[<c:out value='${idx }'/>].attend" id="attendList[<c:out value='${idx }'/>].attend3" value="3">
													</label>
													<label for="attendList[<c:out value='${idx }'/>].attend1">
														출석&nbsp;<input type="radio" name="attendList[<c:out value='${idx }'/>].attend" id="attendList[<c:out value='${idx }'/>].attend1" value="1" checked>
													</label>
													<input type="hidden" name="attendList[<c:out value='${idx }'/>].lectClass" value="<c:out value='${stt.count }'/>"/>
													<input type="hidden" name="attendList[<c:out value='${idx }'/>].attSeq"/>
												</c:if>
												<input type="hidden" name="attendList[<c:out value='${idx }'/>].memberCode" value="<c:out value='${member.memberCode }'/>"/>
												<input type="hidden" name="attendList[<c:out value='${idx }'/>].lectTbseq" value="<c:out value='${lectTime.lectTbseq }'/>"/>
											</td>
											<c:set var="idx" value="${idx+1 }"/>
										</c:forEach>
									</c:forEach>
									<td>
										<label for="modi-pop" class="normal-btn" onclick="fn_etc('<c:out value="${member.memberCode }"/>', '<c:out value="${member.name }"/>');">비고</label>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<p>* 비고사항을 입력하려면 먼저 '출석등록' 버튼을 눌러주세요</p>
				<!--// table -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/attnd/lecAttndList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">출석등록</button>
					</div>
				</div>
				<!--// table button -->

				</form:form>
			</div>
		</div>
		<form id="etcFrm" name="etcFrm" enctype="multipart/form-data">
			<input type="hidden" id="etcSeq" name="etcSeq"/>
			<input type="hidden" id="attDatePop" name="attDate"/>
			<input type="hidden" id="memberCode" name="memberCode"/>
			<input type="checkbox" id="modi-pop" class="hidden" />
			<div class="black-pop">&nbsp;</div>
			<div class="modi-popup web">
				<p class="sub-title">비고</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;">
							<col >
							<col style="width:10%;">
							<col >
							<col style="width:15%;">
							<col >
						</colgroup>
						<tbody>
							<tr>
								<th>이름</th>
								<td id="name"></td>
								<th>학번</th>
								<td id="mCode"></td>
								<th>강의일자</th>
								<td id="date"></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>비고</th>
							</tr>
						</thead>
						<tbody id="stdBody">
						</tbody>
					</table>
				</div>
				<div class="table-button">
					<div class="btn-box">
						<label for="modi-pop" class="white btn-save" onclick="fn_etc_save();">저장</label>
						<label for="modi-pop" class="white btn-cancel">취소</label>
					</div>
				</div>
			</div>
			<div class="modi-popup mob">
				<p class="sub-title">비고</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:20%;">
							<col >
						</colgroup>
						<tbody>
							<tr>
								<th>이름</th>
								<td id="name2"></td>
							</tr>
							<tr>
								<th>학번</th>
								<td id="mCode2"></td>
							</tr>
							<tr>
								<th>강의일자</th>
								<td id="date2"></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>비고</th>
							</tr>
						</thead>
						<tbody id="stdBody2">
						</tbody>
					</table>
				</div>
				<div class="table-button">
					<div class="btn-box">
						<label for="modi-pop" class="white btn-save" onclick="fn_etc_save();">저장</label>
						<label for="modi-pop" class="white btn-cancel">취소</label>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->
	<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
</body>
</html>