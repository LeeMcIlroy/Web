<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>

<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>

<script>
		function closeLayer( obj ) {
			$(obj).parent().parent().hide();
		}

		$(function(){

			/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
			$('.imgSelect').click(function(e)
			{
				var sWidth = window.innerWidth;
				var sHeight = window.innerHeight;

				var oWidth = $('.popupLayer').width();
				var oHeight = $('.popupLayer').height();

				// 레이어가 나타날 위치를 셋팅한다.
				var divLeft = e.clientX + 10;
				var divTop = e.clientY + 5;

				// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
				if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
				if( divTop + oHeight > sHeight ) divTop -= oHeight;

				// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
				if( divLeft < 0 ) divLeft = 0;
				if( divTop < 0 ) divTop = 0;

				$('.popupLayer').css({
					"top": divTop,
					"left": divLeft,
					"position": "absolute"
				}).show();
			});

		});

		// 관리자 비밀번호 변경
		function fn_modify_pw(){
			var pw1 = $("#pw1").val();
			var pw2 = $("#pw2").val();
			var pw3 = $("#pw3").val();
			var num = pw2.search(/[0-9]/g);
			var eng = pw2.search(/[a-z]/ig);
			var spe = pw2.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
			
			if(pw1 == ''){
				alert('비밀번호를 입력해주세요.');
				$("#pw1").focus();
				return;
			}
			else if($("#pwChkTxt").hasClass('dpn')){
				alert('현재 비밀번호가 일치하지 않습니다.');
				$("#pw1").focus();
				return;
			}
			else if(pw2 == ''){
				alert('비밀번호를 입력해주세요.');
				$("#pw2").focus();
				return;
			}
			else if(pw3 == ''){
				alert('비밀번호를 입력해주세요.');
				$("#pw3").focus();
				return;
			}
			else if(pw2 != pw3){
				alert('비밀번호가 일치하지 않습니다.');
				$("#pw3").focus();
				return;
				
			}
			else if(pw2.length < 8 || num < 0 || eng < 0 || spe < 0){
				alert('비밀번호는 영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.');
				$("pw2").focus();
				return;
			}		
			else{
				$("#detailForm").attr("action", "<c:url value= '/qxsepmny/oper/admAjaxPasswordUpdate.do'/>").submit();
				alert('변경 되었습니다.');
			}
			
		
		};
		
		function fn_cancel(){
			$("#detailForm").attr("action", "<c:url value= '/qxsepmny/oper/admAdminProfileView.do'/>").submit();
			alert('취소 되었습니다.');
		};
		
	
		
		// 현재 비밀번호 유효성 검사
		function fn_pwChk(ele){
			var adminPw = $(ele).val();
			
			$.ajax({
				url: "<c:url value='/qxsepmny/oper/admAjaxAdminPwChk.do'/>"
				, type: "post"
				, data: "adminPw="+adminPw
				, dataType: "json"
				, success: function(data){
					var status = data.status;
					console.log(status);
					if(status){
							$("#pwChkTxt").removeClass('dpn');
							$("#pwChkTxt2").addClass('dpn');
							$("#pwChk").val('Y');
					}else{
							$("#pwChkTxt").addClass('dpn');
							$("#pwChkTxt2").removeClass('dpn');
							$("#pwChk2").val('N');
					}
				},error: function(){
					
				}
			});
		};
		
		// 새 비밀번호 변경 유효성검사
		$(function(){
			$("#alert-pw-guide").removeClass('dpn');
			$("#alert-danger").addClass('dpn');
			$("#alert-success_1").addClass('dpn');
			$("#alert-success_2").addClass('dpn');
			$("#alert-danger_1").addClass('dpn');
			$("#alert-pw-check").addClass('dpn');
			$("#alert-pw-check_1").addClass('dpn');

			$("input").keyup(function(){
				var pw2 = $("#pw2").val(); // 새 비밀번호
				var pw3 = $("#pw3").val(); // 새비밀번호 확인
				var num = pw2.search(/[0-9]/g);
				var eng = pw2.search(/[a-z]/ig);
				var spe = pw2.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
				
				if(pw2 == ""){
					$("#alert-pw-guide").removeClass('dpn');
					$("#alert-pw-check").addClass('dpn');
					$("#alert-success_1").addClass('dpn');
					$("#alert-success_2").addClass('dpn');
					$("#alert-danger_1").addClass('dpn');
					$("#alert-pw-check_1").addClass('dpn');
				}
				
				// 비밀번호 영문,숫자,특수문자 조합 8자리 이상 체크
				else{
				
				 if(pw2.length < 8 || num < 0 || eng < 0 || spe < 0){
					$("#alert-pw-check").removeClass('dpn');
					$("#alert-pw-guide").addClass('dpn');
					$("#alert-success_1").addClass('dpn');
					$("#alert-success_2").addClass('dpn');
					$("#submit").attr("disabled", "disabled");
					return false;
				
				 }else{
					 $("#alert-success_1").removeClass('dpn');
					 $("#alert-pw-check").addClass('dpn');
					 $("#alert-pw-guide").addClass('dpn');
				 }
				}
				
				if(pw3 == ""){
					$("#alert-pw-check").addClass('dpn');
					$("#alert-pw-check_1").addClass('dpn');
					$("#alert-success_2").addClass('dpn');
					$("#alert-danger_1").addClass('dpn');
				}
				else{
					if(pw2 != pw3){
					$("#alert-danger_1").removeClass('dpn');
					$("#alert-pw-check_1").addClass('dpn');
					$("#alert-success_2").addClass('dpn');
					$("#submit").attr("disabled", "disabled");
					return false;
					}
					else{
						$("#alert-success_2").removeClass('dpn');
						$("#alert-danger_1").addClass('dpn');
						$("#alert-pw-check").addClass('dpn');
						$("#alert-pw-check_1").addClass('dpn');
						$("#alert-pw-guide").addClass('dpn');
						$("#submit").removeAttr("disabled");
					}
				}

			});
			
		});
		

		

