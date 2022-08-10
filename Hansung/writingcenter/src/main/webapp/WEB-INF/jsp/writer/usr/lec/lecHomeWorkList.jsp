<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "fn"  uri = "http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">

	// 검색
	function fn_list(pageNo){
		$("#pageIndex2").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHomeWorkList.do'/>").submit();
	}
	
	// 목록2
	function fn_list2(){
		$("#pageIndex").val(1);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecSubjectList.do'/>").submit();
	}
	
	// 조회
	function fn_select(hmwkSeq, regId, hmwkHakbuns){

		if($("#sbjtViewYn").val()=='N'){
			memCode = "<c:out value='${sessionScope.userSession.memCode }'/>";
			if(regId != memCode){
				
				var isAuth = false;
				
				if(hmwkHakbuns && hmwkHakbuns.indexOf(memCode) >= 0) {
					isAuth = true;
				}
				
				if(!isAuth) {
					alert("작성자만 조회가능 합니다.");
					return false;
				}
				
			}
		}
		$("#hmwkSeq").val(hmwkSeq);
		$("#hmwkRegId").val(regId);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHomeWorkView.do'/>").submit();
	}
	
	// 등록화면
	function fn_modify(hmwkSeq){
		$("#hmwkSeq").val(hmwkSeq);
		var today = new Date();
		var startDate = new Date("<c:out value='${subjectVO.sbjtStartDate}'/> <c:out value='${subjectVO.sbjtStartTime}'/>");
		var endDate = new Date("<c:out value='${subjectVO.sbjtEndDate}'/> <c:out value='${subjectVO.sbjtEndTime}'/>");
		
		if(today < startDate || today > endDate){
			alert("제출기간이 아닙니다.");
			return false;
		}
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/lec/lecHomeWorkModify.do'/>").submit();
	}
	
	// 파일 다운로드
	function fn_download(type, upSeq){
		location.href = "<c:out value='${pageContext.request.contextPath }/cmmn/file/downloadFile.do'/>?type="+type+"&fileId="+upSeq;
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchClass" />
<form:hidden path="searchSubject" />
<input type="hidden" id="hmwkSeq" name="hmwkSeq"/>
<input type="hidden" id="hmwkRegId" name="hmwkRegId"/>
<input type="hidden" id="sbjtViewYn" name="sbjtViewYn" value="${subjectVO.sbjtViewYn }"/>
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
				<dl class="view_dl">
					<dt><c:out value="${subjectVO.sbjtTitle}"/></dt>
					<dd class="font12">
						제출기간 : 
						<c:out value="${subjectVO.sbjtStartDate}"/>&nbsp;<c:out value="${subjectVO.sbjtStartTime }"/>
						&nbsp;~&nbsp;
						<c:out value="${subjectVO.sbjtEndDate}"/>&nbsp;<c:out value="${subjectVO.sbjtEndTime }"/>
						&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
						등록일 : <c:out value="${subjectVO.regDate}"/>
					</dd>
					<dd class="view_dl_cont"><c:out value="${subjectVO.sbjtContent }" escapeXml="false"/></dd>
					<dd class="font12">
						첨부파일 :
						<c:forEach items="${sbjtUpfileList }" var="sbjtUpfile" varStatus="status">
							<a href="#" onclick="fn_download('SUBJECT', <c:out value='${sbjtUpfile.upSeq }'/>); return false;">
								<c:out value="${sbjtUpfile.upOriginFileName }"/>
							</a>
							<c:if test="${status.last == false}">
								&nbsp;|&nbsp;
							</c:if>
						</c:forEach>
					</dd>
				</dl>
				<div class="sh_box">
					<div class="sh_l_box">
						게시물 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건
					</div>
					<div class="sh_r_box">
						<form:select path="searchCondition2" class="w100">
							<form:option value="hmwkNames">작성자</form:option>
						</form:select>
						<form:input path="searchWord2" class="w200" />
						<a href="#" class="sh_btn" onclick="fn_list(1); return false;">검색</a>
					</div>
				</div>
				<table class="list_type01 mt30" summary="강의실 목록">
					<caption>강의실</caption>
					<colgroup>
						<col style="width:10%" />
						<col style="width:50%" />
						<col style="width:18%" />
						<col style="width:22%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">작성자</th>
							<th scope="col">제출일자</th>
							<th scope="col">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex2-1) * 10 + status.count)}"/></td>
								<td class="ta_left">
									<a href="#" class="comt" onclick="<c:if test='${result.hmwkStatus ne 4 }'>fn_select(<c:out value='${result.hmwkSeq }'/>,'<c:out value='${result.hmwkRegId }'/>','<c:out value="${result.hmwkHakbuns }"/>');</c:if><c:if test='${result.hmwkStatus eq 4 }'>alert('첨삭진행중입니다.');</c:if> return false;">
										<c:choose>
											<c:when test="${!empty result.hmwkNames && !empty result.hmwkHakbuns && !empty result.hmwkDepts }">
												<c:out value="${result.hmwkDepts }"/>/<c:out value="${result.hmwkHakbuns }"/>/<c:out value="${result.hmwkNames }"/>
											</c:when>
											<c:otherwise>
												<c:out value="${result.hmwkRegDept }"/>/<c:out value="${result.hmwkRegId }"/>/<c:out value="${result.hmwkRegName }"/>
											</c:otherwise>
										</c:choose>
										<c:if test="${result.cmmtCnt > 0}">
											<span>(<c:out value="${result.cmmtCnt }"/>)</span>
										</c:if>
									</a>
								</td>
								<td><c:out value="${result.hmwkRegDate }"/></td>
								<td class="ta_left">
									<c:if test="${result.hmwkStatus eq 1 }">
										<a href="#" class="ta_s_btn03">제출</a>
									</c:if>
									<c:if test="${result.hmwkStatus eq 2 }">
										<a href="#" class="ta_s_btn01">첨삭완료</a>
									</c:if>
									<c:if test="${result.hmwkStatus eq 3 }">
										<a href="#" class="ta_s_btn01">첨삭완료</a>
										<a href="#" class="ta_s_btn02">첨삭확인완료</a>
									</c:if>
									<c:if test="${result.hmwkStatus eq 4 }">
										<a href="#" class="ta_s_btn01">첨삭진행중</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					<%--
						<tr>
							<td>10</td>
							<td class="ta_left"><a href="#" class="comt">응용인문학부 국어국문전공/1611***/최**<span>(3)</span></a></td>
							<td>2016-10-04 14:20</td>
							<td class="ta_left">
								<a href="#" class="ta_s_btn01">첨삭완료</a>
								<a href="#" class="ta_s_btn02">첨삭확인완료</a>
								<a href="#" class="ta_s_btn03">제출</a>
							</td>
						</tr>
				 	--%>
					</tbody>
				</table>
				<!-- 하단 영역 -->
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="btn_write" onclick="fn_modify(); return false;">글쓰기</a>
							<a href="#" class="btn_list" onclick="fn_list2(); return false;">목록</a>
						</div>
					</div>
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image2" jsFunction="fn_list" />
						<form:hidden path="pageIndex2" />
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
<input type="hidden" id="message" name="message" value="${message }"/>
<!-- 목록페이지 조건 -->
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>