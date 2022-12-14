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
		
		var ynuseYn = '<c:out value="${cr3200mVO.useYn}"/>';
		
		switch(ynuseYn) {
		case "Y" :  
			$("#useY").attr('checked', 'checked');
			break;
		case "N" :  
			$("#useN").attr('checked', 'checked');
			break;
		default :
			$("#useY").attr('checked', 'checked');	
		}
		
		$("#dsp1").hide();
		$("#dsp2").hide();
		$("#dsp3").hide();
		$("#dsp4").hide();
		$("#dsp5").hide();
		
		var dsp = '<c:out value="${cr3200mVO.dspName1}"/>';
		if(dsp != '') {$("#dsp1").show();}
		var dsp = '<c:out value="${cr3200mVO.dspName2}"/>';
		if(dsp != '') {$("#dsp2").show();}
		var dsp = '<c:out value="${cr3200mVO.dspName3}"/>';
		if(dsp != '') {$("#dsp3").show();}
		var dsp = '<c:out value="${cr3200mVO.dspName4}"/>';
		if(dsp != '') {$("#dsp4").show();}
		var dsp = '<c:out value="${cr3200mVO.dspName5}"/>';
		if(dsp != '') {$("#dsp5").show();}
		
				
		//if(ynuseYn == 'Y'){
			//$("#useY").attr('checked', 'checked');
		//}else{
			//$("#useN").attr('checked', 'checked');
		//}
	});	

	function fn_dsp(dspCnt){
		switch(dspCnt) {
		case "1" :  
			$("#dsp1").show();
			$("#dspName1").removeAttr('disabled');
			$("#dsp2").hide();
			$("#dspName2").attr('disabled', true);
			$("#dsp3").hide();
			$("#dspName3").attr('disabled', true);
			$("#dsp4").hide();
			$("#dspName4").attr('disabled', true);
			$("#dsp5").hide();
			$("#dspName5").attr('disabled', true);
			break;
		case "2" :  
			$("#dsp1").show();
			$("#dspName1").removeAttr('disabled');
			$("#dsp2").show();
			$("#dspName2").removeAttr('disabled');
			$("#dsp3").hide();
			$("#dspName3").attr('disabled', true);
			$("#dsp4").hide();
			$("#dspName4").attr('disabled', true);
			$("#dsp5").hide();
			$("#dspName5").attr('disabled', true);
			break;
		case "3" :  
			$("#dsp1").show();
			$("#dspName1").removeAttr('disabled');
			$("#dsp2").show();
			$("#dspName2").removeAttr('disabled');
			$("#dsp3").show();
			$("#dspName3").removeAttr('disabled');
			$("#dsp4").hide();
			$("#dspName4").attr('disabled', true);
			$("#dsp5").hide();
			$("#dspName5").attr('disabled', true);
			break;
		case "4" :  
			$("#dsp1").show();
			$("#dspName1").removeAttr('disabled');
			$("#dsp2").show();
			$("#dspName2").removeAttr('disabled');
			$("#dsp3").show();
			$("#dspName3").removeAttr('disabled');
			$("#dsp4").show();
			$("#dspName4").removeAttr('disabled');
			$("#dsp5").hide();
			$("#dspName5").attr('disabled', true);
			break;
		case "5" :  
			$("#dsp1").show();
			$("#dspName1").removeAttr('disabled');
			$("#dsp2").show();
			$("#dspName2").removeAttr('disabled');
			$("#dsp3").show();
			$("#dspName3").removeAttr('disabled');
			$("#dsp4").show();
			$("#dspName4").removeAttr('disabled');
			$("#dsp5").show();
			$("#dspName5").removeAttr('disabled');
			break;
		default :
			$("#dsp1").hide;
			$("#dspName1").attr('disabled', true);
			$("#dsp2").hide;
			$("#dspName2").attr('disabled', true);
			$("#dsp3").hide;
			$("#dspName3").attr('disabled', true);
			$("#dsp4").hide;
			$("#dspName4").attr('disabled', true);
			$("#dsp5").hide;
			$("#dspName5").attr('disabled', true);
		}
	}
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech020503.do'/>"
					, '????????????????????????', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205List.do'/>";
	}
	
	function fn_update(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var regDt = $('#datepicker01').val();
			
		if(regDt==''){
			alert('????????????????????? ??????????????????.')
			$('#datepicker01').focus();
			return;
		}
	
		var regDt = $('#datepicker02').val();
		
		if(regDt==''){
			alert('????????????????????? ??????????????????.')
			$('#datepicker02').focus();
			return;
		}
		
		var chkTrm = $('#chkTrm').val();
		
		if(chkTrm==''){
			alert('??????????????? ??????????????????.')
			$('#chkTrm').focus();
			return;
		}
		
		var chkCnt = $('#chkCnt').val();
		
		if(chkCnt==''){
			alert('???????????? ??????????????????.')
			$('#chkCnt').focus();
			return;
		}
		
		switch(chkCnt) {
		case "1" :  
			if($("#dspName1").val()==''){
				alert('??????1???  ??????????????????.')
				$("#dspName1").focus();
				return;
			}
			break;
		case "2" :  
			if($("#dspName1").val()==''){
				alert('??????1???  ??????????????????.')
				$("#dspName1").focus();
				return;
			}
			if($("#dspName2").val()==''){
				alert('??????2???  ??????????????????.')
				$("#dspName2").focus();
				return;
			}
			break;
		case "3" :  
			if($("#dspName1").val()==''){
				alert('??????1???  ??????????????????.')
				$("#dspName1").focus();
				return;
			}
			if($("#dspName2").val()==''){
				alert('??????2???  ??????????????????.')
				$("#dspName2").focus();
				return;
			}
			if($("#dspName3").val()==''){
				alert('??????3???  ??????????????????.')
				$("#dspName3").focus();
				return;
			}
			
			break;
		case "4" :  
			if($("#dspName1").val()==''){
				alert('??????1???  ??????????????????.')
				$("#dspName1").focus();
				return;
			}
			if($("#dspName2").val()==''){
				alert('??????2???  ??????????????????.')
				$("#dspName2").focus();
				return;
			}
			if($("#dspName3").val()==''){
				alert('??????3???  ??????????????????.')
				$("#dspName3").focus();
				return;
			}
			if($("#dspName4").val()==''){
				alert('??????4???  ??????????????????.')
				$("#dspName4").focus();
				return;
			}
			break;
		case "5" :  
			if($("#dspName1").val()==''){
				alert('??????1???  ??????????????????.')
				$("#dspName1").focus();
				return;
			}
			if($("#dspName2").val()==''){
				alert('??????2???  ??????????????????.')
				$("#dspName2").focus();
				return;
			}
			if($("#dspName3").val()==''){
				alert('??????3???  ??????????????????.')
				$("#dspName3").focus();
				return;
			}
			if($("#dspName4").val()==''){
				alert('??????4???  ??????????????????.')
				$("#dspName4").focus();
				return;
			}
			if($("#dspName5").val()==''){
				alert('??????5???  ??????????????????.')
				$("#dspName5").focus();
				return;
			}
			break;
		default :
			$("#dsp1").hide;
			$("#dspName1").attr('disabled', true);
			$("#dsp2").hide;
			$("#dspName2").attr('disabled', true);
			$("#dsp3").hide;
			$("#dspName3").attr('disabled', true);
			$("#dsp4").hide;
			$("#dspName4").attr('disabled', true);
			$("#dsp5").hide;
			$("#dspName5").attr('disabled', true);
		}
		
		//$("#emailAdr").removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0205/ech0205Update.do'/>").submit();
	}

	
