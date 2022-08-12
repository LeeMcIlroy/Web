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
		
		$("#auth-all").click(function(){
			var checked = $(this).is(":checked");
			
			$(".auth input[type=checkbox]").prop("checked", checked);
			$("#rsmg").attr('checked', 'checked');
			$("#mcrf").attr('checked', 'checked');
		});
		
		$("#rsmg").attr('checked', 'checked');
		$("#mcrf").attr('checked', 'checked');
		
		var ynVal = '<c:out value="${ct1030mVO.ipAllYn}"/>';
		if(ynVal == 'Y'){
			$("#ipAllYn1").attr('checked', 'checked');
		}else{
			$("#ipAllYn2").attr('checked', 'checked');
		}
		
		var ynexauth = '<c:out value="${ct1030mVO.exauth}"/>';
		if(ynexauth == 'Y'){
			$("#exauth1").attr('checked', 'checked');
		}else{
			$("#exauth2").attr('checked', 'checked');
		}
				
		var ynVal = '<c:out value="${ct1030mVO.userSt}"/>';
		if (ynVal == '1') {
			$("#userSt1").attr('checked', 'checked');
		} else if (ynVal == '2') {
			$("#userSt2").attr('checked', 'checked');
		} else {
			$("#userSt1").attr('checked', 'checked');
		}
		
		var ynEmail = '<c:out value="${ct1030mVO.email}"/>';
		if(ynEmail == ''){
			$("#emailAdr").attr('value', 'hanmail.net');
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

	function fn_idChk(ele){
		var adminId = $(ele).val();
		
		$.ajax({
			url: "<c:url value='/qxsepmny/ech0702/ech0702AjaxAdminIdChk.do'/>"
			, type: "post"
			, data: "adminId="+adminId
			, dataType:"json"
			, success: function(data){
				var status = data.status;
				
				if(!status){
					$("#idChkTxt").removeClass('dpn');
					$("#idChk").val('N');
				}else{
					$("#idChkTxt").addClass('dpn');
					$("#idChk").val('Y');
				}
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0702/ech0702List.do'/>").submit();
	}
	
	function fn_save(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var stat = $('#userSt').val();
		var name = $('#empName').val();
		var userId = $('#userId').val();
		
		
		if(userId==''){
			alert('아이디를 입력해주세요.')
			$('#userId').focus();
			return;
		}
		
		if(name==''){
			alert('이름을 입력해주세요.')
			$('#name').focus();
			return;
		}
				
		if(stat==''){
			alert('상태항목을 선택해주세요.');
			$('#userSt').focus();
			return;
		}
	
		$("#emailAdr").removeAttr('disabled'); 
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0702/ech0702Update.do'/>").submit();
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
	            <jsp:param name="dept2" value="사용자관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="ct1030mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${ct1030mVO.corpCd}">
				<input type="hidden" id="empNo" name="empNo" value="${ct1030mVO.empNo}">
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
							<th scope="row"><i>*</i>사용자ID</th>
							<td>
								<input type="text" value="<c:out value="${ct1030mVO.userId }" />"  class="input-data" id="userId" name="userId" onkeyup="fn_idChk(this); return false;"/>							
								<span class="alt-txt dpn" id="idChkTxt">이미 등록되어 있는 아이디입니다.</span>
								<input type="hidden" id="idChk" value="N"/>
							</td>
							<th scope="row" class="bl">비밀번호</th>
							<td>
								등록시 비밀번호는 아이디와 동일하게 생성됩니다(암호화)
								<!-- <input type="password" value="<c:out value="${ct1030mVO.pwNo }" />"  class="input-data" id="pwNo" name="pwNo"/>  -->
							</td>
						</tr>
						<tr>
							<th scope="row"><i>*</i>구분</th>
							<td>
								<!-- 연구자구분 목록(공통코드) CM4000M - CM1240  -->
								<select id="rsCls" name=rsCls>
									<c:forEach var="result" items="${cm1240}">
										<option value="${result.cd}"<c:if test="${result.cd eq ct1030mVO.rsCls}">selected="selected"</c:if>>${result.cdName}</option>
									</c:forEach>
								</select>
							</td>
							<th scope="row" class="bl"><i>*</i>권한</th>
							<td>								
								<!-- 연구권한 목록(공통코드) CM4000M - CM1210  -->
								<select id="rsAuthCls" name=rsAuthCls>
									<c:forEach var="result" items="${cm1210}">
										<option value="${result.cd}"<c:if test="${result.cd eq ct1030mVO.rsAuthCls}">selected="selected"</c:if>>${result.cdName}</option>
									</c:forEach>
								</select>	
							</td>
						</tr>
						<tr>
							<th scope="row" class="bl"><i>*</i>가입일자</th>
							<td>
								<div class="date_sec">
									<span>
									<form:input path="incDt" id="datepicker01" placeholder="0000-00-00" class="date required" title="가입일자"/>
									<label for="datepicker01" class="btn_cld">날짜검색</label>
									</span>
								</div>
							</td>
							<th scope="row" class="bl"><i>*</i>상태</th>
							<td>
								<input type="radio" name="userSt" id="userSt1" value="1" checked="checked" />
							    <label for="userSt1">정상</label>
							    <input type="radio" name="userSt" id="userSt2" value="2"/>
							    <label for="userSt2">정지(로그인차단)</label>&nbsp;&nbsp;&nbsp;&nbsp;(‘정지’로 설정한 경우 로그인이 차단됩니다.)							    
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 서브타이틀 -->
				<div class="sub_title_area">
					<h4>사용자정보</h4>
				</div>
				<!-- //서브타이틀 -->
	            <!-- 사용자정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">구성원번호</th>
							<td>
								<c:out value="${ct1030mVO.empNo }" />							
							</td>
							<th scope="row" class="bl"><i>*</i>사원구분</th>
							<td>
							<!-- <select id="empCls" name="empCls">
									<option value="" <c:if test="${ct1030mVO.empCls eq '' }">selected="selected"</c:if> >선택</option>								
									<option value="10" <c:if test="${ct1030mVO.empCls eq '10' }">selected="selected"</c:if> >직원-직접</option>
									<option value="20" <c:if test="${ct1030mVO.empCls eq '20' }">selected="selected"</c:if> >협력-직접</option>
							</select>  -->
								<!-- 사원구분 목록(공통코드) CM4000M - CM1230  -->
								<select id="empCls" name=empCls>
									<c:forEach var="result" items="${cm1230}">
										<option value="${result.cd}"<c:if test="${result.cd eq ct1030mVO.empCls}">selected="selected"</c:if>>${result.cdName}</option>
									</c:forEach>
								</select>		
							</td>
						</tr>
						<tr>
							<th scope="row"><i>*</i>사용자명</th>
							<td>
								<input type="text" value="<c:out value="${ct1030mVO.empName }" />"  class="input-data" id="empName" name="empName"/>
							</td>
							<th scope="row" class="bl">지사정보</th>
							<td>
								<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->							
								<select id="branchCd" name=branchCd>
									<c:forEach var="result" items="${branch}">
										<option value="${result.branchCd}"<c:if test="${result.branchCd eq ct1030mVO.branchCd}">selected="selected"</c:if>>${result.branchName}</option>
									</c:forEach>
								</select>	
							</td>
						</tr>
						<tr>
							<th scope="row">부서</th>
							<td>
								<!-- 부서구분 목록(공통코드) CM4000M - CM1220  -->
								<select id="orgNo" name=orgNo>
									<c:forEach var="result" items="${cm1220}">
										<option value="${result.cd}"<c:if test="${result.cd eq ct1030mVO.orgNo}">selected="selected"</c:if>>${result.cdName}</option>
									</c:forEach>
								</select>
							</td>
							<th scope="row" class="bl">직위</th>
							<td>
								<input type="text" value="<c:out value="${ct1030mVO.spot }" />"  class="input-data" id="spot" name="spot"/>
							</td>
						</tr>
						<tr>
							<th scope="row">핸드폰</th>
							<td>
								<!-- 휴대폰 첫자리는 select box로 구성하자 -->
								
								<select id="mobile1" name="mobile1" class="p30">
									<option value="010" <c:if test="mobile1 eq '010' }">selected="selected"</c:if> >010</option>								
									<option value="011" <c:if test="mobile1 eq '011' }">selected="selected"</c:if> >011</option>
									<option value="019" <c:if test="mobile1 eq '019' }">selected="selected"</c:if> >019</option>
								</select>							
	                            <!--<form:input path="mobile1" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> -->
								<form:input path="mobile2" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="mobile3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
							</td>
							<th scope="row" class="bl">이메일</th>
								<td colspan="3">
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
					</tbody>
				</table>
	            <!-- //사용자정보 -->
	            <!-- 서브타이틀 -->
				<div class="sub_title_area">
					<h4>권한정보</h4>
				</div>
				<!-- //서브타이틀 -->
	            <!-- 권한정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><i>*</i>접속허용IP</th>
							<td>
								<form:input path="ip1" class="p10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> .
								<form:input path="ip2" class="p10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> .
								<form:input path="ip3" class="p10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> .
								<form:input path="ip4" class="p10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/>
							
								<!-- <input type="text" value="<c:out value="${ct1030mVO.acceIp }" />"  class="input-data" id="acceIp" name="acceIp"/>
								<input type="text" value="<c:out value="${ct1030mVO.acceIp }" />"  class="input-data" id="acceIp" name="acceIp"/> -->
							</td>
							<th scope="row" class="bl"><i>*</i>모든 IP허용</th>
							<td>
								<input type="radio" name="ipAllYn" id="ipAllYn1" value="Y" />
							    <label for="ipAllYn1">모든 IP허용</label>
							    <input type="radio" name="ipAllYn" id="ipAllYn2" value="N" checked="checked"/>
							    <label for="ipAllYn2">고정 IP사용</label>	
							</td>
						</tr>
						<tr>
							<th scope="row"><i>*</i>사용자구분</th>
							<td>
								<select id="adminType" name="adminType" class="p30">
									<option value="" <c:if test="${ct1030mVO.adminType  eq '' }">selected="selected"</c:if> >선택</option>
									<option value="1" <c:if test="${ct1030mVO.adminType  eq '1' }">selected="selected"</c:if> >Admin 권한</option>								
									<option value="2" <c:if test="${ct1030mVO.adminType  eq '2' }">selected="selected"</c:if> >일반사용자 권한</option>
								</select>
							</td>
							<th scope="row" class="bl">최근로그인일자</th>
							<td>
								<c:out value="${ct1030mVO.rloginDt}" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="auth-all"><i>*</i>사용권한<input type="checkbox" id="auth-all"/></label></th>
							<td colspan="3">
								<div class="check-box auth">
									<ul>
										<li>
											<form:checkbox path="rsmg" value="Y" id="rsmg"/>
											<label for="rsmg">연구관리</label>
										</li>
										<li>
											<form:checkbox path="ecrf" value="Y"/>
											<label for="ecrf">eCRF관리</label>
										</li>
										<li>
											<form:checkbox path="rsjt" value="Y"/>
											<label for="rsjt">피험자관리</label>
										</li>
										<li>
											<form:checkbox path="extr" value="Y"/>
											<label for="extr">자료추출</label>
										</li>
										<li>
											<form:checkbox path="rept" value="Y"/>
											<label for="rept">보고서</label>
										</li>
										<li>
											<form:checkbox path="send" value="Y"/>
											<label for="send">발송관리</label>
										</li>
										<li>
											<form:checkbox path="sale" value="Y"/>
											<label for="send">영업관리</label>
										</li>
										<li>
											<form:checkbox path="stnd" value="Y"/>
											<label for="stnd">기준정보관리</label>
										</li>
										<li>
											<form:checkbox path="oper" value="Y"/>
											<label for="oper">운영관리</label>
										</li>
										<li>
											<form:checkbox path="mcrf" value="Y" id="mcrf"/>
											<label for="mcrf">CRF작성</label>
										</li>
										<li>
											<form:checkbox path="acrf" value="Y"/>
											<label for="acrf">종료확인</label>
										</li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row" class="bl"><i>*</i>엑셀다운로드권한</th>
							<td colspan="3">
								<input type="radio" name="exauth" id="exauth1" value="Y" />
							    <label for="exauth1">엑셀다운로드허용</label>
							    <input type="radio" name="exauth" id="exauth2" value="N" checked="checked"/>
							    <label for="exauth2">허용안함</label>	
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //사용자정보 -->	            
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
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>