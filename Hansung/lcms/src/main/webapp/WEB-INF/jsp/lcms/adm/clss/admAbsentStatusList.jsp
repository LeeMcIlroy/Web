<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_list(idx){
		$("#pageIndex").val(idx);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admAbsentStatusList.do'/>").submit();
	}

	function fn_list2(idx){
		$("#pageIndex2").val(idx);
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admAbsentStatusList.do'/>").submit();
	}
	
	function fn_date(i){
		var staDate = new Date($("#datepicker01").val());
		var endDate = new Date($("#datepicker02").val())
		var dateDiff = Math.ceil((endDate.getTime() - staDate.getTime())/(1000*3600*24));
		if(dateDiff > 7 || dateDiff < -7){
			$("#datepicker02").val("");
			$("#datepicker02").focus();
		}
	}
	function getDateRange(startDate, endDate, listDate){
        var dateMove = new Date(startDate);
        var strDate = startDate;
        if (startDate == endDate){
            var strDate = dateMove.toISOString().slice(0,10);
            listDate.push(strDate);
        }else{
            while (strDate < endDate){
                var strDate = dateMove.toISOString().slice(0, 10);
                listDate.push(strDate);
                dateMove.setDate(dateMove.getDate() + 1);
            }
        }
        return listDate;
    };

	$(document).ready(function(){
		var year = $("#searchCondition1").val();
		var sem = $("#semEster").val();
		var sDate = $("#datepicker01").val();
		var eDate = $("#datepicker02").val();
		var listDate = [];
		getDateRange(sDate, eDate, listDate);
		var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
		
		$.ajax({
			url: "<c:url value='/qxsepmny/clss/admAjaxAbsentList.do'/>"
			, type: "post"
			, data: "searchCondition1="+year+"&searchCondition2="+sem+"&searchCondition3="+sDate+"&searchCondition4="+eDate
			, dataType:"json"
			, success: function(data){
				var resultList = data.resultList;
				var lectList = data.lectList;
				var html = "";
				var totalCnt = 0;
				var delSeq = new Array();
				for (var i = 0; i < listDate.length; i++) {
					var today = new Date(listDate[i]).getDay();
			    	var todayLabel = week[today];
			    	var dateArray = listDate[i].split("-");
					var tot = 0;
			    	html += '<tr>'
					html += '	<td>'+dateArray[1]+"."+dateArray[2]+'</td>';
					html += '	<td>'+todayLabel+'</td>';
					for (var z = 0; z < lectList.length; z++) {
						var chk = true;
						for (var j = 0; j < resultList.length; j++) {
							if(listDate[i] == resultList[j].attDate){
								if(lectList[z].lectName == resultList[j].lectName && lectList[z].lectDivi == resultList[j].lectDivi){
									if(resultList[j].attend == 1){
										html += '	<td id="atd'+j+'">결석자 없음</td>';
										chk = false;
									}else if(resultList[j].attend == 2){
										if(j > 0){
											if(resultList[j-1].lectName == resultList[j].lectName && resultList[j-1].lectDivi == resultList[j].lectDivi && resultList[j-1].attDate == resultList[j].attDate){
												delSeq.push(j-1);
												html += '	<td id="atd'+j+'">'+resultList[j].cnt+'</td>';
												tot += resultList[j].cnt;
												totalCnt += resultList[j].cnt;
												chk = false;
											}else{
												html += '	<td id="atd'+j+'">'+resultList[j].cnt+'</td>';
												tot += resultList[j].cnt;
												totalCnt += resultList[j].cnt;
												chk = false;
											}
										}else if(j == 0){
											html += '	<td id="atd'+j+'">'+resultList[j].cnt+'</td>';
											tot += resultList[j].cnt;
											totalCnt += resultList[j].cnt;
											chk = false;
										}
									}
								}
							}
						}
						if(chk){
							html += '	<td></td>';
						}
					}
					if(tot == 0){
						html += '	<td></td>';
					}else{
						html += '	<td>'+tot+'</td>';
					}
					html += '</tr>';
				}
				
				var totList = data.totList;
				html += '<tr>'
				html += '	<td>계</td>'
				html += '	<td></td>'
					for (var z = 0; z < lectList.length; z++) {
						var chk2 = true;
						for (var j = 0; j < totList.length; j++) {
							if(lectList[z].lectName == totList[j].lectName && lectList[z].lectDivi == totList[j].lectDivi){
								html += '	<td>'+totList[j].totcnt+'</td>';
								chk2 = false;
							}
						}
						if(chk2){
							html += '	<td></td>';
						}
					}
				html += '	<td>'+totalCnt+'</td>';
				html += '</tr>'
						
				/* if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="'+$("#lectLength").val()+'">검색 결과가 없습니다.</td>';
					html += '</tr>';
				} */
				$("#absent").html(html);
				
				for (var d = 0; d < delSeq.length; d++) {
					$("#atd"+delSeq[d]).remove();
				}
				
				var count = '<strong>'+resultList.length+'</strong>건이 검색되었습니다.';
				$(".search-count").html(count);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
		
		//두 날짜 사이의 날짜들 구하기
		/* var listDate = [];
		var staDate = $("#datepicker01").val();
		var endDate = $("#datepicker02").val();
		getDateRange(staDate, endDate, listDate);
		//그 날짜의 요일
		var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
		for (var i = 0; i < listDate.length; i++) {
		    var today = new Date(listDate[i]).getDay();
		    var todayLabel = week[today];
		} */

	}); 
	
	//팝업창
	//교사생찾기 팝업
    function searchAbse(memberCode){
    	var year = $("#searchCondition1").val();
		var sem = $("#semEster").val();
		var sDate = $("#datepicker01").val();
		var eDate = $("#datepicker02").val();
		$.ajax({
			url: "<c:url value='/qxsepmny/clss/admAjaxAbsentPoPSearchList.do' />"
			, type: "post"
			, data: "memberCode="+memberCode+"&year="+year+"&sem="+sem+"&sDate="+sDate+"&eDate="+eDate
			, dataType:"json"
			, success: function(data){
				var resultList = data.searchList;
				if(resultList.length != 0){
				  	 $(".pop-bg").css("display", "block" );
		   			 fn_select(memberCode);
				}else{
					alert("상담이력이 없습니다.")
				}
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		}); 
    }
	//팝업창 닫기
    function fn_close(){
    	 $(".pop-bg").css("display", "none" );
    }
	//null값 체크 
	function isEmpty(value){
		if(value == null || value.length === 0) {
	    	return "";
		} else{
			return value;
		}
	}
	//팝업 검색
	function fn_select(memberCode){
		var year = $("#searchCondition1").val();
		var sem = $("#semEster").val();
		var sDate = $("#datepicker01").val();
		var eDate = $("#datepicker02").val();
		$.ajax({
			url: "<c:url value='/qxsepmny/clss/admAjaxAbsentPoPSearchList.do' />"
			, type: "post"
			, data: "memberCode="+memberCode+"&year="+year+"&sem="+sem+"&sDate="+sDate+"&eDate="+eDate
			, dataType:"json"
			, success: function(data){
				var resultList = data.searchList;
				var html = '';
				
				for(var i=0; i < resultList.length; i++){
					html += '<tr>';
					html += '	<td class="txt-c" rowspan="2">'+(resultList.length - i)+'</td>';
					html += '	<td class="txt-c" rowspan="2">'+resultList[i].attDate+'('+resultList[i].attWeek+')</td>';
					html += '	<td class="txt-c" rowspan="2">'+isEmpty(resultList[i].lectGrade)+isEmpty(resultList[i].lectDivi)+'</td>';
					html += '	<td class="txt-c" rowspan="2">'+isEmpty(resultList[i].name)+'</td>';
					html += '	<td class="txt-c" rowspan="2">'+isEmpty(resultList[i].nation)+'</td>';
					html += '	<td class="txt-c" rowspan="2">'+isEmpty(resultList[i].gender)+'</td>';
					html += '	<td class="txt-c">1</td>';
					
					if(resultList[i].firstTel == 'Y'){
						html += '	<td class="txt-c">○</td>';
					}else {
						html += '	<td class="txt-c"> </td>';
					}
					if(resultList[i].firstSns == 'Y'){
						html += '	<td class="txt-c">○</td>';
					}else {
						html += '	<td class="txt-c"> </td>';
					}
					if(resultList[i].firstTeam == 'Y'){
						html += '	<td class="txt-c">○</td>';
					}else {
						html += '	<td class="txt-c"> </td>';
					}
					if(resultList[i].firstEtc == 'Y'){
						html += '	<td class="txt-c">○</td>';
					}else{
						html += '	<td class="txt-c"> </td>';
					}
					
					html += '	<td class="txt-c">'+isEmpty(resultList[i].firstReason)+'</td>';
					html += '	<td class="txt-c">'+isEmpty(resultList[i].firstFolup)+'</td>';
					html += '</tr>';
					html += '<tr>';
					html += '	<td class="txt-c">2</td>';

					if(resultList[i].secondTel == 'Y'){
						html += '	<td class="txt-c">○</td>';
					}else {
						html += '	<td class="txt-c"> </td>';
					}
					if(resultList[i].secondSns == 'Y'){
						html += '	<td class="txt-c">○</td>';
					}else {
						html += '	<td class="txt-c"> </td>';
					}
					if(resultList[i].secondTeam == 'Y'){
						html += '	<td class="txt-c">○</td>';
					}else {
						html += '	<td class="txt-c"> </td>';
					}
					if(resultList[i].secondEtc == 'Y'){
						html += '	<td class="txt-c">○</td>';
					}else{
						html += '	<td class="txt-c"> </td>';
					}
					
					html += '	<td class="txt-c">'+isEmpty(resultList[i].secondReason)+'</td>';
					html += '	<td class="txt-c">'+isEmpty(resultList[i].secondFolup)+'</td>';
					html += '</tr>';
				}
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td class="txt-c" colspan="13">검색결과가없습니다.</td>';
					html += '</tr>';
				}
				
				$("#searchAbsent").html(html);
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
		            <jsp:param name="dept2" value="결석자현황"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
					<form:hidden path="searchLecture"/>
					<form:hidden path="searchMemberCode"/>
					<input type="hidden" id="lectLength" value="${lectList.size()+3}"/>
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
										<col />
									</colgroup>
									<tbody>
										<tr>
											<td>대상학기</td>
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
											<td>출결기간</td>
											<td>
												<form:input path="searchCondition3" id="datepicker01" class="w173px bl-l bl-r" onchange="fn_date(1); return false;"/>&nbsp;&nbsp;~&nbsp;&nbsp;
												<form:input path="searchCondition4" id="datepicker02" class="w173px bl-l bl-r" onchange="fn_date(2); return false;"/>
											</td>
										</tr>
									</tbody>
								</table>
								<a href="#" onclick="fn_list(1); return false;">검색하기</a>
							</div>
							<!--// 확장 검색조건항목 -->
						</div>
					</div>
					<!--// search -->
					<!--search info-->
					<div class="search-infomation mt20">
						<div class="search-count">
						</div>
						<!--<div class="paging-select">
<%-- 							<c:out value="${paginationInfo.currentPageNo }"/> / <c:out value="${totalPageCount }"/>page &nbsp;&nbsp; --%>
							<form:select path="recordCountPerPage" onchange="fn_list(1); return false;">
								<form:option value="10">10</form:option>
								<form:option value="15">15</form:option>
								<form:option value="20">20</form:option>
								<form:option value="25">25</form:option>
								<form:option value="30">30</form:option>
							</form:select>
						</div>-->
					</div>
					<!--// search info-->
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-list-table">
							<colgroup>
								<col style="width:5%;"/>
								<c:set var="mcode" value=""/>
								<c:forEach items="${lectList }">
									<col />
								</c:forEach>
							</colgroup>
							<thead>
								<tr>
									<th>일자</th>
									<th>요일</th>
									<c:forEach items="${lectList }" var="lect" varStatus="status">
										<th>
											<c:out value="${lect.lectGrade }"/> <c:out value="${lect.lectDivi }"/>
										</th>
									</c:forEach>
									<th>계</th>
								</tr>
							</thead>
							<tbody id="absent">
								<%--
								<c:forEach items="${resultList }" var="list">
									<tr>
										<td>${list.attDate }</td>
										<td>요일</td>
											<c:forEach items="${lectList }" var="lect" varStatus="status">
													<c:choose>
														<c:when test="${lect.lectName eq list.lectName && lect.lectDivi eq list.lectDivi}">
															<td>${list.cnt}</td>
														</c:when>
														<c:otherwise>
															<td></td>
														</c:otherwise>
													</c:choose>
											</c:forEach>
										<td></td>
									</tr>
								</c:forEach> 
								<c:if test="${resultList.size() eq 0 }">
									<tr><td colspan="${lectList.size()+3}">검색 결과가 없습니다.</td></tr>
								</c:if>
								<c:if test="${resultList.size() ne 0 }">
									<tr>
										<td>계</td>
										<td>&nbsp;</td>
										<c:forEach items="${lectList }" var="lect">
											<td></td>
										</c:forEach>
										<td>계</td>
									</tr>
								</c:if>
							--%>
							</tbody>
						</table>
					</div>
					<!-- //table -->
					<!-- ////////////////////////////////////////////////////// 하단 목록 ////////////////////////////////////////////////////// -->
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-list-table">
							<colgroup>
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
									<th>급/반</th>
									<th>이름</th>
									<th>학번</th>
									<th>국적</th>
									<th>성별</th>
									<th>현재출석율(%)</th>
									<th>결석시간</th>
									<th>결석일자</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${stdList }" var="list">
									<tr>
										<td><c:out value="${list.lectGrade }"/>급 <c:out value="${list.lectDivi }"/></td>
										<td><a href="" onclick="searchAbse('<c:out value="${list.memberCode }"/>'); return false;" class="underline"><c:out value="${list.name }"/></a></td>
										<td><a href="" onclick="searchAbse('<c:out value="${list.memberCode }"/>'); return false;" class="underline"><c:out value="${list.memberCode }"/></a></td>
										<td><c:out value="${list.nation }"/></td>
										<td><c:out value="${list.gender }"/></td>
										<td><c:out value="${list.avgAtte }"/></td>
										<td><c:out value="${list.abseCnt }"/></td>
										<td><c:out value="${list.dt }"/></td>
									</tr>
								</c:forEach>
								<c:if test="${stdList.size() eq 0 }">
									<tr><td colspan="8">검색 결과가 없습니다.</td></tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<!-- ////////////////////////////////////////////////////// 하단 목록 ////////////////////////////////////////////////////// -->
					<!-- 팝업 -->
					<div class="pop-bg">
						<div class="pop-table">
							<!-- table -->
							<div class="list-table-box">
								<table class="normal-wmv-table">
									<colgroup>
										<col style="width:15%;" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th class="txt-l" colspan="2"><strong>상담이력</strong></th>
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
										<col />
										<col />
									</colgroup>
									<thead>
										<tr>
											<th rowspan="2">No.</th>
											<th rowspan="2">결석일자</th>
											<th rowspan="2">급/반</th>
											<th rowspan="2">이름</th>
											<th rowspan="2">국적</th>
											<th rowspan="2">성별</th>
											<th rowspan="2">회차</th>
											<th colspan="4">상담방법</th>
											<th rowspan="2">결석사유</th>
											<th rowspan="2">후속조치</th>
										</tr>
										<tr>
											<th>전화</th>
											<th>SNS</th>
											<th>국제교류팀</th>
											<th>기타</th>
										</tr>
									</thead>
									<tbody>
									<tbody id="searchAbsent">
									</tbody>
								</table>
							</div>
							<!--// table -->
								<!-- table button -->
							<div class="table-button">
								<div class="btn-box">
									<!-- <button type="button" class="white btn-newwrite" onclick="fn_printPrf(); return false;">인쇄</button> -->
									<button type="button" class="white btn-cancel" onclick="fn_close(); return false;">닫기</button>
								</div>
							</div>
							<!--// table button -->
						</div>
					</div>
					<!-- // 팝업 -->
					<div class="table-button">
						<div class="btn-box">
<!-- 							<button type="button" class="white btn-down">Download</button> -->
						</div>
					</div>
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