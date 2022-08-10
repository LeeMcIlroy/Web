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
	function fn_ExpoChk(){
		
		if(!$("input:radio[name=eveNum]:checked").val()){
			alert("신청하신 행사를 선택해 주세요.");
			return false;
		}else if($("#eveName").val() == ''){
			alert("신청자명을 입력해주세요.");
			return false;
		}else if($("#eveTel1").val() == '' || $("#eveTel2").val() == '' || $("#eveTel3").val() == ''){
			alert("연락처를 입력해주세요.");
			 return false;
		}else if($("#chkBox").is(":checked") == false){
			alert("상기 내용 동의를 확인해 주세요.");
			return false;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/event/eventCancelChk.do'/>").submit();
	}
	
</script>
<body>
<form id="frm" name="frm">
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
			            <jsp:param name="dept2" value="크리에이터페스타 취소신청"/>
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
								<li class="txt_left w100p " style="width: 150px;">* 참가행사명</li>
								<li>
									<input type="radio" name="eveNum" id="eveNum1" value="1"/><label for="eveNum1"> 보이스토크 성우편(성우 강수진, 남도형)</label><br/>
									<input type="radio" name="eveNum" id="eveNum2" value="2"/><label for="eveNum2"> 보이스토크 크리에이터편(크리에이터 엔조이커플, 유준호)</label>
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 참석자명</li>
								<li><input type="text" id="eveName" name="eveName"></li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 연락처</li>
								<li>
									<select id="eveTel1" name="eveTel1" style="min-width: 5%;">
										<option value="010">010</option>
										<option value="011">011</option>
									</select>
									&nbsp;-&nbsp;<input type="text" id="eveTel2" name="eveTel2" style="width: 50px;text-align: center;" maxlength="4">
									&nbsp;-&nbsp;<input type="text" id="eveTel3" name="eveTel3" style="width: 50px;text-align: center;" maxlength="4">
								</li>
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
								<li style="width: 100%; border: 1px solid #000000;">
									■ 12월 24일 (월) 낮 12시 이전에 취소 건은 100% 환불이 가능하며, 낮 12시 이후부터는 취소 및 환불이 불가하니 참고하시길 바랍니다.<br/>
									■ 취소하실 경우 재신청이 불가합니다.<br/>
									■ 12월 16일 (일)까지 취소 신청하실 경우, 12월 19일 (수)에 일괄 입금 처리됩니다.<br/>
									■ 12월 24일 (월) 낮 12시까지 취소 신청하실 경우, 12월 26일 (수)에 일괄 입금 처리됩니다.
								</li>
							</ul>
							<div align="center"><input type="checkbox" id="chkBox" ><label for="chkBox" style="margin-left: 4px;"> 상기 내용에 동의합니다.</label></div>
						</div>
					</div>
					<div class="btn_box">
						<a href="#" class="btn_go_list" onclick="fn_ExpoChk(); return false;" style="width: 230px;">크리에이터페스타 취소 신청하기</a>
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