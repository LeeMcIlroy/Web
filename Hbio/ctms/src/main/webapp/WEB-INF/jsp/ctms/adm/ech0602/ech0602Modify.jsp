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
		
		$("#smsdisp").hide();
		$("#resrdisp").hide();
		
		var ynSubmitFile1 = '<c:out value="${rm1000mVO.fileNames1}"/>';
		switch (ynSubmitFile1) {
		case '1':
			$("#fileNames1").attr('checked', 'checked');
	    	break;
		case '2':
			$("#fileNames2").attr('checked', 'checked');
			break;
		}
		
		var ynSubmitFile2 = '<c:out value="${rm1000mVO.fileNames2}"/>';
		switch (ynSubmitFile2) {
		case '1':
			$("#fileNames1").attr('checked', 'checked');
	    	break;
		case '2':
			$("#fileNames2").attr('checked', 'checked');
			break;
		}
		
		/* var ynSubmitFile = '<c:out value="${rm1000mVO.fileNames}"/>';
		switch (ynSubmitFile) {
		case '1':
			$("#fileNames1").attr('checked', 'checked');
	    	break;
		case '2':
			$("#fileNames2").attr('checked', 'checked');
			break;
		default:
			console.log(`Sorry, we are out of ${expr}.`);
		} */
		
		// 1 즉시발송, 2 예약발송
		var ynSubmitSet = '<c:out value="${rm1000mVO.sendmCls}"/>';
		
		switch (ynSubmitSet) {
		case '1':
			$("#sendmCls1").attr('checked', 'checked');
			
	    	break;
		case '2':
			$("#sendmCls2").attr('checked', 'checked');
			$("#resrdisp").show();
			break;
		default:
			console.log(`Sorry, we are out of ${expr}.`);
		}
		
		// 1 이메일, 2 이메일+SMS
		var ynSubmitGb = '<c:out value="${rm1000mVO.sendsCls}"/>';
		
		switch (ynSubmitGb) {
			case '1':
				$("#sendsCls1").attr('checked', 'checked');
				$("#smsdisp").hide();
		    	break;
			case '2':
				$("#sendsCls2").attr('checked', 'checked');
				$("#smsdisp").show();
		    	break;				
		  default:
		    console.log(`Sorry, we are out of ${expr}.`);
		}
		
		
		
		// 첨부파일이 있는 경우 파일업로드 버튼을 숨긴다
		
		if(${empty attachList }){ 
			//alert(${empty attachList });
			$(".checkfile").show();
		}else{				
			$(".checkfile").hide();
		}		
		// 등록, 수정 구분? 
		
		// $("#datepicker01").datepicker();

		

	
	});


	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0602/ech0602List.do'/>").submit();
	}
	
	function fn_pop() {
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100401.do'/>"
				, '연구조회팝업', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_pop2() {
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100401.do'/>"
				, '고객사팝업', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	

	function fn_update(){
		
		//$('#cont').val(CKEDITOR.instances.Cont.getData());
				
		var recmDt = $('#recmDt').val();
		
		if(recmDt==''){
			alert('접수일자를 입력해주세요.')
			$('#recmDt').focus();
			return
		}
		
		var title = $('#title').val();
			
		if(title==''){
			alert('제목을 입력해주세요.')
			$('#title').focus();
			return
		}
	
		var cont = $('#cont').val();
		
		if(cont==''){
			alert('내용을 입력해주세요.')
			$('#cont').focus();
			return
		}
		
		// $("#emailAdr").removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0602/ech0602Update.do'/>").submit();
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
	
	$("#modi-pop").change(function(){
		html = '<tr>';
		html += '	<td colspan="5">이름을 검색해주세요.</td>';
		html += '</tr>';
		$("#stdBody").html(html);
	});

	var resultList;
	
	function fn_search(){
		$.ajax({
			url: "<c:url value='/qxsepmny/cmm/cmmAjaxSearchRsList.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '	<td>'+resultList[i].rsCd+'</td>';
					html += '	<td>'+resultList[i].rsName+'</td>';
					/* html += '	<td>'+resultList[i].branchCd+'</td>'; */
					html += '	<td>'+resultList[i].rsStdt+'</td>';
					html += '	<td>'+resultList[i].rsEndt+'</td>';
					html += '	<td>'+resultList[i].vendName+'</td>';
					html += '	<td>'+resultList[i].rsDrtNm+'</td>';
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
		
		//팝업에서 선택한 값을 설정한다.
		$("#receEmail").val(result.vmngEmail);
		$("#rsCd").val(result.rsCd);
		$("#rsNo").val(result.rsNo);
		$("#receNo").val(result.vmnghpNo);
		$("#branchCd").val(result.branchCd);
		$("#modi-pop").click();
		
		resultList = null;
	}
	
	function fn_resrdisp() {
		var ynresrdisp = $("input[name=sendmCls]:checked").val();
		
		switch(ynresrdisp) {
		case '1':
			$("#resrdisp").hide();
			break;
		case '2':
			$("#resrdisp").show();
			break;
		default : 
			$("#resrdisp").hide();
		}	

	}
	
	function fn_smsdisp() {
		var ynsmsdisp = $("input[name=sendsCls]:checked").val();
		
		switch(ynsmsdisp) {
		case '1':
			$("#smsdisp").hide();
			break;
		case '2':
			$("#smsdisp").show();
			break;
		default : 
			$("#smsdisp").hide();
		}	

	}
	
	function fn_smsspl() {
		alert($("select[name=smsspl]").val());
		$("#smscont").val($("select[name=smsspl]").val());	
	}
	
	function fn_emailspl() {		
		var jbString = $("select[name=emailspl]").val();
	    var jbSplit = jbString.split(';');
		$("#title").val(jbSplit[0]);
		$("#cont").val(jbSplit[1]);
	}	
	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>발송관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="발송관리"/>
	            <jsp:param name="dept2" value="보고서발송"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<form:form commandName="rm1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${rm1000mVO.corpCd}">
				<input type="hidden" id="recmNo" name="recmNo" value="${rm1000mVO.recmNo}">
				<input type="hidden" id="branchCd" name="branchCd" value="${rm1000mVO.branchCd}">
            <!-- 발송내용 -->
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                	<tr>
                		<th scope="row"><i>*</i>접수일자(필수)</th>
                        <td>
                			<div class="date_sec">
                			<span>
							<input name="recmDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${rm1000mVO.recmDt }" />" class="date required" title="접수일자" />
							 <label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
							</div>
						</td>
					</tr>	                
                    <tr>
                        <th scope="row"><i>*</i>연구선택</th>
                        <td>
                        	<input type="text" class="p30" id="rsCd" name="rsCd"/>
                           	<input type="hidden"  value="<c:out value="${rm1000mVO.rsNo }" />"  class="p30" id="rsNo" name="rsNo"/>
                            <!-- <a href="#" onclick="fn_pop(); return false;" class="btn_sub">연구조회</a> -->
                            <label for="modi-pop" class="btn_sub">연구조회</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">첨부보고서</th>
                        <td>
                        	<!-- 공통코드에서 보고서종류가 표시되고 사용자가 선택하면 연구과제에 등록된 보고서명칭이 표시된다 -->
                        	<!-- 보고서는 여러개 될 수 있다. 메일발송시 첨부된 파일을 보내야 한다. -->
                        	<input type="checkbox" name="fileNames" id="fileNames1" value="1"/>
                        	<label for="fileNames1">초안보고서</label>
                        	<input type="checkbox" name="fileNames" id="fileNames2" value="2"/>
                        	<label for="fileNames2">최종보고서</label>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><i>*</i>받는사람 이메일</th>
                        <td>
                        	<div class="email_address">
                        		<input type="text" value="<c:out value="${rm1000mVO.receEmail }" />" class="p30" id="receEmail" name="receEmail"/>*연구선택시 고객사 담당자의 이메일주소가 자동설정됩니다.
                        		<!-- 수신이메일은 다수가 된다 -->
                        		<%-- <textarea class="type03" id="receEmail" name="receEmail"><c:out value="${rm1000mVO.receEmail }" /></textarea>
                        		
                        		<a href="#" onclick="fn_pop2(); return false;" class="btn_sub">고객사조회</a> --%>
                        	</div>                        	
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                
                    <tr>
                        <th scope="row"><i>*</i>발송구분</th>
                        <td>
                        	<!-- 공통코드 발송구분 CM1340 -->
                        	<input type="radio" name="sendmCls" id="sendmCls1" value="1" checked="checked" onchange="fn_resrdisp()"/>
						    <label for="sendmCls1">즉시발송</label>
						    <input type="radio" name="sendmCls" id="sendmCls2" value="2" onchange="fn_resrdisp()"/>
						    <label for="sendmCls2">예약발송</label>
						    &nbsp;&nbsp;
						    <span id="resrdisp">
						    <div class="date_sec type02">
						    	<span>		
								<form:input path="resrDt" id="datepicker02" placeholder="0000-00-00" class="date required" title="발송예약일자"/>
								<label for="datepicker02" class="btn_cld">날짜검색</label>
								</span>
							</div>
							<select id="resrHr" name="resrHr" class="p10">
										<option value="" <c:if test="${rm1000mVO.resrHr eq '' }">selected="selected"</c:if> >선택</option>						
										<option value="01" <c:if test="${rm1000mVO.resrHr eq '01' }">selected="selected"</c:if> >01</option>
										<option value="02" <c:if test="${rm1000mVO.resrHr eq '02' }">selected="selected"</c:if> >02</option>
										<option value="03" <c:if test="${rm1000mVO.resrHr eq '03' }">selected="selected"</c:if> >03</option>
										<option value="04" <c:if test="${rm1000mVO.resrHr eq '04' }">selected="selected"</c:if> >04</option>
										<option value="05" <c:if test="${rm1000mVO.resrHr eq '05' }">selected="selected"</c:if> >05</option>
										<option value="06" <c:if test="${rm1000mVO.resrHr eq '06' }">selected="selected"</c:if> >06</option>
										<option value="07" <c:if test="${rm1000mVO.resrHr eq '07' }">selected="selected"</c:if> >07</option>
										<option value="08" <c:if test="${rm1000mVO.resrHr eq '08' }">selected="selected"</c:if> >08</option>
										<option value="09" <c:if test="${rm1000mVO.resrHr eq '09' }">selected="selected"</c:if> >09</option>
										<option value="10" <c:if test="${rm1000mVO.resrHr eq '10' }">selected="selected"</c:if> >10</option>
										<option value="11" <c:if test="${rm1000mVO.resrHr eq '11' }">selected="selected"</c:if> >11</option>
										<option value="12" <c:if test="${rm1000mVO.resrHr eq '12' }">selected="selected"</c:if> >12</option>
										<option value="13" <c:if test="${rm1000mVO.resrHr eq '13' }">selected="selected"</c:if> >13</option>
										<option value="14" <c:if test="${rm1000mVO.resrHr eq '14' }">selected="selected"</c:if> >14</option>
										<option value="15" <c:if test="${rm1000mVO.resrHr eq '15' }">selected="selected"</c:if> >15</option>
										<option value="16" <c:if test="${rm1000mVO.resrHr eq '16' }">selected="selected"</c:if> >16</option>
										<option value="17" <c:if test="${rm1000mVO.resrHr eq '17' }">selected="selected"</c:if> >17</option>
										<option value="18" <c:if test="${rm1000mVO.resrHr eq '18' }">selected="selected"</c:if> >18</option>
										<option value="19" <c:if test="${rm1000mVO.resrHr eq '19' }">selected="selected"</c:if> >19</option>
										<option value="20" <c:if test="${rm1000mVO.resrHr eq '20' }">selected="selected"</c:if> >20</option>
										<option value="21" <c:if test="${rm1000mVO.resrHr eq '21' }">selected="selected"</c:if> >21</option>
										<option value="22" <c:if test="${rm1000mVO.resrHr eq '22' }">selected="selected"</c:if> >22</option>
										<option value="23" <c:if test="${rm1000mVO.resrHr eq '23' }">selected="selected"</c:if> >23</option>
							</select>
							시
							&nbsp;&nbsp;
							<select id="resrMm" name="resrMm" class="p10">
										<option value="" <c:if test="${rm1000mVO.resrMm eq '' }">selected="selected"</c:if> >선택</option>						
										<option value="00" <c:if test="${rm1000mVO.resrMm eq '00' }">selected="selected"</c:if> >00</option>
										<option value="10" <c:if test="${rm1000mVO.resrMm eq '10' }">selected="selected"</c:if> >10</option>
										<option value="20" <c:if test="${rm1000mVO.resrMm eq '20' }">selected="selected"</c:if> >20</option>
										<option value="30" <c:if test="${rm1000mVO.resrMm eq '30' }">selected="selected"</c:if> >30</option>
										<option value="40" <c:if test="${rm1000mVO.resrMm eq '40' }">selected="selected"</c:if> >40</option>
										<option value="50" <c:if test="${rm1000mVO.resrMm eq '50' }">selected="selected"</c:if> >50</option>
							</select>
							분 
							</span>                    	
                        </td>
                    </tr>
                     <tr>
                        <th scope="row"><i>*</i>발송설정</th>
                        <td>
                        	<!-- 공통코드 발송설정 CM1330 -->
                        	<input type="radio" name="sendsCls" id="sendsCls1" value="1" checked="checked" onchange="fn_smsdisp()"/>
							<label for="sendsCls1">이메일</label>
							<input type="radio" name="sendsCls" id="sendsCls2" value="2" onchange="fn_smsdisp()" />
							<label for="sendsCls2">이메일+SMS</label>                      	         	
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">전송상태</th>
                        <td>
  				        	<!-- 전송상태(공통코드) CM4000M - CM1310  -->
							<select id="tstaCls" name="tstaCls" class="p30">
								<option value="" <c:if test="${rm1000mVO.tstaCls eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${cm1310}">
									<option value="${result.cd}"<c:if test="${result.cd eq rm1000mVO.tstaCls}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
	                    </td>
                    </tr>
                    <tr>    
                        <th scope="row">전송결과</th>
                        <td>
  				        	<!-- 전송결과(공통코드) CM4000M - CM1320  -->
							<select id="tsenCls" name="tsenCls" class="p30">
								<option value="" <c:if test="${rm1000mVO.tsenCls eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${cm1320}">
									<option value="${result.cd}"<c:if test="${result.cd eq rm1000mVO.tsenCls}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
                        	발송일자<input type="hidden" value="<c:out value="${rm1000mVO.sendDt }" />"  class="ta_l type02" id="sendDt" name="sendDt" / >						
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>발송제목</th>
                        <td>
	                        <div class="msg_select">
								<select id="emailspl" name="emailspl" onchange="fn_emailspl()">
									<option value="">자동입력</option>
									<c:forEach var="emailresult" items="${emailList}">									
										<option value="${emailresult.title};${emailresult.cont}">${emailresult.title}</option>
									</c:forEach>
								</select>
							</div>                        
                        	<input type="text" value="<c:out value="${rm1000mVO.title }" />"  class="ta_l type02" id="title" name="title"/>                        	         	
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>내용</th>
                        <td>
						<textarea id="cont" name="cont"><c:out value="${rm1000mVO.cont }" escapeXml="false"/></textarea>
						<script type="text/javascript">
						CKEDITOR.replace( 'Cont', {
						height: 300,
						filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath }/cmmn/ckeditor/uploadCkeditorFile.do'/>"
						});
						</script>          	
                        </td>
                    </tr>
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
                         </td>
                    </tr>
                     <tr>
                        <th scope="row">메모</th>
                        <td>
                        	<input type="text" value="<c:out value="${rm1000mVO.remk }" />"  class="ta_l type02" id="remk" name="remk"/ >                        	         	
                        </td>
                    </tr>
                </tbody>
            </table>
            <table id="smsdisp" class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">핸드폰 번호</th>
                        <td>
                        	<input type="text" value="<c:out value="${rm1000mVO.receNo }" />" class="p30" id="receNo" name="receNo"/>*연구선택시 고객사 담당자의 핸드폰번호가 자동설정됩니다. 핸드폰번호는 '-'없이 입력해주세요
                        
                       		<%-- <textarea class="type02 type03" id="receNo" name="receNo"><c:out value="${rm1000mVO.receNo }" /></textarea> --%>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">메시지</th>
                        <td>
	                        <div class="msg_select">
							<select id="smsspl" name="smsspl" onchange="fn_smsspl()">
								<option value="">자동입력</option>
								<c:forEach var="smsresult" items="${smsList}">									
									<option value="${smsresult.cont}">${smsresult.cont}</option>
								</c:forEach>
							</select>
							</div>
                       		<textarea class="type02 type03" id="smscont" name="smscont"><c:out value="${rm1000mVO.smscont }" /></textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- <p class="guide_txt">※ 수신자가 여러명일 경우 이메일, 핸드폰번호 사이에 콤마로 구분</p>  -->
            <!-- //발송내용 -->
            </form:form>
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_update(); return false;" >저장(발송)</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:800px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>연구과제조회</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>검색어</p>
						<span class="type02">
							<input type="text" name="searchWord" id="searchWord" class="input-data" placeholder="연구코드,연구명,고객사명을 검색해주세요" style="width: 400px;"/>
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
					<col style="width:20%" />
					<col style="width:auto%" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">연구코드</th>
						<th scope="col">연구명</th>
						<th scope="col">시작일자</th>
						<th scope="col">종료일자</th>
						<th scope="col">고객사명</th>
						<th scope="col">연구책임자</th>
					</tr>
				</thead>
				<tbody id="stdBody">
					<tr>
						<td colspan="6">검색된 내용이 없습니다.</td>
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
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->

</body>
</html>