<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script>
	// 상담 취소
	function fn_delete(aplySeq, aplyUsrType, aplyStatus){
		if(aplyStatus != 1){
			alert("선택하신 상담신청은 취소할 수 없습니다.");
			return false;
		}
		if(confirm("상담신청을 취소하시겠습니까?")){
			$("#aplySeq").val(aplySeq);
			$("#aplyUsrType").val(aplyUsrType);
			$("#aplyStatus").val(aplyStatus);
			
			$("#frm").attr("method","post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/cnslt/cnsltDeleteOne.do'/>").submit();
		}
	}

//파일 다운로드
	function fn_download(type, upSeq){
		location.href = "<c:url value='/cmmn/file/downloadFile.do?type="+type+"&fileId="+upSeq+"'/>";
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="aplySeq" name="aplySeq"/>
<input type="hidden" id="aplyUsrType" name="aplyUsrType"/>
<input type="hidden" id="aplyStatus" name="aplyStatus"/>
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
            	<jsp:param name="dept1" value="상담"/>
            	<jsp:param name="dept2" value="마이페이지"/>
            </jsp:include>
			<div class="cont_box">
				<table class="list_type01" summary="마이페이지 리스트">
					<caption>마이페이지</caption>
					<colgroup>
						<col width="5%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="9%" />
						<col  />
						<col  />
					</colgroup>	
					<thead>
						<tr>
							<th>번호</th>
							<th>구분</th>
							<th>강좌</th>
							<th>상담일</th>
							<th>처리</th>
							<th>비고</th>
							<th>신청일시</th>
							<th>원본</th> 
							<th>첨삭지도</th> 
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td>
									<c:if test="${result.aplyType eq '1' }">온라인</c:if>
									<c:if test="${result.aplyType eq '2' }">면대면</c:if>
								</td>
								<td class="ta_left">
									<c:out value="${result.aplyCourseName }"/>
								<%--
									<a href="#">
										<c:out value="${result.aplyCourseName }"/>
									</a>
								--%>
								</td>
								<td>
									<c:if test="${result.aplyType ne '1' }">
										<c:out value="${result.schYmd }"/>
									</c:if>
									<c:if test="${result.aplyType eq '1' }">
										<c:out value="${result.updtDate }"/>
									</c:if>
								</td>
								<td>
									<c:if test="${result.aplyStatus eq '1'}">신청완료</c:if>
									<c:if test="${result.aplyStatus eq '2'}">상담완료</c:if>
									<c:if test="${result.aplyStatus eq '3'}">불참</c:if>
									<c:if test="${result.aplyStatus eq '4'}">상담취소</c:if>
								</td>
								<td>
									<c:if test="${result.aplyStatus eq '1' }">
										<a href="#" class="btn_del" onclick="fn_delete(<c:out value='${result.aplySeq }'/>, '<c:out value='${result.aplyUsrType }'/>', <c:out value='${result.aplyStatus}'/>); return false;">취소</a>
									</c:if>
								</td>
								<td><c:out value="${result.regDate}"/></td>
								<td>        
									<c:forEach items="${cnsltUpfileList}" var="upfile" varStatus="status">
										<c:if test="${result.aplySeq eq upfile.aplySeq and upfile.upType eq 'CONS'}">
											<a href="#" onclick="fn_download('CONSULT', <c:out value='${upfile.upSeq }'/>); return false;"><c:out value="${upfile.upOriginFileName }"/></a><br />
										</c:if>
								    </c:forEach>
								</td>
								<td>        
									<c:forEach items="${cnsltUpfileList}" var="upfile" varStatus="status">
										<c:if test="${result.aplySeq eq upfile.aplySeq and upfile.upType eq 'ANSW'}">
											<a href="#" onclick="fn_download('CONSULT', <c:out value='${upfile.upSeq }'/>); return false;"><c:out value="${upfile.upOriginFileName }"/></a><br />
										</c:if>
								    </c:forEach>
								</td>
							</tr>
						</c:forEach>
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
<input type="hidden" id="message" name="message" value="${message }"/>
</form:form>
</body>
</html>