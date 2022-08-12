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
		var ynVal = '<c:out value="${ct1010mVO.stat}"/>';
			
		if(ynVal == '1'){
			$("#stat1").attr('checked', 'checked');
		}else{
			$("#stat2").attr('checked', 'checked');
		}
		
		var ynEmail = '<c:out value="${ct1010mVO.email}"/>';
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

	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0702/ech0702List.do'/>").submit();
	}
	
	function fn_save(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var stat = $('#stat').val();
		var name = $('#name').val();
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
			$('#stat').focus();
			return;
		}
	
		$("#emailAdr").removeAttr('disabled'); 
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0702/ech0702Save.do'/>").submit();
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
			<form:form commandName="ct1010mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="userNo" name="userNo" value="${ct1010mVO.userNo}">
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
							<th scope="row">사용자ID</th>
							<td>
								<input type="text" value="<c:out value="${ct1010mVO.userId }" />"  class="input-data" id="userId" name="userId"/>							
							</td>
							<th scope="row" class="bl">비밀번호</th>
							<td>
								<input type="password" value="<c:out value="${ct1010mVO.pwNo }" />"  class="input-data" id="pwNo" name="pwNo"/>
							</td>
						</tr>
						<tr>
							<th scope="row">구분</th>
							<td>
								<!-- 공통코드로 처리 -->
								<select id="userGb" name="userGb">
									<option value="" <c:if test="${ct1010mVO.userGb eq '' }">selected="selected"</c:if> >선택</option>								
									<option value="1001" <c:if test="${ct1010mVO.userGb eq '1001' }">selected="selected"</c:if> >연구원</option>
									<option value="1002" <c:if test="${ct1010mVO.userGb eq '1002' }">selected="selected"</c:if> >관리자</option>
								</select>
							</td>
							<th scope="row" class="bl">권한</th>
							<td>
								<!-- 공통코드로 처리 -->
								<select id="resererStat" name="resererStat">
									<option value="" <c:if test="${ct1010mVO.resererStat eq '' }">selected="selected"</c:if> >선택</option>								
									<option value="1" <c:if test="${ct1010mVO.resererStat eq '1' }">selected="selected"</c:if> >연구담당자</option>
									<option value="2" <c:if test="${ct1010mVO.resererStat eq '2' }">selected="selected"</c:if> >연구책임자</option>
								</select>	
							</td>
						</tr>
						<tr>
							<th scope="row">최근로그인</th>
							<td> </td>
							<th scope="row" class="bl">가입일자</th>
							<td>
							<form:input path="enterYmd" id="datepicker01" placeholder="0000-00-00" class="required" title="가입일자"/>
							</td>
						</tr>
						<tr>
							<!-- 공통코드로 처리 -->
							<th scope="row">상태</th>
							<td colspan="3">
								<input type="radio" name="stat" id="stat1" value="1" checked="checked" />
							    <label for="stat1">정상</label>
							    <input type="radio" name="stat" id="stat2" value="2"/>
							    <label for="stat2">정지(로그인차단)</label>&nbsp;&nbsp;&nbsp;&nbsp;(‘정지’로 설정한 경우 로그인이 차단됩니다.)
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
							<th scope="row">사용자명</th>
							<td>
								<input type="text" value="<c:out value="${ct1010mVO.name }" />"  class="input-data" id="name" name="name"/>
							</td>
							<th scope="row" class="bl">지사정보</th>
							<!-- 지사관리 테이블 처리 
								지사이름, 지사코드 -> 사용자 테이블 CD1010에은 지사코드가 등록되어야 한다. 	
							-->
							<td>							
								<select id="branchNo" name="branchNo">
									<c:forEach var="result" items="${branch}">
										<option value="${result.branchCd}"<c:if test="${result.branchCd eq ct1010mVO.branchNo}">selected="selected"</c:if>>${result.branchName}</option>
									</c:forEach>
								</select>	
							</td>
						</tr>
						<tr>
							<th scope="row">부서</th>
							<td>
								<!-- 공통코드로 처리 -->
								<select id="buso" name="buso">
									<option value="" <c:if test="${ct1010mVO.buso eq '' }">selected="selected"</c:if> >선택</option>								
									<option value="1001" <c:if test="${ct1010mVO.buso eq '1001' }">selected="selected"</c:if> >임상시험1팀</option>
									<option value="1002" <c:if test="${ct1010mVO.buso eq '1002' }">selected="selected"</c:if> >임상시험2팀</option>
									<option value="1003" <c:if test="${ct1010mVO.buso eq '1003' }">selected="selected"</c:if> >임상시험3팀</option>
									<option value="1004" <c:if test="${ct1010mVO.buso eq '1004' }">selected="selected"</c:if> >임상시험4팀</option>							
								</select>
							</td>
							<th scope="row" class="bl">직위</th>
							<td>
								<input type="text" value="<c:out value="${ct1010mVO.spot }" />"  class="input-data" id="spot" name="spot"/>
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