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

	$(function(){
		$("#modi-pop").change(function(){
			if(!($("#modi-pop").is(":checked"))){
				resultList = null;
				$("#stdBody").html('<tr><td colspan="3">학번 또는 이름을 검색해주세요.</td></tr>');
			}
		});
	});

	function fn_search(type){
		$("#searchType").val(type);
		
		$.ajax({
			url: "<c:url value='/qxsepmny/regist/admAjaxSearchStdList.do'/>"
			, type: "post"
			, data: $("#searchFrm").serialize()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '	<td>'+resultList[i].enterNum+'</td>';
					html += '	<td>'+resultList[i].memberCode+'</td>';
					html += '	<td>'+resultList[i].enterName+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="3">검색된 내용이 없습니다.</td>';
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
		
		$("#semester").html(result.enterYear + ' ' + result.enterSemeNm);
		$("#name").val(result.enterName);
		$("#entNum").html(result.enterNum + ' / ' + result.enterType);
		$("#code").html(result.memberCode);
		$("#enterNum").val(result.enterNum);
		$("#nation").html(result.enterNation);
		$("#birth").html(result.enterBirth);
		$("#account").val(result.bankAccount);
		
		$("#modi-pop").click();
	}
	
	function fn_save(){
		$("#refFee").val($("#refFee").val().replace(/,/g,''));
		$("#frm").attr("action","<c:url value='/qxsepmny/regist/admRefUpdate.do'/>").submit();
	}
</script>
<body onload="fn_number(document.getElementById('refFee'))">
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="등록"/>
		            <jsp:param name="dept2" value="환불"/>
	           	</jsp:include>
				<p class="sub-title">접수 정보</p>
				<form:form commandName="refFeeVO" id="frm" name="frm">
				<form:hidden path="refSeq"/>
				<form:hidden path="enterNum"/>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:150px;" />
							<col />
							<col style="width:150px;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>접수학기</th>
								<td colspan="3" id="semester"><c:out value="${refFeeVO.enterYear }"/> <c:out value="${refFeeVO.enterSeme }"/></td>
							</tr>
							<tr>
								<th><sup>*</sup>이름</th>
								<td colspan="3">
									<c:if test="${refFeeVO.refSeq eq '' || refFeeVO.refSeq == null }">
										<input type="text" class="input-data" placeholder="" id="name" readonly="readonly" />
										<a href="" class="normal-btn">학생찾기</a>&nbsp;&nbsp;&nbsp;
										<label class="normal-btn" for="modi-pop">신청자찾기</label>
									</c:if>
									<c:if test="${refFeeVO.refSeq ne '' && refFeeVO.refSeq != null }">
										<c:out value="${refFeeVO.enterName }"/>
									</c:if>
								</td>
							</tr>
							<tr>
								<th>접수번호</th>
								<td id="entNum"><c:out value="${refFeeVO.enterNum }"/> / <c:out value="${refFeeVO.enterType }"/></td>
								<th>학번</th>
								<td id="code"><c:out value="${refFeeVO.enterCode }"/></td>
							</tr>
							<tr>
								<th>국적</th>
								<td id="nation"><c:out value="${refFeeVO.enterNation }"/></td>
								<th>생년월일</th>
								<td id="birth"><c:out value="${refFeeVO.enterBirth }"/></td>
							</tr>
							<tr>
								<th><sup>*</sup>환불일자</th>
								<td colspan="3">
									<form:input path="refDate" id="datepicker01" placeholder="0000-00-00"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">환불정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:150px;" />
							<col />
							<col style="width:150px;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>환불계좌번호</th>
								<td>
									<form:input path="refAccount" class="input-data w100p" />
								</td>
								<th><sup>*</sup>사유</th>
								<td>
									<form:select path="refType">
										<form:option value="1">자퇴</form:option>
										<form:option value="2">장학</form:option>
										<form:option value="3">미등록</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>환불금액</th>
								<td>
									<form:input path="refFee" class="input-data w100p txt-r" onkeyup="fn_number(this);"/>
								</td>
								<th>비고</th>
								<td>
									<form:input path="refEtc" class="input-data w100p" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/regist/admRefList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
					</div>
				</div>
				</form:form>
			</div>
		</div>
		<!-- 팝업 -->
		<form:form commandName="searchVO" id="searchFrm" name="searchFrm">
			<form:hidden path="searchType"/>
			<input type="checkbox" id="modi-pop" class="hidden" />
			<div class="black-pop">&nbsp;</div>
			<div class="modi-popup">
				<p class="sub-title">신청자찾기</p>
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
											<form:input path="searchWord" class="input-data" placeholder="학번,이름을 입력하세요" />
										</td>
									</tr>
								</tbody>
							</table>
							<a href="#" onclick="fn_search('ENTR'); return false;">검색하기</a>
						</div>
					</div>
				</div>
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:150px;" />
							<col style="width:150px;" />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>접수번호</th>
								<th>학번</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody id="stdBody">
							<tr>
								<td colspan="3">학번 또는 이름을 검색해주세요.</td>
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
		</form:form>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->

</body>
</html>