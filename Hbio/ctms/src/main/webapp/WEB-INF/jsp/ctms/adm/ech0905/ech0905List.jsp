<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.ui.position.js"></script>
<script type="text/javascript"> 
	$(function(){
		//엑셀다운로드권한 
		var ynexauth = '<c:out value="${exauth}"/>';
		if(ynexauth=='N') {
			$('.btn_excel').css("display","none");
		}
		
		//자산 목록 선택
		$("#all-chk").change(function(){
			$("input[name=keySeq]").prop("checked", $(this).prop('checked'));
		});
				
	})
	
	$(function(){
        $.contextMenu({
            selector: '#contextMenuTest .keyv', 
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
                        if (key == "견적관리") {
                            $("#listForm").attr("action","<c:url value='/qxsepmny/ech0902/ech0902List.do'/>").submit();
                        }
                        if (key == "view") {
                            var actionUrl = "<c:url value='/qxsepmny/ech0905/ech0905View.do'/>"+"?paramKeyNo="+paramKeyNo;
                            $("#listForm").attr("action",actionUrl).submit();
                        }
                        if (key == "add") {
                        	fn_modify();
                        }
                        if (key == "edit") {
                            var actionUrl = "<c:url value='/qxsepmny/ech0905/ech0905Modify.do'/>"+"?paramKeyNo="+paramKeyNo;
                            $("#listForm").attr("action",actionUrl).submit();
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
                        if (key == "disAll") {
                        	fn_open();
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
                options.items["견적관리"] = { 
                    name: "견적관리 이동 " 
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
                options.items["del"] = { 
                        name: "Delete " + strdisp,
                        icon: function () { 
                            return 'context-menu-icon context-menu-icon-cut'; 
                        }
                    };
                options.items["excel"] = { 
                        name: "Excel "
                    };
                options.items["addAll"] = { 
                        name: "일괄등록 "
                    };
                options.items["disAll"] = { 
                        name: "일괄폐기 "
                    };
                options.items["delAll"] = { 
                        name: "일괄삭제 ",
                        icon: function () { 
                            return 'context-menu-icon context-menu-icon-delete'; 
                        }
                    };
                /* options.items["addVend"] = { 
                        name: "구매처간편등록 "
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
    });

	$(function(){
        $.contextMenu({
            selector: '#contextMenuTest2', 
            build: function ($trigger) {
                
                var options = {
                    items: {
                    	 /* "edit": {name: "Edit", icon: "fa-edit"},
                         "cut": {name: "Beer", icon: "fa-beer"},
                         copy: {name: "Cloud download", icon: "fa-cloud-download"},
                         "paste": {name: "Certificate", icon: "fa-certificate"} */
                    },
                    callback: function (key, opts, e) {
                        console.log(key);
                        if (key == "1") {
                            $("#listForm").attr("action","<c:url value='/qxsepmny/ech0401/ech0401List.do'/>").submit();
                        }
                        if (key == "2") {
                            $("#listForm").attr("action","<c:url value='/qxsepmny/ech0105/ech0105List.do'/>").submit();
                        }
                        if (key == "3") {
                            $("#listForm").attr("action","<c:url value='/qxsepmny/ech0102/ech0102List.do'/>").submit();
                        }
                        if (key == "4") {
                            $("#listForm").attr("action","<c:url value='/qxsepmny/ech0301/ech0301List.do'/>").submit();
                        }
                        if (key == "5") {
                            $("#listForm").attr("action","<c:url value='/qxsepmny/ech0704/ech0704List.do'/>").submit();
                        }
                        if (key == "6") {
                            $("#listForm").attr("action","<c:url value='/qxsepmny/lgn/admLogout.do'/>").submit();
                        }
                        
                        if (key == 'quit') return;
                        return false;
                    }
                };
                options.items["1"] = { 
                    name: "시험결과추출 " 
                };
                options.items["2"] = { 
                        name: "연구계획서 " 
                    };
                options.items["3"] = { 
                        name: "피험자선정 "
                    };
                options.items["4"] = { 
                        name: "피험자관리 "
                    };
                options.items["5"] = { 
                        name: "고객사관리 "
                    };
                options.items["6"] = {
                        name: "로그아웃 "
                    };
                options.items["quit"] = { 
                    name: "Quit", 
                    icon: function () { 
                        return 'context-menu-icon context-menu-icon-quit'; 
                    }
                };
                
                return options;
            }
        });
    });
	
	//일괄 폐기
	function fn_open(){
		
		if($("input[name=keySeq]:checked").length == 0){
			alert('자산정보를 선택해 주세요.');
			return;
		}
		$("#datepicker03").datepicker().datepicker("setDate", new Date());
		$("#modi-pop").prop("checked", "true");
	}
	
	function fn_step(){
		if(confirm('선택하신 자산정보를 일괄폐기합니다. 폐기일자와 사용안함으로 설정됩니다.\r\n폐기하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var step1 = $("#datepicker03").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0905/ech0905AjaxSaveDisDt.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"step1="+step1+"&"+$("input[name=keySeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					$("#modi-pop").click();
					fn_list(1);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	//상세보기 화면
	function fn_view(corpCd, astNo){
		$("#corpCd").val(corpCd);
	 	$("#astNo").val(astNo);
	 	//var str = $("#searchWord").val();
		//$("#searchWord").val(encodeURIComponent(str));
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0905/ech0905View.do'/>").submit();
	}
	
	//등록 화면
	function fn_modify(){
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0905/ech0905Modify.do'/>").submit();
	}
	
	/* //자산정보 일괄등록 화면
	function fn_AstUpload(){
		if(confirm('일괄등록 화면으로 전환됩니다. \r\n진행하시겠습니까?')){
	 		$("#listForm").attr("action","<c:url value='/qxsepmny/ech0905/ech0905AstUpload.do'/>").submit();
		}
	} */
	
	//일괄등록 화면 전환
	function fn_AddAllUpload(){
		if(confirm('(자산)일괄등록 화면으로 전환됩니다. \r\n진행하시겠습니까?')){
			$("#uploadFlag").val("AST");
			$("#listForm").attr("action","<c:url value='/qxsepmny/cmm/CmmUplsUpload.do'/>").submit();
		}
	}
	
	//자산관리 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0905/ech0905List.do'/>").submit();
	}
	
	//자산관리 목록 엑셀다운로드
	function fn_excelDown(){
		if(confirm('출력하는 데이터건수에 따라 시간이 지체될 수 있습니다. \r\n진행하시겠습니까?')){
			$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0905/ech0905Excel.do'/>").submit();
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
	
	// 자산 일괄 삭제
	function fn_del(){
		
		if($("input[name=keySeq]:checked").length == 0){
			alert('삭제할 자산 정보를 선택해 주세요.');
			return;
		}
		if(confirm('선택하신 자산 정보를 삭제합니다. 삭제한 정보는 복구할 수 없습니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0905/ech0905AjaxAstDel.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=keySeq]:checked").serialize()
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
	
	// 자산 건별 삭제
	function fn_delOne(paramKeyNo){
		
		if(confirm('자산 정보를 삭제합니다. 삭제한 정보는 복구할 수 없습니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var step1 = "Y";
			var step2 = "N";
			//var keySeq[] = paramKeyNo;
			var keySeq = [ paramKeyNo ];
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0905/ech0905AjaxAstDel.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"step1="+step1+"&"+"step2="+step2+"&"+"keySeq="+keySeq
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
	
	//구매처 간편등록 팝업
	function fn_regVend(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0905/ech0905VendmgPop.do'/>?corpCd="+corpCd
				, '구매처간편등록', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>자산관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="영업관리"/>
	            <jsp:param name="dept2" value="자산관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<form:form commandName="searchVO" id="listForm" name="listForm">
				<input type="hidden" id="corpCd" name="corpCd"/>
				<input type="hidden" id="astNo" name="astNo"/>
				<input type="hidden" id="uploadFlag" name="uploadFlag"/>
				<!-- 검색영역 -->
				<div class="srch_area" id="contextMenuTest2">
					<ul>
						<%-- <li>
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
						</li> --%>
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
						</li> --%>
	                    <li>
							<p>자산분류</p>
							<span>
								<!-- 자산분류 목록(공통코드) CM4000M - CM1370   -->
								<select id="searchCondition6" name="searchCondition6">
									<option value="">선택</option>
									<c:if test="${searchVO.searchCondition6 eq '' }">selected="selected"</c:if>
									<c:forEach var="result" items="${cm1370}">									
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
									<option value="1" <c:if test="${searchVO.searchCondition4  eq '1' }">selected="selected"</c:if> >구입일</option>
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
							<p>사용여부</p>
							<span>
								<select name="searchCondition5" id="searchCondition5">
									<option value="" <c:if test="${searchVO.searchCondition5  eq '' }">selected="selected"</c:if> >선택</option>
									<option value="Y" <c:if test="${searchVO.searchCondition5  eq 'Y' }">selected="selected"</c:if> >사용</option>
									<option value="N" <c:if test="${searchVO.searchCondition5  eq 'N' }">selected="selected"</c:if> >폐기</option>
								</select> 
							</span>
						</li>                    
	                    <li>
							<p>검색어</p>
							<span>
								<select name="searchCondition3" id="searchCondition3" onchange="fn_resetWord(); return false;">
									<option value="" <c:if test="${searchVO.searchCondition3  eq '' }">selected="selected"</c:if> >선택</option>
									<option value="1" <c:if test="${searchVO.searchCondition3  eq '1' }">selected="selected"</c:if> >전체</option>
									<option value="2" <c:if test="${searchVO.searchCondition3  eq '2' }">selected="selected"</c:if> >자산명</option>
									<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >제조사</option>
									<option value="4" <c:if test="${searchVO.searchCondition3  eq '4' }">selected="selected"</c:if> >구매처</option>
									<option value="5" <c:if test="${searchVO.searchCondition3  eq '5' }">selected="selected"</c:if> >책임자</option>
								</select>
							</span>
	                        <span class="type02">
	                            <input type="text" name="searchWord" id="searchWord" value="${searchVO.searchWord }" class="input-data" placeholder="자산명,제조사,구매처를 입력하세요" style="width: 248px;"/>
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
						<!-- <a href="#" class="btn_sub" onclick="fn_regVend(); return false;" id="btnDel">구매처 간편등록</a> -->
						<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_open(); return false;">일괄폐기</a>
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
						<col style="width:8%" />
						<col style="width:12%" />
						<col style="width:auto" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:8%" />
						<col style="width:8%" />
	                    <col style="width:6%" />
	                    <col style="width:8%" />
	                    <col style="width:6%" />
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" id="all-chk"/></th>
							<th scope="col">번호</th>
							<th scope="col">분류</th>
							<th scope="col">자산코드</th>
							<th scope="col">명칭</th>
							<th scope="col">제조사</th>
							<th scope="col">구매처</th>
							<th scope="col">구매일</th>
							<th scope="col">폐기일</th>
							<th scope="col">책임자</th>
	                        <th scope="col">지사</th>
	                        <th scope="col">사용</th>
	                        
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr id="contextMenuTest">
								<td><input type="checkbox" name="keySeq" value="<c:out value='${result.astNo }'/>"/></td>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
								<td><c:out value="${result.astClsNm }"/></td>
								<td class="keyv" onclick="fn_view('<c:out value='${result.corpCd}'/>','<c:out value='${result.astNo}'/>'); return false;" style="text-decoration: underline;"><span style="display:none"><c:out value="${result.astNo }"/></span><c:out value="${result.astCd }"/></td>
		         	            <td class="keyv" onclick="fn_view('<c:out value='${result.corpCd}'/>','<c:out value='${result.astNo}'/>'); return false;" style="text-decoration: underline;"><span style="display:none"><c:out value="${result.astNo }"/></span><c:out value="${result.astName }"/></td>
		         	            <td><c:out value="${result.fctvName }"/></td>
		                        <td><c:out value="${result.pchvName }"/></td>
		                        <td><c:out value="${result.pchDt }"/></td>
		                        <td><c:out value="${result.disDt }"/></td>
								<td class="ta_l"><c:out value="${result.empName }"/></td>
								<td><c:out value="${result.branchName }"/></td>
								<td>
									<c:choose>
		                          		<c:when test="${result.useYn eq 'Y' }">사용</c:when>
		                          		<c:when test="${result.useYn eq 'N' }"><span style="color:red;">폐기</span></c:when>
	                          		</c:choose>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${resultList.size() == 0 }">
							<tr>
								<td class="nodata" colspan="12">자산정보가 없습니다.</td>
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
					<a href="#" onclick="fn_AddAllUpload(); return false;">자산일괄등록</a>
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
				<h4>폐기일자 설정</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 사용체크정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
				</colgroup>
				<tbody>			
					<tr>
						<th scope="row">폐기일자</th>
						<td colspan="3">
							<div>
								<input name="step1" id="datepicker03" placeholder="0000-00-00"  class="required" title="폐기일자" />
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
