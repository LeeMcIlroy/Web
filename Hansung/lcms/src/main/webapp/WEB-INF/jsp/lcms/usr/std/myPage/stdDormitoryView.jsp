<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script>
		function closeLayer( obj ) {
			$(obj).parent().parent().hide();
		}

		$(function(){

			/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
			$('.imgSelect').click(function(e)
			{
				var sWidth = window.innerWidth;
				var sHeight = window.innerHeight;

				var oWidth = $('.popupLayer').width();
				var oHeight = $('.popupLayer').height();

				// 레이어가 나타날 위치를 셋팅한다.
				var divLeft = e.clientX + 10;
				var divTop = e.clientY + 5;

				// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
				if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
				if( divTop + oHeight > sHeight ) divTop -= oHeight;

				// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
				if( divLeft < 0 ) divLeft = 0;
				if( divTop < 0 ) divTop = 0;

				$('.popupLayer').css({
					"top": divTop,
					"left": divLeft,
					"position": "absolute"
				}).show();
			});

		});
		// 목록 화면으로
		function fn_list(){
			
			$("#detailform").attr("action", "<c:url value='/usr/std/myPage/stdDormitoryList.do'/>").submit();
			
		}
		// 기숙사 입사 신청 저장 20200313
		function fn_save(){

			 $("#detailform").attr("action", "<c:url value='/usr/std/myPage/stdDormitoryRegist.do'/>").submit();
		}
		
		// 구분을 통해 입사했던 내역 찾기
		$(document).ready(function(){
			
			$("#renewGubun").change(function(){
			//재입사
		  var renewGubun = $("#renewGubun").val();
		  
				if($("#renewGubun").val() == '2'){
				
				$.ajax({
					 url :   '<c:url value='/usr/std/myPage/findStudents.do'/>'
					,type : 'post'
					,data :{'renewGubun':renewGubun}
					,dataType : 'json' 
					,success:function(result){
						if (result.dormVO != '' && result.dormVO != null) {
						$('#dormnow').html(result.dormVO.dormNow);
						$('#perroomnow').html(result.dormVO.perroomNow);
						$('#joindate').html(result.dormVO.joinDate);
						$("#nowResiDorm").attr("style","display:block");
						alert('현재 거주 기숙사가 조회되었습니다.');
						}else{
							$("#renewGubun").val('1').attr("selected","selected");
							$("#nowResiDorm").attr("style","display:none");
						alert('현재 거주한 기숙사가 존재하지 않습니다.');
						}
						}
				});
			}
			//신입사
		if($("#renewGubun").val() == '1'){
				
				$("#nowResiDorm").attr("style","display:none");
			}
			});
		});
		


		//파일업로드  추가. 해당 요소 업로드 제거 핸들링
		$(document).ready(function(){
			   $("#addFile").on("click", function(e){ 
		    	
		    	e.preventDefault(); 
		    	fn_addFile();
		    });
			   $("a[name='delete']").on("click", function(e){ //삭제 버튼 
				   e.preventDefault(); 
			   fn_deleteFile($(this)); });

		});

		//파일업로드 추가
		var file_count = 1;

		function fn_addFile(){
			
		var file_cnt = file_count++;
		var fileHtml = document.getElementById('fileDiv');
		var fileHtmlCnt = fileHtml.childElementCount; // 자식 요소 카운트

		      if (fileHtmlCnt >= 5) {
				alert('파일첨부는 5개까지만 가능합니다.');
				return false;
		      }else{

		    var html = '<p class="file-upload"><input type="text" value="파일선택" class="input-data" id="fileName_'+(file_cnt)+'" disabled="disabled" >';     
		        html += '<label for="upload_file_'+(file_cnt)+'" class="normal-btn" style="margin-left: 4px;">파일선택</label>';
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
		//파일업로드 제거
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
				
		 		/* if(extension != 'JPG'){
					alert('JPG만이 첨부 가능합니다');
					$('#upload_file').val('');
					return;
				} */
				$("#fileName_0").val(fileName);
				}
		       }); 
			 $("a[name='delete_0']").on("click", function(e){ //삭제 버튼 
			      	e.preventDefault(); 
			      	
			    	$("#fileName_0").val('파일선택');
			      
			      });
			});  
		
		
		
		
	</script>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavStd"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuStd"/>
			<!--// left menu -->
			
	<form:form commandName="DormVO" id="detailform"	 name="detailform" enctype="multipart/form-data">
			
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">기숙사 – 입사신청</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>마이페이지</span>
						<span>기숙사</span>
					</div>
				</div>
