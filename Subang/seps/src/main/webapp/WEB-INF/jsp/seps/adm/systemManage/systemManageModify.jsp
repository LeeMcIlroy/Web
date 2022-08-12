<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<script type="text/javascript">

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/systemManage/systemManageList.do'/>").submit();
	}
	
	// 저장
	function fn_modify(){
		var regExp = /^[0-9]*$/;
		if($('#userNm').val() == ''){
			alert('이름은 필수 입력 항목입니다.');
			return false;
		}
		
		if($('#userId').val() == ''){
			alert('아이디를 입력해주세요.');
			return false;
		}
		
<c:if test="${empty userInfoVO.userInfoId }">
		if($("#admIdCheck").val() != $("#userId").val()){
			alert("아이디 중복확인을 해주세요.");
			return false;
		}
</c:if>
		
		if($("#userPw").val() == null || $("#userPw").val() == ''){
			alert("비밀번호는 필수 입력 항목입니다.");
			return false;
		}
		
		var passwordRules = /^[A-Za-z0-9!@#$%^&\*=+]{6,20}$/;

		if(!passwordRules.test($("#userPw").val())){
			alert('비밀번호는 6~20자리로 영문, 숫자, 특수문자만 사용가능합니다.');
			return false;
		}
		
		if($('#userTel1').val() == '' || $('#userTel2').val() == '' || $('#userTel3').val() == ''){
			alert('연락처를 입력해주세요.');
			return false;
		}
		if(!regExp.test($('#userTel2').val()) || !regExp.test($('#userTel3').val())){
			alert('숫자만 입력가능합니다.');
			return false;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/systemManage/systemManageSubmit.do'/>").submit();
	}
	
	// 중복확인
	function fn_idCheck(){
		var userId = $("#userId").val();
		if(userId != ''){
			$.ajax({
				url: "<c:url value='/adm/systemManage/ajaxSystemManageCheck.do'/>"
				, type: "post"
				, data: "userId="+userId
				, dataType:"json"
				, success: function(data){
					if(data.result == 'Y'){
						alert("이미 등록된 아이디 입니다.");
					}else{
						alert("사용 가능한 아이디 입니다.");
						$("#admIdCheck").val($("#userId").val());
					}
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}else{
			alert("아이디를 입력해주세요.");
			return false;
		}
	}
	
</script>
<body>
<form:form commandName="userInfoVO" id="frm" name="frm">
<form:hidden path="userInfoId"/>
<input type="hidden" id="admIdCheck" name="admIdCheck" value="<c:out value='${admIdCheck }'/>">
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">사용자관리</div>
			<!--// PAGE_TITLE -->
			<div class="content">
				<div class="cont_box">
					<div>
						<div>
							<table class="input_table">
								<colgroup>
									<col width="15%" />
									<col width="85%" />
								</colgroup>
								<tbody>
									<tr>
										<th>*이름</th>
										<td>
											<form:input path="userNm"/>
										</td>
									</tr>
									<tr>
										<th>*아이디</th>
										<td>
											<c:if test="${empty userInfoVO.userInfoId }">
												<form:input path="userId" autocomplete="off"/> <button class="btn_list"  onclick="fn_idCheck(); return false;"> 중복확인</button>
											</c:if>
											<c:if test="${!empty userInfoVO.userInfoId }">
												<c:out value="${userInfoVO.userId }"/>
												<form:hidden path="userId"/>
											</c:if>
										</td>
									</tr>
									<tr>
										<th>*비밀번호</th>
										<td>
											<form:password path="userPw"/>
											<p class="alt_txt">6~20 자리로 영문, 숫자, 특수문자만 사용 가능 합니다.</p>
										</td>
									</tr>
									<tr>
										<th>*연락처</th>
										<td>
											<form:select path="userTel1" style="width: 70px;">
												<form:option value="">선택</form:option>
												<form:option value="010">010</form:option>
												<form:option value="011">011</form:option>
												<form:option value="02">02</form:option>
												<form:option value="031">031</form:option>
												<form:option value="032">032</form:option>
												<form:option value="033">033</form:option>
												<form:option value="041">041</form:option>
												<form:option value="042">042</form:option>
												<form:option value="043">043</form:option>
												<form:option value="044">044</form:option>
												<form:option value="051">051</form:option>
												<form:option value="052">052</form:option>
												<form:option value="053">053</form:option>
												<form:option value="054">054</form:option>
												<form:option value="055">055</form:option>
												<form:option value="061">061</form:option>
												<form:option value="062">062</form:option>
												<form:option value="063">063</form:option>
												<form:option value="064">064</form:option>
												<form:option value="070">070</form:option>
											</form:select>
											-<form:input path="userTel2" maxlength="4" style="width: 70px;"/>-<form:input path="userTel3" maxlength="4" style="width: 70px;"/>
											<%--
											<form:input path="userTel"/>
											--%>
										</td>
									</tr>
									<tr>
										<th>이메일</th>
										<td>
											<form:input path="userMail1"/>@
											<form:select path="userMail2">
												<form:option value="">선택</form:option>
												<form:option value="sisul.or.kr">sisul.or.kr</form:option>
												<form:option value="gmail.com">gmail.com</form:option>
												<form:option value="naver.com">naver.com</form:option>
											</form:select>
										</td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td>
											<form:select path="useYn" >
												<form:option value="Y">사용</form:option>
												<form:option value="N">미사용</form:option>
											</form:select>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="btn_box">
								<button class="btn_list" onclick="fn_modify(); return false;">저장</button>
								<button class="btn_list" onclick="fn_list(); return false;">목록</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=inc/incFooter"/>
	<!-- footer - end -->
	
<!-- 목록 검색조건 - start -->
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }">
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }">
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }">
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }">
<!-- 목록 검색조건 - end -->
</form:form>
</body>
</html>