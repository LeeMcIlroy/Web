<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	// 이메일 주소 선택
	function fn_email(){
		var emailAddress = $("#emailAddress").val();
		
		if(emailAddress != '1'){
			$("#aplyEmail_2").val(emailAddress);
			$("#aplyEmail_2").attr("readonly", "readonly");
		}else{
			$("#aplyEmail_2").val('');
			$("#aplyEmail_2").removeAttr("readonly");
		}
	}

	// 대회 접수
	function fn_update(){
		if($("#aplyName").val() == ''){
			alert("성명을 입력해주세요.");
			return false;
		}else if($("#aplyHakbun").val() == ''){
			alert("학번을 입력해주세요.");
			return false;
		}else if($("#aplyRegistYn").val() == ''){
			alert("학적구분을 선택해주세요.");
			return false;
		}else if($("#aplyMphone_2").val() == '' || $("#aplyMphone_3").val() == ''){
			alert("휴대폰번호를 입력해주세요.");
			return false;
		}else if($("#aplyEmail_1").val() == '' || $("#aplyEmail_2").val() == ''){
			alert("이메일를 입력해주세요.");
			return false;
		}else if($("#aplyDept").val() == ''){
			alert("대학을 선택해주세요.");
			return false;
		}else if($("#aplyGrade").val() == ''){
			alert("학년을 선택해주세요.");
			return false;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstContestUpdate.do'/>").submit();
	}

	// 대회 취소
	function fn_delete(){
		if(!confirm('대회 접수를 취소하시겠습니까?')){
			return false;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstContestDelete.do'/>").submit();
	}
</script>
<body>
<form:form commandName="cntstApplyVO" id="frm" name="frm">
<form:hidden path="aplyType" value="WRITE"/>
<form:hidden path="brdSeq" value="${resultMap.brdSeq }"/>
<form:hidden path="aplySeq"/>
<form:hidden path="aplyYear" value="${resultMap.openYear }"/>
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
            	<jsp:param name="dept1" value="글쓰기"/>
            	<jsp:param name="dept2" value="한성인 글쓰기 대회"/>
            </jsp:include>
			<div class="cont_box">
				<div class="book_line02">
					<ul>
						<!-- <li><a href="#p09_txt01"><span>대회 소개</span></a></li> -->
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteComList.do'/>"><span>공지사항</span></a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstContestApply.do'/>"><span>대회 신청</span></a></li>
					</ul>
				</div>
				<div class="mid_tit">대회안내</div>
				<div class="cont_box">
					<table class="view_type01 mb30" summary="자유게시판">
						<caption>대회안내</caption>
						<colgroup>
							<col width="10%"/>
							<col width="40%"/>
							<col width="10%"/>
							<col width="40%"/>
						</colgroup>
						<tbody>
							<tr class="first">
								<td colspan="4"><c:out value="${resultMap.brdTitle }"/></td>
							</tr>
							<tr>
								<th scope="row">신청접수기간</th>
								<td>
									<c:out value="${resultMap.appSDate }"/>(<c:out value="${resultMap.appSDateKr }"/>) ~ 
									<c:out value="${resultMap.appEDate }"/>(<c:out value="${resultMap.appEDateKr }"/>)
								</td>
								<th scope="row">모집인원</th>
								<td><c:out value="${resultMap.appNum }"/></td>
							</tr>
							<tr>
								<th scope="row">대회안내</th>
								<td colspan="3"><c:out value="${resultMap.brdContent }" escapeXml="false"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mid_tit">신청정보</div>
				<div class="cont_box">
					<table class="view_type01 mb30" summary="자유게시판">
						<caption>대회안내</caption>
						<colgroup>
							<col width="10%"/>
							<col width="40%"/>
							<col width="10%"/>
							<col width="40%"/>
						</colgroup>
						<tbody>
							<tr class="first">
								<th scope="row">* 성명</th>
								<td>
									<c:if test="${cntstApplyVO.aplySeq == null || cntstApplyVO.aplySeq eq '' }">
										<form:input path="aplyName" value="${sessionScope.userSession.memName }" readonly="true"/>
									</c:if>
									<c:if test="${cntstApplyVO.aplySeq != null && cntstApplyVO.aplySeq ne '' }">
										<c:out value="${cntstApplyVO.aplyName }"/>
									</c:if>
								</td>
								<th scope="row">* 학번</th>
								<td>
									<c:if test="${cntstApplyVO.aplySeq == null || cntstApplyVO.aplySeq eq '' }">
										<form:input path="aplyHakbun" value="${sessionScope.userSession.memCode }" readonly="true"/>
									</c:if>
									<c:if test="${cntstApplyVO.aplySeq != null && cntstApplyVO.aplySeq ne '' }">
										<c:out value="${cntstApplyVO.aplyHakbun }"/>
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row">* 학적구분</th>
								<td>
									<c:if test="${cntstApplyVO.aplySeq == null || cntstApplyVO.aplySeq eq '' }">
										<form:select path="aplyRegistYn">
											<form:option value="">선택</form:option>
											<form:option value="Y">재학</form:option>
											<form:option value="N">휴학</form:option>
										</form:select>
									</c:if>
									<c:if test="${cntstApplyVO.aplySeq != null && cntstApplyVO.aplySeq ne '' }">
										<c:out value="${cntstApplyVO.aplyRegistYn eq 'Y'?'재학':'휴학' }"/>
									</c:if>
								</td>
								<th scope="row">* 휴대폰</th>
								<td>
									<c:if test="${cntstApplyVO.aplySeq == null || cntstApplyVO.aplySeq eq '' }">
										<form:select path="aplyMphone_1" style="width:60px;" >
											<form:option value="010">010</form:option>
											<form:option value="011">011</form:option>
										</form:select> - 
										<form:input path="aplyMphone_2" style="width:60px; ime-mode: disabled;" maxlength="4" onkeydown="return showKeyCode(event);"/> - 
										<form:input path="aplyMphone_3" style="width:60px; ime-mode: disabled;" maxlength="4" onkeydown="return showKeyCode(event);"/>
									</c:if>
									<c:if test="${cntstApplyVO.aplySeq != null && cntstApplyVO.aplySeq ne '' }">
										<c:out value="${cntstApplyVO.aplyMphone }"/>
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row">* 이메일</th>
								<td colspan="3">
									<c:if test="${cntstApplyVO.aplySeq == null || cntstApplyVO.aplySeq eq '' }">
										<form:input path="aplyEmail_1" maxlength="100"/> @ 
										<form:input path="aplyEmail_2" maxlength="100" readonly="true"/>
										<select id="emailAddress" onchange="fn_email(); return false;">
											<option value="">선택하세요</option>
											<option value="naver.com">naver.com</option>
											<option value="hanmail.net">hanmail.net</option>
											<option value="gmail.com">gmail.com</option>
											<option value="1">직접입력</option>
										</select>	
									</c:if>
									<c:if test="${cntstApplyVO.aplySeq != null && cntstApplyVO.aplySeq ne '' }">
										<c:out value="${cntstApplyVO.aplyEmail }"/>
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row">* 소속</th>
								<td colspan="3">
									<c:if test="${cntstApplyVO.aplySeq == null || cntstApplyVO.aplySeq eq '' }">
										대학&nbsp;
										<form:select path="aplyDept">
											<form:option value="">대학선택</form:option>
											<form:option value="크리에이티브인문예슬대학">크리에이티브인문예슬대학</form:option>
											<form:option value="미래융합사회과학대학">미래융합사회과학대학</form:option>
											<form:option value="상상력인재학부">상상력인재학부</form:option>
											<form:option value="디자인대학">디자인대학</form:option>
											<form:option value="IT공과대학">IT공과대학</form:option>
											<form:option value="미래플러스대학">미래플러스대학</form:option>
										</form:select> 
									</c:if>
									<c:if test="${cntstApplyVO.aplySeq != null && cntstApplyVO.aplySeq ne '' }">
										<c:out value="${cntstApplyVO.aplyDept }"/>
									</c:if>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${cntstApplyVO.aplySeq == null || cntstApplyVO.aplySeq eq '' }">
										학년 &nbsp;
										<form:select path="aplyGrade">
											<form:option value="">선택</form:option>
											<form:option value="1">1</form:option>
											<form:option value="2">2</form:option>
											<form:option value="3">3</form:option>
											<form:option value="4">4</form:option>
										</form:select>
									</c:if>
									<c:if test="${cntstApplyVO.aplySeq != null && cntstApplyVO.aplySeq ne '' }">
										<c:out value="${cntstApplyVO.aplyGrade }"/>&nbsp;학년
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mid_tit">개인정보 수집 및 이용 동의</div>
				<div class="g_box">
					<p class="mb20 ml10 tx_l">
						본인은 다음의 목적과 관련하여 글쓰기 대회 학생 원고 수집 및 이용에 동의합니다.<br/><br/>
						1. 이용 항목 및 목적<br/><br/>
						1) 수집·이용 정보 : 한성인 글쓰기 대회 학생 원고<br/><br/>
						2) 목적 : ① 교육 및 연구 자료로 활용<br/><br/>
						② 수상작은 <우수과제자료집> 게재 –<사고와표현> 수업에서 배부<br/><br/>
						③ 수업 시간 자료로 활용<br/><br/>
						2. 정보의 보유 및 이용 기간<br/><br/>
						수집한 정보는 수집·이용에 관한 동의일로부터 일정기간 보존합니다. 단, 동의자가 정보 삭제를 요청할 경우 지체 없이 파기합니다.<br/>
					</p>
					<c:if test="${cntstApplyVO.aplySeq == null || cntstApplyVO.aplySeq eq '' }">
						<p>
							<input type="radio" name="agreeChk" id="agreeChk_Y" value="Y"/> <label for="agreeChk_Y">동의함</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="agreeChk" id="agreeChk_N" value="N"/> <label for="agreeChk_N">동의하지 않음</label>
						</p>
					</c:if>
				</div>
				<div class="btn_box">
					<c:if test="${cntstApplyVO.aplySeq == null || cntstApplyVO.aplySeq eq '' }">
						<a href="#" class="coun_btn" onclick="fn_update(); return false;">접수</a>
					</c:if>
					<c:if test="${cntstApplyVO.aplySeq != null && cntstApplyVO.aplySeq ne '' }">
						<a href="#" class="coun_btn" onclick="fn_delete(); return false;">접수취소</a>
					</c:if>
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
</form:form>
</body>
</html>