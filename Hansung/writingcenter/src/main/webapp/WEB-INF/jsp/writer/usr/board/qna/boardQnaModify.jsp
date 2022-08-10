<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>
$(function(){
	$('#qstContent').on('keyup', function() {
        if($(this).val().length > 50) {
            $(this).val($(this).val().substring(0, 1300));
        }
		var content = $(this).val();
		$('#counter').html(content.length + '/1300');
	});
});

	//목록으로
	function fn_goList(){
		$("#frm").attr("method","post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaList.do'/>").submit();
	}
	//등록
	function fn_update(){
		if($("#qstTitle").val()=='' || $("#qstTitle").val()==null){
			alert("제목을 입력해주십시오");
			return false;
		}
		if($("#qstContent").val()=='' || $("#qstContent").val()==null){
			alert("내용을 입력해주십시오");
			return false;
		}
		
		if(confirm(($("#qnaSeq").val()==""? "등록":"수정") + "하시겠습니까?")){
			$("#frm").attr("method","post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaModify.do'/>").submit();
		}
	}
</script>
<body>
<form:form commandName="qnaVO" id="frm" name="frm">
<form:hidden path="qnaSeq" />
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
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
            	<jsp:param name="dept1" value="게시판"/>
            	<jsp:param name="dept2" value="Q&A"/>
            </jsp:include>
			<div class="cont_box">
				<div class="ta_caption">
						* 는 필수 입력항목입니다.
					</div>
				<table class="view_type01 mb20" summary="Q&amp;A 등록">
					<caption>Q&amp;A</caption>
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">* 제목</th>
							<td>
								<form:input path="qstTitle" style="width: 100%;" maxlength="150" />
							</td>
						</tr>
						<tr>
							<td colspan="2" style="padding:5px;">
								<form:textarea path="qstContent" cols="5" rows="5" style="width:100%; height:200px;" />
								<div id="counter" style="text-align: right;">0/1300</div>	
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 하단 영역 -->
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="btn_enter" onclick="fn_update(); return false;">등록</a>
							<a href="#" class="btn_list" onclick="fn_goList(); return false;">목록</a>
						</div>
					</div>
				</div>
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