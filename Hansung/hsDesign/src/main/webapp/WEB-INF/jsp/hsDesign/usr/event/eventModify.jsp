<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>
	// 신청
	function fn_Insert(){
		//var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				
		if(!$("input:radio[name=eveNum]:checked").val()){
			alert("참가하실 행사를 선택해 주세요.");
			return false;
		}else if($("#eveName").val() == ''){
			alert("신청자명을 입력해주세요.");
			return false;
		}else if($("#eveTel1").val() == '' || $("#eveTel2").val() == '' || $("#eveTel3").val() == ''){
			alert("연락처를 입력해주세요.");
			 return false;
		}else if($("#eveEmail").val() == ''){
			alert("이메일을 입력해주세요.");
			 return false;
		}else if($("#eveDepoName").val() == ''){
			alert("입금자명을 입력해주세요.");
			 return false;
		}else if($("#eveDepoDate").val() == ''){
			alert("입금일자를 선택해주세요.");
			 return false;
		}else if(!$.trim($("#eveEmail").val()).match(regExp)){
			alert("이메일 형식에 맞지 않습니다. 다시 입력해주세요.");
			 return false;
		}else if($("#eveQues1").val() == '' || $("#eveQues2").val() == ''/* || $("#eveQues3").val() == '' || $("#eveQues4").val() == '' || $("#eveQues5").val() == '' */){
			alert("모든 설문조사를 입력해주세요.");
			return false;
		}else if($("#chkBox").is(":checked") == false){
			alert("상기 내용 동의를 확인해 주세요.");
			return false;
		}
		
		if(confirm("작성된 내용으로 신청하시겠습니까?\n신청한 내용은 조회가 불가능합니다.")){
			var radioId = $("input:radio[name=eveNum]:checked").attr("id");
			var eveEvname = $("label[for='"+radioId+"']").text();
			
			$("#eveEvname").val(eveEvname.trim());
			
			var acnm = $("#eveRefundAcnm").val();
			$("#eveRefundAcnm").val(acnm.replace("-", ""));
			
			$("#eveDepoDate").val($("#eveDepoDate").val() + " " + $("#hour").val() + ":" + $("#minute").val());
			
			$("#eveQues1").val($("#ques1").text()+"/"+$("#eveQues1").val());
			$("#eveQues2").val($("#ques2").text()+"/"+$("#eveQues2").val());
			$("#eveQues3").val($("#ques3").text()+"/"+$("#eveQues3").val());
			$("#eveQues4").val($("#ques4").text()+"/"+$("#eveQues4").val());
			$("#eveQues5").val($("#ques5").text()+"/"+$("#eveQues5").val());
			
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/event/eventInsert.do'/>").submit();
		}
	}
	
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
	
