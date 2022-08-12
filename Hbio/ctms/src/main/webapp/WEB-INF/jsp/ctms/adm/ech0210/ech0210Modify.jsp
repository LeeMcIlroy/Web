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
		var yndataRegnt = '<c:out value="${cr2100mVO.dataRegnt}"/>';
		if(!yndataRegnt=='') {
			$('#tempNo').attr('disabled', 'true');
			$('#vendNo').attr('disabled', 'true');
			$('#vendName').attr('disabled', 'true');
			$('.dispNone').hide();
		} else {
			$('#tempNo').attr('disabled', 'true');
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
		var ynuseYn = '<c:out value="${cr2100mVO.useYn}"/>';		
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
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0210/ech0210List.do'/>";
	}	
	
	//function fn_update(){
		//if(fn_validate("detailForm")){
		 	//$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0210/ech0210Update.do'/>").submit();
		//}
	//}
	
	function fn_update(){
		var regDt = $('#datepicker01').val();			
		if(regDt==''){
			alert('등록일자를 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
		
		var empNo = $('#empNo').val();
		if(empNo==''){
			alert('담당자를 입력해주세요.')
			$('#empNo').focus();
			return;
		}
		
		var tempNm = $('#tempNm').val();
		if(tempNm==''){
			alert('템플릿명을 입력해주세요.')
			$('#tempNm').focus();
			return;
		}
		
		var tempType = $('#tempType').val();
		if(tempType==''){
			alert('템플릿분류를 입력해주세요.')
			$('#tempType').focus();
			return;
		}
		
		var stDate = $('#datepicker02').val();			
		if(stDate==''){
			alert('시작일자를 입력해주세요.')
			$('#datepicker02').focus();
			return;
		}
		
		var edDate = $('#datepicker03').val();			
		if(edDate==''){
			alert('종료일자를 입력해주세요.')
			$('#datepicker03').focus();
			return;
		}
		
		var useYn = $('#useYn').val();
		if(useYn==''){
			alert('사용여부를 입력해주세요.')
			$('#useYn').focus();
			return;
		}
		
		/* var upageCntYn = $('#upageCnt').val();
		if(upageCntYn==''){
			alert('구성쪽수를 입력해주세요.')
			$('#upageCntYn').focus();
			return;
		} */
		
		$('#tempNo').removeAttr('disabled');

		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0210/ech0210Update.do'/>").submit();
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
		<h2>CRF템플릿관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="CRF템플릿관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>CRF템플릿정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <form:form commandName="cr2100mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${cr2100mVO.corpCd}">
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
                        <th scope="row">템플릿번호(자동생성)</th>
                        <td colspan="3">
                        	<input type="text" value="<c:out value="${cr2100mVO.tempCd }" />"  class="p20" id="tempCd" name="tempCd" readonly/>
                        </td>
                    </tr>
                    <tr>    
                        <th scope="row"><i>*</i>등록일자</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="regDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${cr2100mVO.regDt }" />" class="date required" title="등록일" />
                                    <label for="datepicker01" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="bl"><i>*</i>담당자</th>
                        <td>
                           	<input type="text" value="<c:out value="${cr2100mVO.empName }" />"  class="p30" id="empName" name="empName"/>
                           	<input type="hidden"  value="<c:out value="${cr2100mVO.empNo }" />"  class="p30" id="empNo" name="empNo"/>
                            <label for="modi-pop" class="btn_sub">조회</label>
                        </td>                        
                    </tr>	
					<tr>
                        <th scope="row"><i>*</i>템플릿명</th>                        
                        <td>
							<input type="text" value="<c:out value="${cr2100mVO.tempNm }" />" class="type02 type03" id="tempNm" name="tempNm" placeholder="템플릿명을 입력하세요">
						</td>
						<th scope="row" class="bl"><i>*</i>템플릿분류</th>
                        <td>
                        	<!-- CRF템플릿 목록(공통코드) CM4000M - CT3020  -->
							<select id="tempType" name="tempType" class="p30">
								<option value="" <c:if test="${cr2100mVO.tempType eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${ct3020}">
									<option value="${result.cd}"<c:if test="${result.cd eq cr2100mVO.tempType}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
						</td>                        
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>시작일자</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="stDate" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${cr2100mVO.stDate }" />" class="date required" title="시작일" />
                                    <label for="datepicker02" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
                        <th scope="row" class="bl"><i>*</i>종료일자</th>
                        <td>
                            <div class="date_sec">
                                <span>
                                    <input name="edDate" id="datepicker03" placeholder="0000-00-00" value="<c:out value="${cr2100mVO.edDate }" />" class="date required" title="종료일" />
                                    <label for="datepicker03" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
					</tr>
					<tr>
						<th scope="row"><i>*</i>사용여부</th>
                        <td>
                        	<input type="radio" name="useYn" id="useYn1" value="Y" checked="checked"/>
						    <label for="rtYn1">사용</label>
						    <input type="radio" name="useYn" id="useYn2" value="N"/>
						    <label for="rtYn2">사용안함</label>
                        </td>
                        <th scope="row" class="bl">구성쪽수</th>                        
                        <td>
							<input type="text" value="<c:out value="${cr2100mVO.upageCnt }" />" class="p10" id="upageCnt" name="upageCnt">
						</td>
                    </tr>    
					<tr>
                        <th scope="row">비고</th>                        
                        <td colspan="3">
							<textarea class="type02 type03" id="remk" name="remk"><c:out value="${cr2100mVO.remk }" /></textarea>
						</td>                        
                    </tr>
                    <tr>
						<th scope="row">담당지사</th>
						<td colspan="3">
							<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->
							<select id="branchCd" name="branchCd" class="p15">
								<option value="" <c:if test="${cr2100mVO.branchCd eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${branch}">
									<option value="${result.branchCd}"<c:if test="${result.branchCd eq cr2100mVO.branchCd}">selected="selected"</c:if>>${result.branchName}</option>
								</c:forEach>
							</select>	
						</td>
                    </tr>
                    <tr>
                        <th scope="row">관리번호</th>
                        <td colspan="3">
							<input type="text" value="<c:out value="${cr2100mVO.tempNo }" />"  class="p20" id="tempNo" name="tempNo" />
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
                        </td>
                    </tr>
                </tbody>
            </table>
            <span><p style="color:red;"><i>*CRF파일 첨부시 구성쪽수(페이지수)는 자동 설정됩니다. 첨부파일의 구성쪽수가 많은 경우 저장시간이 지연될 수 있습니다. 잠시만 기다려주세요.</i></p></span>
            <span><p style="color:red;"><i>*설문(연구자대상자특성,사용성,효능설문)템플릿은 설문템플릿관리에서 등록하시면 됩니다.</i></p></span>
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
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