</script>
<body>

	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<!--// left menu -->
			<div class="main-content">
			<form:form commandName="adminVO" id="detailForm" name="detailForm">
				<form:hidden path="adminId" value="${adminVO.adminId }"/>
				<div class="title-area">
					<p class="page-lv01">Profile</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>마이페이지</span>
						<span>Profile</span>
					</div>
				</div>

				<div class="tab-box">
					<input id="tab1" type="radio" name="tabs" checked="">
					<input id="tab2" type="radio" name="tabs">

					<div class="tab-btn">
						<label for="tab1" class="tab1">기본정보</label>
						<label for="tab2" class="tab2">비밀번호변경</label>
					</div>

					<div id="content1">
						<!-- table -->
						<div class="list-table-box web">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:10%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>아이디</th>
										<td>
											<c:out value="${adminVO.adminId }"/>
										</td>
									</tr>
									<tr> 
										<th>이름</th>
										<td>
											<c:out value="${adminVO.name }"/>
										</td>
									</tr>
									<tr>
										<th>소속</th>
										<td>
											<c:out value="${adminVO.depart }"/>
										</td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td>
										<c:if test="${adminVO.useYn  eq 'Y'}">
											사용
										</c:if>
										<c:if test="${adminVO.useYn  eq 'N'}">
											중지
										</c:if>
										</td>
									</tr>
									<tr> 
										<th>사용자구분</th>
										<td>
										<c:if test="${adminVO.adminType  eq '1'}">
											관리자
										</c:if>
										<c:if test="${adminVO.adminType  eq '2'}">
											사용자
										</c:if>
										</td>
									</tr>
									<tr>
										<th>최근접속일시</th>
										<td>
											<c:out value="${adminVO.loginDateTime}"/>
										</td>
									</tr>
									<tr>
										<th>권한</th>
										<td>
										<c:if test="${adminVO.entran  eq 'Y'}">
											입학,
										</c:if>
										<c:if test="${adminVO.regist  eq 'Y'}">
											등록,
										</c:if>
										<c:if test="${adminVO.student  eq 'Y'}">
											학생,
										</c:if>
										<c:if test="${adminVO.clss  eq 'Y'}">
											수업,
										</c:if>
										<c:if test="${adminVO.admstr  eq 'Y'}">
											행정,
										</c:if>
										<c:if test="${adminVO.stat  eq 'Y'}">
											현황통계,
										</c:if>
										<c:if test="${adminVO.oper  eq 'Y'}">
											교육과정,
										</c:if>
										<c:if test="${adminVO.curr  eq 'Y'}">
											운영
										</c:if>
										
										
											
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table -->

					</div>

					<div id="content2">
						<div class="list-table-box web">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:15%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th><sup>*</sup>현재 비밀번호</th>
										<td>
											<input  type="password" id="pw1" class="input-data" placeholder="현재 비밀번호를 입력해주세요" onkeyup="fn_pwChk(this); return false;"/>
											<span class="alt-txt dpn" id="pwChkTxt">비밀번호가 일치합니다.</span>
											<input type="hidden" id="pwChk" value="Y"/>
											<span class="alt-txt dpn" id="pwChkTxt2">비밀번호가 일치하지 않습니다.</span>
											<input type="hidden" id="pwChk2" value="N"/>
										</td>

									</tr>
									<tr>
										<th><sup>*</sup>새 비밀번호</th>
										<td>
											<input type="password" id="pw2" name="adminPw" class="input-data" placeholder="영문,숫자, 특수문자를 혼합하여 8자리 이상" />
											<span class="alt-txt dpn" id="alert-pw-guide">영문,숫자,특수문자 조합으로 8자 이상 설정</span>
											<span class="alt-txt dpn" id="alert-pw-check">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.</span>
											<!-- <span class="alt-txt" id="alert-pw-space-check" >비밀번호는 공백없이 입력해주세요.</span> -->
											<span class="ok-signature dpn" id="alert-success_1">O.K</span>
										</td>
									</tr>
									<tr> 
										<th><sup>*</sup>새 비밀번호 확인</th>
										<td>
											<input type="password" id="pw3" class="input-data" placeholder="비밀번호 확인"/>
											<span class="alt-txt dpn" id="alert-danger_1">비밀번호가 일치하지 않습니다.</span>
											<span class="alt-txt dpn" id="alert-pw-check_1">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.</span>
											<span class="ok-signature dpn" id="alert-success_2">O.K</span>
										</td>
									</tr>
									<tr>
										<th>최종변경일</th>
										<td>
											<c:out value="${adminVO.updDate}"/>
										</td>
									</tr>
									<tr>
										<th>변경작업IP</th>
										<td>
											<c:out value="${clientIp}"/>
											
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="table-button">
							<div class="btn-box">
								<button type="button" class="white btn-save" onclick="fn_modify_pw(); return false;">저장</button>
								<button type="button" class="white btn-cancel" onclick="fn_cancel(); return false;">취소</button>
								
							</div>
						</div>
					</div>
				</div>
				</form:form>
			</div>
		</div>
	</div>

	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

</body>
</html>