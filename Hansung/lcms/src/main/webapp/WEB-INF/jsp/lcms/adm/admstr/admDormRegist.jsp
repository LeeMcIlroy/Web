<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">

// 목록 화면으로
function fn_list(){
	$("#detailform").attr("action", "<c:url value='/qxsepmny/admstr/admDormList.do'/>").submit();
}

//  ************ 20200306 학생 찾기 버튼 데이터 출력 시작************
function fn_findStudents(){
	var memName = $("#name").val();
	
	$.ajax({
		 url :   '<c:url value="/qxsepmny/admstr/findStudents.do"/>'
		,type : 'post'
		,data :{'name':memName}
		,dataType : 'json' 
		,success:function(result){
			alert(result.message);
		  
			if(result.memberVO.memberType == 'STD'){
				$('#stdInfo').attr("style","display:block");
				$('#memberName').html(result.memberVO.name);
				$('#memberVoCode').html(result.memberVO.memberCode);
				$('#memEname').html(result.memberVO.eName);
				$('#memStatus').html(result.memberVO.status);
				$('#memStep').html(result.memberVO.step);
				$('#memNation').html(result.memberVO.nation);
			}
		}
		
	});
	
	
}

var resultList;

function fn_search(){
	$.ajax({
		url: "<c:url value='/qxsepmny/admstr/findStudents.do'/>"
		, type: "post"
		, data: "name="+$("#searchWord").val()
		, dataType:"json"
		, success: function(data){
			resultList = data.resultList;
			var html = "";
			
			for(var i=0; i<resultList.length; i++){
				html += '<tr onclick="fn_select('+i+'); return false;">';
				html += '	<td>'+resultList[i].name+'</td>';
				html += '	<td>'+resultList[i].memberCode+'</td>';
				html += '	<td>'+resultList[i].eName+'</td>';
				html += '	<td>'+resultList[i].status+'</td>';
				html += '	<td>'+resultList[i].step+'급</td>';
				html += '	<td>'+resultList[i].nation+'</td>';
				html += '</tr>';
			}
			
			if(resultList.length == 0){
				html += '<tr>';
				html += '	<td colspan="6">검색된 내용이 없습니다.</td>';
				html += '</tr>';
			}
			
			$("#stdBody").html(html);
		}, error: function(){
			alert("오류가 발생하였습니다.");
		}
	});
}

function fn_select(i){
	var result = resultList[i];
	
	$('#stdInfo').attr("style","display:block");
	$('#memberName').html(result.name);
	$('#name').val(result.name);
	$('#memberVoCode').html(result.memberCode);
	$('#memEname').html(result.eName);
	$('#memStatus').html(result.status);
	$('#memStep').html(result.step);
	$('#memNation').html(result.nation);
	
	$("#modi-pop").click();
	
	resultList = null;
}

