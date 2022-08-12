<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	$(function(){
		
		$("#chkmobile").val("Y");
		var ynVal = '<c:out value="${sb1000mVO.userSt}"/>';
		
		if(ynVal == '1'){
			$("#stat1").attr('checked', 'checked');
		}else{
			$("#stat2").attr('checked', 'checked');
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
		
		var ynConfirmYn = '<c:out value="${sb1000mVO.cfmYn}"/>';
		
		if(ynConfirmYn == 'Y'){
			$("#cfmYn1").attr('checked', 'checked');
		}else{
			$("#cfmYn2").attr('checked', 'checked');
		}				

		var ynrsjStCls = '<c:out value="${sb1000mVO.rsjStCls}"/>';
		if(ynrsjStCls == ''){
			$("#rsjStCls").val("90");
		}		
		
		// 첨부파일이 있는 경우 파일업로드 버튼을 숨긴다
		if(${empty attachList }){ 
			//alert(${empty attachList });
			$(".checkfile").show();
		}else{				
			$(".checkfile").hide();
		}		
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
	
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100201.do'/>"
					, 'SMS발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	function fn_list(){
		
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0301/ech0301List.do'/>").submit();
		
		//location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0301/ech0301List.do'/>";
	}
	
	function fn_save(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var chkmobile = $("#chkmobile").val();
		if(chkmobile=='N'){
			alert('핸드폰중복확인을 해주세요.')
			$('#mobile2').focus();
			return;
		}
		
		var regDt = $('#datepicker01').val();			
		if(regDt==''){
			alert('등록일자를 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
	
		var name = $('#rsjName').val();		
		if(name==''){
			alert('이름을 입력해주세요.')
			$('#rsjName').focus();
			return;
		}
		
		$("#emailAdr").removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0301/ech0301Update.do'/>").submit();
	}

	//첨부파일 삭제
	function fn_delfile(fileKey, seq){
	
		var html = '';
		if(seq != ''){
			html += '<input type="hidden" id="delFile" name="delFile" value="'+seq+'"/>';
		}
			html += '<input type="file" id="'+fileKey+'" name="'+fileKey+'" onchange="fn_file_add(\''+fileKey+'\'); return false;"/>';
			html += '<label for="'+fileKey+'" id="'+fileKey+'_label" class="btn_sub">파일업로드</label>';
		
		
		$("#"+fileKey+"_div").html(html);
	}
	//첨부파일 추가
	function fn_file_add(fileKey){
		
		if(fileCheck_adm(fileKey)){
			var fileValue = $('#'+fileKey).val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
			var html = ''
		
			html+= '<div>';
			html+= '<span>'+fileName+'</span>';
			html+= '<a href="#" onclick="fn_delfile(\''+fileKey+'\',\'\');">삭제</a>';
			html+= '</div>'; 
			
			$("#"+fileKey+"_label").addClass('dpn');
			$("#"+fileKey+"_div").append(html); 
        } 
	}
	 
	 
	// 핸드폰번호 중복체크
	function fn_check(){
		var mobile1 = $("#mobile1").val();
		var mobile2 = $("#mobile2").val();
		var mobile3 = $("#mobile3").val();
		var rsjNo = $("#rsjNo").val();
		
		if(mobile2 == ''){
			alert('먼저 핸드폰번호를 입력해 주세요');
			return;
		}
		$.ajax({
			url: "<c:url value='/qxsepmny/ech0301/ech0301AjaxHpNoCheck.do'/>"
			, type: "post"
			, data: "mobile1="+mobile1+"&"+"mobile2="+mobile2+"&"+"mobile3="+mobile3+"&"+"rsjNo="+rsjNo
			, dataType:"json"
			, success: function(data){
				var status = data.status;
				var message = data.message;
				
				/* if(!status){
					$("#rsCd").val('');
				}else{
					$("#rsCd").val(rsCd);
				} */
				alert(message);
				$('#chkmobile').val("Y");
			}, error: function(){
				alert("오류가 발생하였습니다.");
				$('#chkmobile').val("N");
			}
		});
	}
	
	function fn_resetChkmobile(){
		$('#chkmobile').val("N");
	}
	
</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm" method="post" enctype="multipart/form-data">
	<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
	<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }"/>
	<input type="hidden" id="searchCondition3" name="searchCondition3" value="${searchVO.searchCondition3 }"/>
	<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
	<input type="hidden" id="chkmobile" name="chkmobile"/>
</form:form>				
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>피험자관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="피험자관리"/>
	            <jsp:param name="dept2" value="피험자관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="sb1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${sb1000mVO.corpCd}">
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
						<th scope="row"><i>*</i>등록일자(필수)</th>
						<td> 
							<div class="date_sec">
							<span>
							<input name="regDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${sb1000mVO.regDt }" />" class="date required" title="등록일자" />
							<label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
								<!--<form:input path="regDt" id="datepicker01" placeholder="0000-00-00" class="required" title="등록일자"/>-->
							</div>
						</td>
						<th scope="row"  class="bl">번호(자동생성)</th>
						<td>
							<input type="text" value="<c:out value="${sb1000mVO.rsjNo }" />"  class="input-data" id="rsjNo" name="rsjNo" readonly/>
						</td>	
					</tr>					
					<tr>						
						<th scope="row" class="bl"><i>*</i>이름</th>
						<td>
							<input type="text" value="<c:out value="${sb1000mVO.rsjName }" />"  class="input-data required" id="rsjName" name="rsjName"/>
						</td>
						<th scope="row"  class="bl"><i>*</i>생년월일</th>
						<td> 
							<form:select path="brDtY" class="required select-one p20" title="생년월일">
								<form:option value="">년도</form:option>
								<c:set var="now" value="<%=new java.util.Date()%>" />
								<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/> 
								<c:forEach begin="0" end="70" var="result" step="1">
									<form:option value="${yearStart - result}"><c:out value="${yearStart - result}" /></form:option>
								</c:forEach>
							</form:select>&nbsp;년&nbsp;&nbsp;
							<form:select path="brDtM" class="required select-one p20" title="생년월일">
								<form:option value="">월</form:option>
								<c:forEach begin="1" end="12" var="month" step="1">
									<fmt:formatNumber minIntegerDigits="2" value="${month }" var="month"/>
									<form:option value="${month }"><c:out value="${month }"/></form:option>
								</c:forEach>
							</form:select>&nbsp;월&nbsp;&nbsp;
							<form:select path="brDtD" class="required select-one p20" title="생년월일">
								<form:option value="">일</form:option>
								<c:forEach begin="1" end="31" var="day" step="1">
									<fmt:formatNumber minIntegerDigits="2" value="${day }" var="day"/>
									<form:option value="${day }"><c:out value="${day }"/></form:option>
								</c:forEach>
							</form:select>&nbsp;일						
							<!--<div class="date_sec">
								<span>								
								<form:input path="brDt" id="datepicker02" placeholder="0000-00-00" class="date required" title="생년월일"/>
								<label for="datepicker02" class="btn_cld">날짜검색</label>
								</span>
							</div> -->
						</td>	
					</tr>
					<tr>
						<th scope="row"><i>*</i>성별</th>
						<td>
							<input type="radio" name="genYn" id="gender1" value="1" checked="checked" />
							<label for="gender1">남</label>
							<input type="radio" name="genYn" id="gender2" value="2"/>
							<label for="gender2">여</label>
						</td>
						<th scope="row" class="bl">주민등록번호</th>
						<td>
							<form:input path="regNo1" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="6"/> -
							<form:input path="regNo2" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="7"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><i>*</i>핸드폰</th>
						<td>
							<select id="mobile1" name="mobile1" class="p25">
								<option value="010" <c:if test="mobile1 eq '010' }">selected="selected"</c:if> >010</option>								
								<option value="011" <c:if test="mobile1 eq '011' }">selected="selected"</c:if> >011</option>
								<option value="019" <c:if test="mobile1 eq '019' }">selected="selected"</c:if> >019</option>
							</select>							
	                        <form:input path="mobile2" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4" onchange="fn_resetChkmobile(); return false;"/> -
							<form:input path="mobile3" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4" onchange="fn_resetChkmobile(); return false;"/>
							<a href="#" onclick="fn_check(); return false;" class="btn_sub" id="btnDupchk">중복확인</a>
						
						</td>
						<th scope="row" class="bl">이메일</th>
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
						<th scope="row">주소</th>
						<td colspan="3">
							<a href="#" onclick="execDaumPostcode(''); return false;" class="btn_sub2">주소검색</a>
							<form:input path="postNo" class="p15" /> <!-- 우편번호 -->
							<form:input path="addrMain" class="ta_l p40" /> <!-- 주소1 -->
							<form:input path="addrGita" class="ta_l p35" placeholder="상세주소" /> <!-- 주소2 -->
						</td>
					</tr>
					<tr>
						<th scope="row">은행명</th>
						<td>
							<input type="text" value="<c:out value="${sb1000mVO.bankName }" />"  class="p40" id="bankName" name="bankName"/>
						</td>
						<th scope="row">예금주</th>
						<td>
							<input type="text" value="<c:out value="${sb1000mVO.acctName }" />"  class="p40" id="acctName" name="acctName"/>							
						</td>
					</tr>
					<tr>
						<th scope="row">계좌번호</th>
						<td colspan="3">
							<input type="text" value="<c:out value="${sb1000mVO.acctNo }" />"  class="p40" id="acctNo" name="acctNo"/>
						</td>
					</tr>		
					<tr>
						<th scope="row">통장사본</th>
                       <td colspan="3" id="file_td">
                            <div class="attach_sec type02 mb02" id="attachRpt01_div">
	                            	<c:choose>
		                            		<c:when test="${attachMap.attachRpt01 != null }">
				                            	<div>
				                            		<span><c:out value="${attachMap.attachRpt01.orgFileName }"/></span>
				                            		<a href="#" onclick="fn_delfile('attachRpt01','<c:out value="${attachMap.attachRpt01.attachNo }"/>');">삭제</a>
				                            	</div>
		                            		</c:when>
		                            		<c:otherwise>
				                            	 <input type="file" id="attachRpt01" name="attachRpt01" onchange="fn_file_add('attachRpt01'); return false;"/>
				                            	<label for="attachRpt01" id="attachRpt01_label" class="btn_sub">파일업로드</label>  
		                            		</c:otherwise>
	                            	</c:choose>
                            </div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="bl">지사정보</th>
						<td colspan="3">
							<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->							
							<select id="branchCd" name="branchCd" class="p20">
								<c:forEach var="result" items="${branch}">
									<option value="${result.branchCd}"<c:if test="${result.branchCd eq sb1000mVO.branchCd}">selected="selected"</c:if>>${result.branchName}</option>
								</c:forEach>
							</select>	
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //기본정보 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>연구대상자 상태</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 연구대상자 상태 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>								
					<tr>
						<th scope="row">관리자 확인</th>
						<td>
							<!-- <input type="checkbox" name="subIdent" id="subIdent" />
							<label for="subIdent">피험자 확인</label>  -->
							
							<input type="radio" name="cfmYn" id="confirmYn1" value="Y" />
							<label for="cfmYn1">확인</label>
							<input type="radio" name="cfmYn" id="confirmYn2" value="N"  checked="checked"/>
							<label for="cfmYn2">미확인</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<span>확인일 :</span> 
							<div class="date_sec">
								<span>								
								<input name="cfmDt" id="datepicker03" placeholder="0000-00-00" value="<c:out value="${sb1000mVO.cfmDt }" />" class="date required" title="확인일" />
								<label for="datepicker03" class="btn_cld">날짜검색</label>
								</span>
							</div>
						</td>
						<th scope="row" class="bl">연구순응도</th>
						<td>
							<!-- 연구순응도목록 목록(공통코드) CM4000M - CT1010  -->
							<select id="rsjStCls" name="rsjStCls" class="p30">
									<c:forEach var="result" items="${ct1010}">
										<option value="${result.cd}"<c:if test="${result.cd eq sb1000mVO.rsjStCls}">selected="selected"</c:if>>${result.cdName}</option>
									</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">연구대상자유형</th>
						<td colspan="3">
							<div class="unit_wrap">
								<!-- 유형 -->
								<div class="unit">
									<p>안면여드름</p>									
									<select id="faceacne" name="faYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.faYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.faYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.faYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">								
									<p>등여드름</p>								
									<select id="baYn" name="baYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.baYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.baYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.baYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>팔자주름</p>
									<select id="nfYn" name="nfYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.nfYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.nfYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.nfYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>셀룰라이트</p>
									<select id="clYn" name="clYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.clYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.clYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.clYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>눈가주름</p>
									<select id="weYn" name="weYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.weYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.weYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.weYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>다크서클</p>
									<select id="dcYn" name="dcYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.dcYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.dcYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.dcYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>광피부타입</p>
									<select id="ltYn" name="ltYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.ltYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.ltYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.ltYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>색소침착</p>
									<select id="pmYn" name="pmYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.pmYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.pmYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.pmYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>탈모</p>
									<select id="hlYn" name="hlYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.hlYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.hlYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.hlYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>아이백</p>
									<select id="ebYn" name="ebYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.ebYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.ebYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.ebYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>민감여부</p>
									<select id="snYn" name="snYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.snYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.snYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.snYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>비듬</p>
									<select id="ddYn" name="ddYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.ddYn eq '' }">selected="selected" </c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.ddYn eq 'Y' }">selected="selected" </c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.ddYn eq 'N' }">selected="selected" </c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>홍조</p>
									<select id="flYn" name="flYn" class="p60">
										<option value="" <c:if test="${sb1010mVO.flYn eq '' }">selected="selected"</c:if> >선택</option>
										<option value="Y" <c:if test="${sb1010mVO.flYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.flYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">메모</th>
						<td colspan="3">
							<textarea class="type02 type03" id="remk" name="remk"><c:out value="${sb1000mVO.remk }" /></textarea>
							
							<!-- <input type="text" value="<c:out value="${sb1000mVO.remk }" />"  class="p40" id="remk" name="remk"/> -->
						</td>
					</tr>
					<tr>
						<th scope="row"><i>*</i>상태</th>
						<td colspan="3">
							<input type="radio" name="userSt" id="stat1" value="1" checked="checked" />
							<label for="stat1">정상</label>
							<input type="radio" name="userSt" id="stat2" value="2"/>
							<label for="stat2">정지(로그인차단)</label>&nbsp;&nbsp;&nbsp;&nbsp;(‘정지’로 설정한 경우 로그인이 차단됩니다.)
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //연구대상자 상태 -->
			</form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_save(); return false;" >저장</a>
			</div>
			<!-- //버튼 -->
			<!-- 테이블 상단 정보 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
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