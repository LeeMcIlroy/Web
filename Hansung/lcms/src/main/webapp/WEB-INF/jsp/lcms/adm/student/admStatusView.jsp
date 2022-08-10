<%@page import="lcms.valueObject.AdminVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%> 
<%
	String admMenuNo = ((String)session.getAttribute("admMenuNo")!=null)?(String)session.getAttribute("admMenuNo"):"";
	AdminVO adminVO = ((AdminVO)session.getAttribute("adminSessionLcms")!=null)?(AdminVO)session.getAttribute("adminSessionLcms"):null;
%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">

function edit(){
	$("#detailForm").attr("action", "<c:url value='/qxsepmny/student/admStatusModify.do'/>").submit();
}
function del(){
	if(confirm('삭제 하시겠습니까?')){
	$("#detailForm").attr("action", "<c:url value='/qxsepmny/student/admStatusDelete.do'/>").submit();
	}
}

$('input[name=checkValue]').click(function(){

 var ischecked = $(this).attr('checked');
 if(ischecked){
      $('.img1').css('display', 'none');
      $('.img2').css('display', 'block');
 }else{
      $('.img1').css('display', 'block');
      $('.img2').css('display', 'none');
 }

});

function fn_clearPw(){
	if(confirm('해당 학생의 비밀번호를 초기화하시겠습니까?')){
		$.ajax({
			url: "<c:url value='/qxsepmny/student/admAjaxStudClearPw.do'/>"
			, type: "post"
			, data: "memberVO="+$("#detailForm").serialize()
			, dataType:"json"
			, success: function(data){
				alert(data.message);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
}

function fn_clearLogin(){
	if(confirm('해당 학생의 로그인 횟수를 초기화하시겠습니까?')){
		$.ajax({
			url: "<c:url value='/qxsepmny/student/admAjaxStdClearLogin.do'/>"
			, type: "post"
			, data: "memberCode="+$("#memberCode").val()
			, dataType:"json"
			, success: function(data){
				alert(data.message);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
}

//이미지 썸네일 
var InputImage = 
	 (function loadImageFile() {
	    if (window.FileReader) {
	        var ImagePre; 
	        var ImgReader = new window.FileReader();
	        var fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i; 
	 
	        ImgReader.onload = function (Event) {
	            if (!ImagePre) {
	                var newPreview = document.getElementById("imagePreview");
	                ImagePre = new Image();
	                ImagePre.style.width = "113px";
	                ImagePre.style.height = "151px";
	                newPreview.appendChild(ImagePre);
	            }
	            ImagePre.src = Event.target.result;
	            
	        };
	 
	        return function () {
	         
	            var img = document.getElementById("upload_file").files;
	           
	            if (!fileType.test(img[0].type)) { 
	             alert("이미지 파일을 업로드 하세요"); 
	             return; 
	            }
	            
	            ImgReader.readAsDataURL(img[0]);
	        }
	 
	    }
	   
	            document.getElementById("imagePreview").src = document.getElementById("upload_file").value;
	 
	      
	})();

$(document).ready(function(){
		$("#attachFile").css("display", "block" );
		$("#imagePreview").css("display", "none" );
		$("#imgUpdate").css("display", "none" );
		$("#openVisa").css("display", "none" );
		$("#closeVisa_btn").css("display", "none" );
		$("#openIns").css("display", "none" );
		$("#closeIns_btn").css("display", "none" );
		fn_hide()
		$("#personal").css("display", "" );
		$("input:radio[name='tabs']:radio[value='']").prop('checked', true); 
});  
 
function previwe(){
	$("#attachFile").css("display", "none" );
	$("#imagePreview").css("display", "block" );
	$("#imgUpdate").css("display", "block" );
};

function openVisa(){
	$("#openVisa").css("display", "block" );
	$("#openVisa_btn").css("display", "none" );
	$("#closeVisa_btn").css("display", "inline-block" );
	var memberCode = $("#memberCode").val();
	$.ajax({
		url: "<c:url value='/qxsepmny/student/openVisa.do'/>"
		, type: "post"
		, data: "memberCode="+memberCode
		, dataType:"json"
	});
}
function closeVisa(){
	$("#openVisa").css("display", "none" );
	$("#openVisa_btn").css("display", "inline-block" );
	$("#closeVisa_btn").css("display", "none" );
}
function openIns(){
	$("#openIns").css("display", "block" );
	$("#openIns_btn").css("display", "none" );
	$("#closeIns_btn").css("display", "inline-block" );
	var memberCode = $("#memberCode").val();
	$.ajax({
		url: "<c:url value='/qxsepmny/student/openIns.do'/>"
		, type: "post"
		, data: "memberCode="+memberCode
		, dataType:"json"
	});
}
function insFileDown(){
	var memberCode = $("#memberCode").val();
	$.ajax({
		url: "<c:url value='/qxsepmny/student/insFileDown.do'/>"
		, type: "post"
		, data: "memberCode="+memberCode
		, dataType:"json"
	});
}
function closeIns(){
	$("#openIns").css("display", "none" );
	$("#openIns_btn").css("display", "inline-block" );
	$("#closeIns_btn").css("display", "none" );
}
function openTable(){
	alert('접근 권한이 없습니다.');
}
var $input = $("#fileName");
$("#fileName").on('input', function() {
    console.log("Input text changed!" + $(this).val());
    (function ($) {
        var originalVal = $.fn.val;
        $.fn.val = function (value) {
            var res = originalVal.apply(this, arguments);
     
            if (this.is('input:text') && arguments.length >= 1) {
                // this is input type=text setter
                this.trigger("input");
            }
     
            return res;
        };
    })(jQuery);

});

$(function(){
	$("#upload_file").change(function(){
		var fileValue = $('#upload_file').val().split("\\");
		var fileName = fileValue[fileValue.length-1];
		var extension = fileName.split(".")[1].toUpperCase();
	
 		/* if(extension != 'JPG'){
			alert('JPG만이 첨부 가능합니다');
			$('#upload_file').val('');
			return;
		} */
 		
		$("#fileName").val(fileName);
	});
});

function fn_modify(){
	var memberCode = $("#memberCode").val();
	$("#detailForm").attr("action","<c:out value='${pageContext.request.contextPath}/qxsepmny/student/admStudImgUpdate.do'/>").submit();
}

//tab
function fn_hide(){
	$("#personal").css("display", "none" );
	$("#register").css("display", "none" );
	$("#grade").css("display", "none" );
	$("#consul").css("display", "none" );
}
function fn_tab(menu){
	$("#menuType").val(menu);
	if(menu == ''){
		fn_hide();
		$("input:radio[name='tabs']:radio[value='']").prop('checked', true); 
		$("#personal").css("display", "" ); 
		$("#editBtn").css("display", "" ); 
		$("#delBtn").css("display", "" );
	}else if(menu == '2'){
		fn_hide();
		$("input:radio[name='tabs']:radio[value='2']").prop('checked', true);
		$("#register").css("display", "" );
		$("#editBtn").css("display", "none" ); 
		$("#delBtn").css("display", "none" );
	}else if(menu == '3'){
		fn_hide();
		$("input:radio[name='tabs']:radio[value='3']").prop('checked', true);
		$("#grade").css("display", "" );
		$("#editBtn").css("display", "none" ); 
		$("#delBtn").css("display", "none" );
	}else if(menu == '4'){
		fn_hide();
		$("input:radio[name='tabs']:radio[value='4']").prop('checked', true);
		$("#consul").css("display", "" );
		$("#editBtn").css("display", "none" ); 
		$("#delBtn").css("display", "none" );
	}
}
// //tab
</script>
<body>
<form:form commandName="memberVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
<form:hidden path="memberSeq" value="${result.memberSeq }"/>
<form:hidden path="memberCode" value="${result.memberCode }"/>
<input type="hidden" id="visaOpenYN" value=""/>
<input type="hidden" id="insOpenYN" value=""/>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="학생"/>
		            <jsp:param name="dept2" value="학생현황"/>
	           	</jsp:include>
				<p class="sub-title">기본 정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col style="width:20%;" />
							<col style="width:20%;" />
						</colgroup>
						<tbody>
							<tr>
								<th>학번</th>
								<td>
									<c:out value="${result.memberCode }" />
								</td>
								<th>급수</th>
								<td>
									<c:out value="${result.step }" />급
								</td>
								<td rowspan="4">
									<div id="attachFile" style="text-align: center; margin-top: 15px;"><img src="<c:url value='/showImage.do?filePath=${result.imgPath}'/>"  alt="<c:out value="${result.imgName}"/>" style="width:113px; height:151px; text-align: center;"/></div>
									<div id="imagePreview" style="text-align: center; margin-top: 15px;"></div>
								</td>
							</tr>
							<tr>
								<th>성명</th>
								<td colspan="3">
									<c:out value="${result.name }" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${result.eName }" />
								</td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td>
									<c:out value="${result.birthYear }" />-<c:out value="${result.birthMonth }" />-<c:out value="${result.birthDay }" />
								</td>
								<th>성별</th>
								<td>
									<c:out value="${result.gender }" />
								</td>
							</tr>
							<tr>
								<th>국적</th>
								<td>
									<c:out value="${result.nation }" />
								</td>
								<th>출생국</th>
								<td>
									<c:out value="${result.depart }" />
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>
									<c:out value="${result.status }" />
								</td>
								<th>사진첨부</th>
								<td colspan="2">
									<input type="text" value="<c:out value='${attachList != null?result.imgName:"파일선택" }'/>" class="input-data" id="fileName" disabled="disabled">
									<label for="upload_file" class="btn-upload-file" >파일업로드</label>
									<input type="file" class="hidden" id="upload_file" name="upload_file" onclick="previwe();" onchange="InputImage();"/>
									<div id="imgUpdate" style="float: right;" ><button type="button" class="white btn-save" onclick="fn_modify(); return false;">저장</button></div>
									<form:hidden path="imgPath"/>
								</td>
							</tr>
							<tr>
								<th>과정</th>
								<td>
									<c:out value="${result.stdCurr }" />
								</td>
								<th>학생구분</th>
								<td colspan="2">
								<c:choose>
								<c:when test="${result.stdType eq 1}">교환학생</c:when>
								<c:when test="${result.stdType eq 2}">한국어교육과정생(어학연수생)</c:when>
								<c:when test="${result.stdType eq 3}">학부(유학생)</c:when>
								<c:when test="${result.stdType eq 4}">대학원(유학생)</c:when>
								</c:choose>
								</td>
							</tr>
							<tr>
								<th>입학일자</th>
								<td>
									<c:out value="${result.appDate }" />
								</td>
								<th>TOPIK취득</th>
								<td>
									<c:if test="${!empty result.tpStep || result.tpStep eq '' }">
										<c:out value="${result.tpStep }" />급 <c:out value="${result.tpScore }" />점  취득일자 : <c:out value="${result.tpDate }" />
									</c:if>
								</td>
							</tr>
							<tr>
								<th>수강현황</th>
								<td colspan="4">
									<c:forEach items="${lectList }" var="lect">
										<p>
											<c:out value="${lect.lectYear }년"/>&nbsp;
											<c:out value="${lect.lectSem }"/>&nbsp;
											<c:out value="${lect.lectName }"/>&nbsp;
											<c:out value="${lect.lectDivi }"/>&nbsp;/&nbsp;
											<c:out value="${lect.grade }급"/>&nbsp;
											<c:out value="${lect.compleSta }"/>
										</p>
									</c:forEach>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="tab-box">
					<form:hidden path="menuType"/>
					<input id="tab1" type="radio" name="tabs" value="" >
					<input id="tab2" type="radio" name="tabs" value="2" >
					<input id="tab3" type="radio" name="tabs" value="3" >
					<input id="tab4" type="radio" name="tabs" value="4" >
<!-- 					<input id="tab5" type="radio" name="tabs" value="5" > -->
					<div class="tab-btn">
						<label for="tab1" class="tab1" onclick="fn_tab(''); return false;">신상</label>
						<label for="tab2" class="tab2" onclick="fn_tab('2'); return false;">학적</label>
						<label for="tab3" class="tab3" onclick="fn_tab('3'); return false;">성적</label>
						<label for="tab4" class="tab4" onclick="fn_tab('4'); return false;">상담</label>
<!-- 						<label for="tab5" class="tab5" onclick="fn_tab('5'); return false;">결석경고</label> -->
					</div>
				
					<div id="personal">
						<!-- table -->
						<p class="sub-title">사용정보</p>
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:10%;" />
									<col style="width:40%;" />
									<col style="width:10%;" />
									<col style="width:40%;" />
								</colgroup>
								<tbody>
									<tr>
										<th><sup>*</sup>비밀번호</th>
										<td>
		<%-- 									<input type="password" id="memberPw" value="<c:out value="${result.memberPw }" />">  --%>
											<button class="normal-btn" onclick="fn_clearPw(); return false;">비밀번호초기화</button>
											<button class="normal-btn" onclick="fn_clearLogin(); return false;">로그인횟수 초기화</button>
										</td>
										<th>최근접속일시</th>
										<td>
											<c:out value="${result.loginDateTime }" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table -->
		
						<p class="sub-title">학력 사항</p>
						<!-- table -->
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:10%;" />
									<col style="width:40%;" />
									<col style="width:10%;" />
									<col style="width:40%;" />
								</colgroup>
								<tbody>
									<tr>
										<th>최종학력</th>
										<td>
											<c:out value="${result.finalEdu }" />
										</td>
										<th>학교명</th>
										<td>
											<c:out value="${result.feSchoolname }" />
										</td>
									</tr>
									<tr>
										<th>국가</th>
										<td>
											<c:out value="${result.feCountry }" />
										</td>
										<th>재학기간</th>
										<td>
											<c:out value="${result.feDateS }" /> ~ <c:out value="${result.feDateE }" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table -->
		
						<p class="sub-title">연수 계획</p>
						<!-- table -->
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:10%;" />
									<col style="width:40%;" />
									<col style="width:10%;" />
									<col style="width:40%;" />
								</colgroup>
								<tbody>
									<tr>
										<th>한국어 연수경험</th>
										<td>
										<c:choose>
										<c:when test="${result.trExperience eq 'N'}">연수경험 없음</c:when>
										<c:when test="${result.trExperience eq 'Y'}">연수경험 있음</c:when>
										</c:choose>
											<c:out value="" />
										</td>
										<th>프로그램 인지경로</th>
										<td>
										<c:choose>
										<c:when test="${result.trGetpath eq '1'}">한성대학 학생</c:when>
										<c:when test="${result.trGetpath eq '2'}">지인(친구,가족등)</c:when>
										<c:when test="${result.trGetpath eq '3'}">홈페이지</c:when>
										<c:when test="${result.trGetpath eq '4'}">팸플릿</c:when>
										<c:when test="${result.trGetpath eq '5'}">기타</c:when>
										</c:choose>
										</td>
									</tr>
									<tr>
										<th>연수 예정기간</th>
										<td colspan="3">
											<c:out value="${result.trTerm }" />개 학기
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table -->
		
						<p class="sub-title">연락처</p>
						<!-- table -->
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:10%;" />
									<col style="width:10%;" />
									<col style="width:35%;" />
									<col style="width:10%;" />
									<col style="width:35%;" />
								</colgroup>
								<tbody>
									<tr>
										<th><sup>*</sup>개인연락처</th>
										<td class="txt-c">SNS</td>
										<td colspan="3">
											<c:out value="${result.naSns }" />
										</td>
									</tr>
									<tr>
										<th rowspan="2">본국</th>
										<td class="txt-c">전화번호</td>
										<td colspan="3">
											<c:out value="${result.naTel }" />
										</td>
									</tr>
									<tr>
										<td class="txt-c">주소</td>
										<td colspan="3">
											<c:out value="${result.naAddr }" />
										</td>
									</tr>
									<tr>
										<th rowspan="2">국내 주소</th>
										<td class="txt-c">전화번호</td>
										<td>
		<%-- 									<c:out value="${result.tel1 }" />-<c:out value="${result.tel2 }" />-<c:out value="${result.tel3 }" /> --%>
											<c:out value="${result.tel }" />
										</td>
										<th>이메일</th>
										<td>
		<%-- 									<c:out value="${result.emailId }" />@<c:out value="${result.emailAdr }" /> --%>
										<c:out value="${result.email }" />
										</td>
									</tr>
									<tr>
										<td class="txt-c">주소<br />(현거주지)</td>
										<td colspan="3">
											<ul>
												<li class="mb5"><c:out value="${result.post }" /></li>
												<li>
													<c:out value="${result.addr1 }" /> <c:out value="${result.addr2 }" />
												</li>
											</ul>
										</td>
									</tr>
									<tr>
										<th rowspan="3">비상시 연락처</th>
										<td class="txt-c">이름</td>
										<td>
											<c:out value="${result.emerName }" />
										</td>
										<th>관계</th>
										<td>
											<c:out value="${result.emerRelation }" />
										</td>
									</tr>
									<tr>
										<td class="txt-c">전화번호</td>
										<td>
		<%-- 									<c:out value="${result.tel1Emer }" />-<c:out value="${result.tel2Emer }" />-<c:out value="${result.tel3Emer }" /> --%>
											<c:out value="${result.telEmer }" />
										</td>
										<th>이메일</th>
										<td>
		<%-- 									<c:out value="${result.emailEmerId }" />@<c:out value="${result.emailEmerAdr }" /> --%>
											<c:out value="${result.emailEmer }" />
										</td>
									</tr>
									<tr>
										<td class="txt-c">주소</td>
										<td colspan="3">
											<ul>
												<li class="mb5"><c:out value="${result.postEmer }" /></li>
												<li>
													<c:out value="${result.addr1Emer }" /> <c:out value="${result.addr2Emer }" />
												</li>
											</ul>
										</td>
									</tr>
		
									<tr>
										<th rowspan="3">국내 신원보증인</th>
										<td class="txt-c">이름</td>
										<td>
											<c:out value="${result.guarName }" />
										</td>
										<th>관계</th>
										<td>
											<c:out value="${result.guarRelation }" />
										</td>
									</tr>
									<tr>
										<td class="txt-c">전화번호</td>
										<td>
		<%-- 									<c:out value="${result.tel1Guar }" />-<c:out value="${result.tel2Guar }" />-<c:out value="${result.tel3Guar }" /> --%>
											<c:out value="${result.telGuar }" />
										</td>
										<th>이메일</th>
										<td>
		<%-- 									<c:out value="${result.emailGuarId }" />@<c:out value="${result.emailGuarAdr }" /> --%>
											<c:out value="${result.emailGuar }" />
										</td>
									</tr>
									<tr>
										<td class="txt-c">주소</td>
										<td colspan="3">
											<ul>
												<li class="mb5"><c:out value="${result.postGuar }" /></li>
												<li>
													<c:out value="${result.addr1Guar }" /> <c:out value="${result.addr2Guar }" />
												</li>
											</ul>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table -->
					<c:set var="dtl" value="<%=adminVO.getDtlYn() %>" />
						<p class="sub-title" style="float: left;">비자 및 여권</p>
						<c:if test="${dtl eq 'Y' }">
							&nbsp;&nbsp;<button type="button"  onclick="openVisa()" id="openVisa_btn" class="white btn-list">펼쳐보기</button>
							<button type="button"  onclick="closeVisa()" id="closeVisa_btn" class="white btn-list">닫기</button>
						</c:if>
						<c:if test="${dtl eq 'N' || dtl eq ''  }">
							&nbsp;&nbsp;<button type="button"  onclick="openTable()" class="white btn-list">펼쳐보기</button>
						</c:if>
						<br />
						<br />
						<!-- table -->
						<div class="list-table-box" id="openVisa">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:10%;" />
									<col style="width:40%;" />
									<col style="width:10%;" />
									<col style="width:40%;" />
								</colgroup>
								<tbody>
									<tr>
										<th>비자종류</th>
										<td>
											<c:choose>
											<c:when test="${empty result.visa1 }"><c:out value="${result.visa2 }" /></c:when>
											<c:when test="${result.visa1 eq '1'}">D-4</c:when>
											<c:when test="${result.visa1 eq '2'}">C-3</c:when>
											<c:when test="${result.visa1 eq '3'}"><c:out value="${result.visa2 }" /></c:when>
											<c:otherwise><c:out value="${result.visa1 }" /></c:otherwise>
											</c:choose>
										</td>
										<th>한국입국일</th>
										<td>
											<c:out value="${result.entryDate }" />
										</td>
									</tr>
									<tr>
										<th>비자발급일자</th>
										<td>
											<c:out value="${result.issueDate }" />
										</td>
										<th>비자만료일자</th>
										<td>
											<c:out value="${result.expiryDate }" />
										</td>
									</tr>
									<tr>
										<th>외국인등록증발급일</th>
										<td>
											<c:out value="${result.rcIsDate }" />
										</td>
										<th>외국인등록번호</th>
										<td>
											<c:out value="${result.rcCode }" />
										</td>
									</tr>
									<tr>
										<th>여권번호</th>
										<td>
											<c:out value="${result.pNumber }" />
										</td>
										<th>여권발급일자</th>
										<td>
											<c:out value="${result.pIsDate }" />
										</td>
									</tr>
									<tr>
										<th>여권유효기간</th>
										<td colspan="3">
											<c:out value="${result.pValidity }" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table -->
		<br />
						<p class="sub-title" style="float: left;">보험증권및은행</p>
						
						<c:if test="${dtl eq 'Y' }">
							&nbsp;&nbsp;<button type="button"  onclick="openIns()" id="openIns_btn" class="white btn-list">펼쳐보기</button>
							<button type="button"  onclick="closeIns()" id="closeIns_btn" class="white btn-list">닫기</button>
						</c:if>
						<c:if test="${dtl eq 'N' || dtl eq ''  }">
							&nbsp;&nbsp;<button type="button"  onclick="openTable()" class="white btn-list">펼쳐보기</button>
						</c:if>
						<br />
						<br />
						<!-- table -->
						<div class="list-table-box" id="openIns">
							<table class="normal-wmv-table">
								<colgroup>
									<col style="width:10%;" />
									<col style="width:40%;" />
									<col style="width:10%;" />
									<col style="width:40%;" />
								</colgroup>
								<tbody>
									<tr>
										<th>보험회사</th>
										<td>
											<c:out value="${result.insCompany }" />
										</td>
										<th>증권번호</th>
										<td>
											<c:out value="${result.stockNumber }" />
										</td>
									</tr>
									<tr>
										<th>보험가입 기간</th>
										<td colspan="3">
											<c:out value="${result.insSdate }" /> ~ <c:out value="${result.insEdate }" />
										</td>
									</tr>
									<tr>
										<th>은행명</th>
										<td>
											<c:out value="${result.bName }" />
										</td>
										<th>예금주</th>
										<td>
											<c:out value="${result.bAccount }" />
										</td>
									</tr>
									<tr>
										<th>계좌번호</th>
										<td colspan="3">
											<c:out value="${result.bNumber }" />
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td colspan="3">
											<c:forEach items="${attachList }" var="attach">
												<p>
													<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>" onclick="insFileDown();">
														<c:out value="${attach.orgFileName }" />
													</a>
												</p>
											</c:forEach>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// table -->
					</div>
					<div id="register">
					<p class="sub-title">학적정보</p>
						<!-- table -->
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col width="7%" />
									<col  />
									<col  />
									<col  />
									<col  />
									<col  />
									<col  />
								</colgroup>
								<tbody>
									<tr>
										<th>No.</th>
										<th>학기</th>
										<th>급/반</th>
										<th>성적</th>
										<th>출석율(%)</th>
										<th>급수</th>
										<th>수료</th>
									</tr>
									<c:forEach var="result" items="${regiList }" varStatus="status">
										<tr>
											<td><c:out value="${regiList.size()-status.index}"/></td>
											<td>
												<c:if test="${result.lectYear ne '' }">
													<c:out value="${result.lectYear }"/>년 <c:out value="${result.lectSem }"/>
												</c:if>
											</td>
											<td>
												<c:set var = "string1" value = "${result.lectName }"/>
											    <c:set var = "length" value = "${fn:length(string1)}"/>
											    <c:set var = "string2" value = "${fn:substring(string1, length -1, length)}" />
											    <c:if test="${string2.matches('[0-9]+') }">
											    	<c:out value="${string2 }"/>급
											    </c:if>
											    <c:if test="${!string2.matches('[0-9]+') }">
											    	1급
											    </c:if>
												<c:if test="${result.lectName ne '' && result.lectDivi ne ''}">/</c:if>
												<c:out value="${result.lectDivi }"/>
											</td>
	<%-- 										<td style="<c:out value="${result.midterm < 70?'color:#fc6039':'' }"/>"><c:out value="${result.midterm }"/></td> --%>
	<%-- 										<td style="<c:out value="${result.finals < 70?'color:#fc6039':'' }"/>"><c:out value="${result.finals }"/></td> --%>
											<td><c:out value="${result.finals eq null?'':(result.midterm+result.finals)/2 }"/></td>
											<td><c:out value="${result.gradeAttnd }"/></td>
											<td><c:out value="${result.grade }"/>급</td>
											<td><c:out value="${result.compleSta }"/></td>
										</tr>
									</c:forEach>
									<c:if test="${empty regiList }">
										<tr>
											<td colspan="7">학적정보가 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>
					</div>					
					<div id="grade">
					<p class="sub-title">성적정보</p>
						<!-- table -->
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col width="7%" />
									<col  />
									<col  />
									<col  />
									<col  />
									<col  />
									<col  />
									<col  />
								</colgroup>
								<tbody>
									<tr>
										<th rowspan="3">No.</th>
										<th rowspan="3">학기</th>
										<th rowspan="3">급/반</th>
										<th colspan="4">영역별 평균</th>
										<th rowspan="3">평균</th>
									</tr>
									<tr>
										<th colspan="2">표현능력</th>
										<th colspan="2">이해능력</th>
									</tr>
									<tr>
										<th>말하기</th>
										<th>쓰기</th>
										<th>듣기</th>
										<th>읽기</th>
									</tr>
									<c:forEach var="result" items="${gradeList }" varStatus="status">
										<tr>
											<td><c:out value="${gradeList.size()-status.index}"/></td>
											<td>
												<c:if test="${result.lectYear ne '' }">
													<c:out value="${result.lectYear }"/>년 <c:out value="${result.lectSem }"/>
												</c:if>
											</td>
											<td>
												<c:set var = "string1" value = "${result.lectName }"/>
											    <c:set var = "length" value = "${fn:length(string1)}"/>
											    <c:set var = "string2" value = "${fn:substring(string1, length -1, length)}" />
											    <c:if test="${string2.matches('[0-9]+') }">
											    	<c:out value="${string2 }"/>급
											    </c:if>
											    <c:if test="${!string2.matches('[0-9]+') }">
											    	1급
											    </c:if>
												<c:out value="${result.lectDivi }"/>
											</td>
											<td style="<c:out value='${result.avgSpeak < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgSpeak }"/></td>
											<td style="<c:out value='${result.avgWrite < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgWrite }"/></td>
											<td style="<c:out value='${result.avgListen < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgListen }"/></td>
											<td style="<c:out value='${result.avgRead < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgRead }"/></td>
											<td style="<c:out value='${result.avgTotal < 70?"color:#fc6039":"" }'/>"><c:out value="${result.avgTotal }"/></td>
										</tr>
									</c:forEach>
									<c:if test="${empty gradeList }">
										<tr>
											<td colspan="8">성적정보가 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>
					</div>	
					<div id="consul">
					<p class="sub-title">상담정보</p>
						<!-- table -->
						<c:forEach var="result" items="${consulList }">
							<div class="list-table-box">
								<table class="normal-wmv-table">
									<colgroup>
										<col width="15%" />
										<col width="35%" />
										<col width="15%" />
										<col width="35%" />
									</colgroup>
									<tbody>
										<tr>
											<th>상담일자</th>
											<td><c:out value="${result.consultdate }"/></td>
											<th>상담자</th>
											<td><c:out value="${result.profcode }"/></td>
										</tr>
										<tr>
											<th>상담구분</th>
											<td><c:out value="${result.consulttype }"/></td>
											<th>상담장소</th>
											<td><c:out value="${result.place }"/></td>
										</tr>
										<tr>
											<th>상담내용</th>
											<td colspan="3"><c:out value="${result.content }" escapeXml="false"/></td>
										</tr>
									</tbody>
								</table>
							</div>
						</c:forEach>
									<c:if test="${empty consulList }">
										<div class="list-table-box">
								<table class="normal-wmv-table">
									<colgroup>
										<col width="15%" />
										<col width="35%" />
										<col width="15%" />
										<col width="35%" />
									</colgroup>
									<tbody>
										<tr>
											<th>상담일자</th>
											<td></td>
											<th>상담자</th>
											<td></td>
										</tr>
										<tr>
											<th>상담구분</th>
											<td></td>
											<th>상담장소</th>
											<td></td>
										</tr>
										<tr>
											<th>상담내용</th>
											<td colspan="3">상담정보가 없습니다.</td>
										</tr>
									</tbody>
								</table>
							</div>
									</c:if>
					</div>		
				</div>			
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admStatusList.do'/>" class="white btn-list">목록</a>
						<a href="#" onclick="edit()" id="editBtn" class="white btn-list">수정</a>
						<a href="#" onclick="del()"id="delBtn"  class="white btn-list">삭제</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
	</form:form>
</body>
</html>