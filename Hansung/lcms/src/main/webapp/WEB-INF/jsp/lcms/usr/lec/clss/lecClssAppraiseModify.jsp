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

	});
	
	function fn_add(web){
		var cnt = $("."+web+" .file-upload").length;
		
		var html = '';
		
		html += '<p class="file-upload" id="'+web+'_'+cnt+'">';
		html += '	<input type="text" value="파일선택" class="input-data" disabled="disabled" id="fileName_'+cnt+'" onchange="fn_file(this); return false;" readonly="readonly">';
		html += '	<label for="upload_file_'+cnt+'" class="btn-upload-file">파일업로드</label>';
		html += '	<input type="file" class="hidden" id="upload_file_'+cnt+'" name="upload_file_'+cnt+'"/>';
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
	
	function fn_save(){
		$("#content").val(CKEDITOR.instances.content.getData());
		
		if(fn_validate("frm")){
			$("#frm").attr("action", "<c:url value='/usr/lec/clss/lecClssAppraiseUpdate.do'/>").submit();
		}
	}
	
	function fn_file(ele){
		var eleId = ele.id;
		var cnt = eleId.split('_')[2];
		if(fileCheck_adm(eleId)){
			var fileValue = $(ele).val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
		
			$("#fileName_"+cnt).val(fileName);
		}else{
			$(this).val('');
			$("#fileName_"+cnt).val('파일선택');
		}
	}
	
	function fn_pop(memberCode){
		window.open("<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssAppraisePop.do'/>?memberCode="+memberCode, '평가이력', 'width=1050, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">학생평가 – 학생평가등록</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>학생평가</span>
					</div>
				</div>
				<form:form commandName="evalVO" id="frm" name="frm" enctype="multipart/form-data">
					<form:hidden path="evalSeq"/>
					<form:hidden path="memberCode"/>
					<p class="sub-title">진행 정보</p>
					<!-- table -->
					<div class="list-table-box web">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:10%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><sup>*</sup>평가일자</th>
									<td>
										<form:input path="evalDate" id="datepicker" class="required" title="평가일자"/>
									</td>
									<th>평가자</th>
									<td>
										<form:select path="profCode">
											<c:forEach items="${profList }" var="prof">
												<form:option value="${prof.lectTea }"><c:out value="${prof.name }"/></form:option>
											</c:forEach>
										</form:select>
									</td>
	
								</tr>
								<%-- <tr>
									<th>이름</th>
									<td>
										<c:if test="${evalVO.evalSeq eq '' || evalVO.evalSeq == null }">
											<input type="text" class="input-data" id="name" value="<c:out value="${evalVO.name }"/>"/> <label class="normal-btn" for="modi-pop">학생찾기</label>
										</c:if>
										<c:if test="${evalVO.evalSeq ne '' && evalVO.evalSeq != null }">
											<c:out value="${evalVO.name }"/>
										</c:if>
									</td>
									<th></th>
									<td>
									</td>
								</tr> --%>
							</tbody>
						</table>
					</div>
					<div class="mob mb20">
						<div class="mob-write">
							<dl>
								<dt><sup>*</sup>평가일자</dt>
								<dd>
									<form:input path="evalDate" id="datepicker01" class="required" title="평가일자"/>
								</dd>
							</dl>
							<dl>
								<dt>평가자</dt>
								<dd>
									<form:select path="profCode">
										<c:forEach items="${profList }" var="prof">
											<form:option value="${prof.lectTea }"><c:out value="${prof.name }"/></form:option>
										</c:forEach>
									</form:select>
								</dd>
							</dl>
							<%-- <dl>
								<dt>이름</dt>
								<dd>
									<c:if test="${evalVO.evalSeq eq '' || evalVO.evalSeq == null }">
										<input type="text" class="input-data" id="name" /> <label class="normal-btn" for="modi-pop">학생찾기</label>
									</c:if>
									<c:if test="${evalVO.evalSeq ne '' && evalVO.evalSeq != null }">
										<c:out value="${evalVO.name }"/>
									</c:if>
								</dd>
							</dl> --%>
						</div>
					</div>
					<p class="sub-title">학생 정보</p>
					<!-- table -->
					<div class="list-table-box web">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:10%;" />
								<col style="width:23%;" />
								<col style="width:10%;" />
								<col style="width:23%;" />
								<col style="width:10%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th>이름</th>
									<td id="nameTd">
										<c:out value="${evalVO.name }"/>
									</td>
									<th>학번</th>
									<td id="code">
										<c:out value="${evalVO.memberCode }"/>
									</td>
									<th>영문명</th>
									<td id="eName">
										<c:out value="${evalVO.eName }"/>
									</td>
								</tr>
								<tr>
									<th>상태</th>
									<td id="status">
										<c:out value="${evalVO.status }"/>
									</td>
									<th>급수</th>
									<td id="step">
										<c:out value="${evalVO.step }급"/>
									</td>
									<th>국적</th>
									<td id="nation">
										<c:out value="${evalVO.nation }"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="mob mb20">
						<div class="mob-write">
							<dl>
								<dt>이름</dt>
								<dd id="nameTd"><c:out value="${evalVO.name }"/></dd>
							</dl>
							<dl>
								<dt>학번</dt>
								<dd id="code"><c:out value="${evalVO.memberCode }"/></dd>
							</dl>
							<dl>
								<dt>영문명</dt>
								<dd id="eName"><c:out value="${evalVO.eName }"/></dd>
							</dl>
							<dl>
								<dt>상태</dt>
								<dd id="status"><c:out value="${evalVO.status }"/></dd>
							</dl>
							<dl>
								<dt>급수</dt>
								<dd id="step"><c:out value="${evalVO.step }급"/></dd>
							</dl>
							<dl>
								<dt>국적</dt>
								<dd id="nation"><c:out value="${evalVO.nation }"/></dd>
							</dl>
						</div>
					</div>
					<div class="mt10 txt-r mb20" style="margin-top:-10px;">
						<a href="#" class="underline" onclick="fn_pop('<c:out value="${evalVO.memberCode }"/>'); return false;">평가이력 보기</a>
					</div>
	
					<p class="sub-title">평가내용 (줄바꿈없이 공백포함 150자 미만으로 작성해주세요)</p>
					<!-- table -->
					<div class="list-table-box web">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:10%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><sup>*</sup>평가내용</th>
									<td colspan="3">
										<form:textarea path="content" class="required" title="평가내용" lang="150"/>
										<script type="text/javascript">
											var editor = CKEDITOR.replace( 'content', {
												height: 300,
												filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
											});

											CKEDITOR.config.wordcount = {
												showCharCount: true,
												showWordCount: false,
												charLimit: 150
											};
											
											editor.on('key', function(){
												var charCount = editor.getData().replace(/(<([^>]+)>)/ig, "").length;
												var charLimit = CKEDITOR.config.wordcount.charLimit;

												if(charCount > charLimit){
													var replaceTxt = editor.getData().replace(/(<([^>]+)>)/ig, "").substring(0, charLimit);
													editor.setData(replaceTxt);
													alert('평가내용은 최대 150자까지 입력하실 수 있습니다.');
												}
											});
										</script>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="mob mb20">
						<div class="mob-write">
							<dl>
								<!-- <dt><sup>*</sup>평가내용</dt>
								<dd> -->
									<form:textarea path="content" id="mbContent" class="required" title="평가내용" lang="150"/>
									<script type="text/javascript">
										var editor1 = CKEDITOR.replace( 'mbContent', {
											height: 300,
											filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
										});

										CKEDITOR.config.wordcount = {
												showCharCount: true,
												showWordCount: false,
												charLimit: 150
										};
											
										editor1.on('key', function(event){
											var charCount = editor1.getData().replace(/(<([^>]+)>)/ig, "").length;
											var charLimit = CKEDITOR.config.wordcount.charLimit;

											if(charCount > charLimit){
												var replaceTxt = editor1.getData().replace(/(<([^>]+)>)/ig, "").substring(0, charLimit);
												editor1.setData(replaceTxt);
												alert('평가내용은 최대 150자까지 입력하실 수 있습니다.');
											}
										});
									</script>
								<!-- </dd> -->
							</dl>
						</div>
					</div>
					<%-- <p class="sub-title">첨부파일</p>
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
											<input type="text" value="파일선택" class="input-data" disabled="disabled" id="fileName_0">
											<label for="upload_file_0" class="btn-upload-file">파일업로드</label>
											<input type="file" class="hidden" id="upload_file_0" name="upload_file_0" onchange="fn_file(this); return false;" readonly="readonly"/>
											<button class="white" onclick="fn_add('web'); return false;">+</button>
										</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
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
												<input type="text" value="파일선택" class="input-data" disabled="disabled" id="fileName_0" onchange="fn_file(this); return false;" readonly="readonly">
												<label for="upload_file_0" class="btn-upload-file">파일업로드</label>
												<input type="file" class="hidden" id="upload_file_0" name="upload_file_0"/>
												<button class="white" onclick="fn_add('mob'); return false;">+</button>
											</p>
										</li>
									</ul>
								</dd>
							</dl>
						</div>
					</div> --%>
					<!-- table button -->
					<div class="table-button">
						<div class="btn-box">
							<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssAppraiseList.do'/>" class="white btn-list">목록</a>
							<button type="button" class="white btn-save sem-chk" onclick="fn_save(); return false;">저장</button>
						</div>
					</div>
					<!--// table button -->
					<div id="delAtt"></div>
				</form:form>
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

</body>
</html>