</script>
<body>
<form id="frm" name="frm">
	<input type="hidden" name="eveEvname" id="eveEvname"/>
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
		<!-- header area -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
		<!-- header area -->
		<div class="main_content" id="content">
			<div class="width_box">
				<!-- left menu area-->
				<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
				<!-- //left menu area-->
				<div class="sub_content">
					<!-- 타이틀 영역 -->
					<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
						<jsp:param name="dept1" value="행사"/>
			            <jsp:param name="dept2" value="크리에이터페스타 참가신청서"/>
		           	</jsp:include>
		           	<div class="top_tab type_li3 eve_tab">
						<ul>
							<li <c:if test="${sessionScope.menuNo eq '50901' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/event/eventModify.do'/>">행사참가신청</a></li>
							<li <c:if test="${sessionScope.menuNo eq '50902' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/event/eventExpo.do'/>">행사참가비확인</a></li>
							<li <c:if test="${sessionScope.menuNo eq '50903' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/event/eventCancel.do'/>">참가취소신청</a></li>
						</ul>
					</div>
					<div class="transform_table notice_type">
						<div class="tbl_write">
							<ul class="tbl_view_m">
								<li style="width: 100%; border: 1px solid #000000;">
									■ 일 시<br/>
									: 2018년 12월 30일 오전 11시 : 보이스토크 성우편 / 성우 강수진, 남도형<br/>
									: 2018년 12월 30일 오후 3시 : 보이스토크 크리에이터편 / 크리에이터 유준호, 엔조이커플<br/>
									■ 장 소<br/>
									: 한성대학교 낙산관 <br/>
									■ 입 장 료<br/>
									: 사전 예약(~12월24일 낮12시까지) 20,000원 (300명 선착순) / 카드결제 X<br/>
									: 본 예약, 현장 예매 30,000원 / 카드결제 X<br/>
									■ 신청기간<br/>
									: 2018년 12월 7일 (금) ~ 12월 23일 (일)<br/>
									<br/>
									■ 신청방법<br/>
									Step 1. [국민은행 938002-00-165239 이소권] 으로 입금(입금시 꼭 신청서의 입금자명과 같아야 합니다. 입금자명과 다를 경우 신청이 거절 될 수 도 있습니다.)<br/>
									Step 2. 아래 설문 내용을 기입하시고 "크리에이터페스타 참가 신청하기" 클릭(꼭 입금후 설문조사 해주세요!! 입금 선착순으로 진행 됩니다.)<br/>
									Step 3. [010-5529-1351] 로 참석자-입금자-연락처-이메일-입금했어요!! 라고 문자 보내주세요(문자 접수 전용 번호이라 전화 또는 카톡 하시면 절대 안돼요)<br/>
									(ex) 김철수-이영희-010-1234-5678-famousfaces@naver.com-입금했어요!!)<br/>
									<br/>
									- 입금확인 되면 확인문자 보내드립니다.<br/>
									- 좌석은 입금순서에 따라 앞자리부터 차례대로 배정이 됩니다.<br/>
									- 최종 전달사항은 행사 1주일 전에 문자 또는 메일로 전달 해드립니다.<br/>
									- 좌석번호는 당일 행사장에서 알려드립니다. 
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 참가행사명</li>
								<li>
									<input type="radio" name="eveNum" id="eveNum1" value="1"/><label for="eveNum1"> 보이스토크 성우편(성우 강수진, 남도형)</label><br/>
									<input type="radio" name="eveNum" id="eveNum2" value="2"/><label for="eveNum2"> 보이스토크 크리에이터편(크리에이터 엔조이커플, 유준호)</label>
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 참가자명</li>
								<li><input type="text" id="eveName" name="eveName"></li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 연락처</li>
								<li>
									<select id="eveTel1" name="eveTel1" style="min-width: 5%;">
										<option value="010">010</option>
										<option value="011">011</option>
									</select>
									&nbsp;-&nbsp;<input type="text" id="eveTel2" name="eveTel2" style="width: 50px;text-align: center;" onkeyup="removeChar(event)" maxlength="4">
									&nbsp;-&nbsp;<input type="text" id="eveTel3" name="eveTel3" style="width: 50px;text-align: center;" onkeyup="removeChar(event)" maxlength="4">
									&nbsp;(행사 당일 연락 가능한 연락처를 기입해주세요.)
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 이메일</li>
								<li><input type="text" id="eveEmail" name="eveEmail" style="width: 200px;"><span style="margin-left: 10px;">ex. example@naver.com</span></li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 입금자명</li>
								<li><input type="text" id="eveDepoName" name="eveDepoName" style="width: 200px;"></li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 환불 신청시 <br/>&nbsp;&nbsp;&nbsp;환불계좌</li>
								<li>
									은행명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;<!-- <input type="text" id="eveRefundBank" name="eveRefundBank" style="width: 100px;"> -->
									<select id="eveRefundBank" name="eveRefundBank" style="min-width: 50px;">
										<option value="국민">국민</option>
										<option value="신한">신한</option>
										<option value="농협">농협</option>
										<option value="우리">우리</option>
										<option value="하나">하나</option>
										<option value="외환">외환</option>
										<option value="기업">기업</option>
										<option value="카카오뱅크">카카오뱅크</option>
										<option value="새마을">새마을</option>
										<option value="우체국">우체국</option>
									</select><br/>
									계좌번호&nbsp;&nbsp;:&nbsp;&nbsp;<input type="text" id="eveRefundAcnm" name="eveRefundAcnm" style="width: 200px;">(계좌번호는 ‘-’ 없이 입력해주세요.)
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 입금날짜 및 시간</li>
								<li>
									<input type="text" id="eveDepoDate" name="eveDepoDate" class="datepicker" style="width: 90px;text-align: center;" readonly="readonly"/>&nbsp;&nbsp;
									<select id="hour" name="hour"  style="width: 50px;min-width: 50px;">
											<c:forEach var="i" begin="0" end="23" >
												<option value="<c:out value="${i}"/>">
													<c:out value="${i}"/>
												</option>
											</c:forEach>
									</select> 시
									<select id="minute" style="width: 50px;min-width: 50px;">
											<c:forEach var="i" begin="0" end="59" >
												<option value="<c:out value="${i}"/>">
													<c:out value="${i}"/>
												</option>
											</c:forEach>
									</select> 분
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li style="width: 100%;">
									■ 설문조사<br/>
									설문조사 꼭 부탁드립니다. 설문조사는 당일 행사 2부때 참가자들의 질문 및 고민을 성우분들과 mc분들이 함께 하는 시간을 갖습니다. 
									익명으로 제출시 문장앞에 ＜익명＞이라고 적어주세요.(차후 익명 실명 전환이 불가합니다. 잘 생각하시고 적어주세요^^). 
									성우 또는 크리에이터에 대한 내용이 아니어도 됩니다. 너무 흔한 질문의 경우 채택확률이 낮습니다. 
									게스트 개인에게 질문하고 싶은 경우 앞에 게스트 성함을 적어주세요 <br/>ex) ＜남도형＞, ＜엔조이커플＞
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li style="width: 98%;">
									<a id="ques1">- 현재 가지고 있는 고민은 무엇인가요?</a><br/>
									<textarea id="eveQues1" name="eveQues1" rows="10" cols="auto" style="width: 100%;"></textarea>
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li style="width: 98%;">
									<a id="ques2">- 게스트에게 궁금한 점은 무엇인가요?</a><br/>
									<textarea id="eveQues2" name="eveQues2" rows="10" cols="auto" style="width: 100%;"></textarea>
								</li>
							</ul>
							<!-- <ul class="tbl_view_m">
								<li style="width: 98%;">
									<a id="ques3">설문조사 3. test</a><br/>
									<textarea id="eveQues3" name="eveQues3" rows="5" cols="auto" style="width: 100%;"></textarea>
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li style="width: 98%;">
									<a id="ques4">설문조사 4. test</a><br/>
									<textarea id="eveQues4" name="eveQues4" rows="5" cols="auto" style="width: 100%;"></textarea>
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li style="width: 98%;">
									<a id="ques5">설문조사5. test</a><br/>
									<textarea id="eveQues5" name="eveQues5" rows="5" cols="auto" style="width: 100%;"></textarea>
								</li>
							</ul> -->
							<ul class="tbl_view_m">
								<li style="width: 100%; border: 1px solid #000000;">
									■ 공지 관련된 내용은 현재 등록해 주시는 성함, 연락처, 메일로 전달 됩니다. 잘못된 정보로 기입 되어있을경우 참석이 불가 할 수도 있습니다.<br/>
									■ 12월 23일(일) 낮 12시 이전에 취소건은 100% 환불이 가능하며, 12시 이후는 취소 및 환불이 불가하니 참고하시길 바랍니다.<br/>
									■ 설문조사 꼭 부탁드립니다. 설문조사는 당일 행사 2부때 참가자들의 질문 및 고민을 성우분들과 mc분들이 함께 하는 시간을 갖습니다.<br/>
									■ 당일 주최측 사진, 영상 촬영이 될 예정입니다. 참가자들이 노출 될 수 있습니다. 참고 하시길 바랍니다.<br/>
									■ 당일 현장에서 사진촬영 및 영상촬영은 불가능 합니다.  촬영 및 업로드시 문제 되는 법적인 책임은 본인에게 있습니다.
								</li>
							</ul>
							<div align="center"><input type="checkbox" id="chkBox" ><label for="chkBox" style="margin-left: 4px;"> 상기 내용에 동의합니다.</label></div>
						</div>
					</div>
					<div class="btn_box">
						<a href="#" class="btn_go_list" onclick="fn_Insert(); return false;" style="width: 230px;">크리에이터페스타 참가 신청하기</a>
					</div>

					<!-- rolling banner -->
					<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
					<!-- //rolling banner -->
				</div>
			</div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!--// footer -->
	</div>
<input type="hidden" id="message" value="${message}" />
</form>
</body>
<style>
	.experCoure li label{margin-left: 4px;}
</style>

</html>