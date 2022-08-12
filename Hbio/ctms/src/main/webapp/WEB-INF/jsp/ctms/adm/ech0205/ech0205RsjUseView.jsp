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
		var ynLock = '<c:out value="${rs1000mVO.dataLockYn}"/>';		
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
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205RsjUseModify.do'/>").submit();
	}
	
	function fn_view(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205RsjUseView.do'/>").submit();
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
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205ChkmgPop.do'/>?corpCd="+corpCd+"&rsNo="+rsNo+"&rsjNo="+rsjNo+"&chkDt="+chkDt
				, '사용관리', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//연구대상자 목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205View.do'/>").submit();
	}
	
	//SMS관리 엑셀다운로드
	function fn_excelDown(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205RsjUseExcel.do'/>").submit();
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
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205AjaxSaveDel.do'/>"
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
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205AjaxSaveChkdt.do'/>"
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
	
	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>eCRF관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="제품사용관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1000mVO.corpCd }"/>
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1000mVO.rsNo }"/>
			<input type="hidden" id="chkTrm" name="chkTrm" value="${cr3200mVO.chkTrm }"/>
			<input type="hidden" id="chkCnt" name="chkCnt" value="${cr3200mVO.chkCnt }"/>
			<input type="hidden" id="rsjNo" name="rsjNo" value="${cr3210mVO.rsjNo }"/>
			<input type="hidden" id="chkStdt" name="chkStdt" value="${cr3210mVO.chkStdt }"/>
			<input type="hidden" id="chkEndt" name="chkEndt" value="${cr3210mVO.chkEndt }"/>
			<input type="hidden" id="setVal" name="setVal"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
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
                          		<c:when test="${rs1000mVO.dataLockYn eq 'Y' }"><c:out value="${rs1000mVO.rsCd }" /><span style="color:red;">(Data Locked)</span></c:when>
                          		<c:when test="${rs1000mVO.dataLockYn eq 'N' }"><c:out value="${rs1000mVO.rsCd }" /></c:when>
                          	</c:choose>
						</td>					
						<th scope="row" class="bl">연구명</th>
						<td><c:out value="${rs1000mVO.rsName }" /></td>
					</tr>
