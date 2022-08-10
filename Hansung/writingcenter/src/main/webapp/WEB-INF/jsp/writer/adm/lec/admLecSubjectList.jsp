<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript" defer="defer">

	// 조회
	function fn_select(sbjtSeq){
		$("#searchSubject").val(sbjtSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecHomeWorkList.do'/>").submit();
	}

	// 등록
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecSubjectModify.do'/>").submit();
	}

	/* pagination 페이지 링크 function */
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecSubjectList.do'/>").submit();
	}
	
	// 목록
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
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchClass" />
<form:hidden path="searchSubject" />
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
			<!--// 타이틀 영역 -->
			<div class="cont_box">
			<!-- content -->
				<!-- page_cont_title -->
				<div class="pt_tit">
					<c:out value="${smtrClsInfo.deptTitle }"/>&nbsp;|&nbsp;<c:out value="${fn:replace(smtrClsInfo.clsTitle, '-', '') }" escapeXml="false"/> <span>강의실</span>
					<c:if test="${sessionScope.adminSession.memLevel ne '3' }">
						<c:if test="${!empty smtrClsInfo.clsLink }"><a href="<c:out value='${smtrClsInfo.clsLink }'/>" class="btn" target="_blank">블랙보드 바로가기</a></c:if>
					</c:if>					
				</div>
				<!-- //page_cont_title -->
				<!-- mid_tab-->
				<div class="mid_tab01">
					<ul>
						<li><a href="#" class="active" onclick="fn_list2('CLS_SBJT'); return false;">주제 출제</a></li>
						<li><a href="#" onclick="fn_list2('CLS_NOTI'); return false;">우리반 게시판</a></li>
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
							<th scope="col">강의 주제</th>
							<th scope="col">시작일</th> 
							<th scope="col">마감일</th>
							<th scope="col">순서</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td class="ta_left">
									<a href="#" onclick="fn_select(<c:out value='${result.sbjtSeq }'/>); return false;"><c:out value="${result.sbjtTitle }"/></a>
									<c:if test="${result.sbjtViewYn eq 'N' }"><img src="<c:url value='/assets/usr/img/user_lock.png'/>" alt="" ></c:if>
								</td>
								<td><c:out value="${result.sbjtStartDate }"/></td>
								<td><c:out value="${result.sbjtEndDate }"/></td>
								<td><c:out value="${result.sbjtSort }"/></td>
							</tr>
                       	</c:forEach>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type01" onclick="fn_modify(); return false;">주제 출제하기</a>
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
									<form:option value="title">강의주제</form:option>
									<form:option value="content">내용</form:option>
								</form:select>
							</li>
							<li>
								<form:input path="searchWord" class="in_base w150"/>
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
<div style="visibility: hidden;">
	<iframe src="http://info.hansung.ac.kr/index_blackboard.jsp"></iframe>
</div>
</body>
</html>