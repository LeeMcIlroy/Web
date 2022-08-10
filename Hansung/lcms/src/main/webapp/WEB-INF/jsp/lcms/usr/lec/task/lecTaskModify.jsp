<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
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
		
		$(function() {
			//input을 datepicker로 선언
			$("#taskSdate, #taskEdate").datepicker({
				dateFormat: 'yy-mm-dd' //Input Display Format 변경
				,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
				,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
				,changeYear: true //콤보박스에서 년 선택 가능
				,changeMonth: true //콤보박스에서 월 선택 가능                		
				,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
				,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
				,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
				,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
				,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
				,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
				,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
				,minDate: "-6M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
				,maxDate: "+6M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
			});                    
			
			var taskSeq = $("#taskSeq").val();
			console.log(taskSeq);
			if( taskSeq == "" || taskSeq == null ){
				$('#taskSdate, #taskEdate').datepicker('setDate', 'today');   
			}
 			         
		});
		
		var typ = $(".mob").css("display");
		
		if( typ != "none" ){
			var ynVal = '<c:out value="${taskVO.taskYn}"/>';
			
			if(ynVal == 'Y'){
				$("#rad04").attr('checked', 'checked');
			}else{
				$("#rad03").attr('checked', 'checked');
			}
		}
	});
	
	
	function fn_save(){
		
		var taskNm = $('#taskNm').val();
		$("#taskContent").val(CKEDITOR.instances.taskContent.getData());
		
		if(taskNm==''){
			alert('제목을 입력해주세요.');
			$('#taskNm').focus();
			return;
		}
		
		if($("#taskContent").val()==''){
			alert('내용을 입력해주세요.')
			$('#taskContent').focus();
			return;
		}
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/task/lecAddTask.do'/>").submit();
	}
	
	function fn_add(web){
		var cnt = $("."+web+" .file-upload").length;
		
		var html = '';
		
		html += '<p class="file-upload" id="'+web+'_'+cnt+'">';
		html += '	<input type="text" value="파일선택" class="input-data" readonly="readonly" id="fileName_'+cnt+'">';
		html += '	<label for="upload_file_'+cnt+'" class="btn-upload-file">파일업로드</label>';
		html += '	<input type="file" class="hidden" id="upload_file_'+cnt+'" name="upload_file_'+cnt+'" onchange="fn_fileName(this);"/>';
		html += '	<button class="white" onclick="fn_remove(\''+web+'\','+cnt+'); return false;">x</button>';
		html += '</p>';
		
		$("#file_"+web).append(html);
	}
	
	function fn_del(seq){
		
		var html = '<input type="hidden" name="delSeqList" value="'+seq+'"/>';
		
		$("#delAtt").append(html);
		$("#fileDiv"+seq).remove();
	}
	
	function fn_remove(web, cnt){
		$("#"+web+"_"+cnt).remove();
	}
	
	function fn_fileName(ele){
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
</script>
<body>
<form:form commandName="taskVO" id="detailForm" name="detailForm" enctype="multipart/form-data">
<input type="hidden" name="taskSeq" id="taskSeq" value="${taskVO.taskSeq }"/>
<input type="hidden" name="lectTbseq" id="lectTbseq" value="${taskVO.lectTbseq }"/>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">과제게시판 - 과제출제</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>과제</span>
						<span>과제게시판</span>
					</div>
				</div>

				<p class="sub-title">출제과제</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>과제명</th>
								<td>
									<input type="text" class="input-data" name="taskNm" id="taskNm" value="<c:out value="${taskVO.taskNm }" />"/>
									<%-- 
									<c:if test="${!empty taskVO.taskSeq }">
										<input type="text" class="input-data" name="taskNm" id="taskNm" value="<c:out value="${taskVO.taskNm }" />"/>	
									</c:if>
									<c:if test="${empty taskVO.taskSeq }">
										<input type="text" class="input-data" name="taskNm" id="taskNm"/>
									</c:if>--%>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>내용</th>
								<td colspan="5" class="bln editor" height="200">
									<form:textarea path="taskContent"/>
									<script type="text/javascript">
										CKEDITOR.replace( 'taskContent', {
											height: 300,
											filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
										});
									</script>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>제출기간</th>
								<td>
									<form:input path="taskSdate" class="w100px"/>
									<form:select path="taskSdateT">
										<c:forEach var="hour" begin="0" end="23" step="1">
											<form:option value="${hour}"><c:out value="${hour}"/></form:option>
										</c:forEach>
									</form:select>&nbsp;시&nbsp;&nbsp;:&nbsp;&nbsp;
									<form:select path="taskSdateM">
										<form:option value="00">00</form:option>
										<form:option value="10">10</form:option>
										<form:option value="20">20</form:option>
										<form:option value="30">30</form:option>
										<form:option value="40">40</form:option>
										<form:option value="50">50</form:option>
									</form:select>&nbsp;분
									&nbsp;&nbsp;ㅡ&nbsp;&nbsp;
									<form:input path="taskEdate" class="w100px"/>
									<form:select path="taskEdateT">
										<c:forEach var="hour" begin="0" end="23" step="1">
											<form:option value="${hour}"><c:out value="${hour}"/></form:option>
										</c:forEach>
									</form:select>&nbsp;시&nbsp;&nbsp;:&nbsp;&nbsp;
									<form:select path="taskEdateM">
										<form:option value="00">00</form:option>
										<form:option value="10">10</form:option>
										<form:option value="20">20</form:option>
										<form:option value="30">30</form:option>
										<form:option value="40">40</form:option>
										<form:option value="50">50</form:option>
									</form:select>&nbsp;분
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>공개여부</th>
								<td>
									<form:radiobutton path="taskYn" id="rad01" value="N" checked="checked" />
									<label for="rad01">비공개</label> &nbsp;&nbsp;&nbsp;&nbsp;
									<form:radiobutton path="taskYn" id="rad02" value="Y" /> 
									<label for="rad02">공개</label> &nbsp;&nbsp;&nbsp;&nbsp;  (‘공개’로 설정한 경우 학생간 첨부파일 다운로드가 가능 합니다)
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt><sup>*</sup>과제명</dt>
							<dd>
								<input type="text" class="input-data" name="taskNm" id="taskNm" value="<c:out value="${taskVO.taskNm }" />"/>
							</dd>
						</dl>
						<dl>
							<!-- <dt><sup>*</sup>내용</dt>
							<dd> -->
								<form:textarea path="taskContent" id="content"/>
								<script type="text/javascript">
									CKEDITOR.replace( 'content', {
										height: 300,
										filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							<!-- </dd> -->
						</dl>
						<dl>
							<dt><sup>*</sup>제출기간</dt>
							<dd>
								<form:input path="taskSdate" class="w100px"/>
								<form:select path="taskSdateT">
									<c:forEach var="hour" begin="0" end="23" step="1">
										<form:option value="${hour}"><c:out value="${hour}"/></form:option>
									</c:forEach>
								</form:select>&nbsp;시&nbsp;&nbsp;:&nbsp;&nbsp;
								<form:select path="taskSdateM">
									<form:option value="00">00</form:option>
									<form:option value="10">10</form:option>
									<form:option value="20">20</form:option>
									<form:option value="30">30</form:option>
									<form:option value="40">40</form:option>
									<form:option value="50">50</form:option>
								</form:select>&nbsp;분
								&nbsp;&nbsp;ㅡ&nbsp;&nbsp;
								<form:input path="taskEdate" class="w100px"/>
								<form:select path="taskEdateT">
									<c:forEach var="hour" begin="0" end="23" step="1">
										<form:option value="${hour}"><c:out value="${hour}"/></form:option>
									</c:forEach>
								</form:select>&nbsp;시&nbsp;&nbsp;:&nbsp;&nbsp;
								<form:select path="taskEdateM">
									<form:option value="00">00</form:option>
									<form:option value="10">10</form:option>
									<form:option value="20">20</form:option>
									<form:option value="30">30</form:option>
									<form:option value="40">40</form:option>
									<form:option value="50">50</form:option>
								</form:select>&nbsp;분
							</dd>
						</dl>
						<dl>
							<dt><sup>*</sup>공개여부</dt>
							<dd>
								<input type="radio" name="taskYn" id="rad03" value="N"/> 
								<label for="rad03">비공개</label> &nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="taskYn" id="rad04" value="Y"/> 
								<label for="rad04">공개</label> &nbsp;&nbsp;&nbsp;&nbsp;  (‘공개’로 설정한 경우 학생간 첨부파일 다운로드가 가능 합니다)
							</dd>
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
										<input type="text" value="파일선택" class="input-data" readonly="readonly" id="fileName_0">
										<label for="upload_file_0" class="btn-upload-file">파일업로드</label>
										<input type="file" class="hidden" id="upload_file_0" name="upload_file_0" onchange="fn_fileName(this);"/>
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
											<input type="text" value="파일선택" class="input-data" readonly="readonly" id="fileName_0">
											<label for="upload_file" class="btn-upload-file">파일업로드</label>
											<input type="file" class="hidden" id="upload_file_0" name="upload_file_0" onchange="fn_fileName(this);"/>
											<button class="white" onclick="fn_add('mob'); return false;">+</button>
										</p>
									</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/task/lecTaskList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
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