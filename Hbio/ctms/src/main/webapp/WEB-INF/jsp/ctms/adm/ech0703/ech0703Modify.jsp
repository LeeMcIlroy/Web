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
	$(function(){
		var ynVal = '<c:out value="${ct1020mVO.useYn}"/>';
			
		if(ynVal == 'Y'){
			$("#stat1").attr('checked', 'checked');
		}else{
			$("#stat2").attr('checked', 'checked');	}
		
		
	});

	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0703/ech0703List.do'/>").submit();
	}
	
	function fn_save(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		
		var branchName = $('#branchName').val();
		var useYn = $('#useYn').val();
		
		
		if(branchName==''){
			alert('지사명을 입력해주세요.')
			$('#branchName').focus();
			return;
		}
		
		if(useYn==''){
			alert('사용여부를 선택해주세요.');
			$('#useYn').focus();
			return;
		}
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0703/ech0703Update.do'/>").submit();
	}	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>기준정보</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="기준정보"/>
	            <jsp:param name="dept2" value="지사관리"/>
           	</jsp:include>
			<!-- //타이틀 -->			
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>지사정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="ct1020mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${ct1020mVO.corpCd}">
				<input type="hidden" id="branchCd" name="branchCd" value="${ct1020mVO.branchCd}">				
	            <!-- 지사정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">지사명</th>
							<td>
								<input type="text" value="<c:out value="${ct1020mVO.branchName }" />"  class="input-data" id="branchName" name="branchName"/>
							</td>
							
							<th scope="row" class="bl">지사약칭</th>
							<td>
								<input type="text" value="<c:out value="${ct1020mVO.branchSm }" />"  class="input-data" id="branchSm" name="branchSm"/>
							</td>
						</tr>	
						<tr>	
							<th scope="row">지사구분</th>
							<td>
								<!-- 지사구분 목록(공통코드) CM4000M - CM1020  -->
								<select id="branchCls" name=branchCls>
									<c:forEach var="result" items="${cm1020}">
										<option value="${result.cd}"<c:if test="${result.cd eq ct1030mVO.branchCls}">selected="selected"</c:if>>${result.cdName}</option>
									</c:forEach>
								</select>
								
								<!-- <input type="text" value="<c:out value="${ct1020mVO.branchCls }" />"  class="input-data" id="branchCls" name="branchCls"/>  -->
							</td>
							<th scope="row" class="bl">사용여부</th>
							<td>
								<input type="radio" name="useYn" id="stat1" value="Y" checked="checked" />
							    <label for="stat1">사용</label>
							    <input type="radio" name="useYn" id="stat2" value="N"/>
							    <label for="stat2">미사용</label>
							</td>
						</tr>						
						<tr>
							<th scope="row">전화번호</th>
							<td>
								<form:input path="tel1" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="tel2" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="tel3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
							</td>
							<th scope="row" class="bl">팩스번호</th>
							<td>
								<form:input path="fax1" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="fax2" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="fax3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
							</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td colspan="3">
								<a href="#" onclick="execDaumPostcode(''); return false;" class="btn_sub2">주소검색</a>
								<form:input path="postNo" class="p15" /> <!-- 우편번호 -->
								<form:input path="addrMain" class="ta_l p40" /> <!-- 주소1 -->
								<form:input path="addrGita" class="ta_l p35" placeholder="상세주소" /> <!-- 주소2 -->
							</td>
						</tr>
						<tr>	
							<th scope="row">비고</th>
							<td colspan="3">
								<textarea class="type02 type03" id="remk" name="remk"><c:out value="${ct1020mVO.remk  }" /></textarea>
							</td>
						</tr>
						<tr>	
							<th scope="row">사업자번호</th>
							<td>
								<input type="text" value="<c:out value="${ct1020mVO.bregRsno }" />"  class="input-data" id="bregRsno" name="bregRsno"/>
							</td>
							<th scope="row" class="bl">법인번호</th>
							<td>
								<input type="text" value="<c:out value="${ct1020mVO.corpNo }" />"  class="input-data" id="corpNo" name="corpNo"/>
							</td>
						</tr>
						<tr>	
							<th scope="row">업태</th>
							<td>
								<input type="text" value="<c:out value="${ct1020mVO.bsln }" />"  class="input-data" id="bsln" name="bsln"/>
							</td>
							<th scope="row" class="bl">업종(종목)</th>
							<td>
								<input type="text" value="<c:out value="${ct1020mVO.bscl }" />"  class="input-data" id="bscl" name="bscl"/>
							</td>
						</tr>
						<tr>
							<th scope="row">대표자명</th>
							<td colspan="3">
								<input type="text" value="<c:out value="${ct1020mVO.excutNm }" />"  class="input-data" id="excutNm" name="excutNm"/>
							</td>
						</tr>
						<tr>	
							<th scope="row">담당자명</th>
							<td>
								<input type="text" value="<c:out value="${ct1020mVO.mngName }" />"  class="input-data" id="mngName" name="mngName"/>
							</td>
							<th scope="row" class="bl">담당자부서명</th>
							<td>
								<input type="text" value="<c:out value="${ct1020mVO.mngOrg }" />"  class="input-data" id="mngOrg" name="mngOrg"/>
							</td>
						</tr>
						<tr>	
							<th scope="row">담당자휴대폰</th>
							<td>
								<input type="text" value="<c:out value="${ct1020mVO.mnghpNo }" />"  class="input-data" id="mnghpNo" name="mnghpNo"/>
							</td>
							<th scope="row" class="bl">담당자이메일</th>
							<td>
								<input type="text" value="<c:out value="${ct1020mVO.mngEmail }" />"  class="input-data" id="mngEmail" name="mngEmail"/>
							</td>
						</tr>
						<tr>
							<th scope="row">지사코드(자동생성)</th>
							<td colspan="3">
								<!-- <input type="text" value="<c:out value="${ct1020mVO.branchCd }" />"  class="input-data" id="branchCd" name="branchCd" readonly/>  -->
								<c:out value="${ct1020mVO.branchCd }" />
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //지사정보 -->
			</form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_save(); return false;" >저장</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- 팝업 -->
	<input type="checkbox" id="modi-pop" class="hidden" />
	<div class="black-pop">&nbsp;</div>
	<!-- 주소찾기 -->
	<div class="modi-popup" id="addrPop">
	</div>
	<!--// 주소찾기 -->
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>