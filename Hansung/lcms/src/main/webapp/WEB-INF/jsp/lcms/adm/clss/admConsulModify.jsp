<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>

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
		
		$("#modi-pop").change(function(){
			html = '<tr>';
			html += '	<td colspan="6">학번 또는 이름을 검색해주세요.</td>';
			html += '</tr>';
			$("#stdBody").html(html);
		});

	});
	
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
	
	var resultList;
	
	function fn_search(){
		$.ajax({
			url: "<c:url value='/qxsepmny/cmm/admAjaxSearchStd.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '	<td>'+resultList[i].name+'</td>';
					html += '	<td>'+resultList[i].memberCode+'</td>';
					html += '	<td>'+resultList[i].eName+'</td>';
					html += '	<td>'+resultList[i].status+'</td>';
					html += '	<td>'+resultList[i].step+'급</td>';
					html += '	<td>'+resultList[i].nation+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="6">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_select(i){
		var result = resultList[i];
		
		$("#nameTd").html(result.name);
		$("#name").val(result.name);
		$("#code").html(result.memberCode);
		$("#memberCode").val(result.memberCode);
		$("#eName").html(result.eName);
		$("#status").html(result.status);
		$("#step").html(result.step+'급');
		$("#nation").html(result.nation);
		$("#mName").html(result.name);
		$("#mCode").html(result.memberCode);
		$("#mEName").html(result.eName);
		$("#mStatus").html(result.status);
		$("#mStep").html(result.step+'급');
		$("#mNation").html(result.nation);
		
		$("#modi-pop").click();
		
		resultList = null;
	}
	
	function fn_add(web){
		var cnt = $("."+web+" .file-upload").length;
		
		var html = '';
		
		html += '<p class="file-upload" id="'+web+'_'+cnt+'">';
		html += '	<input type="text" value="파일선택" class="input-data" id="fileName_'+cnt+'" readonly="readonly">';
		html += '	<label for="upload_file_'+cnt+'" class="btn-upload-file">파일업로드</label>';
		html += '	<input type="file" class="hidden" id="upload_file_'+cnt+'" name="upload_file_'+cnt+'" onchange="fn_file(this); return false;"/>';
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
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admConsulSubmit.do'/>").submit();
	}
	
	function fn_pop(){
		var memberCode = $("#memberCode").val();
		if(memberCode == ''){
			alert('학생을 선택해 주세요.');
			return;
		}
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admConsulPop.do'/>?memberCode="+memberCode, '상담이력', 'width=1050, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
</script>
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<!--// left menu -->
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="수업"/>
		            <jsp:param name="dept2" value="상담"/>
	           	</jsp:include>
				<form:form commandName="consultVO" id="frm" name="frm" enctype="multipart/form-data">
				<form:hidden path="consultSeq"/>
				<form:hidden path="memberCode"/>
				<p class="sub-title">진행 정보</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>상담일자</th>
								<td>
									<form:input path="consultDate" id="datepicker" />
								</td>
								<th>상담자</th>
								<td>
									<form:select path="profCode">
										<c:forEach items="${adminList }" var="admin">
											<form:option value="${admin.adminId }"><c:out value="${admin.name }"/></form:option>
										</c:forEach>
									</form:select>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<c:if test="${consultVO.consultSeq eq '' || consultVO.consultSeq == null }">
										<input type="text" class="input-data" id="name" readonly="readonly"/> <label class="normal-btn" for="modi-pop">학생찾기</label>
									</c:if>
									<c:if test="${consultVO.consultSeq ne '' && consultVO.consultSeq != null }">
										<c:out value="${consultVO.name }"/>
									</c:if>
								</td>
								<th>상담학기</th>
								<td>
									<form:select path="year" onchange="fn_search_seme(this);">
										<form:options items="${yearList }"/>
									</form:select>
									<form:select path="semester" id="semEster">
										<c:forEach items="${semeList }" var="seme">
											<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
										</c:forEach>
									</form:select>
								</td>
							</tr>
						</tbody>
					</table>
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
									<c:out value="${consultVO.name }"/>
								</td>
								<th>학번</th>
								<td id="code">
									<c:out value="${consultVO.memberCode }"/>
								</td>
								<th>영문명</th>
								<td id="eName">
									<c:out value="${consultVO.eName }"/>
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td id="status">
									<c:out value="${consultVO.status }"/>
								</td>
								<th>급수</th>
								<td id="step">
									<c:out value="${consultVO.step }급"/>
								</td>
								<th>국적</th>
								<td id="nation">
									<c:out value="${consultVO.nation }"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mt10 txt-r mb20" style="margin-top:-10px;">
					<a href="#" class="underline" onclick="fn_pop(); return false;">상담이력 보기</a>
				</div>
				<p class="sub-title">상담내용</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>상담구분</th>
								<td>
									<form:select path="consultType">
										<form:option value="1">출결</form:option>
										<form:option value="2">성적</form:option>
										<form:option value="3">수업</form:option>
										<form:option value="4">기타</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th>상담장소</th>
								<td colspan="3">
									<form:input path="place" class="input-data" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>상담내용</th>
								<td colspan="3">
									<form:textarea path="content"/>
									<script type="text/javascript">
										CKEDITOR.replace( 'content', {
											height: 300,
											filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
										});
									</script>
								</td>
							</tr>
						</tbody>
					</table>
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
										<input type="text" value="파일선택" class="input-data" id="fileName_0" readonly="readonly">
										<label for="upload_file_0" class="btn-upload-file">파일업로드</label>
										<input type="file" class="hidden" id="upload_file_0" name="upload_file_0" onchange="fn_file(this); return false;"/>
										<button class="white" onclick="fn_add('web'); return false;">+</button>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="delAtt"></div>
				</form:form>
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admConsulList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
					</div>
				</div>
				<!--// table button -->
			</div>
		</div>
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup">
			<p class="sub-title">신청자찾기</p>
			<div class="search-box none-option">
				<input type="checkbox" id="search-option-open" />
				<div class="search">
					<div class="search-input">
						<table class="shearch-option">
							<colgroup>
								<col style="width:8%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<input type="text" class="input-data" placeholder="학번,이름을 입력하세요" id="searchWord" />
									</td>
								</tr>
							</tbody>
						</table>
						<a href="#" onclick="fn_search(); return false;">검색하기</a>
					</div>
				</div>
			</div>
			<div class="list-table-box">
				<table class="normal-list-table">
					<colgroup>
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>이름</th>
							<th>학번</th>
							<th>영문명</th>
							<th>상태</th>
							<th>급수</th>
							<th>국적</th>
						</tr>
					</thead>
					<tbody id="stdBody">
						<tr>
							<td colspan="6">학번 또는 이름을 검색해주세요.</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="table-button">
				<div class="btn-box">
					<label for="modi-pop" class="white btn-cancel">취소</label>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->

</body>
</html>