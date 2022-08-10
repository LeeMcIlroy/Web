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
		var searchDate = $("#searchDate").val();
		var datepicker = $("#datepicker01").val();
		var mDatepicker = $("#m-datepicker01").val();
		
		if(searchDate != datepicker){
			$("#searchDate").val(datepicker);
		}else if(searchDate != mDatepicker){
			$("#searchDate").val(mDatepicker);
		}
		
		$("#pageIndex").val(idx);
		$("#frm").attr("action", "<c:url value='/usr/lec/attnd/lecAttndList.do'/>").submit();
	}
	
	function fn_view(){
		$("#attDate").val($("#searchDate").val());
		$("#frm").attr("action", "<c:url value='/usr/lec/attnd/lecAttndView.do'/>").submit();
	}
	
	function fn_attend(lectSeq){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/cmm/attendancePop.do'/>?lectSeq="+lectSeq
					, '학생명단 인쇄', 'width=1600, height=850, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_etc(lectSeq){
		var attDate = $("#datepicker01").val();
		$.ajax({
			url: "<c:url value='/usr/lec/attnd/lecAjaxAttndEtcList.do'/>"
			, type: "post"
			, data: "lectSeq="+lectSeq
			, dataType:"json"
			, success: function(data){
				
				var html = '';
				var html2 = '';
				
				var resultList = data.resultList;
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr>';
					html += '	<th>이름</th>';
					html += '	<td>'+resultList[i].name+'</td>';
					html += '	<th>학번</th>';
					html += '	<td>'+resultList[i].memberCode+'</td>';
					html += '	<th>강의일자</th>';
					html += '	<td>'+resultList[i].attDate+'</td>';
					html += '</tr>';
					html += '<tr>';
					html += '	<th>비고</th>';
					html += '	<td colspan="5">'+resultList[i].attEtc+'</td>';
					html += '</tr>';
					
					html += '<tr>';
					html += '	<th>첨부파일</th>';
					html += '	<td colspan="5">';
					if(resultList[i].attachSeq != null){
						html += '		<a href="<c:url value="/cmmn/file/downloadFile.do"/>?fileId='+resultList[i].attachSeq+'&type='+resultList[i].boardType+'">';
						html += '			'+resultList[i].orgFileName;
						html += '		</a>';
					}
					html += '	</td>';
					html += '</tr>';
					
					html += '<tr>';
					html += '	<td colspan="6"></td>';
					html += '</tr>';
					
					html2 += '<tr>';
					html2 += '	<th>이름</th>';
					html2 += '	<td>'+resultList[i].name+'</td>';
					html2 += '</tr>';
					html2 += '<tr>';
					html2 += '	<th>학번</th>';
					html2 += '	<td>'+resultList[i].memberCode+'</td>';
					html2 += '</tr>';
					html2 += '<tr>';
					html2 += '	<th>강의일자</th>';
					html2 += '	<td>'+resultList[i].attDate+'</td>';
					html2 += '</tr>';
					html2 += '<tr>';
					html2 += '	<th>비고</th>';
					html2 += '	<td>'+resultList[i].attEtc+'</td>';
					html2 += '</tr>';
					
					html2 += '<tr>';
					html2 += '	<th>첨부파일</th>';
					html2 += '	<td>';
					if(resultList[i].attachSeq != null){
						html2 += '		<a href="<c:url value="/cmmn/file/downloadFile.do"/>?fileId='+resultList[i].attachSeq+'&type='+resultList[i].boardType+'">';
						html2 += '			'+resultList[i].orgFileName;
						html2 += '		</a>';
					}
					html2 += '	</td>';
					html2 += '</tr>';
					
					html2 += '<tr>';
					html2 += '	<td colspan="2"></td>';
					html2 += '</tr>';
				}
				
				$("#stdBody").html(html);
				$("#stdBody2").html(html2);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
</script>
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
					<p class="page-lv01">출결</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>출결</span>
					</div>
				</div>
				<form:form commandName="searchVO" id="frm" name="frm">
					<form:hidden path="searchDate"/>
					<input type="hidden" name="attDate" id="attDate"/>
					<!-- search -->
					<div class="search-box none-option">
						<input type="checkbox" id="search-option-open" />
						<div class="search web"><!-- 모바일 수정 -->
							<div class="search-input">
								<table class="shearch-option">
									<colgroup>
										<%-- <col style="width:8%;" />
										<col style="width:15%;" /> --%>
										<col style="width:8%;" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<td>대상학기</td>
											<td>
												<select>
													<option value="<c:out value="${semester.semYear }"/>"><c:out value="${semester.semYear }"/></option>
												</select>
												<select>
													<option value="<c:out value="${semester.semester }"/>"><c:out value="${semester.semeNm }"/></option>
												</select>
											</td>
											<%-- <td>출석일자</td>
											<td>
												<input type="text" id="datepicker01" class="w173px bl-l bl-r" value="<c:out value='${searchVO.searchDate }'/>" />
											</td> --%>
										</tr>
									</tbody>
								</table>
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
									<li>
										<select class="w49pc-01">
											<option value="<c:out value="${semester.semYear }"/>"><c:out value="${semester.semYear }"/></option>
										</select>
										<select class="w49pc-01">
											<option value="<c:out value="${semester.semester }"/>"><c:out value="${semester.semeNm }"/></option>
										</select>
									</li>
									<%-- <li>
										<input type="text" id="m-datepicker01" value="<c:out value='${searchVO.searchDate }'/>" />
									</li> --%>
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
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>학번</th>
									<th>이름</th>
									<th>현재수업시간</th>
									<th>출석시간</th>
									<th>결석시간</th>
									<th>현재출석율(%)</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr>
										<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
										<td><c:out value="${result.memberCode }"/></td>
										<td><c:out value="${result.name }"/></td>
										<td><c:out value="${result.totAttend }"/></td>
										<td><c:out value="${result.atteCnt }"/></td>
										<td><c:out value="${result.abseCnt }"/></td>
										<td><c:out value="${result.avgAtte }"/></td>
									</tr>
								</c:forEach>
								<c:if test="${resultList.size() == 0 }">
									<tr>
										<td colspan="9">검색된 내용이 없습니다.</td>
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
											<span class="title"><c:out value="${result.name }"/> <c:out value="${result.memberCode }"/></span>
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
							<label for="modi-pop" onclick="fn_etc('<c:out value="${selLectCode }"/>');" class="white">비고이력</label>
							<a href="#" onclick="fn_attend('<c:out value="${selLectCode }"/>'); return false;" class="white">출석표</a>
							<a href="#" onclick="fn_view(); return false;" class="white btn-newwrite sem-chk">출석등록</a>
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
				</form:form>
			</div>
		</div>
		<input type="checkbox" id="modi-pop" class="hidden" />
			<div class="black-pop">&nbsp;</div>
			<div class="modi-popup web">
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
						<tbody id="stdBody">
							<tr>
								<th>이름</th>
								<td id="name"></td>
								<th>학번</th>
								<td id="mCode"></td>
								<th>강의일자</th>
								<td id="date"></td>
							</tr>
							<tr>
								<th>비고</th>
								<td colspan="5"></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="table-button">
					<div class="btn-box">
						<label for="modi-pop" class="white btn-cancel">닫기</label>
					</div>
				</div>
			</div>
			<div class="modi-popup mob">
				<p class="sub-title">비고</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:20%;">
							<col >
						</colgroup>
						<tbody id="stdBody2">
							<tr>
								<th>이름</th>
								<td></td>
							</tr>
							<tr>
								<th>학번</th>
								<td></td>
							</tr>
							<tr>
								<th>강의일자</th>
								<td></td>
							</tr>
							<tr>
								<th>비고</th>
								<td></td>
							</tr>
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
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->
	<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->

</body>
</html>