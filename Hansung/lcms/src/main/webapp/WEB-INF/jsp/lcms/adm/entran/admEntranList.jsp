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
	});
	
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admEntranList.do'/>").submit();
	}
	
	function fn_modify(seq){
		$("#enterSeq").val(seq);
		$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admEntranModify.do'/>").submit();
	}
	
	function fn_bat(stat){
		if($("input[name=enterSeq]:checked").length == 0){
			alert('학생을 선택해 주세요.');
			return;
		}
		$.ajax({
			url: "<c:url value='/qxsepmny/entran/admAjaxEntranBatch.do'/>"
			, type: "post"
			, data: "status="+stat+"&"+$("input[name=enterSeq]:checked").serialize()
			, dataType:"json"
			, success: function(data){
				alert(data.message);
				window.location.reload();
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_tab(menu){
		$("#menuType").val(menu);
		fn_list(1);
	}
	
	function fn_select(seq, ele){
		if($(ele).hasClass('imgSelect2')){
		}
		$.ajax({
			url: "<c:url value='/qxsepmny/entran/admAjaxEnterReco.do'/>"
			, type: "post"
			, data: "enterSeq="+seq
			, dataType:"json"
			, success: function(data){
				var enterVO = data.enterVO;
				var recoList = data.recoList;
				var type = '';
				var satsus = '';
				
				if(enterVO.enterType == '1'){
					type = '신규';
				}else if(enterVO.enterType == '2'){
					type = '재등록';
				}

				if(enterVO.enterStatus == '1'){
					satsus = '신청';
				}else if(enterVO.enterStatus == '2'){
					satsus = '합격';
				}else if(enterVO.enterStatus == '3'){
					satsus = '불합격';
				}
				
				$("#enterNum").html(enterVO.enterNum+'('+enterVO.enterCode+') / '+type+' / '+satsus);
				$("#name").html(enterVO.enterName);
				$("#birth").html(enterVO.enterBirth);
				$("#nation").html(enterVO.enterNation);
				$("#enterEtc").val(enterVO.enterEtc);
				$("#etcSeq").val(enterVO.enterSeq);
				
				var html = '';
				for(var i=0; i<recoList.length; i++){
					html += '<p>'+recoList[i].enterYear+recoList[i].enterSeme+'-'+recoList[i].enterSemeNm+' '+recoList[i].enterStatus+' / '+(recoList[i].enterEtc==null?'':recoList[i].enterEtc)+'</p>';
				}
				
				$("#recoList").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_save_etc(){
		var enterSeq = $("#etcSeq").val();
		var enterEtc = $("#enterEtc").val();
		
		if(enterSeq != ''){
			$.ajax({
				url: "<c:url value='/qxsepmny/entran/admAjaxSaveEtc.do'/>"
				, type: "post"
				, data: "enterSeq="+enterSeq+"&enterEtc="+enterEtc
				, dataType:"json"
				, success: function(data){
					if(data.status){
						alert('저장되었습니다.');
						window.location.reload();
					}else{
						alert('오류가 발생하였습니다.');
					}
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	// 엑셀 다운로드
	function fn_excelDown(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/entran/admEntranExcel.do'/>").submit();
	}
	
	// 학번일괄등록
	function fn_code(){
		if($("input[name=enterSeq]:checked").length == 0){
			alert('학생을 선택해 주세요.');
			return;
		}
		if(confirm('합격한 학생들의 학번을 일괄 등록합니다.\r\n등록하시겠습니까?')){
			$("#frm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/entran/admEntranCodeBat.do'/>").submit();
		}
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
		            <jsp:param name="dept2" value="신입학"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
					<input type="hidden" id="enterSeq" name="enterSeq"/>
					<input type="hidden" id="enterNum" name="enterNum"/>
					
					<input type="hidden" id="enterStatus" name="enterStatus"/>
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
										</tr>
									</tbody>
								</table>
	
								<a href="#" onclick="fn_list(1); return false;">검색하기</a>
							</div>
						</div>
					</div>
					<!--// search -->
					<div class="tab-box">
						<form:hidden path="menuType"/>
						<input id="tab1" type="radio" name="tabs" <c:out value="${searchVO.menuType eq ''?'checked':'' }"/>>
						<input id="tab2" type="radio" name="tabs" <c:out value="${searchVO.menuType eq '2'?'checked':'' }"/>>
						<input id="tab3" type="radio" name="tabs" <c:out value="${searchVO.menuType eq '3'?'checked':'' }"/>>
	
						<div class="tab-btn">
							<label for="tab1" class="tab1" onclick="fn_tab(''); return false;">입학신청자</label>
							<label for="tab2" class="tab2" onclick="fn_tab('2'); return false;">합격자</label>
							<label for="tab3" class="tab3" onclick="fn_tab('3'); return false;">불합격자</label>
						</div>
	
						<div id="content">
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
										<c:if test="${searchVO.menuType eq '2' }">
											<col />
										</c:if>
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
											<th>상태</th>
											<c:if test="${searchVO.menuType eq '2' }">
												<th>입학연기</th>
											</c:if>
											<th><c:out value="${searchVO.menuType eq ''?'신청회수':'비고' }"/></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${resultList }" var="result">
											<tr>
												<td><input type="checkbox" name="enterSeq" value="<c:out value='${result.enterSeq }'/>"/></td>
												<td><a href="#" class="underline imgSelect" onclick="fn_select('<c:out value='${result.enterSeq }'/>', this); return false;"><c:out value="${result.enterNum }"/></a></td>
												<td><a href="#" class="underline" onclick="fn_modify('<c:out value='${result.enterSeq }'/>'); return false;"><c:out value="${result.enterCode }"/></a></td>
												<td><a href="#" class="underline" onclick="fn_modify('<c:out value='${result.enterSeq }'/>'); return false;"><c:out value="${result.enterName }"/></a></td>
												<td><c:out value="${result.enterNation }"/></td>
												<td><c:out value="${result.enterBirth }"/></td>
												<td><c:out value="${result.enterStdType }"/></td>
												<td><c:out value="${result.enterType }"/></td>
												<td><c:out value="${result.enterStatus }"/></td>
												<c:if test="${searchVO.menuType eq '2' }">
													<td><c:out value="${result.delayYn }"/></td>
												</c:if>
												<td><c:out value="${searchVO.menuType eq ''? result.enterCnt : searchVO.menuType eq '2'?result.delayEtc:result.enterEtc }"/></td>
											</tr>
										</c:forEach>
										<c:if test="${resultList.size() == 0 }">
											<tr>
												<td colspan="11">검색된 내용이 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>
	
	
							</div>
							<!--// table -->
	
							<!-- table button -->
							<div class="table-button">
								<div class="btn-box">
									<c:if test="${searchVO.menuType eq '' }">
										<button type="button" class="white btn-type01">신청자전체보기</button>
									</c:if>
									<c:if test="${searchVO.menuType eq '' || searchVO.menuType eq '3' }">
										<button type="button" class="white btn-type02" onclick="fn_bat('2'); return false;">합격처리</button>
									</c:if>
									<c:if test="${searchVO.menuType eq '' || searchVO.menuType eq '2' }">
										<button type="button" class="white btn-type03" onclick="fn_bat('3'); return false;">불합격처리</button>
									</c:if>
									<c:if test="${searchVO.menuType eq '2' }">
										<button type="button" class="white btn-type01" onclick="fn_code(); return false;">학번일괄등록</button>
										<button type="button" class="white btn-type01" onclick="fn_open(); return false;">급수일괄등록</button>
									</c:if>
									<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
									<c:if test="${searchVO.menuType eq '' }">
										<button type="button" onclick="fn_modify(''); return false;" class="white btn-type04">입학신청자등록</button>
									</c:if>
									<c:if test="${searchVO.menuType eq 'P' }">
										<button type="button" onclick="fn_modify(); return false;" class="white btn-type05">등록금고지확정</button>
									</c:if>
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
						</div>
					</div>
					<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>">
				</form:form>
			</div>
		</div>

		<!-- 입학신청자 입력폼 -->
		<div class="popupLayer">
			<table class="pop-table">
				<colgroup>
					<col style="width:100px;" />
					<col />
					<col style="width:100px;" />
					<col />
				</colgroup>
				<tbody>
					<c:if test="${searchVO.menuType ne '' }">
						<tr>
							<th scope="row" colspan="4" style="border-right:0;"><strong>학생찾기</strong></th>
						</tr>
					</c:if>
					<tr>
						<th scope="row">접수번호</th>
						<td colspan="3" id="enterNum"></td>
					</tr>
					<tr>
						<th scope="col">이름</th>
						<td id="name"></td>
						<th scope="col">생년월일</th>
						<td id="birth"></td>
					</tr>
					<tr>
						<th scope="row">국적</th>
						<td colspan="3" id="nation"></td>
					</tr>
					<tr>
						<th scope="row">신청이력</th>
						<td colspan="3" id="recoList"></td>
					</tr>
					<c:if test="${searchVO.menuType ne '' }">
						<tr>
							<th scope="row"><sup>*</sup>비고</th>
							<td colspan="3">
								<input type="text" class="input-data" id="enterEtc"/>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<div class="btn-box01">
				<c:if test="${searchVO.menuType ne '' }">
					<input type="hidden" id="etcSeq"/>
					<button style="cursor:pointer;" class="pop-save" onclick="fn_save_etc(); return false;" title="저장">저장</button>
				</c:if>
				<button onClick="closeLayer(this)" class="pop-close" style="cursor:pointer;" title="닫기">닫기</button>
			</div>
		</div>
		<!--// 입학신청자 입력폼 -->
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
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>