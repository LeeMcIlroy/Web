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

		//수정인 경우 RS_CD 생성하는 컬럼을 사용하지 못하게 처리해야 함
		var yndataRegnt = '<c:out value="${rs3000mVO.dataRegnt}"/>';
		if(!yndataRegnt=='') {
			$('#ctrtNo').attr('disabled', 'true');
			$('#ctrtCd').attr('disabled', 'true');
		} else {
			$('#ctrtNo').attr('disabled', 'true');
			$('#ctrtCd').attr('disabled', 'true');
		}
		
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
		
		$("#modi-pop3").change(function(){
			html = '<tr>';
			html += '	<td colspan="6">연구코드,연구명 또는 고객사명으로 검색해주세요.</td>';
			html += '</tr>';
			$("#stdBody3").html(html);
		});
		
		// 수거여부 Y 수거 N 미수거
		var reYn = '<c:out value="${rs3000mVO.reYn}"/>';
		switch (reYn) {
			case 'Y':
				$("#reYn1").attr('checked', 'checked');
		    	break;
			case 'N':
				$("#reYn2").attr('checked', 'checked');
		    	break;			    	
		  default:
		    console.log(`Sorry, we are out of ${expr}.`);
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
			url: "<c:url value='/qxsepmny/ech0106/ech0106AjaxRsCdCheck.do'/>"
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
				alert(message);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	// 	연구계획서 가져오기
	function fn_check2(){
		var rsCd = $("#rsCd").val();
		var csNo1 = $("#csNo1").val();
		var csNo2 = $("#csNo2").val();
		var csNo3 = $("#csNo3").val();
		var csNo4 = $("#csNo4").val();
		var csNo5 = $("#csNo5").val();
		var csNo6 = $("#csNo6").val();
		
		if(rsCd == ''){
			alert('먼저 연구코드를  생성해 주세요');
			return;
		}
		$.ajax({
			url: "<c:url value='/qxsepmny/ech0106/ech0106AjaxRsCdCheck2.do'/>"
			, type: "post"
			, data: "rsCd="+rsCd+"&"+"csNo1="+csNo1+"&"+"csNo2="+csNo2+"&"+"csNo3="+csNo3+"&"+"csNo4="+csNo4+"&"+"csNo5="+csNo5+"&"+"csNo6="+csNo6
			, dataType:"json"
			, success: function(data){
				var status = data.status;
				var message = data.message;
				
				if(!status){
					$("#rsCd").val('');
				}else{
					$("#datepicker01").datepicker().datepicker("setDate", data.rs1010mVO.regDt);
					
					$("#rsDrt").val(data.rs1010mVO.rsDrt);
					$("#rsDrtNm").val(data.rs1010mVO.rsDrtNm);
					$("#rsGrt").val(data.rs1010mVO.rsGrt);
					$("#rsGrtNm").val(data.rs1010mVO.rsGrtNm);
					
					$("#rsMscnt").val(data.rs1010mVO.rsMscnt);
					$("#visitCnt").val(data.rs1010mVO.visitCnt);
					$("#ageSt").val(data.rs1010mVO.ageSt);
					$("#ageEn").val(data.rs1010mVO.ageEn);
					
					//대상부위를 설정한다
					var ynVal = data.rs1010mVO.rsPos;
					const arrRsPos = ynVal.split(",");
					
					for(var i=0; i<arrRsPos.length; i++){
						var setval = arrRsPos[i];
						$("#rsPos"+setval).attr('checked', 'checked');
					}
					
					//연구상태 설정 - 공통코드인데 radio로 처리됨
					var ynrsstCls = data.rs1010mVO.rsstCls;					
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
					
					//IRB승인여부 설정
					var ynirbsmYn = data.rs1010mVO.irbsmYn;
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
					var ynduplYn = data.rs1010mVO.duplYn;
					if(ynduplYn == 'Y'){
						$("#duplYn1").attr('checked', 'checked');
					}else{
						$("#duplYn2").attr('checked', 'checked');
					}
					
					//모집성별 
					var yngenYn = data.rs1010mVO.genYn;
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
					
					$("#rsName").val(data.rs1010mVO.rsName);
					$("#rsPps").val(data.rs1010mVO.rsPps);
					$("#rsPtc").val(data.rs1010mVO.rsPtc);
					
					$("#datepicker03").datepicker().datepicker("setDate", data.rs1010mVO.rsplDt);
					$("#datepicker04").datepicker().datepicker("setDate", data.rs1010mVO.rsitDt);
					$("#datepicker05").datepicker().datepicker("setDate", data.rs1010mVO.rsirbDt);
					$("#datepicker06").datepicker().datepicker("setDate", data.rs1010mVO.rsrStdt);
					$("#datepicker07").datepicker().datepicker("setDate", data.rs1010mVO.rsrEndt);
					$("#datepicker08").datepicker().datepicker("setDate", data.rs1010mVO.rep2Dt);
					$("#datepicker09").datepicker().datepicker("setDate", data.rs1010mVO.repDt);
					
					//IRB심의정보가 등록된 경우 설정한다. 
					
				}
				alert(message);
			}, error: function(){
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
		$("#empNo").val(result.empNo);
		$("#empName").val(result.empName);
		$("#branchCd").val(result.branchCd);
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
		$("#empNo").val(result.empNo);
		$("#empName").val(result.empName);
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

	function fn_search3(){
		$.ajax({
			url: "<c:url value='/qxsepmny/ech1005/ech1005AjaxSearchRs.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord3").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select3('+i+'); return false;">';
					html += '	<td>'+resultList[i].vendName+'</td>';
					html += '	<td>'+resultList[i].rsCd+'</td>';
					html += '	<td>'+resultList[i].rsName+'</td>';
					html += '	<td>'+resultList[i].rsstClsNm+'</td>';
					html += '	<td>'+resultList[i].rsStdt+'</td>';
					html += '	<td>'+resultList[i].rsEndt+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="6">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody3").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}

	function fn_select3(i){
		var result = resultList[i];
		
		$("#rsNo").val(result.rsNo);
		$("#rsCd").val(result.rsCd);
		$("#rsName").val(result.rsName);
		$("#vendNo").val(result.vendNo);
		$("#vendName").val(result.vendName);
		
		//$("#nameTd").html(result.name);
		//$("#orgNmTd").html(result.orgNm);
		//$("#bracnNmTd").html(result.branchNm);
		//$("#rsClsNmTd").html(result.rsClsNm);		
		
		$("#modi-pop3").click();
		
		resultList = null;
	}
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech10105/ech100501.do'/>"
					, '관리자 조회', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106List.do'/>";
	}	
	
	//function fn_update(){
		//if(fn_validate("detailForm")){
		 	//$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0106/ech0106Update.do'/>").submit();
		//}
	//}
	

	
	function fn_setrsCd(){
		var chkVal = $('#csNo1').val();
		if(chkVal==''){
			alert('연구과제고유번호을 입력해주세요.')
			$('#csNo1').focus();
			return;
		}
		var chkVal = $('#csNo2').val();
		if(chkVal==''){
			alert('임상종류를 입력해주세요')
			$('#csNo2').focus();
			return;
		}
		var chkVal = $('#csNo3').val();
		if(chkVal==''){
			alert('임상분류를 입력해주세요')
			$('#csNo3').focus();
			return;
		}
		var chkVal = $('#csNo4').val();
		if(chkVal==''){
			alert('프로토콜을  입력해주세요')
			$('#csNo4').focus();
			return;
		}
		var chkVal = $('#csNo5').val();
		if(chkVal==''){
			alert('연구년도를 입력해주세요')
			$('#csNo5').focus();
			return;
		}
		var chkVal = $('#csNo6').val();
		if(chkVal==''){
			alert('임상번호를  입력해주세요')
			$('#csNo6').focus();
			return;
		}
		var chkVal = $('#csNo7').val();
		if(chkVal==''){
			alert('차수를 입력해주세요')
			$('#csNo7').focus();
			return;
		}
		
		//연구코드 생성 
		$('#rsCd').val($('#csNo1').val()+$('#csNo2').val()+'-'+$('#csNo3').val()+$('#csNo4').val()+'-'+$('#csNo5').val()+$('#csNo6').val()+'-'+$('#csNo7').val());
	}	
	
	function fn_update(){
		var inhDt = $('#datepicker01').val();			
		if(inhDt==''){
			alert('입고일자를 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
		
		var empNo = $('#empNo').val();
		if(empNo==''){
			alert('제품담당자를 입력해주세요.')
			$('#empNo').focus();
			return;
		}
		
		var rsNo = $('#rsNo').val();
		if(rsNo==''){
			alert('연구번호를 입력해주세요.')
			$('#rsNo').focus();
			return;
		}
		
		var vendNo = $('#vendNo').val();
		if(vendNo==''){
			alert('고객사를 입력해주세요.')
			$('#vendNo').focus();
			return;
		}
		
		var itemName = $('#itemName').val();
		if(itemName==''){
			alert('제품명을 입력해주세요.')
			$('#itemName').focus();
			return;
		}
		
		var itemCls = $('#itemCls').val();
		if(itemCls==''){
			alert('제품구분을 입력해주세요.')
			$('#itemCls').focus();
			return;
		}
		
				
		$('#itemNo').removeAttr('disabled');
				
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0106/ech0106Update.do'/>").submit();
	}
	
	// IRB심의정보 삭제 연구번호+IRB심의번호 
	function fn_delIrb(){
		if(confirm('IRB심의정보를 삭제합니다. 삭제된 정보는 복구되지 않습니다.\r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var csNo = $("#csNo").val();
			var rvNo1 = $("#rvNo1").val();
			var rvNo2 = $("#rvNo2").val();
			var rvNo3 = $("#rvNo3").val();
			var rvNo4 = $("#rvNo4").val();
			var rvNo5 = $("#rvNo5").val();
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106AjaxDelIrb.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"csNo="+csNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+"rvNo1="+rvNo1+"&"+"rvNo2="+rvNo2+"&"+"rvNo3="+rvNo3+"&"+"rvNo4="+rvNo4+"&"+"rvNo5="+rvNo5
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
	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>시험제품</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="연구관리"/>
	            <jsp:param name="dept2" value="시험제품"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>시험제품정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <form:form commandName="rs3000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${rs3000mVO.corpCd}">
            <!-- 시험제품정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">제품번호(변경불가)</th>
                        <td colspan="3">
                        	<input type="text" value="<c:out value="${rs3000mVO.itemNo }" />"  class="p40" id="itemNo" name="itemNo"/>
                        </td>
                    </tr>
                    <tr>    
                        <th scope="row"><i>*</i>입고일자</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="inhDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${rs3000mVO.inhDt }" />" class="date required" title="입고일" />
                                    <label for="datepicker01" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="b1"><i>*</i>제품담당자</th>
                        <td>
                           	<input type="text" value="<c:out value="${rs3000mVO.empName }" />"  class="p30" id="empName" name="empName"/>
                           	<input type="hidden"  value="<c:out value="${rs3000mVO.empNo }" />"  class="p30" id="empNo" name="empNo" class="date required" />
                            <label for="modi-pop" class="btn_sub">조회</label>
                        </td>                        
                    </tr>
                    <tr>
                    	<th scope="row"><i>*</i>연구번호</th>
                        <td colspan="3">
							<input type="text" value="<c:out value="${rs3000mVO.rsCd }" />"  class="p30" id="rsCd" name="rsCd"/>
                           	<input type="hidden"  value="<c:out value="${rs3000mVO.rsNo }" />"  class="p30" id="rsNo" name="rsNo"/>
                            <label for="modi-pop3" class="btn_sub">조회</label>
						</td>
                    </tr>
                    <tr>
                    	<th scope="row"><i>*</i>고객사</th>
                        <td>
                            <input type="text" value="<c:out value="${rs3000mVO.vendName }" />"  class="p80" id="vendName" name="vendName"/>
							<input type="hidden" value="<c:out value="${rs3000mVO.vendNo }" />"  class="p80" id="vendNo" name="vendNo" class="date required" />
                            <label for="modi-pop2" class="btn_sub">조회</label>
                        </td>
                        <th scope="row" class="bl">연구명</th>
                        <td>
                        	<input type="text" value="<c:out value="${rs3000mVO.rsName }" />"  id="rsName" name="rsName"/>
                        </td>
					</tr>
					<tr>
                        <th scope="row"><i>*</i>제품명</th>
                        <td>
                        	<input type="text" value="<c:out value="${rs3000mVO.itemName }" />"  id="itemName" name="itemName" class="required" />
						</td>
						<th scope="row" class="b1"><i>*</i>제품구분</th>
                        <td>
                            <%-- <input type="text" value="<c:out value="${rs3000mVO.itemCls }" />"  id="itemCls" name="itemCls" class="date required" /> --%>
                            <!-- 제품구분 목록(공통코드) CM4000M - CT2040  -->
							<select id="itemCls" name="itemCls">
								<option value="" <c:if test="${rs3000mVO.itemCls eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${ct2040}">
									<option value="${result.cd}"<c:if test="${result.cd eq rs3000mVO.itemCls}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">반출일</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="outDt" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${rs3000mVO.outDt }" />"  class="date" title="반출일" />
                                    <label for="datepicker02" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="bl">발송일</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="sendDt" id="datepicker03" placeholder="0000-00-00" value="<c:out value="${rs3000mVO.sendDt }" />" class="date" title="발송일" />
                                    <label for="datepicker03" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
					</tr>
					<tr>
                        <th scope="row">수거여부</th>
                        <td>
                        	<%-- <input type="text" value="<c:out value="${rs3000mVO.reYn }" />"  id="reYn" name="reYn"/> --%>
                        	<input type="radio" name="reYn" id="reYn1" value="Y" />
							<label for="reYn1">수거</label>
							<input type="radio" name="reYn" id="reYn2" value="N" />
	                        <label for="reYn2">미수거</label>
						</td>
						<th scope="row" class="bl">수거일</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="reDt" id="datepicker04" placeholder="0000-00-00" value="<c:out value="${rs3000mVO.reDt }" />" class="date" title="수거일" />
                                    <label for="datepicker04" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
					</tr>
					<tr>
						<th scope="row">폐기일</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <span>
                                    <input name="dispoDt" id="datepicker05" placeholder="0000-00-00" value="<c:out value="${rs3000mVO.dispoDt }" />" class="date" title="폐기일" />
                                    <label for="datepicker05" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
					</tr>
					<tr>
                        <th scope="row">비고</th>                        
                        <td colspan="3">
							<textarea class="type02 type03" id="remk" name="remk"><c:out value="${rs3000mVO.remk }" /></textarea>
						</td>                        
                    </tr>
                    <tr>
						<th scope="row">담당지사</th>
						<td colspan="3">
							<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->
							<select id="branchCd" name="branchCd" class="p15">
								<option value="" <c:if test="${rs3000mVO.branchCd eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${branch}">
									<option value="${result.branchCd}"<c:if test="${result.branchCd eq rs3000mVO.branchCd}">selected="selected"</c:if>>${result.branchName}</option>
								</c:forEach>
							</select>	
						</td>
                    </tr>
                </tbody>
            </table>
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
		<input type="checkbox" id="modi-pop3" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup3" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>연구조회</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>검색어</p>
						<span class="type02">
							<input type="text" name="searchWord3" id="searchWord3" class="input-data" placeholder="검색어를  입력하세요" />
						</span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_search3(); return false;">검색하기</a>
			</div>
			<!-- 연구목록 -->
			<!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:auto" />
					<col style="width:8%" />
					<col style="width:12%" />
					<col style="width:12%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">고객사</th>
						<th scope="col">연구번호</th>
						<th scope="col">연구명</th>
						<th scope="col">연구상태</th>
						<th scope="col">연구시작일</th>
						<th scope="col">연구종료일</th>
					</tr>
				</thead>
				<tbody id="stdBody3">
					<tr>
						<td colspan="6">연구코드,연구명 또는 고객사명으로 검색해주세요.</td>
					</tr>
				</tbody>
			</table>
			<!-- //목록 -->
			<!-- 버튼 -->
            <div class="btn_area">
            	<label for="modi-pop3" class="type02 btn-cancel btn_sub" >취소</label>			
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
