<%@page import="lcms.valueObject.AdminVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%
	String admMenuNo = ((String)session.getAttribute("admMenuNo")!=null)?(String)session.getAttribute("admMenuNo"):"";
	AdminVO adminVO = ((AdminVO)session.getAttribute("adminSessionLcms")!=null)?(AdminVO)session.getAttribute("adminSessionLcms"):null;
%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_list(){
		$("#listFrm").attr("action", "<c:url value='/qxsepmny/student/admStatusList.do'/>").submit();
	}
	
	function fn_mailadr(el){
		var addr = $(el).val();
		if('' == addr){	$("#emailAdr").removeAttr('disabled');
		}else{	$("#emailAdr").attr('disabled', 'true');
		}
		$("#emailAdr").val(addr);
	}	
	function fn_mailadr1(el){
		var addr = $(el).val();
		if('' == addr){	$("#emailEmerAdr").removeAttr('disabled');
		}else{	$("#emailEmerAdr").attr('disabled', 'true');
		}
		$("#emailEmerAdr").val(addr);
	}	
	function fn_mailadr2(el){
		var addr = $(el).val();
		if('' == addr){	$("#emailGuarAdr").removeAttr('disabled');
		}else{	$("#emailGuarAdr").attr('disabled', 'true');
		}
		$("#emailGuarAdr").val(addr);
	}
	

	/* 등록하기 */
	function fn_modify(){
		var memberCode = $("#memberCode").val();
		var post = $("#post").val();
		var postEmer = $("#postEmer").val();
		var postGuar = $("#postGuar").val();

		var dtl=$("#yn").val();
		
		$("#emailAdr").removeAttr('disabled');
		$("#emailEmerAdr").removeAttr('disabled');
		$("#emailGuarAdr").removeAttr('disabled');
		
		var memberPw = $("#memberPw").val();
		var name  = $("#name").val();
		var eName  = $("#eName").val();
		var birthYear  = $("#birthYear").val();
		var birthMonth  = $("#birthMonth").val();
		var birthDay  = $("#birthDay").val();
		var appDate  = $("#datepicker01").val();
		var tpStep  = $("#tpStep").val();
		var tpScore   = $("#tpScore ").val();
		var tpDate  = $("#datepicker13").val();
		var naSns  = $("#naSns").val();
		var naTel  = $("#naTel").val();
		var naAddr  = $("#naAddr").val();
		var entryDate  = $("#datepicker04").val();
		var issueDate  = $("#datepicker05").val();
		var expiryDate  = $("#datepicker06").val();
		var pNumber  = $("#pNumber").val();
		var pIsDate  = $("#datepicker09").val();
		var pValidity  = $("#datepicker10").val();
		var insCompany  = $("#insCompany").val();
		var stockNumber  = $("#stockNumber").val();
		var insSdate  = $("#datepicker11").val();
		var insEdate  = $("#datepicker12").val();
		var bName  = $("#bName").val();
		var bAccount  = $("#bAccount").val();
		var bNumber  = $("#bNumber").val();
		
		// != 경우 한글
		var kor= /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g; 
		// 영어+숫자
		var eng = /^[a-zA-Z0-9 ]*$/; 
		// 숫자
		var num= /[^0-9]/g;
		
		if(appDate == null || appDate == ''){				alert("입학일자를 선택해 주세요."); 	 	$("#datepicker01").focus();
		}else if(memberCode == null || memberCode == ''){	alert("학번을 입력해 주세요."); 	 		$("#memberCode").focus();
		}else if((name == null || name == '') && (eName == null || eName == '')){		alert("이름을 입력해 주세요."); 	 	
			if(name == null || name == ''){	$("#name").focus();	}else{	$("#eName").focus();}
		}else if(kor.test(name)){   	alert("한글만 입력해 주세요."); 	 	$("#name").focus();	
		}else if(!eng.test(eName.trim())){   	alert("영어만 입력해 주세요."); 	 	$("#eName").focus();
		}else if(birthYear == null || birthYear == '' || birthMonth == null || birthMonth == '' || birthDay == null || birthDay == ''){		alert("생년월일을 입력해 주세요."); 	 	$("#birthYear").focus();
		}else if(memberPw == null || memberPw == ''){		alert("비밀번호를 입력해 주세요."); 	 	$("#memberPw").focus();
		}else if(naTel == null || naTel == ''){				alert("본국 전화번호를 입력해 주세요."); 	 	$("#naTel").focus();
		}else if(naAddr == null || naAddr == ''){			alert("본국 주소를 입력해 주세요."); 	 	$("#naAddr").focus();
		
	//	}else if(entryDate == null || entryDate == ''){		alert("한국 입국일을 선택해 주세요."); 	 	$("#datepicker04").focus();
	//	}else if(issueDate == null || issueDate == ''){		alert("비자 발급일자를 선택해 주세요."); 	 	$("#datepicker05").focus();
		}else if(expiryDate == null || expiryDate == ''){	alert("비자 만료일자를 선택해 주세요."); 	 	$("#datepicker06").focus();
		}else if(pNumber == null || pNumber == ''){			alert("여권번호를 입력해 주세요."); 	 	$("#pNumber").focus();
	//	}else if(pIsDate == null || pIsDate == ''){			alert("여권 발급일자를 선택해 주세요."); 	 	$("#datepicker09").focus();
	//	}else if(pValidity == null || pValidity == ''){		alert("여권 유효기간을 선택해 주세요."); 	 	$("#datepicker10").focus();
		
		}else if(insCompany == null || insCompany == ''){	alert("보험회사 이름을 입력해 주세요."); 	 	$("#insCompany").focus();
		}else if(stockNumber == null || stockNumber == ''){	alert("증권번호를 입력해 주세요."); 	 	$("#stockNumber").focus();
		}else if(insSdate == null || insSdate == '' || insEdate == null || insEdate == ''){		alert("보험 가입기간을 선택해 주세요."); 	 	$("#datepicker11").focus();
		}else{
		$("#frm").attr("action","<c:out value='${pageContext.request.contextPath}/qxsepmny/student/admStudUpdate.do'/>").submit();
		}
	}
	
	$(function(){
		$("#upload_file").change(function(){
			var fileValue = $('#upload_file').val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
	 		
			$("#fileName").val(fileName);
			$("#deleteFile").val($("#deleteFileSeq").val());
		});

		$("#upload_img").change(function(){
			var fileValue = $('#upload_img').val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
	 		
			$("#imgName").val(fileName);
		});
	});
	
