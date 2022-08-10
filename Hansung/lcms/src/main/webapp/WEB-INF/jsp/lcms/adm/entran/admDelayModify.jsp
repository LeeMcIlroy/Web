<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>
	function fn_update() {
		if(fn_validate("frm")){
			$("#frm").attr("action", "<c:url value='/qxsepmny/entran/admDelayUpdate.do'/>").submit();
		}
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="입학" />
					<jsp:param name="dept2" value="신입학" />
				</jsp:include>
				<form:form commandName="enterVO" id="frm" name="frm" enctype="multipart/form-data">
					<form:hidden path="enterSeq" />
					<p class="sub-title">접수 정보</p>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width: 150px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><sup>*</sup>학기</th>
									<td>
										<c:out value="${enterVO.enterYear }년"/>&nbsp;
										<c:if test="${enterVO.enterSeme eq '1' }">
											봄학기
										</c:if>
										<c:if test="${enterVO.enterSeme eq '2' }">
											여름학기
										</c:if>
										<c:if test="${enterVO.enterSeme eq '3' }">
											가을학기
										</c:if>
										<c:if test="${enterVO.enterSeme eq '4' }">
											겨울학기
										</c:if>
									</td>
								</tr>
								<tr>
									<th>접수번호</th>
									<td><c:out value="${enterVO.enterNum }" /></td>
								</tr>
								<tr>
									<th><sup>*</sup>접수일자</th>
									<td><c:out value="${enterVO.enterDate }"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<p class="sub-title">신청자정보</p>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width: 150px;" />
								<col />
								<col style="width: 150px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><sup>*</sup>이름</th>
									<td colspan="3">
										<c:out value="${enterVO.enterName }"/>
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>국적</th>
									<td colspan="3">
										<c:out value="${enterVO.enterNation }"/>
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>생년월일</th>
									<td>
										<c:out value="${enterVO.enterBirth }"/>
									</td>
									<th><sup>*</sup>학생구분</th>
									<td>
										<c:if test="${enterVO.enterStdType eq '1' }">교환학생</c:if>
										<c:if test="${enterVO.enterStdType eq '2' }">어학연수생</c:if>
										<c:if test="${enterVO.enterStdType eq '3' }">학부(유학생)</c:if>
										<c:if test="${enterVO.enterStdType eq '4' }">대학원(유학생)</c:if>
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>연락처</th>
									<td>
										<c:out value="${enterVO.enterTel }"/>
									</td>
									<th>이메일</th>
									<td>
										<c:out value="${enterVO.enterEmail }"/>
									</td>
								</tr>
								<tr>
									<th>첨부파일</th>
									<td colspan="3">
										<c:if test="${attachList != null }">
											<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attachList[0].attachSeq }&type=${attachList[0].boardType }'/>">
												<c:out value="${attachList[0].orgFileName }" />
											</a>
											<input type="hidden" id="deleteFile" name="deleteFile" value="<c:out value='${attachList[0].attachSeq }'/>" />
										</c:if>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
					<p class="sub-title <c:out value='${recoList != null?"":"dpn" }'/>">신청이력</p>
					<div class="list-table-box <c:out value='${recoList != null?"":"dpn" }'/>">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width: 150px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th></th>
									<td>
										<ul class="nomal-list">
											<c:forEach items="${recoList }" var="recode">
												<li>
													<c:out value="${recode.enterYear }" /><c:out value="${recode.enterSeme }" />-
													<c:out value="${recode.enterSemeNm }" /> 
													<c:out value="${recode.enterStatus }" /> / 
													<c:out value="${recode.enterEtc }" /></li>
											</c:forEach>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<p class="sub-title">입학연기</p>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width: 150px;" />
								<col />
								<col style="width: 150px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th>입학연기</th>
									<td>
										<form:checkbox path="delayYn" value="Y" disabled="true"/>&nbsp;(체크하면 입학연기로 처리됩니다.)
									</td>
									<th>연기신청일자</th>
									<td>
										<c:out value="${enterVO.delayDate }"/>
									</td>
								</tr>
								<tr>
									<th>입학연기</th>
									<td colspan="3">
										<c:out value="${enterVO.delayEtc }"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<p class="sub-title">입학처리</p>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width: 150px;" />
								<col />
								<col style="width: 150px;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th>입학학기</th>
									<td>
										<form:select path="delayEntrYear" onchange="fn_search_seme(this);" class="required select-one" title="입학연도">
											<form:options items="${yearList }"/>
										</form:select>
										<form:select path="delayEntrSeme" id="semEster" class="required select-one" title="입학학기">
											<c:forEach items="${semeList }" var="seme">
												<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
											</c:forEach>
										</form:select>
									</td>
									<th>입학일자</th>
									<td>
										<form:input path="delayEntrDate" id="datepicker01" placeholder="0000-00-00" class="required" title="입학일자"/>
									</td>
								</tr>
								<tr>
									<th>입학등급</th>
									<td colspan="3">
										<form:select path="delayEntrGrade" class="required select-one" title="입학등급">
											<c:forEach begin="1" end="6" var="grade">
												<form:option value="${grade }"><c:out value="${grade }급"/></form:option>
											</c:forEach>
										</form:select>
									</td>
								</tr>
								<c:if test="${registFee != null }">
									<tr>
										<th>등록금선납적용</th>
										<td colspan="3">
											<form:checkbox path="delayTuinYn" value="Y"/>&nbsp;(체크하면 아래 납부한 등록금이 입학학기의 선납등록금으로 처리 됩니다.)
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<c:if test="${registFee != null }">
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
											<c:out value="${registFee.bankAccount }"/>
										</td>
									</tr>
									<tr>
										<th>납부시작학기</th>
										<td>
											<c:out value="${registFee.regStYear }"/>년 <c:out value="${registFee.regStSeme }"/>
										</td>
										<th>대상학기</th>
										<td>
											<c:out value="${registFee.regRgSeme }"/>학기
										</td>
									</tr>
									<tr>
										<th><sup>*</sup>등록금</th>
										<td>
											<fmt:formatNumber value="${registFee.regFee }" pattern="#,###"/>원
										</td>
										<th>입학금</th>
										<td>
											<fmt:formatNumber value="${registFee.enterFee }" pattern="#,###"/>원
										</td>
									</tr>
									<tr>
										<th>보험료</th>
										<td colspan="3">
											<fmt:formatNumber value="${registFee.insuFee }" pattern="#,###"/>원
										</td>
									</tr>
									<tr>
										<th>고지일자</th>
										<td>
											<c:out value="${registFee.regDate }"/>
										</td>
										<th>고지서발송일자</th>
										<td>
											<c:out value="${registFee.regSeDate }"/>
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
											<c:out value="${registFee.payDate }"/>
										</td>
									</tr>
									<tr>
										<th><sup>*</sup>납부금액</th>
										<td>
											<fmt:formatNumber value="${registFee.payFee }" pattern="#,###"/>원
										</td>
										<th><span class="txt-red">미납금액</span></th>
										<td>
											<fmt:formatNumber value="${(regFeeVO.regFee+regFeeVO.enterFee+regFeeVO.insuFee)-regFeeVO.payFee }" pattern="#,###"/>원
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</c:if>
					<div class="table-button">
						<div class="btn-box">
							<button type="button" class="white btn-list" onclick="fn_list(); return false;">목록</button>
							<button type="button" class="white btn-save" onclick="fn_update(); return false;">저장</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
	<form:form commandName="searchVO" id="listFrm" name="listFrm">
		<form:hidden path="searchCondition1" />
		<form:hidden path="searchCondition2" />
		<form:hidden path="recordCountPerPage" />
	</form:form>
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
</body>
</html>