</script>
<body>
<!-- wrap -->

<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>eCRF??????</h2>
		<!-- contents -->
		<div class="contents">
			<!-- ????????? -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF??????"/>
	            <jsp:param name="dept2" value="??????????????????"/>
           	</jsp:include>
			<!-- //????????? -->
			<form:form commandName="cr3200mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${cr3200mVO.corpCd}">
				<input type="hidden" id="rsNo" name="rsNo" value="${cr3200mVO.rsNo eq ''?rsNo:cr3200mVO.rsNo}">
				<input type="hidden" id="dataRegdt" name="dataRegdt" value="${cr3200mVO.dataRegdt eq ''?dataRegdt:cr3200mVO.dataRegdt}">
			<!-- ??????????????? -->
			<div class="sub_title_area type02">
				<h4>????????????</h4>
			</div>
			<!-- //??????????????? -->
			<!-- ???????????? -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>					
					<tr>
						<th scope="row">????????????</th>
						<td>
							<c:choose>
                          		<c:when test="${rs1000mVO.dataLockYn eq 'Y' }"><c:out value="${rs1000mVO.rsCd }" /><span style="color:red;">(Data Locked)</span></c:when>
                          		<c:when test="${rs1000mVO.dataLockYn eq 'N' }"><c:out value="${rs1000mVO.rsCd }" /></c:when>
                          	</c:choose>
						</td>					
						<th scope="row" class="bl">?????????</th>
						<td><c:out value="${rs1000mVO.rsName }" /></td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td><c:out value="${rs1000mVO.rsstClsNm }" /></td>
						<th scope="row" class="bl">????????????</th>
						<td><c:out value="${rs1000mVO.rsStdt }" />~<c:out value="${rs1000mVO.rsEndt }" /></td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td><c:out value="${rs1000mVO.vendName }" /></td>
						<th scope="row" class="bl">?????????</th>
						<td><c:out value="${rs1000mVO.vmngName }" />,<c:out value="${rs1000mVO.vmnghpNo }" />,<c:out value="${rs1000mVO.vmngEmail }" /></td>
					</tr>
				</tbody>
			</table>
			<!-- //???????????? -->
			<!-- ??????????????? -->
			<div class="sub_title_area">
				<h4>??????????????????</h4>
			</div>
			<!-- //??????????????? -->
            <!-- ?????????????????? -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
							
					<tr>
						<th scope="row"><i>*</i>????????????</th>
						<td>
							<div class="date_sec">
								<span>
									<input name="chkStdt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${cr3200mVO.chkStdt }" />" class="date required" title="??????????????????" />
									<label for="datepicker01" class="btn_cld">????????????</label>
								</span>	
								<em>~</em>
								<span>
									<input name="chkEndt" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${cr3200mVO.chkEndt }" />" class="date required" title="??????????????????" />
									<label for="datepicker02" class="btn_cld">????????????</label>
								</span>
							</div>
						</td>
						<th scope="row" class="bl"><i>*</i>????????????</th>
						<td>
							<select id="chkTrm" name="chkTrm" class="p20">
								<option value="" <c:if test="${cr3200mVO.chkTrm eq '' }">selected="selected"</c:if> >??????</option>
								<option value="1" <c:if test="${cr3200mVO.chkTrm eq '1' }">selected="selected"</c:if> >1</option>
								<option value="2" <c:if test="${cr3200mVO.chkTrm eq '2' }">selected="selected"</c:if> >2</option>
								<option value="3" <c:if test="${cr3200mVO.chkTrm eq '3' }">selected="selected"</c:if> >3</option>
								<option value="4" <c:if test="${cr3200mVO.chkTrm eq '4' }">selected="selected"</c:if> >4</option>
								<option value="5" <c:if test="${cr3200mVO.chkTrm eq '5' }">selected="selected"</c:if> >5</option>
							</select>&nbsp;???
						</td>
					</tr>
					<tr>
						<th scope="row"><i>*</i>?????????</th>
						<td>
							<select id="chkCnt" name="chkCnt" class="p20" onchange="fn_dsp($('#chkCnt').val()); return false;">
								<option value="" <c:if test="${cr3200mVO.chkCnt eq '' }">selected="selected"</c:if> >??????</option>
								<option value="1" <c:if test="${cr3200mVO.chkCnt eq '1' }">selected="selected"</c:if> >1</option>
								<option value="2" <c:if test="${cr3200mVO.chkCnt eq '2' }">selected="selected"</c:if> >2</option>
								<option value="3" <c:if test="${cr3200mVO.chkCnt eq '3' }">selected="selected"</c:if> >3</option>
								<option value="4" <c:if test="${cr3200mVO.chkCnt eq '4' }">selected="selected"</c:if> >4</option>
								<option value="5" <c:if test="${cr3200mVO.chkCnt eq '5' }">selected="selected"</c:if> >5</option>
							</select>&nbsp;???
						</td>
						<th scope="row" class="bl">????????????</th>
						<td>
							<input type="radio" name="useYn" id="useY" value="Y"/>
						    <label for="useY">??????</label>
						    <input type="radio" name="useYn" id="useN" value="N"/>
						    <label for="useN">??????</label>
						</td>
					</tr>
					<tr>
						<th scope="row"><i>*</i>???????????????</th>
						<td colspan="3" id="answTd">
							<div class="check_btn" id="dsp1">
								<span>??????1</span>
								<input type="text" value="<c:out value="${cr3200mVO.dspName1 }" />"  class="ta_l p90" id="dspName1" name="dspName1"/>
							</div>
							<div class="check_btn" id="dsp2">
								<span>??????2</span>
								<input type="text" value="<c:out value="${cr3200mVO.dspName2 }" />"  class="ta_l p90" id="dspName2" name="dspName2"/>
							</div>
							<div class="check_btn" id="dsp3">
								<span>??????3</span>
								<input type="text" value="<c:out value="${cr3200mVO.dspName3 }" />"  class="ta_l p90" id="dspName3" name="dspName3"/>
							</div>
							<div class="check_btn" id="dsp4">
								<span>??????4</span>
								<input type="text" value="<c:out value="${cr3200mVO.dspName4 }" />"  class="ta_l p90" id="dspName4" name="dspName4"/>
							</div>
							<div class="check_btn" id="dsp5">
								<span>??????5</span>
								<input type="text" value="<c:out value="${cr3200mVO.dspName5 }" />"  class="ta_l p90" id="dspName5" name="dspName5"/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<input type="text" id="itemName" name="itemName" value="<c:out value="${cr3200mVO.itemName }" />"/>
						</td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<textarea id="cont" name="cont"><c:out value="${cr3200mVO.cont }" escapeXml="false"/></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //?????????????????? -->
			</form:form>
            <!-- ?????? -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">??????</a>
				<a href="#" onclick="fn_update(); return false;" >??????</a>
			</div>
			<!-- //?????? -->			
		</div>	
		<!-- //contents -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>		
	</div>
	<!-- ?????? -->
	<input type="checkbox" id="modi-pop" class="hidden" />
	<div class="black-pop">&nbsp;</div>
	<!-- ???????????? -->
	<div class="modi-popup" id="addrPop">
	</div>
	<!--// ???????????? -->
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>