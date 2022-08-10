<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>

<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

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

			if($("#lap").val() == "Y"){
				$("#tab2").prop("checked", true)
			}
		});
		
		// 교사 프로필 저장
		function fn_modify(){
			$("#emailAddr").removeAttr('disabled');
			$("#detailForm").attr("action", "<c:url value= '/usr/lec/myPage/lecProfileUpdate.do'/>").submit();
			alert('변경 되었습니다.');
		}
		
		// 교사 비밀번호 변경
		function fn_modify_pw(){
			var pw1 = '';
			var pw2 = '';
			var pw3 = '';
			
			var typ = $(".mob").css("display");
			
			if(typ == 'none'){
				pw1 = $("#pw1").val();
				pw2 = $("#pw2").val();
				pw3 = $("#pw3").val();
			}else{
				pw1 = $("#pw4").val();
				pw2 = $("#pw5").val();
				pw3 = $("#pw6").val();
			}
			
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
				$("#detailForm").attr("action", "<c:url value= '/usr/lec/myPage/lecAjaxPasswordUpdate.do'/>").submit();
				alert('변경 되었습니다.');
			}
			
		
		};
		
		function fn_cancel(){
			$("#detailForm").attr("action", "<c:url value= '/usr/lec/myPage/lecNoticeList.do'/>").submit();
			alert('취소 되었습니다.');
		};
		
		function fn_mailaddr(ele){
			var addr = $(ele).val();
			
			if(addr != ''){
				$("#emailAddr").attr('disabled','true');
			}else{
				$("#emailAddr").removeAttr('disabled');
			}
			$("#emailAddr").val(addr);
		};
		
		
		// 현재 비밀번호 유효성 검사
		function fn_pwChk(ele){
			var memberPw = $(ele).val();
			
			$.ajax({
				url: "<c:url value='/usr/lec/myPage/admAjaxMemberPwChk.do'/>"
				, type: "post"
				, data: "memberPw="+memberPw
				, dataType: "json"
				, success: function(data){
					var status = data.status;
					console.log(status);
					if(status){
							$("#pwChkTxt").removeClass('dpn');
							$("#pwChkTxt2").addClass('dpn');
							$("#pwChkTxt3").removeClass('dpn');
							$("#pwChkTxt4").addClass('dpn');
							$("#pwChk").val('Y');
							$("#pwChk3").val('Y');
					}else{
							$("#pwChkTxt").addClass('dpn');
							$("#pwChkTxt2").removeClass('dpn');
							$("#pwChkTxt3").addClass('dpn');
							$("#pwChkTxt4").removeClass('dpn');
							$("#pwChk2").val('N');
							$("#pwChk4").val('N');
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
			
			$("#alert-pw-guide1").removeClass('dpn');
			$("#alert-danger").addClass('dpn');
			$("#alert-success_3").addClass('dpn');
			$("#alert-success_4").addClass('dpn');
			$("#alert-danger_2").addClass('dpn');
			$("#alert-pw-check3").addClass('dpn');
			$("#alert-pw-check_4").addClass('dpn');

			$("input").keyup(function(){
				var pw2 = '';
				var pw3 = '';
				var typ = $(".mob").css("display");
				
				if(typ == 'none'){
					pw2 = $("#pw2").val(); // 새 비밀번호
					pw3 = $("#pw3").val(); // 새비밀번호 확인
				}else{
					pw2 = $("#pw5").val(); // 새 비밀번호
					pw3 = $("#pw6").val(); // 새비밀번호 확인
				}
				
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
					
					$("#alert-pw-guide1").removeClass('dpn');
					$("#alert-pw-check3").addClass('dpn');
					$("#alert-success_3").addClass('dpn');
					$("#alert-success_4").addClass('dpn');
					$("#alert-danger_2").addClass('dpn');
					$("#alert-pw-check_4").addClass('dpn');
				}
				
				// 비밀번호 영문,숫자,특수문자 조합 8자리 이상 체크
				else{
				
				 if(pw2.length < 8 || num < 0 || eng < 0 || spe < 0){
					$("#alert-pw-check").removeClass('dpn');
					$("#alert-pw-guide").addClass('dpn');
					$("#alert-success_1").addClass('dpn');
					$("#alert-success_2").addClass('dpn');
					$("#submit").attr("disabled", "disabled");
					
					$("#alert-pw-check3").removeClass('dpn');
					$("#alert-pw-guide1").addClass('dpn');
					$("#alert-success_3").addClass('dpn');
					$("#alert-success_4").addClass('dpn');
					return false;
				
				 }else{
					 $("#alert-success_1").removeClass('dpn');
					 $("#alert-pw-check").addClass('dpn');
					 $("#alert-pw-guide").addClass('dpn');
					 
					 $("#alert-success_3").removeClass('dpn');
					 $("#alert-pw-check3").addClass('dpn');
					 $("#alert-pw-guide1").addClass('dpn');
				 }
				}
				
				if(pw3 == ""){
					$("#alert-pw-check").addClass('dpn');
					$("#alert-pw-check_1").addClass('dpn');
					$("#alert-success_2").addClass('dpn');
					$("#alert-danger_1").addClass('dpn');
					
					$("#alert-pw-check3").addClass('dpn');
					$("#alert-pw-check_4").addClass('dpn');
					$("#alert-success_4").addClass('dpn');
					$("#alert-danger_2").addClass('dpn');
				}
				else{
					if(pw2 != pw3){
					$("#alert-danger_1").removeClass('dpn');
					$("#alert-pw-check_1").addClass('dpn');
					$("#alert-success_2").addClass('dpn');
					$("#submit").attr("disabled", "disabled");
					
					$("#alert-danger_2").removeClass('dpn');
					$("#alert-pw-check_4").addClass('dpn');
					$("#alert-success_4").addClass('dpn');
					return false;
					}
					else{
						$("#alert-success_2").removeClass('dpn');
						$("#alert-danger_1").addClass('dpn');
						$("#alert-pw-check").addClass('dpn');
						$("#alert-pw-check_1").addClass('dpn');
						$("#alert-pw-guide").addClass('dpn');
						$("#submit").removeAttr("disabled");
						
						$("#alert-success_4").removeClass('dpn');
						$("#alert-danger_2").addClass('dpn');
						$("#alert-pw-check3").addClass('dpn');
						$("#alert-pw-check_4").addClass('dpn');
						$("#alert-pw-guide1").addClass('dpn');
					}
				}

			});
			
		});
		

		

</script>
<body>

	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
			<form:form commandName="usrVO" id="detailForm" name="detailForm">
			<form:hidden path="memberSeq" value="${usrVO.memberSeq }"/>
			<form:hidden path="memberCode" value="${usrVO.memberCode }"/>
			<input type="hidden" id="lap" value="${lap }"/>
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
											<c:out value="${usrVO.memberCode }"/>
										</td>
									</tr>
									<tr>
										<th>이름</th>
										<td>
											<c:out value="${usrVO.name }"/>
										</td>
									</tr>
									<tr>
										<th>생년월일</th>
										<td>
											<c:out value="${usrVO.birth }"/>
										</td>
									</tr>
									<tr>
										<th>상태</th>
										<td>
											<c:out value="${usrVO.useYn}"/>
										</td>
									</tr>
									<tr> 
										<th>권한</th>
										<td>
											<c:out value="${lectSession.lectYear }"/>-<c:out value="${lectSession.lectSem eq '1'?'봄학기':lectSession.lectSem eq '2'?'여름학기':lectSession.lectSem eq '3'?'가을학기':'겨울학기' }"/>-<c:if test="${lectSession.lectName ne '한국어과정' }"><c:out value="${lectSession.lectName }"/>급-</c:if><c:if test="${lectSession.lectName eq '한국어과정' }"><c:out value="${lectSession.lectName }"/></c:if>-<c:out value="${lectSession.lectDivi }"/>
										</td>
									</tr>
									<tr>
										<th>최초등록일시</th>
										<td>
											<c:out value="${usrVO.regDate}"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table -->
						 <div class="mob">
							<div class="mob-list">
								<div class="mob-list-type">
									<dl>
										<dt>아이디</dt>
										<dd><c:out value="${usrVO.memberCode }"/></dd>
									</dl>
									<dl>
										<dt>이름</dt>
										<dd><c:out value="${usrVO.name }"/></dd>
									</dl>
									<dl>
										<dt>생년월일</dt>
										<dd><c:out value="${usrVO.birth }"/></dd>
									</dl>
									<dl>
										<dt>상태</dt>
										<dd><c:out value="${usrVO.useYn}"/></dd>
									</dl>
									<dl>
										<dt>권한</dt>
										<dd><c:out value="${lectSession.lectYear }"/>-<c:out value="${lectSession.lectSem eq '1'?'봄학기':lectSession.lectSem eq '2'?'여름학기':lectSession.lectSem eq '3'?'가을학기':'겨울학기' }"/>-<c:if test="${lectSession.lectName ne '한국어과정' }"><c:out value="${lectSession.lectName }"/>급-</c:if><c:if test="${lectSession.lectName eq '한국어과정' }"><c:out value="${lectSession.lectName }"/></c:if>-<c:out value="${lectSession.lectDivi }"/></dd>
									</dl>
									<dl>
										<dt>최초등록일시</dt>
										<dd><c:out value="${usrVO.regDate}"/></dd>
									</dl>
								</div>
							</div>
						</div>

						<p class="sub-title">정보수정</p>
						<!-- table -->
						<div class="list-table-box web">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:10%;" />
									<col style="width:40%;" />
									<col style="width:10%;" />
									<col />
								</colgroup>
								<tbody>
								<tr>
									<td>주소</td>
									<td colspan="3">
										<ul>
											<li class="mb5"><form:input path="post" class="input-data w100px" /> <a href="#" onclick="execDaumPostcode(); return false;"  class="normal-btn">우편번호검색</a></li>
											<li>
												<form:input path="addr1" class="input-data w49pc" />
												<form:input path="addr2" class="input-data w49pc" />
											</li>
										</ul>
									</td>
								</tr>
									<tr>
										<th>전화번호</th>
											<td>
												<form:input path="tel1" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> -
												<form:input path="tel2" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
												<form:input path="tel3" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
											</td>
										<th>휴대폰번호</th>
											<td>
												<form:input path="mobile1" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> -
												<form:input path="mobile2" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
												<form:input path="mobile3" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
											</td>
									</tr>
									<tr>
										<th>e-mail</th>
										<td colspan="3">
										<form:input path="emailId" class="input-data w100px" /> @
										<form:input path="emailAddr" class="input-data w100px" disabled="true"/>
										<select onchange="fn_mailaddr(this); return false;">
											<option value="hansung.ac.kr">hansung.ac.kr</option>
											<option value="naver.com">naver.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="">직접입력</option>
										</select>
									</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table -->

						<div class="mob mb20">
							<div class="mob-write">
								<dl>
									<dt>주소</dt>
									<dd>
										<ul>
											<li class="mb5"><form:input path="post" class="input-data w100px" /> <a href="#" onclick="execDaumPostcode(); return false;"  class="normal-btn">우편번호검색</a></li>
											<li>
												<form:input path="addr1" class="input-data w49pc" />
												<form:input path="addr2" class="input-data w49pc" />
											</li>
										</ul>
									</dd>
								</dl>
								<dl>
									<dt>전화번호</dt>
									<dd>
										<form:input path="tel1" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> -
										<form:input path="tel2" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
										<form:input path="tel3" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
									</dd>
								</dl>
								<dl>
									<dt>휴대폰번호</dt>
									<dd>
										<form:input path="mobile1" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> -
										<form:input path="mobile2" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
										<form:input path="mobile3" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
									</dd>
								</dl>
								<dl>
									<dt>e-mail</dt>
									<dd>
										<form:input path="emailId" class="input-data w100px" /> @
										<form:input path="emailAddr" class="input-data w100px" disabled="true"/>
										<select onchange="fn_mailaddr(this); return false;">
											<option value="hansung.ac.kr">hansung.ac.kr</option>
											<option value="naver.com">naver.com</option>
											<option value="gmail.com">gmail.com</option>
											<option value="">직접입력</option>
										</select>
									</dd>
								</dl>
							</div>
						</div>


						<div class="table-button">
							<div class="btn-box">
								<button type="button" class="white btn-save" onclick="fn_modify(); return false;">저장</button>
							</div>
						</div>
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
											<input type="password" id="pw2" name="memberPw" class="input-data" placeholder="영문,숫자, 특수문자를 혼합하여 8자리 이상" />
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
											<c:out value="${usrVO.updDate}"/>
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
						<div class="mob mb20">
							<div class="mob-write w-dt130">
								<dl>
									<dt><sup>*</sup>현재 비밀번호</dt>
									<dd>
										<ul>
											<li>
												<input  type="password" id="pw4" class="input-data" placeholder="현재 비밀번호를 입력해주세요" onkeyup="fn_pwChk(this); return false;"/>
												<span class="alt-txt dpn" id="pwChkTxt3">비밀번호가 일치합니다.</span>
												<input type="hidden" id="pwChk3" value="Y"/>
												<span class="alt-txt dpn" id="pwChkTxt4">비밀번호가 일치하지 않습니다.</span>
												<input type="hidden" id="pwChk4" value="N"/>
											</li>
										</ul>
									</dd>
								</dl>
								<dl>
									<dt><sup>*</sup>새 비밀번호</dt>
									<dd>
										<input type="password" id="pw5" name="memberPw" class="input-data" placeholder="영문,숫자, 특수문자를 혼합하여 8자리 이상" />
										<span class="alt-txt dpn" id="alert-pw-guide1">영문,숫자,특수문자 조합으로 8자 이상 설정</span>
										<span class="alt-txt dpn" id="alert-pw-check3">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.</span>
										<span class="ok-signature dpn" id="alert-success_3">O.K</span>
									</dd>
								</dl>
								<dl>
									<dt><sup>*</sup>새 비밀번호 확인</dt>
									<dd>
										<input type="password" id="pw6" class="input-data" placeholder="비밀번호 확인"/>
										<span class="alt-txt dpn" id="alert-danger_2">비밀번호가 일치하지 않습니다.</span>
										<span class="alt-txt dpn" id="alert-pw-check_4">영문,숫자,특수문자 조합으로 8자 이상이어야 합니다.</span>
										<span class="ok-signature dpn" id="alert-success_4">O.K</span>
									</dd>
								</dl>
								<dl>
									<dt>최종변경일</dt>
									<dd>
										<c:out value="${usrVO.updDate}"/>
									</dd>
								</dl>
								<dl>
									<dt>변경작업IP</dt>
									<dd>
										<c:out value="${clientIp}"/>
									</dd>
								</dl>
							</div>
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
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<!-- 주소찾기 -->
		<div class="modi-popup" id="addrPop">
		</div>
		<!--// 주소찾기 -->
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->
	

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->

</body>
</html>