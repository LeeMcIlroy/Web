<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>
	function fn_select(brdSeq){
		$("#brdSeq").val(brdSeq);
		$("#frm").attr("method","post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/wcGuide/exclnt/wcGuideExclntView.do'/>").submit();
	}
	
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/wcGuide/exclnt/wcGuideExclntList.do'/>").submit();
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="brdSeq" name="brdSeq"/> 
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
            	<jsp:param name="dept1" value="글쓰기 길잡이"/>
            	<jsp:param name="dept2" value="우수과제"/>
            </jsp:include>
			<div class="cont_box">
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
				<table class="list_type01" summary="우수과제 목록">
					<caption>우수과제</caption>
					<col width="10%" />
					<col width="60%" />
					<col width="15%" />
					<col width="15%" />
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>글쓴이</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="notice" items="${resultList_notice }">
							<tr>
								<td>
									공지
								</td>
								<td class="ta_left">
									<a href="#" onclick="fn_select(<c:out value='${notice.brdSeq }'/>); return false;">
										<c:out value="${notice.brdTitle }"/>										
									</a>
								</td>
								<td><c:out value="${notice.regName }"/></td>
								<td><c:out value="${notice.regDate }"/></td>
							</tr>
						</c:forEach>
						<c:forEach var="list" items="${resultList }" varStatus="status">
							<tr>
								<td>
									<c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/>
								</td>
								<td class="ta_left">
									<a href="#" onclick="fn_select(<c:out value='${list.brdSeq }'/>); return false;">
										<c:out value="${list.brdTitle }"/>										
									</a>
								</td>
								<td><c:out value="${list.regName }"/></td>
								<td><c:out value="${list.regDate }"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 하단 영역 -->
				<div class="btm_area">
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