<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*, java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<link rel="shortcut icon" href="#">
<script type="text/javascript">
function fn_add(seq){
	var diviCheck =  $("#diviCheck").val();//중복확인을 했는지 안했는지(Y했다. N안했다)
	var doubleChk =  $("#doubleChk").val();//중복 값이 있는지 (Y) 없는지 (N)
	var lectWeek = $("#lectWeek").val();
	var lectSeq = $("#lectSeq").val(); 
	var lectTbSeq = $("#lectTbSeq").val(); 
	var datepicker01 = $("#datepicker01").val();
	var datepicker02 = $("#datepicker02").val();

	
	if(lectSeq == '' || lectSeq == null){
		if(diviCheck == ''){
			alert('중복확인을 해주세요');
			$("#diviChk").focus(); 
		}else if(doubleChk == 'Y'){
			alert('이미 등록된 강의 입니다.');
		}else if(datepicker01 > datepicker02){
			alert('개설종료일이 시작일보다 큽니다.');
			$("#datepicker02").focus(); 
		}else if(confirm("강의등록 하시겠습니까 ?")){
			$('#detaleList').attr("method", "post").attr("action","<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/addLect.do'/>").submit();
		}
	}else if(lectSeq != '' || lectSeq != null){
		if(datepicker01 > datepicker02){
			alert('개설종료일이 시작일보다 큽니다.');
			$("#datepicker02").focus(); 
		}else if(confirm("강의수정 하시겠습니까 ?")){
			$('#detaleList').attr("method", "post").attr("action","<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/addLect.do'/>").submit();
			}
	}
	};

	$(document).ready(function(){
	    $("#lectDivi").on("click", function(){  
	    	$('#diviCheck').val('');
	    });    
	});

//중복확인
function fn_chk(){
	var lectDivi = $("#lectDivi").val(); //분반
	var lectYear = $("#lectYear").val(); //학기-년도
	var lectSem = $("#lectSem").val(); //학기 - 학기
	var lectName = $("#lectName").val(); //교과목
	var lectCurr = $("#lectCurr").val(); //교육과정

	var lectSeq = $("#lectSeq").val(); 
	
	$('#diviCheck').val('Y');
	if(lectSeq != null || lectSeq != ''){
		
	$.ajax({
		url: "<c:url value='/qxsepmny/curr/chkLect.do'/>"
		, type: "post"
		, data: {"lectDivi" : lectDivi, "lectYear" : lectYear, "lectSem" : lectSem, "lectName" : lectName, "lectCurr" : lectCurr}
		, dataType:"json"
		, success: function(data){
			if(data.result == 'Y'){
				alert("이미 등록된 강의 입니다.");
				$('#doubleChk').val('Y');
			}else{
				alert("등록 가능한 강의 입니다.");
				$("#diviChk").val($("#lectDivi").val());
				$('#doubleChk').val('N');
			}
		}, error: function(){
			alert("오류가 발생하였습니다.");
		}
	});
	}
}
//시간추가
function fn_addClass(){
	var cnt = $(".timeClass").length;
	var html = '';
	
// 	html += ''; 
	html += '<p class="timeClass" name="pClass" id="pClass'+cnt+'">';
	html += '<input type="hidden" name="timeTableList['+cnt+'].lectTbseq" id="tbSeq'+cnt+'"/>';
	html += '		<select name="timeTableList['+cnt+'].lectWeek" id="lectWeek'+cnt+'">';
	html += '			<option value="월요일">월요일</option>';
	html += '			<option value="화요일">화요일</option>';
	html += '			<option value="수요일">수요일</option>';
	html += '			<option value="목요일">목요일</option>';
	html += '			<option value="금요일">금요일</option>';
	html += '		</select>';
	html += '		<select name="timeTableList['+cnt+'].lectSclass" id="lectSclass'+cnt+'">';
	html += '			<option value="1">1교시</option>';
	html += '			<option value="2">2교시</option>';
	html += '			<option value="3">3교시</option>';
	html += '			<option value="4">4교시</option>';
	html += '			<option value="5">5교시</option>';
	html += '			<option value="6">6교시</option>';
	html += '		</select>';
	html += '	 -';
	html += '		<select name="timeTableList['+cnt+'].lectEclass" id="lectEclass'+cnt+'">';
	html += '			<option value="1">1교시</option>';
	html += '			<option value="2" >2교시</option>';
	html += '			<option value="3">3교시</option>';
	html += '			<option value="4">4교시</option>';
	html += '			<option value="5">5교시</option>';
	html += '			<option value="6">6교시</option>';
	html += '		</select>';
	html += '		<select name="timeTableList['+cnt+'].lectGrammar" id="lectGrammar'+cnt+'">';
	html += '			<option value="어휘문법">어휘문법</option>';
	html += '			<option value="말하기">말하기</option>';
	html += '		</select>';
	html += '		<select name="timeTableList['+cnt+'].lectTea" id="lectTea'+cnt+'">';
	html += '			<c:forEach var="teacher" items="${teacher}">';
	html += '				<option value="${teacher.memberCode}">${teacher.name}</option>';
	html += '			</c:forEach>';
	html += '		</select>';
	html += '	<button type="button" name="delButton" onclick="delClass(this,'+cnt+'); return false;">  x</button>';
	html += '</p>';	
	
	$("#timeTable").append(html);
};

		
//삭제 버튼
	function delClass(e, count){
    var html = '<input type="hidden" name="delSeqList" value="'+e.value+'"/>';	
		$("#delSeq").append(html);
		
  	  var cnt = $(".timeClass").length;
    
    	if(cnt != 1){
			for(i=count; i<cnt; i++){
				$("#lectTbSeq"+i).val($("#lectTbSeq"+(i+1)).val());
				$("#lectWeek"+i).val($("#lectWeek"+(i+1)).val());
				$("#lectSclass"+i).val($("#lectSclass"+(i+1)).val());
				$("#lectEclass"+i).val($("#lectEclass"+(i+1)).val());
				$("#lectGrammar"+i).val($("#lectGrammar"+(i+1)).val());
				$("#lectTea"+i).val($("#lectTea"+(i+1)).val());
				$("#btnSeq"+i).val($("#btnSeq"+(i+1)).val());
			}
			$("#pClass"+(cnt-1)).remove();
		}
	};


	function selectLectSem(e){
		  $("#lectSem").empty();
		  $("#datepicker01").attr("value","");
		  $("#datepicker02").attr("value","");
// 		  $("#lectSem").append("<option>"+'**학기**'+"</option>");
    var lectYear = $("#lectYear").val();
	    $.ajax({
	        type: "POST"
	        ,data: {"lectYear" : lectYear }
	        ,url: "<c:url value='/qxsepmny/curr/admAjaxSelectBoxLectSem.do'/>"
	        ,dataType:"json"
	    	,success:function(data){
	    		resultList = data.resultList;
	    		for(var i=0; i<resultList.length; i++){
            		$("#lectSem").append("<option value='"+resultList[i].semester+"'>"+resultList[i].semester+"</option>");
		    		$("#datepicker01").attr("value",resultList[i].enterRegiS);
	    			$("#datepicker02").attr("value",resultList[i].enterRegiE);
	    		}
	   		}
	   		,error : function(){
	   			alert('오류가 발생했습니다.');
	   		}
		});
};

