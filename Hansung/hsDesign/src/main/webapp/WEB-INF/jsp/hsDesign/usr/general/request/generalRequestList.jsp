<%@page import="hsDesign.valueObject.CmmBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	
	$(function(){
		$(document).on("keydown", "#cbPassword", function(e){
			if (e.keyCode == 13) {
				fn_select_pwd();
				return false;
			}
		});
	});
	
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/general/request/generalRequestList.do'/>").submit();
	}


	
	function fn_select_pwd(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/general/request/generalRequestView.do'/>").submit();
	}
	
	
	// 조회
	function fn_select(cbSeq, cbSecretYn){
		$("#cbSeq").val(cbSeq);
		if(cbSecretYn == 'Y'){
			$(".pop_pw").show();
			
			$("#cbPassword").focus();	
		}else{
		
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/general/request/generalRequestView.do'/>").submit();
		}
	}
	
	// 취소
	function fn_cancel(){
		$(".pop_pw").hide();
		$("#cbSeq").val("");
		$("#cbPassword").val("");
		
	}
	
	
	// 등록 & 수정 화면
	function fn_modify(cbSeq){
		$("#cbSeq").val(cbSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/general/request/generalRequestModify.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchType"/>
<input type="hidden" id="cbSeq" name="cbSeq"> <!-- 게시판의 각 리스트의 넘버를 히든값으로  -->
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<!-- container -->
	<div class="main_content" id="content">
		<div class="width_box">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
			<!--// lnb -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="비학위과정"/>
		            <jsp:param name="dept2" value="수강문의"/>
	           	</jsp:include>
	           	<div class="list_sh">
					<ul>
						<li>
							<form:select path="searchCondition2">
								<form:option value="">전체</form:option>
								<form:option value="title">제목</form:option>
								<form:option value="writer">작성자</form:option>
							</form:select>
						</li>
						<li>
							<form:input path="searchWord" />
						</li>
						<li>
							<a href="#" onclick="fn_list(1); return false;"><img src="<c:out value='${pageContext.request.contextPath  }/assets/usr/img/icon_sh.png'/>" alt="찾기" /></a>
						</li>
					</ul>
				</div>
				<div class="transform_table notice_type">
					<ul class="tbl_th">
						<li>번호</li>
						<li>제목</li>
						<li>작성자</li>
						<li>작성일</li>
						<li>조회</li>
					</ul>
					<div class="tbl_td">
						<c:forEach items="${ntResultList }" var="ntResult" varStatus="status">
							<ul>
								<li class="tbl_ntc"><span>공지</span></li>
								<li class="txt_left" style="text-overflow:ellipsis; overflow: hidden;  white-space: nowrap; max-width: 1000px;">
										<a href="#" onclick="fn_select('<c:out value='${ntResult.cbSeq }'/>', '<c:out value='${ntResult.cbSecretYn }'/>'); return false;">
											<c:out value="${ntResult.cbTitle }" escapeXml="false"/>
											<c:if test="${ntResult.cmmtCount gt 0 }">(<c:out value="${ntResult.cmmtCount }"/>)</c:if>
											<c:if test="${ntResult.cbSecretYn eq 'Y' }">
												<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_lock.png'/>" alt="비밀글" />
											</c:if>
										</a>
									</li>
								<li><c:if test="${!empty ntResult.regName }">
									<c:out value="${ntResult.regName }" />
								</c:if> <c:if test="${empty ntResult.regName }">&nbsp;</c:if></li>
								<li><c:out value="${ntResult.cbRegDate }"/></li>
								<li><c:out value="${ntResult.cbCount }"/></li>
							</ul>
						</c:forEach>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<ul>
								<li class="tbl_ntc"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></li>
								<li class="txt_left" >
									<a href="#" onclick="fn_select('<c:out value='${result.cbSeq }'/>','<c:out value='${result.cbSecretYn }'/>'); return false;">	
										<c:out value="${result.cbTitle }" escapeXml="false"/>
										<c:if test="${result.cmmtCount gt 0 }">(<c:out value="${result.cmmtCount }"/>)</c:if>
										<c:if test="${result.cbSecretYn eq 'Y' }">
											<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_lock.png'/>" alt="비밀글" />
										</c:if>
									</a>
								</li>
								<li><c:out value="${result.regName }"/></li>
								<li><c:out value="${result.cbRegDate }"/></li>
								<li><c:out value="${result.cbCount }"/></li>
							</ul>
			 	<!--********************추가 시작 ********************** -->
		
						<c:if test="${result.cbContentReply != null}">
						<ul>
						<li class="tbl_ntc"></li>
						<li class="txt_left" style="margin-left: 87px;"><a href="#" onclick="fn_select('<c:out value='${result.cbSeq }'/>','<c:out value='${result.cbSecretYn }'/>'); return false;">
						<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/Re.png'/>" alt="화살표" />
						Re : <c:out value="${result.cbTitle }" escapeXml="false"/>&nbsp<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_lock.png'/>" alt="비밀글" /></a></li>
						<li><c:out value="${result.cbConreplyName }"/></li>
						<li><c:out value="${result.cbConreplyDate }"/></li>
						<li><c:out value="${result.cbCount }"/></li>
						</ul>
						</c:if>
						</c:forEach>
				<!--********************추가 끝 ********************** -->
					</div>
				</div>
				<div class="btn_box txt_right">
					<a href="#" onclick="fn_modify(); return false;" class="btn_go_write">글쓰기</a>
				</div>
				<div class="pager">
					<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list"/>
					<form:hidden path="pageIndex"/>
				</div>
				<!-- 비밀글 본인 확인 창 숨김 -->
				<div class="pop_pw" style="display:none;">
					<div class="pop_cont">
						<div class="pop_title">비밀번호</div>
						<div class="pop_sub_page">
							<div><input id="cbPassword" name="cbPassword" type="password" class="pop_pw_input" /></div>
							<div class="pop_btn_box">
								<a href="#" class="btn_enter" onclick="fn_select_pwd(); return false;">확인</a>
								<a href="#" class="btn_cancel" onclick="fn_cancel(); return false;">취소</a>
							</div>
						</div>
					</div>
				</div>
				<!-- 비밀글 본인 확인 창 -->
	
				<!-- rolling banner -->
				<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
				<!-- //rolling banner -->
				<!-- //content -->
			</div>
	</div>
	<!-- content -->
	<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>