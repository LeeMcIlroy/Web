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
		var ynLock = '<c:out value="${rs1010mVO.dataLockYn}"/>';		
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
	
		if(confirm('선택하신 연구대상자들의 작성준비를 설정합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();			
			var step1 = "";
			var step2 = "";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0212/ech0212AjaxSaveStep.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
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
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0212/ech0212AjaxSaveStep2.do'/>"
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
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0212/ech0212AjaxSaveStep3.do'/>"
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
			window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0212/ech0212RsjUsePop.do'/>?corpCd="+corpCd+"&rsNo="+rsNo+"&rsjNo="+rsjNo
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
					window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0212/ech0212RsjUsePop.do'/>?corpCd="+corpCd+"&rsNo="+rsNo+"&rsjNo="+rsjNo+"&authkey="+authkey
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
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ecr0201/ecr0201RsjMkView.do'/>").submit();
	}
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ecr0201/ecr0201List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_modify(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0212/ech0212Modify.do'/>").submit();
	}
	
	//CRF작성관리 삭제
	function fn_delete(){
		if (confirm("제품사용 정보를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0212/ech0212Delete.do'/>").submit();
			
		}
	}
	
	//일괄 SMS 발송
	function fn_pop_sms(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해주세요.');
			return;
		}
		var corpCd = $("#corpCd").val();
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0212/ech0212SmsAllPop.do'/>?corpCd="+corpCd+"&"+$("input[name=rsjSeq]:checked").serialize()
					, 'SMS발송', 'width=840, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//CRF pdf 합치기
	function fn_pdfMerge(rsiNo,rsNo){
		$.ajax({
	
			type: "POST"
	        , url:  "<c:url value='/qxsepmny/ecr0201/pdfMerge.do'/>"    
	        , data: {  
	    	    "rsNo"  : rsNo,
	    	    "rsiNo" : rsiNo
	        }
	        , dataType:"json"	  
            , success: function (data) {
            	alert(data.message);
	         	var attachSeq1 = data.attachNo;
	         	var boardType1 = "SVYMerge";	
	         	location.reload();
	         	fn_filedownload(attachSeq1, boardType1);
	        }, 
	        error: function (jqXHR, textStatus, errorThrown) {
	           alert(jqXHR + ' ' + textStatus.msg);
	        }
		});	 
	}
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}
	
	//CRF템플릿 일괄다운로드
	function fn_ZipDownload(){
		if (confirm("CRF파일을 일괄 다운로드하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0212/ech0212ZipDownloadCrfFile.do'/>").submit();
			
		}
	}
	
	//미리보기
	function fn_pdfView(attachSeq){
		//location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/pdfOpen.do'/>?fileId="+attachSeq;
		window.open("<c:out value='${pageContext.request.contextPath}/cmmn/file/pdfOpen.do'/>?fileId="+attachSeq);
	}
	
	function fn_open2(){
		
		/* if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구계획서를 선택해 주세요.');
			return;
		} */
		$("#modi-pop").prop("checked", "true");
		
	}
	
	function fn_open3(){
		
		/* if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구계획서를 선택해 주세요.');
			return;
		} */
		$("#modi-pop").removeAttr("checked");
		
	}
	
	function fn_step(){
		if(confirm('새로운 연구대상자를 등록합니다. \r\n등록하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			//alert("rsNo= "+rsNo);
			var step1 = $("#step1").val(); //식별번호
			var step2 = $("#step2").val(); //이름
			//alert("step1= "+step1);
			//alert("step2= "+step2);
			/* if(step1 > step2) {
				alert('설정한 연구차수를 확인해주세요.');
				return;
			} */
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ecr0201/ecr0201AjaxSaveStep2.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2
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
	
	//CRF 재작성(연구종료확인서)
	function fn_reMkCrf(corpCd, rsNo, tempNo, rsiNo, attachNo){
		if(confirm('작성완료된 연구종료확인서를 삭제합니다. 삭제된 확인서는 복구할 수 없습니다. \r\n재작성하시겠습니까?')){
			//var corpCd = $("#corpCd").val();
			//var rsNo = $("#rsNo").val();
			//var step1 = $("#step1").val();
			//var step2 = $("#step2").val();
			/* if(step1 > step2) {
				alert('설정한 연구차수를 확인해주세요.');
				return;
			} */
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ecr0201/ecr0201AjaxReMkCrf.do'/>"
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
	
	function fn_dspDout(doutDt, doutCont){
		confirm("중도탈락일자: "+doutDt+" "+"\r\n사유= "+doutCont);		
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
			<!-- <div class="sub_title_area type02">
				<h4>연구정보</h4>
			</div> -->
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1010mVO.corpCd }"/>
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1010mVO.rsNo }"/>
			<input type="hidden" id="rsjNo" name="rsjNo"/>			
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
			<input type="hidden" id="file" name="file"/>			
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
						<th scope="row">연구상태</th>
						<td><c:out value="${rs1010mVO.rsstClsNm }" /></td>
						<th scope="row" class="bl">연구기간</th>
						<td><c:out value="${rs1010mVO.rsStdt }" />~<c:out value="${rs1010mVO.rsEndt }" /></td>
					</tr>
				</tbody>
			</table>
			<!-- //연구정보 -->
		</form:form>	
            <!-- 버튼 -->
            <div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">목록</a>
				<!-- <a href="#" onclick="fn_delete(); return false;" class="btnLockNonDisp">삭제</a>
				<a href="#" onclick="fn_modify(); return false;" class="btnLockNonDisp">수정</a> -->
			</div>
			<!-- 나중에 작성한다 -->
			<!-- //버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<!-- <h4>피험자정보</h4> -->
				<!-- 버튼 -->
				<div>
					<!-- <a href="#" onclick="fn_pop_sms(); return false;" class="btn_sub">SMS 발송</a> -->
					<!-- <a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_open(); return false;">작성설정</a> -->
					<!-- <a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_open2(); return false;">작성신규설정</a> -->
					<!-- <a href="#" onclick="fn_ZipDownload(); return false;" class="btn_sub">CRF일괄다운로드(zip)</a>
					<a href="#" class="btn_sub type02 btnLockNonDisp" onclick="fn_open2(); return false;">연구대상자등록</a> -->
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 피험자정보 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<%-- <col style="width:5%" /> --%>
					<col style="width:8%" />
					<col style="width:auto" />
					<%-- <col style="width:10%" />
					<col style="width:10%" /> --%>
					<col style="width:8%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:14%" />
					<col style="width:10%" />
					<%-- <col style="width:auto" /> --%>
					<col style="width:34%" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all-chk"/></th>
						<!-- <th scope="col">번호</th> -->
						<th scope="col">식별번호</th>
						<th scope="col">이름</th>
						<!-- <th scope="col">생년월일</th>
						<th scope="col">나이</th>
						<th scope="col">성별</th>
						<th scope="col">핸드폰</th> -->
						<th scope="col">중도탈락</th>
						<th scope="col">대상</th>
						<th scope="col">작성</th>
						<th scope="col">CRF</th>
						<th scope="col">종료확인</th>
						<!-- <th scope="col">비고</th> -->
						<th scope="col">연구종료확인서</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.rsiNo }'/>"/></td>
						<%-- <td><c:out value="${result.rownum }"/></td> --%>
						<td><c:out value="${result.rsiNo }"/></td>
						<%-- <td  onclick="fn_view('<c:out value="${result.corpCd }"/>','<c:out value="${result.rsNo }"/>','<c:out value="${result.rsjNo }"/>'); return false;" style="text-decoration: underline;"><a href="#" ><c:out value="${result.rsjName }"/></td> --%>
						<td><c:out value="${result.rsjName }"/></td>
						<td>
							<c:choose>
                          		<%-- <c:when test="${result.doutYn eq 'Y' }"><span style="color:red; text-decoration: underline;">중도탈락</span></c:when> --%>
                          		<c:when test="${result.doutYn eq 'Y' }"><a class ="btn_sub2" onclick="fn_dspDout('<c:out value="${result.doutDt }"/>','<c:out value="${result.doutCont }"/>'); return false;"  ><span style="color:red; ">탈락</a></c:when>
                        	</c:choose>
						</td>
						<%-- <td><c:out value="${result.brDt }"/></td>
						<td><c:out value="${result.age }"/></td>
						<td><c:out value="${result.genYnNm }"/></td>
						<td><c:out value="${result.hpNo }"/></td> --%>
						<td><c:out value="${result.tmplCnt }"/></td>
						<td><c:out value="${result.mkCnt }"/></td>
						<td>
							<!-- 생성된  CRF 파일 미리보기 -->
							<c:choose>
                         		<c:when test="${result.mkCnt eq 0 }">
                         			<p>파일없음</p>
                         		</c:when>
                         		<c:when test="${result.mkCnt > 0 }">
                          		<c:set var="chkNo" value="${result.mapKey2 }"/>
								<c:forEach items="${mtList2[chkNo] }" var="resultMt" varStatus="status">
									<a onclick="fn_pdfView('<c:out value="${resultMt.attachNo }"/>'); return false;"  class="btn_sub">보기</a>						
								</c:forEach>
                         		</c:when>
                         	</c:choose>
                        </td>
						<td>
							<!-- 연구종료확인서 작성/다운로드 대기/작성/다운로드 -->
                         	<c:set var="chkNo" value="${result.title }"/>
							<c:choose>
                          		<c:when test="${result.mkYn eq 'N' }">
                          			<%-- <c:set var="mkCnt" value="${result.mkCnt }"/>
                          			<c:if test="${result.tmplCnt - mkCnt > '1' }">대기</c:if>
                          			<c:if test="${result.tmplCnt - mkCnt <= '1'  }">
                          				<a class="btn_sub type02" href="#" onclick="fn_ubi_pop2('detailForm', <c:out value='${result.tempNo }'/>, 'corpCd#<c:out value='${result.corpCd }'/>#pageNo#<c:out value='${result.spageCnt }'/>#tpageNo#<c:out value='${result.tpageCnt }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#setRsNo#<c:out value='${result.setRsNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value='${result.rsiNo }'/>#type#crf#title#<c:out value='${result.title }'/>', '', <c:out value='${result.tempNo }'/>); return false;" class="btn_sub">작성</a>                          				
                          			</c:if> --%>
                          			
                          			<!-- 승인대기상태에서만 보이기 -->
                          			<c:choose>
                          				<c:when test="${rs1010mVO.mkCls eq '1020' }">
                          					<a class="btn_sub type02" href="#" onclick="fn_ubi_pop2('detailForm', <c:out value='${result.tempNo }'/>, 'corpCd#<c:out value='${result.corpCd }'/>#pageNo#<c:out value='${result.spageCnt }'/>#tpageNo#<c:out value='${result.tpageCnt }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#setRsNo#<c:out value='${result.setRsNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value='${result.rsiNo }'/>#type#crf#title#<c:out value='${result.title }'/>', '', <c:out value='${result.tempNo }'/>); return false;" class="btn_sub">작성</a>
                          				</c:when>
                          			</c:choose>
                          			
                          		</c:when>	                          		
                          		<c:when test="${result.mkYn eq 'Y' }"><span style="color:blue;">완료 </span>
	                          		<%-- <c:set var="chkNo" value="${result.mapKey }"/>
									<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
									<div class="que_item ques_div_0">
										<a class ="btnLockNonDisp btn_sub" onclick="fn_filedownload('<c:out value="${resutlMt.attachNo }"/>','<c:out value="${resutlMt.boardType }"/>'); return false;" style="text-decoration: underline;" >다운로드</a>
									</div>
									</c:forEach> --%>
                          		</c:when> 
                          	</c:choose>
                        </td>
						<%-- <td><c:out value="${result.etc }"/></td> --%>
						<td>
							<!-- 연구종료확인서 미리보기 -->
							<c:choose>
                         		<c:when test="${result.mkYn eq 'N' }">
                         			<p>파일없음</p>
                         		</c:when>
                         		<c:when test="${result.mkYn eq 'Y' }">
                          		<c:set var="chkNo" value="${result.mapKey }"/>
								<c:forEach items="${mtList[chkNo] }" var="resultMt" varStatus="status">
									<a class ="btnLockNonDisp btn_sub" onclick="fn_filedownload('<c:out value="${resultMt.attachNo }"/>','<c:out value="${resultMt.boardType }"/>'); return false;" style="text-decoration: underline;" >다운로드</a>
									<a onclick="fn_pdfView('<c:out value="${resultMt.attachNo }"/>'); return false;"  class="btn_sub">보기</a>
									<a onclick="fn_reMkCrf('<c:out value="${result.corpCd }"/>','<c:out value="${result.rsNo }"/>','<c:out value="${result.tempNo }"/>','<c:out value="${result.rsiNo }"/>','<c:out value="${resultMt.attachNo }"/>'); return false;"  class="btn_sub2"><span style="color:red; text-decoration: underline;">재작성</span></a>						
								</c:forEach>
                         		</c:when>
                         	</c:choose>
                        </td>					
					 </tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="9">연구대상자 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			<!-- //피험자정보 -->			
		</div>		
		<!-- //contents -->
				<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:600px; height:300px; top:60%; left:40%;">
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<!-- <h4>연구차수 설정</h4> -->
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
					<!-- <tr>
						<th scope="row">연구번호</th>
						<td colspan="3">
							<div>
								<input type="text" class="step1 p20" id="step3" class="required" title="연구번호"/>
							</div>
						</td>
					</tr> -->			
					<tr>
						<th scope="row">식별번호</th>
						<td>
							<div>
								<input type="text" class="step1 p5" id="step1" class="required" title="식별번호"/>
							</div>
						</td>
						<th scope="row" class="bl">이름</th>
						<td>
							<div>
								<input type="text" class="step2 p20" id="step2" class="required" title="이름"/>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- 버튼 -->
            <div class="btn_area">
            	<a href="#" onclick="fn_step(); return false;" >저장</a>
				<a href="#" class="type02" onclick="fn_open3(); return false;" >취소</a>
			</div>
		</div>
		</div>
		<!-- 팝업 -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