/* 분반 추가 */
	function fn_addDivi() {
		$("#addDivi").removeClass('dpn');
		$("#lectDivi").val('');
	} 
	function fn_save_divi() {
		var newDivi = $("#newDivi").val();

		if (newDivi != '') {
			$.ajax({
				url : "<c:url value='/qxsepmny/entran/admAjaxDiviUpdate.do'/>",
				type : "post",
				data : "newDivi=" + newDivi,
				dataType : "json",
				success : function(data) {
					var diviList = data.diviList;
					var html = '<option value="">선택</option>';
					for (var i = 0; i < diviList.length; i++) {
						html += '<option value="'+diviList[i].name+'">'+ diviList[i].name + '</option>';
					}
					$("#lectDivi").html(html);
					$("#addDivi").addClass('dpn');
					$("#newDivi").val('');
				},
				error : function() {
					alert("오류가 발생하였습니다.");
				}
			});
		} else {
			alert('추가하실 국적을 입력해 주세요.');
		}
	}
	$(function() {
		$("#lectDivi").change(function() {
			$("#addDivi").addClass('dpn');
			$("#newDivi").val('');
		});
		$("#lectClassroom").change(function() {
			$("#addlectClass").addClass('dpn');
			$("#newlectClass").val('');
		});
	});
	/* 강의실 추가 */
	function fn_addlectClass() {
		$("#addlectClass").removeClass('dpn');
		$("#lectClassroom").val('');
	} 
	function fn_save_lectclass() {
		console.log($("#newlectClass").val())
		var newClass = $("#newlectClass").val();

		 if (newClass != '') {
			$.ajax({
				url : "<c:url value='/qxsepmny/entran/admAjaxClassUpdate.do'/>",
				type : "post",
				data : "newClass=" + newClass,
				dataType : "json",
				success : function(data) {
					var ClassList = data.classList;
					var html = '<option value="">선택</option>';
					for (var i = 0; i < ClassList.length; i++) {
						html += '<option value="'+ClassList[i].name+'">'+ ClassList[i].name + '</option>';
					}
					$("#lectClassroom").html(html);
					$("#addlectClass").addClass('dpn');
					$("#newClass").val('');
				},
				error : function() {
					alert("오류가 발생하였습니다.");
				}
			});
		} else {
			alert('추가하실 강의실을 입력해 주세요.');
		} 
	}

	
