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
	function closeLayer( obj ) {
		$(obj).parent().parent().hide();
	}

	$(function(){
		
		$('#checkDup').val("N");

		// 대상부위를 설정한다
		var ynVal = '<c:out value="${rs1010mVO.rsPos}"/>';
		const arrRsPos = ynVal.split(",");
		
		for(var i=0; i<arrRsPos.length; i++){
			var setval = arrRsPos[i];
			$("#rsPos"+setval).attr('checked', 'checked');
		}
		
		//수정인 경우 RS_CD 생성하는 컬럼을 사용하지 못하게 처리해야 함
		//수정인 경우 심의정보가 있는 경우 수정하지 못하게 처리한다. 
		var yndataRegnt = '<c:out value="${rs1010mVO.dataRegnt}"/>';
		if(!yndataRegnt=='') {
			
			$('#checkDup').val("Y");
			$('#rsNo').attr('disabled', 'true');
			$('#rsNo1').attr('disabled', 'true');
			$('#rsNo2').attr('disabled', 'true');
			$('#rsNo3').attr('disabled', 'true');
			$('#rsNo4').attr('disabled', 'true');
			$('#rsNo5').attr('disabled', 'true');
			$('#rsNo6').attr('disabled', 'true');
			$('#rsNo7').attr('disabled', 'true');
			$('#rsCd').attr('disabled', 'true');
			$('#btnSetrsCd').hide();
			$('#btnDupchk').hide();
			
			/* var ynirbsmYn = '<c:out value="${rs1010mVO.irbsmYn}"/>';
			if(ynirbsmYn == "Y") {
				var ynrvNo2 = '<c:out value="${rs5000mVO.rvNo2}"/>';
				if(!ynrvNo2 =='') {
					$('#irbsmYn1').attr('disabled', 'true');
					$('#irbsmYn2').attr('disabled', 'true');
					$('#rvNo1').attr('disabled', 'true');
					$('#rvNo2').attr('disabled', 'true');
					$('#rvNo3').attr('disabled', 'true');
					$('#rvNo4').attr('disabled', 'true');
					$('#rvNo5').attr('disabled', 'true');
					$('#rvCls1').attr('disabled', 'true');
					$('#rvCls2').attr('disabled', 'true');
					$('#rvRs1').attr('disabled', 'true');
					$('#rvRs2').attr('disabled', 'true');
					$('#rvSt1').attr('disabled', 'true');
					$('#rvSt2').attr('disabled', 'true');
					$('#datepicker02').attr('disabled', 'true');
				}else {
					$('#rvNo1').attr('disabled', 'true');
					$('#rvNo2').attr('disabled', 'true');
					$('#rvNo3').attr('disabled', 'true');
					$('#rvNo4').attr('disabled', 'true');
					$('#rvNo5').attr('disabled', 'true');
					$('#rvCls1').attr('disabled', 'true');
					$('#rvCls2').attr('disabled', 'true');
					$('#rvRs1').attr('disabled', 'true');
					$('#rvRs2').attr('disabled', 'true');
					$('#rvSt1').attr('disabled', 'true');
					$('#rvSt2').attr('disabled', 'true');
					$('#datepicker02').attr('disabled', 'true');
				}
			}else {
				$('#rvNo1').attr('disabled', 'true');
				$('#rvNo2').attr('disabled', 'true');
				$('#rvNo3').attr('disabled', 'true');
				$('#rvNo4').attr('disabled', 'true');
				$('#rvNo5').attr('disabled', 'true');
				$('#rvCls1').attr('disabled', 'true');
				$('#rvCls2').attr('disabled', 'true');
				$('#rvRs1').attr('disabled', 'true');
				$('#rvRs2').attr('disabled', 'true');
				$('#rvSt1').attr('disabled', 'true');
				$('#rvSt2').attr('disabled', 'true');
				$('#datepicker02').attr('disabled', 'true');
			} */
		} else {
			$('#rsNo').attr('disabled', 'true');
			$('#rsNo1').attr('disabled', 'true');
		}
			

		//IRB승인여부
		var ynirbsmYn = '<c:out value="${rs1010mVO.irbsmYn}"/>';
		switch(ynirbsmYn) {
		case "Y" :  
			$("#irbsmYn1").attr('checked', 'checked');
			break;
		case "N" :  
			$("#irbsmYn2").attr('checked', 'checked');
			break;
		default :
			$("#irbsmYn1").attr('checked', 'checked');	
		}
		
		//중북참여여부
		var ynduplYn = '<c:out value="${rs1010mVO.duplYn}"/>';
		if(ynduplYn == 'Y'){
			$("#duplYn1").attr('checked', 'checked');
		}else{
			$("#duplYn2").attr('checked', 'checked');
		}
		
		//모집나이초기화
		var ynage = '<c:out value="${rs1010mVO.ageSt}"/>';
		if(ynage == '') {$("#ageSt").val("0");}
		var ynduplYn = '<c:out value="${rs1010mVO.ageEn}"/>';
		if(ynage == '') {$("#ageEn").val("99");}
		
		//모집성별 
		var yngenYn = '<c:out value="${rs1010mVO.genYn}"/>';
		switch(yngenYn) {
		case "1" :  
			$("#genYn1").attr('checked', 'checked');
			break;
		case "2" :  
			$("#genYn2").attr('checked', 'checked');
			break;
		case "0" :  
			$("#genYn3").attr('checked', 'checked');
			break;
		default :
			$("#genYn2").attr('checked', 'checked');	
		}	
		
		//연구상태 - 공통코드인데 radio로 처리됨 
		var ynrsstCls = '<c:out value="${rs1010mVO.rsstCls}"/>';
		
		switch(ynrsstCls) {
		case "10" :  
			$("#rsstCls1").attr('checked', 'checked');
			break;
		case "20" :  
			$("#rsstCls2").attr('checked', 'checked');
			break;
		case "30" :  
			$("#rsstCls3").attr('checked', 'checked');
			break;
		case "40" :  
			$("#rsstCls4").attr('checked', 'checked');
			break;	
		default :
			$("#rsstCls1").attr('checked', 'checked');	
		}
		
		//if(ynuseYn == 'Y'){
			//$("#useY").attr('checked', 'checked');
		//}else{
			//$("#useN").attr('checked', 'checked');
		//}
		
		//$("#searchWord").keydown(function(e){
			//if(e.keyCode == 13){
				//fn_search('RERE');
			//}
		//});
		$("#modi-pop").change(function(){
			html = '<tr>';
			html += '	<td colspan="5">이름을 검색해주세요.</td>';
			html += '</tr>';
			$("#stdBody").html(html);
		});
		
		$("#modi-pop11").change(function(){
			html = '<tr>';
			html += '	<td colspan="5">이름을 검색해주세요.</td>';
			html += '</tr>';
			$("#stdBody11").html(html);
		});
		
		$("#modi-pop2").change(function(){
			html = '<tr>';
			html += '	<td colspan="5">고객사명을 검색해주세요.</td>';
			html += '</tr>';
			$("#stdBody2").html(html);
		});
		
		//부가세 자동산출 
		$("#rsPay").change(function(){
			
			if (isNaN($("#rsPay").val())) {
				$("#rsPayvt").val(0);
			} else {
			
				var vat = parseInt($("#rsPay").val()*0.1)
				$("#rsPayvt").val(vat);	
				
			}
		});
		
		//연구명을 초기설정한다
		var ynrsname = '<c:out value="${rs1010mVO.rsName}"/>';
		if(ynrsname == '') {
			var setRsName = "OOO에 대한 인체피부 일차자극 평가시험";
			$("#rsName").val(setRsName);
		}

		//IRB심의 정보 설정
		var ynVal = '<c:out value="${rs5000mVO.rvCls}"/>';
		switch (ynVal) {
			case '1':
				$("#rvCls1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rvCls2").attr('checked', 'checked');
		    	break;
		  	default:
		     	console.log('Sorry, we are out of service');
		}
		
		var ynVal = '<c:out value="${rs5000mVO.rvSt}"/>';
		switch (ynVal) {
			case '1':
				$("#rvSt1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rvSt2").attr('checked', 'checked');
		    	break;				
		  	default:
		     	console.log('Sorry, we are out of service');
		}
		
		var ynVal = '<c:out value="${rs5000mVO.rvRs}"/>';
		switch (ynVal) {
			case '1':
				$("#rvRs1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rvRs2").attr('checked', 'checked');
		    	break;				
		  	default:
		     	console.log('Sorry, we are out of service');
		}
		
		//IRB심의가 등록되여 있는 경우 심의번호 수정 불가처리
		var ynrvno = '<c:out value="${rs5000mVO.rvNo}"/>';
		if(!ynrvno=='') {
			$('#rvNo1').attr('disabled', 'true');
			$('#rvNo2').attr('disabled', 'true');
			$('#rvNo3').attr('disabled', 'true');
			$('#rvNo4').attr('disabled', 'true');
			$('#rvNo5').attr('disabled', 'true');
		}else{ //IRB심의가 등록되지 않은 경우 삭제버튼 숨김 처리 
			$('#btnDelIrb').hide();
		}
		
	});	

	// 	연구코드 중복체크
	function fn_check(){
		var rsCd = $("#rsCd").val();
		
		if(rsCd == ''){
			alert('먼저 연구코드를  생성해 주세요');
			return;
		}
		$.ajax({
			url: "<c:url value='/qxsepmny/ech0105/ech0105AjaxRsCdCheck.do'/>"
			, type: "post"
			, data: "rsCd="+rsCd
			, dataType:"json"
			, success: function(data){
				var status = data.status;
				var message = data.message;
				
				if(!status){
					$("#rsCd").val('');
				}else{
					$("#rsCd").val(rsCd);
				}
				$('#checkDup').val("Y");
				alert(message);
			}, error: function(){
				$('#checkDup').val("N");
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	var resultList;
	
	function fn_search(){
		$.ajax({
			url: "<c:url value='/qxsepmny/ech1005/ech1005AjaxSearchStaff.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '	<td>'+resultList[i].empNo+'</td>';
					html += '	<td>'+resultList[i].empName+'</td>';
					html += '	<td>'+resultList[i].orgNm+'</td>';
					html += '	<td>'+resultList[i].branchNm+'</td>';
					html += '	<td>'+resultList[i].rsClsNm+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="5">검색된 내용이 없습니다.</td>';
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
		
		//팝업에서 선택한 값을 설정한다.
		$("#rsDrt").val(result.empNo);
		$("#rsDrtNm").val(result.empName);
		//$("#nameTd").html(result.name);
		//$("#orgNmTd").html(result.orgNm);
		//$("#bracnNmTd").html(result.branchNm);
		//$("#rsClsNmTd").html(result.rsClsNm);		
		
		$("#modi-pop").click();
		
		resultList = null;
	}
	
	function fn_search11(){
		$.ajax({
			url: "<c:url value='/qxsepmny/ech1005/ech1005AjaxSearchStaff.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord11").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select11('+i+'); return false;">';
					html += '	<td>'+resultList[i].empNo+'</td>';
					html += '	<td>'+resultList[i].empName+'</td>';
					html += '	<td>'+resultList[i].orgNm+'</td>';
					html += '	<td>'+resultList[i].branchNm+'</td>';
					html += '	<td>'+resultList[i].rsClsNm+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="5">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody11").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}

	function fn_select11(i){
		var result = resultList[i];
		
		//팝업에서 선택한 값을 설정한다.
		$("#rsGrt").val(result.empNo);
		$("#rsGrtNm").val(result.empName);
		//$("#nameTd").html(result.name);
		//$("#orgNmTd").html(result.orgNm);
		//$("#bracnNmTd").html(result.branchNm);
		//$("#rsClsNmTd").html(result.rsClsNm);		
		
		$("#modi-pop11").click();
		
		resultList = null;
	}
	
	
	function fn_search2(){
		$.ajax({
			url: "<c:url value='/qxsepmny/ech1005/ech1005AjaxSearchVendor.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord2").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select2('+i+'); return false;">';
					html += '	<td>'+resultList[i].vendNo+'</td>';
					html += '	<td>'+resultList[i].vendName+'</td>';
					html += '	<td>'+resultList[i].excutName+'</td>';
					html += '	<td>'+resultList[i].bregRsno+'</td>';
					html += '	<td>'+resultList[i].telno+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="5">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody2").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}

	function fn_select2(i){
		var result = resultList[i];
		
		//팝업에서 선택한 값을 설정한다.
		$("#vendNo").val(result.vendNo);
		$("#vendName").val(result.vendName);
		//업무담당자,연락처,이메일을 설정한다.
		$("#vmngName").val(result.mngName);
		$("#vmnghpNo").val(result.mnghpNo);
		$("#vmngEmail").val(result.mngEmail);
		
		//$("#nameTd").html(result.name);
		//$("#orgNmTd").html(result.orgNm);
		//$("#bracnNmTd").html(result.branchNm);
		//$("#rsClsNmTd").html(result.rsClsNm);		
		
		$("#modi-pop2").click();
		
		resultList = null;
	}

	
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech10105/ech100501.do'/>"
					, '관리자 조회', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0105/ech0105List.do'/>";
	}	
	
	//function fn_update(){
		//if(fn_validate("detailForm")){
		 	//$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0105/ech0105Update.do'/>").submit();
		//}
	//}
	

	
	function fn_setrsCd(){
		var chkVal = $('#rsNo1').val();
		if(chkVal==''){
			alert('연구과제고유번호을 입력해주세요.')
			$('#rsNo1').focus();
			return;
		}
		var chkVal = $('#rsNo2').val();
		if(chkVal==''){
			alert('임상종류를 입력해주세요')
			$('#rsNo2').focus();
			return;
		}
		var chkVal = $('#rsNo3').val();
		if(chkVal==''){
			alert('임상분류를 입력해주세요')
			$('#rsNo3').focus();
			return;
		}
		var chkVal = $('#rsNo4').val();
		if(chkVal==''){
			alert('프로토콜을  입력해주세요')
			$('#rsNo4').focus();
			return;
		}
		var chkVal = $('#rsNo5').val();
		if(chkVal==''){
			alert('연구년도를 입력해주세요')
			$('#rsNo5').focus();
			return;
		}
		var chkVal = $('#rsNo6').val();
		if(chkVal==''){
			alert('임상번호를  입력해주세요')
			$('#rsNo6').focus();
			return;
		}
		/* var chkVal = $('#rsNo7').val();
		if(chkVal==''){
			alert('임상번호를 입력해주세요')
			$('#rsNo7').focus();
			return;
		} */
		
		//연구코드 생성 
		$('#rsCd').val($('#rsNo1').val()+$('#rsNo2').val()+'-'+$('#rsNo3').val()+$('#rsNo4').val()+'-'+$('#rsNo5').val()+$('#rsNo6').val());
	}	
	
	function fn_update(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var yncheckDup = $('#checkDup').val();
		if(yncheckDup == 'N') {
			alert('중복여부를 확인해주세요.')
			$('#btnDupchk').focus();
			return;
		}	
		
		var rsCd = $('#rsCd').val();
		if(rsCd==''){
			alert('연구코드를 생성해주세요.')
			$('#rsCd').focus();
			return;
		}
		
		var rsDrt = $('#rsDrt').val();
		if(rsDrt==''){
			alert('연구책임자를 입력해주세요.')
			$('#rsDrt').focus();
			return;
		}
		
		var regDt = $('#datepicker01').val();			
		if(regDt==''){
			alert('등록일을 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
		
		var rsDrt = $('#rsDrt').val();
		if(rsDrt==''){
			alert('연구책임자를 입력해주세요.')
			$('#rsDrt').focus();
			return;
		}
		
		var rsMscnt = $('#rsMscnt').val();
		if(rsMscnt==''){
			alert('최대지원자수를 입력해주세요.')
			$('#rsMscnt').focus();
			return;
		}
		
		var rsGrt = $('#rsGrt').val();
		if(rsGrt==''){
			alert('신뢰성보증업무담당자를 입력해주세요.')
			$('#rsGrt').focus();
			return;
		}
		
		var rsName = $('#rsName').val();
		if(rsName==''){
			alert('연구명을 입력해주세요.')
			$('#rsName').focus();
			return;
		}
		
		/* var regDt = $('#datepicker02').val();
		if(regDt==''){
			alert('연구시작일을 입력해주세요.')
			$('#datepicker02').focus();
			return;
		}
		
		var regDt = $('#datepicker03').val();
		if(regDt==''){
			alert('연구종료일을 입력해주세요.')
			$('#datepicker03').focus();
			return;
		}
		
		var regDt = $('#datepicker05').val();
		if(regDt==''){
			alert('전체연구기간의 시작일을 입력해주세요.')
			$('#datepicker05').focus();
			return;
		}
		var regDt = $('#datepicker06').val();
		if(regDt==''){
			alert('전체연구기간의 종료일을 입력해주세요.')
			$('#datepicker06').focus();
			return;
		} */
		
			
		//alert($("input[name=data_lock]:checked").serialize())
		
		//alert($("input[name=rsPos]:checked").serialize())
						
		//$("#emailAdr").removeAttr('disabled');
		$('#rsNo').removeAttr('disabled');
		$('#rsNo1').removeAttr('disabled');
		$('#rsNo2').removeAttr('disabled');
		$('#rsNo3').removeAttr('disabled');
		$('#rsNo4').removeAttr('disabled');
		$('#rsNo5').removeAttr('disabled');
		$('#rsNo6').removeAttr('disabled');
		$('#rsNo7').removeAttr('disabled');
		$('#rsCd').removeAttr('disabled');
		
		$('#irbsmYn1').removeAttr('disabled');
		$('#irbsmYn2').removeAttr('disabled');
		
		//alert($('#rvNo2').val());
		//alert($('#rvNo3').val());
				
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0105/ech0105Update.do'/>").submit();
	}
	
	// IRB심의정보 삭제 연구번호+IRB심의번호 
	function fn_delIrb(){
		if(confirm('IRB심의정보를 삭제합니다. 삭제된 정보는 복구할 수 없으며 연구관리는 IRB승인 불필요로 설정됩니다.\r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var rvNo1 = $("#rvNo1").val();
			var rvNo2 = $("#rvNo2").val();
			var rvNo3 = $("#rvNo3").val();
			var rvNo4 = $("#rvNo4").val();
			var rvNo5 = $("#rvNo5").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0105/ech0105AjaxDelIrb.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"rvNo1="+rvNo1+"&"+"rvNo2="+rvNo2+"&"+"rvNo3="+rvNo3+"&"+"rvNo4="+rvNo4+"&"+"rvNo5="+rvNo5
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	
	}
	
	function zeroFill(target, width) {
		  var n = target.value;
		  var id = target.id;
			n = n + "";
		  if(n.length >= width){
			document.getElementById(id).value = n;
		  }else{
			document.getElementById(id).value = new Array(width - n.length + 1).join('0') + n;
		  }
	}
			
	
	
	$(document).ready(function () {
		//IRB 심의 번호 필요/불필요 선택시 DISABLED 처리
		$('input[name=irbsmYn]').change(function(){
			//해당 ID값의 INPUT 태그 개수 넣기
			//irbsmYn2 체크 여부
			var cnt = $('#irbNo input').length;
		
			if($("#irbsmYn2").is(":checked") ==true){ // if 시작
			//불필요
				for(var i=2; i<=cnt; i++){

					document.getElementById('rvNo'+i+'').disabled = true;
					document.getElementById('rvNo'+i+'').value ='';

				}
			}else{
			//필요
				for(var i=2; i<=cnt; i++){

					document.getElementById('rvNo'+i+'').disabled = false;

				}
			}
		});
		for(var i =1 ; i<12; i++){
			/* $('.date_sec').click(function(){ */
				
					//픽커만 사용할수있게 input box 입력방지
					/* $('input[name=regDt]').datepicker('disable').removeAttr('disabled'); */
					//$('input[name=regDt]').attr("readonly",true);
		 	$('#datepicker0'+i+'').attr("readonly",true);
			if(i >= 10){
			 $('#datepicker'+i+'').attr("readonly",true);
			} 
		

			//})
		}
			

			
		$('#ageSt').change(function() {
			
			if($('#ageSt').val() > $('#ageEn').val()){
				$('#ageSt').val('');
				alert("데이터가 잘못 입력되었습니다.");
			}
		})
		$('#ageEn').change(function() {
			
			if($('#ageSt').val() > $('#ageEn').val()){
				$('#ageEn').val('');
				alert("데이터가 잘못 입력되었습니다.");
			}
		})
		
	})
	
	// Byte 수 체크 제한
	function fnChkByte(obj, maxByte, rType)
	{
	    var str = obj.value;
	    var str_len = str.length;
	
	
	    var rbyte = 0;
	    var rlen = 0;
	    var one_char = "";
	    var str2 = "";
	
	
	    for(var i=0; i<str_len; i++)
	    {
	        one_char = str.charAt(i);
	        if(escape(one_char).length > 4) {
	            rbyte += 2;                                         //한글2Byte
	        }else{
	            rbyte++;                                            //영문 등 나머지 1Byte
	        }
	        if(rbyte <= maxByte){
	            rlen = i+1;                                          //return할 문자열 갯수
	        }
	     }
	     if(rbyte > maxByte)
	     {
	        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	        alert("명칭은 최대 " + maxByte + "byte를 초과할 수 없습니다.")
	        str2 = str.substr(0,rlen);                                  //문자열 자르기
	        obj.value = str2;
	        fnChkByte(obj, maxByte);
	     }
	     else
	     {
	        if(rType == '1'){
	        	document.getElementById('byteInfo1').innerText = rbyte;	
	        }else if(rType == '2'){
	        	document.getElementById('byteInfo2').innerText = rbyte;	
	        }else if(rType == '3'){
	        	document.getElementById('byteInfo3').innerText = rbyte;	
	        }  
	    	 
	     }
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>연구관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="연구관리"/>
	            <jsp:param name="dept2" value="연구관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>연구정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <form:form commandName="rs1010mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${rs1010mVO.corpCd}">
				<input type="hidden" id="checkDup" name="checkDup">
            <!-- 연구정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">연구과제고유번호(변경불가)</th>
                        <td>
                        	<input type="text" value="<c:out value="${rs1010mVO.rsNo1 }" />"  class="p40" id="rsNo1" name="rsNo1"/>
                        </td>
                        <th scope="row" class="bl">연구번호(변경불가)</th>
                        <td >
                        	<input type="text" value="<c:out value="${rs1010mVO.rsNo }" />"  class="p40" id="rsNo" name="rsNo"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>임상종류</th>
                        <td>
                        	<!-- 임상종류 목록(공통코드) CM4000M - CT2020  E S I F A -->
							<select id="rsNo2" name="rsNo2" onchange="fn_search_rsProtocol(this); return false;">
								<option value="" <c:if test="${rs1010mVO.rsNo2 eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${ct2020}">
									<option value="${result.cd}"<c:if test="${result.cd eq rs1010mVO.rsNo2}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
                        </td>
                        <th scope="row" class="bl"><i>*</i>임상분류</th>
                        <td>
                            <!-- 임상분류 목록(공통코드) CM4000M - CT2030  M P G O -->
							<select id="rsNo3" name="rsNo3">
								<option value="" <c:if test="${rs1010mVO.rsNo3 eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${ct2030}">
									<option value="${result.cd}"<c:if test="${result.cd eq rs1010mVO.rsNo3}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>프로토콜</th>
                        <td>
	                        <!-- 프로코콜 목록(공통코드) CM4000M - CT2060  -->
							<select id="rsNo4" name="rsNo4">
								<option value="" <c:if test="${rs1010mVO.rsNo4 eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${ct2060}">
									<option value="${result.cd}"<c:if test="${result.cd eq rs1010mVO.rsNo4}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
                        </td>
                        <th scope="row" class="bl"><i>*</i>연구년도</th>
                        <td>
                            <select id="rsNo5" name="rsNo5" class="p30">
	                            <option value="" <c:if test="${rs1010mVO.rsNo5 eq '' }">selected="selected"</c:if> >선택</option>
	                            <option value="30" <c:if test="${rs1010mVO.rsNo5 eq '30' }">selected="selected"</c:if> >30</option>
	                            <option value="29" <c:if test="${rs1010mVO.rsNo5 eq '29' }">selected="selected"</c:if> >29</option>
	                            <option value="28" <c:if test="${rs1010mVO.rsNo5 eq '28' }">selected="selected"</c:if> >28</option>
	                            <option value="27" <c:if test="${rs1010mVO.rsNo5 eq '27' }">selected="selected"</c:if> >27</option>
	                            <option value="26" <c:if test="${rs1010mVO.rsNo5 eq '26' }">selected="selected"</c:if> >26</option>
	                            <option value="25" <c:if test="${rs1010mVO.rsNo5 eq '25' }">selected="selected"</c:if> >25</option>
	                            <option value="24" <c:if test="${rs1010mVO.rsNo5 eq '24' }">selected="selected"</c:if> >24</option>
	                            <option value="23" <c:if test="${rs1010mVO.rsNo5 eq '23' }">selected="selected"</c:if> >23</option>
	                            <option value="22" <c:if test="${rs1010mVO.rsNo5 eq '22' }">selected="selected"</c:if> >22</option>
	                            <option value="21" <c:if test="${rs1010mVO.rsNo5 eq '21' }">selected="selected"</c:if> >21</option>
	                            <option value="20" <c:if test="${rs1010mVO.rsNo5 eq '20' }">selected="selected"</c:if> >20</option>
	                            <option value="19" <c:if test="${rs1010mVO.rsNo5 eq '19' }">selected="selected"</c:if> >19</option>
	                            <option value="18" <c:if test="${rs1010mVO.rsNo5 eq '18' }">selected="selected"</c:if> >18</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>임상번호</th>
                        <td colspan="3">
                            <input type="text" value="<c:out value="${rs1010mVO.rsNo6 }" />" oninput="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"  class="p10" id="rsNo6" name="rsNo6" placeholder="000"/>
                        </td>
                        <%-- <th scope="row" class="bl"><i>*</i>임상번호</th>
                        <td>
                            <input type="text" value="<c:out value="${rs1010mVO.rsNo7 }" />"  class="p15" id="rsNo7" name="rsNo7"/>
                        </td> --%>
                    </tr>
                    <tr>
                        <th scope="row">연구코드</th>
                        <td colspan="3">
                        	<input type="text" value="<c:out value="${rs1010mVO.rsCd }" />" id="rsCd" name="rsCd" class="p30" readonly="readonly"/>
                        	<a href="#" onclick="fn_setrsCd(); return false;" class="btn_sub" id="btnSetrsCd">연구코드생성</a>
                        	<a href="#" onclick="fn_check(); return false;" class="btn_sub" id="btnDupchk">중복확인</a>
                        </td>
                    </tr>
                    <tr>
                    	<th scope="row"><i>*</i>등록일자</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <span>
                                    <input name="regDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.regDt }" />" class="date required" title="등록일" />
                                    <label for="datepicker01" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                    	<th scope="row"><i>*</i>연구책임자</th>
                        <td>
                           	<input type="text" value="<c:out value="${rs1010mVO.rsDrtNm }" />"  class="p30" readonly="readonly" id="rsDrtNm" name="rsDrtNm"/>
                           	<input type="hidden"  value="<c:out value="${rs1010mVO.rsDrt }" />"  class="p30" id="rsDrt" name="rsDrt"/>
                            <!--  <a href="#" onclick="fn_pop(); return false;" class="btn_sub">조회</a> -->
                            <label for="modi-pop" class="btn_sub">조회</label>
                        </td>
                       	<th scope="row" class="bl">피험자수</th>
                        <td>
                            <input type="text" value="<c:out value="${rs1010mVO.rsScnt eq '' ? 0 : rs1010mVO.rsScnt }" />"  oninput="this.value=this.value.replace(/[^0-9]/g,'');" readonly="readonly" maxlength="3" class="p15" id="rsScnt" name="rsScnt"/> 명&nbsp;&nbsp;&nbsp;
                                                      <span style="color:red;"><i>*</i></span> 최대지원자수&nbsp;&nbsp;
                            <input type="text" value="<c:out value="${rs1010mVO.rsMscnt }" />"  oninput="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3" class="p15" id="rsMscnt" name="rsMscnt"/> 명
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연구상태</th>
                        <td colspan="3">
                            <input type="radio" name="rsstCls" id="rsstCls1" value="10" />
                            <label for="rsstCls1">예정</label>
                            <input type="radio" name="rsstCls" id="rsstCls2" value="20" />
                            <label for="rsstCls2">진행</label>
                            <input type="radio" name="rsstCls" id="rsstCls3" value="30" />
                            <label for="rsstCls3">완료</label>
                            <input type="radio" name="rsstCls" id="rsstCls4" value="40" />
                            <label for="rsstCls4">취소</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">방문횟수</th>
                        <td>
                            <select id="visitCnt" name="visitCnt" class="p20">
	                            <option value="" <c:if test="${rs1010mVO.visitCnt eq '' }">selected="selected"</c:if> >선택</option>
	                            <option value="1" <c:if test="${rs1010mVO.visitCnt eq '1' }">selected="selected"</c:if> >1</option>
	                            <option value="2" <c:if test="${rs1010mVO.visitCnt eq '2' }">selected="selected"</c:if> >2</option>
	                            <option value="3" <c:if test="${rs1010mVO.visitCnt eq '3' }">selected="selected"</c:if> >3</option>
	                            <option value="4" <c:if test="${rs1010mVO.visitCnt eq '4' }">selected="selected"</c:if> >4</option>
	                            <option value="5" <c:if test="${rs1010mVO.visitCnt eq '5' }">selected="selected"</c:if> >5</option>
                            </select>회
                        </td>
                        <th scope="row" class="bl">중복참여여부</th>
                        <td>
                            <input type="radio" name="duplYn" id="duplYn1" value="Y"/>
                            <label for="duplYn1">중복참여 가능</label>
                            <input type="radio" name="duplYn" id="duplYn2" value="N"/>
                            <label for="duplYn2">중복참여 불가</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">모집성별</th>
                        <td>
                            <input type="radio" name="genYn" id="genYn1" value="1"/>
                            <label for="genYn1">남</label>
                            <input type="radio" name="genYn" id="genYn2" value="2"/>
                            <label for="genYn2">여</label>
                            <input type="radio" name="genYn" id="genYn3" value="0"/>
                            <label for="genYn3">제한없음</label>
                        </td>
                        <th scope="row" class="bl">모집나이</th>
                        <td>
                            <input type="text" value="<c:out value="${rs1010mVO.ageSt }" />"  oninput="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"  onblur="zeroFill(this, 2);" class="p15" id="ageSt" name="ageSt" placeholder="00"/>세
                            ~
                            <input type="text" value="<c:out value="${rs1010mVO.ageEn }" />"  oninput="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"  onblur="zeroFill(this, 2);" class="p15" id="ageEn" name="ageEn" placeholder="00"/>세 이하
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">대상부위</th>
                        <td>                            
                            <!-- <input type="checkbox" name="rsPos" id="rsPos1" value="1"/>
                            <label for="rsPos1">이마</label>
                            <input type="checkbox" name="rsPos" id="rsPos2" value="2"/>
                            <label for="rsPos2">눈</label>
                            <input type="checkbox" name="rsPos" id="rsPos3" value="3"/>
                            <label for="rsPos2">코</label>
                            <input type="checkbox" name="rsPos" id="rsPos4" value="4"/>
                            <label for="rsPos4">입</label>
                            <input type="checkbox" name="rsPos" id="rsPos5" value="5"/>
                            <label for="rsPos5">얼굴전체</label>
                            <input type="checkbox" name="rsPos" id="rsPos6" value="6"/>
                            <label for="rsPos6">등</label>
                            <input type="checkbox" name="rsPos" id="rsPos7" value="7"/>
                            <label for="rsPos7">피부전체</label> -->
                            
                            <input type="checkbox" name="rsPos" id="rsPos1" value="1"/>
                            <label for="rsPos1">안면</label>
                            <input type="checkbox" name="rsPos" id="rsPos2" value="2"/>
                            <label for="rsPos2">전박</label>
                            <input type="checkbox" name="rsPos" id="rsPos3" value="3"/>
                            <label for="rsPos2">등</label>
                            <input type="checkbox" name="rsPos" id="rsPos4" value="4"/>
                            <label for="rsPos4">기타</label>                            
                        </td>
                        <!-- 고객사요청으로 등록된 구성원에서 선택항목으로 변경 - 2021.3.22 -->
                        <th scope="row" class="bl"><i>*</i>신뢰성보증업무담당자</th>
                        <td>
                           	<input type="text" value="<c:out value="${rs1010mVO.rsGrtNm }" />" readonly="readonly" class="p30" id="rsGrtNm" name="rsGrtNm"/>
                           	<input type="hidden"  value="<c:out value="${rs1010mVO.rsGrt }" />"  class="p30" id="rsGrt" name="rsGrt"/>
                            <!--  <a href="#" onclick="fn_pop(); return false;" class="btn_sub">조회</a> -->
                            <label for="modi-pop11" class="btn_sub">조회</label>
                        </td>
                        <%-- <td>
                            <input type="text" value="<c:out value="${rs1010mVO.rsGrt }" />"  class="p60" id="rsGrt" name="rsGrt"/>
                        </td> --%>
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>연구명</th>                        
                        <td colspan="3">
                        	<span id="byteInfo1">0</span>/200bytes
							<%-- <textarea class="type02 type03" id="rsName" name="rsName" placeholder="OOO에 대한 인체피부 일차자극 평가시험"><c:out value="${rs1010mVO.rsName }" /></textarea> --%>
							<textarea class="type02 type03" id="rsName" name="rsName" onKeyUp="javascript:fnChkByte(this,'200','1')"><c:out value="${rs1010mVO.rsName }" /></textarea>
							
						</td>                        
                    </tr>
                    <tr>
                        <th scope="row">연구목적</th>
                        <td colspan="3">
                        	<span id="byteInfo2">0</span>/200bytes
							<textarea class="type02 type03" id="rsPps" name="rsPps" onKeyUp="javascript:fnChkByte(this,'200','2')"><c:out value="${rs1010mVO.rsPps }" /></textarea>
						</td>           
                    </tr>
                    <tr>
                        <th scope="row">연구방법</th>
                        <td colspan="3">
                        	<span id="byteInfo3">0</span>/2000bytes
							<textarea class="type02 type03" id="rsPtc" name="rsPtc" onKeyUp="javascript:fnChkByte(this,'2000','3')"><c:out value="${rs1010mVO.rsPtc }" /></textarea>
						</td>           
                    </tr>
                    <tr>
                    	<th scope="row">IRB승인</th>
                        <td colspan="3">
                            <input type="radio" name="irbsmYn" id="irbsmYn1" value="Y"/>
                            <label for="irbsmYn1">필요</label>
                            <input type="radio" name="irbsmYn" id="irbsmYn2" value="N"/>
                            <label for="irbsmYn2">불필요</label>
                        </td>
                    </tr>
                    <!-- IRB정보 --> 
                    <tr id="irbNo">
                        <th scope="row">IRB심의번호</th>
                        <td colspan="3">
                            <input type="text" class="p15" value="HBABN01" id="rvNo1" name="rvNo1" disabled="disabled" />
                            -
                            <input type="text" value="<c:out value="${rs5000mVO.rvNo2 }" />"  oninput="this.value=this.value.replace(/[^0-9]/g,'');" class="p15" id="rvNo2" name="rvNo2" placeholder="신청년월(210101)" maxlength="6"/>
                            -
                            <input type="text" value="<c:out value="${rs5000mVO.rvNo3 }" />"  oninput="this.value=this.value.replace(/[^a-zA-Z]*$/i,'');" class="p15" id="rvNo3" name="rvNo3" placeholder="심의종류(4)" maxlength="4"/>                             
                            -
                            <%-- <input type="text" value="<c:out value="${rs5000mVO.rvNo4 }" />"   oninput="this.value=this.value.replace(/[^0-9]/g,'');" class="p15" id="rvNo4" name="rvNo4" placeholder="일련번호(0000)" maxlength="4"/> --%>
                            <input type="text" value="<c:out value="${rs5000mVO.rvNo4 }" />"   oninput="this.value=this.value.replace(/[^a-zA-Z0-9]*$/i,'');" class="p15" id="rvNo4" name="rvNo4" placeholder="일련번호(6)" maxlength="6"/>
                            -
                            <input type="text" value="<c:out value="${rs5000mVO.rvNo5 }" />"  oninput="this.value=this.value.replace(/[^0-9]/g,'');" class="p15" id="rvNo5" name="rvNo5" placeholder="관리번호(2)" maxlength="2"/>
                            <a href="#" onclick="fn_delIrb(); return false;" class="btn_sub" id="btnDelIrb">삭제</a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">심의종류</th>
                        <td>
							<input type="radio" name="rvCls" id="rvCls1" value="1" />
							<label for="rvCls1">신속</label>
							<input type="radio" name="rvCls" id="rvCls2" value="2" />
							<label for="rvCls2">정규</label>
                        </td>
                        <th scope="row" class="bl">심의접수일</th>
                        <td>
							<div class="date_sec">
								<span>
									<input name="rvDt" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${rs5000mVO.rvDt }" />" class="date required" title="접수일자" />
									<label for="datepicker02" class="btn_cld">날짜검색</label>
								</span>
							</div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">심의상태</th>
                        <td>
							<input type="radio" name="rvSt" id="rvSt1" value="1"/>
							<label for="rvSt1">심의중</label>
							<input type="radio" name="rvSt" id="rvSt2" value="2"/>
							<label for="rvSt2">완료</label>
                        </td>
                        <th scope="row" class="bl">심의결과</th>
                        <td>
                            <input type="radio" name="rvRs" id="rvRs1" value="1"/>
							<label for="rvRs1">승인</label>
							<input type="radio" name="rvRs" id="rvRs2" value="2"/>
							<label for="rvRs2">보완</label>
                        </td>
                    </tr>
                    <!-- //IRB정보 -->
                </tbody>
            </table>
            <!-- //연구정보 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>임상시험일정(점검/보고)</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 임상시험일정 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">연구계획서</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="rsplDt" id="datepicker03" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.rsplDt }" />" class="date required" title="연구계획서" />
                                    <label for="datepicker03" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="bl">시험제품정보확인</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="rsitDt" id="datepicker04" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.rsitDt }" />" class="date required" title="시험제품정보확인" />
                                    <label for="datepicker04" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">IRB승인</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <span>
                                    <input name="rsirbDt" id="datepicker05" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.rsirbDt }" />" class="date required" title="IRB승인일" />
                                    <label for="datepicker05" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연구대상자 모집</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <span>
                            		<input name="rsrStdt" id="datepicker06" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.rsrStdt }" />" class="date required" title="시작일자" />
                            		<label for="datepicker06" class="btn_cld">날짜검색</label>
                                </span>
                           </div>
                           <em>~</em>
                           <div class="date_sec">
                                <span>
                                    <input name="rsrEndt" id="datepicker07" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.rsrEndt }" />" class="date required" title="종료일자" />
                                    <label for="datepicker07" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                    </tr>    
                    <tr>
                        <th scope="row">연구기간</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <span>
                            		<input name="rsStdt" id="datepicker08" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.rsStdt }" />" class="date required" title="시작일자" />
                            		<label for="datepicker08" class="btn_cld">날짜검색</label>
                                </span>
                           </div>
                           <em>~</em>
                           <div class="date_sec">
                                <span>
                                    <input name="rsEndt" id="datepicker09" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.rsEndt }" />" class="date required" title="종료일자" />
                                    <label for="datepicker09" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">초안보고서</th>
                        <td>
                        	<div class="date_sec">
                                <span>
                                    <input name="rep2Dt" id="datepicker10" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.rep2Dt }" />" class="date required" title="초안보고일" />
                                    <label for="datepicker10" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="bl">최종보고서</th>
                        <td>
                        	<div class="date_sec">
                                <span>
                                    <input name="repDt" id="datepicker11" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.repDt }" />" class="date required" title="최종보고일" />
                                    <label for="datepicker11" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <%-- <tr>
                        <th scope="row" class="bl"><i>*</i>전체연구기간</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <span>
                            		<input name="rsTstdt" id="datepicker12" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.rsTstdt }" />" class="date required" title="개시일자" />
                            		<label for="datepicker12" class="btn_cld">날짜검색</label>
                                </span>
                           </div>
                           <em>~</em>
                           <div class="date_sec">
                                <span>
                                    <input name="rsTendt" id="datepicker13" placeholder="0000-00-00" value="<c:out value="${rs1010mVO.rsTendt }" />" class="date required" title="종료일자" />
                                    <label for="datepicker13" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                    </tr> --%>
                </tbody>
            </table>
            <!-- //임상시험일정 -->
            
            
            <!-- 서브타이틀 -->
            <!-- <div class="sub_title_area">
                <h4>의뢰기관</h4>
            </div> -->
            <!-- //서브타이틀 -->
<%--             <!-- 의뢰기관 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">고객사</th>
                        <td>
                            <input type="text" value="<c:out value="${rs1010mVO.vendName }" />"  class="p80" id="vendName" name="vendName"/>
							<input type="hidden" value="<c:out value="${rs1010mVO.vendNo }" />"  class="p80" id="vendNo" name="vendNo"/>
                            <!-- <a href="#" onclick="fn_pop(); return false;" class="btn_sub">조회</a>  -->
                            <label for="modi-pop2" class="btn_sub">조회</label>
                        </td>
                        <th scope="row" class="bl">담당자</th>
                        <td>
                            <input type="text" value="<c:out value="${rs1010mVO.vmngName }" />"  id="vmngName" name="vmngName"/>
                        </td>
                    </tr>
                    <tr>
                    	<!-- 전화번호로 변경 -->
                        <th scope="row">연락처</th>
                        <td>
                            <input type="text" value="<c:out value="${rs1010mVO.vmnghpNo }" />"  id="vmnghpNo" name="vmnghpNo"/>
                        </td>
                        <!-- 이메일로 변경 -->
                        <th scope="row" class="bl">이메일</th>
                        <td>
                        	<input type="text" value="<c:out value="${rs1010mVO.vmngEmail }" />"  id="vmngEmail" name="vmngEmail"/>
                        </td>
                    </tr>
                    <!-- 고객사요청으로 연구비항목 삭제 - 2021.3.22 -->
                    <tr>
                        <th scope="row">연구비</th>
                        <td>                            
                            <!-- <input type="text" value="<c:out value="${rs1010mVO.rsPay }" />"  class="p40" id="rsPay" name="rsPay" onkeyup="fn_number(this);"/> -->
                            <input type="text" value="<c:out value="${rs1010mVO.rsPay }" />"  class="p40" id="rsPay" name="rsPay" />
                        </td>
                        <th scope="row" class="bl">부가세</th>
                        <td>                     
                        <input type="text" value="<c:out value="${rs1010mVO.rsPayvt }" />"  class="p40" id="rsPayvt" name="rsPayvt"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">제품구분</th>
                        <td>
                        <!-- 제품구분 목록(공통코드) CM4000M - CT2040  -->
						<select id="itemCls" name="itemCls">
							<c:forEach var="result" items="${ct2040}">
								<option value="${result.cd}"<c:if test="${result.cd eq rs1010mVO.itemCls}">selected="selected"</c:if>>${result.cdName}</option>
							</c:forEach>
						</select>
						</td>
						<th scope="row" class="bl">제품명</th>		
                        <td>
                        	<input type="text" value="<c:out value="${rs1010mVO.itemName }" />"  id="itemName" name="itemName"/>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //의뢰기관 --> --%>
            <!-- 서브타이틀 -->
<%--             <div class="sub_title_area">
                <h4>첨부파일</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 첨부파일 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">연구공고</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file01" />
                            	<label for="in_file01" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                        <th scope="row" class="bl">연구계획서</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file02" />
                            	<label for="in_file02" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">IRB신규계획서</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file03" />
                            	<label for="in_file03" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                        <th scope="row" class="bl">IRB결과보고서</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file04" />
                            	<label for="in_file04" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
 --%>            <!-- //첨부파일 -->
            </form:form>
			<!-- 버튼 -->
			<div class="btn_area">
					<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
					<a onclick="fn_update(); return false;">저장</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>구성원조회</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>검색어</p>
						<span class="type02">
							<input type="text" name="searchWord" id="searchWord" class="input-data" placeholder="검색어를  입력하세요" />
						</span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_search(); return false;">검색하기</a>
			</div>
			<!-- 사용체크정보 -->
			<!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:auto%" />
					<col style="width:20%" />
					<col style="width:20%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">구성원번호</th>
						<th scope="col">이름</th>
						<th scope="col">부서</th>
						<th scope="col">지사</th>
						<th scope="col">연구원구분</th>
					</tr>
				</thead>
				<tbody id="stdBody">
					<tr>
						<td colspan="5">이름을 검색해주세요.</td>
					</tr>
				</tbody>
			</table>
			<!-- //목록 -->
			<!-- 버튼 -->
            <div class="btn_area">
            	<label for="modi-pop" class="type02 btn-cancel btn_sub">취소</label>			
			</div>
		</div>
		<!-- //팝업 -->
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop11" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup11" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>구성원조회</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>검색어</p>
						<span class="type02">
							<input type="text" name="searchWord11" id="searchWord11" class="input-data" placeholder="검색어를  입력하세요" />
						</span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_search11(); return false;">검색하기</a>
			</div>
			<!-- 사용체크정보 -->
			<!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:auto%" />
					<col style="width:20%" />
					<col style="width:20%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">구성원번호</th>
						<th scope="col">이름</th>
						<th scope="col">부서</th>
						<th scope="col">지사</th>
						<th scope="col">연구원구분</th>
					</tr>
				</thead>
				<tbody id="stdBody11">
					<tr>
						<td colspan="5">이름을 검색해주세요.</td>
					</tr>
				</tbody>
			</table>
			<!-- //목록 -->
			<!-- 버튼 -->
            <div class="btn_area">
            	<label for="modi-pop11" class="type02 btn-cancel btn_sub">취소</label>			
			</div>
		</div>
		<!-- //팝업 -->
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop2" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup2" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>고객사조회</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>검색어</p>
						<span class="type02">
							<input type="text" name="searchWord2" id="searchWord2" class="input-data" placeholder="검색어를  입력하세요" />
						</span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_search2(); return false;">검색하기</a>
			</div>
			<!-- 고객사목록 -->
			<!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:auto%" />
					<col style="width:10%" />
					<col style="width:20%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">고객사번호</th>
						<th scope="col">고객사명</th>
						<th scope="col">대표자</th>
						<th scope="col">사업등록번호</th>
						<th scope="col">전화번호</th>
					</tr>
				</thead>
				<tbody id="stdBody2">
					<tr>
						<td colspan="5">고객사명을 검색해주세요.</td>
					</tr>
				</tbody>
			</table>
			<!-- //목록 -->
			<!-- 버튼 -->
            <div class="btn_area">
            	<label for="modi-pop2" class="type02 btn-cancel btn_sub" >취소</label>			
			</div>
		</div>
		<!-- //팝업 -->
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
