<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
				<h3>팝업관리</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 사이트관리 &gt; 팝업관리 &nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
			<div class="cont_box">
			<!-- content -->
			<form:form commandName="searchVO" id="frm" name="frm">
			<input type="hidden" name="popSeq" id="popSeq"/>
			<input type="hidden" name="popUseYn" id="popUseYn"/>
				<div class="tbl_top_side">
					<div class="side_r">
						<ul>
							<li>
								<form:select path="searchCondition1" class="se_base w100">
									<form:option value="">전체</form:option>
									<form:option value="Y">사용</form:option>
									<form:option value="N">미사용</form:option>
								</form:select>
							</li>
							<li>
								<form:select path="searchCondition2" class="se_base w100">
									<form:option value="N">이름</form:option>
								</form:select>
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
				<table class="list_tbl_03" summary="팝업 관리 목록">
					<caption>팝업관리</caption>
					<colgroup>
						<col style="width:10%" />
						<col style="width:*" />
						<col style="width:7%" />
						<col style="width:7%" />
						<col style="width:20%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col" colspan="2">사용여부</th>
							<th scope="col">수정/삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td class="ta_left" style="cursor: pointer;" onclick="fn_popupOpen('<c:out value='${result.popTitle }'/>',<c:out value='${result.popWidth }'/>,<c:out value='${result.popHeight }'/>,<c:out value='${result.popTop }'/>,<c:out value='${result.popLeft }'/>,'<c:out value='${result.popScrollYn }'/>','<c:out value='${result.popResizeYn }'/>','<c:out value='${result.popSeq }'/>'); return false;">
									<c:out value="${result.popTitle }"/>
								</td>
								<c:if test="${result.popUseYn == 'Y' }">
								<td class="bg_yes" >YES</td>
								<td><a href="#"  onclick="fn_modify_useYn('<c:out value="${result.popSeq}"/>' ,'N'); return false;">NO</a></td>
								</c:if>
								<c:if test="${result.popUseYn == 'N' }">
								<td><a href="#"  onclick="fn_modify_useYn('<c:out value="${result.popSeq}"/>' ,'Y'); return false;">YES</a></td>
								<td class="bg_no" >NO</td>
								</c:if>
								<td>
									<a href="#" class="btn_s_modi" onclick="fn_modify('<c:out value="${result.popSeq }"/>'); return false;">수정</a><a href="#" class="btn_s_del" onclick="fn_delete('<c:out value="${result.popSeq }"/>'); return false;">삭제</a>
								</td>
							</tr>
								<input type="hidden" value='${result.popUrl}'> </input>
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
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/popup/admPopupList.do'/>").submit();
	}
	// 조회
	function fn_modify(popSeq){
		$("#popSeq").val(popSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/popup/admPopupModify.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(popSeq){
		if(confirm("선택하신 팝업을 삭제하시겠습니까?")){
			$("#popSeq").val(popSeq);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/popup/admPopupDelete.do'/>").submit();
		}else{
			return false;
		}
	}
	
	// 팝업사용여부 수정
	function fn_modify_useYn(popSeq, popUseYn){
		$("#popSeq").val(popSeq);
		$("#popUseYn").val(popUseYn);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/popup/admPopupUseYnUpdate.do'/>").submit();
	}
	
	//팝업열기
	function fn_popupOpen(title,width,height,top,left,scrollYn,resizeYn,popSeq){
		url="<c:url value='/qxerpynm/siteMng/popup/admPopupOpen.do?popSeq="+popSeq+"'/>";
		 
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
	
</script>
</body>
</html>