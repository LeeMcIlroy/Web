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
		}

	});	

	function fn_view(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewIcf.do'/>").submit();
	}
	function fn_view2(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewCrf.do'/>").submit();
	}
	function fn_view3(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewSkinProp.do'/>").submit();
	}
	function fn_view4(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewSkinStim.do'/>").submit();
	}
	function fn_view5(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewItemUse.do'/>").submit();
	}
	function fn_view6(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ViewReport.do'/>").submit();
	}
	
	function fn_pop_icf1(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech040401.do'/>"
					, '개인정보동의서출력팝업', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	function fn_pop_icf2(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech040402.do'/>"
					, '연구참여동의서출력팝업', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401Modify.do'/>").submit();
	}
	
	//연구동의서 삭제
	function fn_delete(){
		if (confirm("연구동의서 정보를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401Delete.do'/>").submit();
			
		}
	}
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}
	
	// 설문결과 생성(사용성) 
	function fn_code1(termType){
		//alert(termType);
		/* if(confirm('연구대상자의 식별번호를 일괄 등록합니다.\r\n등록하시겠습니까?')){	
			$("#detailForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102RsiCodeBat.do'/>").submit();
		} */
		
		if(confirm('연구대상자의 사용성 설문결과를 일괄 생성합니다(중도탈락자 제외).기존 생성된 결과는 삭제됩니다. \r\n생성하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var step1 = "Y";
			var step2 = "Y";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0401/ech0401AjaxCrfSvyBat1.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+"termType="+termType
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
	
	// 설문결과 생성(효능) 
	function fn_code2(termType){
		//alert(termType);
		/* if(confirm('연구대상자의 식별번호를 일괄 등록합니다.\r\n등록하시겠습니까?')){	
			$("#detailForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/ech0102/ech0102RsiCodeBat.do'/>").submit();
		} */
		
		if(confirm('연구대상자의 효능 설문결과를 일괄 생성합니다(중도탈락자 제외). 기존 생성된 결과는 삭제됩니다. \r\n생성하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var step1 = "Y";
			var step2 = "Y";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0401/ech0401AjaxCrfSvyBat2.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+"termType="+termType
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
	
	//연구대상자 사용성설문 데이터 엑셀다운로드
	function fn_excelDown(svyType){
		if(confirm('출력하는 데이터건수에 따라 시간이 지체될 수 있습니다. \r\n진행하시겠습니까?')){
			if(svyType == '1') { //사용성설문
				$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ExcelCrfSvy1.do'/>").submit();	
			}else { //효능설문
				$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0401/ech0401ExcelCrfSvy2.do'/>").submit();
			}
			
		}
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>자료추출</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="자료추출"/>
	            <jsp:param name="dept2" value="시험결과추출(CRF설문)"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>연구정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1000mVO.corpCd eq ''?corpCd:rs1000mVO.corpCd}">
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1000mVO.rsNo eq ''?rsNo:rs1000mVO.rsNo}">
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
						<td><c:out value="${rs1000mVO.rsstClsNm }" />(연구대상자: <c:out value="${rs1000mVO.rsScnt }" />명)
							<c:choose>
								<c:when test="${rs1000mVO.doutCnt > 0 }">
							 		(중도탈락: <span style="color:red;"><c:out value="${rs1000mVO.doutCnt }" /></span>명)
							 	</c:when>
						 	</c:choose>
						 </td>
						<th scope="row" class="bl">연구기간</th>
						<td><c:out value="${rs1000mVO.rsStdt }" />~<c:out value="${rs1000mVO.rsEndt }" /></td>
					</tr>
					<%-- <tr>
						<th scope="row">고객사명</th>
						<td><c:out value="${rs1000mVO.vendName }" /></td>
						<th scope="row" class="bl">담당자</th>
						<td><c:out value="${rs1000mVO.vmngName }" />,<c:out value="${rs1000mVO.vmnghpNo }" />,<c:out value="${rs1000mVO.vmngEmail }" /></td>
					</tr> --%>
				</tbody>
			</table>
            <!-- //연구정보 -->
            </form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">목록</a>
			</div>
			<!-- //버튼 -->
            <!-- 탭버튼 -->
            <div class="tab_area tab04">
                <ul>
                    <!-- <li><a href="#" onclick="fn_view(); return false;" >동의서</a></li> -->
                	<li><a href="#" onclick="fn_view2(); return false;" class="on">CRF(사용성/효능설문)</a></li>
                	<li><a href="#" onclick="fn_view3(); return false;">연구대상자특성</a></li>
                	<li><a href="#" onclick="fn_view4(); return false;">피부자극</a></li>
                	<!-- <li><a href="#" onclick="fn_view5(); return false;">제품사용</a></li> -->
                	<li><a href="#" onclick="fn_view6(); return false;">결과보고서(안전성)</a></li>
                </ul>
            </div>
            <!-- //탭버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>사용성/효능설문 통계</h4>
				<!-- 버튼 -->
				<!-- <div>
					<select class="sub">
						<option>회차</option>
					</select>
					<a href="#" class="btn_sub">응답 종합통계 출력</a>
				</div> -->
				<!-- 버튼 -->
				<div>
					<!-- <a href="#" class="btn_sub">연구대상자 피부특성</a> -->
					<!-- <a href="#" onclick="fn_code1('1'); return false;" class="btn_sub btnLockNonDisp">사전사용성결과생성</a>
					<a href="#" onclick="fn_code1('2'); return false;" class="btn_sub btnLockNonDisp">사후사용성결과생성</a> -->
					<a href="#" onclick="fn_code1('0'); return false;" class="btn_sub btnLockNonDisp">사용성결과생성</a>
					<a href="#" onclick="fn_excelDown('1'); return false;" class="btn_excel">사용성엑셀</a>
					<!-- <a href="#" onclick="fn_code2('1'); return false;" class="btn_sub type02 btnLockNonDisp">사전효능결과생성</a>
					<a href="#" onclick="fn_code2('2'); return false;" class="btn_sub type02 btnLockNonDisp">사후효능결과생성</a> -->
					<a href="#" onclick="fn_code2('0'); return false;" class="btn_sub type02 btnLockNonDisp">효능결과생성</a>
					<a href="#" onclick="fn_excelDown('2'); return false;" class="btn_excel">효능엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 목록 -->
			<%-- <table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:auto" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:10%" />
					<col style="width:15%" />
					<col style="width:20%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<!-- <th scope="col">설문차수</th>
						<th scope="col">설문명</th> -->
						<th scope="col">이름</th>
						<th scope="col">생년월일</th>
						<th scope="col">나이</th>
						<th scope="col">핸드폰번호</th>
						<th scope="col">응답결과</th>
						
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td><c:out value="${result.rownum }"/></td>
						<!-- <td>설문차수</td>
						<td>설문명</td> -->
						<td><c:out value="${result.rsjName }"/></td>
						<td><c:out value="${result.brDt }"/></td>
						<td><c:out value="${result.age}"/></td>
						<td><c:out value="${result.hpNo}"/></td>
						<!-- <td><a href="#" onclick="fn_pop(); return false;" class="btn_sub">출력</a></td> -->
						<td>
							<c:set var="chkNo" value="${result.mapKey2 }"/>
							<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
								<div class="que_item ques_div_0">
									<a href="#" class ="btnLockNonDisp" onclick="fn_filedownload('<c:out value="${resutlMt.attachNo }"/>','<c:out value="${resutlMt.boardType }"/>'); return false;" style="text-decoration: underline;"><c:out value="${resutlMt.orgFileName}"/></a>						
								</div>
							</c:forEach>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="8">eCRF통계 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table> --%>
			<!-- //목록 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>