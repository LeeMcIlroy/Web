<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script>

function fn_save(){
	$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
	
	var noti_gubun = $('#noti_gubun').val();
	var noti_title = $('#noti_title').val();
	var noti_content = $('#noti_content').val();
	
	if(noti_gubun=='0'){
		alert('구분을 선택해주세요.');
		$('#noti_gubun').focus();
		return;
	}
	
	if(noti_title==''){
		alert('제목을 입력해주세요.')
		$('#noti_title').focus();
		return;
	}
	
	if(noti_content==''){
		alert('내용을 입력해주세요.')
		$('#noti_content').focus();
		return;
	}
	$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/admstr/admSaveNotice.do'/>").submit();
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

    var html = '<p class="file-upload"><input type="text" value="파일선택" class="input-data" id="fileName_'+(file_cnt)+'" disabled="disabled" >';     
        html += '<label for="upload_file_'+(file_cnt)+'" class="btn-upload-file" style="margin-left: 4px;">파일업로드</label>';
        html +='<input type="file" class="hidden" id="upload_file_'+(file_cnt)+'" name="file_'+(file_cnt)+'" />';
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
	
//공지사항 개수 조정 10개
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
 function fn_xFile(attachSeq){
	 var attachSeq = attachSeq;
	 
	 if (confirm("파일을 삭제하시겠습니까?")) {
		$.ajax({
			url : '<c:url value='/qxsepmny/admstr/deleteFileUpload.do'/>'
			,type : 'post'
			,data :{'attachSeq':attachSeq}
			,dataType:'json'
			,success:function(result){
				alert(result.message);
				window.location.reload();
			},error:function(e){
				alert(e);
			}
		 });
	 } 
 }
 
 function fn_list(){
	 $("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/admstr/admNoticeList.do'/>").submit();
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
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="공지사항"/>
	           	</jsp:include>
				<p class="sub-title">공지내용</p>
				
				<form:form commandName="noticeVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="noti_seq" name="noti_seq" value="${noticeVO.noti_seq}">
				
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>공지구분</th>
								<td>
									<select id="noti_gubun" name="noti_gubun">
										<option value="전체" <c:if test="${noticeVO.noti_gubun eq '전체' }">selected="selected"</c:if> >전체</option>
										<option value="교사" <c:if test="${noticeVO.noti_gubun eq '교사' }">selected="selected"</c:if> >교사</option>
										<option value="학생" <c:if test="${noticeVO.noti_gubun eq '학생' }">selected="selected"</c:if> >학생</option>
									</select>
								</td>
								<th>작성자</th>
								<td>
								<c:if test="${NotiPageGubun eq 'NotiRegist' }">
									<c:out value="${adminVO.name}" />
								</c:if>
								<c:if test="${NotiPageGubun eq 'NotiUpdate' }">
									<c:out value="${noticeVO.noti_writer}" />
								</c:if>
								</td>
								<th>작성일</th>
								<td>
								<c:if test="${!empty noticeVO.noti_seq }">
									<fmt:parseDate var="dateFmt" pattern="yyyy.MM.dd HH:mm:ss" value="${noticeVO.noti_date }"/>
									<fmt:formatDate var="notiDate" pattern="yyyy-MM-dd" value="${dateFmt}" />
									<c:out value="${notiDate}" />
								</c:if>
								<c:if test="${empty noticeVO.noti_seq }">
									<script>
										var d = new Date();
										document.write(d.getFullYear()+'.'+(d.getMonth() + 1)+'.'+d.getDate());
									</script>
								</c:if>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>제목</th>
								<td colspan="5">
								
									<input type="text" value="<c:out value="${noticeVO.noti_title }" />"  class="input-data" id="noti_title" name="noti_title"/> &nbsp;&nbsp;&nbsp;
							
<!-- 									<label for="noti_top" id="noti_top">상단고정</label> -->
									<input type="checkbox" onclick="fn_notiTopGubun('<c:out value="${notiTopCnt}" />')" id="noti_top" name="noti_top" value="Y" <c:if test="${noticeVO.noti_top eq 'Y' }">checked="checked"</c:if> /> 상단고정
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>내용</th>
								<td colspan="5" class="bln editor" height="200">
									<textarea id="noti_content" name="noti_content"><c:out value="${noticeVO.noti_content }" escapeXml="false"/></textarea>
									<script type="text/javascript">
										CKEDITOR.replace( 'noti_content', {
											height: 300,
											filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
										});
									</script>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<p class="sub-title">첨부파일</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>첨부파일</th>
								<td>
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
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				</form:form>
				<!--// table -->
				<div class="table-button">
					<div class="btn-box">
						<a href="#" onclick="fn_list(); return false;" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>