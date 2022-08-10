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

// 목록으로
function fn_list(){
	$("#detailform").attr("action", "<c:url value='/qxsepmny/admstr/admDormList.do'/>").submit();
}

// 게시글 상세보기 등록
function fn_save(memCode){
	$('#memCode').val(memCode);
	$("#payment").val($("#payment").val().replace(/,/g,''));
	 $("#detailform").attr("action", "<c:url value='/qxsepmny/admstr/admDormRegist.do'/>").submit();
}

//파일 다운로드
function fn_filedownload(attachSeq, boardType){
	location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
}

</script>
<body onload="fn_number(document.getElementById('payment'));">
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="기숙사"/>
	           	</jsp:include>
               
        <form:form commandName="DormVO" id="detailform"	 name="detailform" enctype="multipart/form-data">
               
        <input type="hidden" name="menuType" id="menuType" value="dormUpdate">
        <input type="hidden" name="dormSeq" id="dormSeq" value="<c:out value="${result.dormSeq }" />">       
<!-- ************************	학생 정보 TABLE			************************ -->
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
								<td>
									<c:out value="${result.name }" />
								</td>
								<th>학번</th>
								<td>
									<c:out value="${result.memberCode }" />
									<input type="hidden" name="memCode" id="memCode" />
								</td>
								<th>영문명</th>
								<td>
									<c:out value="${result.eName }" />
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>
								<c:out value="${result.status }" />
								</td>
								<th>급수</th>
								<td>
									<c:out value="${result.step }" />
								</td>
								<th>국적</th>
								<td>
				                   <c:out value="${result.nation }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				

<!-- ************************	현재 거주 기숙사 TABLE (재입사인경우)************************ -->				
					<c:if test="${result.dormNow ne null}">
					<p class="sub-title">현재 거주 기숙사</p>
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
								<th>기숙사명</th>
								<td>
									<c:out value="${result.dormNow }" />
								</td>
								<th>인실</th>
								<td>
									<c:out value="${result.perroomNow }" />
								</td>
								<th>최초입사일자</th>
								<td>
									<c:out value="${result.joinMinDate }" />
								</td>
							</tr>
                       </tbody>
                    </table>
                    </div>
                    </c:if>
 <!-- ************************	신청 기숙사 TABLE			************************ -->	                   
          <p class="sub-title">신청 기숙사</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col style="width:13%;" />
							<col style="width:20%;"/>
							<col style="width:13%;" />
							<col style="width:20%;"/>
						</colgroup>
						<tbody>
							<tr>
						<th>신청학기</th>
						<td  colspan="3" style="text-align: center;"> 
						<c:out value="${result.semYear }" />년&nbsp <c:out value="${result.semEster }" /> 
						</td>
						</tr>
						<tr>
						<th>거주기간</th>
						
						<fmt:parseDate value="${result.resiStartdate }" var="resiStartdate" pattern="yyyy.MM.dd"/>
                        <fmt:parseDate value="${result.resiEnddate }" var="resiEnddate" pattern="yyyy.MM.dd"/>
                        
                        <fmt:parseNumber value="${resiStartdate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
                        <fmt:parseNumber value="${resiEnddate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
						
						<td colspan="2"><c:out value="${result.resiStartdate }" /> – <c:out value="${result.resiEnddate }" /> (  ${endDate - strDate }일간)</td>
						
						<th>신청구분</th>
						<td><c:if test="${result.renewGubun eq '1'}">신입사</c:if>
								<c:if test="${result.renewGubun eq '2'}">재입사</c:if>
								</td>
						</tr>
						
							<tr>
								<th>기숙사</th>
								<th>1순위</th>
								<td>
									<c:out value="${result.dormFirst }" />
								</td>
								<th>2순위</th>
								<td>
								<c:out value="${result.dormSecond }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				
<!-- ************************ 첨부파일 TABLE			************************ -->
               <c:if test="${attachList ne null && !empty attachList}">
                <p class="sub-title">첨부파일</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col />
						</colgroup>
						<tbody>
						<c:forEach var="attachFile" items="${attachList}">
		                        <tr>
								<th>첨부파일</th>
								<td>
								<a href="#" onclick="fn_filedownload(<c:out value='${attachFile.attachSeq }'/>, 'DORM'); return false;">
									<c:out value='${attachList != null?attachFile.orgFileName:"파일선택" }'/>
									</a>
									<!-- 히든 값 두개 -->
									<!-- <input type="file" class="hidden" id="upload_file" name="upload_file"/>
									<input type="hidden" id="deleteFile" name="deleteFile"/> -->
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				</c:if>
				<!--// table -->

<!-- ************************ 기숙사 배정 TABLE			************************ -->

                <p class="sub-title">기숙사 배정</p>
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
								<th><sup>*</sup>기숙사</th>
								<td>
									<select name="dormNow">
									<option value="1" <c:if test="${result.dormNow eq 'Global Village 1'}">selected</c:if>>Global Village 1</option>
									<option value="2" <c:if test="${result.dormNow eq 'Global Village 2'}">selected</c:if>>Global Village 2</option>
									<option value="3" <c:if test="${result.dormNow eq 'APT'}">selected</c:if>>APT</option>
									</select>
								</td>
								<th><sup>*</sup>인실</th>
								<td>
									<select name="perroomNow">
									<option  value="1" <c:if test="${result.perroomNow eq '2인실'}">selected</c:if>>2인실</option>
									<option  value="2" <c:if test="${result.perroomNow eq '3인실'}">selected</c:if>>3인실</option>
									<option  value="3" <c:if test="${result.perroomNow eq '4인실'}">selected</c:if>>4인실</option>
									</select>
								</td>
								<th><sup>*</sup>호실</th>
								<td>
									<input type="text" name="roomNum" id="roomNum" value="<c:out value="${result.roomNum }" />" >
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>입사일자</th>
								<td>
									<input type="text" name="joinDate" id="datepicker09" placeholder="0000-00-00" readonly="readonly" value="<c:out value="${result.joinDate }" />">
								</td>
								<th><sup>*</sup>퇴사일자</th>
								<td colspan="2">
									<input type="text" name="resignDate" id="datepicker10" placeholder="0000-00-00" readonly="readonly" value="<c:out value="${result.resignDate }" />">
								</td>
								
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				
<!-- ************************ 수납 TABLE			************************ -->

                <p class="sub-title">수납</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col style=""/>
							<col style="width:13%;" />
							<col style=""/>
						</colgroup>
						<tbody>
							<tr>
								<th>수납금액</th>
								<td>
									<input type="text" name="payment" id="payment" value="<c:out value="${result.payment }" />" class="txt-r" onkeyup="fn_number(this);"/>
								</td>
								<th>수납일자</th>
								<td>
								<input type="text" name="payDate" id="datepicker11" placeholder="0000-00-00" value="${result.payDate }" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th>비고</th>
								<td colspan="2">
									<input type="text" style="width:100%;" name="remarks" id="remarks" value="<c:out value="${result.remarks }" />" >
								</td>
								
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->


				<!-- table button 목록, 저장 -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-down" onclick="fn_list()">목록</button>
						<button type="button" class="white btn-down" onclick="fn_save('<c:out value="${result.memberCode }" />')">저장</button>
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

</body>
</html>