<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>
	function fn_goList(){
		location.href = "<c:url value='/xabdmxgr/qestnar/admQuestionaireList.do'/>";
	}
	
	// 주관식 답변 목록
	function fn_subAnswerList(qstnrSeq, askNo){
		var url = "<c:out value='${pageContext.request.contextPath}/xabdmxgr/qestnar/admSubAnswerList.do'/>";
		var params = "?qstnrSeq="+qstnrSeq+"&askNo="+askNo;
		window.open(url+params, "subAnswerList", "width=600px, height=500px, scrollbars=yes, resizable=yes, location=no, menubar=no");
	}
	
</script>
<body>
<form:form commandName="qestnarVO" id="frm">
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!--// header -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<div class="title_area">
				<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="설문조사"/>
		            <jsp:param name="dept2" value="설문조사"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<div class="section_top_area mt30">
					<h4>설문 구분</h4>
				</div>
				<table class="view_tbl_03 mb30" summary="설문조사">
					<caption>설문조사</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">학기 강의실</th>
							<td> <c:out value="${resultVO.smtrTitle }"/></td>
						</tr>
						<tr>
							<th scope="row">설문 구분 제목</th>
							<td> <c:out value="${resultVO.qstnrTitle }"/></td>
						</tr>
						<tr>
							<th scope="row">설문 제목</th>
							<td> <c:out value="${resultVO.qstnrSubTitle }"/></td>
						</tr>
						<tr>
							<th scope="row">설문 내용</th>
							<td>
								 <c:out value="${resultVO.qstnrContent }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">설문 기간</th>
							<td> <c:out value="${resultVO.qstnrStartDate }"/> ~ <c:out value="${resultVO.qstnrEndDate }"/></td>
						</tr>
						<tr>
							<th scope="row">총 설문인원</th>
							<td><c:out value="${resultVO.qstnrRespCount }"/>명</td>
						</tr>
						<tr>
							<th scope="row">소속별</th>
							<td>
								<dl class="so_dl">
									<c:forEach var="dept" items="${deptList }" varStatus="status">
										<dt><c:out value="${dept.deptTitle }"/></dt>
										<dd><c:out value="${dept.qstnrCnt }"/>명</dd>
										<c:if test="${(status.count % 5) eq 0}">
								</dl>
								<dl class="so_dl">
										</c:if>
									</c:forEach>
								</dl>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="section_top_area mt30">
					<h4>설문 내용</h4>
				</div>

		<c:forEach var="askList" items="${resultAskList }">
					<table class="view_tbl_03 mb30" summary="설문 내용">
					<caption>설문 내용</caption>
						<colgroup>
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
 							<c:if test="${askList.qstnrSeq eq '166' && askList.askNo eq '5' }">
							<div style="margin-bottom: 15px; font-size: 15px;">[※(5~10번) 여러분 자신의 의사소통 역량에 대한 점검입니다.]</div>
							</c:if>
							
							<tr class="first">
								<th scope="row">질문<c:out value="${askList.askNo }"/></th>
								<td><c:out value="${askList.askContent }"/></td>
							</tr>
							<c:if test="${askList.askType eq '3' }">
								<tr>
									<th scope="row">답변<c:out value="${askList.askNo }"/></th>
									<td class="aw">
										<a href="#" onclick="fn_subAnswerList(<c:out value="${resultVO.qstnrSeq }"/>, <c:out value='${askList.askNo }'/>); return false;">주관식 답변 목록 보기</a>
									</td>
								</tr>
							</c:if>
							<c:if test="${askList.askType ne '3' }">
								<tr>
									<th scope="row">답변<c:out value="${askList.askNo }"/></th>
									<td class="aw">
										<c:forEach var="replyList" items="${resultReplyList }">
											<c:if test="${askList.askNo eq replyList.askNo }">
												<ul class="aw_ul">
													<li>항목<c:out value="${replyList.repNo }"/></li>
													<li><c:out value="${replyList.repContent }"/></li>
													<li>
														<c:if test="${replyList.maxRepCnt ne replyList.repChoiceCount }">
															<p style="width:<c:out value='${replyList.repChoiceCount*0.4 }'/>%;" >&nbsp;</p> <c:out value="${replyList.repChoiceCount }"/>표
														</c:if>
														<c:if test="${replyList.maxRepCnt eq replyList.repChoiceCount }">
															<p style="width:<c:out value='${replyList.repChoiceCount*0.4 }'/>%;" class="top" >&nbsp;</p> <c:out value="${replyList.repChoiceCount }"/>표
														</c:if>
													</li>
												</ul>
											</c:if>
			</c:forEach>
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</c:forEach>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type03" onclick="fn_goList(); return false;">목록</a>
						</div>
					</div>
				</div>
			<!-- //content -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>