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
		$("#all-chk").change(function(){
			$("input[name=memberCode]").prop("checked", $(this).prop('checked'));
		});
	});

	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/admstr/admProfList.do'/>").submit();
	}
	
	function fn_modify(seq){
		$("#memberSeq").val(seq);
		$("#frm").attr("action", "<c:url value='/qxsepmny/admstr/admProfModify.do'/>").submit();
	}
	
	function fn_excelDown(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/admstr/admProfExcel.do'/>").submit();
	}
	
	function fn_del(){
		if($("input[name=memberCode]:checked").length == 0){
			alert('삭제할 교사를 선택해 주세요.');
			return;
		}
		
		$.ajax({
			url: "<c:url value='/qxsepmny/admstr/admAjaxProfDel.do'/>"
			, type: "post"
			, data: $("input[name=memberCode]").serialize()
			, dataType:"json"
			, success: function(data){
				if(data.status == 'false'){
					alert('수업배정 교사로 삭제 할 수 없습니다.');
					return;
				}else{
					alert('삭제가 완료되었습니다.');
					window.location.reload();
				}
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	//팝업창
	//교사생찾기 팝업
    function searchProf(){
    	 $(".pop-bg").css("display", "block" );
    }
	//팝업창 닫기
    function fn_close(){
    	 $(".pop-bg").css("display", "none" );
    }
    
	//팝업 검색
	function fn_select(){
		var year = $("#searchCondition2").val();
		var seme = $("#semEster").val();
		$.ajax({
			url: "<c:url value='/qxsepmny/admstr/admAjaxProfSearch.do' />"
			, type: "post"
			, data: "seme="+seme+"&year="+year
			, dataType:"json"
			, success: function(data){
				var resultList = data.profList;
				var html = '';
				
				for(var i=0; i < resultList.length; i++){
					html += '<tr>';
					html += '	<td class="txt-c">'+(resultList.length - i)+'</td>';
					html += '	<td class="txt-c">'+resultList[i].memberCode+'</td>';
					html += '	<td class="txt-c">'+resultList[i].prfTPosition+'</td>';
					html += '	<td class="txt-c">'+resultList[i].name+'</td>';
					html += '	<td class="txt-c">'+resultList[i].prfSStep+'</td>';
					if(isNaN(resultList[i].step)){
						html += '	<td class="txt-c">1급</td>';
					}else{
						html += '	<td class="txt-c">'+resultList[i].step+'급</td>';
					}
					html += '	<td class="txt-c">'+resultList[i].prfSDivi+'</td>';
					html += '	<td class="txt-c">'+resultList[i].prfSPosition+'</td>';
					html += '</tr>';
				}
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td class="txt-c" colspan="8">검색된 교사가 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#searchPrfList").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_printPrf(){
		var prtType = 'PRFLIST';
		var year= $("#searchCondition2").val();
		var seme= $("#semEster").val();
		
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/prfPrtPop.do?'/>prtType="+prtType+"&year="+year+"&seme="+seme
			, '교사명단 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
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
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="교사"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
					<input type="hidden" id="memberSeq" name="memberSeq"/>
					<div class="search-box none-option">
						<input type="checkbox" id="search-option-open" />
						<div class="search">
							<div class="search-input">
								<table class="shearch-option">
									<colgroup>
										<col style="width:10%;" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th>재직상태</th>
											<td>
												<form:select path="searchCondition1">
													<form:option value="all">전체</form:option>
													<form:option value="재직">재직</form:option>
													<form:option value="퇴사">퇴사</form:option>
												</form:select>
												<form:input path="searchWord" class="input-data" placeholder="이름, 교번을 입력하세요" />
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
							<form:select path="recordCountPerPage">
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
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="all-chk"></th>
									<th>교번</th>
									<th>이름</th>
									<th>재직상태</th>
									<th>연락처</th>
									<th>임용일자</th>
									<th>퇴사일자</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr>
										<td><input type="checkbox" value="<c:out value='${result.memberCode }'/>" name="memberCode"></td>
										<td onclick="fn_modify(<c:out value='${result.memberSeq }'/>); return false;"><c:out value="${result.memberCode }"/></td>
										<td onclick="fn_modify(<c:out value='${result.memberSeq }'/>); return false;"><c:out value="${result.name }"/></td>
										<td onclick="fn_modify(<c:out value='${result.memberSeq }'/>); return false;"><c:out value="${result.status }"/></td>
										<td onclick="fn_modify(<c:out value='${result.memberSeq }'/>); return false;"><c:out value="${result.tel }"/></td>
										<td onclick="fn_modify(<c:out value='${result.memberSeq }'/>); return false;"><c:out value="${result.appDate }"/></td>
										<td onclick="fn_modify(<c:out value='${result.memberSeq }'/>); return false;"><c:out value="${result.resDate }"/></td>
									</tr>
								</c:forEach>
								<c:if test="${resultList.size() == 0 }">
									<tr>
										<td colspan="7">검색된 내용이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<!-- table button -->
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-down" onclick="searchProf();">학기별교사명단</button>
							<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
							<button type="button" class="white btn-del" onclick="fn_del(); return false;">삭제</button>
							<button type="button" class="white btn-newwrite" onclick="fn_modify(''); return false;" href="">교사등록</button>
						</div>
					</div>
					<!--// table button -->
					<!-- 팝업 -->
					<div class="pop-bg">
						<div class="pop-table">
							<!-- table -->
							<div class="list-table-box">
								<table class="normal-wmv-table">
									<colgroup>
										<col style="width:15%;" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th class="txt-l" colspan="2"><strong>학기별 교사명단</strong></th>
										</tr>
										<tr>
											<td colspan="2">
												<form:select path="searchCondition2" onchange="fn_search_seme(this);">
													<form:option value="">전체</form:option>
													<form:options items="${yearList }"/>
												</form:select>
												<form:select path="searchCondition3" id="semEster">
													<form:option value="">전체</form:option>
													<c:forEach items="${semeList }" var="seme">
														<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
													</c:forEach>
												</form:select>
												<button type="button" class="normal-btn" onclick="fn_select(); return false;">검색</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!--// table -->
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
									</colgroup>
									<thead>
										<tr>
											<th>No.</th>
											<th>교번</th>
											<th>직위</th>
											<th>아룸</th>
											<th>과목</th>
											<th>급수</th>
											<th>분반</th>
											<th>직책</th>
										</tr>
									</thead>
									<tbody>
									<tbody id="searchPrfList">
									</tbody>
								</table>
							</div>
							<!--// table -->
								<!-- table button -->
							<div class="table-button">
								<div class="btn-box">
									<button type="button" class="white btn-newwrite" onclick="fn_printPrf(); return false;">인쇄</button>
									<button type="button" class="white btn-cancel" onclick="fn_close(); return false;">닫기</button>
								</div>
							</div>
							<!--// table button -->
						</div>
					</div>
					<!-- // 팝업 -->
					<!-- paging -->
					<div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
					</div>
					<!--// paging -->
					<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>">
				</form:form>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>