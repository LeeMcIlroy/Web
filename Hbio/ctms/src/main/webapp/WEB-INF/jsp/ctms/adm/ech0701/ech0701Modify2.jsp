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
				
		var ynEmail = '<c:out value="${cd1001mVO.cust_excut_email}"/>';
		if(ynEmail == ''){
			$("#emailAdr").attr('value', 'hanmail.net');
		}
		
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
	
	function fn_save(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var use_yn = $('#use_yn').val();
		var branch_name = $('#cust_name').val();
		var mng_name = $('#mng_name').val();
		
		if(use_yn==''){
			alert('사용여부를 선택해주세요.');
			$('#use_yn').focus();
			return;
		}
		
		if(cust_name==''){
			alert('고객사명을 입력해주세요.')
			$('#branch_name').focus();
			return;
		}
		
		if(mng_name==''){
			alert('담당자명을 입력해주세요.')
			$('#mng_name').focus();
			return;
		}
		
		$("#emailAdr").removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0701/ech0701Save.do'/>").submit();
	}	

	function fn_file_del(idx){
		$("#deleteFile"+idx).val($("#deleteFileSeq"+idx).val());
		$("#file_p"+idx).remove();
	}
	
	function fn_add(){
		var cnt = $("#file_div p").length;
		
		var html = '';
		html += '<p id="file_p'+cnt+'">';
		html += '	<input type="file" class="hidden" id="upload_file'+cnt+'" name="upload_file'+cnt+'" onchange=""/>';
		html += '	<label for="upload_file'+cnt+'" class="btn_sub" >파일업로드</label>';
		html += '	<input type="text" value="파일선택" class="p30" id="fileName'+cnt+'" disabled="disabled">';
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
            <form:form commandName="cd1001mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="cust_no" name="cust_no" value="${cd1001mVO.cust_no}">
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
								<input type="text" value="<c:out value="${cd1001mVO.cust_name }" />"  class="input-data" id="cust_name" name="cust_name"/>
							</td>
							<th scope="row" class="bl">사업자번호</th>
							<td>
								<form:input path="regno1" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> -
								<form:input path="regno2" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"/> -
								<form:input path="regno3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="5"/>
							</td>
						</tr>
						<tr>
							<th scope="row">대표이사</th>
							<td>
								<input type="text" value="<c:out value="${cd1001mVO.cust_excut_name }" />"  class="input-data" id="cust_excut_name" name="cust_excut_name"/>
							</td>
							<th scope="row" class="bl">개인정보책임자</th>
							<td>
								<input type="text" value="<c:out value="${cd1001mVO.informanger_name }" />"  class="input-data" id="informanger_name" name="informanger_name"/>
							</td>
						</tr>
						<tr>
							<th scope="row">홈페이지</th>
							<td>
								<input type="text" value="<c:out value="${cd1001mVO.homepage }" />"  class="input-data" id="homepage" name="homepage"/>
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
								<form:input path="post" class="p15" /> <!-- 우편번호 -->
								<form:input path="addr1" class="ta_l p40" /> <!-- 주소1 -->
								<form:input path="addr2" class="ta_l p35" placeholder="상세주소" /> <!-- 주소2 -->								
							</td>
						</tr>
						<tr>
							<!-- 파일첨부합시다 -->
							<th scope="row">로고이미지</th>
							<td colspan="3">
							
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
			                    <input type="text" value="파일선택" class="input-data" id="fileName_0" disabled="disabled" >
								<label for="upload_file_0" class="btn-upload-file">파일업로드</label>
								<input type="file" class="hidden" id="upload_file_0" name="file_0" />
							    <a href="#"><button class="white" name="delete_0">x</button></a>
							    <a href="#" id="addFile"><button class="white" >+</button></a>
							    </p>
							   </div>
							   
							       </c:when>
								
										<c:otherwise>
								
							 <div id="fileDiv">
								 <c:forEach  items="${attachList }" var="file" varStatus="status">
			                    <p class="file-upload">
			                    <input type="text" value="${file.orgFileName eq null? '파일선택':file.orgFileName}" class="input-data" id="fileName_${status.index }" disabled="disabled" >
								<label for="upload_file_${status.index }" class="btn-upload-file">파일업로드</label>
								<input type="file" class="hidden" id="upload_file_${status.index }" name="file_${status.index }" />
							    <a href="#"><button class="white" name="delete_${status.index }"  onclick="fn_xFile('<c:out value="${file.attachSeq}"/>');">x</button></a>
							    <c:if test="${status.index == 0}">
							    <a href="#" id="addFile"><button class="white" >+</button></a>
							    </c:if>
							    </p>
							   </c:forEach>
							   </div>
								

										</c:otherwise>
								
								
									</c:choose>
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
							
														
								<div id="file_div">
									<p class="file-upload">
										<label for="upload_file" class="btn_sub" >파일업로드</label>
										<input type="file" class="hidden" id="upload_file" name="upload_file"/>
										<input type="text" value="파일선택" class="p30" id="fileName" disabled="disabled">											
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
	            <!-- //기본정보 -->
	            <!-- 탭버튼 -->
	            <div class="tab_area tab06">
	                <ul>
	                	<li><a href="#" class="on">이용약관</a></li>
	                	<li><a href="#">개인정보처리방침</a></li>
	                </ul>
	            </div>
	            <!-- //탭버튼 -->
	            <!-- 상세내용 -->
	            <div class="tab_con">
	            	내용
	            </div>
	            <!-- //상세내용 -->
            </form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_view(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_save(); return false;" class="type02" >저장</a>
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