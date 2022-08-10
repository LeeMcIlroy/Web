<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<script type="text/javascript">
//페이지 로딩시 추가탭 전부 숨김, 임용이력 리스트 불러오기
var seq = "";
$(document).ready(function(){
	fn_hide();
	fn_tab('');
	$("input:radio[name='tabs']:radio[value='']").prop('checked', true);
	$(document).on("click",".underline",function(event){
		seq = $(this).attr('value'); 
		var type = $(this).attr('type');
		if(type == "F"){
			$.ajax({
				url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubTab1One.do'/>"
				, type: "post"
				, data: "seq="+seq+"&type="+type
				, dataType:"json"
				, success: function(data){
					resultList = data.resultList;
					$("#prfFYear").val(resultList.prfFYear);
					$("#prfFSem").val(resultList.prfFSem);
					$("#datepicker03").val(resultList.prfFSDate);
					$("#datepicker04").val(resultList.prfFEDate);
					$("#prfFHour").val(resultList.prfFHour);
					$("#prfFGrade").val(resultList.prfFGrade);
					$("#prfFGubun").val(resultList.prfFGubun);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}else if(type == "S"){
			$.ajax({
				url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubTab1One.do'/>"
				, type: "post"
				, data: "seq="+seq+"&type="+type
				, dataType:"json"
				, success: function(data){
					resultList = data.resultList;
					$("#prfSYear").val(resultList.prfSYear);
					$("#prfSSem").val(resultList.prfSSem);
					$("#prfSStep").val(resultList.prfSStep);
					$("#prfSDivi").val(resultList.prfSDivi);
					$("#prfSPosition").val(resultList.prfSPosition);
					$("#datepicker05").val(resultList.prfSSDate);
					$("#datepicker06").val(resultList.prfSEDate);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}else if(type == "T"){
			$.ajax({
				url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubTab1One.do'/>"
				, type: "post"
				, data: "seq="+seq+"&type="+type
				, dataType:"json"
				, success: function(data){
					resultList = data.resultList;
					$("#prfTYear").val(resultList.prfTYear);
					$("#prfTSem").val(resultList.prfTSem);
					$("#datepicker07").val(resultList.prfTAnnoDate);
					$("#prfTBelong").val(resultList.prfTBelong);
					$("#prfTPosition").val(resultList.prfTPosition);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}else if(type == "P"){
			$.ajax({
				url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubTab1One.do'/>"
				, type: "post"
				, data: "seq="+seq+"&type="+type
				, dataType:"json"
				, success: function(data){
					resultList = data.resultList;
					$("#prfPCerti").val(resultList.prfPCerti);
					$("#prfPIncidental").val(resultList.prfPIncidental);
					$("#prfPCauseIssue").val(resultList.prfPCauseIssue);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
		fn_add(seq)
		return false;
    }); 
	$(document).on("click","#print",function(event){
		fn_hide();
		var memberCode = $("#memberCode").val();
		seq = $(this).attr('value'); 
		fn_printPrf(memberCode, seq);
		return false;
    }); 
}); 
//년도 선택시 학기리스트 표출
function fn_search_semester(ele,type){
	var menuType = $("#menuType").val();
	$.ajax({
		url: "<c:url value='/usr/cmm/ajaxSearchSeme.do'/>"
		, type: "post"
		, data: "year="+$(ele).val()
		, dataType:"json"
		, success: function(data){
			resultList = data.semeList;
			var html = "";

			html += '<option value="">전체</option>';
			for(var i=0; i<resultList.length; i++){
				html += '<option value="'+resultList[i].semester+'">'+resultList[i].semeNm+'</option>';
			}
			$("#prf"+type+"Sem").html(html);
		}, error: function(){
			alert("오류가 발생하였습니다.");
		}
	});
}
//학기 선택시 과목명 리스트 표출
function fn_search_lectName(ele, type){
	var year = $("#prfSYear").val();
	$.ajax({
		url: "<c:url value='/qxsepmny/admstr/admAjaxProfLectName.do'/>"
		, type: "post"
		, data: "seme="+$(ele).val()+"&year="+year
		, dataType:"json"
		, success: function(data){
			resultList = data.lectNameList;
			var html = "";
			html += '<option value="">전체</option>';
			for(var i=0; i<resultList.length; i++){
				html += '<option value="'+resultList[i].lectName+'">'+resultList[i].lectName+'</option>';
			}
			$("#prfSStep").html(html);
		}, error: function(){
			alert("오류가 발생하였습니다.");
		}
	});

	$.ajax({
		url: "<c:url value='/qxsepmny/admstr/admAjaxProfEnterDate.do'/>"
		, type: "post"
		, data: "seme="+$(ele).val()+"&year="+year
		, dataType:"json"
		, success: function(data){
			resultList = data.enterDateList;
			document.getElementById("datepicker05").value=resultList[0].enterRegiS;
			document.getElementById("datepicker06").value=resultList[0].enterRegiE;
		}, error: function(){
			alert("오류가 발생하였습니다.");
		}
	});
}
//학기 선택시  개설일자
function fn_search_enter_date(ele, type){
	var year = $("#prfFYear").val();
	$.ajax({
		url: "<c:url value='/qxsepmny/admstr/admAjaxProfEnterDate.do'/>"
		, type: "post"
		, data: "seme="+$(ele).val()+"&year="+year
		, dataType:"json"
		, success: function(data){
			resultList = data.enterDateList;
			document.getElementById("datepicker03").value=resultList[0].enterRegiS;
			document.getElementById("datepicker04").value=resultList[0].enterRegiE;
		}, error: function(){
			alert("오류가 발생하였습니다.");
		}
	});
}
//과목 선택시 분반 리스트 표출
function fn_search_divi(ele){
	var year = $("#prfSYear").val();
	var seme = $("#prfSSem").val();
	$.ajax({
		url: "<c:url value='/qxsepmny/admstr/ajaxSearchDivi.do'/>"
		, type: "post"
		, data: "name="+$(ele).val()+"&year="+year+"&seme="+seme
		, dataType:"json"
		, success: function(data){
			resultList = data.lectDiviList;
			var html = "";
			html += '<option value="">전체</option>';
			for(var i=0; i<resultList.length; i++){
				html += '<option value="'+resultList[i].lectDivi+'">'+resultList[i].lectDivi+'</option>';
			}
			$("#prfSDivi").html(html);
		}, error: function(){
			alert("오류가 발생하였습니다.");
		}
	});
}
//탭 추가 전부 숨김
function fn_hide(){
	$("#subAdd1").css("display", "none" );
	$("#subAdd2").css("display", "none" );
	$("#subAdd3").css("display", "none" );
	$("#subAdd4").css("display", "none" );
}
function fn_clear(){
	$("#prfFYear").val("");
	$("#prfFSem").val("");
	$("#datepicker03").val("");
	$("#datepicker04").val("");
	$("#prfFHour").val("");
	$("#prfFGrade").val("");
	$("#prfFGubun").val("");
	$("#prfSYear").val("");
	$("#prfSSem").val("");
	$("#prfSStep").val("");
	$("#prfSDivi").val("");
	$("#datepicker05").val("");
	$("#datepicker06").val("");
	$("#prfSPosition").val("");
	$("#prfTYear").val("");
	$("#prfTSem").val("");
	$("#datepicker07").val("");
	$("#prfTBelong").val("");
	$("#prfTPosition").val("");
	$("#prfPCerti").val("");
	$("#prfPIncidental").val("");
	$("#prfPCauseIssue").val("");
}
//선택된 탭에 따른 리스트 불러오기
function fn_tab(menu){
	$("#menuType").val(menu);
	if(menu == ''){
		$("input:radio[name='tabs']:radio[value='']").prop('checked', true);
		fn_hide();
		$.ajax({
			url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubTab1.do'/>"
				, type: "post"
				, data: "memberCode="+$("#memberCode").val()
				, dataType:"json"
				, success: function(data){
					var resultList = data.resultList;
					var html = "";
					html += '<tr>';
					html += '	<th>No.</th>';
					html += '	<th>년도</th>';
					html += '	<th>학기</th>';
					html += '	<th>시작일자</th>';
					html += '	<th>종료일자</th>';
					html += '	<th>시수</th>';
					html += '	<th>등급</th>';
					html += '	<th>강사구분</th>';
					html += '	<th>작업일자</th>';
					html += '</tr>';
					for(var i=0; i<resultList.length; i++){
						html += '<tr>';
						html += '<input type="hidden" id="prfFSeq'+resultList[i].prfFSeq+'" name="prfFSeq" value="'+resultList[i].prfFSeq+'"/>';
						html += '	<td>'+(resultList.length - i)+'</td>';
						html += '	<td>'+resultList[i].prfFYear+'</td>';
						html += '	<td>'+resultList[i].prfFSem+'</td>';
						html += '	<td><a href="#" class="underline" type="F" value="'+resultList[i].prfFSeq+'">'+resultList[i].prfFSDate+'</a></td>';
						html += '	<td><a href="#" class="underline" type="F" value="'+resultList[i].prfFSeq+'"); return false;">'+resultList[i].prfFEDate+'</a></td>';
						html += '	<td>'+resultList[i].prfFHour+'</td>';
						html += '	<td>'+resultList[i].prfFGrade+'</td>';
						html += '	<td>'+resultList[i].prfFGubun+'</td>';
						html += '	<td>'+resultList[i].prfFWorkDay+'</td>';
						html += '</tr>';
					}
					if(resultList.length == 0){
						html += '<tr>';
						html += '	<td colspan="9">등록된 내용이 없습니다.</td>';
						html += '</tr>';
					}
					$("#subTab").html(html);
					
					var cnt = '<strong>'+resultList.length+'</strong>건이 검색되었습니다.';
					$(".search-count").html(cnt);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		fn_clear()
	}else if(menu == '2'){
		$("input:radio[name='tabs']:radio[value='2']").prop('checked', true);
		fn_hide();
		$.ajax({
			url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubTab2.do'/>"
				, type: "post"
				, data: "memberCode="+$("#memberCode").val()
				, dataType:"json"
				, success: function(data){
					var resultList = data.resultList;
					var html = "";
					html += '<tr>';
					html += '	<th>No.</th>';
					html += '	<th>년도</th>';
					html += '	<th>학기</th>';
					html += '	<th>급수</th>';
					html += '	<th>분반</th>';
					html += '	<th>시작일자</th>';
					html += '	<th>종료일자</th>';
					html += '	<th>직책</th>';
					html += '</tr>';
					for(var i=0; i<resultList.length; i++){
						html += '<tr>';
						html += '	<td>'+(resultList.length - i)+'</td>';
						html += '<input type="hidden" id="prfSSeq'+resultList[i].prfSSeq+'" name="prfSSeq" value="'+resultList[i].prfSSeq+'"/>';
						html += '	<td><a href="#" class="underline" type="S" value="'+resultList[i].prfSSeq+'">'+resultList[i].prfSYear+'</a></td>';
						html += '	<td><a href="#" class="underline" type="S" value="'+resultList[i].prfSSeq+'">'+resultList[i].prfSSem+'</a></td>';
						html += '	<td><a href="#" class="underline" type="S" value="'+resultList[i].prfSSeq+'">'+resultList[i].prfSStep+'</a></td>';
						html += '	<td><a href="#" class="underline" type="S" value="'+resultList[i].prfSSeq+'">'+resultList[i].prfSDivi+'</a></td>';
						html += '	<td>'+resultList[i].prfSSDate+'</td>';
						html += '	<td>'+resultList[i].prfSEDate+'</td>';
						html += '	<td>'+resultList[i].prfSPosition+'</td>';
						html += '</tr>';
					}
					if(resultList.length == 0){
						html += '<tr>';
						html += '	<td colspan="9">등록된 내용이 없습니다.</td>';
						html += '</tr>';
					}
					$("#subTab").html(html);
					
					var cnt = '<strong>'+resultList.length+'</strong>건이 검색되었습니다.';
					$(".search-count").html(cnt);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		fn_clear()
	}else if(menu == '3'){
		$("input:radio[name='tabs']:radio[value='3']").prop('checked', true);
		fn_hide();
		$.ajax({
			url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubTab3.do'/>"
				, type: "post"
				, data: "memberCode="+$("#memberCode").val()
				, dataType:"json"
				, success: function(data){
					var resultList = data.resultList;
					var html = "";
					html += '<tr>';
					html += '	<th>No.</th>';
					html += '	<th>발령일자</th>';
					html += '	<th>소속</th>';
					html += '	<th>직함</th>';
					html += '	<th>작업일자</th>';
					html += '</tr>';
					for(var i=0; i<resultList.length; i++){
						html += '<tr>';
						html += '	<td>'+(resultList.length - i)+'</td>';
						html += '<input type="hidden" id="prfTSeq'+resultList[i].prfTSeq+'" name="prfTSeq" value="'+resultList[i].prfTSeq+'"/>';
						html += '	<td><a href="#" class="underline" type="T" value="'+resultList[i].prfTSeq+'">'+resultList[i].prfTAnnoDate+'</a></td>';
						html += '	<td><a href="#" class="underline" type="T" value="'+resultList[i].prfTSeq+'">'+resultList[i].prfTBelong+'</a></td>';
						html += '	<td>'+resultList[i].prfTPosition+'</td>';
						html += '	<td>'+resultList[i].prfTWorkDay+'</td>';
						html += '</tr>';
					}
					if(resultList.length == 0){
						html += '<tr>';
						html += '	<td colspan="9">등록된 내용이 없습니다.</td>';
						html += '</tr>';
					}
					$("#subTab").html(html);
					
					var cnt = '<strong>'+resultList.length+'</strong>건이 검색되었습니다.';
					$(".search-count").html(cnt);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		fn_clear()
	}else if(menu == '4'){
		$("input:radio[name='tabs']:radio[value='4']").prop('checked', true);
		fn_hide();
		$.ajax({
			url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubTab4.do'/>"
			, type: "post"
			, data: "memberCode="+$("#memberCode").val()
			, dataType:"json"
			, success: function(data){
				var resultList = data.resultList;
				var html = "";
				html += '<tr>';
				html += '	<th>No.</th>';
				html += '	<th>발급번호</th>';
				html += '	<th>증명서</th>';
				html += '	<th>발급사유</th>';
				html += '	<th>발급일시</th>';
				html += '	<th>부수</th>';
				html += '	<th>발행</th>';
				html += '</tr>';
				for(var i=0; i<resultList.length; i++){
					html += '<tr>';
					html += '	<td>'+(resultList.length - i)+'</td>';
					html += '<input type="hidden" id="prfPSeq'+resultList[i].prfPSeq+'" name="prfPSeq" value="'+resultList[i].prfPSeq+'"/>';
					html += '	<td><a href="#" class="underline" type="P" value="'+resultList[i].prfPSeq+'">'+resultList[i].prfPIssueNum+'</a></td>';
					html += '	<td><a href="#" class="underline" type="P" value="'+resultList[i].prfPSeq+'">'+resultList[i].prfPCerti+'</a></td>';
					html += '	<td>'+resultList[i].prfPCauseIssue+'</td>';
					html += '	<td>'+resultList[i].prfPDateIssue+'</td>';
					html += '	<td>'+resultList[i].prfPIncidental+'</td>';
					html += '	<td><a href="#" value="'+resultList[i].prfPSeq+'" id="print" class="underline">인쇄</a></td>';
					html += '</tr>';
				}
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="9">등록된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				$("#subTab").html(html);
				
				var cnt = '<strong>'+resultList.length+'</strong>건이 검색되었습니다.';
				$(".search-count").html(cnt);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
		fn_clear()
	}
} 
//추가 버튼 눌렀을때 어떤 양식 불러올껀지 선택
function fn_add(seq){
	var menuType = $("#menuType").val();
	if(menuType == ''){
		fn_hide();
		fn_clear()
		$("#subAdd1").css("display", "" );
	}else if(menuType == '2'){
		fn_hide();
		fn_clear()
		$("#subAdd2").css("display", "" );
	}else if(menuType == '3'){
		fn_hide();
		fn_clear()
		$("#subAdd3").css("display", "" );
	}else if(menuType == '4'){
		fn_hide();
		fn_clear()
		$("#subAdd4").css("display", "" );
	}
}
//탭 테이블별로 add시키고 리스트 재표출
function fn_save(el){
	if(el == 1){
		var prfFSeq = seq;
		var memberCode = $("#memberCode").val();
		var prfFYear = $("#prfFYear").val();
		var prfFSem = $("#prfFSem").val();
		var prfFSDate = $("#datepicker03").val();
		var prfFEDate = $("#datepicker04").val();
		var prfFHour = $("#prfFHour").val();
		var prfFGrade = $("#prfFGrade").val();
		var prfFGubun = $("#prfFGubun").val();
		
		if(prfFYear == '' || prfFSem == ''){
			alert('년도/학기를 선택해 주세요.');
			$("#prfFYear").focus();
			return false;
		}else if(prfFSDate == ''){
			alert('시작일자를 선택해 주세요.');
			$("#datepicker03").focus();
			return false;
		}else if(prfFHour == ''){
			alert('시수를 입력해 주세요.');
			$("#prfFHour").focus();
			return false;
		}else if(prfFGrade == ''){
			alert('등급을 선택해 주세요.');
			$("#prfFGrade").focus();
			return false;
		}else if(prfFGubun == ''){
			alert('강사구분을 선택해 주세요.');
			$("#prfFGubun").focus();
			return false;
		}else{
			$.ajax({
				url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubSave1.do'/>",
				type : "post",
				data : "prfFYear="+prfFYear+"&prfFSem="+prfFSem+"&prfFSDate="+prfFSDate+"&prfFEDate="+prfFEDate+"&prfFHour="+prfFHour+"&prfFGrade="+prfFGrade+"&prfFGubun="+prfFGubun+"&memberCode="+memberCode+"&prfFSeq="+prfFSeq,
				dataType : "json",
				success: function(data){
					var resultList = data.resultList;
					var html = "";
					html += '<tr>';
					html += '	<th>No.</th>';
					html += '	<th>년도</th>';
					html += '	<th>학기</th>';
					html += '	<th>시작일자</th>';
					html += '	<th>종료일자</th>';
					html += '	<th>시수</th>';
					html += '	<th>등급</th>';
					html += '	<th>강사구분</th>';
					html += '	<th>작업일자</th>';
					html += '</tr>';
					for(var i=0; i<resultList.length; i++){
						html += '<tr>';
						html += '<input type="hidden" id="prfFSeq'+resultList[i].prfFSeq+'" name="prfFSeq" value="'+resultList[i].prfFSeq+'"/>';
						html += '	<td>'+(resultList.length - i)+'</td>';
						html += '	<td>'+resultList[i].prfFYear+'</td>';
						html += '	<td>'+resultList[i].prfFSem+'</td>';
						html += '	<td><a href="#" class="underline" type="F" value="'+resultList[i].prfFSeq+'">'+resultList[i].prfFSDate+'</a></td>';
						html += '	<td><a href="#" class="underline" type="F" value="'+resultList[i].prfFSeq+'"); return false;">'+resultList[i].prfFEDate+'</a></td>';
						html += '	<td>'+resultList[i].prfFHour+'</td>';
						html += '	<td>'+resultList[i].prfFGrade+'</td>';
						html += '	<td>'+resultList[i].prfFGubun+'</td>';
						html += '	<td>'+resultList[i].prfFWorkDay+'</td>';
						html += '</tr>';
					}
					if(resultList.length == 0){
						html += '<tr>';
						html += '	<td colspan="9">등록된 내용이 없습니다.</td>';
						html += '</tr>';
					}
					$("#subTab").html(html);
					
					var cnt = '<strong>'+resultList.length+'</strong>건이 검색되었습니다.';
					$(".search-count").html(cnt);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
		$("#subAdd1").css("display", "none" );
		fn_clear()
	}else if(el == 2){
		var prfSSeq = seq;
		var memberCode = $("#memberCode").val();
		var prfSYear = $("#prfSYear").val();
		var prfSSem = $("#prfSSem").val();
		var prfSStep = $("#prfSStep").val();
		var prfSDivi = $("#prfSDivi").val();
		var prfSSDate = $("#datepicker05").val();
		var prfSEDate = $("#datepicker06").val();
		var prfSPosition = $("#prfSPosition").val();
		
		if(prfSYear == '' || prfSSem == ''){
			alert('년도/학기를 선택해 주세요.');
			$("#prfSYear").focus();
			return false;
		}else if(prfSStep == ''){
			alert('급수를 선택해 주세요.');
			$("#prfSStep").focus();
			return false;
		}else if(prfSDivi == ''){
			alert('분반를 입력해 주세요.');
			$("#prfSDivi").focus();
			return false;
		}else if(prfSSDate == ''){
			alert('시작일자를 선택해 주세요.');
			$("#prfSSDate").focus();
			return false;
		}else if(prfSEDate == ''){
			alert('종료일자를 선택해 주세요.');
			$("#prfSEDate").focus();
			return false;
		}else if(prfSPosition == ''){
			alert('직책을 선택해 주세요.');
			$("#prfSPosition").focus();
			return false;
		}else{
			$.ajax({
				url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubSave2.do'/>",
				type : "post",
				data : "prfSYear="+prfSYear+"&prfSSem="+prfSSem+"&prfSStep="+prfSStep+"&prfSDivi="+prfSDivi+"&prfSSDate="+prfSSDate+"&prfSEDate="+prfSEDate+"&prfSPosition="+prfSPosition+"&memberCode="+memberCode+"&prfSSeq="+prfSSeq,
				dataType : "json",
				 success: function(data){
					var resultList = data.resultList;
					var html = "";
					html += '<tr>';
					html += '	<th>No.</th>';
					html += '	<th>년도</th>';
					html += '	<th>학기</th>';
					html += '	<th>급수</th>';
					html += '	<th>분반</th>';
					html += '	<th>시작일자</th>';
					html += '	<th>종료일자</th>';
					html += '	<th>직책</th>';
					html += '</tr>';
					for(var i=0; i<resultList.length; i++){
						html += '<tr>';
						html += '	<td>'+(resultList.length - i)+'</td>';
						html += '<input type="hidden" id="prfSSeq'+resultList[i].prfSSeq+'" name="prfSSeq" value="'+resultList[i].prfSSeq+'"/>';
						html += '	<td><a href="#" class="underline" type="S" value="'+resultList[i].prfSSeq+'">'+resultList[i].prfSYear+'</a></td>';
						html += '	<td><a href="#" class="underline" type="S" value="'+resultList[i].prfSSeq+'">'+resultList[i].prfSSem+'</a></td>';
						html += '	<td><a href="#" class="underline" type="S" value="'+resultList[i].prfSSeq+'">'+resultList[i].prfSStep+'</a></td>';
						html += '	<td><a href="#" class="underline" type="S" value="'+resultList[i].prfSSeq+'">'+resultList[i].prfSDivi+'</a></td>';
						html += '	<td>'+resultList[i].prfSSDate+'</td>';
						html += '	<td>'+resultList[i].prfSEDate+'</td>';
						html += '	<td>'+resultList[i].prfSPosition+'</td>';
						html += '</tr>';
					}
					if(resultList.length == 0){
						html += '<tr>';
						html += '	<td colspan="9">등록된 내용이 없습니다.</td>';
						html += '</tr>';
					}
					$("#subTab").html(html);
					
					var cnt = '<strong>'+resultList.length+'</strong>건이 검색되었습니다.';
					$(".search-count").html(cnt);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
		$("#subAdd2").css("display", "none" );
		fn_clear()
	}else if(el == 3){
		var prfTSeq = seq;
		var memberCode = $("#memberCode").val();
		var prfTYear = $("#prfTYear").val();
		var prfTSem = $("#prfTSem").val();
		var prfTAnnoDate = $("#datepicker07").val();
		var prfTBelong = $("#prfTBelong").val();
		var prfTPosition = $("#prfTPosition").val();

		if(prfTYear == '' || prfTSem == ''){
			alert('년도/학기를 선택해 주세요.');
			$("#prfTYear").focus();
			return false;
		}else if(prfTAnnoDate == ''){
			alert('발령일자를 선택해 주세요.');
			$("#prfTAnnoDate").focus();
			return false;
		}else if(prfTBelong == ''){
			alert('소속을 입력해 주세요.');
			$("#prfTBelong").focus();
			return false;
		}else if(prfTPosition == ''){
			alert('직함을 선택해 주세요.');
			$("#prfTPosition").focus();
			return false;
		}else{
			$.ajax({
				url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubSave3.do'/>",
				type : "post",
				data : "prfTYear="+prfTYear+"&prfTSem="+prfTSem+"&prfTAnnoDate="+prfTAnnoDate+"&prfTBelong="+prfTBelong+"&prfTPosition="+prfTPosition+"&memberCode="+memberCode+"&prfTSeq="+prfTSeq,
				dataType : "json",
				success: function(data){
					var resultList = data.resultList;
					var html = "";
					html += '<tr>';
					html += '	<th>No.</th>';
					html += '	<th>발령일자</th>';
					html += '	<th>소속</th>';
					html += '	<th>직함</th>';
					html += '	<th>작업일자</th>';
					html += '</tr>';
					for(var i=0; i<resultList.length; i++){
						html += '<tr>';
						html += '	<td>'+(resultList.length - i)+'</td>';
						html += '<input type="hidden" id="prfTSeq'+resultList[i].prfTSeq+'" name="prfTSeq" value="'+resultList[i].prfTSeq+'"/>';
						html += '	<td><a href="#" class="underline" type="T" value="'+resultList[i].prfTSeq+'">'+resultList[i].prfTAnnoDate+'</a></td>';
						html += '	<td><a href="#" class="underline" type="T" value="'+resultList[i].prfTSeq+'">'+resultList[i].prfTBelong+'</a></td>';
						html += '	<td>'+resultList[i].prfTPosition+'</td>';
						html += '	<td>'+resultList[i].prfTWorkDay+'</td>';
						html += '</tr>';
					}
					if(resultList.length == 0){
						html += '<tr>';
						html += '	<td colspan="9">등록된 내용이 없습니다.</td>';
						html += '</tr>';
					}
					$("#subTab").html(html);
					
					var cnt = '<strong>'+resultList.length+'</strong>건이 검색되었습니다.';
					$(".search-count").html(cnt);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
		$("#subAdd3").css("display", "none" );
		fn_clear()
	}else if(el == 4){
		var prfPSeq = seq;
		var memberCode = $("#memberCode").val();
		var prfPCerti = $("#prfPCerti").val();
		var prfPIncidental = $("#prfPIncidental").val();
		var prfPCauseIssue = $("#prfPCauseIssue").val();
		
		if(prfPCerti == ''){
			alert('증명서 종류를 선택해 주세요.');
			$("#prfPCerti").focus();
			return false;
		}else if($("#datepicker02").val() == "" && prfPCerti == "1"){
			alert("재직자는 퇴직증명서를 발급할 수 없습니다.");
			return false; 
		}else{
			$.ajax({
				url: "<c:url value='/qxsepmny/admstr/admAjaxProfSubSave4.do'/>",
				type : "post",
				data : "prfPCerti="+prfPCerti+"&prfPIncidental="+prfPIncidental+"&prfPCauseIssue="+prfPCauseIssue+"&memberCode="+memberCode+"&prfPSeq="+prfPSeq,
				dataType : "json"
				,success: function(data){
					var resultList = data.resultList;
					var html = "";
					html += '<tr>';
					html += '	<th>No.</th>';
					html += '	<th>발급번호</th>';
					html += '	<th>증명서</th>';
					html += '	<th>발급사유</th>';
					html += '	<th>발급일시</th>';
					html += '	<th>부수</th>';
					html += '	<th>발행</th>';
					html += '</tr>';
					for(var i=0; i<resultList.length; i++){
						html += '<tr>';
						html += '	<td>'+(resultList.length - i)+'</td>';
						html += '<input type="hidden" id="prfPSeq'+resultList[i].prfPSeq+'" name="prfPSeq" value="'+resultList[i].prfPSeq+'"/>';
						html += '	<td><a href="#" class="underline" type="P" value="'+resultList[i].prfPSeq+'">'+resultList[i].prfPIssueNum+'</a></td>';
						html += '	<td><a href="#" class="underline" type="P" value="'+resultList[i].prfPSeq+'">'+resultList[i].prfPCerti+'</a></td>';
						html += '	<td>'+resultList[i].prfPCauseIssue+'</td>';
						html += '	<td>'+resultList[i].prfPDateIssue+'</td>';
						html += '	<td>'+resultList[i].prfPIncidental+'</td>';
						html += '	<td><a href="#" value="'+resultList[i].prfPSeq+'" id="print" class="underline">인쇄</a></td>';
						html += '</tr>';
					}
					if(resultList.length == 0){
						html += '<tr>';
						html += '	<td colspan="9">등록된 내용이 없습니다.</td>';
						html += '</tr>';
					}
					$("#subTab").html(html);
					
					var cnt = '<strong>'+resultList.length+'</strong>건이 검색되었습니다.';
					$(".search-count").html(cnt);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});	
		}
		$("#subAdd4").css("display", "none" );
		fn_clear()
	}
}
//취소버튼 클릭시 추가탭 숨김
function fn_cnacel(i){
	$("#subAdd"+i).css("display", "none" );
	fn_clear()
}
//퇴직증명서 인쇄
function fn_printPrf(memberCode, seq){
	var prtType = 'RETIR';
	window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/prfPrtPop.do?'/>prtType="+prtType+"&memberCode="+memberCode+"&seq="+seq
		, '퇴직증명서 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
}
</script>
	<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strdate = simpleDate.format(date);
	%>
<!-- =============================================================하단탭============================================================= -->
			<div class="tab-box">
				<input id="tab1" type="radio" name="tabs" value="" >
				<input id="tab2" type="radio" name="tabs" value="2" >
				<input id="tab3" type="radio" name="tabs" value="3" >
				<input id="tab4" type="radio" name="tabs" value="4" >
		
				<div class="tab-btn">
					<label for="tab1" class="tab1" onclick="fn_tab(''); return false;">임용이력</label>
					<label for="tab2" class="tab2" onclick="fn_tab('2'); return false;">강의이력</label>
					<label for="tab3" class="tab3" onclick="fn_tab('3'); return false;">인사발령</label>
					<label for="tab4" class="tab4" onclick="fn_tab('4'); return false;">증명서발급</label>
				</div>
				
	
				<div id="content">
					<!--search info-->
					<div class="search-infomation">
						<div class="search-count">
						</div>
					</div>
					<!--// search info-->
		
					<!-- table -->
					<div class="list-table-box">
						<table class="normal-list-table">
							<colgroup>
								<col style="width:5%;" />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
							</colgroup>
							<tbody id="subTab">
							</tbody>
						</table>
					</div>
					<!--// table -->
	
					<!-- table button -->
					<div class="table-button">
						<div class="btn-box">
							<button type="button" onclick="fn_add(''); return false;" class="white btn-type05">추가</button>
						</div>
					</div>
						<!--// table button -->
		<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
					<div id="subAdd1">
						<div class="list-table-box">
							<table class="normal-list-table">
								<colgroup>
									<col style="width:15%;" />
									<col />
									<col style="width:15%;" />
									<col />
								</colgroup>
								<tr>
									<th><sup>*</sup>년도/학기</th>
									<td colspan="3" style="text-align: left; margin-left: 5px;">
										<select id="prfFYear" onchange="fn_search_semester(this,'F');">
											<option value="">전체</option>
											<c:forEach items="${yearList }" var="year">
												<option value="${year }"><c:out value="${year }"/></option>
											</c:forEach>
										</select>
										<select id="prfFSem" onchange="fn_search_enter_date(this,'F')">
											<option value="">전체</option>
											<c:forEach items="${semeList }" var="seme">
												<option value="${seme.semester }"><c:out value="${seme.semeNm }"/></option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>시작일자</th>
									<td style="text-align: left; margin-left: 5px;"><input type="text" id="datepicker03" name="prfFSDate" placeholder="<%= strdate%>" value="<c:out value="${prfSub1VO.prfFSDate }" />"></td>
									<th>종료일자</th>
									<td style="text-align: left; margin-left: 5px;"><input type="text" id="datepicker04" name="prfFEDate" placeholder="<%= strdate%>" value="<c:out value="${PrfSub1VO.prfFEDate }" />"></td>
								</tr>
								<tr>
									<th><sup>*</sup>시수</th>
									<td style="text-align: left; margin-left: 5px;"><input type="text" id="prfFHour" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="<c:out value="${PrfSub1VO.prfFEDate }" />"/>&nbsp;시간</td>
									<th><sup>*</sup>등급</th>
									<td style="text-align: left; margin-left: 5px;">
										<select id="prfFGrade">
											<option value="">선택</option>
											<option value="A" <c:if test="${PrfSub1VO.prfFGrade eq 'A' }"> selected = "selected"</c:if>>A</option>
											<option value="B" <c:if test="${PrfSub1VO.prfFGrade eq 'B' }"> selected = "selected"</c:if>>B</option>
											<option value="C" <c:if test="${PrfSub1VO.prfFGrade eq 'C' }"> selected = "selected"</c:if>>C</option>
											<option value="D" <c:if test="${PrfSub1VO.prfFGrade eq 'D' }"> selected = "selected"</c:if>>D</option>
											<option value="E" <c:if test="${PrfSub1VO.prfFGrade eq 'E' }"> selected = "selected"</c:if>>E</option>
										</select>
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>강사구분</th>
									<td colspan="3" style="text-align: left; margin-left: 5px;">
										<select id="prfFGubun">
											<option value="">선택</option>
											<option value="1" <c:if test="${PrfSub1VO.prfFGubun eq '1' }"> selected = "selected"</c:if>>정강사</option>
											<option value="2" <c:if test="${PrfSub1VO.prfFGubun eq '2' }"> selected = "selected"</c:if>>임시강사</option>
										</select>
									</td>
								</tr>
							</table>
							<!-- table button -->
							<div class="table-button">
								<div class="btn-box">
									<button type="button" onclick="fn_cnacel(1); return false;" class="white btn-type05">취소</button>
									<button type="button" class="white btn-save" onclick="fn_save(1); return false;">저장</button>
								</div>
							</div>
						</div>
					</div>
		<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
					<div id="subAdd2">
						<div class="list-table-box">
							<table class="normal-list-table">
								<colgroup>
									<col style="width:15%;" />
									<col />
									<col style="width:15%;" />
									<col />
								</colgroup>
								<tr>
									<th><sup>*</sup>년도/학기</th>
									<td style="text-align: left; margin-left: 5px;">
										<select id="prfSYear" onchange="fn_search_semester(this,'S');">
											<option value="">전체</option>
											<c:forEach items="${yearList }" var="year">
												<option value="${year }"><c:out value="${year }"/></option>
											</c:forEach>
										</select>
										<select id="prfSSem" onchange="fn_search_lectName(this,'S');">
											<option value="">전체</option>
											<c:forEach items="${semeList }" var="seme">
												<option value="${seme.semester }"><c:out value="${seme.semeNm }"/></option>
											</c:forEach>
										</select>
									</td>
									<th><sup>*</sup>급/분반</th>
									<td style="text-align: left; margin-left: 5px;">
										<select id="prfSStep" onchange="fn_search_divi(this);">
											<option value="">전체</option>
											<c:forEach items="${lectNameList }" var="lectName">
												<option value="${lectName.lectName }"><c:out value="${lectName.lectName }"/></option>
											</c:forEach>
										</select>
										<select id="prfSDivi">
											<option value="">전체</option>
											<c:forEach items="${lectDiviList }" var="divi">
												<option value="${divi.lectDivi }"><c:out value="${divi.lectDivi }"/></option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>시작일자</th>
									<td style="text-align: left; margin-left: 5px;"><input type="text" id="datepicker05" name="prfSSDate" placeholder="<%= strdate%>" value="<c:out value="${PrfSub2VO.prfSSDate }" />"></td>
									<th><sup>*</sup>종료일자</th>
									<td style="text-align: left; margin-left: 5px;"><input type="text" id="datepicker06" name="prfSEDate" placeholder="<%= strdate%>" value="<c:out value="${PrfSub2VO.prfSEDate }" />"></td>
								</tr>
								<tr>
									<th><sup>*</sup>직책</th>
									<td colspan="3" style="text-align: left; margin-left: 5px;">
										<select id="prfSPosition">
											<option value="">선택</option>
											<option value="1">담임</option>
											<option value="2">부담임</option>
										</select>
									</td>
								</tr>
							</table>
							<!-- table button -->
							<div class="table-button">
								<div class="btn-box">
									<button type="button" onclick="fn_cnacel(2); return false;" class="white btn-type05">취소</button>
									<button type="button" class="white btn-save" onclick="fn_save(2); return false;">저장</button>
								</div>
							</div>
						</div>
					</div> 
		<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
					<div id="subAdd3">
						<div class="list-table-box">
							<table class="normal-list-table">
								<colgroup>
									<col style="width:15%;" />
									<col style="width:35%;" />
									<col style="width:15%;" />
									<col style="width:35%;" />
								</colgroup>
								<tr>
									<th><sup>*</sup>년도/학기</th>
									<td style="text-align: left; margin-left: 5px;" colspan="3">
										<select id="prfTYear" onchange="fn_search_semester(this,'T');">
											<option value="">전체</option>
											<c:forEach items="${yearList }" var="year">
												<option value="${year }"><c:out value="${year }"/></option>
											</c:forEach>
										</select>
										<select id="prfTSem" >
											<option value="">전체</option>
											<c:forEach items="${semeList }" var="seme">
												<option value="${seme.semester }"><c:out value="${seme.semeNm }"/></option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>발령일자</th>
									<td style="text-align: left; margin-left: 5px;" colspan="3">
										<input type="text" id="datepicker07" name="prfTAnnoDate" placeholder="<%= strdate%>" value="<c:out value="${PrfSub3VO.prfTAnnoDate }" />">
									</td>
								</tr>
								<tr>
									<th><sup>*</sup>소속</th>
									<td style="text-align: left; margin-left: 5px;">
										<input type="text" id="prfTBelong" />
									</td>
									<th><sup>*</sup>직함</th>
									<td style="text-align: left; margin-left: 5px;">
										<select id="prfTPosition">
											<option value="">선택</option>
											<option value="1">강사실장</option>
											<option value="2">선임강사</option>
											<option value="3">강사</option>
										</select>
									</td>
								</tr>
							</table>
							<!-- table button -->
							<div class="table-button">
								<div class="btn-box">
									<button type="button" onclick="fn_cnacel(3); return false;" class="white btn-type05">취소</button>
									<button type="button" class="white btn-save" onclick="fn_save(3); return false;">저장</button>
								</div>
							</div>
						</div>
					</div> 
		<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
					<div id="subAdd4">
						<div class="list-table-box">
							<table class="normal-list-table">
								<colgroup>
									<col style="width:15%;" />
									<col />
								</colgroup>
								<tr>
									<th><sup>*</sup>증명서</th>
									<td style="text-align: left; margin-left: 5px;" colspan="3">
										<select id="prfPCerti">
											<option value="">선택</option>
											<option value="1">퇴직증명서</option>
										</select>
										<select id="prfPIncidental">
											<option value="">선택</option> 
											<c:forEach begin="1" end="10" var="idt">
												<option value="${idt}">${idt}</option> 
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th>발급사유</th>
									<td colspan="3" style="text-align: left; margin-left: 5px;">
										<input type="text" id="prfPCauseIssue" />
									</td>
								</tr>
							</table>
							<!-- table button -->
							<div class="table-button">
								<div class="btn-box">
									<button type="button" onclick="fn_cnacel(4); return false;" class="white btn-type05">취소</button>
									<button type="button" class="white btn-save" onclick="fn_save(4); return false;">저장</button>
								</div>
							</div>
						</div>
					</div> 
				</div>
			</div>
			<!-- =============================================================//하단탭============================================================= -->
</html>