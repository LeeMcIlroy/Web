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

		//수정인 경우 CS_NO 생성하는 컬럼을 사용하지 못하게 처리해야 함
		var yndataRegnt = '<c:out value="${ct3000mVO.dataRegnt}"/>';
		if(!yndataRegnt=='') {
			$('#astNo').attr('disabled', 'true');
			$('#btn_regVend').hide();
			//$('#btn_csChk').hide();
		} else {
			$('#astNo').attr('disabled', 'true');
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
		
		// 사용여부 Y 회신확인, N 미확인
		var ynuseYn = '<c:out value="${ct3000mVO.useYn}"/>';		
		switch (ynuseYn) {
		case 'Y':
			$("#useYn1").attr('checked', 'checked');
			
	    	break;
		case 'N':
			$("#useYn2").attr('checked', 'checked');
			break;
		default:
			console.log(`Sorry, we are out of ${expr}.`);
		}
		
		
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
					/* html += '	<td>'+resultList[i].vendNo+'</td>'; */
					html += '	<td>'+resultList[i].vendName+'</td>';
					html += '	<td>'+resultList[i].excutName+'</td>';
					html += '	<td>'+resultList[i].dispbregRsno+'</td>';
					html += '	<td>'+resultList[i].telno+'</td>';
					html += '	<td>'+resultList[i].mngName+'</td>';
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
		$("#rcsName").val(result.mngName);
		$("#rcsTel").val(result.mnghpNo);
		$("#rcsEmail").val(result.mngEmail);
		
		//$("#nameTd").html(result.name);
		//$("#orgNmTd").html(result.orgNm);
		//$("#bracnNmTd").html(result.branchNm);
		//$("#rsClsNmTd").html(result.rsClsNm);		
		
		$("#modi-pop2").click();
		
		resultList = null;
	}

	function fn_search3(){
		var searchWord = $("#searchWord2").val();
		var astNo = $("#astNo").val();
		var vendNo = $("#vendNo").val();
		if(vendNo == ''){
			alert('먼저 고객사를 선택해 주세요');
			return;
		}
		$.ajax({
			url: "<c:url value='/qxsepmny/ech0905/ech0905AjaxSearchCs.do'/>"
			, type: "post"
			, data: "searchWord="+searchWord+"&"+"vendNo="+vendNo+"&"+"astNo="+astNo
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select2('+i+'); return false;">';
					/* html += '	<td><input type="checkbox" name="csSeq" value="'+resultList[i].astNo+'""/></td>'; */
					html += '	<td>'+resultList[i].rownum+'</td>';
					html += '	<td>'+resultList[i].pchDt+'</td>';
					html += '	<td>'+resultList[i].empName+'</td>';
					html += '	<td>'+resultList[i].astClsNm+'</td>';
					html += '	<td>'+resultList[i].csCont+'</td>';
					html += '	<td>'+resultList[i].rcsName+'</td>';
					html += '	<td>'+resultList[i].rcsTel+'</td>';
					html += '	<td>'+resultList[i].rcsEmail+'</td>';
					html += '	<td>'+resultList[i].remk+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="9">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody3").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0905/ech0905List.do'/>";
	}	
		
	function fn_update(){
		var regDt = $('#datepicker01').val();			
		if(regDt==''){
			alert('구매일자를 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
		
		var empNo = $('#empNo').val();
		if(empNo==''){
			alert('책임자를 입력해주세요.')
			$('#empNo').focus();
			return;
		}
		
		var astName = $('#astName').val();
		if(astName==''){
			alert('자산명을 입력해주세요.')
			$('#astName').focus();
			return;
		}
		
		var astCls = $('#astCls').val();
		if(astCls==''){
			alert('자산분류를 입력해주세요.')
			$('#astCls').focus();
			return;
		}
		
		var fctvName = $('#fctvName').val();
		if(fctvName==''){
			alert('제조사를 입력해주세요.')
			$('#fctvName').focus();
			return;
		}
		
		var pchvName = $('#pchvName').val();
		if(pchvName==''){
			alert('구매처를 입력해주세요.')
			$('#fctvName').focus();
			return;
		}
		
		var mngName = $('#mngName').val();
		if(mngName==''){
			alert('구매처담당자를 입력해주세요.')
			$('#mngName').focus();
			return;
		}
		
		var useYn = $('#useYn').val();
		if(useYn==''){
			alert('사용여부를 입력해주세요.')
			$('#useYn').focus();
			return;
		}
		
		var tel = $('#pchvTel').val();
		if(tel != '') {
			var exptext = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
		    if(exptext.test(tel)==false){
		        alert("전화번호형식이 올바르지 않습니다.");
		        $('#rcsTel').focus();
		        return;
		    }	
		}
		
		var email = $('#pchvEmail').val();
		if(email != '') {
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		    if(exptext.test(email)==false){
		        //이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우
		        alert("이메일형식이 올바르지 않습니다.");
		        $('#rcsEmail').focus();
		        return;
		    }	
		}
		
		$('#astNo').removeAttr('disabled');
		
		$("#pchAmt").val($("#pchAmt").val().replace(/,/g,''));
		$("#pchAmtvt").val($("#pchAmtvt").val().replace(/,/g,''));
		$("#pchTamt").val($("#pchTamt").val().replace(/,/g,''));
				
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0905/ech0905Update.do'/>").submit();
	}
	
	//고객사 간편등록 팝업
	function fn_regVend(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0905/ech0905VendmgPop.do'/>?corpCd="+corpCd
				, '고객사간편등록', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_setVat(){
		var setVat = $("#pchAmt").val().replace(/,/g,'') * 0.1;
		var setVat2 = setVat.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#pchAmtvt").val(setVat2);
		
		var setPay = $("#pchAmt").val().replace(/,/g,'') * 1;
		var tPay = setPay + setVat;		
		var tPay2 = tPay.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#pchTamt").val(tPay2);
		
		//$("#nameTd").html(result.name);
		//$("#orgNmTd").html(result.orgNm);
		//$("#bracnNmTd").html(result.branchNm);
		//$("#rsClsNmTd").html(result.rsClsNm);		
		
		
	}
	
	function fn_setUseYn(){
		var regDt = $('#datepicker02').val();
		if(regDt == '') {
			$("#useYn1").attr('checked', 'checked');
		}else{
			$("#useYn2").attr('checked', 'checked');
		}
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>자산관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="영업관리"/>
	            <jsp:param name="dept2" value="자산관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>자산정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <form:form commandName="ct3000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${ct3000mVO.corpCd}">
            <!-- 상담정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                	<tr>
                        <th scope="row">자산코드(자동생성)</th>
                        <td colspan="3">
                        	<input type="text" value="<c:out value="${ct3000mVO.astCd }" />"  class="p20" id="astCd" name="astCd" readonly/>
                        </td>
                    </tr>
                    <tr>    
                        <th scope="row"><i>*</i>구매일자</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="pchDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${ct3000mVO.pchDt }" />" class="date required" title="구매일" />
                                    <label for="datepicker01" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="bl"><i>*</i>책임자</th>
                        <td>
                           	<input type="text" value="<c:out value="${ct3000mVO.empName }" />"  class="p30" id="empName" name="empName"/>
                           	<input type="hidden"  value="<c:out value="${ct3000mVO.empNo }" />"  class="p30" id="empNo" name="empNo"/>
                            <label for="modi-pop11" class="btn_sub">조회</label>
                        </td>                        
                    </tr>
                    <tr>
                    	<th scope="row"><i>*</i>자산명</th>
                        <td>
                            <input type="text" value="<c:out value="${ct3000mVO.astName }" />"  class="p60" id="astName" name="astName" />
                        </td>
                        <th scope="row" class="bl"><i>*</i>자산분류</th>
                        <td>
                        	<!-- 자산분류 목록(공통코드) CM4000M - CM1370  -->
							<select id="astCls" name="astCls" class="p30">
								<option value="" <c:if test="${ct3000mVO.astCls eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${cm1370}">
									<option value="${result.cd}"<c:if test="${result.cd eq ct3000mVO.astCls}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
						</td>	
					</tr>		
                    <tr>
                    	<th scope="row"><i>*</i>제조사</th>
                        <td colspan="3">
                            <input type="text" value="<c:out value="${ct3000mVO.fctvName }" />"  class="p30" id="fctvName" name="fctvName" />
                        </td>
                    </tr>
                    <tr>
                    	<th scope="row"><i>*</i>구매처</th>
                        <td>
                            <input type="text" value="<c:out value="${ct3000mVO.pchvName }" />"  class="p50" id="pchvName" name="pchvName" />
                        </td>
                        <th scope="row" class="bl"><i>*</i>구매처담당자</th>
                        <td>
                            <input type="text" value="<c:out value="${ct3000mVO.mngName }" />"  class="p50" id="mngName" name="mngName" />
                        </td>
                    </tr>
                    <tr>
                    	<th scope="row">구매처연락처</th>
                        <td>
							<input type="text" value="<c:out value="${ct3000mVO.pchvTel }" />"  class="p50" id="pchvTel" name="pchvTel" />
						</td>
                        <th scope="row" class="bl">구매처메일주소</th>
                        <td>
							<input type="text" value="<c:out value="${ct3000mVO.pchvEmail }" />"  class="p50" id="pchvEmail" name="pchvEmail" />
						</td>
					</tr>
                    <tr>
                        <th scope="row">구매가격</th>
                        <td>
                        	<input type="text" value="<c:out value="${ct3000mVO.pchAmt }" />"  class="p30 txt-r" id="pchAmt" name="pchAmt" onkeyup="fn_number(this);" onchange="fn_setVat()" />원
						</td>
						<th scope="row" class="bl">부가세</th>
                        <td>
                        	<input type="text" value="<c:out value="${ct3000mVO.pchAmtvt }" />"  class="p30 txt-r" id="pchAmtvt" name="pchAmtvt" onkeyup="fn_number(this);"/>원
						</td>
					</tr>
					<tr>
                        <th scope="row">합계</th>
                        <td colspan="3">
                        	<input type="text" value="<c:out value="${ct3000mVO.pchTamt }" />"  class="p15 txt-r" id="pchTamt" name="pchTamt" onkeyup="fn_number(this);"/>원
						</td>
					</tr>
                    <tr>    
                        <th scope="row">폐기일자</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="disDt" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${ct3000mVO.disDt }" />" class="date required" title="폐기일" onchange="fn_setUseYn()"/>
                                    <label for="datepicker02" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="bl"><i>*</i>사용여부</th>
                        <td>
                        	<input type="radio" name="useYn" id="useYn1" value="Y" checked="checked"/>
						    <label for="rtYn1">사용</label>
						    <input type="radio" name="useYn" id="useYn2" value="N"/>
						    <label for="rtYn2">사용안함</label>
                        </td>                        
                    </tr>
                    <tr>
                        <th scope="row">S/N</th>
                        <td colspan="3">
                        	<input type="text" value="<c:out value="${ct3000mVO.sNum }" />"  class="p20" id="sNum" name="sNum"/>
                        </td>
                    </tr>
					<tr>
                        <th scope="row">비고</th>                        
                        <td colspan="3">
							<textarea class="type02 type03" id="remk" name="remk"><c:out value="${ct3000mVO.remk }" /></textarea>
						</td>                        
                    </tr>
                    <tr>
						<th scope="row">담당지사</th>
						<td colspan="3">
							<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->
							<select id="branchCd" name="branchCd" class="p15">
								<option value="" <c:if test="${ct3000mVO.branchCd eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${branch}">
									<option value="${result.branchCd}"<c:if test="${result.branchCd eq ct3000mVO.branchCd}">selected="selected"</c:if>>${result.branchName}</option>
								</c:forEach>
							</select>	
						</td>
                    </tr>
                    <tr>
                        <th scope="row">관리번호</th>
                        <td colspan="3">
                        	<input type="text" value="<c:out value="${ct3000mVO.astNo }" />"  class="p20" id="astNo" name="astNo"/>
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
					<%-- <col style="width:15%" /> --%>
					<col style="width:auto%" />
					<col style="width:15%" />
					<col style="width:20%" />
					<col style="width:20%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<!-- <th scope="col">고객사번호</th> -->
						<th scope="col">고객사명</th>
						<th scope="col">대표자</th>
						<th scope="col">사업등록번호</th>
						<th scope="col">전화번호</th>
						<th scope="col">담당자</th>
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