</script>
<body>
<form:form commandName="lectureVO" id="detaleList" name="detaleList">
<input type="hidden" name="lectSeq" id="lectSeq" value="${lectVO.lectSeq }"/>
<%-- <form:hidden path="lectSeq"/> --%>
<input type="hidden" id="diviCheck" value="">
<input type="hidden" id="doubleChk" value="">
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="교육과정"/>
		            <jsp:param name="dept2" value="강의개설"/>
	           	</jsp:include>
				<p class="sub-title">기본 정보</p>
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
								<th><sup>*</sup>학기</th>
								<td colspan="3">
									<select id="lectYear" name="lectYear" onchange="selectLectSem(this);return false;">
										<!-- <option value="">선택</option> -->
										<c:forEach var="result" items="${SemeCode}">
											<option value="">**년도**</option>
											<option value="${result.semYear}"<c:if test="${result.semYear eq lectVO.lectYear}">selected="selected"</c:if>>${result.semYear}</option>
										</c:forEach>
									</select>
									<select id="lectSem" name="lectSem">
									<c:if test="${lectVO.lectSem eq '1'?'봄학기':lectVO.lectSem eq '2'?'여름학기':lectVO.lectSem eq '3'?'가을학기':'겨울학기' }"/>
										<option value="${lectVO.lectSem}">${lectVO.lectSem}</option>
										<!-- <option value="">선택</option>
										<c:forEach var="result" items="${SemeCode}">
											<option value="${result.semester}" <c:if test="${result.semester eq lectVO.lectSem}">selected="selected"</c:if>>
										<c:if test="${lectVO.lectSem eq '1'}">봄학기</c:if>
										<c:if test="${lectVO.lectSem eq '2'}">여름학기</c:if>
										<c:if test="${lectVO.lectSem eq '3'}">가을학기</c:if>
										<c:if test="${lectVO.lectSem eq '4'}">겨울학기</c:if>
											</option>
										</c:forEach> -->
									</select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>교육과정</th>
								<td>
									<select id="lectCurr" name="lectCurr">
										<!-- <option value="">선택</option> -->
										<c:forEach var="result" items="${currName}">
											<option value="${result.currName}" <c:if test="${result.currName eq lectVO.lectCurr}">selected="selected"</c:if>>${result.currName}</option>
										</c:forEach>
									</select>
								</td>
								<th><sup>*</sup>프로그램</th>
								<td>
									<select id="lectProg" name="lectProg">
										<!-- <option value="">선택</option> -->
										<c:forEach var="result" items="${progName}">
											<option value="${result.progName}" <c:if test="${result.progName eq lectVO.lectProg}">selected="selected"</c:if>>${result.progName}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>교과목</th>
								<td>
									<select id="lectName" name="lectName">
										<!-- <option value="">선택</option> -->
										<c:forEach var="result" items="${courName}">
											<option value="${result.courName}" <c:if test="${result.courName eq lectVO.lectName}">selected="selected"</c:if>>${result.courName}</option>
										</c:forEach>
									</select>
								</td>
								<th><sup>*</sup>분반</th>
								<td>
									<%-- <select id="lectDivi" name="lectDivi">
										<option value="">선택</option>
										<c:forEach var="result" items="${division}">
											<option value="${result.name}" <c:if test="${result.name eq lectVO.lectDivi}">selected="selected"</c:if>>${result.name}</option>
										</c:forEach>
									</select> --%>
									<form:select path="lectDivi" class="required select-one" title="분반">
										<form:option value="">선택</form:option>
											<c:forEach var="result" items="${diviList}">
												<option value="${result.name}" <c:if test="${result.name eq lectVO.lectDivi}">selected="selected"</c:if>>${result.name}</option>
											</c:forEach>
										</form:select>
									<button type="button" class="normal-btn" id="diviChk" onclick="fn_chk()">중복확인</button>
									<button class="normal-btn" onclick="fn_addDivi(); return false;">추가</button>
									<label class="dpn" id="addDivi">
											<input type="text" class="input-data" id="newDivi" name="newDivi" placeholder="" />
											<button class="normal-btn" onclick="fn_save_divi(); return false;">저장</button>
									</label>
								</td>
							</tr>
							<tr>
								<th>정원</th>
								<td>
									<input type="text" id="lectPer" name="lectPer" value="${lectVO.lectPer }" class="input-data w50px" /> 명
								</td>
								<th><sup>*</sup>등급</th>
								<td>
									<select id="lectGrade" name="lectGrade" class="required select-one" title="등급">
										<c:forEach begin="1" end="6" var="grade">
											<option value="${grade }" <c:if test="${grade eq lectVO.lectGrade}">selected="selected"</c:if>><c:out value="${grade }"/></option>
										</c:forEach>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">강의정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>강의실</th>
								<td>
									<%-- <select id="lectClassroom" name="">
										<option value="상상관1113호" <c:if test="${lectVO.lectClassroom eq '상상관1113호'}">selected="selected"</c:if> >상상관1113호</option>
										<option value="상상관1112호" <c:if test="${lectVO.lectClassroom eq '상상관1112호'}">selected="selected"</c:if> >상상관1112호</option>
									</select> --%>
									<form:select path="lectClassroom" class="required select-one" title="강의실">
										<form:option value="">선택</form:option>
											<c:forEach var="result" items="${lectclassList}">
												<option value="${result.name}" <c:if test="${result.name eq lectVO.lectClassroom}">selected="selected"</c:if>>${result.name}</option>
											</c:forEach>
									</form:select>
							
									<button class="normal-btn" onclick="fn_addlectClass(); return false;">추가</button>
									<label class="dpn" id="addlectClass">
											<input type="text" class="input-classdata" id="newlectClass" name="newlectClass" placeholder="" value="" />
											<button class="normal-btn" onclick="fn_save_lectclass(); return false;">저장</button>
									</label>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>담임교사</th>
								<td>
									<select id="lectClaTea" name="lectClaTea" >
										<c:forEach var="result" items="${teacher}">
											<option value="${result.memberCode}" <c:if test="${result.memberCode eq lectVO.lectClaTea}">selected="selected"</c:if>>${result.name}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>개설여부</th>
								<td>
									<input type="radio" id="rad01" name="lectState" value="Y" <c:if test="${lectVO.lectState eq 'Y'}"> checked = "checked" </c:if> checked/> <label for="rad01">개강</label> &nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" id="rad02" name="lectState" value="N" <c:if test="${lectVO.lectState eq 'N'}"> checked = "checked" </c:if> /> <label for="rad02">폐강</label>
								
								</td>
							</tr>
							<tr>
								<th>개설기간</th>
							<%

							Date date = new Date();
							SimpleDateFormat simpleDate = new SimpleDateFormat("yyy-MM-dd");
							String strdate = simpleDate.format(date);
							
							%>
							
								<td>
									<input type="text" id="datepicker01" name="lectSdate" placeholder="<%= strdate%>" value="${lectVO.lectSdate }"> -
									<input type="text" id="datepicker02" name="lectEdate" placeholder="<%= strdate%>" value="${lectVO.lectEdate }">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="delSeq"></div>
				<!--// table -->
				<p class="sub-title">수업시간</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><button type="button" class="normal-btn"onclick="fn_addClass(); return false;">시간추가+</button></th>
								
								<td>
								<c:forEach items="${timeTableList }" var="result" varStatus="status">
									<p class="timeClass" name="pClass" id="pClass<c:out value='${status.index }'/>">
								<input type="hidden" name="timeTableList[<c:out value='${status.index }'/>].lectTbseq" value="<c:out value='${result.lectTbseq }'/>" id="lectTbSeq<c:out value='${status.index }'/>"/>
										<select name="timeTableList[<c:out value='${status.index }'/>].lectWeek" id="lectWeek<c:out value='${status.index }'/>">
											<option value="월요일" <c:if test="${result.lectWeek eq '월요일'}"> selected="selected" </c:if> >월요일</option>
											<option value="화요일" <c:if test="${result.lectWeek eq '화요일'}"> selected="selected" </c:if> >화요일</option>
											<option value="수요일" <c:if test="${result.lectWeek eq '수요일'}"> selected="selected" </c:if> >수요일</option>
											<option value="목요일" <c:if test="${result.lectWeek eq '목요일'}"> selected="selected" </c:if> >목요일</option>
											<option value="금요일" <c:if test="${result.lectWeek eq '금요일'}"> selected="selected" </c:if> >금요일</option>
										</select>
										<select name="timeTableList[<c:out value='${status.index }'/>].lectSclass" id="lectSclass<c:out value='${status.index }'/>">
											<option value="1" <c:if test="${result.lectSclass eq '1'}"> selected="selected" </c:if> >1교시</option>
											<option value="2" <c:if test="${result.lectSclass eq '2'}"> selected="selected" </c:if> >2교시</option>
											<option value="3" <c:if test="${result.lectSclass eq '3'}"> selected="selected" </c:if> >3교시</option>
											<option value="4" <c:if test="${result.lectSclass eq '4'}"> selected="selected" </c:if> >4교시</option>
											<option value="5" <c:if test="${result.lectSclass eq '5'}"> selected="selected" </c:if> >5교시</option>
											<option value="6" <c:if test="${result.lectSclass eq '6'}"> selected="selected" </c:if> >6교시</option>
										</select>
										-
										<select name="timeTableList[<c:out value='${status.index }'/>].lectEclass" id="lectEclass<c:out value='${status.index }'/>">
											<option value="1" <c:if test="${result.lectEclass eq '1'}"> selected="selected" </c:if> >1교시</option>
											<option value="2" <c:if test="${result.lectEclass eq '2'}"> selected="selected" </c:if> >2교시</option>
											<option value="3" <c:if test="${result.lectEclass eq '3'}"> selected="selected" </c:if> >3교시</option>
											<option value="4" <c:if test="${result.lectEclass eq '4'}"> selected="selected" </c:if> >4교시</option>
											<option value="5" <c:if test="${result.lectEclass eq '5'}"> selected="selected" </c:if> >5교시</option>
											<option value="6" <c:if test="${result.lectEclass eq '6'}"> selected="selected" </c:if> >6교시</option>
										</select>
										<select name="timeTableList[<c:out value='${status.index }'/>].lectGrammar" id="lectGrammar<c:out value='${status.index }'/>">
											<option value="어휘문법" <c:if test="${result.lectGrammar eq '어휘문법'}"> selected="selected" </c:if> >어휘문법</option>
											<option value="말하기" <c:if test="${result.lectGrammar eq '말하기'}"> selected="selected" </c:if> >말하기</option>
										</select>
										<select name="timeTableList[<c:out value='${status.index }'/>].lectTea" id="lectTea<c:out value='${status.index }'/>">
											<c:forEach var="teacher" items="${teacher}">
												<option value="${teacher.memberCode}" <c:if test="${teacher.memberCode eq result.lectTea}"> selected="selected" </c:if>>${teacher.name}</option>
											</c:forEach>
										</select>
