<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script type="text/javascript">
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
	
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/usr/lec/result/lecResultList.do'/>").submit();
	}
	
	function fn_modify(){
		/* var gradeS = '<c:out value="${semester.gradeS}"/>'.replace(/-/gi, "");
		var gradeE = '<c:out value="${semester.gradeE}"/>'.replace(/-/gi, "");
		var nowDate = fn_dateMinus().replace(/-/gi, "");
		
		if(!(gradeS <= nowDate <= gradeE)){
			alert('성적등록기간이 아닙니다.');
			return;
		} */
		
		$("#listForm").attr("action", "<c:url value='/usr/lec/result/lecResultView.do'/>").submit();
	}
	
	function fn_submit(){
		var gradeS = '<c:out value="${semester.gradeS}"/>'.replace(/-/gi, "");
		var gradeE = '<c:out value="${semester.gradeE}"/>'.replace(/-/gi, "");
		var nowDate = fn_dateMinus().replace(/-/gi, "");
		
		if(!(gradeS <= nowDate && nowDate <= gradeE)){
			alert('성적제출은 성적등록기간내에만 가능합니다.');
			return;
		}
		
		if(confirm('성적을 제출하시겠습니까?\r\n제출된 성적은 수정할 수 없습니다.')){
			$("#listForm").attr("action", "<c:url value='/usr/lec/result/lecGradeSubmis.do'/>").submit();
		}
	}
</script>
<body>
	<form:form commandName="searchVO" id="listForm" name="listForm">
	<input type="hidden" name="memberCode" id="memberCode"/>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">성적</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>성적</span>
					</div>
				</div>
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
										<td>대상학기</td>
										<td>
											<select>
												<option><c:out value="${semester.semYear }"/></option>
											</select>
											<select>
												<option><c:out value="${semester.semeNm }"/></option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
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
						<div class="w100-sh">
							<ul>
								<li>
									<select class="w49pc-01">
										<option><c:out value="${semester.semYear }"/></option>
									</select>
									<select class="w49pc-01">
										<option><c:out value="${semester.semeNm }"/></option>
									</select>
								</li>
							</ul>
							<div class="m-search-btn">
								<button type="button" for="sh-op-cl01">검색</button>
							</div>
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
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>학번</th>
								<th>이름</th>
								<th>영문이름</th>
								<th>국적</th>
								<th>연락처</th>
								<th>현재출석율(%)</th>
								<th>성적(중간)</th>
								<th>성적(기말)</th>
								<th>평균</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status" >
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td><c:out value="${result.memberCode }"/></td>
								<td><c:out value="${result.name }"/></td>
								<td><c:out value="${result.eName }"/></td>
								<td><c:out value="${result.feCountry }"/></td>
								<td><c:out value="${result.tel }"/></td>
								<td><c:out value="${result.gradeAttnd }"/></td>
								<td><c:out value="${result.midterm }"/></td>
								<td><c:out value="${result.finals }"/></td>
								<td><c:out value="${result.finals eq null?'':(result.midterm+result.finals)/2 }"/></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-list">
						<ul>
							<c:set var="submitYn" value="Y"/>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<li>
									<p>
										<span class="title"><c:out value="${result.name }"/> <c:out value="${result.memberCode }"/></span>
									</p>
									<p class="option">
										<span class="date"><c:out value="${result.midterm }"/></span>
										<span class="hit"><c:out value="${result.finals }"/></span>
										<c:if test="${result.finals eq null }">
											<c:set var="submitYn" value="N"/>
										</c:if>
									</p>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<c:if test="${lecSession.gradeYn ne 'Y' && submitYn eq 'Y' }">
							<button type="button" class="white btn-type01 sem-chk" onclick="fn_submit(); return false;">성적제출</button>
						</c:if>
						<button type="button" class="white btn-newwrite sem-chk" onclick="fn_modify(); return false;">성적등록</button>
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
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>">
	</form:form>
</body>
</html>