<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script type="text/javascript">
	$(function(){

		var ynhplogin = '<c:out value="${sb1000mVO.hplogin}"/>';
		if(ynhplogin == 'Y') {
			$('#disp').hide();
		}
		
		var ynGender = '<c:out value="${sb1000mVO.genYn}"/>';
		if(ynGender == '1'){
			$("#gender1").attr('checked', 'checked');
		}else{
			$("#gender2").attr('checked', 'checked');
		}

		var ynEmail = '<c:out value="${sb1000mVO.email}"/>';
		if(ynEmail == ''){
			$("#emailAdr").attr('value', 'hanmail.net');
		}
	
		// 첨부파일이 있는 경우 파일업로드 버튼을 숨긴다
		
		/* if(${empty attachList }){ 
			//alert(${empty attachList });
			$(".checkfile").show();
		}else{				
			$(".checkfile").hide();
		}		 */
		
		$("#usrId").attr('disabled', 'true');
		$("#rsjName").attr('disabled', 'true');
		// 등록, 수정 구분? 
		
		// $("#datepicker01").datepicker();
	
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

	function fn_save(){

		//성별, 생년월일, 핸드폰, 주소, 임상시험 정보 필수입력 
		
		var name = $('#userId').val();
		if(name==''){
			alert('아이디를 입력해주세요.')
			$('#userId').focus();
			return;
		}
			
		var name = $('#rsjName').val();
		if(name==''){
			alert('이름을 입력해주세요.')
			$('#rsjName').focus();
			return;
		}
		
		var yngenYn = $('#genYn').val();
		if(yngenYn==''){
			alert('성별을 입력해주세요.')
			$('#genYn').focus();
			return;
		}
		
		var yngenYn = $('#genYn').val();
		if(yngenYn==''){
			alert('성별을 입력해주세요.')
			$('#genYn').focus();
			return;
		}
		
		var ynbrDtY = $('#brDtY').val();
		if(ynbrDtY==''){
			alert('생년월일을 입력해주세요.')
			$('#brDtY').focus();
			return;
		}
		if(ynbrDtY > '2004'){
			alert('생년월일을 입력해주세요.')
			$('#brDtY').focus();
			return;
		}
		
		var ynbrDtM = $('#brDtM').val();
		if(ynbrDtM==''){
			alert('생년월일을 입력해주세요.')
			$('#brDtM').focus();
			return;
		}
		
		var ynbrDtD = $('#brDtD').val();
		if(ynbrDtD==''){
			alert('생년월일을 입력해주세요.')
			$('#brDtD').focus();
			return;
		}
		
		var ynmobile1 = $('#mobile1').val();
		if(ynmobile1==''){
			alert('핸드폰번호를 입력해주세요.')
			$('#mobile1').focus();
			return;
		}
		
		var ynmobile2 = $('#mobile2').val();
		if(ynmobile2==''){
			alert('핸드폰번호를 입력해주세요.')
			$('#mobile2').focus();
			return;
		}
		
		var ynmobile3 = $('#mobile3').val();
		if(ynmobile3==''){
			alert('핸드폰번호를 입력해주세요.')
			$('#mobile3').focus();
			return;
		}
		
		var ynmobile3 = $('#mobile13').val();
		if(ynmobile3==''){
			alert('핸드폰번호를 입력해주세요.')
			$('#mobile3').focus();
			return;
		}

		var ynpostNo = $('#postNo').val();
		if(ynpostNo==''){
			alert('주소를 입력해주세요.')
			$('#postNo').focus();
			return;
		}
		
		var ynaddrMain = $('#addrMain').val();
		if(ynaddrMain==''){
			alert('주소를 입력해주세요.')
			$('#addrMain').focus();
			return;
		}
		
		$("#emailAdr").removeAttr('disabled');
		$("#usrId").removeAttr('disabled');
		$("#rsjName").removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/ecf0501/ecf0501Update.do'/>").submit();
	}
	
	function fn_modifyPw(){

		var name = $('#userId').val();
		if(name==''){
			alert('아이디를 입력해주세요.')
			$('#userId').focus();
			return;
		}
			
		var name = $('#rsjName').val();
		if(name==''){
			alert('이름을 입력해주세요.')
			$('#rsjName').focus();
			return;
		}
		
		$("#emailAdr").removeAttr('disabled');
		$("#usrId").removeAttr('disabled');
		$("#rsjName").removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/ecf0501/ecf0501ModifyPw.do'/>").submit();
	}
	
	
	
</script>	
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<form:form commandName="sb1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
	<input type="hidden" id="corpCd" name="corpCd" value="${sb1000mVO.corpCd}">
	<input type="hidden" id="rsjNo" name="rsjNO" value="${sb1000mVO.rsjNo}">
	<!-- contents -->
	<div class="contents">
		<!-- 회원정보 -->
		<div class="profile">			
			<ul>
				<li>
					<div>
						<p>아이디</p>
						<div>
							<input type="text" value="<c:out value="${sb1000mVO.userId }"/>" name="userId" id="usrId" class="form_base" />
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>이름</p>
						<div>
							<input type="text" value="<c:out value="${sb1000mVO.rsjName }"/>" name="rsjName" id="rsjName" class="form_base" />
						</div>
					</div>
				</li>
				<li>
					<div>
						<p><i style="color:#e54141;">*</i>성별</p>
						<div>
							<input type="radio" name="genYn" id="gender1" value="1" checked="checked" class="form_base"/>
							<label for="gender1">남</label>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="genYn" id="gender2" value="2" class="form_base"/>
							<label for="gender2">여</label>
						</div>
					</div>
				</li>
				<li>
					<div>
						<p><i style="color:#e54141;">*</i>생년월일</p>
						<div>
							<form:select path="brDtY" class="required select-one p20 phone" title="생년월일">
								<form:option value="">년도</form:option>
								<c:set var="now" value="<%=new java.util.Date()%>" />
								<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/> 
								<c:forEach begin="0" end="70" var="result" step="1">
									<form:option value="${yearStart - result}"><c:out value="${yearStart - result}" /></form:option>
								</c:forEach>
							</form:select>&nbsp;년&nbsp;&nbsp;
							<form:select path="brDtM" class="required select-one p20 phone" title="생년월일">
								<form:option value="">월</form:option>
								<c:forEach begin="1" end="12" var="month" step="1">
									<fmt:formatNumber minIntegerDigits="2" value="${month }" var="month"/>
									<form:option value="${month }"><c:out value="${month }"/></form:option>
								</c:forEach>
							</form:select>&nbsp;월&nbsp;&nbsp;
							<form:select path="brDtD" class="required select-one p20 phone" title="생년월일">
								<form:option value="">일</form:option>
								<c:forEach begin="1" end="31" var="day" step="1">
									<fmt:formatNumber minIntegerDigits="2" value="${day }" var="day"/>
									<form:option value="${day }"><c:out value="${day }"/></form:option>
								</c:forEach>
							</form:select>&nbsp;일&nbsp;&nbsp;
						</div>
					</div>
				</li>
				<li>
					<div>
						<p><i style="color:#e54141;">*</i>핸드폰</p>
						<div>
							<select id="mobile1" name="mobile1" class="p25 phone">
								<option value="010" <c:if test="mobile1 eq '010' }">selected="selected"</c:if> >010</option>								
								<option value="011" <c:if test="mobile1 eq '011' }">selected="selected"</c:if> >011</option>
								<option value="019" <c:if test="mobile1 eq '019' }">selected="selected"</c:if> >019</option>
							</select>							
	                        <form:input path="mobile2" class="p30 phone" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
							<form:input path="mobile3" class="p30 phone" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>이메일</p>
						<div>
							<form:input path="emailId" class="p30 email1" /> @
							<form:input path="emailAdr" class="p30 email2" disabled="true"/>
							<select class="p30 email2" onchange="fn_mailadr(this); return false;">
								<option value="hanmail.net">hanmail.net</option>
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="">직접입력</option>
							</select>
						</div>
					</div>
				</li>
				<li>
					<div>
						<p><i style="color:#e54141;">*</i>주소</p>
						<div>
							<div class="address">	
								<a href="#" onclick="execDaumPostcode(''); return false;" class="btn_sub2">주소검색</a>
								<form:input path="postNo" class="p15" /> <!-- 우편번호 -->
							</div>							
							<form:input path="addrMain" class="ta_l p40" /> <!-- 주소1 -->
							<form:input path="addrGita" class="ta_l p35" placeholder="상세주소" /> <!-- 주소2 -->
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>계좌정보</p>
						<div>
							<input type="text" placeholder="은행명"  value="<c:out value="${sb1000mVO.bankName }" />"  class="p40 bankbook1" id="bankName" name="bankName"/>
							<input type="text" placeholder="계좌번호"  value="<c:out value="${sb1000mVO.acctNo }" />"  class="p40 bankbook2" id="acctNo" name="acctNo"/>
							<input type="text" placeholder="예금주" value="<c:out value="${sb1000mVO.acctName }" />"  class="p40 bankbook1" id="acctName" name="acctName"/>
						</div>	
					</div>
				</li>
				<!-- <li>
					<div>
						<p>통장사본</p>			
						<div>
                           	<input type="file" id="in_file01" />
                           	<label for="in_file01" class="btn_sub2">통장사본파일</label>
                           	<div>
                           		<span>파일명.jpg<a href="#">삭제</a></span>
                           	</div>
						</div>
					</div>
				</li> -->
				<li>
					<div>
						<p><i style="color:#e54141;">*</i>임상시험 정보</p>
						<div class="clinic_info">
							<div>
								<p>안면여드름</p>
								<select id="faceacne" name="faYn" class="p60">
										<option value="Y" <c:if test="${sb1010mVO.faYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.faYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>등여드름</p>
								<select id="baYn" name="baYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.baYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.baYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>팔자주름</p>
								<select id="nfYn" name="nfYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.nfYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.nfYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>셀룰라이트</p>
								<select id="clYn" name="clYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.clYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.clYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>눈가주름</p>
								<select id="weYn" name="weYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.weYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.weYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>다크서클</p>
								<select id="dcYn" name="dcYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.dcYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.dcYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>광피부타입</p>
								<select id="ltYn" name="ltYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.ltYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.ltYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>색소침착</p>
								<select id="pmYn" name="pmYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.pmYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.pmYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>탈모</p>
								<select id="hlYn" name="hlYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.hlYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.hlYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>아이백</p>
								<select id="ebYn" name="ebYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.ebYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.ebYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>민감여부</p>
								<select id="snYn" name="snYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.snYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.snYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>비듬</p>
								<select id="ddYn" name="ddYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.ddYn eq 'Y' }">selected="selected" </c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.ddYn eq 'N' }">selected="selected" </c:if> >없음</option>
								</select>
							</div>
							<div>
								<p>홍조</p>
								<select id="flYn" name="flYn" class="p60">
									<option value="Y" <c:if test="${sb1010mVO.flYn eq 'Y' }">selected="selected"</c:if> >있음</option>
									<option value="N" <c:if test="${sb1010mVO.flYn eq 'N' }">selected="selected"</c:if> >없음</option>
								</select>
							</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
		<!-- //회원정보 -->
		</form:form>
		<!-- 하단버튼 -->
		<div class="btn_area">
			<span><a href="#" class="type02">취소</a></span>
			<span><a href="#" onclick="fn_save(); return false;" >저장</a></span>
		</div>
		<div class="btn_area" id="disp">
			<span><a href="#" onclick="fn_modifyPw(); return false;" class="type02">비밀번호변경</a></span>
		</div>
		<!-- //하단버튼 -->
	</div>
	<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	<!-- //contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- //footer -->
	<!-- 팝업 -->
	<input type="checkbox" id="modi-pop" class="hidden" />
	<div class="black-pop">&nbsp;</div>
	<!-- 주소찾기 -->
	<div class="modi-popup" id="addrPop">
	</div>
	<!--// 주소찾기 -->	
</div>
<!-- //wrap -->
</body>
</html>