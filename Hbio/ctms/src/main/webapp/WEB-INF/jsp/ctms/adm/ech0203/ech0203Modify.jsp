<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_answ_add(){
		var html = '';
		var queItem = document.getElementsByClassName('que_item');
		var queLeng = queItem.length;
		
		if(queLeng < 6){
			html += '<div class="que_item">';
			html += '	<span>항목'+(queLeng+1)+'</span>';
			html += '	<input type="text" name="cr2040mVOList['+queLeng+'].answCon" id="answCon_'+queLeng+'" class="ta_l p70 required" />';
			html += '	<a href="#" class="btn_subtract" onclick="fn_answ_del('+queLeng+');">삭제</a>';
			html += '</div>';
			
			$("#answTd").append(html);
		}else{
			alert('항목은 최대 6개까지 추가하실 수 있습니다.');
		}
	}
	
	function fn_answ_del(answNum){
		var queItem = document.getElementsByClassName('que_item');
		var queLeng = queItem.length-1;
		
		for(var i=answNum; i<queLeng; i++){
			$("#answCon_"+i).val($("#answCon_"+(i+1)).val());
		}
		
		queItem[queLeng].remove();
	}
	
	function fn_list(){
		$("#searchFrm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0203/ech0203List.do'/>").submit();
	}
	
	function fn_update(){
		if(fn_validate('frm')){
			$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0203/ech0203Update.do'/>").submit();
		}
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>eCRF관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="질문답변관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="searchFrm" name="searchFrm" method="post">
				<form:hidden path="searchCondition1"/>
				<form:hidden path="searchCondition2"/>
				<form:hidden path="searchCondition3"/>
				<form:hidden path="startDate"/>
				<form:hidden path="endDate"/>
				<form:hidden path="searchType"/>
				<form:hidden path="searchWord"/>
			</form:form>
			<form:form commandName="cr2030mVO" id="frm" name="frm" method="post">
				<form:hidden path="quesNo"/>
	            <!-- 기본정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">질문/답변명</th>
							<td colspan="3">
								<form:input path="quesNm" class="ta_l type02 required" title="질문/답변명"/>
							</td>
						</tr>
						<tr>
							<th scope="row">유형</th>
							<td>
								<form:radiobutton path="quesType" id="answerType_01" value="S" class="select-one required" title="유형" />
							    <label for="answerType_01">단일응답</label>
							    <form:radiobutton path="quesType" id="answerType_02" value="M" class="select-one required" title="유형" />
							    <label for="answerType_02">복수응답</label>
							    <form:radiobutton path="quesType" id="answerType_03" value="F" class="select-one required" title="유형" />
							    <label for="answerType_03">자유기재형</label>
							</td>
							<th scope="row" class="bl">사용여부</th>
							<td>
								<form:radiobutton path="useYn" id="useY" value="Y" class="select-one required" title="사용여부"/>
							    <label for="useY">사용</label>
							    <form:radiobutton path="useYn" id="useN" value="N" class="select-one required" title="사용여부"/>
							    <label for="useN">미사용</label>
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 서브타이틀 -->
				<div class="sub_title_area">
					<h4>질문/답변</h4>
				</div>
				<!-- //서브타이틀 -->
	            <!-- 기본정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:85%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><i>*</i>질문</th>
							<td>
								<form:input path="quesCon" class="p65 ta_l required" title="질문"/>
								<form:input path="quesAbb" class="p30 ta_l required" placeholder="약어" title="질문(약어)"/>
							</td>
						</tr>
						<tr>
							<th scope="row"><i>*</i>답변</th>
							<td id="answTd">
								<c:choose>
									<c:when test="${cr2040List != null && cr2040List.size() != 0 }">
										<c:forEach items="${cr2040List }" var="cr2040m" varStatus="status">
											<div class="que_item">
												<span>항목1</span>
												<form:input path="cr2040mVOList[${status.index }].answCon" id="answCon_${status.index }" value="${cr2040m.answCon }" class="ta_l p70 required" title="답변 항목"/>
												<c:choose>
													<c:when test="${status.first }">
														<a href="#" class="btn_add" onclick="fn_answ_add();">추가</a>
													</c:when>
													<c:otherwise>
														<a href="#" class="btn_subtract" onclick="fn_answ_del(<c:out value='${status.index }'/>);">삭제</a>
													</c:otherwise>
												</c:choose>
											</div>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<div class="que_item">
											<span>항목1</span>
											<form:input path="cr2040mVOList[0].answCon" id="answCon_0" class="ta_l p70 required" title="답변 항목"/>
											<a href="#" class="btn_add" onclick="fn_answ_add();">추가</a>
										</div>
										
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 버튼 -->
				<div class="btn_area">
					<a href="#" class="type02" onclick="fn_list();">취소</a>
					<a href="#" onclick="fn_update();">저장</a>
				</div>
				<!-- //버튼 -->
			</form:form>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>