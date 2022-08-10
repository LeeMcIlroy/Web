<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />

<script>
	// 글쓰기 이동
	function fn_modify(qnaSeq){
		$("#qnaSeq").val(qnaSeq);
		$("#frm").attr("method","post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaModifyView.do'/>").submit();
	}
	
	//조회
	function fn_select(qnaSeq){
		$("#qnaSeq").val(qnaSeq);
		$("#frm").attr("method","post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaView.do'/>").submit();
	} 
	
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaList.do'/>").submit();
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="qnaSeq" name="qnaSeq"/>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<hr />
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="게시판"/>
            	<jsp:param name="dept2" value="Q&A"/>
            </jsp:include>
			<div class="cont_box">
			<%-- 
				<div class="mid_tit">자주 묻는 질문 TOP5</div>
				<div class="qna_box mb40">
					<ul>
						<li class="questioin"><a href="javascript:;">상담신청 관련 질문</a></li>
						<li class="answer">
							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.
							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.

							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.
						</li>
					</ul>
					<ul>
						<li class="questioin"><a href="javascript:;">상담신청 관련 질문 상담신청 관련 질문 상담신청 관련 질문 상담신청 관련 질문</a></li>
						<li class="answer">
							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.
							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.

							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.
						</li>
					</ul>
					<ul>
						<li class="questioin"><a href="javascript:;">상담신청 관련 질문 상담신청 관련 질문 상담신청 관련 질문 상담신청 관련 질문</a></li>
						<li class="answer">
							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.
							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.

							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.
						</li>
					</ul>
					<ul>
						<li class="questioin"><a href="javascript:;">상담신청 관련 질문 상담신청 관련 질문 상담신청 관련 질문 상담신청 관련 질문 상담신청 관련 질문 상담신청 관련 질문</a></li>
						<li class="answer">
							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.
							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.

							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.
						</li>
					</ul>
					<ul>
						<li class="questioin"><a href="javascript:;">상담신청 관련 질문 상담신청 관련 질문 상담신청 관련 질문 상담신청 관련 질문</a></li>
						<li class="answer">
							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.
							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.

							자주 묻는 질문에 대한 답변입니다. 글쓰기 센터는 재학생의 사고와표현에 도움을 줍니다.
						</li>
					</ul>
				</div>
				--%>
				<div class="sh_box">
					<div class="sh_l_box">
						게시물 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건
					</div>
					<div class="sh_r_box">
						<form:select path="searchCondition" class="w100">
							<form:option value="title">제목</form:option>
							<form:option value="content">내용</form:option>
						</form:select>
						<form:input path="searchWord" class="w200" />
						<a href="#" class="sh_btn" onclick="fn_list(1); return false;">검색</a>
					</div>
				</div>
				<table class="list_type01" summary="Q&A 목록">
					<caption>Q&A</caption>
					<col width="10%" />
					<col width="50%" />
					<col width="15%" />
					<col width="15%" />
					<col width="10%"/>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>글쓴이</th>
							<th>작성일</th>
							<%--
							<th>조회수</th>
							--%>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${resultList }" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td class="ta_left">
									<a href="#" onclick="fn_select(<c:out value='${list.qnaSeq }'/>); return false;"><c:out value="${list.qstTitle }"/></a>
								</td>
								<td><c:out value="${list.qstRegName }"/></td>
								<td><c:out value="${list.qstRegDate }"/></td>
								<%--
								<td><c:out value="${list.qnaHitcount }"/></td>
								--%>
							</tr>
							<c:if test="${!empty list.ansTitle }">
								<tr>
									<td>답변</td>
									<td class="ta_left">
										<a href="#" class="ml20" onclick="fn_select(<c:out value='${list.qnaSeq }'/>); return false;" ><c:out value="${list.ansTitle }"/></a>
									</td>
									<td><c:out value="${list.ansRegName }"/></td>
									<td><c:out value="${list.ansRegDate }"/></td>
									<%--
									<td></td>
									--%>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
				<!-- 하단 영역 -->
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="btn_write" onclick="fn_modify(); return false;">글쓰기</a>
						</div>
					</div>
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image2" jsFunction="fn_list" />
						<form:hidden path="pageIndex" />
					</div>
				</div>
				<!-- 하단 영역 -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" name="message" value="${message }"/>
</form:form>
</body>
</html>