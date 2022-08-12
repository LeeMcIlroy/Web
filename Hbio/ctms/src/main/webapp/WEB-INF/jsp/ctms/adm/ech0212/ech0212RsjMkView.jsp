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
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0212/ech0212View.do'/>").submit();
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
	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>CRF작성관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="CRF작성관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1010mVO.corpCd }"/>
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1010mVO.rsNo }"/>
			<input type="hidden" id="rsjNo" name="rsjNo" value="${rs2010mVO.rsjNo }"/>
			<input type="hidden" id="setVal" name="setVal"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
			<input type="hidden" id="file" name="file"/>
			<div class="sub_title_area type02">
				<h4>연구관리</h4>
			</div>
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
			<div class="sub_title_area ">
				<h4>연구대상자</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 연구대상자 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>					
					<tr>
						<th scope="row">이름</th>
						<td><c:out value="${rs2010mVO.rsjName }" />(<c:out value="${rs2010mVO.genYnNm }" />,<c:out value="${rs2010mVO.age }" />세)</td>					
						<th scope="row" class="bl">생년월일</th>
						<td><c:out value="${rs2010mVO.brDt }" /></td>
					</tr>
					<tr>
						<th scope="row">핸드폰</th>
						<td><c:out value="${rs2010mVO.hpNo }" /></td>
						<th scope="row" class="b1">식별번호</th>
						<td><c:out value="${rs2010mVO.rsiNo }" /></td>
					</tr>
					<%-- <tr>
						<th scope="row">특이사항</th>
						<td colspan="3"><textarea><c:out value="${rs2010mVO.etc }" /></textarea></td>
					</tr> --%>
				</tbody>
			</table>
			<!-- //연구대상자 -->
			
            <!-- 버튼 -->
            <div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">목록</a>
				<!-- <a href="#" onclick="fn_modify(); return false;" class="btnLockNonDisp">수정</a> -->
			</div>
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>작성정보</h4>
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
					<col style="width:6%" />
					<col style="width:8%" />
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
						<th scope="col">순번</th>
						<th scope="col">템플릿번호</th>
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
							<td><c:out value="${result.svSeq }"/></td>
							<td><c:out value="${result.tempNo }"/></td>
							<td><c:out value="${result.title }"/></td>
							<td>
								<c:choose>
	                          		<c:when test="${result.mkYn eq 'N' }"><span style="color:red;">미작성</span></c:when>
	                          		<c:when test="${result.mkYn eq 'Y' }">작성완료</c:when>
	                          	</c:choose>
	                        </td>
							<td><c:out value="${result.mkDt }"/></td>
                          	<%-- <td><c:out value="${result.remk }"/></td> --%>
                          	<td>
                          		<c:set var="chkNo" value="${result.title }"/>
								<c:choose>
	                          		<c:when test="${result.mkYn eq 'N' }"><a href="#" onclick="fn_ubi_pop2('detailForm', <c:out value='${result.tempNo }'/>, 'corpCd#<c:out value='${result.corpCd }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value='${result.rsiNo }'/>#type#crf#title#<c:out value='${result.title }'/>', '', <c:out value='${result.tempNo }'/>); return false;" class="btn_sub">작성</a></c:when>
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
											<a onclick="fn_pdfView('<c:out value="${resutlMt.attachNo }"/>'); return false;"  class="btn_sub">미리보기</a>						
										</c:forEach>
	                          		</c:when>
	                          	</c:choose>
                          	</td>
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
							<td class="nodata" colspan="10">연구대상자의 작성 정보가 없습니다.</td>
						</tr>
					</c:if>
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