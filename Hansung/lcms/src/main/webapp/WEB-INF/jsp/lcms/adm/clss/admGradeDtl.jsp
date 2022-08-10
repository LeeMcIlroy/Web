<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>

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
			$("#listForm").attr("action", "<c:url value='/qxsepmny/clss/admGradeDtl.do'/>").submit();
		}
		
		function fn_view(lectSeq, memberCode){
			$("#lectSeq").val(lectSeq);
			$("#memberCode").val(memberCode);
			$("#listForm").attr("action", "<c:url value='/qxsepmny/clss/admGradeView.do'/>").submit();
		}
	</script>
<body>
	<form:form commandName="searchVO" id="listForm" name="listForm">
	<input type="hidden" name="lectSeq" id="lectSeq"/>
	<input type="hidden" name="memberCode" id="memberCode"/>
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<!--// left menu -->
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="수업"/>
		            <jsp:param name="dept2" value="성적"/>
	           	</jsp:include>
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
												<option><c:out value="${searchVO.searchCondition1 }"/></option>
											</select>
											<select>
												<option><c:out value="${searchVO.searchCondition2 eq '1'?'봄학기':searchVO.searchCondition2 eq '2'?'여름학기':searchVO.searchCondition2 eq '3'?'가을학기':searchVO.searchCondition2 eq '4'?'겨울학기':'' }"/></option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
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
								<th>출석율(%)</th>
								<th>성적(중간)</th>
								<th>성적(기말)</th>
								<th>평균</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td><span class="underline imgSelect" onclick="fn_view('<c:out value="${result.lectSeq }"/>', '<c:out value="${result.memberCode }"/>');"><c:out value="${result.memberCode }"/></span></td>
									<td><span class="underline imgSelect" onclick="fn_view('<c:out value="${result.lectSeq }"/>', '<c:out value="${result.memberCode }"/>');"><c:out value="${result.name }"/></span></td>
									<td><c:out value="${result.eName }"/></td>
									<td><c:out value="${result.feCountry }"/></td>
									<td><c:out value="${result.tel }"/></td>
									<td><c:out value="${result.gradeAttnd }"/></td>
									<td style="<c:out value="${result.midterm < 70?'color:#fc6039':'' }"/>"><c:out value="${result.midterm }"/></td>
									<td style="<c:out value="${result.finals < 70?'color:#fc6039':'' }"/>"><c:out value="${result.finals }"/></td>
									<td style="<c:out value="${(result.midterm+result.finals)/2 < 70?'color:#fc6039':'' }"/>"><c:out value="${result.finals eq null?'':(result.midterm+result.finals)/2 }"/></td>
								</tr>
							</c:forEach>
							<c:if test="${resultList.size() == 0 }">
								<tr>
									<td colspan="10">검색된 내용이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<!--// table -->
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
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>">
	</form:form>
</body>
</html>