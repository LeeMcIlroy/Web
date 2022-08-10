<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
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
	
	function fn_modify(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/task/lecTaskModify.do'/>").submit();
	}
	
	function fn_down(seq){
		$.ajax({
			url: "<c:url value='/usr/lec/task/lecTaskSubShow.do'/>"
			, type: "post"
			, data: "subSeq="+seq
			, dataType:"json"
			, success: function(data){
				window.location.reload();
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_del(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/task/lecTaskDel.do'/>").submit();
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
					<p class="page-lv01">과제게시판 - 상세보기</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>과제</span>
						<span>과제게시판</span>
					</div>
				</div>

				<p class="sub-title">출제과제</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>과제명</th>
								<td colspan="3">
									<c:out value="${taskVO.taskNm }"/> (<c:out value="${taskVO.taskYn eq 'Y'?'공개':'비공개' }"/>)
								</td>
							</tr>
							<tr>
								<th>제출기간</th>
								<td colspan="3">
									<c:out value="${taskVO.taskSdate }"/>
									 ~ 
									<c:out value="${taskVO.taskEdate }"/>(<c:out value="${taskVO.taskStatus }"/>)
								</td>
							</tr>
							<tr>
								<th>과제내용</th>
								<td colspan="3">
									<c:out value="${taskVO.taskContent }" escapeXml="false"/>
								</td>
							</tr>
							<tr>
								<th>제출현황</th>
								<td>
									<c:out value="${taskVO.taskResultCnt }"/> / <c:out value="${taskVO.taskAllCnt }"/> (<fmt:formatNumber value="${taskVO.taskResultCnt eq '0'?'0':(taskVO.taskResultCnt/taskVO.taskAllCnt)*100 }" pattern="0"/>%)
								</td>
								<th><span class="underline">미제출자</span></th>
								<td>
									<span class="underline"><c:out value="${taskVO.taskAllCnt-taskVO.taskResultCnt }"/>명</span>
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
							<dd><c:out value="${taskVO.taskNm }"/> (<c:out value="${taskVO.taskYn eq 'Y'?'공개':'비공개' }"/>)</dd>
						</dl>
						<dl>
							<dt>제출기간</dt>
							<dd><c:out value="${taskVO.taskSdate }"/> ~ <c:out value="${taskVO.taskEdate }"/>(<c:out value="${taskVO.taskStatus }"/>)</dd>
						</dl>
						<dl>
							<!-- <dt>과제내용</dt>
							<dd> -->
								<c:out value="${taskVO.taskContent }" escapeXml="false"/>
							<!-- </dd> -->
						</dl>
						<dl>
							<dt>제출현황</dt>
							<dd><c:out value="${taskVO.taskResultCnt }"/> / <c:out value="${taskVO.taskAllCnt }"/> (<fmt:formatNumber value="${taskVO.taskResultCnt eq '0'?'0':(taskVO.taskResultCnt/taskVO.taskAllCnt)*100 }" pattern="0"/>%)</dd>
						</dl>
						<dl>
							<dt><span class="underline">미제출자</span></dt>
							<dd><span class="underline"><c:out value="${taskVO.taskAllCnt-taskVO.taskResultCnt }"/>명</span></dd>
						</dl>
					</div>
				</div>
				
				<p class="sub-title">첨부파일</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>첨부파일</th>
								<td id="file_web">
									<c:forEach items="${attachList }" var="attach" varStatus="status">
										<p class="file-upload">
											<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>"><c:out value="${attach.orgFileName }"/></a>
										</p>
									</c:forEach>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>첨부파일</dt>
							<dd>
								<c:forEach items="${attachList }" var="attach" varStatus="status">
									<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>"><c:out value="${attach.orgFileName }"/></a>
								</c:forEach>
							</dd>
						</dl>
					</div>
				</div>

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="#" onclick="fn_del(); return false;" class="white btn-del sem-chk">삭제</a>
						<a href="#" onclick="fn_modify(); return false;" class="white btn-newwrite sem-chk">수정</a>
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/task/lecTaskList.do'/>" class="white btn-list">목록</a>
					</div>
				</div>
				<!--// table button -->

				<form:form commandName="searchVO" id="frm" name="frm">
					<input type="hidden" id="taskSeq" name="taskSeq" value="<c:out value="${taskVO.taskSeq }"/>"/>
					<p class="sub-title">제출현황</p>
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
									<th>제출자</th>
									<th>학번</th>
									<th>과제확인</th>
									<th>제출일시</th>
									<th>제출과제</th>
									<th>확인일시</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr>
										<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
										<td><span class="underline"><c:out value="${result.name }"/></span></td>
										<td><span class="underline"><c:out value="${result.memberCode }"/></span></td>
										<td><c:out value="${result.lookDate }"/></td>
										<td><c:out value="${result.subDate }"/></td>
										<td><a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${result.attachSeq }&type=${result.boardType }'/>" class="underline"><c:out value="${result.orgFileName }"/></a></td>
										<td><c:out value="${result.downDate }"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!--// table -->
	
					<div class="mob mb20">
						<div class="mob-write">
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<div class="mob-list-type">
									<dl>
										<dt>No.</dt>
										<dd><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></dd>
									</dl>
									<dl>
										<dt>제출자</dt>
										<dd><span class="underline"><c:out value="${result.name }"/></span></dd>
									</dl>
									<dl>
										<dt>학번</dt>
										<dd><span class="underline"><c:out value="${result.memberCode }"/></span></dd>
									</dl>
									<dl>
										<dt>과제확인</dt>
										<dd><c:out value="${result.lookDate }"/></dd>
									</dl>
									<dl>
										<dt>제출일시</dt>
										<dd><c:out value="${result.subDate }"/></dd>
									</dl>
									<dl>
										<dt>제출과제</dt>
										<dd>
											<c:if test="${result.orgFileName ne '' }">
												<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${result.attachSeq }&type=${result.boardType }'/>" class="underline"><c:out value="${result.orgFileName }"/></a>
											</c:if>
											<c:if test="${result.orgFileName ne '' }">
												&nbsp;
											</c:if>
										</dd>
									</dl>
									<dl>
										<dt>확인일시</dt>
										<dd><c:out value="${result.downDate }"/></dd>
									</dl>
								</div>
							</c:forEach>
						</div>
					</div>
	
					<!-- table button -->
					<!-- <div class="table-button">
						<div class="btn-box">
							<a href="" class="white btn-newwrite">과제출제</a>
						</div>
					</div> -->
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

	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->
	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
</body>
</html>