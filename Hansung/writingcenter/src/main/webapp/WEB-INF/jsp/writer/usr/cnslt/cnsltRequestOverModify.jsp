<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	$(function(){
		$("input:radio[name=overAns1]").click(function(){
			if($("input:radio[name=overAns1]:checked").val() == '0'){
				$("#overAns1Txt").prop("disabled", "");
			}else{
				$("#overAns1Txt").prop("disabled", "true");
			}
		});
		
		$("input:checkbox[name^=overAns2]").click(function(){
			if($("input:checkbox[name=overAns2F]").is(":checked")){
				$("#overAns2Txt").prop("disabled", "");
			}else{
				$("#overAns2Txt").val("");
				$("#overAns2Txt").prop("disabled", "true");
			}
		});
		
		
		// 파일업로드 조건 확인
		$(document).on("change", "input:file", function(){
			var fileSize = -1;
			if(this.files.length > 0){
				fileSize = this.files[0].size;
				fileCheck(this.id, fileSize);
			}
		});
		
		
	});
	
	// 상담연구원 검색
	function fn_cnsltSchedule_list(){
		var date = new Date();
		var year = date.getFullYear();
		var month = new String(date.getMonth()+1);
		var day = new String(date.getDate());
		nowDate = year + '-' + ((month.length == 1)? "0"+month : month) + '-' + ((day.length == 1)? "0"+day : day);
		
		if($("#schYmd").val() == ''){
			alert("일자를 선택해주세요.");
			return false;
		}else if($("#schYmd").val() < nowDate){
			alert("오늘날짜 이후의 날을 선택해주세요.");			
			return false;
		}
		$.ajax({
			url: "<c:out value='${pageContext.request.contextPath }/usr/cnslt/cnsltScheduleListAjax.do'/>"
			, type: "post"
			, data: {
				schYmd : $("#schYmd").val()
			}
			, dataType:"json"
			, success: function(data){
				scheduleListVO = data.scheduleListVO;				
				console.log(scheduleListVO);
				$("#schSeq > *").remove();
				$("#schSeq").append("<option value=''>선택</option>");
				
				if(scheduleListVO.length == 0){
					alert("선택한 일자에는 상담일정이 없습니다. 다른 일자를 선택해주세요.");
					return false;
				}else{
					alert("상담연구원을 선택해 주세요");
					
				}
				
				$.each(scheduleListVO, function(i, result){
					var tags = '';
					tags += '<option value="'+result.schSeq+'">'+result.schHm+'('+result.regName+')</option>';
					$("#schSeq").append(tags);
				});
				
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	/*
	// 일자 선택
	function fn_cnsltSchedule_popup(){
		window.open("<c:out value='${pageContext.request.contextPath }/EgovPageLink.do?link=usr/cnslt/cnsltRequestSchdulPopup'/>", "cnsltRequestSchdulPopup", "width=626,height=436");
	}
	*/
	
	// 상담신청
	function fn_update(){
		if($("#aplyGrade").val() == ''){
			alert("학년을 선택해주세요.");
			return false;
		}else if($("#aplyDept").val() == ''){
			alert("학과를 입력해주세요.");
			return false;
		}else if($("#aplyHakbun").val() == ''){
			alert("학번을 입력해주세요.");
			return false;
		}else if($("#aplyName").val() == ''){
			alert("성명을 입력해주세요.");
			return false;
		}else if($("#aplyMphone2").val() == '' || $("#aplyMphone3").val() == ''){
			alert("휴대폰번호를 입력해주세요.");
			return false;
		}else if(!$("input:radio[name=overAns1]").is(":checked")){
			alert("상담 대상 글의 1번 질문을 선택해주세요.");
			return false;
		}else if($("input:radio[name=overAns1]:checked").val() == '0' && $("#overAns1Txt").val() == ''){
			alert("상담 대상 글의 1번 질문 기타 내용을 입력해주세요.");
			return false;
		}else if(!$("input:checkbox[name^=overAns2]").is(":checked")){
			alert("상담 대상 글의 2번 질문을 선택해주세요.");
			return false;
		}else if(!$("input:radio[name=overAns3]").is(":checked")){
			alert("상담 대상 글의 3번 질문을 선택해주세요.");
			return false;
		}else if(!$("input:radio[name=tans1]").is(":checked")){
			alert("상담 받을 글 관련 강좌의 1번 질문을 선택해주세요.");
			return false;
		}else if(!$("input:radio[name=tans2]").is(":checked")){
			alert("상담 받을 글 관련 강좌의 2번 질문을 선택해주세요.");
			return false;
		}
		
		var flag = false;
		for(var i = 0; i < $("input:file").length; i++){
			if($("input:file").eq(i).val() != ''){
				flag = true;
			}
		}
		if(!flag){
			alert("파일을 선택해주세요.");
			return false;
		}
		
		if($("#aplyCourseName").val() == ''){
			alert("강좌명을 입력해주세요.");
			return false;
		}else if($("#schSeq").val() == ''){
			alert("상담일자를 선택해주세요.");
			return false;
		}else if(!$("input:radio[name=agreeChk]").is(":checked")){
			alert("개인정보 수집 동의를 선택해주세요.");
			return false;
		}else if($("input:radio[name=agreeChk]:checked").val() == 'N'){
			alert("개인정보 수집에 동의하지 않으셨습니다.");
			return false;
		}
		
		$.ajax({
			url: "<c:out value='${pageContext.request.contextPath }/usr/cnslt/cnsltScheduleCheckAjax.do'/>"
			, type: "post"
			, data: {
				schSeq : $("#schSeq").val()
			}
			, dataType:"json"
			, success: function(data){
				var result = data.result;
				
				if(result > 0) {
					alert("신청이 완료된 시간입니다.\n다시 선택해 주세요.");
					location.reload();
				}else{
					$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/cnslt/cnsltRequestRegiUpdate.do'/>").submit();
				}
			}, error: function(){
				alert("오류가 발생하였습니다.");
				location.reload();
			}
		});
	}
</script>
<body>
<form id="frm" name="frm" enctype="multipart/form-data">
<!-- 1온라인 2면대면 (하드코딩 2로)-->
<input type="hidden" id="aplyType" name="aplyType" value="2"/>
<input type="hidden" id="aplyUsrType" name="aplyUsrType" value="OVER"/>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<hr />
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="상담"/>
            	<jsp:param name="dept2" value="상담신청"/>
            </jsp:include>
			<div class="cont_box">
				<div class="mid_tit">정보입력</div>
				<div class="g_box mb50">
					<ul class="type_01">
						<li class="tit">대학</li>
						<li>
							<select id="aplyCollege" name="aplyCollege" style="width:160px;">
								<c:forEach items="${deptList }" var="dept">
									<c:if test="${dept.deptSeq ne 5 && dept.deptSeq ne 6 && dept.deptSeq ne 7 && dept.deptSeq ne 8 && dept.deptSeq ne 9 && dept.deptSeq ne 102}">
										<option value="<c:out value='${dept.deptSeq }'/>"><c:out value="${dept.deptTitle }"/></option>
									</c:if>
								</c:forEach>
							</select>
						</li>
						<li class="tit">학년</li>
						<li>
							<select name="aplyGrade" id="aplyGrade" style="width:80px;">
								<option value="">선택</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
							</select>
						</li>
						<li class="tit">학과</li>
						<li><input type="text" name="aplyDept" id="aplyDept" style="width:120px;" value="<c:out value="${sessionScope.userSession.memDept }"/>"/></li>
						<li class="tit">학번</li>
						<li><input type="text" name="aplyHakbun" id="aplyHakbun" style="width:100px;" value="<c:out value="${sessionScope.userSession.memCode }"/>"/></li>
						<li class="tit">성명</li>
						<li><input type="text" name="aplyName" id="aplyName" style="width:80px;" value="<c:out value="${sessionScope.userSession.memName }"/>"/></li>
						<li class="tit">학적/구분</li>
						<li>
							<select name="aplyRegistYn" id="aplyRegistYn" style="width:80px;">
								<option value="">선택</option>
								<option value="Y">재학</option>
								<option value="N">휴학</option>
							</select>
						</li>
						<li class="tit">휴대폰</li>
						<li>
							<select name="aplyMphone1" id="aplyMphone1" style="width:60px;" >
								<option value="010">010</option>
								<option value="011">011</option>
							</select> -
							<input type="text" name="aplyMphone2" id="aplyMphone2" style="width:60px; ime-mode: disabled;" maxlength="4" onkeydown="return showKeyCode(event);"/> - 
							<input type="text" name="aplyMphone3" id="aplyMphone3" style="width:60px; ime-mode: disabled;" maxlength="4" onkeydown="return showKeyCode(event);"/></li>
					</ul>
				</div>
				 <li class="tit" style="color: red; font-size: 20px; margin-bottom: 25px;">동일 과제에 대하여 2회 이상 상담 불가합니다.</li>
				<div class="mid_tit">상담 대상 글</div>
				<div class="aw_box mb20">
					<ul class="aw_tit">
						<li>1</li>
						<li>상담 받을 글의 유형은 무엇입니까?</li>
					</ul>
					<div class="cont radio_input li3">
						<ul>
							<li><input type="radio" name="overAns1" id="overAns1_1" value="1"/> <label for="overAns1_1">리포트</label></li>
							<li><input type="radio" name="overAns1" id="overAns1_2" value="2"/> <label for="overAns1_2">분석 보고서</label></li>
							<li><input type="radio" name="overAns1" id="overAns1_3" value="3"/> <label for="overAns1_3">조사 보고서</label></li>
						</ul>
						<ul>
							<li><input type="radio" name="overAns1" id="overAns1_4" value="4"/> <label for="overAns1_4">실험 보고서</label></li>
							<li><input type="radio" name="overAns1" id="overAns1_5" value="5"/> <label for="overAns1_5">일반 한국어 글쓰기</label></li>
							<li><input type="radio" name="overAns1" id="overAns1_6" value="6"/> <label for="overAns1_6">발표(프레젠테이션 문서)</label></li>
						</ul>
						<ul>
							<li><input type="radio" name="overAns1" id="overAns1_7" value="7"/> <label for="overAns1_7">자기소개서</label></li>
							<li><input type="radio" name="overAns1" id="overAns1_8" value="8"/> <label for="overAns1_8">면접</label></li>
						</ul>
						<ul>
							<li style="width:100%;">
								<input type="radio" name="overAns1" id="overAns1_7" value="0"/> <label for="overAns1_7">기타</label>
								<input type="text" name="overAns1Txt" id="overAns1Txt" style="width:60%; height:30px" disabled="disabled"/>
							</li>
						</ul>
					</div>
				</div>
				<div class="aw_box mb20">
					<ul class="aw_tit">
						<li>2</li>
						<li>상담 받고 싶은 내용이 무엇입니까? (두 개를 선택(V)해도 됩니다.)</li>
					</ul>
					<div class="cont check_input li2">
						<ul>
							<li><input type="checkbox" name="overAns2A" id="overAns2A" value="1"/> <label for="overAns2A">주제를 설정하는 방법</label></li>
							<li><input type="checkbox" name="overAns2B" id="overAns2B" value="1"/> <label for="overAns2B">글의 내용을 구성하는 방법</label></li>
						</ul>
						<ul>
							<li><input type="checkbox" name="overAns2C" id="overAns2C" value="1"/> <label for="overAns2C">글을 쓰는 과정에 대한 어려움</label></li>
							<li><input type="checkbox" name="overAns2D" id="overAns2D" value="1"/> <label for="overAns2D">한국어 문장 표현(문법, 어휘, 관용 표현 등)</label></li>
						</ul>
						<ul>
							<li><input type="checkbox" name="overAns2E" id="overAns2E" value="1"/> <label for="overAns2E">자기 글의 문제점</label></li>
						</ul>
						<ul>
							<li style="width:100%;">
								<input type="checkbox" name="overAns2F" id="overAns2F" value="1"/> <label for="overAns2F">기타</label> 
								<input type="text" name="overAns2Txt" id="overAns2Txt" style="width:60%; height:30px" disabled="disabled"/>
							</li>
						</ul>
					</div>
				</div>
				<div class="aw_box mb50">
					<ul class="aw_tit">
						<li>3</li>
						<li>자신이 생각하는 한국어 실력은 어느 정도입니까?</li>
					</ul>
					<div class="cont radio_input li4">
						<ul>
							<li><input type="radio" name="overAns3" id="overAns3_1" value="1"/> <label for="overAns3_1">1~2급</label></li>
							<li><input type="radio" name="overAns3" id="overAns3_2" value="2"/> <label for="overAns3_2">3~4급</label></li>
							<li><input type="radio" name="overAns3" id="overAns3_3" value="3"/> <label for="overAns3_3">5~6급</label></li>
							<li><input type="radio" name="overAns3" id="overAns3_4" value="4"/> <label for="overAns3_4">6급 이상</label></li>
						</ul>
					</div>
				</div>
				<div class="mid_tit">상담 받을 글 관련 강좌</div>
				<div class="aw_box mb20">
					<ul class="aw_tit">
						<li>1</li>
						<li>강좌의 성격은 무엇입니까?</li>
					</ul>
					<div class="cont check_input li4">
						<ul>
							<li><input type="radio" name="tans1" id="tans1_1" value="1"/> <label for="tans1_1">전공 과목</label></li>
							<li><input type="radio" name="tans1" id="tans1_2" value="2"/> <label for="tans1_2">교양 과목</label></li>
						</ul>
					</div>
				</div>
				<div class="aw_box mb50">
					<ul class="aw_tit">
						<li>2</li>
						<li>몇 학년을 수강 대상으로 한 강좌입니까?</li>
					</ul>
					<div class="cont check_input li5">
						<ul>
							<li><input type="radio" name="tans2" id="tans2_1" value="1"/> <label for="tans2_1">1학년</label></li>
							<li><input type="radio" name="tans2" id="tans2_2" value="2"/> <label for="tans2_2">2학년</label></li>
							<li><input type="radio" name="tans2" id="tans2_3" value="3"/> <label for="tans2_3">3학년</label></li>
							<li><input type="radio" name="tans2" id="tans2_4" value="4"/> <label for="tans2_4">4학년</label></li>
							<li><input type="radio" name="tans2" id="tans2_5" value="5"/> <label for="tans2_5">전 학년 공통</label></li>
						</ul>
					</div>
				</div>
				<div class="mid_tit">파일 업로드 (한글, 워드, PDF, PPT)</div>
				<div class="aw_box mb50">
					<div class="cont">
						<c:forEach begin="1" end="2" step="1" var="fileNo">
							<input type="file" id="attachedFile_${fileNo }" name="attachedFile_${fileNo }"/><br />
						</c:forEach>
					</div>
					<div class="g_box alt_txt tx_l">
						<p class="mb10">*첨부파일은 용량 15M 이하의 hwp, doc, txt, ppt, bmp, jpg, gif, pdf 파일만 가능하며, 최대 2개까지 올릴 수 있습니다.</p>
						<p>*첨부파일의 용량이 클 경우 pdf로 변환하거나 나누어서 올리시길 바랍니다.</p>
					</div>
				</div>
				<div class="w_box mb50">
					<ul class="type_01">
						<li class="tit">강좌명</li>
						<li><input type="text" name="aplyCourseName" id="aplyCourseName" style="width:150px;" /></li>
						<li class="tit">일자</li>
						<li>
							<input type="text" name="schYmd" id="schYmd" style="width:150px;" class="datepicker" readonly="readonly"/>
							<a href="#" class="sh_btn" onclick="fn_cnsltSchedule_list(); return false;">검색</a>
						</li>
						<li class="tit">상담연구원</li>
						<li>
							<select name="schSeq" id="schSeq" style="width:150px;" >
								<option value="">선택</option>
							</select>
						</li>
					</ul>
				</div>
				<div class="pri_box mb50">
					<p class="mb10 tit">개인정보 수집에 동의합니까? <span>(상담 외에는 정보가 이용되지 않습니다.)</span></p>
					<p>
						<input type="radio" name="agreeChk" id="agreeChk_Y" value="Y"/> <label for="agreeChk_Y">동의함</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="agreeChk" id="agreeChk_N" value="N"/> <label for="agreeChk_N">동의하지 않음</label>
					</p>
				</div>
				<div class="btn_box">
					<a href="#" class="coun_btn" onclick="fn_update(); return false;">상담신청</a>
				</div>
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" name="message" value="${message }"/>
</form>
</body>
</html>