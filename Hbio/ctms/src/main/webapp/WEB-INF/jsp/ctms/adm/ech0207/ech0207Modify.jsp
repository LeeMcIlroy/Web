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

//수치입력란을 눌렀을때 입력하지않으면 0.00으로 기입
function checkFilled(obj) {
    if(obj.value == "") {
    	obj.value = '0.00'
    }
}
function fn_save(){
	//자극결과수치 입력은 고정이기때문에  이외나머지 수치가 들어가면 리턴하도록 만듬
	var numbers =['0','0.5','1','2','3','4','5','0.00','0.50','1.00','2.00','3.00','4.00','5.00'];
	//detailForm이라는 id값을 가진 form의 데이터를 순서대로 저장함.
	var params = $('#detailForm').serialize();
	

	//lastIndexOf 를 사용하여 배열에있는 값과 비교함.
	var m30Vl1 = numbers.lastIndexOf($('#m30Vl1').val());
	/* var m30Vl2 = numbers.lastIndexOf($('#m30Vl2').val());
	var m30Vl3 = numbers.lastIndexOf($('#m30Vl3').val()); */
	var h24Vl1 = numbers.lastIndexOf($('#h24Vl1').val());
	/* var h24Vl2 = numbers.lastIndexOf($('#h24Vl2').val());
	var h24Vl3 = numbers.lastIndexOf($('#h24Vl3').val()); */
	//해당하지않는 숫자가 입력되면 -1을 뱉어냄 으로 리턴시킴.
	console.log(params);
	if(m30Vl1 == -1 ||  h24Vl1 == -1 ||$('#m30Vl1').val() == ''){
		alert("아래 표기되어있는 수치만 등록이 가능합니다.");
		return;
	}else{

		$.ajax({
			
		       type: "POST",
		       url:  "<c:url value="/qxsepmny/ech0207/ech0207Update.do"/>",
		       data: params,
		         success: function (data) {
					alert("저장되었습니다.");         
					opener.parent.location.reload(); //팝업창닫으면서 부모창 새로고침 
					window.close();
	
		        }, error: function (jqXHR, textStatus, errorThrown) {
		          alert(jqXHR + ' ' + textStatus.msg);
		       }
			});
	}
}
//한글막기
function delHangle(evt){
	var objTarget = evt.srcElement || evt.target;
	var value = event.srcElement.value;
	
	if(/[ㄱ-ㅎㅏ-ㅡ가-핳]/g.test(value)){
		
		objTarget.value =null;
		
	}
}

function isNumberKey(evt){
	
	var charcode = (evt.which) ? evt.which : event.keyCode;
			
	var value = event.srcElement.value;

	if(event.keyCode < 48 || event.keyCode > 57){
		
		if(event.keyCode!= 46){
			return false;
		}
	}
	
	var pattern = /^\d*[.]\d*$/;
	
		if(pattern.test(value)){
			
			if(charcode == 46){
				return false;
			}
		}
	
	var pattern1 = /^\d{1}$/;
		if(pattern1.test(value)){
			if(charcode != 46){
				alert("한자리 이하 숫자만 입력가능합니다.");
				return false;
			}
		}

	var pattern2 =/^\d*[.]\d{1}$/;
	
		if(pattern2.test(value)){
			alert("소수점 첫째자리까지만 입력가능")
			return false;
		}
}
</script>
<body>
<!-- pop_wrap -->
<div class="pop_wrap">
	<!-- pop_header -->
	<div class="pop_header">
		<h1 class="hidden"><a href="#">H&amp;Bio</a></h1>
		<h2>피부자극관리</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type04">
		<!-- 식별코드 -->
<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post">
<input type="hidden" id="rsNo" name="rsNo" readonly="readonly" value="${rsNo} ">

		<table class="tbl_view mb01">
			<colgroup>
				<col style="width:90px" />
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">식별코드</th>					
					<td><input type="text" id="rsiNo" name="rsiNo" readonly="readonly" value="${rsiNo} "> </td>
				</tr>					
			</tbody>		
		</table>
	
		<!-- //식별코드 -->

		<!-- 입력창 -->
		<table class="tbl_list multi_hd ">
			<colgroup>
				<col style="width:20%" />
				<col style="width:100%" />
				<col style="width:22.6%" />
				<col style="width:24%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" >시험물질</th>
					<th scope="col" >물질명</th>	
					<th scope="col" >첩포 제거</br> 30분 후</th>
					<th scope="col" >첩포 제거 </br>24시간 후</th>
					
				</tr>
			</thead>
			<tbody>
				 	<c:forEach items="${resultList}" var="result" >
						<tr>
							<td><input type="text" id="mtlDsp" name="mtlDsp" readonly="readonly" style="text-align: center;" value="<c:out value="${result.mtlDsp}"/>"> </td>
							<td><input type="text" id="mtlName" name="mtlName" readonly="readonly" style="text-align: left;" value="<c:out value="${result.mtlName}"/>" > </td>						
					        <td><input type="text" id="m30Vl1" name="m30Vl1" onfocus="this.value=''" onblur="checkFilled(this)"  style="text-align: center;"  value="<c:out value="${result.m30Vl1 }"/>" onkeypress="return isNumberKey(event)" onkeyup="return delHangle(event)"> </td>				    
						    <td><input type="text" id="h24Vl1" name="h24Vl1" onfocus="this.value=''" onblur="checkFilled(this)"  style="text-align: center;" value="<c:out value="${result.h24Vl1 }"/>" onkeypress="return isNumberKey(event)" onkeyup="return delHangle(event)"> </td>						  
							<td><input type="hidden" id="rsNo7" name="rsNo7" value="<c:out value="${result.rsNo7 }"/>"> </td>						  
							
						</tr>
					</c:forEach>					
			</tbody>
		</table>
</form:form>
		<p class="guide_txt type02">※ 0 / 0.5 / 1 / 2 / 3 / 4 / 5 숫자만 입력 가능합니다.</p>

			
		<!-- //입력창 -->
	</div>
			<div class="btn_area">
				<a href="#" class="type02" onclick="javascript:window.close();">취소</a>
				<a href="#" onclick="fn_save();">저장</a>
			</div>
		 	<img src="<c:out value='${pageContext.request.contextPath }/assets/img/피부자극정도.jpg'/>" width="600px" style="margin-left: 10%">
		<!-- 버튼 -->
		<!-- //버튼 -->
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</body>
</html>