<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	
	$(function(){
		$("input:checkbox[name=myClassChk]").click(function(){
			
			var type = ($("input:checkbox[name=myClassChk]").is(":checked"))? "INSERT":"DELETE";
			$.ajax({
				url: "<c:out value='${pageContext.request.contextPath }/usr/lec/myLecClassAjax.do'/>"
				, type: "post"
				, data: { 
							clsSeq : $("#searchClass").val()
							, type : type
						}
				, dataType:"json"
				, success: function(data){
					result = data.result;
					type = data.type;
					msg = (type == "INSERT")? "등록":"삭제";
					if(result == "1"){
						alert("정상적으로 "+msg+"되었습니다.");						
					}else{
						alert("강의실 지정 "+msg+" 중 오류가 발생하였습니다. 관리자에게 문의해주세요.");
					}
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		});
	});
	
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecSubjectList.do'/>").submit();
	}
	
	// 조회
	function fn_select(sbjtSeq){
		$("#searchSubject").val(sbjtSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHomeWorkList.do'/>").submit();
	}
	
	// 목록2
	function fn_list2(searchType){
		$("#searchCondition").val("");
		$("#searchWord").val("");
		if(searchType == "CLS_SBJT"){
			action = "<c:out value='${pageContext.request.contextPath }/usr/lec/lecSubjectList.do'/>";
		}else if(searchType == "CLS_NOTI"){
			action = "<c:out value='${pageContext.request.contextPath }/usr/lec/lecBoardList.do'/>";
		}
		$("#frm").attr("method", "post").attr("action", action).submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchClass" />
<form:hidden path="searchSubject" />
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
            	<jsp:param name="dept1" value="강의실"/>
            	<jsp:param name="dept2" value="${smtrClsInfo.smtrTitle }"/>
            </jsp:include>
			<div class="cont_box">
				<div class="g_box02 mb10">
					<c:out value="${smtrClsInfo.deptTitle }"/>&nbsp;|&nbsp;<c:out value="${smtrClsInfo.clsTitle }"/>&nbsp;<span>강의실</span>
				</div>
				<div class="mid_btn_r mb20">
					<c:if test="${!empty smtrClsInfo.clsLink }">
						<a href="https://learn.hansung.ac.kr/webapps/portal/execute/tabs/tabAction?tab_tab_group_id=_1_1" class="btn_bl" target="_blank">블랙보드 바로가기</a>
					</c:if>
				</div>
				<div class="tab li02 mb20">
					<ul>
						<li><a href="#" class="active" onclick="fn_list2('CLS_SBJT'); return false;">주제 출제</a></li>
						<li><a href="#" onclick="fn_list2('CLS_NOTI'); return false;">우리반 게시판</a></li>
					</ul>
				</div>
				<div class="sh_box">
					<div class="sh_l_box">
						게시물 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건
					</div>
					<div class="sh_r_box">
						<input type="checkbox" name="myClassChk" id="myClassChk" <c:if test="${smtrClsInfo.myClsYn eq 'Y' }">checked="checked"</c:if>/> <label for="myClassChk">나의 강의실로 지정하기</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<form:select path="searchCondition" class="w100">
							<form:option value="title">강의주제</form:option>
							<form:option value="content">내용</form:option>
						</form:select>
						<form:input path="searchWord" class="w200" />
						<a href="#" class="sh_btn" onclick="fn_list(1); return false;">검색</a>
					</div>
				</div>
				<table class="list_type01" summary="강의실 리스트">
					<caption>강의실</caption>
					<colgroup>
						<col width="10%" />
						<col width="60%" />
						<col width="15%" />
						<col width="15%" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>강의 주제</th>
							<th>시작일</th>
							<th>마감일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td class="ta_left">
									<a href="#" onclick="fn_select(<c:out value='${result.sbjtSeq }'/>); return false;">
										<c:out value="${result.sbjtTitle }"/>
										<c:if test="${result.sbjtViewYn eq 'N' }"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/user_lock.png'/>"/></c:if>
									</a>
								</td>
								<td><c:out value="${result.sbjtStartDate }"/></td>
								<td><c:out value="${result.sbjtEndDate }"/></td>
							</tr>
						</c:forEach>
					<%--
						<tr>
							<td>2</td>
							<td class="ta_left"><a href="#">토론 개요서 <img src="../img/user_lock.png" alt="" /></a></td>
							<td>2016-12-25</td>
							<td>2016-12-25</td>
						</tr>
				 	--%>
					</tbody>
				</table>
				<!-- 하단 영역 -->
				<div class="btm_area">
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image2" jsFunction="fn_list" />
						<form:hidden path="pageIndex" />
					</div>
				</div>
				<!-- 하단 영역 -->
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
</form:form>
<div style="visibility: hidden;">
	<iframe src="http://info.hansung.ac.kr/index_blackboard.jsp"></iframe>
</div>
</body>
</html>