<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	$(function(){
		$(document).on("click", "#adZipcode", function(){
			fn_address_search();
			return false;
		});
	})

	// 주소 찾기
	function fn_address_search(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	            $("#adZipcode").val(data.zonecode);
	            $("#adAddr1").val(data.address);
	        }
	    }).open();
	}
	
	// 신청
	function fn_update(){
		if($("#adName").val() == ''){
			alert("이름을 입력해주세요.");
			return false;
		}else if($("#adSchool").val() == ''){
			alert("고등학교 상태를 선택해주세요.");
			 return false;
		}else if($("#adTel1").val() == '' || $("#adTel2").val() == '' || $("#adTel3").val() == ''){
			alert("연락처를 입력해주세요.");
			 return false;
		}else if($("#adMajor").val() == ''){
			alert("관심학과를 선택해주세요.");
			 return false;
		}
		/* 
		else if($("#adZipcode").val() == '' || $("#adAddr1").val() == ''){
			alert("주소를 입력해주세요.");
			 return false;
		}
		 */
		else if($("#chkBox").is(":checked") == false){
			alert("개인정보 수집동의를 확인해 주세요.");
			return false;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/enter/admission/admissionUpdate.do'/>").submit();
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
				<div class="sub_content">
					<!-- 타이틀 영역 -->
					<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
						<jsp:param name="dept1" value="입학"/>
			            <jsp:param name="dept2" value="입학상담회 신청"/>
		           	</jsp:include>
					<div class="transform_table notice_type">
						<div class="tbl_write">
							<ul class="tbl_view_m">
								<li class="txt_left w100p">* 이름</li>
								<li><input type="text" id="adName" name="adName"></li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p">* 고등학교</li>
								<li>
									<select id="adSchool" name="adSchool">
										<option value="1">재학중</option>
										<option value="2">졸업예정</option>
										<option value="3">졸업</option>
										<option value="0">기타</option>
									</select>
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p">* 연락처</li>
								<li>
									<select id="adTel1" name="adTel1" style="min-width: 5%;">
										<option value="010">010</option>
									</select>
									-<input type="text" id="adTel2" name="adTel2" style="width: 7%;text-align: center;">
									-<input type="text" id="adTel3" name="adTel3" style="width: 7%;text-align: center;">
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p">* 관심학과</li>
								<li>
									<select id="adMajor" name="adMajor">
										<option value="실내디자인">실내디자인</option>
										<option value="시각디자인">시각디자인</option>
										<option value="산업디자인">산업디자인</option>
										<option value="디지털아트">디지털아트</option>
										<option value="패션디자인">패션디자인</option>
										<option value="패션비즈니스">패션비즈니스</option>
										<option value="미용학">미용학</option>
										<option value="미용학(one-day)">미용학(one-day)</option>
									</select>
								</li>
							</ul>
							<%-- 
							<ul class="tbl_view_m">
								<li class="txt_left" style="display:block; width:100%;">* 브로셔를 받을 주소(우편번호 포함)</li>
								<li>
									<input type="text" id="adZipcode" name="adZipcode" placeholder="우편번호" style="margin-top: 10px;width: 15%;" readonly="readonly">
									<button onclick="fn_address_search(); return false;" style="margin-top: 10px;">검색</button>
									
									<a href="#" onclick="fn_address_search(); return false;" class="">검색</a>
									
									<br>
									<input type="text" id="adAddr1" name="adAddr1" style="width: 40%; margin-top: 10px;" readonly="readonly" placeholder="주소">
									<input type="text" id="adAddr2" name="adAddr2" style="width: 40%; margin-top: 10px;" placeholder="상세주소">
								</li>
								<li>
									
								</li>
							</ul>
							 --%>
							<input type="checkbox" id="chkBox" >&nbsp;개인정보 수집동의  (입력된 정보는 신청 업무에만 사용됩니다.)
						</div>
					</div>
					<div class="btn_box">
						<a href="#" class="btn_go_list" onclick="fn_update(); return false;">신청하기</a>
					</div>

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
</html>