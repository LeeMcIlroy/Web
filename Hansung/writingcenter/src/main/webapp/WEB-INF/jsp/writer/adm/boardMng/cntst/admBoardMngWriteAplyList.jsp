<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko" >
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">
//체크박스 전체선택 & 전체해제
$(function(){
	$(document).on("click","#allChkBox",function(){
		var chk=$(this).is(":checked");
		if(chk){
			$("input:checkbox[name='listChkBox']").prop("checked",true);
		}else{
			$("input:checkbox[name='listChkBox']").prop("checked",false);
		}
	});
});

/* pagination 페이지 링크 function */
function fn_list(pageNo){
	$("#pageIndex").val(pageNo);
	$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyList.do'/>").submit();
}

/* 글쓰기 조회*/
function fn_select(aplySeq){
	$("#aplySeq").val(aplySeq);
	$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyView.do'/>").submit();
}

// 엑셀 다운로드 popup
function fn_excelDown(){
	$.fileDownload("/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyExcel.do", {
		data : $("#frm").serialize()
		, httpMethod: "POST"
		, successCallback : function(url){
			// 로딩 end
		}
	});
}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="aplySeq" name="aplySeq">
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
					<jsp:param name="dept1" value="게시판관리"/>
		            <jsp:param name="dept2" value="신청자(글쓰기대회)"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_excelDown(); return false;">엑셀 다운로드</a>
						</div>
					</div>
				</div>
				<!-- content -->
				<table class="list_tbl_03 mt30" summary="대회자료실 목록">
					<caption>대회자료실</caption>
					<colgroup>
						<col style="width:10%" />
						<col style="width:15%" />
						<col style="width:15%" />
						<col style="width:30%" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">신청인</th>
							<th scope="col">학번</th>
							<th scope="col">대학</th>
							<th scope="col">학년</th>
							<th scope="col">학적구분</th>
							<th scope="col">신청일시</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${resultList }" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td>
									<a href="#" onclick="fn_select('<c:out value="${list.aplySeq }"/>'); return false;"><c:out value="${list.aplyName }"/></a>
								</td>
								<td>
									<a href="#" onclick="fn_select('<c:out value="${list.aplySeq }"/>'); return false;"><c:out value="${list.aplyHakbun }"/></a>
								</td>
								<td><c:out value="${list.aplyDept }"/></td>
								<td><c:out value="${list.aplyGrade }"/></td>
								<td><c:out value="${list.aplyRegistYn eq 'Y'?'재학':'휴학' }"/></td>
								<td><c:out value="${list.regDate }"/></td>
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

					<div class="tbl_top_side">
						<div class="side_c">
							<ul>
								<li>
								<form:select path="searchYear" class="se_base w100">
									<form:option value="2022">2022</form:option>
									<form:option value="2021">2021</form:option>
									<form:option value="2020">2020</form:option>
								</form:select>
								</li>
								<li>
								<form:select path="searchCondition" class="se_base w100">
									<form:option value="name">신청인</form:option>
									<form:option value="hakbun">학번</form:option>
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
<input type="hidden" id="message" value="${searchVO.message}" />
</form:form>
</body>
</html>