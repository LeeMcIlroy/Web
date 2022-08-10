<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>
	$(function() {
		$("#upload_file").change(function() {
			if (fileCheck_adm('upload_file')) {
				var fileValue = $('#upload_file').val().split("\\");
				var fileName = fileValue[fileValue.length - 1];
				var extension = fileName.split(".")[1].toUpperCase();

				/* if(extension != 'JPG'){
				alert('JPG만이 첨부 가능합니다');
				$('#upload_file').val('');
				return;
				} */

				$("#fileName").val(fileName);
			} else {
				$('#upload_file').val('');
				$("#fileName").val('파일선택');
			}
		});

		$("#enterNation").change(function() {
			$("#addNation").addClass('dpn');
			$("#newNation").val('');
		});
	});
	function fn_list() {
		$("#listFrm").attr("action", "<c:url value='/qxsepmny/entran/admEntranList.do'/>").submit();
	}

	function fn_update() {
		if(fn_validate("frm")){
			$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admEntranUpdate.do'/>").submit();
		}
	}
	function fn_delete() {
		if(fn_validate("frm")){
			$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admEntranDelete.do'/>").submit();
		}
	}

	function fn_addNation() {
		$("#addNation").removeClass('dpn');
		$("#enterNation").val('');
	}

	function fn_save_nation() {
		var newNation = $("#newNation").val();

		if (newNation != '') {
			$.ajax({
				url : "<c:url value='/qxsepmny/entran/admAjaxNationUpdate.do'/>",
				type : "post",
				data : "newNation=" + newNation,
				dataType : "json",
				success : function(data) {
					var nationList = data.nationList;
					var html = '<option value="">선택</option>';
					for (var i = 0; i < nationList.length; i++) {
						html += '<option value="'+nationList[i].name+'">'+nationList[i].name+'</option>';
					}
					$("#enterNation").html(html);
					$("#addNation").addClass('dpn');
					$("#newNation").val('');
				},
				error : function() {
					alert("오류가 발생하였습니다.");
				}
			});
		} else {
			alert('추가하실 국적을 입력해 주세요.');
		}
	}
	
	var resultList;
	
	function fn_search(){
		$.ajax({
			url: "<c:url value='/qxsepmny/regist/admAjaxSearchStdList.do'/>"
			, type: "post"
			, data: $("#searchFrm").serialize()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '	<td>'+resultList[i].enterNum+'</td>';
					html += '	<td>'+resultList[i].memberCode+'</td>';
					html += '	<td>'+resultList[i].enterName+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="3">검색된 내용이 없습니다.</td>';
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
		
		var birth = result.enterBirth.split('-');
		
		$("#enterName").val(result.enterName);
		$("#enterNation").val(result.enterNation);
		$("#enterBtYear").val(birth[0]);
		$("#enterBtMonth").val(birth[1]);
		$("#enterBtDay").val(birth[2]);
		$("#enterStdType").val(result.enterStdType);
		$("#enterTel").val(result.enterTel);
		$("#enterEmail").val(result.enterEmail);
		$("#enterEName").val(result.enterEName);
		
		var gender = result.enterGender;
		
		if(gneder == '여'){
			$("#enterGender2").attr('checked','checked');
		}else{
			$("#enterGender2").attr('checked','checked');
		}
		
		$("#modi-pop").click();
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="입학" />
					<jsp:param name="dept2" value="신입학" />
				</jsp:include>
				<form:form commandName="enterVO" id="frm" name="frm" enctype="multipart/form-data">
					<form:hidden path="enterSeq" />
					<form:hidden path="enterType" value="1"/>
					<p class="sub-title">접수 정보</p>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width: 150px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><sup>*</sup>학기</th>
									<td>
										<form:select path="enterYear" onchange="fn_search_seme(this);" class="required select-one" title="년도">
											<form:options items="${yearList }"/>
										</form:select>
										<form:select path="enterSeme" id="semEster" class="required select-one" title="학기">
											<c:forEach items="${semeList }" var="seme">
												<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
											</c:forEach>
										</form:select>
									</td>
								</tr>
								<c:if
									test="${enterVO.enterSeq ne '' && enterVO.enterSeq != null }">
									<tr>
										<th>접수번호</th>
										<td><c:out value="${enterVO.enterNum }" /></td>
									</tr>
								</c:if>
								<tr>
									<th><sup>*</sup>접수일자</th>
									<td><form:input path="enterDate" id="datepicker01" placeholder="0000-00-00" class="required" title="접수일자"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<p class="sub-title">신청자정보</p>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width: 150px;" />
								<col />
								<col style="width: 150px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><sup>*</sup>이름(한글)</th>
									<td>
										<form:input path="enterName" class="input-data required" title="이름" placeholder="" />
										<label for="modi-pop" class="normal-btn">신청자 찾기</label>
									</td>
									<th>학번</th>
									<td>
										<form:input path="enterCode" class="input-data" placeholder="" />
										<form:hidden path="useYn" value="${enterVO.useYn }" />
									</td>
								</tr>
								<tr>
									<th>이름(영문)</th>
									<td>
										<form:input path="enterEName" class="input-data" placeholder="" />
									</td>
									<th>성별</th>
									<td>
										<form:radiobutton path="enterGender" value="남" label=" 남"/>&nbsp;
										<form:radiobutton path="enterGender" value="여" label=" 여"/>
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>국적</th>
									<td colspan="3">
										<form:select path="enterNation" class="required select-one" title="국적">
											<form:option value="">선택</form:option>
											<c:forEach var="result" items="${nationList}">
												<form:option value="${result.name}"><c:out value="${result.name}"/></form:option>
											</c:forEach>
										</form:select>
										<button class="normal-btn" onclick="fn_addNation(); return false;">추가</button>&nbsp;&nbsp;&nbsp;
										<label class="dpn" id="addNation">
											<input type="text" class="input-data" id="newNation" name="newNation" placeholder="" />
											<button class="normal-btn" onclick="fn_save_nation(); return false;">저장</button>
										</label>
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>생년월일</th>
									<td>
										<form:select path="enterBtYear" class="required select-one" title="생년월일">
											<form:option value="">년도</form:option>
											<c:set var="now" value="<%=new java.util.Date()%>" />
											<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/> 
											<c:forEach begin="0" end="70" var="result" step="1">
												<form:option value="${yearStart - result}"><c:out value="${yearStart - result}" /></form:option>
											</c:forEach>
										</form:select>&nbsp;년&nbsp;&nbsp;
										<form:select path="enterBtMonth" class="required select-one" title="생년월일">
											<form:option value="">월</form:option>
											<c:forEach begin="1" end="12" var="month" step="1">
												<fmt:formatNumber minIntegerDigits="2" value="${month }" var="month"/>
												<form:option value="${month }"><c:out value="${month }"/></form:option>
											</c:forEach>
										</form:select>&nbsp;월&nbsp;&nbsp;
										<form:select path="enterBtDay" class="required select-one" title="생년월일">
											<form:option value="">일</form:option>
											<c:forEach begin="1" end="31" var="day" step="1">
												<fmt:formatNumber minIntegerDigits="2" value="${day }" var="day"/>
												<form:option value="${day }"><c:out value="${day }"/></form:option>
											</c:forEach>
										</form:select>&nbsp;일
									</td>
									<th><sup>*</sup>학생구분</th>
									<td>
										<form:select path="enterStdType" class="required select-one" title="학생구분">
											<form:option value="2">어학연수생</form:option>
											<form:option value="1">교환학생</form:option>
											<form:option value="3">학부(유학생)</form:option>
											<form:option value="4">대학원(유학생)</form:option>
										</form:select>
									</td>
								</tr>
								<tr>
									<th>본국전화번호</th>
									<td>
										<!--<form:input path="enterTel" class="input-data phone required" title="연락처" placeholder="" />-->
										<form:input path="enterTel" class="input-data phone" title="연락처" placeholder="" />
										
									</td>
									<th>이메일</th>
									<td>
										<form:input path="enterEmail" class="input-data email" placeholder="" />
									</td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td colspan="1">
										<input type="text" value="파일선택" class="input-data" id="fileName" disabled="disabled"/>
										<label for="upload_file" class="btn-upload-file">파일업로드</label>
										<input type="file" class="hidden" id="upload_file" name="upload_file" />
										<c:if test="${attachList != null }">
											<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attachList[0].attachSeq }&type=${attachList[0].boardType }'/>">
												<c:out value="${attachList[0].orgFileName }" />
											</a>
											<input type="hidden" id="deleteFile" name="deleteFile" value="<c:out value='${attachList[0].attachSeq }'/>" />
										</c:if>
									</td>
									<th>비고</th>
									<td>
										<form:input path="enterRemk" class="input-data remark" title="비고" placeholder="" />
									
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<p class="sub-title <c:out value='${recoList != null?"":"dpn" }'/>">신청이력</p>
					<div class="list-table-box <c:out value='${recoList != null?"":"dpn" }'/>">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width: 150px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th></th>
									<td>
										<ul class="nomal-list">
											<c:forEach items="${recoList }" var="recode">
												<li>
													<c:out value="${recode.enterYear }" /><c:out value="${recode.enterSeme }" />-
													<c:out value="${recode.enterSemeNm }" /> 
													<c:out value="${recode.enterStatus }" /> / 
													<c:out value="${recode.enterEtc }" /></li>
											</c:forEach>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<c:if test="${enterVO.enterSeq ne '' and enterVO.enterSeq != null }">
						<p class="sub-title">입학연기</p>
						<!-- table -->
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width: 150px;" />
									<col />
									<col style="width: 150px;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>입학연기</th>
										<td>
											<form:checkbox path="delayYn" value="Y"/>&nbsp;(체크하면 입학연기로 처리됩니다.)
										</td>
										<th>연기신청일자</th>
										<td>
											<form:input path="delayDate" id="datepicker02" placeholder="0000-00-00" title="연기신청일자"/>
										</td>
									</tr>
									<tr>
										<th>입학연기</th>
										<td colspan="3">
											<form:input path="delayEtc" class="input-data"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</c:if>
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-list" onclick="fn_list(); return false;">목록</button>
							<button type="button" class="white btn-save" onclick="fn_update(); return false;">저장</button>
							<c:if test="${enterVO.enterStatus eq '3' }">
							<button type="button" class="white btn-save" onclick="fn_delete(); return false;">삭제</button>
							</c:if>
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<!-- 팝업 -->
		<form:form commandName="searchVO" id="searchFrm" name="searchFrm">
			<form:hidden path="searchType" value="ENTR"/>
			<input type="checkbox" id="modi-pop" class="hidden" />
			<div class="black-pop">&nbsp;</div>
			<div class="modi-popup">
				<p class="sub-title" id="popTit">신청자찾기</p>
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
											<form:input path="searchWord" class="input-data" placeholder="학번,이름을 입력하세요" />
										</td>
									</tr>
								</tbody>
							</table>
							<a href="#" onclick="fn_search('ENTR'); return false;">검색하기</a>
						</div>
					</div>
				</div>
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:150px;" />
							<col style="width:150px;" />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>접수번호</th>
								<th>학번</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody id="stdBody">
							<tr>
								<td colspan="3">학번 또는 이름을 검색해주세요.</td>
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
		</form:form>
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
	<form:form commandName="searchVO" id="listFrm" name="listFrm">
		<form:hidden path="searchCondition1" />
		<form:hidden path="searchCondition2" />
		<form:hidden path="recordCountPerPage" />
	</form:form>
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
</body>
</html>