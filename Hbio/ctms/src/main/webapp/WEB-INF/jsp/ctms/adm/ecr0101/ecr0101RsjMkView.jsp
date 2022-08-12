<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<%-- <c:import url="/EgovPageLink.do?link=adm/inc/incHead"/> --%>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead_crf"/>
<script type="text/javascript">

	$(function(){
		
		//DATA LOCK = 'Y' 인 경우 수정,삭제 불가
		var ynLock = '<c:out value="${rs1010mVO.dataLockYn}"/>';		
		if(ynLock=='Y') {
			$(".btnLockNonDisp").hide();
			$(".btnLockNonDisp").attr('onclick', '').unbind('click');
		}

		//사용일정관리를 위한 목록 선택
		$("#all-chk").change(function(){
			$("input[name=rsjSeq]").prop("checked", $(this).prop('checked'));
		});
	
	});

	//수정페이지로
	function fn_modify(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0212/ech0212RsjUseModify.do'/>").submit();
	}
	
	function fn_view(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0212/ech0212RsjUseView.do'/>").submit();
	}
	function fn_view2(setVal){
		$("#setVal").val(setVal);
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102View2.do'/>").submit();
	}


	function fn_pop_sms(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100201.do'/>"
					, 'SMS발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_pop_email(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100202.do'/>"
					, '이메일발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}

	function fn_pop_resv(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100301.do'/>"
					, '예약관리', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//건별 사용관리 팝업
	function fn_pop(corpCd, rsNo, rsjNo, chkDt){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0212/ech0212ChkmgPop.do'/>?corpCd="+corpCd+"&rsNo="+rsNo+"&rsjNo="+rsjNo+"&chkDt="+chkDt
				, '사용관리', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//연구대상자 목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ecr0101/ecr0101View.do'/>").submit();
	}
	
	//SMS관리 엑셀다운로드
	function fn_excelDown(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0212/ech0212RsjUseExcel.do'/>").submit();
	}
	
	// 사용일정 삭제
	function fn_del(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('삭제할 사용일정을  선택해 주세요.');
			return;
		}
		if(confirm('선택하신 사용일정을 삭제합니다. 삭제된 사용일정정보는 복구되지 않습니다 \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var rsjNo = $("#rsjNo").val();
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0212/ech0212AjaxSaveDel.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"rsjNo="+rsjNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
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
	
	function fn_saveChkDt(){
		if(confirm('연구대상자의 사용일정을 일괄 사용으로 처리합니다.  \r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var rsjNo = $("#rsjNo").val();
			var chkTrm = $("#chkTrm").val();
			var chkCnt = $("#chkCnt").val();
			var chkStdt = $("#chkStdt").val();
			var chkEndt = $("#chkEndt").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0212/ech0212AjaxSaveChkdt.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"rsjNo="+rsjNo+"&"+"chkTrm="+chkTrm+"&"+"chkCnt="+chkCnt+"&"+"chkStdt="+chkStdt+"&"+"chkEndt="+chkEndt+"&"+$("input[name=rsjSeq]:checked").serialize()
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
	//미리보기
	function fn_pdfView(attachSeq){
		//location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/pdfOpen.do'/>?fileId="+attachSeq;
		window.open("<c:out value='${pageContext.request.contextPath}/cmmn/file/pdfOpen.do'/>?fileId="+attachSeq);
	}
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}
	
	function fn_saveEtc(){
		if(confirm('연구대상자의 특이사항을 저장합니다. \r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var subNo = $("#subNo").val();
			var etc = $("#etc").val();
			//alert(etc);
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ecr0101/ecr0101AjaxSaveEtc.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"subNo="+subNo+"&"+"etc="+etc
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
	
	function fn_saveDout(){
		var doutDt = $("#datepicker01").val();
		if(doutDt == undefined || doutDt == '' ) {
			alert('중도탈락일자를 설정해주세요.');
			$("#doutDt").focus();
			return;
		}
		if(confirm('연구대상자의 중도탈락정보를 저장합니다. \r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var subNo = $("#subNo").val();
			var doutCont = $("#doutCont").val();
			
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ecr0101/ecr0101AjaxSaveDout.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"subNo="+subNo+"&"+"doutCont="+doutCont+"&"+"doutDt="+doutDt
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
	
	function fn_delDout(){
		if(confirm('연구대상자의 중도탈락정보를 삭제합니다. 삭제한 정보는 복구할 수 없습니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var subNo = $("#subNo").val();
			//alert(etc);
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ecr0101/ecr0101AjaxDelDout.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"subNo="+subNo+"&"+"etc="+etc
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
	
	
	//CRF 재작성(연구승인전까지 가능)
	function fn_reMkDtlCrf(corpCd, rsNo, tempNo, rsiNo, attachNo){
		if(confirm('작성완료된 CRF(단계)를 삭제합니다. 삭제된 CRF는 복구할 수 없으면 CRF작성 단계로 전환됩니다. \r\n재작성하시겠습니까?')){
			//var corpCd = $("#corpCd").val();
			//var rsNo = $("#rsNo").val();
			//var step1 = $("#step1").val();
			//var step2 = $("#step2").val();
			/* if(step1 > step2) {
				alert('설정한 연구차수를 확인해주세요.');
				return;
			} */
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ecr0101/ecr0101AjaxReMkDtlCrf.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"tempNo="+tempNo+"&"+"rsiNo="+rsiNo+"&"+"attachNo="+attachNo
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
	
	function enterkey() {
        if (window.event.keyCode == 13) {
             // 엔터키가 눌렸을 때 실행할 내용
             fn_saveDout();
        }
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<%-- <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/> --%>
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav_crf"/>
	<!-- container -->
	<div class="container">
		<!-- <h2>CRF작성관리</h2> -->
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<%-- <jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="CRF작성관리"/>
           	</jsp:include> --%>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1010mVO.corpCd }"/>
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1010mVO.rsNo }"/>
			<input type="hidden" id="rsjNo" name="rsjNo" value="${rs2010mVO.rsjNo }"/>
			<input type="hidden" id="subNo" name="subNo" value="${rs2010mVO.subNo }"/>
			<input type="hidden" id="genYn" name="genYn" value="${rs2010mVO.genYn }"/>
			<input type="hidden" id="setVal" name="setVal"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
			<input type="hidden" id="file" name="file"/>
			<!-- <div class="sub_title_area type02">
				<h4>연구관리</h4>
			</div> -->
			<!-- //서브타이틀 -->
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
						<th scope="row">연구코드</th>
						<td>
							<c:choose>
                          		<c:when test="${rs1010mVO.dataLockYn eq 'Y' }"><c:out value="${rs1010mVO.rsCd }" /><span style="color:red;">(Data Locked)</span></c:when>
                          		<c:when test="${rs1010mVO.dataLockYn eq 'N' }"><c:out value="${rs1010mVO.rsCd }" /></c:when>
                          	</c:choose>
						</td>					
						<th scope="row" class="bl">연구명</th>
						<td><c:out value="${rs1010mVO.rsName }" /></td>
					</tr>
					<tr>
						<th scope="row">이름</th>
						<td><c:out value="${rs2010mVO.rsjName }" /></td>					
						<th scope="row" class="bl">식별번호</th>
						<td><c:out value="${rs2010mVO.rsiNo }" /></td>
						
						
					</tr>
					<tr>						
						<th scope="row"><a href="#" onclick="fn_saveEtc(); return false;" class="type02" style="text-decoration: underline;">특이사항</a></th>
						<%-- <td colspan="3"><textarea><c:out value="${rs2010mVO.etc }" /></textarea></td> --%>
						<%-- <td colspan="3">
								<textarea class="type02 type03" id="etc" name="etc"><c:out value="${rs2010mVO.etc }" /></textarea>
							</td> --%>
						<td colspan="3"><input type	="text" value="<c:out value="${rs2010mVO.etc }" />"  class="input-data" id="etc" name="etc"/></td>						
					</tr>
					<tr>
						<th scope="row"><a href="#" onclick="fn_saveDout(); return false;" class="type02" style="text-decoration: underline;">중도탈락 </a>
						<c:choose>
                      		<c:when test="${rs2010mVO.doutYn eq 'Y' }"><a href="#" onclick="fn_delDout(); return false;" class="btn_sub2"><span style="color:red;">삭제 </span></a>
                      		</c:when>
	                    </c:choose>
						</th>						
						<%-- <td colspan="3"><textarea><c:out value="${rs2010mVO.etc }" /></textarea></td> --%>
						<%-- <td colspan="3">
								<textarea class="type02 type03" id="etc" name="etc"><c:out value="${rs2010mVO.etc }" /></textarea>
							</td> --%>
						<td colspan="3">
							<input type	="text" value="<c:out value="${rs2010mVO.doutCont }" />"  onkeyup="enterkey();" class="input-data" id="doutCont" name="doutCont"/>
							<%-- <c:choose>
									<c:when test="${rs2010mVO.doutYn eq 'Y' }">
									     <a href="#" onclick="fn_delDout(); return false;" class="btn_sub2 btn_sub2_del"><span>삭제</span></a>
									</c:when>						
						     </c:choose> --%>							
						</td>						
					</tr>					
					<tr>
						<th scope="row">중도탈락일</th> 
						<td colspan="3">
                            <div class="date_sec">
                                <span>
                                    <input name="doutDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${rs2010mVO.doutDt }" />" class="date required" title="중도탈락일" />
                                    <label for="datepicker01" class="btn_cld">날짜검색</label>
                                </span>
                            </div>
                        </td>
					</tr>
<%-- 					<tr>
						<th scope="row">연구상태</th>
						<td><c:out value="${rs1010mVO.rsstClsNm }" /></td>
						<th scope="row" class="bl">연구기간</th>
						<td><c:out value="${rs1010mVO.rsStdt }" />~<c:out value="${rs1010mVO.rsEndt }" /></td>
					</tr>
					<tr>
						<th scope="row">고객사명</th>
						<td><c:out value="${rs1010mVO.vendName }" /></td>
						<th scope="row" class="bl">담당자</th>
						<td><c:out value="${rs1010mVO.vmngName }" />,<c:out value="${rs1010mVO.vmnghpNo }" />,<c:out value="${rs1010mVO.vmngEmail }" /></td>
					</tr>
 --%>				</tbody>
			</table>
			<!-- //연구정보 -->			
            <!-- 버튼 -->
            <div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">목록</a>
				<!-- <a href="#" onclick="fn_modify(); return false;" class="btnLockNonDisp">수정</a> -->
			</div>
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<!-- <h4>작성정보</h4> -->
				<div>
					<!-- <a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_saveChkDt(); return false;" id="btnSaveChkdt">일괄사용처리</a>
					<a href="#" class="btn_sub btnLockNonDisp" onclick="fn_del(); return false;" id="btnDel">삭제</a>
					<a href="#" onclick="fn_excelDown(); return false;" class="btn_excel">엑셀</a> -->
				</div>
			</div>
            <!-- //사용정보 -->
			<!-- //테이블 상단 정보 -->
            <!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:5%" />
					<%-- <col style="width:6%" />
					<col style="width:8%" /> --%>
					<col style="width:20%" />
					<col style="width:8%" />
					<col style="width:10%" />
					<%-- <col style="width:auto" /> --%>
					<col style="width:10%" />
					<col style="width:10%" />
					<%-- <col style="width:15%" /> --%>
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" id="all-chk"/></th>
						<th scope="col">번호</th>
						<!-- <th scope="col">순번</th>
						<th scope="col">템플릿번호</th> -->
						<th scope="col">문건명</th>
						<th scope="col">작성여부</th>
						<th scope="col">작성일자</th>
						<!-- <th scope="col">특이사항</th> -->
						<th scope="col">관리</th>
						<th scope="col">미리보기</th>
						<!-- <th scope="col">다운로드</th> -->
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultList }" var="result">
						<tr>
						
							<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.chkDt }'/>"/></td>
							<td><c:out value="${result.rownum }"/></td>
<%-- 							<td><c:out value="${result.svSeq }"/></td>
							<td><c:out value="${result.tempNo }"/></td> --%>							
							<td><c:out value="${result.title }"/></td>
							<td>
								<c:choose>
	                          		<c:when test="${result.mkYn eq 'N' }"><span style="color:red;">미작성</span></c:when>
	                          		<c:when test="${result.mkYn eq 'Y' }">작성완료</c:when>
	                          	</c:choose>
	                        </td>							
                          	<td><c:out value="${result.mkDt }"/></td>
                          	<td>
                          		<c:set var="chkNo" value="${result.title }"/>
								<c:choose>
	                          		<c:when test="${result.mkYn eq 'N' }">
	                          			<!-- 탈락인 경우 작성버튼 숨기기 -->
	                          			<c:choose>
	                          				<c:when test="${rs2010mVO.doutYn eq 'Y' }">
	                          					<span style="color:red;">탈락</span>
	                          				</c:when>
	                          				<c:otherwise>
	                          					<c:choose>	                          					
				                          		<c:when test="${result.svyYn eq 'Y' and result.tempType eq '4080' }">
													<a href="#" onclick="fn_ubi_pop('detailForm', 'survey_3', 'corpCd#<c:out value='${result.corpCd }'/>#pageNo#<c:out value='${result.spageCnt }'/>#tpageNo#<c:out value='${result.tpageCnt }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#setRsNo#<c:out value='${result.setRsNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value="${result.rsiNo }"/>#tempType#<c:out value="${result.tempType2 }"/>#termType#<c:out value="${result.termType }"/>#type#survey_3'); return false;" class="btn_sub">피부자극</a>
												</c:when>		                          				
				                          		<c:when test="${result.svyYn eq 'Y' and result.tempType eq '4000' }">
													<a href="#" onclick="fn_ubi_pop('detailForm', 'survey_2','corpCd#<c:out value='${result.corpCd }'/>#pageNo#<c:out value='${result.spageCnt }'/>#tpageNo#<c:out value='${result.tpageCnt }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#setRsNo#<c:out value='${result.setRsNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value="${result.rsiNo }"/>#tempType#<c:out value="${result.tempType2 }"/>#termType#<c:out value="${result.termType }"/>#genYn#<c:out value="${rs2010mVO.genYn }"/>#age#<c:out value="${rs2010mVO.age }"/>#type#survey_2'); return false;" class="btn_sub">특성등록</a>
												</c:when>		                          				
				                          		<c:when test="${result.svyYn eq 'Y' and result.tempType ne '4000' }">
													<a href="#" onclick="fn_ubi_pop('detailForm', 'survey_1', 'corpCd#<c:out value='${result.corpCd }'/>#pageNo#<c:out value='${result.spageCnt }'/>#tpageNo#<c:out value='${result.tpageCnt }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#setRsNo#<c:out value='${result.setRsNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value="${result.rsiNo }"/>#tempType#<c:out value="${result.tempType2 }"/>#termType#<c:out value="${result.termType }"/>#type#survey_1'); return false;" class="btn_sub">설문등록</a>
												</c:when>																																		
												<c:when test="${result.svyYn eq 'N' }">
													<a href="#" onclick="fn_ubi_pop2('detailForm', <c:out value='${result.tempNo }'/>, 'corpCd#<c:out value='${result.corpCd }'/>#pageNo#<c:out value='${result.spageCnt }'/>#tpageNo#<c:out value='${result.tpageCnt }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#setRsNo#<c:out value='${result.setRsNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value='${result.rsiNo }'/>#type#crf#title#<c:out value='${result.title }'/>', '', <c:out value='${result.tempNo }'/>); return false;" class="btn_sub">작성</a>
		                          				</c:when>
		                          				</c:choose>
	                          				</c:otherwise>
	                          			</c:choose>
	                          		
		                          		<!-- 사용성 ,효능 설문 -->
		                          		<%-- <c:if test="${result.svyYn eq 'Y' and result.tempType ne '4000' }">
											<a href="#" onclick="fn_ubi_pop('detailForm', 'survey_1', 'corpCd#<c:out value='${result.corpCd }'/>#pageNo#<c:out value='${result.spageCnt }'/>#tpageNo#<c:out value='${result.tpageCnt }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#setRsNo#<c:out value='${result.setRsNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value="${result.rsiNo }"/>#tempType#<c:out value="${result.tempType2 }"/>#termType#<c:out value="${result.termType }"/>#type#survey_1'); return false;" class="btn_sub">설문등록</a>
										</c:if> --%>
										<!-- 피부특성 설문 -->
		                          		<%-- <c:if test="${result.svyYn eq 'Y' and result.tempType eq '4000' }">
											<a href="#" onclick="fn_ubi_pop('detailForm', 'survey_2', 'corpCd#<c:out value='${result.corpCd }'/>#pageNo#<c:out value='${result.spageCnt }'/>#tpageNo#<c:out value='${result.tpageCnt }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#setRsNo#<c:out value='${result.setRsNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value="${result.rsiNo }"/>#tempType#<c:out value="${result.tempType2 }"/>#termType#<c:out value="${result.termType }"/>#type#survey_2'); return false;" class="btn_sub">설문등록</a>
										</c:if>
									
										<c:if test="${result.svyYn eq 'N' }">
											<a href="#" onclick="fn_ubi_pop2('detailForm', <c:out value='${result.tempNo }'/>, 'corpCd#<c:out value='${result.corpCd }'/>#pageNo#<c:out value='${result.spageCnt }'/>#tpageNo#<c:out value='${result.tpageCnt }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#setRsNo#<c:out value='${result.setRsNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value='${result.rsiNo }'/>#type#crf#title#<c:out value='${result.title }'/>', '', <c:out value='${result.tempNo }'/>); return false;" class="btn_sub">작성</a>
										</c:if> --%>
	                          		</c:when>	                          		
	                          		<c:when test="${result.mkYn eq 'Y' }">
		                          		<c:set var="chkNo" value="${result.mapKey }"/>
										<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
										<div class="que_item ques_div_0">
											<a class ="btnLockNonDisp btn_sub" onclick="fn_filedownload('<c:out value="${resutlMt.attachNo }"/>','<c:out value="${resutlMt.boardType }"/>'); return false;" style="text-decoration: underline;" >다운로드</a>
										</div>
										</c:forEach>
	                          		</c:when>
	                          	</c:choose>
                          	</td>
                          	<td>
								<c:choose>
	                          		<c:when test="${result.mkYn eq 'N' }">
	                          			<p>파일없음</p>
	                          		</c:when>
	                          		<c:when test="${result.mkYn eq 'Y' }">
		                          		<c:set var="chkNo" value="${result.mapKey }"/>
										<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
											<a onclick="fn_pdfView('<c:out value="${resutlMt.attachNo }"/>'); return false;"  class="btn_sub">보기</a>
											<c:choose>
												<c:when test="${result.mkCls eq '1030'}">승인</c:when>
												<c:otherwise>
													<a onclick="fn_reMkDtlCrf('<c:out value="${result.corpCd }"/>','<c:out value="${result.rsNo }"/>','<c:out value="${result.tempNo }"/>','<c:out value="${result.rsiNo }"/>','<c:out value="${resutlMt.attachNo }"/>'); return false;"  class="btn_sub2"><span style="color:red; text-decoration: underline;">재작성</span></a>	
												</c:otherwise>
											</c:choose>
																	
										</c:forEach>
	                          		</c:when>
	                          	</c:choose>
                          	</td>
                          	<%-- <td>
									<c:if test="${result.mkYn eq 'N' }">
										<a href="#" onclick="fn_ubi_pop('detailForm', 'survey_1', 'corpCd#<c:out value='${result.corpCd }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value="${result.rsiNo }"/>#type#survey_1'); return false;" class="btn_sub">등록</a>
									</c:if>
									<c:if test="${result.answState ne 'FALSE' }">
										<!-- <a href="#" class="btn_sub">확인</a> -->
										<c:set var="chkNo" value="${result.mapKey }"/>
										<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
											<div class="que_item ques_div_0">
												<a href="#" class ="btnLockNonDisp" onclick="fn_filedownload('<c:out value="${resutlMt.attachNo }"/>','<c:out value="${resutlMt.boardType }"/>'); return false;" style="text-decoration: underline;"><c:out value="${resutlMt.orgFileName}"/></a>						
											</div>
										</c:forEach>
									</c:if>
								</td> --%>
                          	
                          	<%-- <td id="answTd_0">
								<c:set var="chkNo" value="${result.mapKey }"/>
								<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
									<div class="que_item ques_div_0">
										<a href="#" class ="btnLockNonDisp" onclick="fn_filedownload('<c:out value="${resutlMt.attachNo }"/>','<c:out value="${resutlMt.boardType }"/>'); return false;" style="text-decoration: underline;"><c:out value="${resutlMt.orgFileName}"/></a>						
									</div>
								</c:forEach>
							</td> --%>
						</tr>
					</c:forEach>
					<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="7">연구대상자의 작성 정보가 없습니다.</td>
						</tr>
					</c:if>
					
					
					
					
					<%-- <c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>					
								<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.chkDt }'/>"/></td>
								<td><c:out value="${result.rownum }"/></td>
								<td><c:out value="${result.title }"/></td>
								<td>작성여부</td>
								<td>2021-06-14</td>
								<td>
									<c:if test="${result.answState eq 'FALSE' }">
										<a href="#" onclick="fn_ubi_pop('frm', 'survey_1', 'corpCd#<c:out value='${result.corpCd }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${tempNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value="${result.rsiNo }"/>#type#survey_1'); return false;" class="btn_sub">등록</a>
									</c:if>
									<c:if test="${result.answState ne 'FALSE' }">
										<!-- <a href="#" class="btn_sub">확인</a> -->
										<c:set var="chkNo" value="${result.mapKey }"/>
										<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
											<div class="que_item ques_div_0">
												<a href="#" class ="btnLockNonDisp" onclick="fn_filedownload('<c:out value="${resutlMt.attachNo }"/>','<c:out value="${resutlMt.boardType }"/>'); return false;" style="text-decoration: underline;"><c:out value="${resutlMt.orgFileName}"/></a>						
											</div>
										</c:forEach>
									</c:if>
								</td>
							</tr>
						</c:forEach> --%>
					
				</tbody>			
			</table>
			</form:form>	
			<!-- //목록 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>