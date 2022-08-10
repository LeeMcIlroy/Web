<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>

<script>
	function closeLayer( obj ) {
		$(obj).parent().parent().hide();
	}

	$(function(){

		/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
		$('.imgSelect').click(function(e)
		{
			var sWidth = window.innerWidth;
			var sHeight = window.innerHeight;

			var oWidth = $('.popupLayer').width();
			var oHeight = $('.popupLayer').height();

			// 레이어가 나타날 위치를 셋팅한다.
			var divLeft = e.clientX + 10;
			var divTop = e.clientY + 5;

			// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
			if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
			if( divTop + oHeight > sHeight ) divTop -= oHeight;

			// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
			if( divLeft < 0 ) divLeft = 0;
			if( divTop < 0 ) divTop = 0;

			$('.popupLayer').css({
				"top": divTop,
				"left": divLeft,
				"position": "absolute"
			}).show();
		});

	});
	
	function fn_modify(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admConsulModify.do'/>").submit();
	}
	
	function fn_pop(memberCode){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admConsulPop.do'/>?memberCode="+memberCode, '상담이력', 'width=1050, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_del(){
// 		var seq = $("#consultSeq").val();
		if(confirm('삭제 하시겠습니까?')){
			$("#frm").attr("action", "<c:url value='/qxsepmny/clss/admConsulDelete.do'/>").submit();
		}
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<!--// left menu -->
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="수업"/>
		            <jsp:param name="dept2" value="상담"/>
	           	</jsp:include>
				<form:form commandName="consultVO" id="frm" name="frm">
				<form:hidden path="consultSeq"/>
				<p class="sub-title">진행 정보</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>상담일자</th>
								<td>
									<c:out value="${consultVO.consultDate }"/>
								</td>
								<th>상담자</th>
								<td>
									<c:out value="${consultVO.profCode }"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<p class="sub-title">학생 정보</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>이름</th>
								<td>
									<c:out value="${consultVO.name }"/>
								</td>
								<th>학번</th>
								<td>
									<c:out value="${consultVO.memberCode }"/>
								</td>
								<th>영문명</th>
								<td>
									<c:out value="${consultVO.eName }"/>
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>
									<c:out value="${consultVO.status }"/>
								</td>
								<th>급수</th>
								<td>
									<c:out value="${consultVO.step }"/>급
								</td>
								<th>국적</th>
								<td>
									<c:out value="${consultVO.nation }"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mt10 txt-r mb20" style="margin-top:-10px;">
					<a href="#" class="underline" onclick="fn_pop('<c:out value="${consultVO.memberCode }"/>'); return false;">상담이력 보기</a>
				</div>
				<p class="sub-title">상담내용</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>상담구분</th>
								<td>
									<c:out value="${consultVO.consultType }"/>
								</td>
							</tr>
							<tr>
								<th>상담장소</th>
								<td>
									<c:out value="${consultVO.place }"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>상담내용</th>
								<td>
									<c:out value="${consultVO.content }" escapeXml="false"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<p class="sub-title">첨부파일</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>첨부파일</th>
								<td>
									<c:forEach items="${attachList }" var="attach">
										<p class="file-upload">
											<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>">
												<c:out value="${attach.orgFileName }"/>
											</a>
										</p>
									</c:forEach>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" onclick="fn_del(); return false;" class="white btn-del">삭제</button>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/clss/admConsulList.do'/>" class="white btn-list">목록</a>
						<c:if test="${consultVO.regType == '1' }">
							<button type="button" class="white btn-newwrite" onclick="fn_modify(); return false;">수정</button>
						</c:if>
					</div>
				</div>
				<!--// table button -->
				</form:form>
			</div>
		</div>

	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->

</body>
</html>