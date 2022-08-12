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
	
		var ynVal = '<c:out value="${cr3200mVO.useYn}"/>';
		
		switch (ynVal) {
			case 'Y':
				$("#useY").attr('checked', 'checked');
		    	break;
			case 'N':
				$("#useN").attr('checked', 'checked');
		    	break;
		  	default:
		     	console.log(`Sorry, we are out of ${expr}.`);
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
		
		//연구대상자 체크시작일자-종료일자 설정을 위해 목록 선택
		$("#all-chk").change(function(){
			$("input[name=rsjSeq]").prop("checked", $(this).prop('checked'));
		});
		
		//DATA LOCK = 'Y' 인 경우 수정,삭제 불가
		var ynLock = '<c:out value="${rs1000mVO.dataLockYn}"/>';		
		if(ynLock=='Y') {
			$(".btnLockNonDisp").hide();
			//$(".btnLockNonDisp").attr('onclick', '').unbind('click');
				
		}
		
	});
	
	function fn_open(){
		
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해 주세요.');
			return;
		}
		$("#modi-pop").prop("checked", "true");
		
	}
	
	function fn_step(){
		if(confirm('선택하신 연구대상자들의 체크시작, 종료일자를 수정합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();			
			var step1 = $("#datepicker01").val();
			var step2 = $("#datepicker02").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205AjaxSaveStep.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					$("#modi-pop").click();
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	//연구대상자 건별 시작, 종료일 신규설정 
	function fn_open2(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해 주세요.');
			return;
		}
		if($("input[name=rsjSeq]:checked").length > 1){
			alert('연구대상자는 한명을 선택해 주세요.');
			return;
		}
		
		if(confirm('선택하신 연구대상자의 체크 시작, 종료일을 신규 설정합니다. 체크시작, 종료일은 연구과제의 사용정보기간과 동일하게 설정됩니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();			
			var step1 = $("#chkStdt").val();
			var step2 = $("#chkEndt").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205AjaxSaveStep2.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					//alert(data.status);
					if(data.status) {window.location.reload();}
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	//회수일괄등록
	function fn_open3(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해 주세요.');
			return;
		}
		
		if(confirm('선택하신 연구대상자들의 제품회수를 일괄 설정(회수)합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var step1 = $("#chkStdt").val();
			var step2 = $("#chkEndt").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205AjaxSaveStep3.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					alert(data.status);
					if(data.status) {window.location.reload();}
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
 	//연구대상자별 사용내역 팝업
	function fn_pop(corpCd, rsNo, rsjNo){
			window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205RsjUsePop.do'/>?corpCd="+corpCd+"&rsNo="+rsNo+"&rsjNo="+rsjNo
			, '제품사용체크결과', 'width=860, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	/* function fn_pop(corpCd, rsNo, rsjNo){
		 	//인증키를 획득한다.
		 	alert('get authkey');
			var authkey = "1234";
		 	
		 	$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/cmm/cmmAjaxGetAuthkey.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"rsjNo="+rsjNo
				, dataType:"json"
				, success: function(data){
					//String authkey = data.message;					
					alert(data.message);
				 	alert('get authkey2');
					//인증키를 전달한다. 		 
					window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205RsjUsePop.do'/>?corpCd="+corpCd+"&rsNo="+rsNo+"&rsjNo="+rsjNo+"&authkey="+authkey
					, '제품사용체크결과', 'width=860, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			}); 
		 	
	} */

		 
 	//연구대상자별 사용화면으로
	function fn_view(corpCd, rsNo, rsjNo){
		$("#corpCd").val(corpCd);
		$("#rsNo").val(rsNo);
		$("#rsjNo").val(rsjNo);
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205RsjUseView.do'/>").submit();
	}
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_modify(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205Modify.do'/>").submit();
	}
	
	//제품사용관리 삭제
	function fn_delete(){
		if (confirm("제품사용 정보를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205Delete.do'/>").submit();
			
		}
	}
	
	//일괄 SMS 발송
	function fn_pop_sms(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해주세요.');
			return;
		}
		var corpCd = $("#corpCd").val();
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0103/ech0103SmsAllPop.do'/>?corpCd="+corpCd+"&"+$("input[name=rsjSeq]:checked").serialize()
					, 'SMS발송', 'width=840, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
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
			<div class="sub_title_area type02">
				<h4>연구정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${cr3200mVO.corpCd }"/>
			<input type="hidden" id="rsNo" name="rsNo" value="${cr3200mVO.rsNo }"/>
			<input type="hidden" id="chkStdt" name="chkStdt" value="${cr3200mVO.chkStdt }"/>
			<input type="hidden" id="chkEndt" name="chkEndt" value="${cr3200mVO.chkEndt }"/>
			<input type="hidden" id="rsjNo" name="rsjNo"/>
			
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
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
					<tr>
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
				</tbody>
			</table>
			<!-- //연구정보 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>사용정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 사용체크정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>			
					<tr>
						<th scope="row">체크기간</th>
						<td>
							<div>
								<span>
									<c:out value="${cr3200mVO.chkStdt }" />
								</span>
								<em>~</em>
								<span>
									<c:out value="${cr3200mVO.chkEndt }" />
								</span>
							</div>
						</td>
						<th scope="row" class="bl">체크주기</th>
						<td>
							<c:out value="${cr3200mVO.chkTrm }" />
							&nbsp;일
						</td>
					</tr>
					<tr>
						<th scope="row">체크수</th>
						<td>
							<c:out value="${cr3200mVO.chkCnt }" />
							&nbsp;회
						</td>
						<th scope="row" class="bl">사용여부</th>
						<td>
							<input type="radio" name="useYn" id="useY" readonly/>
						    <label for="useY">사용</label>
						    <input type="radio" name="useYn" id="useN" readonly/>
						    <label for="useN">대기</label>
						
							<!--<c:out value="${cr3200mVO.useYn }" /> -->
						</td>
					</tr>
					<tr>
						<th scope="row">체크버튼명</th>
						<td colspan="3">
							<div class="check_btn" id="dsp1">
								<span>항목1</span>
								<c:out value="${cr3200mVO.dspName1 }" />
							</div>
							<div class="check_btn" id="dsp2">
								<span>항목2</span>
								<c:out value="${cr3200mVO.dspName2 }" />
							</div>
							<div class="check_btn" id="dsp3">
								<span>항목3</span>
								<c:out value="${cr3200mVO.dspName3 }" />
							</div>
							<div class="check_btn" id="dsp4">
								<span>항목4</span>
								<c:out value="${cr3200mVO.dspName4 }" />
							</div>
							<div class="check_btn" id="dsp5">
								<span>항목5</span>
								<c:out value="${cr3200mVO.dspName5 }" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">시험물질</th>
						<td colspan="3">
							<c:out value="${cr3200mVO.itemName }" />
						</td>
					</tr>
					<tr>
						<th scope="row">전달사항</th>
						<td colspan="3">
							<textarea class="type02 type03"><c:out value="${cr3200mVO.cont }" /></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //사용체크정보 -->
		</form:form>	
            <!-- 버튼 -->
            <div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_delete(); return false;" class="btnLockNonDisp">삭제</a>
				<a href="#" onclick="fn_modify(); return false;" class="btnLockNonDisp">수정</a>
			</div>
			<!-- 나중에 작성한다 -->
			<!-- //버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>피험자정보</h4>
				<!-- 버튼 -->
				<div>
					<a href="#" onclick="fn_pop_sms(); return false;" class="btn_sub">SMS 발송</a>
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_open(); return false;">일정저장</a>
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_open2(); return false;">일정신규등록</a>
					<a href="#" class="btn_sub btnLockNonDisp" onclick="fn_open3(); return false;">회수등록</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 피험자정보 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all-chk"/></th>
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">생년월일</th>
						<th scope="col">나이</th>
						<th scope="col">성별</th>
						<th scope="col">핸드폰</th>
						<th scope="col">체크시작일</th>
						<th scope="col">체크종료일</th>
						<th scope="col">제품회수</th>
						<th scope="col">중지여부</th>
						<th scope="col">사용횟수</th>
						<th scope="col">미사용</th>
						<th scope="col">체크결과</th>
						<th scope="col">특이사항</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>					
						<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.rsNo }'/><c:out value='${result.rsjNo }'/>"/></td>
						<td><c:out value="${result.rownum }"/></td>
						<td onclick="fn_view('<c:out value="${result.corpCd }"/>','<c:out value="${result.rsNo }"/>','<c:out value="${result.rsjNo }"/>'); return false;" style="text-decoration: underline;"><a href="#" ><c:out value="${result.rsjName }"/></a></td>
						<td><c:out value="${result.brDt }"/></td>
						<td><c:out value="${result.age}"/></td>
						<td><c:out value="${result.genYnNm}"/></td>
						<td><c:out value="${result.hpNo}"/></td>
						<td><c:out value="${result.chkStdt}"/></td>
						<td><c:out value="${result.chkEndt}"/></td>
						<td>
							<c:choose>
								<c:when test="${result.reYn eq ''}">회수정보없음</c:when>
								<c:when test="${result.reYn eq 'Y'}">회수</c:when>
								<c:when test="${result.reYn eq 'N'}">미회수</c:when>
							</c:choose>
						</td>	
						<%-- <td><c:out value="${result.reYn}"/></td> --%>
						<td>
							<c:choose>
								<c:when test="${result.stYn eq ''}">미확정</c:when>
								<c:when test="${result.stYn eq 'Y'}"><span style="color:red;">중지</span></c:when>
								<c:when test="${result.stYn eq 'N'}">진행</c:when>
							</c:choose>
						</td>
						<%-- <td><c:out value="${result.stYn}"/></td> --%>
						<td><c:out value="${result.chkCnt}"/></td>
						<td><c:out value="${result.unUseCnt}"/></td>
						<td>
							<c:choose>
								<c:when test="${result.chkCnt > 0}"><a onclick="fn_pop('<c:out value="${result.corpCd }"/>','<c:out value="${result.rsNo }"/>','<c:out value="${result.rsjNo }"/>'); return false;" class="btn_sub">확인</a></c:when>
								<c:when test="${result.chkCnt < 1}">사용정보없음</c:when>
							</c:choose>
						</td>
						<td><c:out value="${result.remk}"/></td>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="15">연구대상자 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			<!-- //피험자정보 -->			
		</div>
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>사용체크기간 설정</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 사용체크정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>			
					<tr>
						<th scope="row">시작일자</th>
						<td>
							<div>
								<input name="step1" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${cr3200mVO.chkStdt }" />" class="required" title="체크시작일자" />
							</div>
						</td>
						<th scope="row" class="bl">종료일자</th>
						<td>
							<div>
								<input name="step1" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${cr3200mVO.chkStdt }" />" class="required" title="체크시작일자" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- 버튼 -->
            <div class="btn_area">
            	<a href="#" onclick="fn_step(); return false;" >저장</a>
            	<label for="modi-pop" class="type02 btn-cancel">취소</label>			
			</div>
		</div>
		</div>
		<!-- 팝업 -->
		<!-- //contents -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>