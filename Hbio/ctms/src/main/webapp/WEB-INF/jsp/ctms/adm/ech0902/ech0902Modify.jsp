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

		//수정인 경우 관리번호를 사용하지 못하게 처리해야 함
		var yndataRegnt = '<c:out value="${cs1020mVO.dataRegnt}"/>';
		if(!yndataRegnt=='') {
			$('#opNo').attr('disabled', 'true');
			$('#vendNo').attr('disabled', 'true');
			$('#vendName').attr('disabled', 'true');
			$('.dispNone').hide();
		} else {
			$('#opNo').attr('disabled', 'true');
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

	
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech10105/ech100501.do'/>"
					, '관리자 조회', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0902/ech0902List.do'/>";
	}	
	
	//function fn_update(){
		//if(fn_validate("detailForm")){
		 	//$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0902/ech0902Update.do'/>").submit();
		//}
	//}
	
	function fn_update(){
		var opDt = $('#datepicker01').val();			
		if(opDt==''){
			alert('견적일자를 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
		
		var empNo = $('#empNo').val();
		if(empNo==''){
			alert('견적담당자를 입력해주세요.')
			$('#empNo').focus();
			return;
		}
		
		var vendNo = $('#vendNo').val();
		if(vendNo==''){
			alert('고객사를 입력해주세요.')
			$('#vendNo').focus();
			return;
		}
		
		var opCls = $('#opCls').val();
		if(opCls==''){
			alert('견적분야를 입력해주세요.')
			$('#opCls').focus();
			return;
		}
		
		var opName = $('#opName').val();
		if(opName==''){
			alert('견적명을 입력해주세요.')
			$('#opName').focus();
			return;
		}
		
		var vmngName = $('#vmngName').val();
		if(vmngName==''){
			alert('수신담당자를 입력해주세요.')
			$('#vmngName').focus();
			return;
		}
		
		var tel = $('#vmnghpNo').val();
		if(tel != '') {
			var exptext = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
		    if(exptext.test(tel)==false){
		        alert("전화번호형식이 올바르지 않습니다.");
		        $('#vmnghpNo').focus();
		        return;
		    }	
		}
		
		var email = $('#vmngEmail').val();
		if(email != '') {
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		    if(exptext.test(email)==false){
		        //이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		        alert("이 메일형식이 올바르지 않습니다.");
		        $('#vmngEmail').focus();
		        return;
		    }	
		}
		
		$('#opNo').removeAttr('disabled');
		$('#vendNo').removeAttr('disabled');
		$('#vendName').removeAttr('disabled');
		
		$("#rsPay").val($("#rsPay").val().replace(/,/g,''));
		$("#rsPayvt").val($("#rsPayvt").val().replace(/,/g,''));
		$("#rsTpay").val($("#rsTpay").val().replace(/,/g,''));
				
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0902/ech0902Update.do'/>").submit();
	}
	
	function fn_setVat(){
		//alert("setVat");
		var setVat = $("#rsPay").val().replace(/,/g,'') * 0.1;
		var setVat2 = setVat.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#rsPayvt").val(setVat2);
		
		var setPay = $("#rsPay").val().replace(/,/g,'') * 1;
		var tPay = setPay + setVat;		
		var tPay2 = tPay.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#rsTpay").val(tPay2);
		
		//$("#nameTd").html(result.name);
		//$("#orgNmTd").html(result.orgNm);
		//$("#bracnNmTd").html(result.branchNm);
		//$("#rsClsNmTd").html(result.rsClsNm);		
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
		<h2>견적관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="영업관리"/>
	            <jsp:param name="dept2" value="견적관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>견적정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <form:form commandName="cs1020mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${cs1020mVO.corpCd}">
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
                        <th scope="row">견적번호(자동생성)</th>
                        <td colspan="3">
                        	<input type="text" value="<c:out value="${cs1020mVO.opCd }" />"  class="p20" id="opCd" name="opCd" readonly/>
                        </td>
                    </tr>
                    <tr>    
                        <th scope="row"><i>*</i>견적일자</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="opDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${cs1020mVO.opDt }" />" class="date required" title="견적일" />
                                    <label for="datepicker01" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="bl"><i>*</i>견적담당자</th>
                        <td>
                           	<input type="text" value="<c:out value="${cs1020mVO.empName }" />"  class="p30" id="empName" name="empName"/>
                           	<input type="hidden"  value="<c:out value="${cs1020mVO.empNo }" />"  class="p30" id="empNo" name="empNo"/>
                            <label for="modi-pop" class="btn_sub">조회</label>
                        </td>                        
                    </tr>
                    <tr>
                    	<th scope="row"><span class="dispNone"><i>*</i></span>고객사</th>
                        <td>
                            <input type="text" value="<c:out value="${cs1020mVO.vendName }" />"  class="p80" id="vendName" name="vendName"/>
							<input type="hidden" value="<c:out value="${cs1020mVO.vendNo }" />"  class="p80" id="vendNo" name="vendNo"/>
                            <label for="modi-pop2" class="btn_sub dispNone">조회</label>
                        </td>
                        <th scope="row" class="bl"><i>*</i>견적분야</th>
                        <td>
                        	<!-- 견적분야 목록(공통코드) CM4000M - CM1360  -->
							<select id="opCls" name="opCls" class="p30">
								<option value="" <c:if test="${cs1020mVO.opCls eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${cm1360}">
									<option value="${result.cd}"<c:if test="${result.cd eq cs1020mVO.opCls}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
						</td>	
					</tr>		
					<tr>
                        <th scope="row"><i>*</i>견적명</th>                        
                        <td colspan="3">
							<textarea class="type02 type03" id="opName" name="opName" placeholder="견적명을 입력하세요"><c:out value="${cs1020mVO.opName }" /></textarea>
						</td>                        
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>수신담당자</th>
                        <td>
							<input type="text" value="<c:out value="${cs1020mVO.vmngName }" />"  class="p50" id="vmngName" name="vmngName" />
						</td>
						<th scope="row" class="bl">연락처</th>
                        <td>
							<input type="text" value="<c:out value="${cs1020mVO.vmnghpNo }" />"  class="p50" id="vmnghpNo" name="vmnghpNo" />
						</td>
					</tr>
					<tr>
                        <th scope="row">메일주소</th>
                        <td colspan="3">
							<input type="text" value="<c:out value="${cs1020mVO.vmngEmail }" />"  class="p30" id="vmngEmail" name="vmngEmail" />
						</td>
					</tr>
					 <tr>
                        <th scope="row"><i>*</i>연구비</th>
                        <td>
                        	<%-- <form:input path="rsPay" class="input-data required txt-r" title="연구비" onkeyup="fn_number(this);"/> --%>
                        	<input type="text" value="<c:out value="${cs1020mVO.rsPay }" />"  class="p30 txt-r" id="rsPay" name="rsPay" onkeyup="fn_number(this);" onchange="fn_setVat()" />원
							<%-- <input type="text" value="<c:out value="${cs1020mVO.rsPay }" />"  class="p50" id="rsPay" name="rsPay" /> --%>
						</td>
						<th scope="row" class="bl">부가세</th>
                        <td>
                        	<input type="text" value="<c:out value="${cs1020mVO.rsPayvt }" />"  class="p30 txt-r" id="rsPayvt" name="rsPayvt" onkeyup="fn_number(this);"/>원
							<%-- <input type="text" value="<c:out value="${cs1020mVO.rsPayvt }" />"  class="p50" id="rsPayvt" name="rsPayvt" /> --%>
						</td>
					</tr>
					<tr>
                        <th scope="row">합계</th>
                        <td colspan="3">
                        	<input type="text" value="<c:out value="${cs1020mVO.rsTpay }" />"  class="p15 txt-r" id="rsTpay" name="rsTpay" onkeyup="fn_number(this);"/>원
							<%-- <input type="text" value="<c:out value="${cs1020mVO.rsTpay }" />"  class="p30" id="rsTpay" name="rsTpay" /> --%>
						</td>
					</tr>
					<tr>
                        <th scope="row">비고</th>                        
                        <td colspan="3">
							<textarea class="type02 type03" id="remk" name="remk"><c:out value="${cs1020mVO.remk }" /></textarea>
						</td>                        
                    </tr>
                    <tr>
						<th scope="row">담당지사</th>
						<td colspan="3">
							<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->
							<select id="branchCd" name="branchCd" class="p15">
								<option value="" <c:if test="${cs1020mVO.branchCd eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${branch}">
									<option value="${result.branchCd}"<c:if test="${result.branchCd eq cs1020mVO.branchCd}">selected="selected"</c:if>>${result.branchName}</option>
								</c:forEach>
							</select>	
						</td>
                    </tr>
                    <tr>
                        <th scope="row">관리번호</th>
                        <td colspan="3">
							<input type="text" value="<c:out value="${cs1020mVO.opNo }" />"  class="p20" id="opNo" name="opNo" />
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
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
