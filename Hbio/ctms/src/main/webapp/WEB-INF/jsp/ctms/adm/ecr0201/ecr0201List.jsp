<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<%-- <c:import url="/EgovPageLink.do?link=adm/inc/incHead"/> --%>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead_crf"/>
<script type="text/javascript">
	
	$(function(){
		//엑셀다운로드권한 
		var ynexauth = '<c:out value="${exauth}"/>';
		if(ynexauth=='N') {
			$('.btn_excel').css("display","none");
		}
		
	})
	
	//제품사용관리 상세보기 화면
	function fn_view(corpCd, rsNo){		
	 	$("#corpCd").val(corpCd);
	 	$("#rsNo").val(rsNo);
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ecr0201/ecr0201View.do'/>").submit();
	}
	
	//제품사용관리 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ecr0201/ecr0201List.do'/>").submit();
	}
	
	//제품사용관리 등록화면
	function fn_regist(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0212/ech0212Modify.do'/>").submit();
	}
	
	//제품사용관리 엑셀다운로드
	function fn_excelDown(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0212/ech0212Excel.do'/>").submit();
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
	
	//CRF템플릿 일괄다운로드
	function fn_ZipDownload(){
		if (confirm("CRF템플릿파일을 일괄 다운로드하시겠습니까?")) {
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0212/ech0212ZipDownloadCrfFile.do'/>").submit();
			
		}
	}
	
	function fn_open(){
		
		/* if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구계획서를 선택해 주세요.');
			return;
		} */
		$("#modi-pop").prop("checked", "true");
		
	}
	
	function fn_step(){
		if(confirm('선택하신 연구계획서의 세부 차수를 등록합니다. \r\n등록하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();			
			var step1 = $("#step1").val();
			var step2 = $("#step2").val();
			if(step1 > step2) {
				alert('설정한 연구차수를 확인해주세요.');
				return;
			}
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0105/ech0105AjaxSaveStep2.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
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
	
	//CRF pdf 합치기
	function fn_pdfMergeRsNo(rsNo){
		//alert(rsNo);
		$.ajax({
			type: "POST"
	        , url:  "<c:url value='/qxsepmny/ecr0201/pdfMergeRsNo.do'/>"    
	        , data: {  
	    	    "rsNo"  : rsNo
	        }
	        , dataType:"json"	  
            , success: function (data) {
            	alert(data.message);
	         	var attachSeq1 = data.attachNo;
	         	var boardType1 = "SVYMerge";	
	         	location.reload();
	         	fn_filedownload(attachSeq1, boardType1);
	        }, 
	        error: function (jqXHR, textStatus, errorThrown) {
	           alert(jqXHR + ' ' + textStatus.msg);
	        }
		});	 
	}
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}
	
	function fn_tab(menu){
		$("#menuType").val(menu);
		fn_list(1);
	}
	
	//미리보기
	function fn_pdfView(attachSeq){
		//location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/pdfOpen.do'/>?fileId="+attachSeq;
		window.open("<c:out value='${pageContext.request.contextPath}/cmmn/file/pdfOpen.do'/>?fileId="+attachSeq);
	}
	
	/* function fn_setDataLock2(rsNo, lock){
		alert(lock);
	} */
	
	
	// data_lock 설정  Y, N 
	function fn_setDataLock(rsNo, lock){
		//alert(rsNo+lock);
		var confirmMessage = "";
		if(lock == 'Y') {
			confirmMessage = 'DATA LOCK을 해제합니다. LOCK 해제되면 연구데이터가 변경될 수 있습니다. \r\n해제하시겠습니까?';
			lock = 'N';
		}else {
			confirmMessage = 'DATA LOCK을 잠금 설정합니다. LOCK 설정후 연구데이터를 변경할 수 없습니다. \r\n설정 하시겠습니까?';
			lock = 'Y';
		}

		if(confirm(confirmMessage)){
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0105/ech0105AjaxDataLock.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"lock="+lock
				, dataType:"json"
				, success: function(data){
					var status = data.status;
					var message = data.message;
					alert(message);
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	// 승인요청 반려   MK_CLS 1020 -> 1010 
	function fn_reject(rsNo){
		if(confirm('선택하신 연구과제 승인요청을 반려합니다. \r\n반려하시겠습니까?')){
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ecr0201/ecr0201AjaxReject.do'/>"
				, type: "post"
				, data: "rsNo="+rsNo
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
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" id="corpCd" name="corpCd"/>
<input type="hidden" id="rsNo" name="rsNo"/>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav_crf"/>
	<!-- container -->
	<div class="container">
		<!-- <h2>종료확인</h2> -->
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<%-- <jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="CRF작성관리"/>
           	</jsp:include> --%>
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<%-- <div class="srch_area">
 				<ul>
 					<div>
						<p>아이디</p>
						<div>
							<input type="text"  name="userId" id="usrId" class="form_base" />
						</div>
					</div>
					<li>
						<p>년도</p>
						<!-- <span class="type01">
							<input type="text" placeholder="연구코드" />
						</span>  -->
						<span>
							<form:select path="searchYear" onchange="fn_search_rsplan(this); return false;">
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
					<li>
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
					</li>
					<li>
						<p>기간</p>
                        <span>
                        	<select name="searchCondition4" id="searchCondition4" onchange="fn_resetTerm(); return false;">
								<option value="" <c:if test="${searchVO.searchCondition4  eq '' }">selected="selected"</c:if> >선택</option>
								<option value="1" <c:if test="${searchVO.searchCondition4  eq '1' }">selected="selected"</c:if> >연구시작</option>
								<option value="2" <c:if test="${searchVO.searchCondition4  eq '2' }">selected="selected"</c:if> >연구종료</option>
							</select>
                        </span>
						<span>
						<input type="text" name="searchCondition1" id="datepicker01" value="<c:out value="${searchVO.searchCondition1 }" />" placeholder="0000-00-00" class="date" onchange="fn_date(1); return false;" title="시작일자"/>
						<label for="datepicker01" class="btn_cld">날짜검색</label>
						</span>
						<em>~</em>
						<span>
							<input type="text" name="searchCondition2" id="datepicker02" value="<c:out value="${searchVO.searchCondition2 }" />" placeholder="0000-00-00" class="date" onchange="fn_date(2); return false;" title="종료일자"/>
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
								<option value="2" <c:if test="${searchVO.searchCondition3  eq '2' }">selected="selected"</c:if> >연구명칭</option>
								<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >고객사명</option>
								<option value="3" <c:if test="${searchVO.searchCondition3  eq '4' }">selected="selected"</c:if> >연구코드</option>
							</select>
						</span>
                        <span class="type02">
                            <input type="text" name="searchWord" class="input-data" placeholder="연구명칭,고객사명,연구코드를 입력하세요" style="width: 248px;"/>
                        </span>
					</li>				
				</ul>
 				<!-- 조회버튼 -->
				<a href="#" onclick="fn_list(1); return false;">조회</a>
			</div> --%>
			<!-- //검색영역 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<%-- <span>
					총<strong><c:out value="${totalCount }"/></strong>건
				</span> --%>
				<!-- 버튼 -->
				<div>
					<!-- <a href="#" onclick="fn_excelDown(); return false;" class="btn_sub btn_excel">엑셀</a> -->
					<!-- <a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_open(); return false;">연구대상자등록</a> -->
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<div class="tab-box">
			<form:hidden path="menuType"/>
						<input id="tab1" type="radio" name="tabs" <c:out value="${searchVO.menuType eq '1'?'checked':'' }"/>>
						<input id="tab2" type="radio" name="tabs" <c:out value="${searchVO.menuType eq '2'?'checked':'' }"/>>
						<input id="tab3" type="radio" name="tabs" <c:out value="${searchVO.menuType eq '3'?'checked':'' }"/>>
	
						<div class="tab-btn">
							<label for="tab1" class="tab1" onclick="fn_tab('1'); return false;">승인대기</label>
							<label for="tab2" class="tab2" onclick="fn_tab('2'); return false;">승인완료</label>
							<label for="tab3" class="tab3" onclick="fn_tab('3'); return false;">연구진행</label>
						</div>
			<!-- 목록 -->
			<table class="tbl_list tr_link">
				<colgroup>
					<col style="width:5%" />
					<col style="width:15%" />
					<%-- <col style="width:6%" /> --%>
					<col style="width:auto" />
					<%-- <col style="width:10%" />
					<col style="width:20%" /> --%>
					<col style="width:8%" />
					<col style="width:40%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">연구코드</th>
						<!-- <th scope="col">임상분류</th> -->
						<th scope="col">연구명</th>
						<!-- <th scope="col">연구상태</th>
						<th scope="col">고객사명</th> -->
						<th scope="col">피험자수</th>
                        <th scope="col">CRF관리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
						<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
						<td><c:out value="${result.rsCd }"/></td>
						<%-- <td><c:out value="${result.rsNo3Nm }"/></td> --%>						
						<td onclick="fn_view('<c:out value='${result.corpCd}'/>','<c:out value='${result.rsNo}'/>'); return false;" style="text-decoration: underline;"><c:out value="${result.rsName }"/></td>
						<%-- <td>
							<c:choose>
                          		<c:when test="${result.dataLockYn eq 'Y' }"><c:out value="${result.rsstClsNm }"/><span style="color:red;">(Data Locked)</span></c:when>
                          		<c:when test="${result.dataLockYn eq 'N' }"><c:out value="${result.rsstClsNm }"/></c:when>
                         	</c:choose>
						</td>
						<td><c:out value="${result.vendName2}"/></td> --%>
						<td><c:out value="${result.rsScnt}"/></td>
						<td>
							<c:choose>
                          		<%-- <c:when test="${result.mkYn eq 'N' }"><span style="color:red;">미작성</span></c:when> --%>
                          		<c:when test="${result.mkCls eq '1000' }"><span style="color:red;">임상시험</span></c:when>
                          		<c:when test="${result.mkCls eq '1010' }"><span style="color:red;">승인요청</span></c:when>
                          		<c:when test="${result.mkCls eq '1020' }"><span style="color:red;">승인대기</span>
                          			<c:choose>
                          				<c:when test="${result.procMkFinCnt eq 0 }">
                          					<a class ="btnLockNonDisp btn_sub2" onclick="fn_reject('<c:out value="${result.rsNo }"/>'); return false;" style="text-decoration: underline;" >반려</a>
                          				</c:when>
                          			</c:choose>
                          			
                          		</c:when>
                          		<c:when test="${result.mkCls eq '1030' }">
									<%-- <a onclick="fn_pdfMergeRsNo('<c:out value="${result.rsNo }"/>');" class="btn_sub">CRF생성(전체)</a> --%>
									<!-- CRF(연구) 다운로드,미리보기 -->
									<c:set var="chkNo" value="${result.mapKey }"/>
									<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
										<a class ="btnLockNonDisp btn_sub" onclick="fn_filedownload('<c:out value="${resutlMt.attachNo }"/>','<c:out value="${resutlMt.boardType }"/>'); return false;" style="text-decoration: underline;" >다운로드</a>
										<a onclick="fn_pdfView('<c:out value="${resutlMt.attachNo }"/>'); return false;"  class="btn_sub">보기</a>
										
										<c:choose>
                        				<c:when test="${result.dataLockYn eq 'Y' }">
                        					<a onclick="fn_setDataLock('<c:out value="${result.rsNo }"/>','<c:out value="${result.dataLockYn }"/>'); return false;" class="btn_sub">해제</a>
                        				</c:when>
                        				<c:when test="${result.dataLockYn eq 'N' }">
                        				<a onclick="fn_setDataLock('<c:out value="${result.rsNo }"/>','<c:out value="${result.dataLockYn }"/>'); return false;" class="btn_sub type02">잠금</a>
                        				</c:when>
                        				</c:choose>
										
																
									</c:forEach>                          		
                          		</c:when>
                        	</c:choose>
							<%-- <c:choose>
                          		<c:when test="${result.rsScnt eq 0 }"><span style="color:red;">미작성</span></c:when>
                          		<c:when test="${result.rsScnt > 0 }">
									<a onclick="fn_pdfMergeRsNo('<c:out value="${result.rsNo }"/>');" class="btn_sub">CRF다운로드</a>                          		
                          		</c:when>
                        	</c:choose> --%>
                        	<%-- <c:choose>
                        		<c:when test="${result.mkCls eq '1030' }">
                        			<c:choose>
                        				<c:when test="${result.dataLockYn eq 'Y' }">
                        					<a onclick="fn_setDataLock('<c:out value="${result.rsNo }"/>','<c:out value="${result.dataLockYn }"/>'); return false;" class="btn_sub">해제</a>
                        				</c:when>
                        				<c:when test="${result.dataLockYn eq 'N' }">
                        				<a onclick="fn_setDataLock('<c:out value="${result.rsNo }"/>','<c:out value="${result.dataLockYn }"/>'); return false;" class="btn_sub type02">잠금</a>
                        				</c:when>
                        			</c:choose>
									
								</c:when>
							</c:choose> --%>							
						</td>
						
						<%-- <td>
							<c:choose>
                          		<c:when test="${result.rsScnt eq 0 }"><span style="color:red;">미작성</span></c:when>
                          		<c:when test="${result.rsScnt > 0 }">
                          			<a onclick="fn_pdfMerge('<c:out value="${result.rsiNo }"/>','<c:out value="${result.rsNo }"/>');" class="btn_sub">CRF다운로드</a>
									<a class ="btnLockNonDisp btn_sub" onclick="fn_filedownload('<c:out value="${result.attachNo }"/>','<c:out value="${result.boardType }"/>'); return false;">다운로드</a>
                          		</c:when>
                        	</c:choose>
						</td> --%>
						<%-- <td><c:out value="${result.useYnNm}"/></td> --%>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="5">CRF작성 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			<!-- //목록 -->
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
		</div>		
		<!-- //contents -->
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>연구차수 설정</h4>
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
		</div>
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</form:form>
</body>
</html>