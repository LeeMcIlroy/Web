<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>

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
//등록 화면 이동
function fn_modify(memSeq){
	$("#memSeq").val(memSeq);
	$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberModifyView.do'/>").submit();	
}

//페이징 이동
function fn_list(pageNo){
	$("#pageIndex").val(pageNo);
	$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberList.do'/>").submit();
}


/* 체크박스 선택 삭제 */
function fn_delete(){
	var delSeq;

	if($("input:checkbox[name='listChkBox']").is(":checked")==true){
		if(window.confirm("회원을 삭제하시겠습니까?")==true){
			$("input:checkbox[name='listChkBox']:checked").each(function(i){
				if(i==0){
					delSeq=$(this).val();
				}else{
					delSeq=delSeq+","+$(this).val();
				}
				
			});
			$("#memSeq").val(delSeq);
			$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberDelete.do'/>").submit();
		}else{
			return false;
		}
		
	}else{
		alert("삭제할 회원을 선택하세요");
		return false;
	}
}

/* 회원조회 이동 */
function fn_select(memSeq){
	$("#memSeq").val(memSeq);
	$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberView.do'/>").submit();
}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="memSeq" name="memSeq"/>
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
		            <jsp:param name="dept2" value="회원관리"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<table class="list_tbl_03 mt30" summary="도서목록">
					<caption>도서목록</caption>
					<colgroup>
						<col style="width:12%" />
						<col style="width:11%" />
						<col style="width:11%" />
						<col style="width:11%" />
						<col style="width:22%" />
						<col style="width:11%" />
						<col style="width:11%" />
						<col style="width:11%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col"><input type="checkbox" id="allChkBox"/></th>
							<th scope="col">번호</th>
							<th scope="col">사번</th>
							<th scope="col">이름</th>
							<th scope="col">이메일</th>
							<th scope="col">회원레벨</th>
							<th scope="col">첨삭</th>
							<th scope="col">등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${listVO }" varStatus="status">
						<tr onclick="fn_select(<c:out value="${list.memSeq }"/>); return false;" style="cursor: pointer;">
							<td onclick="event.cancelBubble = true;" style="cursor: default; "><input type="checkbox" name="listChkBox" value="<c:out value="${list.memSeq }"/>" /></td>
							<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
							<td><c:out value="${list.memCode }"/></td>
							<td><c:out value="${list.memName }"/></td>
							<td><c:out value="${list.memEmail }"/></td>
							<td>
								<c:if test="${list.memLevel == '1' }">
									관리자
								</c:if>
								<c:if test="${list.memLevel == '2' }">
									교수
								</c:if>
								<c:if test="${list.memLevel == '3' }">
									연구원
								</c:if>
							</td>
							<td>
								<c:if test="${list.memUpdtYn eq 'Y' }">
									가능
								</c:if>
								<c:if test="${list.memUpdtYn eq 'N' }">
									불가능
								</c:if>
							</td>
							<td><c:out value="${list.regDate }"/></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_modify(); return false;">등록</a>
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
								<form:select path="searchCondition" class="se_base">
									<form:option value="memName">이름</form:option>
									<form:option value="memEmail">이메일</form:option>
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
							회원 <span><c:out value='${paginationInfo.totalRecordCount }'/></span>명
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