<!-- 										<input type="text" name="checkClassTime" id="checkClassTime" /> -->
										<c:if test="${status.index eq 0}"></c:if>
										<c:if test="${status.index ne 0}">
											<button type="button" id="btnSeq<c:out value='${status.index }'/>" onclick="delClass(this, <c:out value='${status.index }'/>); return false;" value="<c:out value='${result.lectTbseq }'/>">x</button>
										</c:if>
									</p>
								</c:forEach>
								<div id="timeTable">
								<c:if test="${timeTableList.size() == 0 || timeTableList == null }">
									<p class="timeClass" name="pClass">
										<select name="timeTableList[0].lectWeek">
											<option value="월요일" >월요일</option>
											<option value="화요일" >화요일</option>
											<option value="수요일" >수요일</option>
											<option value="목요일" >목요일</option>
											<option value="금요일" >금요일</option>
										</select>
										<select name="timeTableList[0].lectSclass">
											<option value="1">1교시</option>
											<option value="2">2교시</option>
											<option value="3">3교시</option>
											<option value="4">4교시</option>
											<option value="5">5교시</option>
											<option value="6">6교시</option>
										</select>
										-
										<select name="timeTableList[0].lectEclass">
											<option value="1">1교시</option>
											<option value="2">2교시</option>
											<option value="3">3교시</option>
											<option value="4">4교시</option>
											<option value="5">5교시</option>
											<option value="6">6교시</option>
										</select>
										<select name="timeTableList[0].lectGrammar">
											<option value="어휘문법">어휘문법</option>
											<option value="말하기">말하기</option>
										</select>
										<select name="timeTableList[0].lectTea">
											<c:forEach var="result" items="${teacher}">
												<option value="${result.memberCode}">${result.name}</option>
											</c:forEach>
										</select>
<!-- 										<input type="text" name="checkClassTime" id="checkClassTime" /> -->
<!-- 										<button type="button" name="delClass">x</button> -->
									</p>
							</c:if>
							</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admLectList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_add()" id="add" >저장</button>
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