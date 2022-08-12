<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript"> 
	$(function(){
		//엑셀다운로드권한 
		var ynexauth = '<c:out value="${exauth}"/>';
		if(ynexauth=='N') {
			$('.btn_excel').css("display","none");
		}
		
		//목록 일괄 선택
		$("#all-chk").change(function(){
			$("input[name=itemSeq]").prop("checked", $(this).prop('checked'));
		});
	})
	
	function fn_view(corpCd, itemNo){
		$("#corpCd").val(corpCd);
	 	$("#itemNo").val(itemNo);
	 	//var str = $("#searchWord").val();
		//$("#searchWord").val(encodeURIComponent(str));
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0106/ech0106View.do'/>").submit();
	}
	
	//SMS 테스트
	function fn_modify1(){
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0106/ech0106Sms.do'/>").submit();
	}

	//등록 화면
	function fn_modify(){
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0106/ech0106Modify.do'/>").submit();
	}
	
	//시험제품일괄등록 화면
	function fn_ItemUpload(){
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0106/ech0106ItemUpload.do'/>").submit();
	}
	
	//연구과제관리 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0106/ech0106List.do'/>").submit();
	}
	
	//연구과제관리 목록 엑셀다운로드
	function fn_excelDown(){
		if(confirm('출력하는 데이터건수에 따라 시간이 지체될 수 있습니다. \r\n진행하시겠습니까?')){
			$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0106/ech0106Excel.do'/>").submit();
		}
	}
	
	//검색항목 제어 기능 시작
	//기간 clear 
	function fn_resetTerm(){
		var chkTerm = $("#searchCondition4").val();
		if(chkTerm == '') {
			$("#datepicker01").datepicker().datepicker("setDate", '');
			$("#datepicker02").datepicker().datepicker("setDate", '');
			$("#searchCondition1").focus();
			$("input[name=period]:checked").prop("checked", false);  
		} 
		//$("#searchCondition1").val("");
		//$("#searchCondition2").val("");
		//$("#searchCondition1").focus();
	}
	
	//검색어 clear
	function fn_resetWord(){
		$("#searchWord").val("");
		$("#searchWord").focus();
	}
	
	function fn_getDatePrev(dayCnt) {
		var dDate = new Date();
		var dDate = new Date(dDate.getTime()+(1000*60*60*24*-dayCnt));
		return dDate;
	}
	
	function fn_resetDate(){
		//alert('검색기간을 재설정합니다.');

		// 1 1년  2 3개월  3 1개월  4 전체
		switch($("input[name=period]:checked").val()) {
			case '1':
				$("#datepicker01").datepicker().datepicker("setDate", fn_getDatePrev(365));
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			case '2':
				$("#datepicker01").datepicker().datepicker("setDate", fn_getDatePrev(90));
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			case '3':
				$("#datepicker01").datepicker().datepicker("setDate", fn_getDatePrev(30));
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			case '4':
				$("#datepicker01").datepicker().datepicker("setDate", '');
				$("#datepicker02").datepicker().datepicker("setDate", '');
			break;
			default : 
				$("#datepicker01").datepicker().datepicker("setDate", new Date());
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
		}
	}
	//-- 검색항목 제어 기능 끝
	
	// 시험제출 일괄 삭제
	function fn_del(){
		
		if($("input[name=itemSeq]:checked").length == 0){
			alert('삭제할 시험제품 정보를 선택해 주세요.');
			return;
		}
		if(confirm('선택하신 시험제품 정보를 삭제합니다. 삭제한 정보는 복구할 수 없습니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106AjaxItemDel.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=itemSeq]:checked").serialize()
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
	
	function fn_open(){
		
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구계획서를 선택해 주세요.');
			return;
		}
		$("#modi-pop").prop("checked", "true");
		
	}
	
	function fn_step(){
		if(confirm('선택하신 연구계획서의 세부 차수를 등록합니다. \r\n등록하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var ctrtNo = $("#ctrtNo").val();			
			var step1 = $("#step1").val();
			var step2 = $("#step2").val();
			if(step1 > step2) {
				alert('설정한 연구차수를 확인해주세요.');
				return;
			}
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106AjaxSaveStep2.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"ctrtNo="+ctrtNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
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
	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>시험제품</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="연구관리"/>
	            <jsp:param name="dept2" value="시험제품"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<form:form commandName="searchVO" id="listForm" name="listForm">
				<input type="hidden" id="corpCd" name="corpCd"/>
				<input type="hidden" id="itemNo" name="itemNo"/>
				<!-- 검색영역 -->
				<div class="srch_area">
					<ul>
						<li>
							<p>년도</p>
							<!-- <span class="type01">
								<input type="text" placeholder="연구코드" />
							</span>  -->
							<span>
								<form:select path="searchYear" onchange="fn_search(this); return false;">
									<option value="">선택</option>
									<form:options items="${yearList }"/>
								</form:select>
							</span>
							<span class="type01" >
								<form:select path="searchCondition8" id="rsCdList">
									<c:forEach items="${yearRsCdList }" var="rscd">
										<form:option value="${rscd.rsCd }"><c:out value="${rscd.rsCd }"/></form:option>
									</c:forEach>
								</form:select>
							</span>
						</li>
						<li>
							<p>지사</p>
							<span>
							<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->							
							<select id="searchCondition7" name="searchCondition7">
								<option value="">선택</option>
								<c:if test="${searchVO.searchCondition7 eq '' }">selected="selected"</c:if>
								<c:forEach var="result" items="${branch}">
									<option value="${result.branchCd}"<c:if test="${result.branchCd eq searchVO.searchCondition7}">selected="selected"</c:if>>${result.branchName}</option>
								</c:forEach>
							</select>
							</span>
						</li>
						<%-- <li>
							<p>임상분류</p>
							<span>
                            <!-- 임상분류 목록(공통코드) CM4000M - CT2030  M P G O -->
							<select id="searchCondition5" name="searchCondition5">
								<option value="">선택</option>
								<c:if test="${searchVO.searchCondition5 eq '' }">selected="selected"</c:if>
								<c:forEach var="result" items="${ct2030}">									
									<option value="${result.cd}"<c:if test="${result.cd eq searchVO.searchCondition5 }">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
							</span>
						</li>
	                    <li>
							<p>연구상태</p>
							<span>
								<!-- 연구상태 목록(공통코드) CM4000M - CT2050   -->
								<select id="searchCondition6" name="searchCondition6">
									<option value="">선택</option>
									<c:if test="${searchVO.searchCondition6 eq '' }">selected="selected"</c:if>
									<c:forEach var="result" items="${ct2050}">									
										<option value="${result.cd}"<c:if test="${result.cd eq searchVO.searchCondition6 }">selected="selected"</c:if>>${result.cdName}</option>
									</c:forEach>
								</select>
							</span>
						</li> --%>
						<li>
							<p>수거여부</p>
							<span>
								<select name="searchCondition6" id="searchCondition6" >
									<option value="" <c:if test="${searchVO.searchCondition6  eq '' }">selected="selected"</c:if> >선택</option>
									<option value="Y" <c:if test="${searchVO.searchCondition6  eq 'Y' }">selected="selected"</c:if> >수거</option>
									<option value="N" <c:if test="${searchVO.searchCondition6  eq 'N' }">selected="selected"</c:if> >미수거</option>
								</select>
							</span>
						</li>		
						<li>
							<p>기간</p>
	                        <span>
	                        	<select name="searchCondition4" id="searchCondition4" onchange="fn_resetTerm(); return false;">
									<option value="" <c:if test="${searchVO.searchCondition4  eq '' }">selected="selected"</c:if> >선택</option>
									<option value="1" <c:if test="${searchVO.searchCondition4  eq '1' }">selected="selected"</c:if> >입고일</option>
									<option value="2" <c:if test="${searchVO.searchCondition4  eq '2' }">selected="selected"</c:if> >폐기일</option>
								</select>
	                        </span>
							<span>
							<%-- <input type="text" name="searchCondition1" id="datepicker01" value="<c:out value="${searchVO.searchCondition1 }" />" placeholder="0000-00-00" class="date" onchange="fn_date(1); return false;" title="시작일자"/> --%>
							<input type="text" name="searchCondition1" id="datepicker01" value="<c:out value="${searchVO.searchCondition1 }" />" placeholder="0000-00-00" class="date" title="시작일자"/>
							<label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
							<em>~</em>
							<span>
								<%-- <input type="text" name="searchCondition2" id="datepicker02" value="<c:out value="${searchVO.searchCondition2 }" />" placeholder="0000-00-00" class="date" onchange="fn_date(2); return false;" title="종료일자"/> --%>
								<input type="text" name="searchCondition2" id="datepicker02" value="<c:out value="${searchVO.searchCondition2 }" />" placeholder="0000-00-00" class="date" title="종료일자"/>
								<label for="datepicker02" class="btn_cld">날짜검색</label>
							</span>
							<span class="type00" onchange="fn_resetDate(); return false;">
								<input type="radio" name="period" id="period01" value="1"/> <label for="period01">1년</label>
								<input type="radio" name="period" id="period02" value="2"/> <label for="period02">3개월</label>
								<input type="radio" name="period" id="period03" value="3"/> <label for="period03">1개월</label>
								<input type="radio" name="period" id="period04" value="4"/> <label for="period04">전체</label>
							</span>
						</li>                    
	                    <li>
							<p>검색어</p>
							<span>
								<select name="searchCondition3" id="searchCondition3" onchange="fn_resetWord(); return false;">
									<option value="" <c:if test="${searchVO.searchCondition3  eq '' }">selected="selected"</c:if> >선택</option>
									<option value="1" <c:if test="${searchVO.searchCondition3  eq '1' }">selected="selected"</c:if> >전체</option>
									<option value="2" <c:if test="${searchVO.searchCondition3  eq '2' }">selected="selected"</c:if> >제품명</option>
									<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >고객사명</option>
									<option value="4" <c:if test="${searchVO.searchCondition3  eq '4' }">selected="selected"</c:if> >연구코드</option>
									<option value="5" <c:if test="${searchVO.searchCondition3  eq '5' }">selected="selected"</c:if> >비고</option>
								</select>
							</span>
	                        <span class="type02">
	                            <input type="text" name="searchWord" id="searchWord" value="${searchVO.searchWord }" class="input-data" placeholder="제품명,고객사명,연구코드를 입력하세요" style="width: 248px;"/>
	                        </span>
						</li>
					</ul>
					<!-- 조회버튼 -->
					<a href="#" onclick="fn_list(1); return false;">조회</a>
				</div>
				<!-- //검색영역 -->
				<!-- 테이블 상단 정보 -->
				<div class="tbl_top_info">
					<span>총<strong><c:out value="${totalCount }"/></strong>건</span>
					<!-- 버튼 -->
					<div>
						<!-- <a href="#" onclick="fn_ZipDownload(); return false;" class="btn_sub">계약서일괄다운로드(zip)</a> -->
						<a href="#" class="btn_sub" onclick="fn_del(); return false;" id="btnDel">일괄삭제</a>
						<a href="#" onclick="fn_excelDown(); return false;" class="btn_excel">엑셀</a>
					</div>
				</div>
				<!-- //테이블 상단 정보 -->
				<!-- 목록 -->
				<table class="tbl_list tr_link">
					<colgroup>
						<col style="width:5%" />
						<col style="width:5%" />
						<col style="width:10%" />
						<col style="width:8%" />
						<col style="width:auto" />
						<col style="width:6%" />
						<col style="width:8%" />
						<col style="width:6%" />
						<col style="width:6%" />
						<col style="width:6%" />
						<col style="width:6%" />
						<col style="width:6%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" id="all-chk"/></th>
							<th scope="col">번호</th>
							<th scope="col">연구코드</th>
							<th scope="col">고객사</th>
							<th scope="col">연구명</th>
							<th scope="col">입고일</th>
							<th scope="col">제품</th>
							<th scope="col">반출일</th>
							<th scope="col">발송일</th>
							<th scope="col">수거여부</th>
							<th scope="col">수거일</th>
							<th scope="col">폐기일</th>
							<th scope="col">비고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>					
								<td><input type="checkbox" name="itemSeq" value="<c:out value='${result.itemNo }'/>"/></td>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
								<td onclick="fn_view('<c:out value='${result.corpCd}'/>','<c:out value='${result.itemNo}'/>'); return false;" style="text-decoration: underline;"><c:out value="${result.rsCd }"/></td>
								<td><c:out value="${result.vendName }"/></td>
								<td onclick="fn_view('<c:out value='${result.corpCd}'/>','<c:out value='${result.itemNo}'/>'); return false;" style="text-decoration: underline;"><c:out value="${result.rsName }"/></td>
								<td><c:out value="${result.inhDt }"/></td>
								<td onclick="fn_view('<c:out value='${result.corpCd}'/>','<c:out value='${result.itemNo}'/>'); return false;" style="text-decoration: underline;"><c:out value="${result.itemName }"/></td>
								<td><c:out value="${result.outDt }"/></td>
								<td><c:out value="${result.sendDt }"/></td>
								<td>
									<c:choose>
		                          		<c:when test="${result.reYn eq 'Y' }"><span style="color:blue;">수거</span></c:when>
		                          		<c:when test="${result.reYn eq 'N' }"><span style="color:red;">미수거</c:when>
		                          	</c:choose>
		                        </td>
								<td><c:out value="${result.reDt }"/></td>
								<td><c:out value="${result.dispoDt }"/></td>
								<td><c:out value="${result.remk }"/></td>
								<%-- <td><a href="#" onclick="fn_ctrtpop('u','<c:out value="${result.corpCd }"/>','<c:out value="${result.ctrtNo }"/>'); return false;" class="btn_sub btnModiMtl" >보기</a></td> --%>
							</tr>
						</c:forEach>
						<c:if test="${resultList.size() == 0 }">
							<tr>
								<td class="nodata" colspan="13">시험제품정보가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<!-- //목록 -->
				<!--  목록 하단 -->
				<div class="list_btm">
				<!-- 페이징 -->
				<div class="pagenate">
					<div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
					</div>
				</div>
				<!-- //페이징 -->
				<!-- 하단버튼 -->
				<div class="list_btm_btn">
					<a href="#" onclick="fn_modify(); return false;">등록</a>
					<a href="#" onclick="fn_ItemUpload(); return false;">시험제품일괄등록</a>
				</div>
				<!-- //하단버튼 -->
			</div>
			<!-- //목록 하단 -->
		</div>
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>입금차수 설정</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 사용체크정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>			
					<tr>
						<th scope="row">시작차수</th>
						<td>
							<div>
								<input type="text" class="step1 p20" id="step1" class="required" title="시작차수"/>
							</div>
						</td>
						<th scope="row" class="bl">종료차수</th>
						<td>
							<div>
								<input type="text" class="step2 p20" id="step2" class="required" title="종료차수"/>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- 버튼 -->
            <div class="btn_area">
            	<a href="#" onclick="fn_step(); return false;" >저장</a>
            	<label for="modi-pop" class="type02 btn-cancel">취소</label>			
			</div>
		</div>
		</div>
		<!-- 팝업 -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
		<!-- //contents -->		
	</div>
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!-- //container -->			
</div>	
<!-- //wrap -->
</form:form>
</body>
</html>
