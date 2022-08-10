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
	
	function fn_view(seq, memberCode){
		$("#evalSeq").val(seq);
		$("#memberCode").val(memberCode);
		$("#frm").attr("action", "<c:url value='/usr/lec/clss/lecClssAppraiseModify.do'/>").submit();
	}
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssAppraisePre.do'/>", '학생평가 미리보기', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
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
					<p class="page-lv01">학생평가</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>학생평가</span>
					</div>
				</div>
				<form:form commandName="searchVO" id="frm" name="frm">
					<input type="hidden" id="evalSeq" name="evalSeq"/>
					<input type="hidden" id="memberCode" name="memberCode"/>
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
	
								<a href="#">검색하기</a>
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
									<td class="txt-c">평가통계</td>
									<th class="txt-c">수강인원</th>
									<td class="txt-c"><c:out value="${resultMap.totCnt }"/>명</td>
									<th class="txt-c">평가</th>
									<td class="txt-c"><c:out value="${resultMap.proCnt }"/>명</td>
									<th class="txt-c">미평가</th>
									<td class="txt-c"><span class="txt-red underline"><c:out value="${resultMap.nproCnt }"/>명</span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<div class="mob mb20">
						<p class="sub-title">평가통계</p>
						<div class="mob-list">
							<div class="mob-list-type">
								<dl>
									<dt>수강인원</dt>
									<dd><c:out value="${resultMap.totCnt }"/>명</dd>
								</dl>
								<dl>
									<dt>평가</dt>
									<dd><c:out value="${resultMap.proCnt }"/>명</dd>
								</dl>
								<dl>
									<dt>미평가</dt>
									<dd><span class="txt-red underline"><c:out value="${resultMap.nproCnt }"/>명</span></dd>
								</dl>
							</div>
						</div>
					</div>
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white" onclick="fn_pop(); return false;">미리보기</button>
						</div>
					</div>
					<!--search info-->
					<div class="search-infomation">
						<div class="search-count">
							<strong><c:out value="${resultList.size() }"/></strong>건이 검색되었습니다.
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
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>학번</th>
									<th>이름</th>
									<th>영문이름</th>
									<th>국적</th>
									<th>연락처</th>
									<th>평가</th>
									<th>평가일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<tr>
										<td><c:out value="${resultList.size() - status.index }"/></td>
										<td><span class="underline imgSelect"><a href="#" onclick="fn_view('<c:out value="${result.evalSeq }"/>', '<c:out value="${result.memberCode }"/>'); return false;"><c:out value="${result.memberCode }"/></a></span></td>
										<td><span class="underline"><a href="#" onclick="fn_view('<c:out value="${result.evalSeq }"/>', '<c:out value="${result.memberCode }"/>'); return false;"><c:out value="${result.name }"/></a></span></td>
										<td><c:out value="${result.eName }"/></td>
										<td><c:out value="${result.nation }"/></td>
										<td><c:out value="${result.tel }"/></td>
										<td><c:out value="${result.evalYn }"/></td>
										<td><c:out value="${result.evalDate }"/></td>
									</tr>
									<c:if test="${result.content ne '' && result.content != null }">
										<tr>
											<td colspan="8">
												<c:out value="${result.content }" escapeXml="false"/>
											</td>
										</tr>
									</c:if>
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
											<span class="title"><a href="#" class="underline" onclick="fn_view('<c:out value="${result.evalSeq }"/>', '<c:out value="${result.memberCode }"/>'); return false;"><c:out value="${result.name }"/> <c:out value="${result.memberCode }"/></a></span>
										</p>
										<p class="option">
											<span class="date"><c:out value="${result.evalYn }"/></span>
										</p>
										<c:if test="${result.content ne '' && result.content != null }">
											<p>
												<c:out value="${result.content }" escapeXml="false"/>
											</p>
										</c:if>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<!-- table button -->
					<%-- <div class="table-button">
						<div class="btn-box">
							<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssAppraiseModify.do'/>" class="white btn-newwrite">학생평가</a>
						</div>
					</div> --%>
					<!--// table button -->
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