<!-- ****************************웹 기숙사 신청**************************** -->
				<p class="sub-title">진행 정보</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>거주기간</th>
								<td>
									<input type="text" name="resiStartdate" id="datepicker" placeholder="0000-00-00" readonly="readonly"  /> ~ 
									<input type="text" name="resiEnddate" id="datepicker01" placeholder="0000-00-00" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>신청구분</th>
								<td>
									<select name="renewGubun" id="renewGubun">
									<option value="1">신입사</option>
									<option value="2">재입사</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				
<!-- ****************************모바일 기숙사 신청**************************** -->					
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt><sup>*</sup>거주기간</dt>
							<dd>
								<input type="text" id="m-datepicker" name="resiStartdate" placeholder="0000-00-00" readonly="readonly"/> ~ <input type="text" id="m-datepicker01"  name="resiEnddate" placeholder="0000-00-00" readonly="readonly"/>
							</dd>
						</dl>
						<dl>
							<dt><sup>*</sup>신청구분</dt>
							<dd>
								<select name="renewGubun" id="renewGubun">
									<option value="1">신입사</option>
									<option value="2">재입사</option>
								</select>
							</dd>
						</dl>
					</div>
				</div>
				
	<!-- ****************************웹 기숙사 신청**************************** -->			
				<p class="sub-title">현재거주 기숙사</p>
				<!-- table -->
				<div class="list-table-box web">
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
							    <th>기숙사명</th>
								<td id="dormnow">
								<c:out value="${dormVO.dormNow }" />
								</td>
								<th>인실</th>
								<td id="perroomnow">
								<c:out value="${dormVO.perroomNow }" />
								</td>
								<th>최초입사일자</th>
								<td id="joindate">
									<c:out value="${dormVO.joinDate }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				
<!-- ****************************모바일 기숙사 신청**************************** -->				
				<div class="mob mb20">
					<div class="mob-write">
						<dl id="dormnow">
							<dt>기숙사명</dt>
							<dd >
								<c:out value="${result.dormNow }" />
							</dd>
						</dl>
						<dl id="perroomnow">
							<dt>인실</dt>
							<dd >
								<c:out value="${result.perroomNow }" />
							</dd>
						</dl>
						<dl id="joindate">
							<dt>최초입사일자</dt>
							<dd >
								<c:out value="${result.joinDate }" />
							</dd>
						</dl>
					</div>
				</div>
			
				

<!-- ****************************웹 + 모바일기숙사 신청**************************** -->
				<p class="sub-title">신청기숙사</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:20%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>기숙사</th>
								<th><sup>*</sup>1순위</th>
								<td>
									<select name="dormFirst">
									<option  value="1">Global Village 1</option>
									<option value="2">Global Village 2</option>
									<option value="3">APT</option>
									</select>
								</td>
								<th><sup>*</sup>2순위</th>
								<td>
									<select name="dormSecond">
									<option  value="1">Global Village 1</option>
									<option value="2">Global Village 2</option>
									<option value="3">APT</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>인실</th>
								<th><sup>*</sup>1순위</th>
								<td>
									<select name="perroomFirst">
									<option  value="1">2인실</option>
									<option  value="2">3인실</option>
									<option  value="3">4인실</option>
									</select>
								</td>
								<th><sup>*</sup>2순위</th>
								<td>
									<select name="perroomSecond">
									<option  value="1">2인실</option>
									<option  value="2">3인실</option>
									<option  value="3">4인실</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				
<!-- ****************************웹 기숙사 신청**************************** -->
				<p class="sub-title">첨부파일</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>첨부파일</th>
								<td>
								 <div id="fileDiv">
			                    <p class="file-upload">
			                    <input type="text" value="파일선택" class="input-data" id="fileName_0" disabled="disabled" readonly="readonly">
								<label for="upload_file_0" class="normal-btn">파일선택</label>
								<input type="file" class="hidden" id="upload_file_0" name="file_0" />
							   	<a href="#" name="delete_0"><button class="white">x</button></a>
							    <a href="#" id="addFile"><button class="white" >+</button></a>
							    </p>
							   </div>
							
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
<!-- ****************************모바일 기숙사 신청**************************** -->
				
			 <div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>첨부파일</dt>
							<dd>
								<ul>
									<li>
								<div id="fileDiv">
			                    <p class="file-upload">
			                    <input type="text" value="파일선택" class="input-data" id="fileName_0" disabled="disabled" readonly="readonly">
								<label for="upload_file_0" class="normal-btn">파일선택</label>
								<input type="file" class="hidden" id="upload_file_0" name="file_0" />
							   	<a href="#" name="delete_0"><button class="white">x</button></a>
							    <a href="#" id="addFile"><button class="white" >+</button></a>
							    </p>
							   </div>
									</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div> 


				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="#" onclick="fn_list(); return false;" class="white btn-list">목록</a>
						<button type="button" onclick="fn_save()" class="white btn-save">저장</button>
					</div>
				</div>
				<!--// table button -->

			</div>
			
			</form:form>
			
		</div>

	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->

</body>
</html>