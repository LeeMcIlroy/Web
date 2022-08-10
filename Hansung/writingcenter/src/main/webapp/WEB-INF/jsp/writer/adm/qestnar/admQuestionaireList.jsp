<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script>
	//설문 등록
	function fn_modify(qstnrSeq){
		$("#qstnrSeq").val(qstnrSeq);
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/qestnar/admQuestionaireModify.do'/>").submit();
	}
	
	//설문 답변자 보기
	function fn_ansList(qstnrSeq, smtrSeq){
		$("#searchWord").val(qstnrSeq);
		$("#searchSemester").val(smtrSeq);
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/qestnar/admQuestionaireAnswererList.do'/>").submit();
	}
	
	function fn_list(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/qestnar/admQuestionaireList.do'/>").submit();
	}
	
	//삭제
	function fn_delete(qstnrSeq, respCount){
		if(confirm("설문조사를 삭제하시겠습니까?")){
		/* 20200622수정 > 답변자 있어도 삭제가되도록 수정
		  if(respCount > 0){
				alert("답변자가 있습니다.");
				return false;
			} */
			$("#qstnrSeq").val(qstnrSeq);
			$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/qestnar/admQuestionaireDelete.do'/>").submit();
		}
	}
	
	//조회
	function fn_select(qstnrSeq){
		$("#qstnrSeq").val(qstnrSeq);
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/qestnar/admQuestionaireView.do'/>").submit();
	}
	

	
	
	
</script>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchWord" />
<form:hidden path="searchSemester" />
<input type="hidden" id="qstnrSeq" name="qstnrSeq"/>
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
				<table class="list_tbl_03 mt30" summary="설문조사 목록">
					<caption>설문조사</caption>
					<colgroup>
						<col style="width:5%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:21%" />
						<col style="width:8%" />
						<col style="width:12%" />
						<col style="width:14%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">학기강의실</th>
							<th scope="col">설문구분제목</th>
							<th scope="col">설문기간</th>
							<th scope="col">총답변수</th>
							<th scope="col">답변자 보기</th>
							<th scope="col">수정/삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList }" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td><c:out value="${result.smtrTitle }"/></td>
								<td>
									<a href="#" onclick="fn_select(<c:out value='${result.qstnrSeq }'/>); return false;"><c:out value="${result.qstnrTitle }"/></a>
								</td>
								<td><c:out value="${result.qstnrStartDate }"/> ~ <c:out value="${result.qstnrEndDate}"/></td>
								<td><c:out value="${result.qstnrRespCount }"/></td>
								<td><a href="#" onclick="fn_ansList(<c:out value='${result.qstnrSeq }'/>,<c:out value='${result.smtrSeq }'/>); return false;">보기</a></td>
								<td><a href="#" class="btn_s_modi" onclick="fn_modify(<c:out value="${result.qstnrSeq }"/>)">수정</a><a href="#" class="btn_s_del" onclick="fn_delete(<c:out value='${result.qstnrSeq }'/>, <c:out value="${result.qstnrRespCount }"/>); return false;" >삭제</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type03" onclick="fn_modify(); return false;" >설문등록</a>
						</div>
					</div>
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
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