// 	학번 중복체크
	function fn_check(){
		var memberCode = $("#memberCode").val();
		
		if(memberCode == ''){
			alert('학번을 입력해 주세요');
			return;
		}
		$.ajax({
			url: "<c:url value='/qxsepmny/student/admAjaxStudCheck.do'/>"
			, type: "post"
			, data: "memberCode="+memberCode
			, dataType:"json"
			, success: function(data){
				var status = data.status;
				var message = data.message;
				
				if(!status){
					$("#memberCode").val('');
				}else{
					$("#memberCode").val(memberCode);
				}
				alert(message);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	/* 비밀번호 초기화 */
	function fn_clearPw(){
		if(confirm('해당 학생의 비밀번호를 초기화하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/qxsepmny/student/admAjaxStudClearPw.do'/>"
				, type: "post"
				, data: "memberVO="+$("#frm").serialize()
				, dataType:"json"
				, success: function(data){
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
// 		document.getElementById('memberPw').value='';
	}
	
// 비자>기타 일때 input칸 활성화
function visa(val){
	if(val == '3'){
		$("#visa2").removeAttr('disabled');
	}else{
		$("#visa2").attr('disabled', 'true');
	}
}


// select box 연도 , 월 표시
$(document).ready(function(){
    setDateBox();
    
	//아래 메뉴 두개 접근 권한처리
	$("#openVisa").css("display", "none" );
	$("#closeVisa_btn").css("display", "none" );
	$("#openIns").css("display", "none" );
	$("#closeIns_btn").css("display", "none" );
});    

function setDateBox(){
    var dt = new Date();
    var year = "";
    var com_year = dt.getFullYear();
    // 발행 뿌려주기
    $("#birthYear").append("<option value=''>년도</option>");
    // 올해 기준으로 년도 표시
    for(var y = (com_year-70); y <= (com_year); y++){
    	 $("#birthYear").append("<option value='"+ y +"'>"+ y +"</option>"); 
    }
    $("#birthYear").val('<c:out value="${memberVO.birthYear }"/>');
    // 월 뿌려주기(1월부터 12월)
    
    var month = "";
    $("#birthMonth").append("<option value=''>월</option>");
    for(var i = 1; i <= 12; i++){
        $("#birthMonth").append("<option value='"+ i +"'>"+ i + " 월" +"</option>");
    }
    $("#birthMonth").val(parseInt('<c:out value="${memberVO.birthMonth }"/>')).prop("selected","selected");
}
//년과 월에 따라 마지막 일 구하기 
function lastday(){ 
	var Year=document.getElementById('birthYear').value;
	var Month=document.getElementById('birthMonth').value;
	var day=new Date(new Date(Year,Month,1)-86400000).getDate();
	var dayindex_len=document.getElementById('birthDay').length;
	
	$("#birthDay").append("<option value=''>일</option>");
	if(day>dayindex_len){
		for(var i=(dayindex_len+1); i<=day; i++){
			document.getElementById('birthDay').options[i-1] = new Option(i, i);
		}
	}
	else if(day<dayindex_len){
		for(var i=dayindex_len; i>=day; i--){
			document.getElementById('birthDay').options[i]=null;
		}
	}
    $("#birthDay").val(parseInt('<c:out value="${memberVO.birthDay }"/>'));
}

	
function fn_hakbun(){
	var year = $("#datepicker01").val();
	var gubun = $("#stdType").val();
	
	if(year == '' || gubun == ''){
		alert('입학일자를 입력해 주세요');
		$("input:checkbox[id='txt-auto']").prop("checked", false);
		return;
	}
	
	if(year != '' && gubun != ''){
		$.ajax({
			url: "<c:url value='/qxsepmny/student/admAjaxStudCreateHakbun.do'/>"
			, type: "post"
			, data: "appDate="+year+"&stdType="+gubun
			, dataType:"json"
			, success: function(data){
				var stdCode = data.stdCode;
				document.getElementById('memberCode').value=stdCode;
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
}


// 이미지 썸네일 
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
	            var img = document.getElementById("upload_img").files;
	           
	            if (!fileType.test(img[0].type)) { 
	             alert("이미지 파일을 업로드 하세요"); 
	             return; 
	            }
	            ImgReader.readAsDataURL(img[0]);
	        }
	    }
	            document.getElementById("imagePreview").src = document.getElementById("upload_img").value;
	})();

$(document).ready(function(){
	if($("#fileName").val() == '파일선택'){
		$("#attachFile").css("display", "none" );
		$("#imagePreview").css("display", "block" );
	}else{
		$("#attachFile").css("display", "block" );
		$("#imagePreview").css("display", "none" );
	}
});  

function previwe(){
	$("#attachFile").css("display", "none" );
	$("#imagePreview").css("display", "block" );
};

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

function openVisa(){
	$("#openVisa").css("display", "block" );
	$("#openVisa_btn").css("display", "none" );
	$("#closeVisa_btn").css("display", "inline-block" );
	var memberCode = $("#memberCode").val();
// 	$.ajax({
// 		url: "<c:url value='/qxsepmny/student/openVisa.do'/>"
// 		, type: "post"
// 		, data: "memberCode="+memberCode
// 		, dataType:"json"
// 	});
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
// 	$.ajax({
// 		url: "<c:url value='/qxsepmny/student/openIns.do'/>"
// 		, type: "post"
// 		, data: "memberCode="+memberCode
// 		, dataType:"json"
// 	});
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

function fn_file_del(idx){
	$("#deleteFile"+idx).val($("#deleteFileSeq"+idx).val());
	$("#file_p"+idx).remove();
}

function fn_add(){
	var cnt = $("#file_div p").length;
	
	var html = '';
	html += '<p class="file-upload" id="file_p'+cnt+'">';
	html += '	<input type="text" value="파일선택" class="input-data" id="fileName'+cnt+'" disabled="disabled">';
	html += '	<label for="upload_file'+cnt+'" class="btn-upload-file" >파일업로드</label>';
	html += '	<input type="file" class="hidden" id="upload_file'+cnt+'" name="upload_file'+cnt+'" onchange=""/>';
	html += '	<button type="button" name="delButton">x</button>';
	html += '</p>';
	
	$("#file_div").append(html);
	
	$("button[name='delButton']").on('click',function(e){
		e.preventDefault(); 
		$(this).parent().remove();
	});
	
	$("#upload_file"+cnt).change(function(){
		var fileValue = $('#upload_file'+cnt).val().split("\\");
		var fileName = fileValue[fileValue.length-1];
		var extension = fileName.split(".")[1].toUpperCase();
 		
		$("#fileName"+cnt).val(fileName);
	});
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
					<jsp:param name="dept1" value="학생"/>
		            <jsp:param name="dept2" value="학생현황"/>
	           	</jsp:include>
	           	<form:form commandName="memberVO" id="frm" name="frm" enctype="multipart/form-data">
				<form:hidden path="memberSeq"/>
				<p class="sub-title">기본 정보</p>
				<!-- table -->
				<div class="list-table-box">
							<%

							Date date = new Date();
							SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
							String strdate = simpleDate.format(date);
							
							%>
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
							<th><sup>*</sup>학생구분</th>
								<td>
									<form:select path="stdType">
										<form:option value="1">교환학생</form:option>
										<form:option value="2">어학연수생</form:option>
										<form:option value="3">학부생(유학생)</form:option>
										<form:option value="4">대학원(유학생)</form:option>
									</form:select>
								</td>
								<th><sup>*</sup>입학일자</th>
								<td>
									<input type="text" id="datepicker01" name="appDate" placeholder="<%= strdate%>" value="<c:out value="${memberVO.appDate }" />">
								</td>
								<td rowspan="5">
<%-- 									<img src="<c:out value='/showImage.do?filePath=${attachList[0].regFileName}'/>"  alt="<c:out value="${attachList[0].orgFileName}"/>" style="width:113px; height:151px; text-align: center;"/> --%>
<%-- 								<c:if test="${attachList[0].regFileName eq null}" > --%>
<!-- 									<div id="imagePreview" style="text-align: center;"></div> -->
<%-- 								</c:if> --%>
								<div id="attachFile" style="text-align: center; margin-top: 15px;"><img src="<c:url value='/showImage.do?filePath=${memberVO.imgPath}'/>"  alt="<c:out value="${memberVO.imgName}"/>" style="width:113px; height:151px; text-align: center;"/></div>
								<div id="imagePreview" style="text-align: center; margin-top: 15px;"></div>
								<br>								
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>학번</th>
								<td>
									<c:if test="${memberVO.memberSeq ne '' && memberVO.memberSeq != null }">
										<input type="text" id="memberCode" name="memberCode" class="input-data w173px" readonly="readonly" value="${memberVO.memberCode }"/>
									</c:if>
									<c:if test="${memberVO.memberSeq eq '' || memberVO.memberSeq == null }">
										<input type="text" id="memberCode" name="memberCode" class="input-data w173px" readonly="readonly" value="${memberVO.memberCode }"/>
										<button type="button" class="normal-btn" onclick="fn_check();">중복확인</button>&nbsp;&nbsp;&nbsp;
									</c:if>
									<input type="checkbox" id="txt-auto" onchange="fn_hakbun(); return false;"/> <label for="txt-auto">자동생성</label>
<%-- 									<form:hidden path="memberCode"/> --%>
								</td>
								<th><sup>*</sup>급수</th>
								<td>
									<form:select path="step">
										<form:option value="1">1급</form:option>
										<form:option value="2">2급</form:option>
										<form:option value="3">3급</form:option>
										<form:option value="4">4급</form:option>
										<form:option value="5">5급</form:option>
										<form:option value="6">6급</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>성명</th>
								<td colspan="3">
									한글 <form:input path="name" class="input-data"/>&nbsp;&nbsp;&nbsp;
									영문 <form:input path="eName" class="input-data"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>생년월일</th>
								<td>
									<form:select path="birthYear"></form:select> 년&nbsp;&nbsp;
									<form:select path="birthMonth" onchange="javascript:lastday();" >
<%-- 										<form:option value="">월</form:option> --%>
<%-- 										<c:forEach begin="1" end="12" var="month"> --%>
<%-- 											<form:option value="${month }" ><c:out value="${month }"/></form:option> --%>
<%-- 										</c:forEach> --%>
									</form:select> 월&nbsp;&nbsp;
									<c:if test="${empty memberVO.birthDay || memberVO.birthDay eq ''}"><form:select path="birthDay"></form:select> 일</c:if>
									<c:if test="${!empty memberVO.birthDay}"><form:input path="birthDay" value="${memberVO.birthDay }" style="width:40px;" /> 일</c:if>
								</td>
								<th><sup>*</sup>성별</th>
								<td>
									<input type="radio" id="gender-m" name="gender" value="남" <c:if test="${memberVO.gender eq '남'}"> checked = "checked" </c:if> checked="checked"/> <label for="gender-m">남</label>&nbsp;&nbsp;
									<input type="radio" id="gender-w" name="gender" value="여" <c:if test="${memberVO.gender eq '여'}"> checked = "checked" </c:if> /> <label for="gender-w">여</label>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>국적</th>
								<td>
									<select id="nation" name="nation">
										<c:forEach var="result" items="${Country}">
											<option value="${result.name}"<c:if test="${result.name eq memberVO.nation}">selected="selected"</c:if>>${result.name}</option>
										</c:forEach>
									</select>
								</td>
								<th><sup>*</sup>출생국</th>
								<td>
									<select id="depart" name="depart">
										<c:forEach var="result" items="${Country}">
											<option value="${result.name}"<c:if test="${result.name eq memberVO.depart}">selected="selected"</c:if>>${result.name}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>상태</th>
								<td>
									<ul>
										<li class="mb5">
											<input type="radio" name="status" id="statu01" value="신입" <c:if test="${memberVO.status eq '신입'}"> checked = "checked" </c:if> checked="checked"/> <label for="statu01">신입</label>&nbsp;&nbsp;
											<input type="radio" name="status" id="statu02" value="재학" <c:if test="${memberVO.status eq '재학'}"> checked = "checked" </c:if>/> <label for="statu02">재학</label>&nbsp;&nbsp;
											<input type="radio" name="status" id="statu03" value="휴학" <c:if test="${memberVO.status eq '휴학'}"> checked = "checked" </c:if>/> <label for="statu03">휴학</label>&nbsp;&nbsp;
											<input type="radio" name="status" id="statu04" value="유급" <c:if test="${memberVO.status eq '유급'}"> checked = "checked" </c:if>/> <label for="statu04">유급</label>&nbsp;&nbsp;
											<input type="radio" name="status" id="statu05" value="수료" <c:if test="${memberVO.status eq '수료'}"> checked = "checked" </c:if>/> <label for="statu05">수료</label>
										</li>
										<li>
											<input type="radio" name="status" id="statu06" value="미등록" <c:if test="${memberVO.status eq '미등록'}"> checked = "checked" </c:if>/> <label for="statu06">미등록</label>&nbsp;&nbsp;
											<input type="radio" name="status" id="statu07" value="자퇴" <c:if test="${memberVO.status eq '자퇴'}"> checked = "checked" </c:if>/> <label for="statu07">자퇴</label>&nbsp;&nbsp;
											<input type="radio" name="status" id="statu08" value="퇴학" <c:if test="${memberVO.status eq '퇴학'}"> checked = "checked" </c:if>/> <label for="statu08">퇴학</label>&nbsp;&nbsp;
											<input type="radio" name="status" id="statu09" value="행방불명" <c:if test="${memberVO.status eq '행방불명'}"> checked = "checked" </c:if>/> <label for="statu09">행방불명</label>
										</li>
									</ul>
								</td>
								<th>사진첨부</th>
								<td colspan="2">
									<input type="text" value="<c:out value='${memberVO.imgName ne ""?memberVO.imgName:"파일선택" }'/>" class="input-data" id="imgName" disabled="disabled">
									<label for="upload_img" class="btn-upload-file" >파일업로드</label>
									<input type="file" class="hidden" id="upload_img" name="upload_img" onclick="previwe();" onchange="InputImage();"/>
									<form:hidden path="imgPath"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>과정</th>
								<td>
									<select id="stdCurr" name="stdCurr">
										<option value="정규과정" <c:if test="${memberVO.stdCurr eq '정규과정' }">selected="selected"</c:if> >정규과정</option>
										<option value="특별과정" <c:if test="${memberVO.stdCurr eq '특별과정' }">selected="selected"</c:if> >특별과정</option>
									</select>
								</td>
								<th>TOPIK취득</th>
								<td colspan="5">
									<form:select path="tpStep">
										<form:option value="">선택</form:option>
										<form:option value="1">1급</form:option>
										<form:option value="2">2급</form:option>
										<form:option value="3">3급</form:option>
										<form:option value="4">4급</form:option>
										<form:option value="5">5급</form:option>
										<form:option value="6">6급</form:option>
									</form:select>
									<form:input path="tpScore" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/>&nbsp;점&nbsp;&nbsp;
									<input type="text" id="datepicker13" name="tpDate" placeholder="<%= strdate%>" value="${memberVO.tpDate }">
								</td>
							</tr>
							
							

						</tbody>
					</table>
				</div>
				<!--// table -->

			<p class="sub-title">사용정보</p>
<!-- 				table -->
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
									<input type="password" class="input-data" id="memberPw" name="memberPw" value="${memberVO.memberPw }"/> 
									<button class="normal-btn" onclick="fn_clearPw(); return false;">비밀번호초기화</button>
								</td>
								<th>최근접속일시</th>
								<td>
									<c:out value="${memberVO.loginDateTime }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
<!-- 				// table -->

				<p class="sub-title">학력 사항</p>
<!-- 				table -->
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
								<th><sup>*</sup>최종학력</th>
								<td>
									<ul>
										<li>
											<input type="radio" name="finalEdu" id="edu01" value="고졸"  <c:if test="${memberVO.finalEdu eq '고졸'}"> checked = "checked" </c:if> checked="checked"/> <label for="edu01">고졸</label>&nbsp;&nbsp;
											<input type="radio" name="finalEdu" id="edu02" value="대졸"  <c:if test="${memberVO.finalEdu eq '대졸'}"> checked = "checked" </c:if> /> <label for="edu02">대졸</label>&nbsp;&nbsp;
											<input type="radio" name="finalEdu" id="edu03" value="석사"  <c:if test="${memberVO.finalEdu eq '석사'}"> checked = "checked" </c:if> /> <label for="edu03">석사</label>&nbsp;&nbsp;
											<input type="radio" name="finalEdu" id="edu04" value="박사"  <c:if test="${memberVO.finalEdu eq '박사'}"> checked = "checked" </c:if> /> <label for="edu04">박사</label>
										</li>
									</ul>
								</td>
								<th>학교명</th>
								<td>
									<input type="text" class="input-data w100p" id="feSchoolname" name="feSchoolname" value="${memberVO.feSchoolname }"/>
								</td>
							</tr>
							<tr>
								<th>국가</th>
								<td>
									<input type="text" class="input-data w100p" id="feCountry" name="feCountry" value="${memberVO.feCountry }"/>
								</td>
								<th>재학기간</th>
								<td>
									<input type="text" id="datepicker02" name="feDateS" placeholder="<%= strdate%>" value="${memberVO.feDateS }"> -
									<input type="text" id="datepicker03" name="feDateE" placeholder="<%= strdate%>" value="${memberVO.feDateE }">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
<!-- 				// table -->

				<p class="sub-title">연수 계획</p>
<!-- 				table -->
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
								<th><sup>*</sup>한국어 연수경험</th>
								<td>
									<ul>
										<li>
											<input type="radio" name="trExperience" id="trExperience01" value="Y" <c:if test="${memberVO.trExperience eq 'Y'}"> checked = "checked" </c:if> checked="checked"/> <label for="trExperience01">예</label>&nbsp;&nbsp;
											<input type="radio" name="trExperience" id="trExperience02" value="N" <c:if test="${memberVO.trExperience eq 'N'}"> checked = "checked" </c:if> /> <label for="trExperience02">아니오</label>
										</li>
									</ul>
								</td>
								<th><sup>*</sup>프로그램 인지경로</th>
								<td>
									<select id="trGetpath" name="trGetpath">
										<option value="1" <c:if test="${memberVO.trGetpath eq '1' }">selected="selected"</c:if>>한성대학학생</option>
										<option value="2" <c:if test="${memberVO.trGetpath eq '2' }">selected="selected"</c:if>>지인(친구,가족  등)</option>
										<option value="3" <c:if test="${memberVO.trGetpath eq '3' }">selected="selected"</c:if>>홈페이지</option>
										<option value="4" <c:if test="${memberVO.trGetpath eq '4' }">selected="selected"</c:if>>팸플릿</option>
										<option value="5" <c:if test="${memberVO.trGetpath eq '5' }">selected="selected"</c:if>>기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>연수 예정기간</th>
								<td colspan="3">
									<ul>
										<li>
											<input type="radio" name="trTerm" id="trTerm01" value="1" <c:if test="${memberVO.trTerm eq '1'}"> checked = "checked" </c:if> checked="checked"/> <label for="trTerm01">1개학기</label>&nbsp;&nbsp;
											<input type="radio" name="trTerm" id="trTerm02" value="2" <c:if test="${memberVO.trTerm eq '2'}"> checked = "checked" </c:if>/> <label for="trTerm02">2개학기</label>&nbsp;&nbsp;
											<input type="radio" name="trTerm" id="trTerm03" value="3" <c:if test="${memberVO.trTerm eq '3'}"> checked = "checked" </c:if>/> <label for="trTerm03">3개학기</label>&nbsp;&nbsp;
											<input type="radio" name="trTerm" id="trTerm04" value="4" <c:if test="${memberVO.trTerm eq '4'}"> checked = "checked" </c:if>/> <label for="trTerm04">4개학기</label>&nbsp;&nbsp;
										</li>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
<!-- 				// table -->

				<p class="sub-title">연락처</p>
<!-- 				table -->
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
								<th>개인연락처</th>
								<td class="txt-c">SNS</td>
								<td colspan="3">
									<input type="text" class="input-data w100p" id="naSns" name="naSns" value="${memberVO.naSns }"/>
								</td>
							</tr>
							<tr>
								<th rowspan="2"><sup>*</sup>본국</th>
								<td class="txt-c">전화번호</td>
								<td colspan="3">
									<input type="text" class="input-data w100p" id="naTel" name="naTel" value="${memberVO.naTel }"/>
								</td>
							</tr>
							<tr>
								<td class="txt-c">주소</td>
								<td colspan="3">
									<input type="text" class="input-data w100p" id="naAddr" name="naAddr" value="${memberVO.naAddr }"/>
								</td>
							</tr>
							<tr>
								<th rowspan="2">국내 주소</th>
								<td class="txt-c">전화번호</td>
								<td>
									<form:input path="tel1" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> -
									<form:input path="tel2" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
									<form:input path="tel3" class="input-data w63px" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
								</td>
								<th>이메일</th>
								<td>
									<form:input path="emailId" class="input-data w100px"/> @
										<form:input path="emailAdr" class="input-data w100px" value="${memberVO.emailAdr }" disabled="true"/>
										<select onchange="fn_mailadr(this); return false;">
											<option>선택</option>
											<option value="hansung.ac.kr" <c:if test="${memberVO.emailAdr eq 'hansung.ac.kr' }">selected="selected"</c:if> >hansung.ac.kr</option>
											<option value="naver.com" <c:if test="${memberVO.emailAdr eq 'naver.com' }">selected="selected"</c:if> >naver.com</option>
											<option value="gmail.com" <c:if test="${memberVO.emailAdr eq 'gmail.com' }">selected="selected"</c:if> >gmail.com</option>
											<option value="">직접입력</option>
										</select>
								</td>
							</tr>
							<tr>
								<td class="txt-c">주소<br />(현거주지)</td>
								<td colspan="3">

										<ul>
											<li class="mb5"><form:input path="post" class="input-data w100px" /> <a href="#" onclick="execDaumPostcode(''); return false;" class="normal-btn">우편번호검색</a></li>
											<li>
												<form:input path="addr1" class="input-data w49pc" />
												<form:input path="addr2" class="input-data w49pc" />
											</li>
										</ul>
								</td>
							</tr>
							<tr>
								<th rowspan="3">비상시 연락처</th>
								<td class="txt-c">이름</td>
								<td>
									<input type="text" class="input-data w100pc" id="emerName" name="emerName" value="${memberVO.emerName }" />
								</td>
								<th>관계</th>
								<td>
									<input type="text" class="input-data w100pc" id="emerRelation" name="emerRelation" value="${memberVO.emerRelation}" />
								</td>
							</tr>
							<tr>
								<td class="txt-c">전화번호</td>
								<td>
									<input type="text" class="input-data w63px" id="tel1Emer" name="tel1Emer" value="${memberVO.tel1Emer}" /> -
									<input type="text" class="input-data w63px" id="tel2Emer" name="tel2Emer" value="${memberVO.tel2Emer}" /> -
									<input type="text" class="input-data w63px" id="tel3Emer" name="tel3Emer" value="${memberVO.tel3Emer}" />
								</td>
								<th>이메일</th>
								<td>
									<form:input path="emailEmerId" class="input-data w100px"/> @
										<form:input path="emailEmerAdr" class="input-data w100px"  value="${memberVO.emailEmerAdr }" disabled="true"/>
										<select onchange="fn_mailadr1(this); return false;">
											<option>선택</option>
											<option value="hansung.ac.kr" <c:if test="${memberVO.emailEmerAdr eq 'hansung.ac.kr' }">selected="selected"</c:if> >hansung.ac.kr</option>
											<option value="naver.com" <c:if test="${memberVO.emailEmerAdr eq 'naver.com' }">selected="selected"</c:if> >naver.com</option>
											<option value="gmail.com" <c:if test="${memberVO.emailEmerAdr eq 'gmail.com' }">selected="selected"</c:if> >gmail.com</option>
											<option value="">직접입력</option>
										</select>
								</td>
							</tr>
							<tr>
								<td class="txt-c">주소</td>
								<td colspan="3">
									<ul>
										<li class="mb5"><form:input class="input-data w100px" path="postEmer"/> <a href="#" onclick="execDaumPostcode('Emer'); return false;" class="normal-btn">우편번호검색</a></li>
										<li>
											<form:input class="input-data w49pc" path="addr1Emer"/>
											<form:input class="input-data w49pc" path="addr2Emer"/>
										</li>
									</ul> 
								</td>
							</tr>

							<tr>
								<th rowspan="3">국내 신원보증인</th>
								<td class="txt-c">이름</td>
								<td>
									<input type="text" class="input-data w100pc" id="guarName" name="guarName" value="${memberVO.guarName }"/>
								</td>
								<th>관계</th>
								<td>
									<input type="text" class="input-data w100pc" id="guarRelation" name="guarRelation" value="${memberVO.guarRelation }"/>
								</td>
							</tr>
							<tr>
								<td class="txt-c">전화번호</td>
								<td>
									<input type="text" class="input-data w63px" id="tel1Guar" name="tel1Guar" value="${memberVO.tel1Guar }"/> -
									<input type="text" class="input-data w63px" id="tel2Guar" name="tel2Guar" value="${memberVO.tel2Guar }"/> -
									<input type="text" class="input-data w63px" id="tel3Guar" name="tel3Guar" value="${memberVO.tel3Guar }"/>
								</td>
								<th>이메일</th>
								<td>
									<form:input path="emailGuarId" class="input-data w100px"/> @
										<form:input path="emailGuarAdr" class="input-data w100px"  value="${memberVO.emailGuarAdr }" disabled="true"/>
										<select onchange="fn_mailadr2(this); return false;">
											<option>선택</option>
											<option value="hansung.ac.kr" <c:if test="${memberVO.emailGuarAdr eq 'hansung.ac.kr' }">selected="selected"</c:if> >hansung.ac.kr</option>
											<option value="naver.com" <c:if test="${memberVO.emailGuarAdr eq 'naver.com' }">selected="selected"</c:if> >naver.com</option>
											<option value="gmail.com" <c:if test="${memberVO.emailGuarAdr eq 'gmail.com' }">selected="selected"</c:if> >gmail.com</option>
											<option value="">직접입력</option>
										</select>
								</td>
							</tr>
							<tr>
								<td class="txt-c">주소</td>
								<td colspan="3">
									<ul>
										<li class="mb5"><form:input path="postGuar" class="input-data w100px"/> <a href="#" onclick="execDaumPostcode('Guar'); return false;" class="normal-btn">우편번호검색</a></li>
										<li>
											<form:input path="addr1Guar" class="input-data w49pc"/>
											<form:input path="addr2Guar" class="input-data w49pc"/>
										</li>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
<!-- 				// table -->
<c:set var="dtl" value="<%=adminVO.getDtlYn() %>" />
<input type="hidden" id="yn" value="<%=adminVO.getDtlYn() %>"/>
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
<!-- 				table -->
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
								<th><sup>*</sup>비자종류</th>
								<td>
									<select id="visa1" name="visa1" onchange="visa(this.value)">
										<option value="1" <c:if test="${memberVO.visa1 eq '1' }">selected="selected"</c:if> >D-4</option>
										<option value="2" <c:if test="${memberVO.visa1 eq '2' }">selected="selected"</c:if> >C-3</option>
										<option value="3" <c:if test="${memberVO.visa1 eq '3' }">selected="selected"</c:if> >기타</option>
									</select>
									<input type="text" class="input-data" id="visa2" name="visa2" value="${memberVO.visa2 }" disabled="disabled"/>
								</td>
								<th>한국입국일</th>
								<td>
									<input type="text" id="datepicker04" placeholder="<%= strdate%>" name="entryDate" value="${memberVO.entryDate }">
								</td>
							</tr>
							<tr>
								<th>비자발급일자</th>
								<td>
									<input type="text" id="datepicker05" placeholder="<%= strdate%>" name="issueDate" value="${memberVO.issueDate }">
								</td>
								<th><sup>*</sup>비자만료일자</th>
								<td>
									<input type="text" id="datepicker06" placeholder="<%= strdate%>" name="expiryDate" value="${memberVO.expiryDate }">
								</td>
							</tr>
							<tr>
								<th>외국인등록증발급일</th>
								<td>
									<input type="text" id="datepicker07" placeholder="<%= strdate%>" name="rcIsDate" value="${memberVO.rcIsDate }">
								</td>
								<th>외국인등록번호</th>
								<td>
									<input type="text" class="input-data w173px" id="rcCode" name="rcCode" value="${memberVO.rcCode }"/>
<!-- 									<input type="text" id="datepicker08" placeholder="<%= strdate%>"> -->
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>여권번호</th>
								<td>
									<input type="text" class="input-data w173px" id="pNumber" name="pNumber" value="${memberVO.pNumber }"/>
								</td>
								<th>여권발급일자</th>
								<td>
									<input type="text" id="datepicker09" placeholder="<%= strdate%>" name="pIsDate" value="${memberVO.pIsDate }">
								</td>
							</tr>
							<tr>
								<th>여권유효기간</th>
								<td colspan="3">
									<input type="text" id="datepicker10" name="pValidity" value="${memberVO.pValidity }" placeholder="<%= strdate%>"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
<!-- 				// table -->

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
<!-- 				table -->
				<div class="list-table-box">
					<table class="normal-wmv-table" id="openIns">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col style="width:40%;" />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>보험회사</th>
								<td>
									<form:input class="input-data w173px" path="insCompany"/>
								</td>
								<th><sup>*</sup>증권번호</th>
								<td>
									<input type="text" class="input-data w173px" id="stockNumber" name="stockNumber" value="${memberVO.stockNumber }" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>보험가입 기간</th>
								<td colspan="3">
									<input type="text" id="datepicker11" placeholder="<%= strdate%>" name="insSdate" value="${memberVO.insSdate }" > -
									<input type="text" id="datepicker12" placeholder="<%= strdate%>" name="insEdate" value="${memberVO.insEdate }" >
								</td>
							</tr>
							<tr>
								<th>은행명</th>
								<td>
									<input type="text" class="input-data w173px" id="bName" name="bName" value="${memberVO.bName }" />
								</td>
								<th>예금주</th>
								<td>
									<input type="text" class="input-data w173px" id="bAccount" name="bAccount" value="${memberVO.bAccount }" />
								</td>
							</tr>
							<tr>
								<th>계좌번호</th>
								<td colspan="3">
									<input type="text" class="input-data w173px" id="bNumber" name="bNumber" value="${memberVO.bNumber }" />
								</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td colspan="3">
									<div id="file_div">
										<p class="file-upload">
											<input type="text" value="파일선택" class="input-data" id="fileName" disabled="disabled">
											<label for="upload_file" class="btn-upload-file" >파일업로드</label>
											<input type="file" class="hidden" id="upload_file" name="upload_file"/>
											<button type="button" name="addButton" onclick="fn_add(); return false;">+</button>
										</p>
									</div>
									<c:if test="${attachList != null }">
										<c:forEach items="${attachList }" var="attach" varStatus="status">
											<p class="file-upload" id="file_p<c:out value='${status.index }'/>">
												<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>" onclick="insFileDown();">
													<c:out value="${attach.orgFileName }" />
												</a>
												<button type="button" name="delButton" onclick="fn_file_del('<c:out value='${status.index }'/>'); return false;">x</button>
											</p>
											<input type="hidden" id="deleteFileSeq<c:out value='${status.index }'/>" value='<c:out value="${attach.attachSeq }"/>'/>
											<input type="hidden" id="deleteFile<c:out value='${status.index }'/>" name="deleteFile"/>
										</c:forEach>
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			<!-- //  table -->
			
			
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admStatusList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_modify(); return false;">저장</button>
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
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>