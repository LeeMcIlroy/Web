<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>
	//등록 & 수정 화면
	function fn_modify(popSeq){
		$("#popSeq").val(popSeq);
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/popup/admSiteMngPopupModifyView.do'/>").submit();
	}
	
	//삭제
	function fn_delete(popSeq){
		if(confirm("해당 팝업을 삭제하시겠습니까?")==true){
			$("#popSeq").val(popSeq);
			$("#frm").attr("mrthod","post").attr("action","<c:url value='/xabdmxgr/siteMng/popup/admSiteMngPopupDelete.do'/>").submit();
		}else{
			return false;
		}
	}
	
	//팝업열기
	function fn_popupOpen(title,width,height,top,left,scrollYn,resizeYn,popSeq){
		url="<c:url value='/xabdmxgr/siteMng/popup/admSiteMngPopupOpen.do?popSeq="+popSeq+"'/>";
		 
		if(scrollYn =='Y'){
			scrollYn = 'yes';
		}else{
			scrollYn = 'no';
		}
		if(resizeYn == 'Y'){
			resizeYn = 'yes';
		}else{
			resizeYn = 'no';
		}
		var option = "width="+width+", height="+height+", top="+top+", left="+left+", scrollbars="+scrollYn+", resizable="+resizeYn;
		win = window.open(url, "", option);
		return false;
	}
	//페이징 이동
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/siteMng/popup/admSiteMngPopupList.do'/>").submit();
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="popSeq" name="popSeq"/> 
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
					<jsp:param name="dept1" value="사이트관리"/>
		            <jsp:param name="dept2" value="팝업관리"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<table class="list_tbl_03 mt30" summary="팝업관리 목록">
					<caption>팝업관리</caption>
					<colgroup>
						<col style="width:10%" />
						<col style="width:60%" />
						<col style="width:15%" />
						<col style="width:15%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">View 여부</th>
							<th scope="col">수정/삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${resultList }" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td class="ta_left">
									<a href="#" onclick="fn_popupOpen('<c:out value='${list.popTitle }'/>',<c:out value='${list.popWidth }'/>,<c:out value='${list.popHeight }'/>,<c:out value='${list.popTop }'/>,<c:out value='${list.popLeft }'/>,'<c:out value='${list.popScrollYn }'/>','<c:out value='${list.popResizeYn }'/>','<c:out value='${list.popSeq }'/>'); return false;">
										<c:out value="${list.popTitle }"/>
									</a>
								</td>
								<td>
									<c:if test="${list.popViewYn eq 'Y'}">
										보이기
									</c:if>
									<c:if test="${list.popViewYn eq 'N'}">
										숨기기
									</c:if>
								</td>
								<td>
									<a href="#" class="btn_s_modi" onclick="fn_modify(<c:out value='${list.popSeq }'/>); return false;">수정</a>
									<a href="#" class="btn_s_del" onclick="fn_delete(<c:out value='${list.popSeq }'/>); return false;">삭제</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type03" onclick="fn_modify(); return false;">등록</a>
						</div>
					</div>
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
					</div>
				</div>
				<div class="tbl_top_side">
					<div class="side_c">
						<ul>
							<li>
								<form:select path="searchCondition" class="se_base w100">
									<form:option value="title">제목</form:option>
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
						게시물 <span><c:out value='${paginationInfo.totalRecordCount }'/></span>건
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