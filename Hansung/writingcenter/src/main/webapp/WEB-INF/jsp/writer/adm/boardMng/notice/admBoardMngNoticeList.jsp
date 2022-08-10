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
	$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/boardMng/notice/admBoardMngNoticeList.do'/>").submit();
}

/* 글쓰기 화면 이동 */
function fn_modify(brdSeq){
	$("#brdSeq").val(brdSeq);
	$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/notice/admBoardMngNoticeModifyView.do'/>").submit();
}

/* 글쓰기 조회*/
function fn_select(brdSeq){
	$("#brdSeq").val(brdSeq);
	$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/notice/admBoardMngNoticeView.do'/>").submit();
}

/* 체크박스 선택 삭제 */
function fn_delete(){
	var delSeq;

	if($("input:checkbox[name='listChkBox']").is(":checked")==true){
		if(window.confirm("게시글을 삭제하시겠습니까?")==true){
			$("input:checkbox[name='listChkBox']:checked").each(function(i){
				if(i==0){
					delSeq=$(this).val();
				}else{
					delSeq=delSeq+","+$(this).val();
				}
				
			});
			$("#brdSeq").val(delSeq);
			$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/notice/admBoardMngNoticeDelete.do'/>").submit();
		}else{
			return false;
		}
		
	}else{
		alert("삭제할 게시글을 선택하세요");
		return false;
	}
}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="brdSeq" name="brdSeq">
<input type="hidden" id="searchType" name="searchType" value="NOTI">
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
		            <jsp:param name="dept2" value="공지사항"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<table class="list_tbl_03 mt30" summary="공지사항 목록">
					<caption>공지사항</caption>
					<colgroup>
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:40%" />
						<col style="width:15%" />
						<col style="width:15%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col"><input type="checkbox" id="allChkBox"/></th>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">글쓴이</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="notice" items="${resultList_notice }">
							<tr>
								<td><input type="checkbox" name="listChkBox" value="<c:out value='${notice.brdSeq }'/>"/></td>
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
								<td><c:out value="${notice.brdHitcount }"/></td>
							</tr>
						</c:forEach>
						<c:forEach var="list" items="${resultList }" varStatus="status">
							<tr>
								<td><input type="checkbox" name="listChkBox" value="<c:out value='${list.brdSeq }'/>"/></td>
								<td>
									<c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/>
								</td>
								<td class="ta_left">
									<a href="#" onclick="fn_select(<c:out value='${list.brdSeq }'/>); return false;"><c:out value="${list.brdTitle }"/></a>
								</td>
								<td><c:out value="${list.regName }"/></td>
								<td><c:out value="${list.regDate }"/></td>
								<td><c:out value="${list.brdHitcount }"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_modify(); return false;">글쓰기</a>
							<a href="#" class="b_type03" onclick="fn_delete(); return false;">삭제</a>
						</div>
					</div>
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
					</div>

					<div class="tbl_top_side">
						<div class="side_c">
							<ul>
								<li>
								<form:select path="searchCondition" class="se_base w100">
									<form:option value="title">제목</form:option>
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
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>