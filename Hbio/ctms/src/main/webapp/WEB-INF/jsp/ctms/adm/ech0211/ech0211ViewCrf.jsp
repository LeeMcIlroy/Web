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
	$(function(){
		//var svItem = document.getElementsByClassName('sv_div_'+num1);
		//var svLeng = svItem.length-1;
	
		//alert(svLeng);
	
		//for(var i=num; i<svLeng; i++){
			//$("#svSeq_"+i).val($("#svSeq_"+(i+1)).val());
			//$("#svCnt_"+i).val($("#svCnt_"+(i+1)).val());
			//$("#tempNo_"+i).val($("#tempNo_"+(i+1)).val());
			//$("#title_"+i).val($("#title_"+(i+1)).val());
			//* $("#content_"+i).val($("#content_"+(i+1)).val());
			//$("#datepicker"+i+"1").val($("#datepicker"+(i+1)+"1").val());
			//$("#datepicker"+i+"2").val($("#datepicker"+(i+1)+"2").val()); */
		//}
		var svItem = document.getElementsByClassName('chkcnt');
		//alert("start"+svItem.length);
		for(var i=0; i<svItem.length; i++) {
			$('#tempType_'+i).attr('disabled', 'true');
			$('#tempNo_'+i).attr('disabled', 'true');	
		}
		
		//DATA LOCK = 'Y' 인 경우 수정,삭제 불가
		var ynLock = '<c:out value="${rs1000mVO.dataLockYn}"/>';		
		if(ynLock=='Y') {
			$(".btnLockNonDisp").hide();
		}
	
	});

	function fn_add(num){
		var html = '';
		var svItem = document.getElementsByClassName('survey_info');
		var svLeng = svItem.length;
		//alert("svLeng= "+svLeng);
		
		html += '<div class="survey_info sv_div_'+svLeng+'">';
		html += '	<table class="tbl_view">';
		html += '		<colgroup>';
		html += '			<col style="width:15%" />';
		html += '			<col style="width:85%" />';
		html += '		</colgroup>';
		html += '		<tbody>';
		html += '			<tr>';
		html += '				<th scope="row">작성차수</th>';
		html += '				<td>';
		html += '					<select name="cr2110mVOList['+svLeng+'].svSeq" id="svSeq_'+svLeng+'" class="p10">';
		html += '						<option value="">선택</option>';
									<c:forEach begin="1" end="20" var="seq">
		html += '						<option value="<c:out value="${seq}"/>"><c:out value="${seq}"/></option>';
									</c:forEach>
		html += '					</select>';
		html += '					차';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th scope="row">템플릿 선택</th>';
		html += '				<td>';
		html += '					<select class="p20" name="cr2110mVOList['+svLeng+'].tempType" id="tempType_'+svLeng+'" onchange="fn_temp(\''+svLeng+'\'); return false;">';
		html += '						<option>템플릿구분</option>';
									<c:forEach items="${typeList}" var="type">
		html += '						<option value="<c:out value="${type.cd}"/>"><c:out value="${type.cdName}"/></option>';
									</c:forEach>
		html += '					</select>';
		html += '					<select name="cr2110mVOList['+svLeng+'].tempNo" id="tempNo_'+svLeng+'" class="p40">';
		html += '						<option value="">템플릿명</option>';
									<c:forEach items="${tempList }" var="temp">
		html += '						<option value="<c:out value="${temp.tempNo}"/>"><c:out value="${temp.tempNm}"/></option>';
									</c:forEach>
		html += '					</select>';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th scope="row">명칭</th>';
		html += '				<td>';
		html += '					<input type="text" name="cr2110mVOList['+svLeng+'].title" id="title_'+svLeng+'" class="type02 ta_l" />';
		html += '				</td>';
		html += '			</tr>';

		html += '			<tr>';
		html += '				<th scope="row">첨부파일</th>';
		html += '				<td colspan="3" id="file_td">';
		html += '					<div class="attach_sec type02 mb02" id="attachRpt'+svLeng+'_div">';
						<c:choose>
							<c:when test="${attachMap.attachRpt01 != null }">
		html += '			                	<div>';
		html += '			                    	<span><c:out value="${attachMap.attachRpt01.orgFileName }"/></span>';
		html += '			                        <a href="#" onclick="fn_delfile("attachRpt01",'<c:out value="${attachMap.attachRpt01.attachNo }"/>');">삭제</a>';
		html += '			                    </div>';
							</c:when>
							<c:otherwise>
		/* html += '			                	<input type="file" id="attachRpt'+svLeng+'" name="attachRpt'+svLeng+'" onchange="fn_file_add(\'attachRpt01\'); return false;"/>'; */
		html += '			                	<input type="file" id="attachRpt'+svLeng+'" name="attachRpt'+svLeng+'" onchange="fn_file_add(\'attachRpt'+svLeng+'\'); return false;"/>';
		html += '			                    <label for="attachRpt'+svLeng+'" id="attachRpt'+svLeng+'_label" class="btn_sub">CRF파일업로드</label>';  
							</c:otherwise>
						</c:choose>
		html += '			        </div>';
		html += '				</td>';
		html += '			</tr>';
		html += '			<tr>';
		html += '				<th scope="row"><i>*</i>구성쪽수</th>';                        
		html += '			    <td>';
		<%-- html += '					<input type="text" value="<c:out value="${cr2100mVO.upageCnt }" />" class="p10" id="upageCnt" name="upageCnt"> '; --%>
		html += '					<input name="cr2110mVOList['+svLeng+'].upageCnt" id="upageCnt_'+svLeng+'" class="type02 p10"/>';
/* 		html += '					<input name="cr2110mVOList['+svLeng+'].fileKey" id="fileKey_'+svLeng+'" class="type02 p10"/>'; */
		html += '				</td>';
		html += '			</tr>';
		html += '		</tbody>';
		html += '	</table>';
		html += '	<div class="sub_btn_area">';
		html += '		<a style="cursor:pointer;" onclick="fn_del('+svLeng+');">삭제</a>';
		html += '	</div>';
		html += '</div>';
		
		$("#survey_list").append(html);
		
		fn_date_picker('datepicker'+svLeng+'1');
		fn_date_picker('datepicker'+svLeng+'2');
	}
	
	function fn_del(num){
		if(confirm('선택하신 CRF정보를 삭제합니다. 삭제된 정보는 복구되지 않습니다. 삭제후 상단 "저장" 버튼을 눌려주세요. \r\n삭제하시겠습니까?')){
			var num1 = num - 1;
			//alert(num);
			//alert(num1);
			var svItem = document.getElementsByClassName('sv_div_'+num1);
			var svLeng = svItem.length-1;
			
			//alert(svLeng);
			
			for(var i=num; i<svLeng; i++){
				$("#svSeq_"+i).val($("#svSeq_"+(i+1)).val());
				$("#svCnt_"+i).val($("#svCnt_"+(i+1)).val());
				$("#tempNo_"+i).val($("#tempNo_"+(i+1)).val());
				$("#title_"+i).val($("#title_"+(i+1)).val());
				/* $("#content_"+i).val($("#content_"+(i+1)).val());
				$("#datepicker"+i+"1").val($("#datepicker"+(i+1)+"1").val());
				$("#datepicker"+i+"2").val($("#datepicker"+(i+1)+"2").val()); */
			}
			
			svItem[svLeng].remove();
	
		}
	}	
	
	function fn_update(){
		var svItem = document.getElementsByClassName('chkcnt');
		//alert("update"+svItem.length);		
		for(var i=0; i<svItem.length; i++) {
			$('#tempType_'+i).removeAttr('disabled');
			$('#tempNo_'+i).removeAttr('disabled');	
		}
		
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0211/ech0211Update.do'/>").submit();
	}
	
	function fn_temp(num){
		var tempType = $("#tempType_"+num).val();
		//alert(tempType);
		var html = '<option>템플릿명</option>';
		
		if(tempType != ''){
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0211/ajaxSelectTempList.do'/>"
				, type: "post"
				, data: "tempType="+tempType
				, dataType:"json"
				, success: function(data){
					var tempList = data.tempList;
					
					for(var i=0; i<tempList.length; i++){
						html += '<option value="'+tempList[i].tempNo+'">'+tempList[i].tempNm+'</option>';
					}
					
					$("#tempNo_"+num).html(html);
					
					var tempList2 = data.CT3020;
					var typeName = "";
					for(var i=0; i<tempList2.length; i++){
						if(tempList2[i].cd == tempType ) {
							typeName = tempList2[i].cdName;
						}
					}
					$("#title_"+num).val(typeName);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}else{
			$("#tempNo_"+num).html(html);
		}
	}
	
	/* function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0211/ech0211List.do'/>";
	} */
	
	//목록으로
	function fn_list(){
		$("#frm2").attr("action", "<c:url value='/qxsepmny/ech0211/ech0211List.do'/>").submit();
	}
	
	//첨부파일 삭제
	function fn_delfile(fileKey, seq){
		//alert(fileKey);
		//alert(seq);
		var fileKey1 = fileKey - 1;
		
		var html = '';
		if(seq != ''){
			html += '<input type="hidden" id="delFile" name="delFile" value="'+seq+'"/>';
		}
			html += '<input type="file" id="'+fileKey+'" name="'+fileKey+'" onchange="fn_file_add(\''+fileKey+'\'); return false;"/>';
			html += '<label for="'+fileKey+'" id="'+fileKey+'_label" class="btn_sub">CRF파일업로드(삭제후 자동생성)</label>';
		
		//fileKey1 = "01";
		$("#"+"attachRpt"+fileKey+"_div").html(html);
	}
	
	//첨부파일 추가
	function fn_file_add(fileKey){
		//alert("fileKey= "+fileKey);
		
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
			$("#fileKey_"+fileKey).val(fileKey);
        } 
	}
	
	//고객사 간편등록 팝업
	function fn_regVend(){
		if(confirm('새로운 CRF단계 간편정보를 등록합니다. 먼저 현재 작업중인 정보를 저장하시고 작업을 진행해주세요.\r\n진행 하시겠습니까?')){
			window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0211/ech0211VendmgPop.do'/>"
					, 'CRF단계등록', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
		}
	}
	
	//설정한 CRF보기
	function fn_viewCrf(frmName, type, argVal, exportNm, tempNo){
		
		if(type != 'survey_1' && type != 'survey_2'&& type != 'survey_3') {
			frmName = "/TMPL/"+frmName;
		}
	    var strUrl = "/ubi4/ubihtml.jsp?file="+frmName+"&arg="+encodeURIComponent(argVal);		
		
		$('#iframe').attr('src',strUrl);
		/* $('#iframe').attr('src',$(this).attr('data-url')); */
	}
	
	//수정페이지로
	function fn_update(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0211/ech0211Modify.do'/>").submit();
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- 검색조건유지 설정 -->
    <form:form commandName="searchVO" id="frm2" name="frm2">
    	<form:hidden path="searchCondition1"/>
    	<form:hidden path="searchCondition2"/>
    	<form:hidden path="searchCondition3"/>
    	<form:hidden path="searchCondition4"/>
    	<form:hidden path="searchCondition5"/>
    	<form:hidden path="searchCondition6"/>
    	<form:hidden path="searchCondition7"/>
    	<form:hidden path="searchCondition8"/>
    	<form:hidden path="searchYear"/>
    	<form:hidden path="searchWord"/>
    	<input type="hidden" id="file" name="file"/>
    </form:form>
    <!-- //검색조건유지 설정 -->
	<form:form commandName="rs1000mVO" id="frm" name="frm" method="post" enctype="multipart/form-data">
		<form:hidden path="rsNo"/>		
		<!-- <input type="hidden" id="rsNo" name="rsNo"/> -->
		<input type="hidden" id="tempNo" name="tempNo"/>
		<!-- container -->
		<div class="container">
			<h2>CRF설정관리</h2>
			<!-- contents -->
			<div class="contents">
				<!-- 타이틀 -->
				<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="eCRF관리"/>
		            <jsp:param name="dept2" value="CRF설정관리"/>
	           	</jsp:include>
				<!-- //타이틀 -->
				<!-- 서브타이틀 -->
				<div class="sub_title_area type02">
					<h4>기본정보</h4>
				</div>
				<!-- //서브타이틀 -->
	            <!-- 기본정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">연구코드</th>
							<td>
								<c:out value="${rs1000mVO.rsCd }"/>
								<c:choose>
									<c:when test="${rsFinSetChkCnt eq 0 }"><span style="color:red;">(CRF설정확인:연구종료확인서 미설정)</c:when>
								</c:choose>							
							</td>
							<th scope="row" class="bl">연구명</th>
							<td><c:out value="${rs1000mVO.rsName }"/></td>
						</tr>
						<tr>
							<th scope="row">eCRF상태</th>
							<td>
								<c:forEach items="${stateList }" var="state" varStatus="status">
									<form:radiobutton path="ecrfState" id="ecrfState_${status.count }" value="${state.cd }"/>
								    <label for="ecrfState_${status.count }"><c:out value="${state.cdName }"/></label>
							    </c:forEach>
							</td>
							<th scope="row" class="bl">총구성쪽수</th>
							<td><c:out value="${rs1000mVO.tpageCnt }"/></td>
						</tr>
					</tbody>
				</table>
				
	            <!-- //기본정보 -->
	            <!-- 버튼 -->
				<div class="btn_area">
					<a href="#" class="type02" onclick="fn_list(); return false;">목록</a>
					<!-- <a href="#" onclick="fn_update(); return false;" class="btnLockNonDisp">저장</a>
					<a href="#" onclick="fn_regVend(); return false;" class="btn_sub btnLockNonDisp" id="btn_regVend">CRF단계등록</a> -->
					<%-- <a href="#" class="type02" onclick="fn_ubi_pop3('frm2', '20210017', 'corpCd#<c:out value='${result.corpCd }'/>#rsNo#20210060#tempNo#20210034#type#crf#title#<c:out value='${result.tempNo }'/>', '', '20210017'); return false;" class="btn_sub">CRF보기</a> --%>
					<a href="#" class="type02" onclick="fn_update(); return false;" class="btn_sub">CRF설정</a>
				</div>
				<!-- //버튼 -->
				<table class="tbl_view">
                <colgroup>
                    <col style="width:30%" />
                    <col style="width:70%" />
                </colgroup>
                <tbody>
                <tr>
                <td style="vertical-align: top;">
				<table class="tbl_list">
					<colgroup>
						<col style="width:100%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">CRF단계</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="eCRF" items="${eCrfList}" varStatus="status">
						<tr>
							<td>
							<c:choose>
								<c:when test="${eCRF.svyYn eq 'N' }">
									<!-- 템플릿번호로 파일 찾기 -->
									<c:set var="chkNo" value="${eCRF.mapKey }"/>
									<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
										<div>
				                            <%-- <span><c:out value="${resutlMt.regFileName }"/></span> --%>
				                            <a href="#" onclick="fn_viewCrf('<c:out value='${resutlMt.regFileName }'/>', <c:out value='${eCRF.tempNo }'/>, 'corpCd#<c:out value='${eCRF.corpCd }'/>#tempNo#<c:out value='${eCRF.tempNo }'/>#type#crf#title#<c:out value='${eCRF.tempNo }'/>', '', <c:out value='${eCRF.tempNo }'/>); return false;" class="btn_sub">
				                            <c:out value='${eCRF.svSeq }'/>.<c:out value='${eCRF.title }'/></a>
											<%-- 구성쪽수:<c:out value='${eCRF.upageCnt }'/>  시작번호:<c:out value='${eCRF.spageCnt }'/> --%>
			                           	</div>													
									</c:forEach>									
								</c:when>
								<c:when test="${eCRF.svyYn eq 'Y' and eCRF.tempType eq '4080' and eCRF.mkType eq '2'}">
		                         	<a href="#" onclick="fn_viewCrf('rpt5.jef', 'survey_3', 'corpCd#<c:out value='${eCRF.corpCd }'/>#rsNo#<c:out value='${eCRF.rsNo }'/>#tempNo#<c:out value='${eCRF.tempNo }'/>#rsiNo#<c:out value='${eCRF.rsiNo }'/>#rsjNo#<c:out value='${eCRF.rsjNo }'/>#usrName#<c:out value="${eCRF.rsiNo }"/>#type#survey_3'); return false;" class="btn_sub">
		                         	<c:out value='${eCRF.svSeq }'/>.<c:out value='${eCRF.title }'/></a>
								</c:when>
	                         	<c:when test="${eCRF.svyYn eq 'Y' and eCRF.tempType ne '4000' }">
		                         	<a href="#" onclick="fn_viewCrf('rpt3_1.jef', 'survey_1', 'corpCd#<c:out value='${eCRF.corpCd }'/>#rsNo#<c:out value='${eCRF.rsNo }'/>#tempNo#<c:out value='${eCRF.tempNo }'/>#rsiNo#<c:out value='${eCRF.rsiNo }'/>#rsjNo#<c:out value='${eCRF.rsjNo }'/>#usrName#<c:out value="${eCRF.rsiNo }"/>#type#survey_1'); return false;" class="btn_sub">
		                         	<c:out value='${eCRF.svSeq }'/>.<c:out value='${eCRF.title }'/>-설문</a>
									<%-- 구성쪽수:<c:out value='${eCRF.upageCnt }'/>  시작번호:<c:out value='${eCRF.spageCnt }'/> --%>			                           			
								</c:when>
								<c:when test="${eCRF.svyYn eq 'Y' and eCRF.tempType eq '4000'}">
		                         	<a href="#" onclick="fn_viewCrf('rpt4.jef', 'survey_2', 'corpCd#<c:out value='${eCRF.corpCd }'/>#rsNo#<c:out value='${eCRF.rsNo }'/>#tempNo#<c:out value='${eCRF.tempNo }'/>#rsiNo#<c:out value='${eCRF.rsiNo }'/>#rsjNo#<c:out value='${eCRF.rsjNo }'/>#usrName#<c:out value="${eCRF.rsiNo }"/>#type#survey_2'); return false;" class="btn_sub">
		                         	<c:out value='${eCRF.svSeq }'/>.<c:out value='${eCRF.title }'/>-설문</a>
								</c:when>
							
							</c:choose>					
							</td>
						</tr>
					</c:forEach>
					<c:if test="${eCrfList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="1">CRF단계 정보가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
				<!-- //목록 -->
                </td>
                  	<td>
                  		<iframe id="iframe" width="700" height="1010" src=""></iframe>
					</td>
                </tr>
                </tbody>
                </table>
			</div>
			<!-- //contents -->
			<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
			<input type="hidden" name="cnt" id="cnt"/>
		</div>
		<!-- //container -->
	</form:form>
</div>	
<!-- //wrap -->
</body>
</html>