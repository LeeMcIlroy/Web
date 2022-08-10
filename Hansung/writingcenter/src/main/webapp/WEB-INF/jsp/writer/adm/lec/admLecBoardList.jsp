<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">

	/* pagination 페이지 링크 function */
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecBoardList.do'/>").submit();
	}
	
	// 목록2
	function fn_list2(searchType){
		$("#searchCondition").val("");
		$("#searchWord").val("");
		if(searchType == "CLS_SBJT"){
			action = "<c:url value='/xabdmxgr/lec/admLecSubjectList.do'/>";
		}else if(searchType == "CLS_NOTI"){
			action = "<c:url value='/xabdmxgr/lec/admLecBoardList.do'/>";
		}
		$("#frm").attr("method", "post").attr("action", action).submit();
	}
	
	// 조회
	function fn_select(ntSeq){
		$("#ntSeq").val(ntSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecBoardView.do'/>").submit();
	}

	// 등록
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecBoardModify.do'/>").submit();
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
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!--// header -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의실"/>
            	<jsp:param name="dept2" value="${smtrClsInfo.smtrTitle }"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<!-- page_cont_title -->
				<div class="pt_tit"><c:out value="${smtrClsInfo.deptTitle }"/>&nbsp;|&nbsp;<c:out value="${smtrClsInfo.clsTitle }"/> <span>강의실</span></div>
				<!-- //page_cont_title -->
				<!-- mid_tab-->
				<div class="mid_tab01">
					<ul>
						<li><a href="#" onclick="fn_list2('CLS_SBJT'); return false;">주제 출제</a></li>
						<li><a href="#" class="active" onclick="fn_list2('CLS_NOTI'); return false;">우리반 게시판</a></li>
					</ul>
				</div>
				<!-- //mid_tab-->
				<!-- table -->
				<div class="tbl_top_area2">
					<p class="total_count">총 <span><c:out value="${paginationInfo.totalRecordCount }"/></span> 건</p>
				</div>
				<table class="list_tbl_03" summary="주제 출제 목록">
					<caption>주제 출제</caption>
					<colgroup>
						<col style="width:10%" />
						<col style="width:50%" />
						<col style="width:15%" />
						<col style="width:15%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">글쓴이</th>
							<th scope="col">작성일</th>
							<th scope="col">조회</th>
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
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type01" onclick="fn_modify(); return false;">글쓰기</a>
						</div>
					</div>
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
						<form:hidden path="pageIndex" />
					</div>
				</div>
				<div class="tbl_top_side">
					<div class="side_c">
						<ul>
							<li>
								<form:select path="searchCondition" class="se_base w100">
									<form:option value="title">제목</form:option>
									<form:option value="name">글쓴이</form:option>
								</form:select>
							</li>
							<li>
								<form:input path="searchWord" class="in_base w150" />
							</li>
							<li>
								<a href="#" class="btn_type05 input_btn" onclick="fn_list(1); return false;">검색</a>
							</li>
						</ul>
					</div>
					<div class="total">
						게시물 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건
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