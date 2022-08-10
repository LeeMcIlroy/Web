<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	var resultList;
	
	function fn_search(){
		$.ajax({
			url: "<c:url value='/qxsepmny/cmm/admAjaxSearchStd.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '	<td>'+resultList[i].name+'</td>';
					html += '	<td>'+resultList[i].memberCode+'</td>';
					html += '	<td>'+resultList[i].eName+'</td>';
					html += '	<td>'+resultList[i].status+'</td>';
					html += '	<td>'+resultList[i].step+'급</td>';
					html += '	<td>'+resultList[i].nation+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="6">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_select(i){
		var result = resultList[i];
		
		$("#nameTd").html(result.name);
		$("#name").val(result.name);
		$("#code").html(result.memberCode);
		$("#memberCode").val(result.memberCode);
		$("#eName").html(result.eName);
		$("#status").html(result.status);
		$("#step").html(result.step+'급');
		$("#nation").html(result.nation);
		$("#mName").html(result.name);
		$("#mCode").html(result.memberCode);
		$("#mEName").html(result.eName);
		$("#mStatus").html(result.status);
		$("#mStep").html(result.step+'급');
		$("#mNation").html(result.nation);
		
		$("#modi-pop").click();
		
		resultList = null;
	}
	
	function fn_save(){
		$("#scholarship").val($("#scholarship").val().replace(/,/g,''));
		$("#frm").attr("action", "<c:url value='/qxsepmny/admstr/admScholarSubmit.do'/>").submit();
	}
</script>
<body onload="fn_number(document.getElementById('scholarship'));">
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="장학/수상"/>
	           	</jsp:include>
	           	<form:form commandName="scholarVO" id="frm" name="frm">
	           	<form:hidden path="scholarSeq"/>
	           	<form:hidden path="memberCode"/>
	           	<c:if test="${scholarVO.scholarSeq eq '' }">
					<p class="sub-title">학생 찾기</p>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:10%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><sup>*</sup>이름</th>
									<td>
										<input type="text" class="input-data w173px" id="name" placeholder="" />
										<label class="normal-btn" for="modi-pop">학생찾기</label>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</c:if>
				<!--// table -->

				<p class="sub-title">학생 정보</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col style="width:20%;"/>
							<col style="width:13%;" />
							<col style="width:20%;"/>
							<col style="width:14%;" />
							<col style="width:20%;"/>
						</colgroup>
						<tbody>
							<tr>
								<th>이름</th>
								<td id="nameTd">
									<c:out value="${scholarVO.name }"/>
								</td>
								<th>학번</th>
								<td id="code">
									<c:out value="${scholarVO.memberCode }"/>
								</td>
								<th>영문명</th>
								<td id="eName">
									<c:out value="${scholarVO.eName }"/>
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td id="status">
									<c:out value="${scholarVO.status }"/>
								</td>
								<th>급수</th>
								<td id="step">
									<c:out value="${scholarVO.step }급"/>
								</td>
								<th>국적</th>
								<td id="nation">
									<c:out value="${scholarVO.nation }"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<p class="sub-title">선정 정보</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col />
							<col style="width:13%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>대상학기</th>
								<td>
									<form:select path="year" onchange="fn_search_seme(this);">
										<form:options items="${yearList }"/>
									</form:select>
									<form:select path="semester" id="semEster">
										<c:forEach items="${semeList }" var="seme">
											<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
										</c:forEach>
									</form:select>
								</td>
								<th><sup>*</sup>장학/수상 구분</th>
								<td>
									<form:select path="scholarType">
										<form:option value="">선택</form:option>
										<form:option value="1">성실상</form:option>
										<form:option value="2">우수상</form:option>
										<form:option value="3">봉사상</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>선정일자</th>
								<td>
									<form:input path="scholarDate" id="datepicker01" readonly="true"/>
								</td>
								<th>장학금(원)</th>
								<td>
									<form:input path="scholarship" onKeyup="fn_number(this);" class="txt-r"/>
								</td>
							</tr>
							<tr>
								<th>비고</th>
								<td colspan="3">
									<form:input path="scholarEtc" class="w100p"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admScholarList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
					</div>
				</div>
				</form:form>
			</div>
		</div>
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup">
			<p class="sub-title">학생 찾기</p>
			<div class="search-box none-option">
				<input type="checkbox" id="search-option-open" />
				<div class="search">
					<div class="search-input">
						<table class="shearch-option">
							<colgroup>
								<col style="width:8%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<input type="text" class="input-data" placeholder="학번,이름을 입력하세요" id="searchWord" />
									</td>
								</tr>
							</tbody>
						</table>
						<a href="#" onclick="fn_search(); return false;">검색하기</a>
					</div>
				</div>
			</div>
			<div class="list-table-box">
				<table class="normal-list-table">
					<colgroup>
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>이름</th>
							<th>학번</th>
							<th>영문명</th>
							<th>상태</th>
							<th>급수</th>
							<th>국적</th>
						</tr>
					</thead>
					<tbody id="stdBody">
						<tr>
							<td colspan="6">학번 또는 이름을 검색해주세요.</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="table-button">
				<div class="btn-box">
					<label for="modi-pop" class="white btn-cancel">취소</label>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>