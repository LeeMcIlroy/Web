<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>한성대학교 디자인아트 교육원</title>
<!-- header -->
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<!--// header -->
</head>
<body>
<div class="wrap">
	<!-- topnav -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!-- topnav -->
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
			<div class="title_area">
				<h3>배너관리</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 사이트관리 &gt; 배너관리 &nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
			<div class="cont_box">
			<!-- content -->
			<form:form commandName="searchVO" id="frm" name="frm">
				<form:hidden path="searchCondition1" />
				<input type="hidden" id="banSeq" name="banSeq"/>
				<input type="hidden" id="banUseYn" name="banUseYn"/>
				<div class="mid_tab04 mt20">
					<ul>
						<li><a href="#" onclick="fn_list_type('M'); return false;" <c:if test="${searchVO.searchCondition1 eq 'M' }">class="active"</c:if>>메인이미지</a></li>
						<li><a href="#" onclick="fn_list_type('S'); return false;" <c:if test="${searchVO.searchCondition1 eq 'S' }">class="active"</c:if>>서브배너</a></li>
						<li><a href="#" onclick="fn_list_type('L'); return false;" <c:if test="${searchVO.searchCondition1 eq 'L' }">class="active"</c:if>>중간배너</a></li>
						<li><a href="#" onclick="fn_list_type('U'); return false;" <c:if test="${searchVO.searchCondition1 eq 'U' }">class="active"</c:if>>영상배너</a></li>
						<li><a href="#" onclick="fn_list_type('R'); return false;" <c:if test="${searchVO.searchCondition1 eq 'R' }">class="active"</c:if>>롤링배너</a></li>
						<li><a href="#" onclick="fn_list_type('F'); return false;" <c:if test="${searchVO.searchCondition1 eq 'F' }">class="active"</c:if>>좌측배너</a></li>
					</ul>
				</div>
				<div class="tbl_top_side">
					<div class="side_r">
						<ul>
							<li>
								<select class="se_base w100">
									<option>배너명</option>
								</select>
							</li>
							<li>
								<form:input path="searchWord" class="in_base w150" />
							</li>
							<li>
								<a href="#" class="btn_type05 input_btn" onclick="fn_list('1'); return false;">검색</a>
							</li>
						</ul>
					</div>
				</div>
				<table class="list_tbl_03" summary="배너 관리 목록">
					<caption>배너관리</caption>
					<colgroup>
						<col style="width:6%" />
						<c:if test="${searchVO.searchCondition1 ne 'S'  && searchVO.searchCondition1 ne 'L' }">
							<c:if test="${searchVO.searchCondition1 eq 'U' }">
								<col style="width:37%" />
							</c:if>
							<c:if test="${searchVO.searchCondition1 ne 'U' }">
								<col style="width:14%" />
							</c:if>
						</c:if>
						<c:if test="${searchVO.searchCondition1 ne 'U' }">
							<col style="width:23%" />
						</c:if>
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:7%" />
						<col style="width:7%" />
						<col style="width:23%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<c:if test="${searchVO.searchCondition1 ne 'S'  && searchVO.searchCondition1 ne 'L'}">
								<c:if test="${searchVO.searchCondition1 eq 'U' }">
									<th scope="col">영상</th>
								</c:if>
								<c:if test="${searchVO.searchCondition1 ne 'U' }">
									<th scope="col">이미지</th>
								</c:if>
							</c:if>
							<c:if test="${searchVO.searchCondition1 ne 'U' }">
								<th scope="col">배너명</th>
							</c:if>
							<th scope="col">새창여부</th>
							<th scope="col">순서</th>
							<th scope="col" colspan="2">사용여부</th>
							<th scope="col">등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
						<tr>
							<c:if test="${searchVO.searchCondition1 eq 'U' }">
							<td><a href="#" onclick="fn_modify('<c:out value='${result.banSeq}'/>'); return false;"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></a></td>
							</c:if>
							<c:if test="${searchVO.searchCondition1 ne 'U' }">
							<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
							</c:if>
							<c:if test="${searchVO.searchCondition1 ne 'S'  && searchVO.searchCondition1 ne 'L' }">
							<td>
								<c:if test="${searchVO.searchCondition1 ne 'U' }">
									<img onerror="this.src='<c:url value='/assets/adm/img/no_img.jpg'/>'" src="<c:url value="/showThumbImage.do?filePath=${result.banImgPath }"/>" alt="배너 미리보기"  style="width:90%; text-align:center;" />
								</c:if>
								<c:if test="${searchVO.searchCondition1 eq 'U' }">
									<iframe style="width:90%; text-align:center;" src="https://www.youtube.com/embed/<c:out value='${fn:trim(fn:replace(fn:replace(result.banUrl, "http://youtu.be/", ""), "https://youtu.be/", "")) }'/>" frameborder="0" allowfullscreen></iframe>
								</c:if>
							</td>
							</c:if>
							<c:if test="${searchVO.searchCondition1 ne 'U' }">
								<td><a href="#" onclick="fn_modify('<c:out value="${result.banSeq }"/>'); return false;"><c:out value="${result.banName }" escapeXml="false"/></a> </td>
							</c:if>
							<td>
								<c:if test="${result.banNewWindow == 'Y' }">새창</c:if>
								<c:if test="${result.banNewWindow == 'N' }">현재창</c:if>
								<c:if test="${result.banNewWindow == '01' }">원서접수</c:if>
								<c:if test="${result.banNewWindow == '02' }">원서접수확인</c:if>
								<c:if test="${result.banNewWindow == '03' }">합격자조회</c:if>
							</td>
							<td><c:out value="${result.banOrder }"/></td>
							<c:if test="${result.banUseYn == 'Y' }">
							<td class="bg_yes" >YES</td>
							<td><a href="#"  onclick="fn_modify_useYn('<c:out value="${result.banSeq}"/>' ,'N'); return false;">NO</a></td>
							</c:if>
							<c:if test="${result.banUseYn == 'N' }">
							<td><a href="#"  onclick="fn_modify_useYn('<c:out value="${result.banSeq}"/>' ,'Y'); return false;">YES</a></td>
							<td class="bg_no" >NO</td>
							</c:if>
							<td><c:out value="${result.banRegDate }"/></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="btm_area">
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
					</div>
					<div class="page_btn">
						<a href="#" onclick="fn_modify(0); return false;" class="b_type03">등록</a>
					</div>
				</div>
			</form:form>
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
<script type="text/javascript">
	
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/banner/admBannerList.do'/>").submit();
	}
	
	// 조회
	function fn_modify(banSeq){
		$("#banSeq").val(banSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/banner/admBannerModify.do'/>").submit();
	}

	//탭이동
	function fn_list_type(type){
		$("#searchCondition1").val(type);
		$("#searchWord").val("");
		fn_list(1);
	}
	
	// 배너사용여부 수정
	function fn_modify_useYn(banSeq, banUseYn){
		$("#banSeq").val(banSeq);
		$("#banUseYn").val(banUseYn);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/banner/admBannerUseYnUpdate.do'/>").submit();
	}
</script>
</body>
</html>