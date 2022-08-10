<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">

	$(function(){
		$("#auth-all").click(function(){
			var checked = $(this).is(":checked");
			
			$(".auth input[type=checkbox]").prop("checked", checked);
		});
	
		$("#lect-all").click(function(){
			var checked = $(this).is(":checked");
			
			$(".lect input[type=checkbox]").prop("checked", checked);
		});
	});

	function fn_list(){
		$("#listFrm").attr("action", "<c:url value='/qxsepmny/oper/admAdminList.do'/>").submit();
	}
	
	function fn_update(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/oper/admAdminUpdate.do'/>").submit();
	}
	
	function fn_clearPw(){
		if(confirm('관리자 비밀번호를 재설정 하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/qxsepmny/oper/admAjaxProfClearPw.do'/>"
				, type: "post"
				, data: $("#frm").serialize()
				, dataType: "json"
				, success: function(data){
					var message = data.message;
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	function fn_clearLgnFail(){
		if(confirm('관리자 로그인 횟수를 초기화 하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/qxsepmny/oper/admAjaxClearLgnFail.do'/>"
				, type: "post"
				, data: "adminId="+$("#adminId").val()
				, dataType: "json"
				, success: function(data){
					var message = data.message;
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
</script>
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="운영"/>
		            <jsp:param name="dept2" value="사용자관리"/>
	           	</jsp:include> 
				<!-- table -->
				<form:form commandName="adminVO" id="frm" name="frm">
				<div class="list-table-box">
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
									<form:hidden path="adminId"/>
								</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td>
									**************
									<c:if test="${adminVO.adminId != null && adminVO.adminId ne '' }">
										<a href="#" onclick="fn_clearPw(); return false;" class="label-btn">재설정</a>
										<a href="#" onclick="fn_clearLgnFail(); return false;" class="label-btn">로그인횟수 초기화</a>
									</c:if>
									<!-- <label for="password-option" class="label-btn">재설정</label>
 -->									<!-- 비밀번호 팝업 -->
									<%-- <input type="checkbox" id="password-option" />
									<div class="pop-bg">
										<div class="pop-table">
											<!-- table -->
											<div class="list-table-box">
												<table class="normal-wmv-table">
													<colgroup>
														<col style="width:15%;" />
														<col />
													</colgroup>
													<tbody>
														<tr>
															<th><sup>*</sup>새 비밀번호</th>
															<td>
																<input type="password" id="afterPw" name="afterPw" class="input-data" placeholder="영숫자, 특수문자를 혼합하여 8자리 이상" />
																<span class="alt-txt">영문,숫자,특수문자 조합으로 8자 이상 설정</span>
																<span class="ok-signature">O.K</span>
															</td>
														</tr>
													</tbody>
												</table>
											</div>
											<!--// table -->
											<!-- table button -->
											<div class="table-button">
												<div class="btn-box">
													<button type="button" class="white btn-save">저장</button>
													<label for="password-option"  class="white btn-cancel">취소</label>
												</div>
											</div>
											<!--// table button -->
										</div>
									</div> --%>
									<!-- // 비밀번호 팝업 -->
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<form:input path="name" class="input-data w173px" />
								</td>
							</tr>
							<tr>
								<th>소속</th>
								<td>
									<form:input path="depart" class="input-data w173px" />
								</td>
							</tr>
							<tr>
								<th>허용IP</th>
								<td>
									<c:set var="acceIpList" value="${fn:split(adminVO.acceIp, '.') }"/>
									<input type="text" name="acceIp" id="acceIp1" class="input-data w63px" value='<c:out value="${acceIpList[0] }"/>' />
									<input type="text" name="acceIp" id="acceIp2" class="input-data w63px" value='<c:out value="${acceIpList[1] }"/>'/>
									<input type="text" name="acceIp" id="acceIp3" class="input-data w63px" value='<c:out value="${acceIpList[2] }"/>'/>
									<input type="text" name="acceIp" id="acceIp4" class="input-data w63px" value='<c:out value="${acceIpList[3] }"/>'/>&nbsp;&nbsp;&nbsp;
									<form:checkbox path="ipAllYn" value="Y"/> <label for="ipAllYn">모든 IP 허용</label>
								</td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td>
									<form:select path="useYn">
										<form:option value="Y">사용</form:option>
										<form:option value="N">중지</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th>사용자구분</th>
								<td>
									<form:select path="adminType">
										<form:option value="1">관리자</form:option>
										<form:option value="2">사용자</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th>최근접속일시</th>
								<td>
									<c:out value="${adminVO.loginDateTime }"/>
								</td>
							</tr>
							<tr>
								<th>2차정보조회권한</th>
								<td>
									<form:checkbox path="dtlYn" value="Y"/>
								</td>
							</tr>
							<tr>
								<th><label for="auth-all">사용권한&nbsp;&nbsp;<input type="checkbox" id="auth-all" /></label></th>
								<td>
									<div class="check-box auth">
										<ul>
											<li>
												<form:checkbox path="entran" value="Y"/>
												<label for="entran">입학</label>
											</li>
											<li>
												<form:checkbox path="regist" value="Y"/>
												<label for="regist">등록</label>
											</li>
											<li>
												<form:checkbox path="student" value="Y"/>
												<label for="student">학생</label>
											</li>
											<li>
												<form:checkbox path="clss" value="Y"/>
												<label for="clss">수업</label>
											</li>
											<li>
												<form:checkbox path="admstr" value="Y"/>
												<label for="admstr">행정</label>
											</li>
											<li>
												<form:checkbox path="stat" value="Y"/>
												<label for="stat">현황통계</label>
											</li>
											<li>
												<form:checkbox path="curr" value="Y"/>
												<label for="curr">교육과정</label>
											</li>
											<li>
												<form:checkbox path="oper" value="Y"/>
												<label for="oper">운영</label>
											</li>
										</ul>
									</div>
								</td>
							</tr>
							<!-- <tr>
								<th><label for="lect-all">지원강의실&nbsp;&nbsp;<input type="checkbox" id="lect-all" /></label></th>
								<td>
									<select>
										<option>2019</option>
									</select>
									<select>
										<option>가을학기</option>
									</select>
									<div class="check-box lect">
										<ul>
											<li><input type="checkbox" id="w02-cb01" /> <label for="w02-cb01">한국어1 A반</label></li>
											<li><input type="checkbox" id="w02-cb02" /> <label for="w02-cb02">한국어1 B반</label></li>
											<li><input type="checkbox" id="w02-cb03" /> <label for="w02-cb03">한국어2 A반</label></li>
											<li><input type="checkbox" id="w02-cb04" /> <label for="w02-cb04">한국어3 B반</label></li>
											<li><input type="checkbox" id="w02-cb05" /> <label for="w02-cb05">한국어3</label></li>
										</ul>
									</div>
								</td>
							</tr> -->
						</tbody>
					</table>
				</div>
				</form:form>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<button type="button" onclick="fn_list(); return false;" class="white btn-list">목록</button>
						<button type="button" onclick="fn_update(); return false;" class="white btn-save">저장</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
	<form:form commandName="searchVO" id="listFrm" name="listFrm">
		<form:hidden path="searchWord"/>
		<form:hidden path="pageIndex"/>
	</form:form>
</body>
</html>