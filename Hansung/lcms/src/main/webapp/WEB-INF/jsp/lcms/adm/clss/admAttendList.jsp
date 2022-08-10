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
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admAttendList.do'/>").submit();
	}
	
	function fn_etc(lectSeq, attDate, memberCode, name){
		$.ajax({
			url: "<c:url value='/qxsepmny/clss/admAjaxAtteEtc.do'/>"
			, type: "post"
			, data: "lectSeq="+lectSeq+"&attDate="+attDate+"&memberCode="+memberCode
			, dataType:"json"
			, success: function(data){
				
				$("#name").html(name);
				$("#mCode").html(memberCode);
				$("#date").html(attDate)
				
				var resultMap = data.resultMap;
				var html = "";
				html += '<tr>';
				html += '	<th>비고</th>';
				html += '	<td>'+resultMap.attEtc+'</td>';
				html += '</tr>';
				html += '<tr>';
				html += '	<th>첨부파일</th>';
				html += '	<td>';
				if(resultMap.attachSeq != null){
					html += '		<a href="<c:url value="/cmmn/file/downloadFile.do"/>?fileId='+resultMap.attachSeq+'&type='+resultMap.boardType+'">';
					html += '			'+resultMap.orgFileName;
					html += '		</a>';
				}
				html += '	</td>';
				html += '</tr>';
				
				$("#stdBody").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_search_cour(ele){
		$.ajax({
			url: "<c:url value='/qxsepmny/cmm/admAjaxSearchCour.do'/>"
			, type: "post"
			, data: "searchWord="+$(ele).val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = '<option value="">-- 선택 --</option>';
				
				for(var i=0; i<resultList.length; i++){
					html += '<option value="'+resultList[i]+'">'+resultList[i]+'</option>';
				}
				
				$("#searchCondition6").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
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
		            <jsp:param name="dept2" value="출결"/>
	           	</jsp:include>
	           	<form:form commandName="searchVO" id="frm" name="frm">
					<!-- search -->
					<div class="search-box">
						<input type="checkbox" id="search-option-open" />
						<div class="search">
							<div class="search-input">
								<table class="shearch-option">
									<colgroup>
										<col style="width:8%;" />
										<col style="width:18%;" />
										<col style="width:8%;" />
										<col style="width:45%;" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<td>대상학기</td>
											<td>
												<form:select path="searchCondition1" onchange="fn_search_seme(this); return false;">
													<form:options items="${yearList }"/>
												</form:select>
												<form:select path="searchCondition2" id="semEster">
													<c:forEach items="${semeList }" var="seme">
														<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
													</c:forEach>
												</form:select>
											</td>
											<td>강의일자</td>
											<td>
												<form:input path="startDate" id="datepicker01" class="w173px bl-l bl-r" />
												~
												<form:input path="endDate" id="datepicker02" class="w173px bl-l bl-r" />
											</td>
											<td>
												<form:select path="searchCondition3">
													<form:option value="1">전체</form:option>
													<form:option value="2">결석자</form:option>
												</form:select>
											</td>
										</tr>
									</tbody>
								</table>
								<a href="#" onclick="fn_list(1); return false;">검색하기</a>
							</div>
							<div class="search-option">
								<label for="search-option-open"><span>조건항목검색</span></label>
							</div>
							<!-- 확장 검색조건항목 -->
							<div class="shearch-option-box">
								<div class="shearch-option-list">
									<table class="shearch-option">
										<colgroup>
											<col style="width:15%;" />
											<col style="width:35%;" />
											<col style="width:15%;" />
											<col style="width:35%;" />
										</colgroup>
										<tbody>
											<tr>
												<th>교육과정</th>
												<td>
													<div>
														<form:select path="searchCondition4">
															<form:option value="">-- 선택 --</form:option>
															<form:options items="${currList }"/>
														</form:select>
													</div>
												</td>
											</tr>
											<tr>
												<th>프로그램</th>
												<td>
													<div>
														<form:select path="searchCondition5" onchange="fn_search_cour(this); return false;">
															<form:option value="">-- 선택 --</form:option>
															<form:options items="${progList }"/>
														</form:select>
													</div>
												</td>
												<th>교과목</th>
												<td>
													<div>
														<form:select path="searchCondition6">
															<form:option value="">-- 선택 --</form:option>
															<form:options items="${courList }"/>
														</form:select>
													</div>
												</td>
											</tr>
											<tr>
												<th>분반</th>
												<td colspan="3">
													<div>
														<form:select path="searchCondition7">
															<form:option value="">-- 선택 --</form:option>
															<c:forEach items="${diviList }" var="divi">
																<form:option value="${divi.name }"><c:out value="${divi.name }"/></form:option>
															</c:forEach>
														</form:select>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="shearch-btn">
									<div class="btn-box">
										<button type="button" class="green" onclick="fn_list(1); return false;">검색</button>
									</div>
								</div>
							</div>
							<!--// 확장 검색조건항목 -->
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
								<c:forEach items="${clstmList }" var="clstm">
									<col />
								</c:forEach>
								<col />
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>강의일자</th>
									<th>과목명</th>
									<th>분반</th>
									<th>학번</th>
									<th>이름</th>
									<c:forEach items="${clstmList }" var="clstm">
										<th><c:out value="${clstm }"/>교시</th>
									</c:forEach>
									<th>비고</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr>
										<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + status.count)}"/></td>
										<td><c:out value="${result.attDate }"/></td>
										<td><c:out value="${result.lectName }"/></td>
										<td><c:out value="${result.lectDivi }"/></td>
										<td><span class="underline"><c:out value="${result.memberCode }"/></span></td>
										<td><span class="underline"><c:out value="${result.name }"/></span></td>
										<c:forEach items="${clstmList }" var="clstm">
											<td>
												<c:forEach items="${attendList }" var="attend" varStatus="status">
													<c:if test="${attend.lectSeq eq result.lectSeq && attend.attDate eq result.attDate && attend.memberCode eq result.memberCode && attend.lectClass eq clstm }">
														<c:if test="${attend.attend eq '결석' || attend.attend eq '지각' }">
															<label class="txt-red"><c:out value="${attend.attend }"/></label>
														</c:if>
														<c:if test="${attend.attend ne '결석' && attend.attend ne '지각' }">
															<c:out value="${attend.attend }"/>
														</c:if>
													</c:if>
												</c:forEach>
											</td>
										</c:forEach>
										<td>
											<c:if test="${result.etcYn eq 'Y' }">
												<label for="modi-pop" class="normal-btn" onclick="fn_etc('<c:out value="${result.lectSeq }"/>','<c:out value="${result.attDate }"/>','<c:out value="${result.memberCode }"/>', '<c:out value="${result.name }"/>');">비고</label>
											</c:if>
										</td>
										<%-- <td><span class="txt-red"><c:out value="${result.attEtc }"/></span></td> --%>
									</tr>
								</c:forEach>
								<c:if test="${resultList.size() == 0 }">
									<tr>
										<td colspan="<c:out value='${clstmList.size()+7 }'/>">검색된 내용이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<!--// table -->
		
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
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup">
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
				<table class="normal-list-table">
					<colgroup>
						<col style="width:10%;" />
						<col />
					</colgroup>
					<tbody id="stdBody">
					</tbody>
				</table>
			</div>
			<div class="table-button">
				<div class="btn-box">
					<label for="modi-pop" class="white btn-cancel">닫기</label>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <footer>
       <p>COPYRIGHT@2019 HANSUNG UNIVERSITY All Rights Reserved.</p>
    </footer>
	<!--// footer -->

</body>
</html>