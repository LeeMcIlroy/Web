<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_save(){
		$("#payFee").val($("#payFee").val().replace(/,/g,''));
		$("#frm").attr("action","<c:url value='/qxsepmny/regist/admTuipayUpdate.do'/>").submit();
	}
	
	function fn_list(){
		$("#frm").attr("action","<c:url value='/qxsepmny/regist/admTuipayList.do'/>").submit();
	}
</script>
<body onload="fn_number(document.getElementById('payFee'));">
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="등록"/>
		            <jsp:param name="dept2" value="등록금납부"/>
	           	</jsp:include>
	           	<form:form commandName="regFeeVO" id="frm" name="frm">
	           	<!-- 검색조건 유지 -->
	           	<input type="hidden" id="searchCondition1" name="searchCondition1" value="<c:out value='${searchVO.searchCondition1 }'/>"/>
	           	<input type="hidden" id="searchCondition2" name="searchCondition2" value="<c:out value='${searchVO.searchCondition2 }'/>"/>
	           	<input type="hidden" id="searchCondition3" name="searchCondition3" value="<c:out value='${searchVO.searchCondition3 }'/>"/>
	           	<input type="hidden" id="searchCondition4" name="searchCondition4" value="<c:out value='${searchVO.searchCondition4 }'/>"/>
	           	<input type="hidden" id="searchWord" name="searchWord" value="<c:out value='${searchVO.searchWord }'/>"/>
	           	<input type="hidden" id="startDate" name="startDate" value="<c:out value='${searchVO.startDate }'/>"/>
	           	<input type="hidden" id="endDate" name="endDate" value="<c:out value='${searchVO.endDate }'/>"/>
	           	<!-- // 검색조건 유지 -->
	           	<form:hidden path="regSeq"/>
				<p class="sub-title">대상자 정보</p>
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
								<th>이름</th>
								<td colspan="3">
									<c:out value="${regFeeVO.enterName }"/>
								</td>
							</tr>
							<tr>
								<th>접수번호</th>
								<td>
									<c:out value="${regFeeVO.enterNum }"/> / <c:out value="${regFeeVO.enterType }"/>
								</td>
								<th>학번</th>
								<td>
									<c:out value="${regFeeVO.memberCode }"/>
								</td>
							</tr>
							<tr>
								<th>국적</th>
								<td>
									<c:out value="${regFeeVO.enterNation }"/>
								</td>
								<th>생년월일</th>
								<td>
									<c:out value="${regFeeVO.enterBirth }"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">등록금정보</p>
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
								<th>가상계좌번호</th>
								<td colspan="3">
									<c:out value="${regFeeVO.bankAccount }"/>
								</td>
							</tr>
							<tr>
								<th>납부시작학기</th>
								<td>
									<c:out value="${regFeeVO.regStYear }"/>년 <c:out value="${regFeeVO.regStSeme }"/>
								</td>
								<th>대상학기</th>
								<td>
									<c:out value="${regFeeVO.regRgSeme }"/>학기
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>등록금</th>
								<td>
									<fmt:formatNumber value="${regFeeVO.regFee }" pattern="#,###"/>원
								</td>
								<th>입학금</th>
								<td>
									<fmt:formatNumber value="${regFeeVO.enterFee }" pattern="#,###"/>원
								</td>
							</tr>
							<tr>
								<th>보험료</th>
								<td colspan="3">
									<fmt:formatNumber value="${regFeeVO.insuFee }" pattern="#,###"/>원
								</td>
							</tr>
							<tr>
								<th>고지일자</th>
								<td>
									<c:out value="${regFeeVO.regDate }"/>
								</td>
								<th>고지서발송일자</th>
								<td>
									<c:out value="${regFeeVO.regSeDate }"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">납부정보</p>
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
								<th><sup>*</sup>납부일자</th>
								<td colspan="3">
									<form:input path="payDate" id="datepicker01" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>납부금액</th>
								<td>
									<form:input path="payFee" class="input-data txt-r" onkeyup="fn_number(this);"/>
								</td>
								<th><span class="txt-red">미납금액</span></th>
								<td>
									<c:out value="${(regFeeVO.regFee+regFeeVO.enterFee+regFeeVO.insuFee)-regFeeVO.payFee }"/>원
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<a href="#" onclick="fn_list(); return false;" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
					</div>
				</div>
				</form:form>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <footer>
       <p>COPYRIGHT@2019 HANSUNG UNIVERSITY All Rights Reserved.</p>
    </footer>
	<!--// footer -->

</body>
</html>