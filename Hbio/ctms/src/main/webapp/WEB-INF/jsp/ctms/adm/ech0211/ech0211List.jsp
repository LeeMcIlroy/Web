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
		//목록 context menu 설정
	    $.contextMenu({
	        selector: '#contextMenu .keyv', 
	        build: function ($trigger) {
	        	var str = $trigger.text();
	        	var strdisp = str.slice((str.length*-1)+8, str.length);
	            var paramKeyNo = str.substr(0,8);
	        	
	            var options = {
	                items: {
	                    "fold1": {
	                        "name": "레코드건수/페이지", 
	                        "items": {
	                            "fold1a-key1": {"name": "기본설정"},
	                            "fold1a-key2": {"name": "30"},
	                            "fold1a-key3": {"name": "50"},
	                            "fold1a-key4": {"name": "100"}
	                        }
	                    },
	                    "sep2": "---------",
	                },
	                callback: function (key, opts, e) {
	                    console.log(key);
	                    if (key == "CRF작성") {
	                        $("#listForm").attr("action","<c:url value='/qxsepmny/ecr0101/ecr0101List.do'/>").submit();
	                    }
	                    if (key == "view") {		                    
	                    	fn_view('HNBSRC',paramKeyNo);
	                    	//$("#csNo").val(paramKeyNo);
	                    	//var actionUrl = "<c:url value='/qxsepmny/ech0901/ech0901View.do'/>";
	                        /* var actionUrl = "<c:url value='/qxsepmny/ech0901/ech0901View.do'/>"+"?paramKeyNo="+paramKeyNo; */
	                        //$("#listForm").attr("action",actionUrl).submit();
	                    }
	                    if (key == "add") {
	                    	fn_view('HNBSRC',paramKeyNo);
	                    	//fn_modify();
	                    }
	                    if (key == "edit") {
	                    	fn_view('HNBSRC',paramKeyNo);
	                    	//$("#csNo").val(paramKeyNo);
	                    	//var actionUrl = "<c:url value='/qxsepmny/ech0901/ech0901Modify.do'/>";
	                        /* var actionUrl = "<c:url value='/qxsepmny/ech0901/ech0901Modify.do'/>"+"?paramKeyNo="+paramKeyNo; */
	                        //$("#listForm").attr("action",actionUrl).submit();
	                    }
	                    if (key == "del") {
	                    	fn_delOne(paramKeyNo);
	                    }
	                    if (key == "delAll") {
	                    	fn_del();
	                    }
	                    if (key == "excel") {
	                    	fn_excelDown();
	                    }
	                    if (key == "addAll") {
	                    	fn_AddAllUpload();
	                    }
	                    if (key == "addVend") {
	                    	fn_regVend();
	                    }
	                    if (key == "fold1a-key1") {
	                    	$("#recordCountPerPage").val(20);
	                    	fn_list(1);
	                    }
	                    if (key == "fold1a-key2") {
	                    	$("#recordCountPerPage").val(30);
	                    	fn_list(1);
	                    }
	                    if (key == "fold1a-key3") {
	                    	$("#recordCountPerPage").val(50);
	                    	fn_list(1);
	                    }
	                    if (key == "fold1a-key4") {
	                    	$("#recordCountPerPage").val(100);
	                    	fn_list(1);
	                    }
	                    if (key == 'quit') return;
	                    return false;
	                }
	            };
	            options.items["CRF작성"] = { 
	                name: "eCRF작성 이동 " 
	            };
	            options.items["view"] = { 
	                    name: "View " 
	                };
	            options.items["add"] = { 
	                    name: "Add " 
	                };
	            options.items["edit"] = { 
	                    name: "Edit " + strdisp,
	                    icon: function () { 
	                        return 'context-menu-icon context-menu-icon-edit'; 
	                    }
	                };
	            /* options.items["del"] = { 
	                    name: "Delete " + strdisp,
	                    icon: function () { 
	                        return 'context-menu-icon context-menu-icon-cut'; 
	                    }
	                }; */
	            /* options.items["excel"] = { 
	                    name: "Excel "
	                }; */
	            /* options.items["addAll"] = { 
	                    name: "일괄등록 "
	                };
	            options.items["delAll"] = { 
	                    name: "일괄삭제 ",
	                    icon: function () { 
	                        return 'context-menu-icon context-menu-icon-delete'; 
	                    }
	                }; */
	            options.items["addVend"] = { 
	                    name: "고객사간편등록 "
	                };
	            /* options.items["addMyMenu"] = { 
	                    name: "마이메뉴등록 "
	                }; */
	            options.items["quit"] = { 
	                name: "Quit", 
	                icon: function () { 
	                    return 'context-menu-icon context-menu-icon-quit'; 
	                }
	            };  
	            return options;
	        }
	    });
	    
	  	//상단 메뉴 바로가기 context menu
	    fn_contextMenu2();
	});

	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0211/ech0211List.do'/>").submit();
	}

	function fn_view(corpCd, rsNo, rsiCnt){
		$("#corpCd").val(corpCd);
		$("#rsNo").val(rsNo);
		$("#rsiCnt").val(rsiCnt);
		$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0211/ech0211Modify.do'/>").submit();
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
	
	//고객사 간편등록 팝업
	function fn_regVend(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0901/ech0901VendmgPop.do'/>?corpCd="+corpCd
				, '고객사간편등록', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>CRF설정관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="CRF설정관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<form:form commandName="searchVO" id="listForm" name="listForm" method="post">
				<input type="hidden" id="rsNo" name="rsNo"/>
				<input type="hidden" id="corpCd" name="corpCd"/>
				<input type="hidden" id="rsiCnt" name="rsiCnt"/>
				<!-- 검색영역 -->
				<div class="srch_area" id="contextMenu2">
					<ul>
						<li>
							<p>연도</p>
							<%-- <span class="type01">
								<form:input path="searchCondition1" placeholder="연구코드" />
							</span> --%>
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
							<p>eCRF상태</p>
							<span>
								<form:select path="searchCondition5">
									<form:option value="">전체</form:option>
									<c:forEach items="${stateList }" var="state">
										<form:option value="${state.cd }"><c:out value="${state.cdName }"/></form:option>
									</c:forEach>
								</form:select>
							</span>
						</li>
						<li>
							<p>기간</p>
	                        <span>
	                            <form:select path="searchCondition4" onchange="fn_resetTerm(); return false;">
									<form:option value="">검색조건</form:option>
									<form:option value="1">연구시작</form:option>
									<form:option value="2">연구종료</form:option>
								</form:select>
	                        </span>
							<span>
								<form:input path="searchCondition1" id="datepicker01" class="date" readonly="true"/>
								<label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
							<em>~</em>
							<span>
								<form:input path="searchCondition2" id="datepicker02" class="date" readonly="true"/>
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
								<form:select path="searchType" onchange="fn_resetWord(); return false;">
									<form:option value="">검색조건</form:option>
									<form:option value="1">전체</form:option>
									<form:option value="2">연구명</form:option>
									<form:option value="3">연구코드</form:option>
								</form:select>
							</span>
	                        <span class="type02">
	                            <form:input path="searchWord" placeholder="검색어 입력" />
	                        </span>
						</li>
					</ul>
					<!-- 조회버튼 -->
					<a href="#" onclick="fn_list('1'); return false;">조회</a>
				</div>
				<!-- //검색영역 -->
				<!-- 테이블 상단 정보 -->
				<div class="tbl_top_info">
					<span>총<strong><c:out value="${totalCount }"/></strong>건</span>
					<!-- 버튼 -->
					<div>
						<!-- <a href="#" onclick="fn_excelDown(); return false;" class="btn_excel">엑셀</a> -->
					</div>
				</div>
				<!-- //테이블 상단 정보 -->
				<!-- 목록 -->
				<table class="tbl_list tr_link">
					<colgroup>
						<col style="width:5%" />
						<col style="width:10%" />
						<col style="width:12%" />
						<col style="width:auto" />
						<col style="width:10%" />
						<col style="width:8%" />
						<col style="width:8%" />
	                    <col style="width:8%" />
	                    <col style="width:8%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">*연구코드</th>
							<th scope="col">연구분야</th>
							<th scope="col">*연구명</th>
							<th scope="col">연구상태</th>
							<th scope="col">피험자수</th>
	                        <th scope="col">eCRF상태</th>
							<th scope="col">템플릿수</th>
							<th scope="col">총구성쪽수</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${resultList != null && resultList.size() != 0 }">
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr id="contextMenu" onclick="fn_view('<c:out value="${result.corpCd }"/>', '<c:out value="${result.rsNo }"/>', '<c:out value="${result.rsiCnt }"/>'); return false;">
										<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
										<td class="keyv" ><span style="display:none"><c:out value="${result.rsNo }"/></span><c:out value="${result.rsCd }"/></td>						
										<td><c:out value="${result.rsNo3Nm }"/></td>						
										<td class="keyv" ><span style="display:none"><c:out value="${result.rsNo }"/></span><c:out value="${result.rsName }"/></td>
										<td>
											<c:choose>
				                          		<c:when test="${result.dataLockYn eq 'Y' }"><c:out value="${result.rsstClsNm }"/><span style="color:red;">(Data Locked)</span></c:when>
				                          		<c:when test="${result.dataLockYn eq 'N' }"><c:out value="${result.rsstClsNm }"/></c:when>
		                          			</c:choose>
										<td><c:out value="${result.rsiCnt }"/></td>
										<td><c:out value="${result.stateClsNm }"/></td>
										<td><c:out value="${result.ecrfCnt }"/></td>
										<td><c:out value="${result.tpageCnt }"/></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="nodata" colspan="9">CRF설정관리 정보가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<!-- //목록 -->
				<!-- 페이징 -->
				<div class="pagenate">
					<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
					<form:hidden path="pageIndex"/>
					<form:hidden path="recordCountPerPage" />
				</div>
				<!-- //페이징 -->
			</form:form>
		</div>
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>