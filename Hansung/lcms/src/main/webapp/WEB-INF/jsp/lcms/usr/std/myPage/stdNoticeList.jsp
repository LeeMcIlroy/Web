<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%
String memberAbs = ((String)session.getAttribute("memberAbs")!=null)?(String)session.getAttribute("memberAbs"):"";
String lapse = ((String)session.getAttribute("lapse")!=null)?(String)session.getAttribute("lapse"):"";
%>
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

			if($("#lapse").val() == "Y"){
				 $(".la-pop").css("display", "block" );
			}
			if($("#memberAbs").val() == "Y"){
				 $(".se-pop").css("display", "block" );
			}
			
		});
		
		function fn_list(pageNo){
			$("#pageIndex").val(pageNo);
			$("#listForm").attr("action", "<c:url value='/usr/std/myPage/stdNoticeList.do'/>").submit();
		}
		function rowClick(notiSeq){
			$("#noti_seq").val(notiSeq);
			$("#listForm").attr("action", "<c:url value='/usr/std/myPage/stdNoticeView.do'/>").submit();
		}
		//팝업창 닫기
	    function fn_close(i){
			if(i == 1){
		   		$(".se-pop").css("display", "none" );
		     	<%session.removeAttribute("memberAbs");%>
			}else if(i == 2){
				$(".la-pop").css("display", "none" );
		     	<%session.removeAttribute("lapse");%>
			}
	    }
		function fn_lac(){
			$("#listForm").attr("action", "<c:url value='/usr/std/myPage/stdProfileView.do'/>").submit();
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
				<div class="title-area">
					<p class="page-lv01">공지사항</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>마이페이지</span>
						<span>공지사항</span>
					</div>
				</div>
				<input type="hidden" id="memberAbs" value="<%= memberAbs %>"/>
				<form:form commandName="searchVO" name="listForm" id="listForm">
				<input type="hidden" name="noti_seq" id="noti_seq">
				<input type="hidden" id="lapse" value="<%= lapse %>"/>
				<input type="hidden" name="lap" id="lap" value="Y">
				<!-- search -->
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search web"><!-- 모바일 수정 -->
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:10%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<input type="text" name="searchWord" id="searchWord" value="${searchVO.searchWord }" class="input-data" placeholder="제목, 내용을 입력하세요" />
										</td>
									</tr>
								</tbody>
							</table>

							<a href="#" onclick="fn_list('1'); return false;">검색하기</a>
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
								<li><input type="text"  class="input-data" placeholder="제목, 내용을 입력하세요" /></li>
							</ul>
							
							<div class="m-search-btn">
								<button type="button" for="sh-op-cl01" >검색</button>
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
							<col style="width:5%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>제목</th>
								<th>첨부</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회</th>
							</tr>
						</thead>
						<tbody>
						<!--************ 상단 공지 20200312************-->
						<c:forEach items="${resultListTOP }" var="resultTop" varStatus="">
							<tr>
								<td>
									<span class="icon-notice">공지</span>
								</td>
								<td class="txt-l" onclick="rowClick('<c:out value="${resultTop.notiSeq}"/>')">
								<c:out value="${resultTop.notiTitle }"/>&nbsp;&nbsp;
								
								<jsp:useBean id="nowTOP" class="java.util.Date" />
									<fmt:formatDate value="${nowTOP}" pattern="yyyy.MM.dd" var="today" />
									<fmt:parseDate var="dateFmt" pattern="yyyy.MM.dd" value="${resultTop.notiDate }"/>
									<fmt:formatDate var="notiDateTOP" pattern="yyyy.MM.dd" value="${dateFmt}" />
									<c:choose>
										<c:when test="${notiDateTOP eq today }">
											&nbsp;&nbsp;<img src="<c:url value='/assets/usr/img/icon-new.png'/>" style="vertical-align:middle;" alt="새글" />
										</c:when> 
									</c:choose>
								</td>
							    <td>
									<c:if test="${resultTop.filecount > 0}">
									<a href="#"><span class="icon-download-file">첨부파일</span></a>
								</c:if>
								</td>
								<td><c:out value="${resultTop.notiWriter }"/></td>
								<td><c:out value="${resultTop.notiDate }"/></td>
								<td><c:out value="${resultTop.notiStdhit }"/></td>
							</tr>
							</c:forEach>
							<!--************ 공지 리스트 20200312************-->
							<c:forEach items="${resultList }" var="result" varStatus="">
							<tr>
								<td><c:out value="${result.rowindex}"/></td>
								<td class="txt-l" onclick="rowClick('<c:out value="${result.notiSeq}"/>')"><a class="underline"><c:out value="${result.notiTitle }"/></a>
								
								<jsp:useBean id="now" class="java.util.Date" />
									<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="today" />
									<fmt:parseDate var="dateFmt" pattern="yyyy.MM.dd" value="${result.notiDate }"/>
									<fmt:formatDate var="notiDate" pattern="yyyy.MM.dd" value="${dateFmt}" />
									<c:choose>
										<c:when test="${notiDate eq today }">
											&nbsp;&nbsp;<img src="<c:url value='/assets/usr/img/icon-new.png'/>" style="vertical-align:middle;" alt="새글" />
										</c:when> 
									</c:choose>
								</td>
								<td>
									<c:if test="${result.filecount > 0}">
									<a href="#"><span class="icon-download-file">첨부파일</span></a>
								</c:if>
								</td>
								<td><c:out value="${result.notiWriter }"/></td>
								<td><c:out value="${result.notiDate }"/></td>
								<td><c:out value="${result.notiStdhit }"/></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="mob mb20">
					<div class="mob-list">
						<ul>
						<!--************ 모바일 상단 공지 20200313************-->
					<c:forEach items="${resultListTOP }" var="resultTop" varStatus="">
							<li>
								<p>
									<span class="icon-notice">공지</span>
									<span class="title"><a href="#" onclick="rowClick('<c:out value="${resultTop.notiSeq}"/>'); return false;" class="underline"><c:out value="${resultTop.notiTitle }"/></a></span>
								</p>
								<p class="option">
									<span class="date"><c:out value="${resultTop.notiDate }"/></span>
									<span class="hit"><c:out value="${resultTop.notiStdhit }"/></span>
								</p>
							</li>
						</c:forEach>
						<!--************ 모바일 공지 리스트 20200313************-->
						<c:forEach items="${resultList }" var="result" varStatus="">
							<li>
								<p>
									<c:out value="${result.rownum}"/>
									<span class="title"><a href="#" onclick="rowClick('<c:out value="${result.notiSeq}"/>'); return false;" class="underline"><c:out value="${result.notiTitle }"/></a></span>
								</p>
								<p class="option">
									<span class="date"><c:out value="${result.notiDate }"/></span>
									<span class="hit"><c:out value="${result.notiStdhit }"/></span>
								</p>
							</li>
						</c:forEach>
						</ul>
					</div>
				</div> 

				<!-- table button 
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-newwrite">공지등록</button>
					</div>
				</div>-->
				<!--// table button -->

				<!-- paging -->
				<div class="paging_wrap">
					<div class="paging">
						
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
									<form:hidden path="pageIndex" />
						
					</div>
				</div>
				<!--// paging -->
				<div class="se-pop">
					<div>
						<p>
							누적결석시간이 30시간 이상으로<br/>
							결석경고 조치 되었습니다
						</p>
						<br/>
						<span>
							※출석률 80%가 넘지 않으면 유급입니다.<br/>
							※출석률이 나쁘면 비자가 취소될 수 있습니다.
						</span>
					</div>
					<br/>
					<div class="table-button">
						<div class="se-btn-box">
							<button type="button" class="white btn-cancel" onclick="fn_close(1); return false;">확인</button>
						</div>
					</div>
				</div>
				<div class="la-pop">
					<div>
						<p>
							비밀번호를 변경하지 않았거나 비밀번호 변경후 30일 경과되었습니다. 
							<br/>
							비밀번호를 변경해주세요.
						</p>
					</div>
					<br/>
					<div class="table-button">
						<div class="se-btn-box">
							<button type="button" class="white btn-cancel" onclick="fn_lac(); return false;" style="margin-left: 240px;">비밀번호변경</button>
							<button type="button" class="white btn-cancel" onclick="fn_close(2); return false;">다음에</button>
						</div>
					</div>
				</div>
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