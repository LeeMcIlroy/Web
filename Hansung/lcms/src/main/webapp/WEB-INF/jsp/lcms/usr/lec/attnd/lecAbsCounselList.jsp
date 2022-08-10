<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script>
		function closeLayer( obj ) {
			$(obj).parent().parent().hide();
		}

		$(function(){

			/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
			$('.imgSelect').click(function(e)
			{
				var sWidth = window.innerWidth;
				var sHeight = window.innerHeight;

				var oWidth = $('.popupLayer').width();
				var oHeight = $('.popupLayer').height();

				// 레이어가 나타날 위치를 셋팅한다.
				var divLeft = e.clientX + 10;
				var divTop = e.clientY + 5;

				// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
				if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
				if( divTop + oHeight > sHeight ) divTop -= oHeight;

				// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
				if( divLeft < 0 ) divLeft = 0;
				if( divTop < 0 ) divTop = 0;

				$('.popupLayer').css({
					"top": divTop,
					"left": divLeft,
					"position": "absolute"
				}).show();
			});

		});
		
		function fn_list(idx){
			$("#pageIndex").val(idx);
			$("#frm").attr("action", "<c:url value='/usr/lec/attnd/lecAbsCounselList.do'/>").submit();
		}
		
		function fn_modify(attDate, memberCode, absentSeq){
			$("#attDate").val(attDate);
			$("#memberCode").val(memberCode);
			$("#absentSeq").val(absentSeq);
			$("#frm").attr("action", "<c:url value='/usr/lec/attnd/lecAbsCounselModify.do'/>").submit();
		}
		
		// 엑셀 다운로드
		function fn_excelDown(){
			$("#frm").attr("method", "post").attr("action", "<c:url value='/usr/lec/attnd/lecAbsCounselExcel.do'/>").submit();
		}
	</script>
	<style>
	#m-datepicker01, #m-datepicker02 {
		width: 110px !important;
    	text-align: center;
		}
	</style>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">결석자상담</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>출결</span>
						<span>결석자상담</span>
					</div>
				</div>
				<form:form commandName="searchVO" id="frm" name="frm">
					<input type="hidden" name="attDate" id="attDate"/>
					<input type="hidden" name="memberCode" id="memberCode"/>
					<input type="hidden" name="absentSeq" id="absentSeq"/>
					<!-- search -->
					<div class="search-box none-option">
						<input type="checkbox" id="search-option-open" />
						<div class="search web"><!-- 모바일 수정 -->
							<div class="search-input">
								<table class="shearch-option">
									<colgroup>
										<col style="width:8%;" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<td>출결기간</td>
											<td>
												<form:input path="startDate" id="datepicker01" class="w173px bl-l bl-r" />&nbsp;-&nbsp;
												<form:input path="endDate" id="datepicker02" class="w173px bl-l bl-r" />
											</td>
										</tr>
									</tbody>
								</table>
								<a href="#" onclick="fn_list(1);">검색하기</a>
							</div>
							<!--// 확장 검색조건항목 -->
						</div>
						<!-- 모바일 추가 -->
						<input type="checkbox" id="sh-op-cl01" class="hidden" />
						<div class="m-search-btn mob">
							<label for="sh-op-cl01">검색</label>
						</div>
						<div class="m-search mob">
							<div class="m-search-tit">
								<p>검색</p>
								<label for="sh-op-cl01" class="icon-pop-close">검색닫기</label>
							</div>
							<div class="half-sh">
								<ul>
									<li style="width: 38%">
										<form:input path="startDate" id="m-datepicker01" class="w173px bl-l bl-r" style=""/>
										&nbsp;-&nbsp;
									</li>
									<li style="float: left; width: 28%;">
										<form:input path="endDate" id="m-datepicker02" class="w173px bl-l bl-r" />
									</li>
									<li style="width: 15%;margin-top: 15px">
										<div class="search-input">
											<a href="#" onclick="fn_list(1);">검색하기</a>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<!--// 모바일 추가 -->
					</div>
					<!--// search -->
	
					<!--search info-->
					<div class="search-infomation">
						<div class="search-count">
							<strong><c:out value="${paginationInfo.totalRecordCount }"/></strong>건이 검색되었습니다.
						</div>
						<%-- <div class="paging-select">
							<c:out value="${paginationInfo.currentPageNo }"/> / <c:out value="${totalPageCount }"/>page &nbsp;&nbsp;
							<form:select path="recordCountPerPage" onchange="fn_list(1); return false;">
								<form:option value="10">10</form:option>
								<form:option value="15">15</form:option>
								<form:option value="20">20</form:option>
								<form:option value="25">25</form:option>
								<form:option value="30">30</form:option>
							</form:select>
						</div> --%>
					</div>
					<!--// search info-->
	
					<!-- table -->
					<div class="list-table-box web">
						<table class="normal-list-table">
							<colgroup>
								<col style="width:5%;" />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col style="width:5%;" />
								<col style="width:5%;" />
								<col style="width:5%;" />
								<col style="width:5%;" />
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
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr>
										<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
										<td><c:out value="${result.attDate }"/>(<c:out value="${result.attWeek }"/>)</td>
										<td><c:out value="${result.lectGrade }급"/><c:out value="${result.lectDivi }"/></td>
										<td><a href="#" class="underline" onclick="fn_modify('<c:out value="${result.attDate }"/>','<c:out value="${result.memberCode }"/>','<c:out value="${result.absentSeq }"/>'); return false;"><c:out value="${result.name }"/></a></td>
										<td><a href="#" class="underline" onclick="fn_modify('<c:out value="${result.attDate }"/>','<c:out value="${result.memberCode }"/>','<c:out value="${result.absentSeq }"/>'); return false;"><c:out value="${result.nation }"/></a></td>
										<td><c:out value="${result.gender }"/></td>
										<td><c:out value="${result.firstYn eq 'Y'?'1':'' }"/></td>
										<td><c:out value="${result.firstTel eq 'Y'?'○':'' }"/></td>
										<td><c:out value="${result.firstSns eq 'Y'?'○':'' }"/></td>
										<td><c:out value="${result.firstTeam eq 'Y'?'○':'' }"/></td>
										<td><c:out value="${result.firstEtc eq 'Y'?'○':'' }"/></td>
										<td style="word-break:break-all;"><c:out value="${result.firstReason }"/></td>
										<td style="word-break:break-all;"><c:out value="${result.firstFolup }"/></td>
									</tr>
								</c:forEach>
								<c:if test="${resultList.size() == 0 }">
									<tr>
										<td colspan="13">검색된 내용이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<div class="mob mb20">
						<div class="mob-list">
							<ul>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<li>
										<p>
											<span class="title">
												<a href="#" onclick="fn_modify('<c:out value="${result.attDate }"/>','<c:out value="${result.memberCode }"/>','<c:out value="${result.absentSeq }"/>'); return false;">
													<c:out value="${result.name }"/> <c:out value="${result.memberCode }"/>
												</a>
											</span>
										</p>
										<p class="option">
											<span class="date"><c:out value="${result.atteCnt }"/>/200 (<c:out value="${result.abseCnt }"/>) <c:out value="${result.avgAtte }"/>%</span>
										</p>
									</li>
								</c:forEach>
								<c:if test="${resultList.size() == 0 }">
									<li>
										<p>
											<span class="title">검색된 내용이 없습니다.</span>
										</p>
									</li>
								</c:if>
							</ul>
						</div>
					</div>
					<!-- table button -->
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						</div>
					</div>
					<!--// table button -->
					<!-- paging -->
					<%-- <div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
					</div> --%>
					<!--// paging -->
				</form:form>
			</div>
		</div>

	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->
	<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->

</body>
</html>