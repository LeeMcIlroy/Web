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
	
	function fn_save(){
		$("#detailForm").attr("action", "<c:url value='/usr/std/lecRoom/stdLecTaskModify.do'/>").submit();
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavStd"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuStd"/>
			<!--// left menu -->
			<div class="main-content">
				<form:form commandName="taskSubVO" id="detailForm" name="detailForm" enctype="multipart/form-data">
				<input type="hidden" name="taskSeq" id="taskSeq" value="${taskSubVO.taskSeq }"/>
				<input type="hidden" name="subSeq" id="stdTaskSeq" value="${taskSubVO.subSeq }"/>
				<div class="title-area">
					<p class="page-lv01">과제 - 과제제출</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>과제</span>
					</div>
				</div>

				<p class="sub-title">과제내용</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;"/>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>과제명</th>
								<td>
									<c:out value="${taskSubVO.taskNm }"/>
								</td>
								<th>공개여부</th>
								<td>
									<c:choose>
										<c:when test="${taskSubVO.taskYn eq 'Y'}"><span class="txt-red">공개</span></c:when>
										<c:when test="${taskSubVO.taskYn eq 'N'}"><span >비공개</span></c:when>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>제출기간</th>
								<td colspan="3">
									<c:out value="${taskSubVO.taskSdate }"/> <c:out value="${taskSubVO.taskSdateT }"/>:<c:out value="${taskSubVO.taskSdateM }"/> 
									~ 
									<c:out value="${taskSubVO.taskEdate }"/> <c:out value="${taskSubVO.taskEdateT }"/>:<c:out value="${taskSubVO.taskEdateM }"/>
									(<c:out value="${taskSubVO.taskStatus }"/>)
								</td>
							</tr>
							<tr>
								<th>과제내용</th>
								<td colspan="3">
									<c:out value="${taskSubVO.taskContent }" escapeXml="false"/>
								</td>
							</tr>
							<tr>
								<th>제출현황</th>
								<td colspan="3">
									<c:out value="${taskSubVO.taskResultCnt }"/> / 20 (60%)
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>과제명</dt>
							<dd>
								<c:out value="${taskSubVO.taskNm }"/>
							</dd>
						</dl>
						<dl>
							<dt>공개여부</dt>
							<dd>
								<c:choose>
									<c:when test="${taskSubVO.taskYn eq 'Y'}"><span class="txt-red">공개</span></c:when>
									<c:when test="${taskSubVO.taskYn eq 'N'}"><span class="txt-red">비공개</span></c:when>
								</c:choose>
							</dd>
						</dl>
						<dl>
							<dt>제출기간</dt>
							<dd>
								<c:out value="${taskSubVO.taskSdate }"/> <c:out value="${taskSubVO.taskSdateT }"/>:<c:out value="${taskSubVO.taskSdateM }"/> 
								~ 
								<c:out value="${taskSubVO.taskEdate }"/> <c:out value="${taskSubVO.taskEdateT }"/>:<c:out value="${taskSubVO.taskEdateM }"/>
								(<c:out value="${taskSubVO.taskStatus }"/>)
							</dd>
						</dl>
						<dl>
							<dt>과제내용</dt>
							<dd>
								<c:out value="${taskSubVO.taskContent }" escapeXml="false"/>
							</dd>
						</dl>
						<dl>
							<dt>제출현황</dt>
							<dd>
								<c:out value="${taskSubVO.taskResultCnt }"/> / 20 (60%)
							</dd>
						</dl>
					</div>
				</div>
				<p class="sub-title">과제제출</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>과제파일</th>
								<td>
									<input type="text" value="파일선택" class="input-data" disabled="disabled">
									<label for="upload_file" class="btn-upload-file">파일업로드</label>
									<input type="file" class="hidden" id="upload_file" name="upload_file"/>
									<button type="button">x</button>
									<p class="mt10">‘공개’ 과제인 경우 다른 학생이 과제파일을 다운로드 할 수 있습니다. </p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				</form:form>
				
				<form:form commandName="searchVO" id="listForm" name="listForm">
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>과제파일</dt>
							<dd>
								<input type="text" value="파일선택" class="input-data" disabled="disabled">
								<label for="upload_file" class="btn-upload-file">파일업로드</label>
								<input type="file" class="hidden" id="upload_file"/>
								<button type="button">x</button>
								<p class="mt10">‘공개’ 과제인 경우 다른 학생이 과제파일을 다운로드 할 수 있습니다. </p>
							</dd>
						</dl>
					</div>
				</div>


				<div class="table-button">
					<div class="btn-box">
						<a href="#" onclick="fn_save(); return false;" class="white btn-newwrite">과제재제출</a>
						<a href="<c:out value='${pageContext.request.contextPath }/usr/std/lecRoom/stdLecTaskList.do'/>" class="white btn-list">목록</a>
					</div>
				</div>

				<p class="sub-title">제출현황</p>
				<!--search info-->
				<div class="search-infomation">
					<div class="search-count">
						<strong><c:out value="${totalCount }"/></strong>건이 검색되었습니다.
					</div>
					<div class="paging-select">
						${currentPageNo} / ${totalPageCount }page &nbsp;&nbsp;
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
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>제출자</th>
								<th>학번</th>
								<th>제출일시</th>
								<th>첨부파일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td><c:out value="${result.memberName }"/></td>
								<td><c:out value="${result.memberCode }"/></td>
								<td><c:out value="${result.regFileDate }"/></td>
								<td><a href="" class="underline"><c:out value="${result.orgFileName }"/></a></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-list">
						<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
							<li>
								<p>
									<span class="title">
										<a href="" class="underline">
										<c:out value="${result.memberName }"/> <c:out value="${result.memberCode }"/>
										</a>
									</span>
								</p>
								<p class="option">
									<span class="date"><c:out value="${result.regFileDate }"/></span>
								</p>
								<p>
									<a href="" class="underline"><c:out value="${result.orgFileName }"/></a>
								</p>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>

				<!-- paging -->
				<div class="paginate">
					<div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
					</div>
				</div>
				<!--// paging -->
				</form:form>
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

</body>
</html>