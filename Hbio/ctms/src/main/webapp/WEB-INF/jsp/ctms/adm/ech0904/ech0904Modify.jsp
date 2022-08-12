<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function closeLayer( obj ) {
		$(obj).parent().parent().hide();
	}

	$(function(){

		//수정인 경우 RS_CD 생성하는 컬럼을 사용하지 못하게 처리해야 함
		var yndataRegnt = '<c:out value="${cs2020mVO.dataRegnt}"/>';
		if(!yndataRegnt=='') {
			$('#ctrtNo').attr('disabled', 'true');
			$('#ctrtCd').attr('disabled', 'true');
			$('#vendNo').attr('disabled', 'true');
			$('#vendName').attr('disabled', 'true');
			$('#inSq').attr('disabled', 'true');
			$('.dispNone').hide();
			
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
			html += '	<td colspan="6">견적명을 검색해주세요.</td>';
			html += '</tr>';
			$("#stdBody3").html(html);
		});
		
		//
		var inTamt = '<c:out value="${cs2020mVO.inTamt}"/>';
		$("#inTamt").val(inTamt.toLocaleString('ko-KR'));
		
	});	
	
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
			url: "<c:url value='/qxsepmny/ech1005/ech1005AjaxSearchCtrt.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord3").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select3('+i+'); return false;">';
					html += '	<td>'+resultList[i].vendName+'</td>';
					html += '	<td>'+resultList[i].ctrtCd+'</td>';
					html += '	<td>'+resultList[i].ctrtDt+'</td>';
					html += '	<td>'+resultList[i].ctrtName+'</td>';
					html += '	<td>'+resultList[i].rsPay+'</td>';
					html += '	<td>'+resultList[i].rsPayvt+'</td>';
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
		
		//팝업에서 선택한 값을 설정한다.
		$("#ctrtNo").val(result.ctrtNo);
		$("#ctrtCd").val(result.ctrtCd);
		$("#ctrtName").val(result.ctrtName);
		$("#rsTpay").val(result.rsTpay);
		
		var chkrsPay = result.rsPay;
		var chkrsPay2 = chkrsPay.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#rsPay").val(chkrsPay2);
		
		var chkrsPayvt = result.rsPayvt;
		var chkrsPayvt2 = chkrsPayvt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#rsPayvt").val(chkrsPayvt2);
		
		$("#vendNo").val(result.vendNo);
		$("#vendName").val(result.vendName);
		
		if(result.inTamt == null) {
			$("#inTamt").val(0);
			$("#inBamt").val(0);
		}else{
			var chkinTamt = result.inTamt;
			var chkinTamt2 = chkinTamt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$("#inTamt").val(chkinTamt2);
			
			var chkinBamt = result.inBamt;
			var chkinBamt2 = chkinBamt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$("#inBamt").val(chkinBamt2);
		}
		
		
		//var chkInBamt = result.InBamt;
		//var chkInBamt2 = chkInBamt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		//$("#InBamt").val(chkInBamt2);
		
		$("#inSq").val(result.inSq+1);
		
		//alert($("#inAmt").val().replaceAll(",",""));
		//var inAmt = Number($("#inAmt").val().replaceAll(",",""));
		//alert(inAmt);
		//var inTamt = result.inTamt + inAmt;
		//var inBamt = result.rsTpay - inTamt;
		//$("#inTamt").val(inTamt);
		//alert(inTamt);
		//alert($("#inTamt").val());
		//$("#inTamt").val(inTamt.toLocaleString('ko-KR'));
		//$("#inBamt").val(inBamt);
		
		//$("#inBamt").val(result.inBamt);
		
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
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0904/ech0904List.do'/>";
	}	
	
	//function fn_update(){
		//if(fn_validate("detailForm")){
		 	//$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0904/ech0904Update.do'/>").submit();
		//}
	//}
	
	function fn_update(){
		var ctrtDt = $('#datepicker01').val();			
		if(ctrtDt==''){
			alert('입금일자를 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
		
		var empNo = $('#empNo').val();
		if(empNo==''){
			alert('입금담당자를 입력해주세요.')
			$('#empNo').focus();
			return;
		}
		
		var inAmt = $('#inAmt').val();
		if(inAmt==''){
			alert('입금액을 입력해주세요.')
			$('#inAmt').focus();
			return;
		}
		
		var ctrtNo = $('#ctrtNo').val();
		if(ctrtNo==''){
			alert('계약번호를 입력해주세요.')
			$('#ctrtNo').focus();
			return;
		}
		
		var vendNo = $('#vendNo').val();
		if(vendNo==''){
			alert('고객사를 입력해주세요.')
			$('#vendNo').focus();
			return;
		}
		
		var inSq = $('#inSq').val();
		if(inSq==''){
			alert('입금차수를 입력해주세요.')
			$('#inSq').focus();
			return;
		}
		
		$('#ctrtNo').removeAttr('disabled');
		$('#ctrtCd').removeAttr('disabled');
		$('#vendNo').removeAttr('disabled');
		$('#vendName').removeAttr('disabled');
		$('#inSq').removeAttr('disabled');
		$("#inAmt").val($("#inAmt").val().replace(/,/g,''));
		$("#inTamt").val($("#inTamt").val().replace(/,/g,''));
		$("#inBamt").val($("#inBamt").val().replace(/,/g,''));
		$("#rsPay").val($("#rsPay").val().replace(/,/g,''));
		$("#rsPayvt").val($("#rsPayvt").val().replace(/,/g,''));
		$("#rsTpay").val($("#rsTpay").val().replace(/,/g,''));
				
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0904/ech0904Update.do'/>").submit();
	}
	
	//첨부파일 삭제
	function fn_delfile(fileKey, seq){
	
		var html = '';
		if(seq != ''){
			html += '<input type="hidden" id="delFile" name="delFile" value="'+seq+'"/>';
		}
			html += '<input type="file" id="'+fileKey+'" name="'+fileKey+'" onchange="fn_file_add(\''+fileKey+'\'); return false;"/>';
			html += '<label for="'+fileKey+'" id="'+fileKey+'_label" class="btn_sub">파일업로드</label>';
		
		
		$("#"+fileKey+"_div").html(html);
	}
	
	//첨부파일 추가
	function fn_file_add(fileKey){
		
		if(fileCheck_adm(fileKey)){
			var fileValue = $('#'+fileKey).val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
			var html = ''
		
			html+= '<div>';
			html+= '<span>'+fileName+'</span>';
			html+= '<a href="#" onclick="fn_delfile(\''+fileKey+'\',\'\');">삭제</a>';
			html+= '</div>'; 
			
			$("#"+fileKey+"_label").addClass('dpn');
			$("#"+fileKey+"_div").append(html); 
        } 
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>입금관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="영업관리"/>
	            <jsp:param name="dept2" value="입금관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>입금정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <form:form commandName="cs2020mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${cs2020mVO.corpCd}">
				<input type="hidden" id="inNo" name="inNo" value="${cs2020mVO.inNo}">
				<input type="hidden" id="rsTpay" name="rsTpay" value="${cs2020mVO.rsTpay}">
            <!-- 견적정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>    
                        <th scope="row"><i>*</i>입금일자</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="inDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${cs2020mVO.inDt }" />" class="date required" title="입금일" />
                                    <label for="datepicker01" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="bl"><i>*</i>입금담당자</th>
                        <td>
                           	<input type="text" value="<c:out value="${cs2020mVO.empName }" />"  class="p30" id="empName" name="empName"/>
                           	<input type="hidden"  value="<c:out value="${cs2020mVO.empNo }" />"  class="p30" id="empNo" name="empNo"/>
                            <label for="modi-pop" class="btn_sub">조회</label>
                        </td>                        
                    </tr>
                    <tr>
                    	<th scope="row"><i>*</i>입금액</th>
                        <td>
							<input type="text" value="<c:out value="${cs2020mVO.inAmt }" />"  class="p30 txt-r" id="inAmt" name="inAmt" onkeyup="fn_number(this);"/>원
						</td>
                    	<th scope="row" class="bl"><span class="dispNone"><i>*</i></span>계약번호</th>
                        <td>
							<input type="text" value="<c:out value="${cs2020mVO.ctrtCd }" />"  class="p30" id="ctrtCd" name="ctrtCd"/>
                           	<input type="hidden"  value="<c:out value="${cs2020mVO.ctrtNo }" />"  class="p30" id="ctrtNo" name="ctrtNo"/>
                            <label for="modi-pop3" class="btn_sub dispNone">조회</label>
						</td>
                    </tr>
                    <tr>
                    	<th scope="row"><span class="dispNone"><i>*</i></span>고객사</th>
                        <td>
                            <input type="text" value="<c:out value="${cs2020mVO.vendName }" />"  class="p80" id="vendName" name="vendName"/>
							<input type="hidden" value="<c:out value="${cs2020mVO.vendNo }" />"  class="p80" id="vendNo" name="vendNo"/>
                            <label for="modi-pop2" class="btn_sub dispNone">조회</label>
                        </td>
                        <th scope="row" class="bl">계약명</th>
                        <td>
                        	<input type="text" value="<c:out value="${cs2020mVO.ctrtName }" />"  id="ctrtName" name="ctrtName"/>
                        </td>
					</tr>
					<tr>
                        <th scope="row">계약금액</th>
                        <td>
                        	<input type="text" value="<c:out value="${cs2020mVO.rsPay }" />"  pattern="#,###" class="p30 txt-r" id="rsPay" name="rsPay" readonly />원
						</td>
						<th scope="row" class="bl">부가세</th>
                        <td>
                            <input type="text" value="<c:out value="${cs2020mVO.rsPayvt }" />"  pattern="#,###" class="p30 txt-r" id="rsPayvt" name="rsPayvt" readonly/>원
						</td>
					</tr>
					<tr>
                        <th scope="row">(입금현황)누적입금액</th>
                        <td>
							<input type="text" value="<c:out value="${cs2020mVO.inTamt }" />" pattern="#,###" class="p30 txt-r" id="inTamt" name="inTamt" onkeyup="fn_number(this);" readonly/>원
						</td>
						<th scope="row" class="bl">잔금</th>
                        <td>
							<input type="text" value="<c:out value="${cs2020mVO.inBamt }" />"  pattern="#,###" class="p30 txt-r"  id="inBamt" name="inBamt" readonly />원
						</td>
					</tr>
					<tr>
                        <th scope="row"><span class="dispNone"><i>*</i></span>입금차수</th>
                        <td  colspan="3">
							<input type="text" value="<c:out value="${cs2020mVO.inSq }" />"  class="p5" id="inSq" name="inSq" />
						</td>
					</tr>
					
					<tr>
						<th scope="row">세금계산서일</th>
                        <td colspan="3">
                            <div class="date_sec">
                                <span>
                                    <input name="reciDt" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${cs2020mVO.reciDt }" />" class="date required" title="세금계산서일" />
                                    <label for="datepicker02" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
					</tr>	
					<tr>
                        <th scope="row">비고</th>                        
                        <td colspan="3">
							<textarea class="type02 type03" id="remk" name="remk"><c:out value="${cs2020mVO.remk }" /></textarea>
						</td>                        
                    </tr>
                    <tr>
						<th scope="row">담당지사</th>
						<td colspan="3">
							<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->
														
							<select id="branchCd" name="branchCd" class="p15">
								<option value="" <c:if test="${cs2020mVO.branchCd eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${branch}">
									<option value="${result.branchCd}"<c:if test="${result.branchCd eq cs2020mVO.branchCd}">selected="selected"</c:if>>${result.branchName}</option>
								</c:forEach>
							</select>	
						</td>
                    </tr>
                    <tr>
                        <th scope="row">관리번호</th>
                        <td colspan="3">
                        	<span class="p10"><c:out value="${cs2020mVO.inNo }"/></span>
                        	<%-- <input type="text" value="<c:out value="${cs2020mVO.inNo }" />"  class="p10" id="inNo" name="inNo" readonly/> --%>
                        </td>
                    </tr>
                </tbody>
            </table>
                        <!-- 첨부파일 영역 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>파일첨부</h4>	                             
            </div>
            <!-- //서브타이틀 -->
            <!-- 파일첨부 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">첨부파일</th>
                        <td colspan="3" id="file_td">
                            <div class="attach_sec type02 mb02" id="attachRpt01_div">
	                            	<c:choose>
		                            		<c:when test="${attachMap.attachRpt01 != null }">
				                            	<div>
				                            		<span><c:out value="${attachMap.attachRpt01.orgFileName }"/></span>
				                            		<a href="#" onclick="fn_delfile('attachRpt01','<c:out value="${attachMap.attachRpt01.attachNo }"/>');">삭제</a>
				                            	</div>
		                            		</c:when>
		                            		<c:otherwise>
				                            	 <input type="file" id="attachRpt01" name="attachRpt01" onchange="fn_file_add('attachRpt01'); return false;"/>
				                            	<label for="attachRpt01" id="attachRpt01_label" class="btn_sub">파일업로드</label>  
		                            		</c:otherwise>
	                            	</c:choose>
                            </div>
                        	 <div class="attach_sec type02 mb02" id="attachRpt02_div">
                                 <c:choose>
	                            		<c:when test="${attachMap.attachRpt02 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt02.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt02','<c:out value="${attachMap.attachRpt02.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	 <input type="file" id="attachRpt02" name="attachRpt02" onchange="fn_file_add('attachRpt02'); return false;"/>
			                            	<label for="attachRpt02" id="attachRpt02_label" class="btn_sub">파일업로드</label> 	
	                            		</c:otherwise>
                            	</c:choose> 
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt03_div">
                                 <c:choose>
	                            		<c:when test="${attachMap.attachRpt03 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt03.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt03','<c:out value="${attachMap.attachRpt03.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                                <input type="file" id="attachRpt03" name="attachRpt03" onchange="fn_file_add('attachRpt03'); return false;"/>
			                            	<label for="attachRpt03" id="attachRpt03_label" class="btn_sub">파일업로드</label>    
	                            		</c:otherwise>
                            	</c:choose>     
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt04_div">
                          	     <c:choose>
	                            		<c:when test="${attachMap.attachRpt04 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt04.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt04','<c:out value="${attachMap.attachRpt04.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	 <input type="file" id="attachRpt04" name="attachRpt04" onchange="fn_file_add('attachRpt04'); return false;"/>
			                            	<label for="attachRpt04" id="attachRpt04_label" class="btn_sub">파일업로드</label> 
	                            		</c:otherwise>
                            	</c:choose>     
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt05_div">
              	     			<c:choose>
	                            		<c:when test="${attachMap.attachRpt05 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt05.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt05','<c:out value="${attachMap.attachRpt05.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	 <input type="file" id="attachRpt05" name="attachRpt05" onchange="fn_file_add('attachRpt05'); return false;"/>
			                            	<label for="attachRpt05" id="attachRpt05_label" class="btn_sub">파일업로드</label> 
	                            		</c:otherwise>
                            	</c:choose> 
                            </div>  
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //파일첨부 -->
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
				<h4>계약조회</h4>
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
			<!-- 견적목록 -->
			<!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:15%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:auto%" />
					<col style="width:10%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">고객사</th>
						<th scope="col">계약번호</th>
						<th scope="col">계약일자</th>
						<th scope="col">계약명</th>
						<th scope="col">연구비</th>
						<th scope="col">부가세</th>
					</tr>
				</thead>
				<tbody id="stdBody3">
					<tr>
						<td colspan="6">계약명 또는 고객사명으로 검색해주세요.</td>
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
