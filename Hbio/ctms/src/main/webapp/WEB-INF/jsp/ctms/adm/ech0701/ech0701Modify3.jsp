<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	$(function(){
				
		var ynEmail = '<c:out value="${ct1000mVO.email}"/>';
		if(ynEmail == ''){
			$("#emailAdr").attr('value', 'hanmail.net');
		}
				
		// 첨부파일이 있는 경우 파일업로드 버튼을 숨긴다 -- 처리해야함 
		//if(${empty attachList }){
		//	$(".checkfile").show();
		//}else{	
		//	$(".checkfile").hide();
		//}
		
		$("#tab-1").show();
		$("#tab1").addClass("on");
		$("#tab-2").hide();
		$("#tab2").removeClass("on");
		
	
		var ynVal = '<c:out value="${ct1000mVO.useYn}"/>';
			
		switch (ynVal) {
		case 'Y':
			$("#useYn1").attr('checked', 'checked');
	    	break;
		case 'N':
			$("#useYn2").attr('checked', 'checked');
	    	break;	
	  	default:
	  		$("#useYn1").attr('checked', 'checked');
		}
	
		$(".tab_title li").click(function() {
		    var idx = $(this).index();
		    
		    switch (idx) {
			case 0:
				$("#tab-1").show();
				$("#tab1").addClass("on");
				$("#tab-2").hide();
				$("#tab2").removeClass("on");
		    	break;
			case 1:
				$("#tab-1").hide();
				$("#tab1").removeClass("on");
				$("#tab-2").show();
				$("#tab2").addClass("on");
		    	break;	
		  	default:
		  		$("#tab-1").show();
				$("#tab1").addClass("on");
				$("#tab-2").hide();
				$("#tab2").removeClass("on");
			}
		    
		    //$(".tab_title li").removeClass("on");
		    //$(".tab_title li").eq(idx).addClass("on");
		    //$(".tab_cont > div").hide();
		    //$(".tab_cont > div").eq(idx).show();
		  })
		
		
		
		
	});
	
	
	function fn_mailadr(el){
		var addr = $(el).val();
		
		if('' == addr){
			$("#emailAdr").removeAttr('disabled');
		}else{
			$("#emailAdr").attr('disabled', 'true');
		}
		$("#emailAdr").val(addr);
	}




	//CTMS운영사 상세보기로
	function fn_view(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0701/ech0701View.do'/>").submit();
	}
	
	function fn_update(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var useYn = $('#useYn').val();
		var corpName = $('#corpName').val();
		var mngName = $('#mngName').val();
		
		if(useYn==''){
			alert('사용여부를 선택해주세요.');
			$('#useYn').focus();
			return;
		}
		
		if(corpName==''){
			alert('고객사명을 입력해주세요.')
			$('#corpName').focus();
			return;
		}
		
		if(mngName==''){
			alert('담당자명을 입력해주세요.')
			$('#mngName').focus();
			return;
		}
		
		$("#emailAdr").removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0701/ech0701Update.do'/>").submit();
	}	

	//파일업로드  추가. 해당 요소 업로드 제거 핸들링
	$(document).ready(function(){
		   $("#addFile").on("click", function(e){ 
	    	
	    	e.preventDefault(); 
	    	fn_addFile();
	    });
		   $("a[name='delete']").on("click", function(e){ //삭제 버튼 
			   e.preventDefault(); 
		   fn_deleteFile($(this)); 
		   

		});

	});

	//파일업로드 추가
	var file_count = 1;

	function fn_addFile(){
		
	var file_cnt = ++file_count;
	var fileHtml = document.getElementById('fileDiv');
	var fileHtmlCnt = fileHtml.childElementCount; // 자식 요소 카운트

	      if (fileHtmlCnt >= 5) {
			alert('파일첨부는 5개까지만 가능합니다.');
			return false;
	      }else{

	        
	    var html = '<p class="file-upload"><input type="file" class="hidden" id="upload_file_'+(file_cnt)+'" name="file_'+(file_cnt)+'" />';     
	        html += '<label for="upload_file_'+(file_cnt)+'" class="btn_sub" >파일업로드</label>';
	        html +='<input type="text" value="파일선택" class="p30" id="fileName_'+(file_cnt)+'" disabled="disabled" >';
	        html +='<a href="#" name="delete" ><button class="white" style="margin-left: 5px;">x</button></a>';
	        html += '</p>' ;    
	        
	        // 동적추가
	        $("#fileDiv").append(html); 
	        
	        //이 값은 이 값이다.
	        $("#upload_file_"+(file_cnt)).change(function(){ 
	        	if(fileCheck_adm('upload_file_'+(file_cnt))){
	    			var fileValue = $('#upload_file_'+(file_cnt)).val().split("\\");
	    			var fileName = fileValue[fileValue.length-1];
	    			var extension = fileName.split(".")[1].toUpperCase();
	    		
	     		/* if(extension != 'JPG'){
	    			alert('JPG만이 첨부 가능합니다');
	    			$('#upload_file').val('');
	    			return;
	    		} */
	    		$("#fileName_"+(file_cnt)).val(fileName);
	    		}
	         
	        });
	        
	        $("a[name='delete']").on("click", function(e){ //삭제 버튼 
	        	e.preventDefault(); 
	        	
	        fn_deleteFile($(this)); 
	        
	        });
	         
	      }
	}
	//파일업로드 text박스 제거
	function fn_deleteFile(obj){
		obj.parent().remove();
		}


	//파일 업로드. 이 값은 이값이다.
	 $(function(){
		
		 $("#upload_file_0").change(function(){
		
			if(fileCheck_adm('upload_file_0')){
				var fileValue = $('#upload_file_0').val().split("\\");
				var fileName = fileValue[fileValue.length-1];
				var extension = fileName.split(".")[1].toUpperCase();
			
			$("#fileName_0").val(fileName);
	 		/* if(extension != 'JPG'){
				alert('JPG만이 첨부 가능합니다');
				$('#upload_file').val('');
				return;
			} */

		        }
		 });
		 $("a[name='delete_0]").on("click", function(e){ //삭제 버튼 
		      	e.preventDefault(); 
		      	
		      	$("#fileName_0").val('파일선택');
		      
		 });
		 
		});
		
	//고객사관리 첨부파일 개수 조정 10개 -> 로고이미지 1개임
	 function fn_notiTopGubun(notiTopCnt){
		
		 if (notiTopCnt <= 9) {
			$('#noti_top').attr("checked",true);
		}else{
			alert('공지사항은 10개 이하로 해주세요.');
			$('#noti_top').attr("checked",false);
			return false;
		}
	 }
	 
	 // 수정 페이지  기존파일  x 표시 누를시 파일 삭제
	 function fn_xFile(attachNo){
		 var attachNo = attachNo;
		 
		 if (confirm("파일을 삭제하시겠습니까?")) {
			$.ajax({
				url : '<c:url value='/qxsepmny/ech0701/deleteFileUpload.do'/>'
				,type : 'post'
				,data :{'attachNo':attachNo}
				,dataType:'json'
				,success:function(result){
					alert(result.message);										
					window.location.reload();
				},error:function(e){
					alert(e);
				}
			 });
			
		 }
		 $("upload_file_0").removeAttr('disabled');
	 }
	 	
	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>기준정보</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="기준정보"/>
	            <jsp:param name="dept2" value="회사관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <form:form commandName="ct1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
		        <!-- 기본정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">회사명</th>
							<td>
								<input type="text" value="<c:out value="${ct1000mVO.corpName }" />"  class="input-data" id="corpName" name="corpName"/>
							</td>
							<th scope="row" class="bl">회사코드(변경불가)</th>
							<td>
								<input type="text" value="<c:out value="${ct1000mVO.corpCd }" />"  class="input-data" id="corpCd" name="corpCd" readonly />								
							</td>
						</tr>
						<tr>
							<th scope="row">사업자번호</th>
							<td>
								<form:input path="regno1" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> -
								<form:input path="regno2" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"/> -
								<form:input path="regno3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="5"/>
							</td>
							<th scope="row" class="bl">사용여부</th>
							<td>
								<input type="radio" name="useYn" id="useYn1" value="Y" checked="checked" />
							    <label for="useYn1">사용</label>
							    <input type="radio" name="useYn" id="useYn2" value="N"/>
							    <label for="useYn2">미사용</label>
							</td>
						</tr>
						<tr>
							<th scope="row">대표이사</th>
							<td>
								<input type="text" value="<c:out value="${ct1000mVO.excutName }" />"  class="input-data" id="excutName" name="excutName"/>
							</td>
							<th scope="row" class="bl">개인정보책임자</th>
							<td>
								<input type="text" value="<c:out value="${ct1000mVO.privmngName }" />"  class="input-data" id="privmngName" name="privmngName"/>
							</td>
						</tr>
						<tr>
							<th scope="row">홈페이지</th>
							<td>
								<input type="text" value="<c:out value="${ct1000mVO.homepage }" />"  class="input-data" id="homepage" name="homepage"/>
							</td>
							<th scope="row" class="bl">대표전화번호</th>
							<td>
								<form:input path="tel1" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="tel2" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="tel3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
							</td>
						</tr>
						<tr>
							<th scope="row">고객센터번호</th>
							<td>
								<form:input path="ctel1" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="ctel2" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/> -
								<form:input path="ctel3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="4"/>
							</td>
							<th scope="row" class="bl">대표이메일</th>
							<td>
								<form:input path="emailId" class="p30" /> @
								<form:input path="emailAdr" class="p30" disabled="true"/>
								<select class="p30" onchange="fn_mailadr(this); return false;">
									<option value="hanmail.net">hanmail.net</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="">직접입력</option>
								</select>								
							</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td colspan="3">
								<a href="#" onclick="execDaumPostcode(''); return false;" class="btn_sub2">주소검색</a>
								<form:input path="postNo" class="p15" /> <!-- 우편번호 -->
								<form:input path="addrMain" class="ta_l p40" /> <!-- 주소1 -->
								<form:input path="addrGita" class="ta_l p35" placeholder="상세주소" /> <!-- 주소2 -->								
							</td>
						</tr>
						<tr>
							<th scope="row">연구고유번호</th>
							<td>
								<input type="text" value="<c:out value="${ct1000mVO.rsNo1 }" />"  class="input-data" id="rsNo1" name="rsNo1"/>
							</td>
							<th scope="row">IRB심의고유번호</th>
							<td>
								<input type="text" value="<c:out value="${ct1000mVO.rvNo1 }" />"  class="input-data" id="rvNo1" name="rvNo1"/>
							</td>
						</tr>	
						<tr>
							
							<th scope="row">로고이미지</th>
							<td colspan="3">
							<!-- 파일첨부 -->							
							<!-- 
								* 1  input file name 달라야한다.
								* 2  label로 연결 되어있기 때문에 
							      input file의 id와 label의 for가 같아야한다.
								* 3  input text id값으로 접근하여 파일 이름을 집어넣는다.
								*label -for- / input file -name과id- / input text -id-* 
								 -->
								<c:choose>
									<c:when test="${empty attachList }">
										 <div id="fileDiv">
						                    <p class="file-upload">
							                    	<input type="file" class="hidden" id="upload_file_0" name="file_0" />
								                    <label for="upload_file_0" class="btn_sub">파일업로드</label>
							         
							                    <input type="text" value="파일선택" class="p30" id="fileName_0" disabled="disabled" />
											    <a href="#"><button class="white" name="delete_0">x</button></a>
											    <!--<a href="#" id="addFile"><button class="white" >+</button></a> -->											    
									    	</p>
							   			</div>
							        </c:when>
									<c:otherwise>
										<div id="fileDiv">
								 			<c:forEach  items="${attachList }" var="file" varStatus="status">
			                    				<p class="file-upload">
			                    			
			                    						<input type="file" class="hidden" id="upload_file_${status.index }" name="file_${status.index }" />
			                    						<label for="upload_file_${status.index }" class="btn_sub">파일업로드</label>
			                    
			                    					<input type="text" value="${file.orgFileName eq null? '파일선택':file.orgFileName}" class="p30" id="fileName_${status.index }" disabled="disabled" >
							    					<a href="#"><button class="white" name="delete_${status.index }"  onclick="fn_xFile('<c:out value="${file.attachNo}"/>');">x</button></a>
							    					<c:if test="${status.index == 0}">
							    						<!--  <a href="#" id="addFile"><button class="white" >+</button></a>-->
							    					</c:if>
							    				</p>
							   				</c:forEach>
							   			</div>
									</c:otherwise>
								</c:choose>
								<!-- 파일첨부 -->
							</td>							
						</tr>
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 탭버튼 -->
	            <div class="tab_area tab06">
	            
	            	<ul class="tab_title">
	                	<li><a href="#" id="tab1" class="tab-link current on" data-tab="tab-1">이용약관</a></li>
	                	<li><a href="#" id="tab2" class="tab-link" data-tab="tab-2">개인정보처리방침</a></li>
	                </ul>
	            
	                <!-- <ul>
	                	<li><a href="#" class="on">이용약관</a></li>
	                	<li><a href="#">개인정보처리방침</a></li>
	                </ul> -->
	            </div>
	            <!-- //탭버튼 -->
	            <!-- 상세내용 -->
	            <div class="tab_con">
		            <div id="tab-1" class="tab-content current on">
		            	<textarea id="useRule" name="useRule"><c:out value="${ct1000mVO.useRule }" escapeXml="false"/></textarea>
						<script type="text/javascript">
							CKEDITOR.replace( 'useRule', {
							height: 300,
							filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
							});
						</script>	            
		            </div>
		            <div id="tab-2" class="tab-content">
		            	<textarea id="privRule" name="privRule"><c:out value="${ct1000mVO.privRule }" escapeXml="false"/></textarea>
						<script type="text/javascript">
							CKEDITOR.replace( 'privRule', {
							height: 300,
							filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
							});
						</script>	            
		            </div>
	            </div>	            
	            <!-- //상세내용 -->
            </form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_view(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_update(); return false;" >저장</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- 팝업 -->
	<input type="checkbox" id="modi-pop" class="hidden" />
	<div class="black-pop">&nbsp;</div>
	<!-- 주소찾기 -->
	<div class="modi-popup" id="addrPop">
	</div>
	<!--// 주소찾기 -->
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>