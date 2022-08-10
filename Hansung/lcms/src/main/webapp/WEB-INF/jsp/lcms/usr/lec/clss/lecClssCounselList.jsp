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
		
		function fn_list(pageNo){
			$("#pageIndex").val(pageNo);
			$("#frm").attr("action", "<c:url value='/usr/lec/clss/lecClssCounselList.do'/>").submit();
		}
		
		function fn_view(seq){
			$("#consultSeq").val(seq);
			$("#frm").attr("action", "<c:url value='/usr/lec/clss/lecClssCounselView.do'/>").submit();
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
					<p class="page-lv01">상담</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>상담</span>
					</div>
				</div>
				<form:form commandName="searchVO" id="frm" name="frm">
				<input type="hidden" name="consultSeq" id="consultSeq"/>
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
									<form:input path="searchCondition1" class="w49pc-01" placeholder="이름을 입력하세요"/>
								</li>
							</ul>
						</div>
					</div>
					<!--// 모바일 추가 -->
				</div>
				<!--// search -->

				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
						</colgroup>
						<tbody>
							<tr>
								<td class="txt-c">상담통계</td>
								<th class="txt-c">수강인원</th>
								<td class="txt-c"><c:out value="${resultMap.totCnt }"/>명</td>
								<th class="txt-c">상담</th>
								<td class="txt-c"><c:out value="${resultMap.proCnt }"/>명</td>
								<th class="txt-c">미상담</th>
								<td class="txt-c"><span class="txt-red underline"><c:out value="${resultMap.nproCnt }"/>명</span></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<p class="sub-title">상담통계</p>
					<div class="mob-list">
						<div class="mob-list-type">
							<dl>
								<dt>수강인원</dt>
								<dd><c:out value="${resultMap.totCnt }"/>명</dd>
							</dl>
							<dl>
								<dt>상담</dt>
								<dd><c:out value="${resultMap.proCnt }"/>명</dd>
							</dl>
							<dl>
								<dt>미상담</dt>
								<dd><span class="txt-red underline"><c:out value="${resultMap.nproCnt }"/>명</span></dd>
							</dl>
						</div>
					</div>
				</div>

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
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>상담일자</th>
								<th>상담자</th>
								<th>상담구분</th>
								<th>학번</th>
								<th>이름</th>
								<th>영문이름</th>
								<th>급수</th>
								<th>상담장소</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td><c:out value="${result.consultDate }"/></td>
									<td><c:out value="${result.profName }"/></td>
									<td><c:out value="${result.consultType }"/></td>
									<td><span class="underline"><a href="#" onclick="fn_view('<c:out value="${result.consultSeq }"/>'); return false;"><c:out value="${result.memberCode }"/></a></span></td>
									<td><span class="underline"><a href="#" onclick="fn_view('<c:out value="${result.consultSeq }"/>'); return false;"><c:out value="${result.name }"/></a></span></td>
									<td><c:out value="${result.eName }"/></td>
									<td><c:out value="${result.step }"/>급</td>
									<td><c:out value="${result.place }"/></td>
								</tr>
							</c:forEach>
							<c:if test="${resultList.size() == 0 }">
								<tr>
									<td colspan="10">검색된 상담내용이 없습니다.</td>
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
										<span class="title"><a href="#" onclick="fn_view('<c:out value="${result.consultSeq }"/>'); return false;" class="underline"><c:out value="${result.name }"/> <c:out value="${result.memberCode }"/></a></span>
									</p>
									<p class="option">
										<span class="date"><c:out value="${result.consultDate }"/></span>
									</p>
								</li>
							</c:forEach>
							<c:if test="${resultList.size() == 0 }">
								<li>
									<p>
										<span class="title">검색된 상담내용이 없습니다.</span>
									</p>
								</li>
							</c:if>
						</ul>
					</div>
				</div>

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssCounselModify.do'/>" class="white btn-newwrite sem-chk">상담등록</a>
					</div>
				</div>
				<!--// table button -->

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