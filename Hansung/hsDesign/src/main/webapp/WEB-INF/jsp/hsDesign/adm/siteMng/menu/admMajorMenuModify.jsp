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
				<h3>전공메뉴관리</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 사이트관리 &gt; 전공메뉴관리 &nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
			<div class="cont_box">
			<!-- content -->
			<div class="tbl_top_area2 mt30">
				<div class="btn_r">
					* 는 필수 입력항목입니다.
				</div>
			</div>
			<form:form commandName="menuVO" id="frm" name="frm">
			<form:hidden path="mmSeq"/>
			<form:hidden path="bcHead"/>
				<!-- table -->
				<table class="view_tbl_03 mb30" summary="전공메뉴관리">
					<caption>전공메뉴관리</caption>
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">*전공</th>
							<td>
								<form:select path="mCode" class="se_base w160">
									<form:option value="">전체</form:option>
									<c:forEach items="${majorList}" var="major">
										<form:option value="${major.mCode}"><c:out value="${major.mName}"/></form:option>
									</c:forEach>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">*사용여부</th>
							<td>
								<form:select path="mmUseYn" class="se_base w100">
									<form:option value="Y">사용</form:option>
									<form:option value="N">미사용</form:option>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">표출순서</th>
							<td>
								<form:input path="mmSortNum" class="in_base" style="width:80%;"/>
							</td>
						</tr>
						<tr>
							<th scope="row">게시판이름</th>
							<td>
								<table>
									<c:forEach items="${boardList}" var="board" varStatus="status">
										<c:if test="${status.count%4 == 1 }"><tr></c:if>
											<td><form:radiobutton path="bcSeq" value="${board.bcSeq }" label="${board.bcName }"/></td>
										<c:if test="${status.count%4 == 0 || status.last}"></tr></c:if>
									</c:forEach>
								</table>
							</td>
						</tr>
						<tr>
							<th scope="row">말머리</th>
							<td>
								<table>
									<c:forEach items="${headerList}" var="result" varStatus="status">
										<c:if test="${status.count%4 == 1 }"><tr></c:if>
											<td><input type="checkbox" value="<c:out value='${result.bcSeq }'/>" id="<c:out value='${result.bcSeq }'/>" name="bcHeaderList" /> <c:out value="${result.bcName }"/></td>
										<c:if test="${status.count%4 == 0 || status.last }"></tr></c:if>
									</c:forEach>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#" onclick="fn_save(); return false;" class="b_type04">저장</a>
						<a href="#" onclick="fn_list(); return false;" class="b_type03">목록</a>
					</div>
				</div>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex }'/>"/>
				<input type="hidden" name="searchCondition1" value="<c:out value='${searchVO.searchCondition1 }'/>"/>
				<input type="hidden" name="searchType" value="<c:out value='${searchVO.searchType }'/>"/>
				<input type="hidden" name="searchWord" value="<c:out value='${searchVO.searchWord }'/>"/>
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
	$(function(){
		var headArray = $("#bcHead").val().split(",");
		
		for(i=0; i<headArray.length; i++){
			$("#"+headArray[i]).attr("checked", true);
		}
	});
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/menu/admMajorMenuList.do'/>").submit();
	}
	
	// 등록&수정
	function fn_save(){
		var selectHead ="";
		var flag = false;
		$("input:checkbox[name='bcHeaderList']:checked").each(function() {
			selectHead += $(this).val() + ",";
			flag = true;
		});
		
		if($("#mCode option:selected").val() == ''){
			alert("전공을 선택해주세요.");
			return false;
		}
		
		if(flag){
			$("#bcHead").val(selectHead.substring(0, selectHead.length-1));
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/menu/admMajorMenuUpdate.do'/>").submit();
		}else{
			alert("말머리는 하나이상 선택해야 합니다.");
			return false;
		}
		
	}

</script>
</body>
</html>