// 구분을 통해 입사했던 내역 찾기
$(document).ready(function(){
	
	$("#renewGubun").change(function(){
	//재입사
  var renewGubun = $("#renewGubun").val();
  var memName = $("#name").val();
  
		if($("#renewGubun").val() == '2'){
		
		$.ajax({
			 url :   '<c:url value="/qxsepmny/admstr/findStudents.do"/>'
			,type : 'post'
			,data :{'name':memName,'renewGubun':renewGubun}
			,dataType : 'json' 
			,success:function(result){
				if (result.dormVO != '' && result.dormVO != null) {
				$('#dormnow').html(result.dormVO.dormNow);
				$('#perroomnow').html(result.dormVO.perroomNow);
				$('#joindate').html(result.dormVO.joinMinDate);
				$("#nowResiDorm").attr("style","display:block");
				alert(result.message);
				}
				else{
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
	
	$("#modi-pop").change(function(){
		var html = '';
		html += '<tr>';
		html += '	<td colspan="6">학번 또는 이름을 검색해주세요.</td>';
		html += '</tr>';
		$("#stdBody").html(html);
	});
});


function fn_save(){

	 $("#detailform").attr("action", "<c:url value='/qxsepmny/admstr/admDormRegist.do'/>").submit();
}


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
 

	
	// 신청학기에 따른 거주기간 값 변경 
	$(document).ready(function(){ 
		
		var eleSem = document.getElementById("semEster");
		fn_search_seme_dorm(eleSem); 
		
		$('#semYear').change(function(){
			var year = this.value;
			 $('#resiStartdate').val('');
			 $('#resiEnddate').val('');	 
		
			$.ajax({
				url: '<c:url value="/usr/cmm/ajaxSearchSeme.do"/>'
				, type: 'post'
				, data: {'year':year}
				, dataType:'json'
				, success: function(data){
					resultList = data.semeList;
					var html = "";
					var semedate = "";
					
					for(var i=0; i<resultList.length; i++){
						html += '<option value="'+resultList[i].semester+'">'+resultList[i].semeNm+'</option>';
					}
					$("#semEster").html(html);
				var ele = document.getElementById("semEster");
				
				fn_search_seme_dorm(ele); 
	
				}
			
			});
		
		}); 
		
	
	});
	
	function fn_search_seme_dorm(ele){
		
	var year = $('#semYear').val();
	var semEster = $(ele).val();
	
	$.ajax({
			url: '<c:url value="/qxsepmny/admstr/findResidenceDate.do"/>'
			, type: 'post'
			, data: {'sem_year':year,
				      'semester':semEster}
			, dataType:'json'
			, success: function(data){
				result = data.residenceDate;
				

	if (semEster == '2' || semEster == '4') {
					 $(".vacaIncGubun").attr("style","visibility:visible");
					 $('#resiStartdate').val('');
					 $('#resiEnddate').val('');	 
	 $("input:radio[name=vacationInc]").click(function(){
		if ($("input:radio[name=vacationInc]:checked").val() == 'Y') {
					$('#resiStartdate').val(result.dormIncS);
					$('#resiEnddate').val(result.dormIncE);
				}else {
					$('#resiStartdate').val(result.dormS);
					$('#resiEnddate').val(result.dormE);
				}
					 });
	}else{
			
		$(".vacaIncGubun").attr("style","visibility:hidden");
		
		$('input[name="vacationInc"]').removeAttr('checked');
		$('#resiStartdate').val(result.dormS);
		$('#resiEnddate').val(result.dormE);
	}	
			
			
			
	}
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
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="기숙사"/>
	           	</jsp:include>
	           	
<form:form commandName="DormVO" id="detailform" method="post" name="detailform" enctype="multipart/form-data">

<input type="hidden" name="menuType" id="menuType" value="dormInsert" >
<!-- ************************	학생 찾기 TABLE	************************ -->

                <p class="sub-title">학생 찾기</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col />
						</colgroup>
						<tbody>
		                        <tr>
								<th><sup>*</sup>이름</th>
								<td>
									<input type="text" class="input-data w173px" name="name" id="name" placeholder="이름을입력하세요" />
									<label for="modi-pop" class="normal-btn">학생찾기</label>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
<!-- ************************	학생 정보 TABLE	************************ -->
                  <div id="stdInfo" style="display: none;">
					<p class="sub-title">학생 정보</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col style="width:20%;"/>
							<col style="width:13%;" />
							<col style="width:20%;"/>
							<col style="width:14%;" />
							<col style="width:20%;"/>
						</colgroup>
						<tbody >
							<tr >
								<th>이름</th>
								<td id="memberName">
									<c:out value="${memberVO.name }" />
								</td>
								<th>학번</th>
								<td  id="memberVoCode">
									<c:out value="${memberVO.memberCode }" />
								</td>
								<th>영문명</th>
								<td id="memEname">
								<c:out value="${memberVO.eName }" />
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td id="memStatus">
									<c:out value="${memberVO.status }" />
								</td>
								<th>급수</th>
								<td id="memStep">
									<c:out value="${memberVO.step }" />
								</td>
								<th>국적</th>
								<td id="memNation">
									<c:out value="${memberVO.nation }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				</div>
				<!--// table -->
				
<!-- ************************	진행 정보 TABLE			************************ -->
				<p class="sub-title">진행 정보</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col  />
						</colgroup>
						<tbody>
						  <tr class="1">
								<th><sup>*</sup>신청학기</th>
								<td>
									<!--  학기 뽑아옴 연도 뽑기 inchead 박혀있음-->
									<select name="semYear" id="semYear"  >
										<c:forEach items="${yearList}" var="year">
											<option value="${year}" <c:out value="${year == semester.semYear?'selected':'' }"/>><c:out value="${year}"/></option>
										</c:forEach>
									</select> 
								
									<!--  학기 뽑아옴 CmmDAO.selectSemeList  연도 박혀있음-->
									<select name="semEster" id="semEster" onchange="fn_search_seme_dorm(this)">
										<c:forEach items="${semeList }" var="seme">
											<option value="${seme.semester }" <c:out value="${seme.semester == semester.semester?'selected':'' }"/>><c:out value="${seme.semeNm }"/></option>
										</c:forEach>
									</select>&nbsp;&nbsp;&nbsp;&nbsp;
									<span style="visibility:hidden;" class="vacaIncGubun">	
										<input type="radio" value="Y" id="vacationY" name="vacationInc" ><label for="vacationY"> 방학포함</label>&nbsp;&nbsp;
										<input type="radio" value="N" id="vacationN" name="vacationInc" ><label for="vacationN"> 방학미포함</label>
									</span>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>거주기간</th>
								<td>
									<input type="text" id="resiStartdate" name="resiStartdate"  placeholder="0000-00-00" readonly="readonly"> -
									<input type="text" id="resiEnddate" name="resiEnddate"  placeholder="0000-00-00" readonly="readonly">
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
				
<!-- ************************	현재 거주 기숙사 TABLE			************************ -->				
					<div id="nowResiDorm" style="display: none;">
					<p class="sub-title" >현재 거주 기숙사</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col style="width:20%;"/>
							<col style="width:13%;" />
							<col style="width:20%;"/>
							<col style="width:14%;" />
							<col style="width:20%;"/>
						</colgroup>
						<tbody>
							<tr>
								<th >기숙사명</th>
								<td id="dormnow">
								<c:out value="${dormVO.dormNow }" />
								</td>
								<th>인실</th>
								<td id="perroomnow">
								<c:out value="${dormVO.perroomNow }" />
								</td>
								<th>최초입사일자</th>
								<td id="joindate">
									<c:out value="${dormVO.joinMinDate }" />
								</td>
							</tr>
                       </tbody>
                    </table>
                    </div>
                    </div>
 <!-- ************************	신청 기숙사 TABLE  ************************ -->	                   
          <p class="sub-title">신청 기숙사</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col style="width:13%;" />
							<col style="width:20%;"/>
							<col style="width:13%;" />
							<col style="width:20%;"/>
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>기숙사</th>
								<th><sup>*</sup>1순위</th>
								<td>
									<select name="dormFirst">
									<option value="1">Global Village 1</option>
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
							<!-- <tr>
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
									<option value="1" >2인실</option>
									<option value="2">3인실</option>
									<option  value="3">4인실</option>
									</select>
								</td>
							</tr> -->
						</tbody>
					</table>
				</div>
				<!--// table -->
				
<!-- ************************ 첨부파일 TABLE			************************ -->

                <p class="sub-title">첨부파일</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col />
						</colgroup>
						<tbody>
		                        <tr>
								<th>첨부파일</th>
								<td>
								 <div id="fileDiv">
			                    <p class="file-upload">
			                    <input type="text" value="파일선택" class="input-data" id="fileName_0" disabled="disabled" >
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
				<!--// table -->
</form:form>

				<!-- table button 목록, 저장 -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-down" onclick="fn_list()">목록</button>
						<button type="button" class="white btn-down" onclick="fn_save()">저장</button>
					</div>
				</div>
				<!--// table button -->


			</div>
		</div>
		<div class="black-pop">&nbsp;</div>
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="modi-popup">
			<p class="sub-title">학생 찾기</p>
			<div class="search-box none-option">
				<input type="checkbox" id="search-option-open" />
				<div class="search">
					<div class="search-input">
						<table class="shearch-option">
							<colgroup>
								<col style="width:8%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<input type="text" class="input-data" placeholder="학번,이름을 입력하세요" id="searchWord" />
									</td>
								</tr>
							</tbody>
						</table>
						<a href="#" onclick="fn_search(); return false;">검색하기</a>
					</div>
				</div>
			</div>
			<div class="list-table-box">
				<table class="normal-list-table">
					<colgroup>
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>이름</th>
							<th>학번</th>
							<th>영문명</th>
							<th>상태</th>
							<th>급수</th>
							<th>국적</th>
						</tr>
					</thead>
					<tbody id="stdBody">
						<tr>
							<td colspan="6">학번 또는 이름을 검색해주세요.</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="table-button">
				<div class="btn-box">
					<label for="modi-pop" class="white btn-cancel">취소</label>
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