<%-- 					<tr>
						<th scope="row">연구상태</th>
						<td><c:out value="${rs1000mVO.rsstClsNm }" /></td>
						<th scope="row" class="bl">연구기간</th>
						<td><c:out value="${rs1000mVO.rsStdt }" />~<c:out value="${rs1000mVO.rsEndt }" /></td>
					</tr>
					<tr>
						<th scope="row">고객사명</th>
						<td><c:out value="${rs1000mVO.vendName }" /></td>
						<th scope="row" class="bl">담당자</th>
						<td><c:out value="${rs1000mVO.vmngName }" />,<c:out value="${rs1000mVO.vmnghpNo }" />,<c:out value="${rs1000mVO.vmngEmail }" /></td>
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
						<td><c:out value="${cr3210mVO.rsjName }" /></td>					
						<th scope="row" class="bl">생년월일</th>
						<td><c:out value="${cr3210mVO.brDt }" /></td>
					</tr>
					<tr>
						<th scope="row">나이</th>
						<td><c:out value="${cr3210mVO.age }" /></td>
						<th scope="row" class="bl">성별</th>
						<td><c:out value="${cr3210mVO.genYnNm }" /></td>
					</tr>
					<tr>
						<th scope="row">핸드폰</th>
						<td><c:out value="${cr3210mVO.hpNo }" /></td>
						<th scope="row" class="bl">체크응답수</th>
						<td><c:out value="${cr3210mVO.chkCnt }" /></td>
					</tr>
					<tr>
						<th scope="row">사용시작일</th>
						<td><c:out value="${cr3210mVO.chkStdt }" /></td>
						<th scope="row" class="bl">사용종료일</th>
						<td><c:out value="${cr3210mVO.chkEndt }" /></td>
					</tr>
					<tr>
						<th scope="row">아이템회수</th>
						<td>
							<c:choose>
	                       		<c:when test="${cr3210mVO.reYn eq 'N' }"><span style="color:red;">미회수</span></c:when>
	                       		<c:when test="${cr3210mVO.reYn eq 'Y' }">회수</c:when>
	                       		<c:when test="${cr3210mVO.reYn eq '' }">미확정</c:when>
	                       	</c:choose>
                       	</td>
						<th scope="row" class="bl">중지여부</th>
						<td>
							<c:choose>
	                       		<c:when test="${cr3210mVO.stYn eq 'N' }"><span style="color:blue;">진행</span></c:when>
	                       		<c:when test="${cr3210mVO.stYn eq 'Y' }"><span style="color:red;">중지</span></c:when>
	                       		<c:when test="${cr3210mVO.stYn eq '' }">미확정</c:when>
	                       	</c:choose>
						</td>
					</tr>
					<tr>
						<th scope="row">특이사항</th>
						<td colspan="3"><c:out value="${cr3210mVO.remk }" /></td>
					</tr>
				</tbody>
			</table>
			<!-- //연구대상자 -->
			</form:form>	
            <!-- 버튼 -->
            <div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">목록</a>
				<a href="#" onclick="fn_modify(); return false;" class="btnLockNonDisp">수정</a>
			</div>
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>사용정보</h4>
				<div>
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_saveChkDt(); return false;" id="btnSaveChkdt">일괄사용처리</a>
					<a href="#" class="btn_sub btnLockNonDisp" onclick="fn_del(); return false;" id="btnDel">삭제</a>
					<a href="#" onclick="fn_excelDown(); return false;" class="btn_excel">엑셀</a>
				</div>
			</div>
            <!-- //사용정보 -->
			<!-- //테이블 상단 정보 -->
            <!-- 목록 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:4%" />
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:auto" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" id="all-chk"/></th>
						<th scope="col">번호</th>
						<th scope="col">사용일자</th>
						<th scope="col">사용횟수</th>
						<th scope="col">체크1</th>
						<th scope="col">체크2</th>
						<th scope="col">체크3</th>
						<th scope="col">체크4</th>
						<th scope="col">체크5</th>
						<th scope="col">특이사항</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${resultList }" var="result">
						<tr>
							<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.chkDt }'/>"/></td>
							<td><c:out value="${result.rownum }"/></td>
							<td><c:out value="${result.chkDt }"/></td>
							<td><c:out value="${result.chkCnt }"/></td>
							<td>
								<c:choose>
	                          		<c:when test="${result.chk1 eq 'N' }"><span style="color:red;">미사용</span></c:when>
	                          		<c:when test="${result.chk1 eq 'Y' }">사용</c:when>
	                          	</c:choose>
                          	</td>
							<td>
								<c:choose>
	                          		<c:when test="${result.chk2 eq 'N' }"><span style="color:red;">미사용</span></c:when>
	                          		<c:when test="${result.chk2 eq 'Y' }">사용</c:when>
	                          	</c:choose>
                          	</td>
							<td>
								<c:choose>
	                          		<c:when test="${result.chk3 eq 'N' }"><span style="color:red;">미사용</span></c:when>
	                          		<c:when test="${result.chk3 eq 'Y' }">사용</c:when>
	                          	</c:choose>
                          	</td>
							<td>
								<c:choose>
	                          		<c:when test="${result.chk4 eq 'N' }"><span style="color:red;">미사용</span></c:when>
	                          		<c:when test="${result.chk4 eq 'Y' }">사용</c:when>
	                          	</c:choose>
                          	</td>
							<td>
								<c:choose>
	                          		<c:when test="${result.chk5 eq 'N' }">미사용<span style="color:red;"></span></c:when>
	                          		<c:when test="${result.chk5 eq 'Y' }">사용</c:when>
	                          	</c:choose>
                          	</td>
							<td><c:out value="${result.remk }"/></td>
							<td><a href="#" onclick="fn_pop('<c:out value="${result.corpCd }"/>','<c:out value="${result.rsNo }"/>','<c:out value="${result.rsjNo }"/>','<c:out value="${result.chkDt }"/>'); return false;" class="btnLockNonDisp btn_sub">사용관리</a></td>
						</tr>
					</c:forEach>
					<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="10">연구대상자의 사용 정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<!-- //목록 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
