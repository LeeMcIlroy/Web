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
			$("input[name=mapSeq]").prop("checked", $(this).prop('checked'));
		});
	});
	
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admComplList.do'/>").submit();
	}
	
	function fn_submit(status){
		if($("input[name=mapSeq]:checked").length == 0){
			alert('학생을 선택해 주세요.');
			return;
		}
		if(confirm('선택 학생을 수료/유급 처리 하시겠습니까?')){
			$("#compleSta").val(status);
			$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admComplUpdate.do'/>").submit();
		}
	}
	
	function fn_numBat(){
		$.ajax({
			url: "<c:url value='/qxsepmny/clss/admAjaxComplNum.do'/>"
			, type: "post"
			, data: $("#frm").serialize()
			, dataType:"json"
			, success: function(data){
				var message = data.message;
				alert(message);
				window.location.reload();
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_certiBat(){
		var lectYear = $("#searchCondition1").val();
		var lectSem = $("#semEster").val();
		var prtType = 'CERTI';
		
		if($("input[name=mapSeq]:checked").length == 0){
			alert('학생을 선택해 주세요.');
			return;
		}

		if($("#prtType").prop('checked')){
			prtType = 'ALL';
		}
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admCertiPop.do?'/>lectYear="+lectYear+"&lectSem="+lectSem+"&prtType="+prtType+"&"+$("#frm").serialize()
					, '증명서 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
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
				
				$("#searchCondition5").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	// 엑셀 다운로드
	function fn_excelDown(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/clss/admComplExcel.do'/>").submit();
	}
	
	function fn_grade(){
		var lectYear = $("#searchCondition1").val();
		var lectSem = $("#semEster").val();
		var prtType = 'GRADE';
		
		if($("input[name=mapSeq]:checked").length == 0){
			alert('학생을 선택해 주세요.');
			return;
		}

		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admCertiPop.do?'/>lectYear="+lectYear+"&lectSem="+lectSem+"&prtType="+prtType+"&"+$("#frm").serialize()
					, '증명서 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
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
		            <jsp:param name="dept2" value="수료산정"/>
	           	</jsp:include>
	           	<form:form commandName="searchVO" id="frm" name="frm">
		           	<input type="hidden" name="compleSta" id="compleSta"/>
					<!-- search -->
					<div class="search-box">
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
												<form:input path="searchWord" class="input-data" placeholder="학번,이름,국적,학적을 입력하세요" />
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
														<form:select path="searchCondition3">
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
														<form:select path="searchCondition4" onchange="fn_search_cour(this); return false;">
															<form:option value="">-- 선택 --</form:option>
															<form:options items="${progList }"/>
														</form:select>
													</div>
												</td>
												<th>교과목</th>
												<td>
													<div>
														<form:select path="searchCondition5">
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
														<form:select path="searchCondition6">
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
								<col />
								<col />
								<col />
								<col />
								<col />
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="all-chk"/></th>
									<th class="sorting">
										과목명
										<button>오름차순 정렬</button>
										<button>내림차순 정렬</button>
									</th>
									<th>분반</th>
									<th class="sorting">
										학번
										<button>오름차순 정렬</button>
										<button>내림차순 정렬</button>
									</th>
									<th class="sorting">
										이름
										<button>오름차순 정렬</button>
										<button>내림차순 정렬</button>
									</th>
									<th>등급</th>
									<th>국적</th>
									<th>성적</th>
									<th>출석율(%)</th>
									<th>산정결과</th>
									<th>수료번호</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr>
										<td><input type="checkbox" value="<c:out value='${result.mapSeq }'/>" name="mapSeq"/></td>
										<td><c:out value='${result.lectName }'/></td>
										<td><c:out value='${result.lectDivi }'/></td>
										<td><c:out value='${result.memberCode }'/></td>
										<td><c:out value='${result.name }'/></td>
										<td><c:out value='${result.step }'/>급</td>
										<td><c:out value='${result.nation }'/></td>
										<td style="<c:out value='${result.grade == "미산정" || result.grade < 70?"color:#fc6039":"" }'/>"><c:out value='${result.grade }'/></td>
										<td><c:out value='${result.attend }'/></td>
										<td>
											<c:if test="${result.compleSta eq '1' }">
												<c:out value='${result.compleStaNm }'/>
											</c:if>
											<c:if test="${result.compleSta ne '1' }">
												<span class="txt-red"><c:out value='${result.compleStaNm }'/></span>
											</c:if>
										</td>
										<td><c:out value='${result.compleNum }'/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!--// table -->
	
					<!-- table button -->
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
							<button type="button" class="white btn-type11" onclick="fn_submit('2'); return false;">유급처리</button>
							<button type="button" class="white btn-type12" onclick="fn_submit('1'); return false;">수료처리</button>
							<button type="button" class="white btn-type12" onclick="fn_numBat(); return false;">수료번호일괄부여</button>
							<label for="modi-pop" class="white btn-type12">수료증일괄발급</label>
							<button type="button" class="white btn-type12" onclick="fn_grade(); return false;">성적표일괄발급</button>
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
					<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>">
				</form:form>
			</div>
		</div>
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:300px; height:150px; top:50%; left:50%; margin-left:-150px; margin-top:-75px;">
			<div class="list-table-box">
				<table class="normal-wmv-table">
					<colgroup>
						<col style="width:40%;">
						<col >
					</colgroup>
					<tbody>
						<tr>
							<th>성적표<br/>동시인쇄여부</th>
							<td><input type="checkbox" id="prtType" value="ALL"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="table-button">
				<div class="btn-box">
					<label for="modi-pop" class="white btn-save" onclick="fn_certiBat();">확인</label>
					<label for="modi-pop" class="white btn-cancel">취소</label>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>