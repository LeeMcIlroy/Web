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
	$(function(){
		$("#all-chk").change(function(){
			$("input[name=enterSeq]").prop("checked", $(this).prop('checked'));
		});
		
		$("#all-chk-pop").change(function(){
			$("input[name=memberCode]").prop("checked", $(this).prop('checked'));
		});
		
		$("#modi-pop2").change(function(){
			$("#searchWordPop").val('');
		});
	});
	
	function fn_modify(seq){
		$("#enterSeq").val(seq);
		$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admReregModify.do'/>").submit();
	}
	
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admReregList.do'/>").submit();
	}
	
	// 엑셀 다운로드
	function fn_excelDown(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/entran/admRegistExcel.do'/>").submit();
	}
	
	function fn_open(){
		if($("input[name=enterSeq]:checked").length == 0){
			alert('학생을 선택해 주세요.');
			return;
		}
		$("#modi-pop").prop("checked", "true");
	}
	
	function fn_step(){
		if(confirm('선택하신 학생들의 급수를 수정합니다.\r\n저장하시겠습니까?')){
			var step = $("#step").val();
			$.ajax({
				url: "<c:url value='/qxsepmny/entran/admAjaxSaveStep.do'/>"
				, type: "post"
				, data: "step="+step+"&"+$("input[name=enterSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					$("#modi-pop").click();
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	function fn_regbat(){
		var searchYear = $("#searchCondition1").val();
		var searchSeme = $("#semEster").val();
		var searchType = $("#searchTypePop").val();
		var searchWord = $("#searchWordPop").val();
		$.ajax({
			url: "<c:url value='/qxsepmny/entran/admAjaxSelectStdList.do'/>"
			, type: "post"
			, data: "searchType="+searchType+"&searchWord="+searchWord
			, dataType:"json"
			, success: function(data){
				var resultList = data.resultList;
				var html = '';
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr>';
					html += '	<td><input type="checkbox" name="memberCode" value="'+resultList[i].memberCode+'"/></td>';
					html += '	<td>'+resultList[i].memberCode+'</td>';
					html += '	<td>'+resultList[i].name+'</td>';
					html += '	<td>'+resultList[i].eName+'</td>';
					html += '	<td>'+resultList[i].status+'</td>';
					html += '	<td>'+resultList[i].step+'급</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td class="txt-c" colspan="6">';
					html += '		검색된 학생이 없습니다.';
					html += '	</td>';
					html += '</tr>';
				}
				
				$("#stdList").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_bat(){
		if($("input[name=memberCode]:checked").length == 0){
			alert('학생을 선택해 주세요.');
			return;
		}
		var enterDate = $("#reregpicker").val();
		if(confirm('저장하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/qxsepmny/entran/admAjaxSaveRereg.do'/>"
				, type: "post"
				, data: "enterDate="+enterDate+"&"+$("input[name=memberCode]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
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
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
					<input type="hidden" id="enterSeq" name="enterSeq"/>
					<input type="hidden" id="enterStatus" name="enterStatus"/>
				
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search">
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:8%;" />
									<col style="width:14%;" />
									<col style="width:8%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>접수학기</th>
										<td>
											<form:select path="searchCondition1" onchange="fn_search_seme(this);">
												<form:options items="${yearList }"/>
											</form:select>
											<form:select path="searchCondition2" id="semEster">
												<c:forEach items="${semeList }" var="seme">
													<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
												</c:forEach>
											</form:select>
										</td>
										<th>직전학기</th>
										<td>
											<form:select path="searchCondition3">
												<form:option value="">등급</form:option>
												<c:forEach begin="1" end="6" var="num">
													<form:option value="${num }"><c:out value="${num }급"/></form:option>
												</c:forEach>
											</form:select>
											<form:select path="searchCondition4">
												<form:option value="">수료여부</form:option>
												<form:option value="수료">수료</form:option>
												<form:option value="유급">유급</form:option>
											</form:select>
											<form:input path="searchWord" class="input-data" placeholder="학번,이름,국적을 입력하세요" />
										</td>
									</tr>
								</tbody>
							</table>

							<a href="#" onclick="fn_list(1); return false;">검색하기</a>
						</div>
					</div>
				</div>
				<!--// search -->

				<!--search info-->
				<div class="search-infomation">
								<div class="search-count">
									<strong><c:out value="${paginationInfo.totalRecordCount }"/></strong>건이 검색되었습니다.
								</div>
								<div class="paging-select">
									<c:out value="${paginationInfo.currentPageNo }"/> / <c:out value="${totalPageCount }"/>page &nbsp;&nbsp;
									<form:select path="recordCountPerPage" onchange="fn_list(1); return false;">
										<form:option value="10">10</form:option>
										<form:option value="15">15</form:option>
										<form:option value="20">20</form:option>
										<form:option value="25">25</form:option>
										<form:option value="30">30</form:option>
									</form:select>
								</div>
							</div>
				<!--// search info-->
	
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:5%;" />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="all-chk"/></th>
								<th>접수번호</th>
								<th>학번</th>
								<th>이름</th>
								<th>국적</th>
								<th>생년월일</th>
								<th>학생구분</th>
								<th>신청구분</th>
								<th>직전학기<br/>수료여부</th>
								<th>재등록<br/>확정등급</th>
								<th>첨부</th>
								<th>접수일자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>
								<td><input type="checkbox" name="enterSeq" value="<c:out value='${result.enterSeq }'/>"/></td>
								<td><a href="#" class="underline imgSelect"><c:out value="${result.enterNum }"/></a></td>
								<td><a href="#" class="underline" onclick="fn_modify('<c:out value='${result.enterSeq }'/>'); return false;"><c:out value="${result.enterCode }"/></a></td>
								<td><a href="#" class="underline" onclick="fn_modify('<c:out value='${result.enterSeq }'/>'); return false;"><c:out value="${result.enterName }"/></a></td>
								<td><c:out value="${result.enterNation }"/></td>
								<td><c:out value="${result.enterBirth }"/></td>
								<td><c:out value="${result.enterStdType }"/></td>
								<td><c:out value="${result.enterType }"/></td>
								<td>
									<c:if test="${result.compleSta eq '미산정' || result.compleSta eq '유급' }"><span class="txt-red"></c:if>
										<c:out value="${result.compleSta }"/>
									<c:if test="${result.compleSta eq '미산정' || result.compleSta eq '유급' }"></span></c:if>
								</td>
								<td><c:out value="${result.enterRegrade }"/></td>
								<td>
							    <c:if test="${result.filecount > 0}">
									<a href="#"><span class="icon-download-file">첨부파일</span></a>
								</c:if>
								</td>
								<td><c:out value="${result.enterDate }"/></td>
							</tr>
							</c:forEach>
							<c:if test="${resultList.size() == 0}">
								<tr>
									<td colspan="12">
										검색된 내용이 없습니다.
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<label class="white btn-newwrite" for="modi-pop2" onclick="fn_regbat();">일괄등록</label>
						<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						<button type="button" class="white btn-type01" onclick="fn_open(); return false;">급수일괄수정</button>
						<a class="white btn-type06" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/entran/admReregModify.do'/>">재등록</a>
					</div>
				</div> 
				<!--// table button -->
				<!-- paging -->
				<div class="paging_wrap">
								<div class="paging">
									<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
									<form:hidden path="pageIndex" />
								</div>
							</div>
				<!--// paging -->
				<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
				</form:form>
			</div>
		</div>
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:250px; height:170px; top:60%; left:56%;">
			<p class="sub-title" id="popTit">급수 선택</p>
			<div class="search-box none-option">
				<input type="checkbox" id="search-option-open" />
				<div class="search">
					<div class="search-input">
						<table class="shearch-option">
							<colgroup>
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<select id="step" name="step" style="width:90%;">
											<option value="1">1급</option>
											<option value="2">2급</option>
											<option value="3">3급</option>
											<option value="4">4급</option>
											<option value="5">5급</option>
											<option value="6">6급</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="table-button">
				<div class="btn-box">
					<button type="button" class="white btn-save" onclick="fn_step(); return false;">저장</button>
					<label for="modi-pop" class="white btn-cancel">취소</label>
				</div>
			</div>
		</div>
		<input type="checkbox" id="modi-pop2" class="hidden" />
		<div class="black-pop2">&nbsp;</div>
		<div class="modi-popup2" style="width:800px; height:800px; top:45%; left:45%;">
			<p class="sub-title" id="popTit">학생찾기</p>
			<div class="search-box none-option">
				<div class="pop-table">
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<select id="searchTypePop" name="searchTypePop">
											<option value="name">이름</option>
											<option value="code">학번</option>
										</select>
										<input type="text" class="input-data w173px" name="searchWordPop" id="searchWordPop"/>
										<button type="button" class="normal-btn" onclick="fn_regbat(); return false;">검색</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="list-table-box">
							<table class="normal-list-table">
								<colgroup>
									<col style="width:5%;">
									<col>
									<col>
									<col>
									<col>
									<col>
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="all-chk-pop"></th>
										<th>학번</th>
										<th>이름</th>
										<th>영문이름</th>
										<th>상태</th>
										<th>현재단계</th>
									</tr>
								</thead>
								<tbody id="stdList">
									<tr>
										<td class="txt-c" colspan="6">
											검색된 학생이 없습니다.
										</td>
									</tr>
								</tbody>
							</table>
						</div>
				</div>
			</div>
			<div class="table-button">
				<div class="btn-box">
					접수일자 : <input id="reregpicker" class="input-data w100px" style="height:25px;" placeholder="0000-00-00" type="text" readonly="readonly">
					<button type="button" class="white btn-save" onclick="fn_bat(); return false;">저장</button>
					<label for="modi-pop2" class="white btn-cancel">닫기</label>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
</body>
</html>