<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">

	//목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardList.do'/>").submit();
	}

	//목록2
	function fn_list2(searchType){
		$("#searchCondition").val("");
		$("#searchWord").val("");
		if(searchType == "CLS_SBJT"){
			action = "<c:out value='${pageContext.request.contextPath }/usr/lec/lecSubjectList.do'/>";
		}else if(searchType == "CLS_NOTI"){
			action = "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardList.do'/>";
		}
		$("#frm").attr("method", "post").attr("action", action).submit();
	}
	
	// 조회
	function fn_select(ntSeq){
		$("#ntSeq").val(ntSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardView.do'/>").submit();
	}
	
	// 등록
	function fn_modify(){
		$("#ntSeq").val("");
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardModify.do'/>").submit();
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchClass" />
<input type="hidden" id="ntSeq" name="ntSeq"/>
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
            	<jsp:param name="dept1" value="강의실"/>
            	<jsp:param name="dept2" value="${smtrClsInfo.smtrTitle }"/>
            </jsp:include>
			<div class="cont_box">
				<div class="g_box02 mb20">
					<c:out value="${smtrClsInfo.deptTitle }"/>&nbsp;|&nbsp;<c:out value="${smtrClsInfo.clsTitle }"/>&nbsp;<span>강의실</span>
				</div>
				<div class="tab li02 mb20">
					<ul>
						<li><a href="#" onclick="fn_list2('CLS_SBJT'); return false;">주제 출제</a></li>
						<li><a href="#" class="active" onclick="fn_list2('CLS_NOTI'); return false;">우리반 게시판</a></li>
					</ul>
				</div>
				<div class="sh_box">
					<div class="sh_l_box">
						게시물 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건
					</div>
					<div class="sh_r_box">
						<c:if test="${searchVO.searchType eq 'CLS_SBJT' }">
							<input type="checkbox" name="" id="my_check" /> <label for="my_check">나의 강의실로 지정하기</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:if>
						<form:select path="searchCondition" class="w100">
							<form:option value="title">제목</form:option>
							<form:option value="name">글쓴이</form:option>
						</form:select>
						<form:input path="searchWord" class="w200" />
						<a href="#" class="sh_btn" onclick="fn_list(1); return false;">검색</a>
					</div>
				</div>
				<table class="list_type01" summary="강의실 리스트">
					<caption>강의실</caption>
					<colgroup>
						<col width="10%" />
						<col width="50%" />
						<col width="15%" />
						<col width="15%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>글쓴이</th>
							<th>작성일</th>
							<th>조회</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${notiList }" var="noti">
                       		<tr>
                       			<td>공지</td>
								<td class="ta_left">
									<a href="#" class="comt" onclick="fn_select(<c:out value='${noti.ntSeq }'/>); return false;">
										<c:out value="${noti.ntTitle }"/>
										<c:if test="${noti.cmmtCnt > 0 }">
											<span>(<c:out value="${noti.cmmtCnt }"/>)</span>
										</c:if>
									</a>
								</td>
								<td><c:out value="${noti.regName }"/></td>
								<td><c:out value="${noti.regDate }"/></td>
								<td><c:out value="${noti.ntHitcount }"/></td>
                       		</tr>
                       	</c:forEach>
                       	<c:forEach items="${resultList }" var="result" varStatus="status">
                       		<tr>
                       			<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td class="ta_left">
									<a href="#" class="comt" onclick="fn_select(<c:out value='${result.ntSeq }'/>); return false;">
										<c:out value="${result.ntTitle }"/>
										<c:if test="${result.cmmtCnt > 0 }">
											<span>(<c:out value="${result.cmmtCnt }"/>)</span>
										</c:if>
									</a>
								</td>
								<td><c:out value="${result.regName }"/></td>
								<td><c:out value="${result.regDate }"/></td>
								<td><c:out value="${result.ntHitcount }"/></td>
                       		</tr>
                       	</c:forEach>
					<%--
						<tr>
							<td>공지</td>
							<td class="ta_left"><a href="#">토론 개요서</a></td>
							<td>박선옥</td>
							<td>2016-12-25</td>
							<td>25</td>
						</tr>
						<tr>
							<td>4</td>
							<td class="ta_left"><a href="#">토론 개요서</a></td>
							<td>박선옥</td>
							<td>2016-12-25</td>
							<td>25</td>
						</tr>
				 	--%>
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