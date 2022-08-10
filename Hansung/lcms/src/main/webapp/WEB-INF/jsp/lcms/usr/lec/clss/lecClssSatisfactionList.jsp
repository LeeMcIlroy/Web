<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	function fn_search(){
		$("#frm").attr("action", "<c:url value='/usr/lec/clss/lecClssSatisfactionList.do'/>").submit();
	}
	
	function fn_open(){
		window.open("<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssSatisfactionView.do'/>"
				, '수업만족도', 'width=1100, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
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
					<p class="page-lv01">수업만족도</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>수업만족도</span>
					</div>
				</div>
				<c:if test="${semester.satisPrfYn eq 'Y' }">
				<p class="sub-title">기본 정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:50%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>학기</th>
								<td>
									<c:out value="${resultMap.year }"/>년도&nbsp;
									<c:out value="${resultMap.semeNm }"/>&nbsp;
									<c:out value="${resultMap.lectName }"/>&nbsp;
									<c:out value="${resultMap.lectDivi }"/>&nbsp;
									<c:out value="${resultMap.profName }"/>
								</td>
								<th>Language</th>
								<td>
									<c:out value="${resultMap.lang }"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>조사제목</th>
								<td>
									<c:out value="${resultMap.title }"/>
								</td>
								<th>게시여부</th>
								<td>
									<c:out value="${resultMap.useYn eq 'Y'?'게시':'게시안함' }"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>조사내용</th>
								<td colspan="3">
									<c:out value="${resultMap.content }" escapeXml="false"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">항목별 평점</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:5%;"/>
							<c:forEach items="${scoreList }">
							<col />
							</c:forEach>
							<col style="width:10%;"/>
							<col style="width:10%;"/>
						</colgroup>
						<thead>
							<tr>
								<th>항목</th>
								<c:forEach items="${scoreList }" varStatus="status">
									<th>질문<c:out value="${status.count }"/></th>
								</c:forEach>
								<th>평균</th>
								<th>총점</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>평점</td>
								<c:set var="avgSum" value="0"/>
								<c:forEach items="${scoreList }" var="score" varStatus="status">
									<c:set var="avgSum" value="${avgSum + score.avgNum }"/>
									<td><c:out value="${score.avgNum }"/></td>
								</c:forEach>
								<td><fmt:formatNumber value="${avgSum != 0 && avgSum != null?avgSum/scoreList.size():0 }" pattern="0.00"/></td>
								<td><fmt:formatNumber value="${avgSum }" pattern="0.00"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">조사항목</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<c:forEach items="${quesList }" var="ques" varStatus="status">
								<fmt:parseNumber value="${ques.cnt5 != 0?ques.cnt5/ques.totCnt*100:0 }" var="avgCnt5" integerOnly="true"/>
								<fmt:parseNumber value="${ques.cnt4 != 0?ques.cnt4/ques.totCnt*100:0 }" var="avgCnt4" integerOnly="true"/>
								<fmt:parseNumber value="${ques.cnt3 != 0?ques.cnt3/ques.totCnt*100:0 }" var="avgCnt3" integerOnly="true"/>
								<fmt:parseNumber value="${ques.cnt2 != 0?ques.cnt2/ques.totCnt*100:0 }" var="avgCnt2" integerOnly="true"/>
								<fmt:parseNumber value="${ques.cnt1 != 0?ques.cnt1/ques.totCnt*100:0 }" var="avgCnt1" integerOnly="true"/>
								<tr>
									<th>조사구분</th>
									<td colspan="4">
										<c:out value="${ques.phrTitle }"/>
									</td>
								</tr>
								<tr>
									<th>질문</th>
									<td colspan="4">
										<c:out value="${ques.question }"/>
									</td>
								</tr>
								<tr>
									<th rowspan="5">답변</th>
									<td class="txt-c">
										<span>1)아주 그렇다</span>
									</td>
									<td class="txt-c">
										<span><c:out value="${ques.cnt5 }"/>명</span>
									</td>
									<td class="txt-c">
										<span><c:out value="${avgCnt5 }"/>%</span>
									</td>
									<td>
										<div class="gr-box">
											<span class="grf">
												<span class="check-type <c:out value="${avgCnt5 < 50?'bg-red':'bg-green' }"/>" style="width:<c:out value="${avgCnt5 }"/>%;" title="<c:out value="${ques.cnt5 }"/>표">
													<c:out value="${ques.cnt5 }"/>표
												</span>
											</span>
										</div>
									</td>
								</tr>
								<tr>
									<td class="txt-c">
										<span>2)그렇다</span>
									</td>
									<td class="txt-c">
										<span><c:out value="${ques.cnt4 }"/>명</span>
									</td>
									<td class="txt-c">
										<span><c:out value="${avgCnt4 }"/>%</span>
									</td>
									<td>
										<div class="gr-box">
											<span class="grf">
												<span class="check-type <c:out value="${avgCnt4 < 50?'bg-red':'bg-green' }"/>" style="width:<c:out value="${avgCnt4 }"/>%;" title="<c:out value="${ques.cnt4 }"/>표">
													<c:out value="${ques.cnt4 }"/>표
												</span>
											</span>
										</div>
									</td>
								</tr>
								<tr>
									<td class="txt-c">
										<span>3)보통이다</span>
									</td>
									<td class="txt-c">
										<span><c:out value="${ques.cnt3 }"/>명</span>
									</td>
									<td class="txt-c">
										<span><c:out value="${avgCnt3 }"/>%</span>
									</td>
									<td>
										<div class="gr-box">
											<span class="grf">
												<span class="check-type <c:out value="${avgCnt3 < 50?'bg-red':'bg-green' }"/>" style="width:<c:out value="${avgCnt3 }"/>%;" title="<c:out value="${ques.cnt3 }"/>표">
													<c:out value="${ques.cnt3 }"/>표
												</span>
											</span>
										</div>
									</td>
								</tr>
								<tr>
									<td class="txt-c">
										<span>4)아니다</span>
									</td>
									<td class="txt-c">
										<span><c:out value="${ques.cnt2 }"/>명</span>
									</td>
									<td class="txt-c">
										<span><c:out value="${avgCnt2 }"/>%</span>
									</td>
									<td>
										<div class="gr-box">
											<span class="grf">
												<span class="check-type <c:out value="${avgCnt2 < 50?'bg-red':'bg-green' }"/>" style="width:<c:out value="${avgCnt2 }"/>%;" title="<c:out value="${ques.cnt2 }"/>표">
													<c:out value="${ques.cnt2 }"/>표
												</span>
											</span>
										</div>
									</td>
								</tr>
								<tr>
									<td class="txt-c">
										<span>5)전혀 아니다</span>
									</td>
									<td class="txt-c">
										<span><c:out value="${ques.cnt1 }"/>명</span>
									</td>
									<td class="txt-c">
										<span><c:out value="${avgCnt1 }"/>%</span>
									</td>
									<td>
										<div class="gr-box">
											<span class="grf">
												<span class="check-type <c:out value="${avgCnt1 < 50?'bg-red':'bg-green' }"/>" style="width:<c:out value="${avgCnt1 }"/>%;" title="<c:out value="${ques.cnt1 }"/>표">
													<c:out value="${ques.cnt1 }"/>표
												</span>
											</span>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<c:forEach items="${shortList }" var="result" varStatus="status">
								<tr>
									<th>조사구분</th>
									<td colspan="4">
										<c:out value="${result.phrTitle }"/>
									</td>
								</tr>
								<tr>
									<th>질문</th>
									<td colspan="4">
										<c:out value="${result.question }"/>
									</td>
								</tr>
								<c:if test="${result.answer1 ne '' }">
									<c:set value="${result.cnt1 != 0?result.cnt1/result.totCnt*100:0 }" var="avgCnt1"/>
									<tr>
										<th rowspan="5">답변</th>
										<td class="txt-c">
											<span><c:out value="${result.answer1 }"/></span>
										</td>
										<td class="txt-c">
											<span><c:out value="${result.cnt1 }"/>명</span>
										</td>
										<td class="txt-c">
											<span><c:out value="${avgCnt1 }"/>%</span>
										</td>
										<td>
											<div class="gr-box">
												<span class="grf">
													<c:set value="${result.cnt1 != 0?result.cnt1/result.totCnt*100:0 }" var="avgCnt1"/>
													<span class="check-type <c:out value="${avgCnt1 < 50?'bg-red':'bg-green' }"/>" style="width:<c:out value="${avgCnt1 }"/>%;" title="<c:out value="${result.cnt1 }"/>표">
														<c:out value="${result.cnt1 }"/>표
													</span>
												</span>
											</div>
										</td>
									</tr>
								</c:if>
								<c:if test="${result.answer2 ne '' }">
									<c:set value="${result.cnt2 != 0?result.cnt2/result.totCnt*100:0 }" var="avgCnt2"/>
									<tr>
										<td class="txt-c">
											<span><c:out value="${result.answer2 }"/></span>
										</td>
										<td class="txt-c">
											<span><c:out value="${result.cnt2 }"/>명</span>
										</td>
										<td class="txt-c">
											<span><c:out value="${avgCnt2 }"/>%</span>
										</td>
										<td>
											<div class="gr-box">
												<span class="grf">
													<span class="check-type <c:out value="${avgCnt2 < 50?'bg-red':'bg-green' }"/>" style="width:<c:out value="${avgCnt2 }"/>%;" title="<c:out value="${result.cnt2 }"/>표">
														<c:out value="${result.cnt2 }"/>표
													</span>
												</span>
											</div>
										</td>
									</tr>
								</c:if>
								<c:if test="${result.answer3 ne '' }">
									<c:set value="${result.cnt3 != 0?result.cnt3/result.totCnt*100:0 }" var="avgCnt3"/>
									<tr>
										<td class="txt-c">
											<span><c:out value="${result.answer3 }"/></span>
										</td>
										<td class="txt-c">
											<span><c:out value="${result.cnt3 }"/>명</span>
										</td>
										<td class="txt-c">
											<span><c:out value="${avgCnt3 }"/>%</span>
										</td>
										<td>
											<div class="gr-box">
												<span class="grf">
													<span class="check-type <c:out value="${avgCnt3 < 50?'bg-red':'bg-green' }"/>" style="width:<c:out value="${avgCnt3 }"/>%;" title="<c:out value="${result.cnt3 }"/>표">
														<c:out value="${result.cnt3 }"/>표
													</span>
												</span>
											</div>
										</td>
									</tr>
								</c:if>
								<c:if test="${result.answer4 ne '' }">
									<c:set value="${result.cnt4 != 0?result.cnt4/result.totCnt*100:0 }" var="avgCnt4"/>
									<tr>
										<td class="txt-c">
											<span><c:out value="${result.answer4 }"/></span>
										</td>
										<td class="txt-c">
											<span><c:out value="${result.cnt4 }"/>명</span>
										</td>
										<td class="txt-c">
											<span><c:out value="${avgCnt4 }"/>%</span>
										</td>
										<td>
											<div class="gr-box">
												<span class="grf">
													<span class="check-type <c:out value="${avgCnt4 < 50?'bg-red':'bg-green' }"/>" style="width:<c:out value="${avgCnt4 }"/>%;" title="<c:out value="${result.cnt4 }"/>표">
														<c:out value="${result.cnt4 }"/>표
													</span>
												</span>
											</div>
										</td>
									</tr>
								</c:if>
								<c:if test="${result.answer5 ne '' }">
									<c:set value="${result.cnt5 != 0?result.cnt5/result.totCnt*100:0 }" var="avgCnt5"/>
									<tr>
										<td class="txt-c">
											<span><c:out value="${result.answer5 }"/></span>
										</td>
										<td class="txt-c">
											<span><c:out value="${result.cnt5 }"/>명</span>
										</td>
										<td class="txt-c">
											<span><c:out value="${avgCnt5 }"/>%</span>
										</td>
										<td>
											<div class="gr-box">
												<span class="grf">
													<span class="check-type <c:out value="${avgCnt5 < 50?'bg-red':'bg-green' }"/>" style="width:<c:out value="${avgCnt5 }"/>%;" title="<c:out value="${result.cnt5 }"/>표">
														<c:out value="${result.cnt5 }"/>표
													</span>
												</span>
											</div>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<c:set var="bftxt" value=""/>
							<c:forEach items="${txtList }" var="txt" varStatus="status">
								<c:if test="${txt.question ne bftxt }">
									<c:set var="bftxt" value="${txt.question }"/>
									<tr>
										<th>조사구분</th>
										<td>
											<c:out value="${txt.phrTitle }"/>
										</td>
									</tr>
									<tr>
										<th>질문</th>
										<td>
											<c:out value="${txt.question }"/>
										</td>
									</tr>
								</c:if>
								<tr>
									<th>답변</th>
									<td>
										<div class="gr-box">
											<c:out value="${txt.answerTxt }"/>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
				</c:if>
				<c:if test="${semester.satisPrfYn ne 'Y' }">
					<div class="web">
						조사기간이 아닙니다.
					</div>
					<div class="mob">
						조사기간이 아닙니다.
					</div>
				</c:if>
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