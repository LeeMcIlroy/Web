<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">

	$(function(){
		$("#searchWord").keydown(function(e){
			if(e.keyCode == 13){
				fn_search('RERE');
			}
		});
	});
	
	var resultList;
	 
	function fn_search(type){ 
		$("#searchType").val(type);
		
		$.ajax({
			url: "<c:url value='/qxsepmny/entran/admAjaxSearchStdRegiList.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '	<td>'+resultList[i].memberCode+'</td>';
					html += '	<td>'+resultList[i].name+'</td>';
					html += '	<td>'+resultList[i].status+'</td>';
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
	
/*  	function fn_search(type){
		$("#searchType").val(type);
		
		$.ajax({
			url: "<c:url value='/qxsepmny/entran/admAjaxSearchStdRegiList.do'/>"
			, type: "post"
			, data: $("#searchFrm").serialize()
			, dataType: "json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i = 0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '    <td>'+resultList[i].enterNum+'</td>';
					html += '    <td>'+resultList[i].enterCode+'</td>';
					html += '    <td>'+resultList[i].enterName+'</td>';
					html += '</tr>';
					
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '<td colspan="3">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				$("#stdBody").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}  */
	
	function fn_select(i){ 
		var result = resultList[i];
		
		/* $("#name").val(result.enterName);
		$("#nation").html(result.nation);
		$("#datepicker03").val(result.enterBirth);
		$("#stdType").val(result.enterStdType);
		$("#tel").val(result.enterTel);
		$("#Email").val(result.enterEmail);
		$("#nation").val(result.enterNation); */
 		
		$("#name").val(result.name);
		$("#enterCode").val(result.memberCode);
		$("#nation").val(result.nation);
		$("#gender").html(result.gender);
		$("#datepicker03").val(result.birth);
		$("#stdType").val(result.stdType);
		$("#tel").val(result.tel);
		$("#email").val(result.email);
 
		$("#modi-pop").click();
		
		$("#modi-popup").load(location.href + " #modi-popup>*","");
	}
		 	

	function fn_update(){
		if(fn_validate("frm")){
			$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admReregUpdate.do'/>").submit();
		}
	}
	
	/* function fn_list(){
		$("#listFrm").attr("action", "<c:url value='/qxsepmny/entran/admReregList.do'/>").submit();
	} */

	
	$(function(){
		$("#upload_file").change(function(){
			if(fileCheck_adm('upload_file')){
				var fileValue = $('#upload_file').val().split("\\");
				var fileName = fileValue[fileValue.length-1];
				var extension = fileName.split(".")[1].toUpperCase();
			
		 		/* if(extension != 'JPG'){
					alert('JPG만이 첨부 가능합니다');
					$('#upload_file').val('');
					return;
				} */
		 		
				$("#fileName").val(fileName);
			}else{
				$('#upload_file').val('');
				$("#fileName").val('파일선택');
			}
		});
		
		
	});

	function fn_del(){
		if(confirm("해당 학생의 재등록을 취소하시겠습니까?")){
			$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admReregDel.do'/>").submit();
		}
	}

</script>
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="입학"/>
		            <jsp:param name="dept2" value="재등록"/>
	           	</jsp:include>
	           	<form:form commandName="enterVO" id="frm" name="frm" enctype="multipart/form-data">
				<form:hidden path="enterSeq"/>
				<form:hidden path="enterCode"/>
				<p class="sub-title">접수 정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:150px;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>학기</th>
								<td>
									<form:select path="enterYear" class="required select-one" title="년도" onchange="fn_search_seme(this);">
										<form:options items="${yearList }"/>
									</form:select>
									<form:select path="enterSeme" class="required select-one" title="학기" id="semEster">
										<c:forEach items="${semeList }" var="seme">
											<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
										</c:forEach>
									</form:select>
								
							<c:if test="${enterVO.enterSeq ne '' && enterVO.enterSeq != null }">
							<tr>
								<th>접수번호</th>
								<td>
									<c:out value="${enterVO.enterNum }"/>
								</td>
							</tr>
							</c:if>
							<tr>
								<th><sup>*</sup>접수일자</th>
								<td>
									<form:input path="enterDate" id="datepicker01" class="required select-one" title="접수일자" placeholder="0000-00-00" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>재등록등급</th>
								<td>
									<form:select path="enterRegrade" class="required select-one" title="재등록등급">
										<form:option value="">선택</form:option>
										<form:option value="1">1</form:option>
										<form:option value="2">2</form:option>
										<form:option value="3">3</form:option>
										<form:option value="4">4</form:option>
										<form:option value="5">5</form:option>
										<form:option value="6">6</form:option>
									</form:select>
								</td>
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
							<col style="width:150px;" />
							<col />
							<col style="width:150px;" />
							<col />
						</colgroup>
						<tbody>
														
							<tr>
								<th><sup>*</sup>이름</th>
								<td colspan="3">
								<!-- <input type="text" class="input-data" id="name" placeholder="" readonly="readonly"/> -->
								 	<form:input path="enterName" id="name" class="input-data required" title="이름" readonly="readonly"/>
									<label for="modi-pop" class="normal-btn">학생찾기</label>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>국적</th>
								<td>
									
									<form:input path="enterNation" id="nation" class="input-data required" title="국적" readonly="readonly"/>
								</td>
								<th>성별</th>
								<td id="gender"></td>
							</tr>
							<tr>
							
								<th><sup>*</sup>생년월일</th>
								<td>
									<form:input id="datepicker03" path="enterBirth" class="required" title="생년월일" placeholder="0000-00-00" type="text" value=""/>
									
								</td>
								<th><sup>*</sup>학생구분</th>
								<td>
									<form:select path="enterStdType" id="stdType" class="required select-one" title="학생구분">
											<form:option value="1">교환학생</form:option>
											<form:option value="2">어학연수생</form:option>
											<form:option value="3">학부(유학생)</form:option>
											<form:option value="4">대학원(유학생)</form:option>
									</form:select> 
								
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>연락처</th>
								<td>
									<form:input path="enterTel" id="tel" class="input-data required" title="연락처" placeholder=""  readonly="readonly"/>
								</td>
								<th>이메일</th>
								<td colspan="3">
									<form:input path="enterEmail" id="email" class="input-data" placeholder=""  readonly="readonly"/>
								
								</td> 
							</tr>
							<tr>
								<th>첨부파일</th>
								<td colspan="3"><input type="text" value="파일선택"
									class="input-data" id="fileName" disabled="disabled">
									<label for="upload_file" class="btn-upload-file">파일업로드</label>
									<input type="file" class="hidden" id="upload_file" name="upload_file" /> 
									<c:if test="${attachList != null }">
										<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attachList[0].attachSeq }&type=${attachList[0].boardType }'/>">
										<c:out value="${attachList[0].orgFileName }" /></a>
										<input type="hidden" id="deleteFile" name="deleteFile" value="<c:out value='${attachList[0].attachSeq }'/>" />
									</c:if>
								</td>
								</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<%-- <p class="sub-title">수료이력</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:150px;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th></th>
								<td>
									<ul class="nomal-list">
									<c:forEach items="${recoList }" var="recode">
										<li>
										<c:out value="${recode.enterYear}"/><c:out value="${recode.enterSeme}"/>-<c:out value="${recode.enterSemeNm }"/> <c:out value="${recode.enterRegrade }"/>급 
										</li>
									</c:forEach>
									<li>20181-봄학기 1급 출석 180/200(90%) 90점 수료</li>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
				</div> --%>
				<!--// table -->
				<div class="table-button">
					<div class="btn-box">
						<!-- <button type="button" class="white btn-list" onclick="fn_list(); return false;">목록</button>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/entran/admReregList.do'/>" class="white btn-list">목록</a> -->
						<button type="button" class="white btn-del" onclick="fn_del(); return false;">재등록 취소</button>
						<a href="javascript:history.back();" type="button" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_update(); return false;">저장</button>
					</div>
				</div>
			</form:form>
			</div>
		</div>
		
		<!-- 팝업 -->
		<form:form commandName="searchVO" id="searchFrm" name="searchFrm">
			<form:hidden path="searchType"/>
			<input type="checkbox" id="modi-pop" class="hidden" />
			<div class="black-pop">&nbsp;</div>
			<div class="modi-popup" id="modi-popup">
				<p class="sub-title">학생찾기</p>
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
							<!-- <a href="#" onclick="fn_search(); return false;">검색하기</a> -->
							<a href="#" onclick="fn_search('RERE'); return false;">검색하기</a>
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
							<th>학번</th>
							<th>이름</th>
							<th>상태</th>
							
							<!-- <th>영문명</th>
							<th>상태</th>
							<th>급수</th>
							<th>국적</th> -->
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
		</form:form>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
    <input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	<!--// footer -->
	<form:form commandName="searchVO" id="listFrm" name="listFrm">
		<form:hidden path="searchCondition1"/>
		<form:hidden path="searchCondition2"/>
		<form:hidden path="recordCountPerPage"/>
	</form:form>
</body>
</html>