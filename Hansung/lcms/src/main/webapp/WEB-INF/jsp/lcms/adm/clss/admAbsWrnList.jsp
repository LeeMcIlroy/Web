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
var seq = "";
	$(document).ready(function(){
		$("#all-chk").attr("checked",true);
		$("input[name=memberSeq]").attr("checked",true);
		
		$.ajax({
			url: "<c:url value='/qxsepmny/clss/admSelectAjaxWrn.do'/>",
			type : "post",
			data : "searchVO="+$("#frm").serialize(),
			dataType : "json",
			success: function(data){
				var resultList = data.hstrList;
				var html = "";
				for(var i=0; i<resultList.length; i++){
					html += '<tr>';
					html += '	<td>'+(resultList.length - i)+'</td>';
					html += '	<td>'+resultList[i].absYear+'</td>';
					html += '	<td>'+resultList[i].absSem+'</td>';
					html += '	<td>'+resultList[i].absDate+'</td>';
					html += '	<td>'+resultList[i].absPrs+'명</td>';
					html += '	<td>'+resultList[i].absTrgPrs+'</td>';
					html += '	<td><a class="underline" id="print" value="'+resultList[i].absSeq+'" style="cursor:pointer;">인쇄</a></td>';
					html += '	<td><a class="underline" id="delWrn" value="'+resultList[i].absSeq+'" style="cursor:pointer;">삭제</a></td>';
					html += '</tr>';
				}
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="8">등록된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				$("#absWrnList").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
		$(document).on("click","#delWrn",function(event){
			absSeq = $(this).attr('value');
			if (confirm("삭제 하시겠습니까?")) {
				$.ajax({
					url: "<c:url value='/qxsepmny/clss/deleteAdmAjaxAbsWrnDel.do'/>"
					, type: "post"
					, data: "absSeq="+absSeq
					, dataType:"json"
					, success: function(data){
						var resultList = data.hstrList;
						var html = "";
						for(var i=0; i<resultList.length; i++){
							html += '<tr>';
							html += '	<td>'+(resultList.length - i)+'</td>';
							html += '	<td>'+resultList[i].absYear+'</td>';
							html += '	<td>'+resultList[i].absSem+'</td>';
							html += '	<td>'+resultList[i].absDate+'</td>';
							html += '	<td>'+resultList[i].absPrs+'명</td>';
							html += '	<td>'+resultList[i].absTrgPrs+'</td>';
							html += '	<td><a class="underline" id="print" value="'+resultList[i].absSeq+'" style="cursor:pointer;">인쇄</a></td>';
							html += '	<td><a class="underline" id="delWrn" value="'+resultList[i].absSeq+'" style="cursor:pointer;">삭제</a></td>';
							html += '</tr>';
						}
						if(resultList.length == 0){
							html += '<tr>';
							html += '	<td colspan="8">등록된 내용이 없습니다.</td>';
							html += '</tr>';
						}
						$("#absWrnList").html(html);
					}, error: function(){
						alert("오류가 발생하였습니다.");
					}
				});
			}
		});
		$(document).on("click","#print",function(event){
			absSeq = $(this).attr('value');
			fn_print(absSeq);
		});
	});

	$(function(){
		$("#all-chk").change(function(){
			$("input[name=memberSeq]").prop("checked", $(this).prop('checked'));
		});
	});
	
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admAbsWrnList.do'/>").submit();
	}
	
	// 엑셀 다운로드
	function fn_excelDown(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/clss/admAbsWrnExcel.do'/>").submit();
	}
	//결석경고 생성
	function fn_absWrnGnr(){
		if(confirm("선택한 학생의 결석경고를 생성합니다.")){
			var rowData = new Array();
			var tdArr = new Array();
			var checkbox = $("input[name=memberSeq]:checked");
			checkbox.each(function(i) {
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				rowData.push(tr.text());
				var td1 = td.eq(1).text()+" "
				var td2 = td.eq(2).text()+" ";
				var td3 = td.eq(3).text()+" ";
				var td7 = td.eq(7).text();
				tdArr.push(td1+td2+td3+td7);
			});
			var year = $("#searchCondition1").val();
			var sem = $("#semEster").val();
			var wrnDate = $("#datepicker01").val();
			var prs = tdArr.length;
			var trgPrs = tdArr
			var lectName = $("#lectName").val();
			
			$.ajax({
				url: "<c:url value='/qxsepmny/clss/admAjaxAddWrn.do'/>",
				type : "post",
				data : "year="+year+"&sem="+sem+"&wrnDate="+wrnDate+"&prs="+prs+"&trgPrs="+trgPrs+"&lectName="+lectName,
				dataType : "json",
				success: function(data){
					var resultList = data.hstrList;
					var html = "";
					for(var i=0; i<resultList.length; i++){
						html += '<tr>';
						html += '	<td>'+(resultList.length - i)+'</td>';
						html += '	<td>'+resultList[i].absYear+'</td>';
						html += '	<td>'+resultList[i].absSem+'</td>';
						html += '	<td>'+resultList[i].absDate+'</td>';
						html += '	<td>'+resultList[i].absPrs+'명</td>';
						html += '	<td>'+resultList[i].absTrgPrs+'</td>';
						html += '	<td><a class="underline" id="print" value="'+resultList[i].absSeq+'" style="cursor:pointer;">인쇄</a></td>';
						html += '	<td><a class="underline" id="delWrn" value="'+resultList[i].absSeq+'" style="cursor:pointer;">삭제</a></td>';
						html += '</tr>';
					}
					if(resultList.length == 0){
						html += '<tr>';
						html += '	<td colspan="8">등록된 내용이 없습니다.</td>';
						html += '</tr>';
					}
					$("#absWrnList").html(html);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	//인쇄
	function fn_print(seq){
		var prtType = 'ABSWRN';
		var year = $("#searchCondition1").val();
		var seme = $("#semEster").val();
		
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admPtrAbsWrn.do?'/>prtType="+prtType+"&year="+year+"&seme="+seme+"&seq="+seq
				, '결석경고 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
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
					<jsp:param name="dept1" value="수업"/>
		            <jsp:param name="dept2" value="결석경고"/>
	           	</jsp:include>
	           	<form:form commandName="searchVO" id="frm" name="frm">
		           	<input type="hidden" name="compleSta" id="compleSta"/>
					<!-- search -->
					<div class="search-box none-option">
						<input type="checkbox" id="search-option-open" />
						<div class="search">
							<div class="search-input">
								<table class="shearch-option">
									<colgroup>
										<col style="width:8%;" />
										<col style="width:15%;" />
										<col style="width:8%;" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th>대상학기</th>
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
											<th>결석시간</th>
											<td>
												<form:select path="searchCondition3">
													<form:option value="10">10시간</form:option>
													<form:option value="20">20시간</form:option>
													<form:option value="30">30시간</form:option>
													<form:option value="40">40시간</form:option>
													<form:option value="50">50시간</form:option>
												</form:select>
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
							<strong><c:out value="${resultList.size() }"/></strong>건이 검색되었습니다.
						</div>
						<%-- <div class="paging-select">
							<c:out value="${paginationInfo.currentPageNo }"/> / <c:out value="${totalPageCount }"/>page &nbsp;&nbsp;
							<form:select path="recordCountPerPage" onchange="fn_list(1); return false;">
								<form:option value="10">10</form:option>
								<form:option value="15">15</form:option>
								<form:option value="20">20</form:option>
								<form:option value="25">25</form:option>
								<form:option value="30">30</form:option>
							</form:select>
						</div> --%>
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
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="all-chk"/></th>
									<th>급/반</th>
									<th>이름</th>
									<th>학번</th>
									<th>국적</th>
									<th>성별</th>
									<th>현재출석율(%)</th>
									<th>총결석시간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="list" varStatus="status">
									<input type="hidden" id="lectName" value="<c:out value="${list.lectName }"/>"/>
									<tr>
										<td><input type="checkbox" value="<c:out value='${list.memberSeq}'/>" name="memberSeq"/></td>
										<td><c:out value="${list.lectGrade }"/>급 <c:out value="${list.lectDivi }"/></td>
										<td><c:out value="${list.name }"/></td>
										<td><c:out value="${list.memberCode }"/></td>
										<td><c:out value="${list.nation }"/></td>
										<td><c:out value="${list.gender }"/></td>
										<td><c:out value="${list.avgAtte }"/></td>
										<td><c:out value="${list.abseCnt }"/></td>
									</tr>
								</c:forEach>
								<c:if test="${resultList.size() eq 0 }">
									<td colspan="8">검색결과가 없습니다.</td>
								</c:if>
							</tbody>
						</table>
					</div>
					<!--// table -->
	
					<!-- table button -->
					<div class="table-button">
						<div class="btn-box">
							<form:input path="searchCondition4" id="datepicker01" style="height: 27px; width: 100px; text-align: center;"/>
							<button type="button" class="white btn-newwrite" onclick="fn_absWrnGnr(); return false;">결석경고생성</button>
							<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						</div>
					</div>
					<!--// table button -->
	
					<p class="sub-title mt50">결석경고 이력</p>
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
									<th>년도</th>
									<th>학기</th>
									<th>경고일자</th>
									<th>인원수</th>
									<th>대상자</th>
									<th>경고장</th>
									<th>작업</th>
								</tr>
							</thead>
							<tbody id="absWrnList">
							</tbody>
						</table>
					</div>
					<!--// table -->
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