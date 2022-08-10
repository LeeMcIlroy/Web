<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	$(function(){
		if($("#datepicker02").val() != ''){
			$("#status").removeAttr('disabled');
		}
		
		$("#datepicker02").change(function(){
			var date = $(this).val();
			
			if(date != ''){
				$("#status").removeAttr('disabled');
			}
		});
	});

	function fn_list(){
		$("#listFrm").attr("action", "<c:url value='/qxsepmny/admstr/admProfList.do'/>").submit();
	}
	
	function fn_mailadr(el){
		var addr = $(el).val();
		
		if('' == addr){
			$("#emailAdr").removeAttr('disabled');
		}else{
			$("#emailAdr").attr('disabled', 'true');
		}
		$("#emailAdr").val(addr);
	}
	
	function fn_modify(){
		var memberCode = $("#memberCode").val();
		
		if(memberCode == ''){
			alert('교번 중복확인을 해주세요.');
			return;
		}
		
		$("#emailAdr").removeAttr('disabled');
		$("#status").removeAttr('disabled');
		$("#frm").attr("action","<c:url value='/qxsepmny/admstr/admProfUpdate.do'/>").submit();
	}
	
	function fn_check(){
		var memberCode = $("#bfCode").val();
		
		if(memberCode == ''){
			alert('교번을 입력해 주세요');
			return;
		}
		$.ajax({
			url: "<c:url value='/qxsepmny/admstr/admAjaxProfCheck.do'/>"
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
	
	function fn_clearPw(){
		if(confirm('해당 교사의 비밀번호를 초기화하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/qxsepmny/admstr/admAjaxProfClearPw.do'/>"
				, type: "post"
				, data: "memberVO="+$("#frm").serialize()
				, dataType:"json"
				, success: function(data){
					var message = data.message;
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}

	function fn_clearLogin(){
		if(confirm('해당 교사의 로그인 횟수를 초기화하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/qxsepmny/admstr/admAjaxProfClearLogin.do'/>"
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
	
	function previwe(){
		$("#attachFile").css("display", "none" );
		$("#imagePreview").css("display", "block" );
		$("#imgUpdate").css("display", "block" );
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
</script>
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="교사"/>
	           	</jsp:include>
	           	<form:form commandName="memberVO" id="frm" name="frm" enctype="multipart/form-data">
	           		<form:hidden path="memberSeq"/>
					<p class="sub-title">기본 정보</p>
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-wmv-table">
							<colgroup>
								<col style="width:10%;" />
								<col style="width:55%;" />
								<col style="width:10%;" />
								<col style="width:25%;" />
							</colgroup>
							<tbody>
								<tr>
									<th><sup>*</sup>교번</th>
									<td colspan="2">
										<c:if test="${memberVO.memberSeq ne '' && memberVO.memberSeq != null }">
											<c:out value="${memberVO.memberCode }"/>
										</c:if>
										<c:if test="${memberVO.memberSeq eq '' || memberVO.memberSeq == null }">
											<input type="text" id="bfCode" class="input-data w173px" placeholder="" />
											<a href="#" onclick="fn_check();" class="normal-btn">중복확인</a>
										</c:if>
										<form:hidden path="memberCode"/>
									</td>
									<td rowspan="4">
										<div id="attachFile" style="text-align: center; margin-top: 15px;"><img src="<c:url value='/showImage.do?filePath=${memberVO.imgPath}'/>"  alt="<c:out value="${memberVO.imgName}"/>" style="width:113px; height:151px; text-align: center;" /></div>
										<div id="imagePreview" style="text-align: center; margin-top: 15px;"></div>
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>성명</th>
									<td colspan="2">
										한글 <form:input path="name" class="input-data w173px" placeholder="" />&nbsp;&nbsp;&nbsp;&nbsp;
										한자 <form:input path="hName" class="input-data w173px" placeholder="" />&nbsp;&nbsp;&nbsp;&nbsp;
										영문 <form:input path="eName" class="input-data w173px" placeholder="" />
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>생년월일</th>
									<td colspan="2">
										<c:set var="now" value="<%=new java.util.Date()%>" />
										<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 
										<form:select path="birthYear">
											<c:forEach begin="0" end="100" var="num">
												<form:option value="${sysYear-num }">${sysYear-num }</form:option>
											</c:forEach>
										</form:select> 년&nbsp;&nbsp;
										<form:input path="birthMonth" class="input-data w63px txt-r" maxlength="2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/> 월&nbsp;&nbsp;
										<form:input path="birthDay" class="input-data w63px txt-r" maxlength="2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"/> 일
									</td>
								</tr>
								<c:forEach items="${subList }" var="subList">
									<tr>
										<th>강사구분</th>
										<td><c:out value="${subList.prfFGubun }"/></td>
									</tr>
									<tr>
										<th>소속 / 직함</th>
										<td><c:out value="${subList.prfTBelong }"/> / <c:out value="${subList.prfTPosition }"/></td>
										<th>사진첨부</th>
										<td>
											<input type="text" value="<c:out value='${attachList != null?result.imgName:"파일선택" }'/>" class="input-data" id="fileName" disabled="disabled">
											<label for="upload_file" class="btn-upload-file" >파일업로드</label>
											<input type="file" class="hidden" id="upload_file" name="upload_file" onclick="previwe();" onchange="InputImage();"/>
											<form:hidden path="imgPath"/>
										</td>
									</tr>
									<tr>
										<th>최근강의</th>
										<td>
											<c:out value="${subList.prfSYear }"/>  <c:out value="${subList.prfSSem }"/> <c:out value="${subList.prfSStep }"/> <c:out value="${subList.prfSDivi }"/> <c:out value="${subList.prfSPosition }"/>
										</td>
										<th>누적시수</th>
										<td>
											<fmt:parseNumber var="sumhour" value="${subList.sumhour }" integerOnly="true" />
											<c:out value="${ sumhour}"/>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${subList.size() eq 0 }">
									<tr>
										<th>강사구분</th><td></td>
									</tr>
									<tr>
										<th>소속 / 직함</th><td></td>
										<th>사진첨부</th>
										<td>
											<input type="text" value="<c:out value='${attachList != null?result.imgName:"파일선택" }'/>" class="input-data" id="fileName" disabled="disabled">
											<label for="upload_file" class="btn-upload-file" >파일업로드</label>
											<input type="file" class="hidden" id="upload_file" name="upload_file" onclick="previwe();" onchange="InputImage();"/>
											<form:hidden path="imgPath"/>
										</td>
									</tr>
									<tr>
										<th>최근강의</th><td></td>
										<th>누적시수</th><td></td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<!--// table -->
	
					<p class="sub-title">재직정보</p>
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
									<th><sup>*</sup>임용일자</th>
									<td>
										<form:input path="appDate" id="datepicker01" />
									</td>
									<th>퇴사일자</th>
									<td>
										<form:input path="resDate" id="datepicker02" />
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>재직상태</th>
									<td colspan="3">
										<form:select path="status" disabled="true">
											<form:option value="재직">재직</form:option>
											<form:option value="퇴사">퇴사</form:option>
										</form:select>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
	
					<p class="sub-title">연락처정보</p>
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
									<th><sup>*</sup>주소</th>
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
									<th><sup>*</sup>전화번호</th>
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
									<th><sup>*</sup>e-mail</th>
									<td colspan="3">
										<form:input path="emailId" class="input-data w100px" /> @
										<form:input path="emailAdr" class="input-data w100px" value="hansung.ac.kr" disabled="true"/>
										<select onchange="fn_mailadr(this); return false;">
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
	
					<p class="sub-title">사용정보</p>
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
									<th><sup>*</sup>비밀번호</th>
									<td colspan="<c:out value="${memberVO.memberSeq == null || memberVO.memberSeq eq ''?'3':'1' }"/>">
										<c:if test="${memberVO.memberSeq == null || memberVO.memberSeq eq '' }">
											<input type="password" class="input-data w173px" placeholder="" />
										</c:if>
										<c:if test="${memberVO.memberSeq != null && memberVO.memberSeq ne '' }">
											<a href="#" onclick="fn_clearPw(); return false;" class="normal-btn">비밀번호초기화</a>
											<a href="#" onclick="fn_clearLogin(); return false;" class="normal-btn">로그인횟수 초기화</a>
										</c:if>
									</td>
									<c:if test="${memberVO.memberSeq != null && memberVO.memberSeq ne '' }">
										<th>최근접속일시</th>
										<td>
											<c:out value="${memberVO.loginDateTime }"/>
										</td>
									</c:if>
								</tr>
							</tbody>
						</table>
					</div>
					<!--// table -->
				</form:form>
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-list" onclick="fn_list(1); return false;">목록</button>
						<button type="button" class="white btn-save" onclick="fn_modify(); return false;">저장</button>
					</div>
				</div>
				 <c:import url="/EgovPageLink.do?link=adm/admstr/admProfModifySub"/>
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
	<form:form commandName="searchVO" id="listFrm" name="listFrm">
		<form:hidden path="searchCondition1"/>
		<form:hidden path="menuType"/>
		<form:hidden path="searchWord"/>
		<form:hidden path="pageIndex"/>
	</form:form>
</body>
</html>