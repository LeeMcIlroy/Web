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
		$("#frm").attr("action", "<c:url value='/usr/lec/clss/lecClssPeopleList.do'/>").submit();
	}
	
	function fn_print(prtType){
		if(prtType == "STDLIST"){
			window.open("<c:out value='${pageContext.request.contextPath }/usr/lec/clss/usrStdPop.do?'/>prtType="+prtType
				, '학생명단 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
		}else if(prtType == "ABSWRN"){
			$.ajax({
				url: "<c:url value='/usr/lec/clss/usrAjaxChk.do'/>"
				, data : "searchVO="+$("#frm").serialize()
				, type: "post"
				, dataType:"json"
				, success: function(data){
					var resultList = data.resultList;
					if(resultList.lenght == 0 || resultList == null){
						alert("학기내 결석경고가 없습니다.");
					}else if(resultList.lenght != 0){
						window.open("<c:out value='${pageContext.request.contextPath }/usr/lec/clss/usrStdPop.do?'/>prtType="+prtType
								, '결석경고 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
					}
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	function fn_view(seq){
		$("#memberSeq").val(seq);
		$("#frm").attr("action", "<c:url value='/usr/lec/clss/lecClssPeopleView.do'/>").submit();
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
					<p class="page-lv01">수강인원</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>수강인원</span>
					</div>
				</div>
				<form:form commandName="searchVO" id="frm" name="frm">
				<input type="hidden" name="memberSeq" id="memberSeq"/>
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
								<col style="width:4%;" />
								<col />
								<col />
								<col />
								<col />
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
									<th>입학일자</th>
									<th>유급</th>
									<th>연락처</th>
									<th>현재출석율(%)</th>
									<th>결석시간</th>
									<th>결석경고</th>
									<th>성적(중간)</th>
									<th>성적(기말)</th>
									<th>성적합계</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr>
										<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
										<td><a href="#" class="underline" onclick="fn_view('<c:out value="${result.memberSeq }"/>'); return false;"><c:out value="${result.memberCode }"/></a></td>
										<td><a href="#" class="underline" onclick="fn_view('<c:out value="${result.memberSeq }"/>'); return false;"><c:out value="${result.name }"/></a></td>
										<td><c:out value="${result.eName }"/></td>
										<td><c:out value="${result.nation }"/></td>
										<td><c:out value="${result.appDate }"/></td>
										<td>
											<c:choose>			
												<c:when test="${!empty result.lastSemCnt && empty result.lastSemCnt2}">
													1회 유급
												</c:when>
												<c:when test="${!empty result.lastSemCnt && !empty result.lastSemCnt2}">
													2회 유급
												</c:when>
											</c:choose>
											<%-- <c:if test="${!empty result.lastSemCnt }">,</c:if>
											<c:if test="${!empty result.staTotCnt && result.staTotCnt ne 0}">
												총유급(<c:out value="${result.staTotCnt }"/>회)
											</c:if> --%>
										</td>
										<td><c:out value="${result.tel }"/></td>
										<td><c:out value="${result.gradeAttnd }"/></td>
										<td>
											<c:choose>
												<c:when test="${result.abseCnt >= 30}">
													<span style="color:red;"><c:out value="${result.abseCnt }"/></span>
												</c:when>
												<c:otherwise>
													<c:out value="${result.abseCnt }"/>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<c:if test="${result.absWrn > 0}">
												<span style="color:red;">경고</span>
											</c:if>
										</td>
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
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<li>
										<p>
											<span class="title">
												<a href="#" onclick="fn_view('<c:out value="${result.memberSeq }"/>'); return false;"><c:out value="${result.name }"/> <c:out value="${result.memberCode }"/></a>
											</span>
										</p>
										<p class="option">
											<span class="date"><c:out value="${result.tel }"/></span>
										</p>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
	
					<!-- table button -->
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-down" onclick="fn_print('STDLIST'); return false;">학생명단</button>
							<button type="button" class="white btn-down" onclick="fn_print('ABSWRN'); return false;">최근 결석경고보기</button>
							<button type="button" class="white btn-down">Download</button>
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
		<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
		<!-- 입학신청자 입력폼 -->
		<div class="popupLayer">
			<table class="pop-table">
				<colgroup>
					<col style="width:100px;" />
					<col />
					<col style="width:100px;" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">접수번호</th>
						<td colspan="3">20091-0001(19K29111) / 재등록 / 불합격</td>
					</tr>
					<tr>
						<th scope="col">이름</th>
						<td>홍길동</td>
						<th scope="col">생년월일</th>
						<td>1999.10.10</td>
					</tr>
					<tr>
						<th scope="row">국적</th>
						<td colspan="3">대한민국</td>
					</tr>
					<tr>
						<th scope="row">신청이력</th>
						<td colspan="3">
							<p>20182-여름학기 불합격 / 서류전형미달</p>
							<p>20171-봄학기 불합격 / 비자발급불가</p>
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-box01">
				<button onClick="closeLayer(this)" class="pop-close" style="cursor:pointer;" title="닫기">닫기</button>
			</div>
		</div>
		<!--// 입학신청자 입력폼 -->

		<!-- 합격자, 불합격자 입력폼 -->
		<div class="popupLayer">
			<table class="pop-table">
				<colgroup>
					<col style="width:100px;" />
					<col />
					<col style="width:100px;" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" colspan="4" style="border-right:0;"><strong>학생찾기</strong></th>
					</tr>
					<tr>
						<th scope="row">접수번호</th>
						<td colspan="3">20091-0001(19K29111) / 재등록 / 불합격</td>
					</tr>
					<tr>
						<th scope="col">이름</th>
						<td>홍길동</td>
						<th scope="col">생년월일</th>
						<td>1999.10.10</td>
					</tr>
					<tr>
						<th scope="row">국적</th>
						<td colspan="3">대한민국</td>
					</tr>
					<tr>
						<th scope="row">신청이력</th>
						<td colspan="3">
							<p>20182-여름학기 불합격 / 서류전형미달</p>
							<p>20171-봄학기 불합격 / 비자발급불가</p>
						</td>
					</tr>
					<tr>
						<th scope="row"><sup>*</sup>비고</th>
						<td colspan="3">
							<input type="text" class="input-data" />
						</td>
					</tr>
				</tbody>
			</table>

			<div class="btn-box01">
				<button style="cursor:pointer;" class="pop-save" title="저장">저장</button>
				<button onClick="closeLayer(this)" class="pop-close" style="cursor:pointer;" title="닫기">닫기</button>
			</div>
		</div>
		<!--// 합격자, 불합격자 입력폼 -->
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