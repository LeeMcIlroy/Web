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
	})

	$(function(){
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
                        if (key == "excel") {
                        	fn_excelDown();
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
                options.items["excel"] = { 
                        name: "Excel "
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
        
        //상단 메뉴 바로가기 context menu
        fn_contextMenu2();
    });
	
	//로그인접속 목록으로
	function fn_list(pageNo){
		var dateStdt = $("#datepicker01").val();
		var dateEndt = $("#datepicker02").val();
				
		if(dateStdt > dateEndt){
			alert('시작일자를 조정해주세요')
			$('#datepicker01').focus();
			return;
		}
		
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0801/ech0801List.do'/>").submit();
	}
		
	//로그인접속 엑셀다운로드
	function fn_excelDown(){
		if(confirm('출력하는 데이터건수에 따라 시간이 지체될 수 있습니다. \r\n진행하시겠습니까?')){
			$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0801/ech0801Excel.do'/>").submit();
		}
	}
	
	// from ~ to 기간 확인  	
	function fn_date(i){
		$("input[name=period]:checked").attr("checked", false);
		var termDate = 365; // 차이일수 설정 
		var staDate = new Date($("#datepicker01").val());
		var endDate = new Date($("#datepicker02").val())
		var dateDiff = Math.ceil((endDate.getTime() - staDate.getTime())/(1000*3600*24));
		if(dateDiff > termDate || dateDiff < -termDate){
			$("#datepicker02").val("");
			$("#datepicker02").focus();
			alert('작업기간은 '+termDate+'일 이내로 검색할 수 있습니다.');
		}
	}
	
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

		// 1 1년  2 3개월  3 1개월
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
	
</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" id="corpCd" name="corpCd"/>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>운영관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="운영관리"/>
	            <jsp:param name="dept2" value="로그인접속"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<div class="srch_area" id="contextMenu2">
				<ul>
					<li>
						<p>기간</p>
                        <span>
                            <select>
								<option>접속일자</option>
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
						</span>
					</li>
					<li>
					<p>검색어</p>
						<span>
							<select name="searchCondition3" id="searchCondition3" onchange="fn_resetWord(); return false;">
								<option value="" <c:if test="${searchVO.searchCondition3  eq '' }">selected="selected"</c:if> >선택</option>
								<option value="1" <c:if test="${searchVO.searchCondition3  eq '1' }">selected="selected"</c:if> >전체</option>
								<option value="2" <c:if test="${searchVO.searchCondition3  eq '2' }">selected="selected"</c:if> >작업자</option>
								<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >지사</option>
							</select>
						</span>
                        <span class="type02">
                            <input type="text" name="searchWord" id="searchWord" class="input-data" value="<c:out value="${searchVO.searchWord }" />" placeholder="이름, 지사명을 입력하세요" />
                        </span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_list(1); return false;">조회</a>
			</div>
			<!-- //검색영역 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<span>
					총<strong><c:out value="${totalCount }"/></strong>건
				</span>				
				<!-- 버튼 -->
				<div>
					<a href="#" onclick="fn_excelDown(); return false;" class="btn_excel">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<!-- 목록 -->
			<table class="tbl_list tr_link">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:auto" />
					<col style="width:10%" />
					<col style="width:20%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">구분</th>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">소속지사</th>
						<th scope="col">접속IP</th>
						<th scope="col">접속일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr id="contextMenu">
							<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
							<td><c:out value="${result.loginTypeNm}"/></td>								
	                        <td class="keyv"><c:out value="${result.userId}"/></td>
							<td class="keyv"><c:out value="${result.empName}"/></td>
							<td><c:out value="${result.branchNm}"/></td>
							<td><c:out value="${result.acceIp}"/></td>
							<td><c:out value="${result.acceDt}"/></td>
						</tr>
					</c:forEach>
					<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="7">로그인접속 정보가 없습니다.</td>
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
							<form:hidden path="recordCountPerPage" />
						</div>
					</div>
				</div>
				<!-- //페이징 -->
			</div>
			<!-- //목록 하단 -->
		</div>
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