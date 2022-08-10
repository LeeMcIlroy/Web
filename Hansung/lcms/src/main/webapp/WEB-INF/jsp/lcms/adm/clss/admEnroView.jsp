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
		$("#stdSearch").keydown(function(e){
			if(e.keyCode == 13){
				fn_select();
			}
		});
	});

	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listFrm").attr("action", "<c:url value='/qxsepmny/clss/admEnroView.do'/>").submit();
	}
	
	function fn_select(){
		$.ajax({
			url: "<c:url value='/qxsepmny/clss/admAjaxStdList.do'/>"
			, type: "post"
			, data: $("#frm").serialize()
			, dataType:"json"
			, success: function(data){
				var resultList = data.resultList;
				var html = '';
				
				for(var i=0; i < resultList.length; i++){
					html += '<tr>';
					html += '	<td class="txt-c"><input type="checkbox" value="'+resultList[i].memberCode+'" name="memberCode"/></td>';
					html += '	<td class="txt-c"><p class="underline">'+resultList[i].memberCode+'</p></td>';
					html += '	<td class="txt-c">'+resultList[i].name+'</td>';
					html += '	<td class="txt-c">'+resultList[i].eName+'</td>';
					html += '	<td class="txt-c">'+resultList[i].tel+'</td>';
					html += '	<td class="txt-c">'+resultList[i].step+'급</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td class="txt-c" colspan="6">검색된 학생이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdList").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_save(seq){
		if(confirm('선택한 학생으로 수강신청을 진행 합니다.')){
			$.ajax({
				url: "<c:url value='/qxsepmny/clss/admAjaxStdMapSave.do'/>"
				, type: "post"
				, data: "lectSeq="+seq+"&"+$("input[name=memberCode]:checked").serialize()
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
	
	function fn_del(){
		if($("input[name=mapSeq]:checked").length == 0){
			alert('학생을 선택해 주세요.');
			return;
		}
		
		if(confirm('선택한 대상자의 수강신청을 취소합니다.')){
			$.ajax({
				url: "<c:url value='/qxsepmny/clss/admAjaxStdMapDel.do'/>"
				, type: "post"
				, data: $("input[name=mapSeq]:checked").serialize()
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
	
	$(function(){
		$("#checkAll").click(function(){
			$("input[name=memberCode]").prop("checked",$("#checkAll").prop("checked")); 
		});
		
		$("#chk-all").click(function(){
			$("input[name=mapSeq]").prop("checked",$("#chk-all").prop("checked")); 
		});
	});
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
		            <jsp:param name="dept2" value="수강신청"/>
	           	</jsp:include>
				<p class="sub-title">강의정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col style="width:40%;" />
						</colgroup>
						<tbody>
							<tr>
								<th>과목명</th>
								<td>
									<c:out value="${lectureVO.lectName }"/>
								</td>
								<th>분반</th>
								<td>
									<c:out value="${lectureVO.lectDivi }"/>
								</td>
							</tr>
							<tr>
								<th>담임</th>
								<td>
									<c:out value="${lectureVO.lectClaTeaNm }"/>(<c:out value="${lectureVO.lectClaTea }"/>)
								</td>
								<th>교사</th>
								<td>
									<c:out value="${lectureVO.lectTeaCon }"/>
								</td>
							</tr>
							<tr>
								<th>강의실</th>
								<td>
									<c:out value="${lectureVO.lectClassroom }"/>
								</td>
								<th>개설여부</th>
								<td>
									<c:out value="${lectureVO.lectState eq 'Y'?'개강':'폐강' }"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<label for="write-popup" class="white btn-save">수강신청작업</label>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admEnroList.do'/>" class="white btn-list">목록</a>
					</div>
				</div>
				<!-- 수강신청작업 팝업 -->
				<input type="checkbox" id="write-popup" />
				<div class="pop-bg">
					<div class="pop-table">
						<form id="frm" name="frm" method="post" onsubmit="return false;">
							<input type="hidden" name="menuType" value="<c:out value="${lectureVO.lectSeq }"/>"/>
							<!-- table -->
							<div class="list-table-box">
								<table class="normal-wmv-table">
									<colgroup>
										<col style="width:15%;" />
										<col style="width:35%;" />
										<col style="width:15%;" />
										<col style="width:35%;" />
									</colgroup>
									<tbody>
										<tr>
											<th>과목명</th>
											<td><c:out value="${lectureVO.lectName }"/></td>
											<th>분반</th>
											<td><c:out value="${lectureVO.lectDivi }"/></td>
										</tr>
										<tr>
											<td colspan="3">
												급수
												<select name="searchCondition1">
													<option value="1">1급</option>
													<option value="2">2급</option>
													<option value="3">3급</option>
													<option value="4">4급</option>
													<option value="5">5급</option>
													<option value="6">6급</option>
												</select>&nbsp;
												<select name="searchType">
													<option value="name">이름</option>
													<option value="code">학번</option>
												</select>
												<input type="text" class="input-data w173px" name="searchWord" id="stdSearch"/>
												<button type="button" class="normal-btn" onclick="fn_select(); return false;">검색</button>
											</td>
											<td>
												<div class="table-button">
													<div class="btn-box txt-c">
														<button type="button" class="white btn-write" onclick="fn_save('<c:out value="${lectureVO.lectSeq }"/>'); return false;" >수강등록</button>
													</div>
												</div>
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
									</colgroup>
									<thead>
										<tr>
											<th><input type="checkbox" id="checkAll"/></th>
											<th>학번</th>
											<th>이름</th>
											<th>영문이름</th>
											<th>연락처</th>
											<th>급수</th>
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
						<!--// table -->
						</form>
						<!-- table button -->
						<div class="table-button">
							<div class="btn-box">
								<label for="write-popup" class="white btn-cancel">닫기</label>
								<!-- <button type="button" class="white btn-newwrite">선택</button> -->
							</div>
						</div>
						<!--// table button -->
					</div>
				</div>
				<!-- // 수강신청작업 팝업 -->
				<p class="sub-title">수강생현황</p>
				<form:form commandName="searchVO" id="listFrm" name="listFrm">
				<input type="hidden" name="lectSeq" value="<c:out value="${lectureVO.lectSeq }"/>"/>
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
							<col style="width:5%;" />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="chk-all"/></th>
								<th>No.</th>
								<th>학번</th>
								<th>이름</th>
								<th>영문이름</th>
								<th>연락처</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><input type="checkbox" name="mapSeq" value="<c:out value='${result.mapSeq }'/>"/></td>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td><c:out value="${result.memberCode }"/></td>
									<td><c:out value="${result.name }"/></td>
									<td><c:out value="${result.eName }"/></td>
									<td><c:out value="${result.tel }"/></td>
								</tr>
							</c:forEach>
							<c:if test="${resultList.size() == 0 }">
								<tr>
									<td colspan="6">수강생이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-del" onclick="fn_del();">수강신청취소</button>
					</div>
				</div>
				<!-- paging -->
				<div class="paging_wrap">
					<div class="paging">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
						<form:hidden path="pageIndex" />
					</div>
				</div>
				<!--// paging -->
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