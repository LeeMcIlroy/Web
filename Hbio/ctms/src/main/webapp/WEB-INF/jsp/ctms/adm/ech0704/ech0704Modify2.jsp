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
		var ynVal = '<c:out value="${ct2000mVO.useYn}"/>';
			
		if(ynVal == '1'){
			$("#stat1").attr('checked', 'checked');
		}else{
			$("#stat2").attr('checked', 'checked');
		}
		
		var ynEmail = '<c:out value="${ct2000mVO.mngEmail}"/>';
		if(ynEmail == ''){
			$("#emailAdr").attr('value', 'hanmail.net');
		}
		
	});

	
	function fn_mailadr(el){
		var addr = $(el).val();
		
		if('' == addr){
			$("#emailAdr").removeAttr('disabled');
		}else{
			$("#emailAdr").attr('disabled', 'true');
		}
		$("#emailAdr").val(addr);
	}
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0704/ech0704List.do'/>").submit();
	}
	
	function fn_save(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var vendName = $('#vendName').val();
		var excutName = $('#excutName').val();
		var mngName = $('#mngName').val();
		
		
		if(vendName==''){
			alert('회사명을 입력해주세요.')
			$('#vendName').focus();
			return;
		}
		if(excutName==''){
			alert('대표자명을 입력해주세요.')
			$('#excutName').focus();
			return;
		}
		
		if(mngName==''){
			alert('담당자명을 입력해주세요.')
			$('#mngName').focus();
			return;
		}
		
		$("#emailAdr").removeAttr('disabled'); 
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0704/ech0704Update.do'/>").submit();
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
	            <jsp:param name="dept2" value="고객사관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<form:form commandName="ct2000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${ct2000mVO.corpCd}">
				<input type="hidden" id="vendNo" name="vendNo" value="${ct2000mVO.vendNo}">
				<!-- 서브타이틀 -->
				<div class="sub_title_area type02">
					<h4>회사정보</h4>
				</div>
				<!-- //서브타이틀 -->
				
	            <!-- 회사정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">회사명</th>
							<td>
								<input type	="text" value="<c:out value="${ct2000mVO.vendName }" />"  class="input-data" id="vendName" name="vendName"/>	
							</td>
							<th scope="row" class="bl">회사약칭</th>
							<td>
								<input type	="text" value="<c:out value="${ct2000mVO.vendSm }" />"  class="input-data" id="vendSm" name="vendSm"/>>
							</td>
						</tr>
						
						<tr>
							<th scope="row">대표자명</th>
							<td>
								<input type	="text" value="<c:out value="${ct2000mVO.excutName }" />"  class="input-data" id="excutName" name="excutName"/>	
							</td>
							<th scope="row" class="bl">회사구분</th>
							<td>
							<!-- 지사구분 목록(공통코드) CM4000M - CM1010  -->
								<select id="vendCls" name=vendCls>
									<c:forEach var="result" items="${cm1010}">
										<option value="${result.cd}"<c:if test="${result.cd eq ct2000mVO.vendCls}">selected="selected"</c:if>>${result.cdName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">사업자등록번호</th>
							<td>
								<!--<form:input path="regno1" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> -
								<form:input path="regno2" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"/> -
								<form:input path="regno3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="5"/>-->
								<input type="text" value="<c:out value="${ct2000mVO.bregRsno }" />"  class="input-data" id="bregRsno" name="bregRsno"/>
							</td>
							<th scope="row" class="bl">법인등록번호</th>
							<td>
								<!-- <form:input path="cregno1" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="6"/> -
								<form:input path="cregno2" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="7"/>   -->
								<input type="text" value="<c:out value="${ct2000mVO.corpNo }" />"  class="input-data" id="corpNo" name="corpNo"/>
							</td>
						</tr>
						
						<tr>
							<th scope="row">업태</th>
							<td>
								<input type	="text" value="<c:out value="${ct2000mVO.bsln }" />"  class="input-data" id="bsln" name="bsln"/>	
							</td>
							<th scope="row" class="bl">업종(종목)</th>
							<td>
								<input type	="text" value="<c:out value="${ct2000mVO.bscl }" />"  class="input-data" id="bscl" name="bscl"/>>
							</td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td>
								<form:input path="tel1" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="tel2" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="tel3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>							
							</td>
							<th scope="row" class="bl">팩스번호</th>
							<td>
								<form:input path="fax1" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="fax2" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="fax3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>							
							</td>
						</tr>
						<tr>	
							<th scope="row">주소</th>
							<td colspan="3">
								<a href="#" onclick="execDaumPostcode(''); return false;" class="btn_sub2">주소검색</a>
								<form:input path="post" class="p15" /> <!-- 우편번호 -->
								<form:input path="addr1" class="ta_l p40" /> <!-- 주소1 -->
								<form:input path="addr2" class="ta_l p35" placeholder="상세주소" /> <!-- 주소2 -->
							</td>
						</tr>
						<tr>
							
							<th scope="row">사용여부</th>
							<td colspan="3">>
								<input type="radio" name="useYn" id="stat1" value="Y" checked="checked" />
							    <label for="stat1">사용</label>
							    <input type="radio" name="useYn" id="stat2" value="N"/>
							    <label for="stat2">미사용</label>
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //회사정보 -->
	            <!-- 서브타이틀 -->
				<div class="sub_title_area">
					<h4>담당자정보</h4>
				</div>
				<!-- //서브타이틀 -->
	            <!-- 담당자정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">담당자명</th>
							<td>
								<input type="text" value="<c:out value="${ct2000mVO.mngName }" />" class="input_data" id="mngName" name="mngName"/>
							</td>
							<th scope="row" class="bl">부서/직위</th>
							<td>
								<input type="text" value="<c:out value="${ct2000mVO.mngOrg }" />" class="input_data" id="mngOrg" name="mngOrg"/>
							</td>
						</tr>
						<tr>
							<th scope="row">담당자휴대폰</th>
							<td>
								<select id="mobile1" name="mobile1" class="p30">
									<option value="010" <c:if test="mobile1 eq '010' }">selected="selected"</c:if> >010</option>								
									<option value="011" <c:if test="mobile1 eq '011' }">selected="selected"</c:if> >011</option>
									<option value="019" <c:if test="mobile1 eq '019' }">selected="selected"</c:if> >019</option>
								</select>
								<form:input path="mobile2" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="mobile3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
							</td>
							<th scope="row" class="bl">담당자이메일</th>
							<td>
								<form:input path="emailId" class="p30" /> @
								<form:input path="emailAdr" class="p30" disabled="true"/>
								<select class="p30" onchange="fn_mailadr(this); return false;">
									<option value="hanmail.net">hanmail.net</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="">직접입력</option>
								</select>
							</td>
						</tr>
						<tr>
						<th scope="row">담당지사</th>
							<td colspan="3">
								<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->							
								<select id="branchCd" name=branchCd>
									<c:forEach var="result" items="${branch}">
										<option value="${result.branchCd}"<c:if test="${result.branchCd eq ct2000mVO.branchCd}">selected="selected"</c:if>>${result.branchName}</option>
									</c:forEach>
								</select>	
							
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //담당자정보 -->
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