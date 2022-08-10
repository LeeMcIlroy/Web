<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">
	
	$(function(){
		$("#tipDelChkAll").click(function(){
			if($(this).is(":checked")){
				$("input:checkbox[name=tipDeleteChk]").prop("checked", true);
			}else{
				$("input:checkbox[name=tipDeleteChk]").prop("checked", false);
			}
		});
	});
	
	// 등록&수정화면
	function fn_modify(tipSeq){
		$("#tipSeq").val(tipSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/tips/admWcGuideTipsModify.do'/>").submit();
	}	

	// 삭제
	function fn_delete(){
		if($("input:checkbox[name='tipDeleteChk']").is(":checked")==true){
			if(confirm("정말 삭제하시겠습니까?")){
				$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/tips/admWcGuideTipsDelete.do'/>").submit();
			}
		}else{
			alert("삭제할 게시글을 선택하세요");
			return false;
		}
	}
	
	/* pagination 페이지 링크 function */
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/wcGuide/tips/admWcGuideTipsList.do'/>").submit();
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="tipSeq" name="tipSeq"/>
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
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="글쓰기 길잡이"/>
            	<jsp:param name="dept2" value="라이팅팁스"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_modify(); return false;">글쓰기</a>
						</div>
					</div>
				</div>
				<table class="list_tbl_03 mt30" summary="라이팅팁스 목록">
					<caption>라이팅팁스</caption>
					<colgroup>
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:20%" />
						<col style="width:25%" />
						<col style="width:12%" />
						<col style="width:13%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col"><input type="checkbox" id="tipDelChkAll" /></th>
							<th scope="col">번호</th>
							<th scope="col">이미지</th>
							<th scope="col">주제/목차/발행일</th>
							<th scope="col">글쓴이</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>
								<td><input type="checkbox" id="tipDeleteChk" name="tipDeleteChk" value="${result.tipSeq }"/></td>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td>
									<a href="#" onclick="fn_modify(<c:out value='${result.tipSeq }'/>); return false;">
										<img src="<c:url value='/showImage.do?filePath=${result.tipImgThumbPath }'/>" style="width: 100%;"/>
									</a>
								</td>
								<td class="ta_left">
									<ul class="ta_ul01">
										<li>주제 :</li>
										<li><c:out value="${result.tipTitle }"/></li>
									</ul>
									<ul class="ta_ul01" style="height: 150px;">
										<li>내용 :</li>
										<li style="max-height: 150px;overflow-y: auto;"><c:out value="${result.tipContent }" escapeXml="false"/></li>
									</ul>
									<ul class="ta_ul01">
										<li>발행일 :</li>
										<li><c:out value="${result.tipPublicDate }"/></li>
									</ul>
								</td>
								<td><c:out value="${result.regName }"/></td>
								<td><c:out value="${result.regDate }"/></td>
								<td><c:out value="${result.tipHitcount }"/></td>
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
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
						<form:hidden path="pageIndex" />
					</div>

					<div class="tbl_top_side">
						<div class="side_c">
							<ul>
								<li>
									<form:select path="searchCondition" class="se_base">
										<form:option value="title">주제</form:option>
										<form:option value="content">내용</form:option>
									</form:select>
								</li>
								<li>
									<form:input path="searchWord" class="in_base w150" />
								</li>
								<li>
									<a href="#" class="btn_type05 input_btn" onclick="fn_list(1); return false;">검색</a>
								</li>
							</ul>
						</div>
						<div class="total">
							게시물 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건
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
<input type="hidden" id="message" name="message" value="${message }"/>
</form:form>
</body>
</html>