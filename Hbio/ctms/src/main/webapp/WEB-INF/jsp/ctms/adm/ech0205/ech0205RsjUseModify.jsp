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
		
 		var ynreYn = '<c:out value="${cr3210mVO.reYn}"/>';
		
		switch(ynreYn) {
		case "Y" :  
			$("#reYn1").attr('checked', 'checked');
			break;
		case "N" :  
			$("#reYn2").attr('checked', 'checked');
			break;
		}
				
		//if(ynuseYn == 'Y'){
			//$("#useY").attr('checked', 'checked');
		//}else{
			//$("#useN").attr('checked', 'checked');
		//}
	});	
	
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205List.do'/>";
	}
	
	function fn_update(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		/* var regDt = $('#datepicker01').val();
			
		if(regDt==''){
			alert('체크시작일자를 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
	
		var regDt = $('#datepicker02').val();
		
		if(regDt==''){
			alert('체크종료일자를 입력해주세요.')
			$('#datepicker02').focus();
			return;
		}
		
		var chkTrm = $('#chkTrm').val();
		
		if(chkTrm==''){
			alert('체크주기를 입력해주세요.')
			$('#chkTrm').focus();
			return;
		}
		
		var chkCnt = $('#chkCnt').val();
		
		if(chkCnt==''){
			alert('체크수를 입력해주세요.')
			$('#chkCnt').focus();
			return;
		}
		
		switch(chkCnt) {
		case "1" :  
			if($("#dspName1").val()==''){
				alert('항목1을  입력해주세요.')
				$("#dspName1").focus();
				return;
			}
			break;
		case "2" :  
			if($("#dspName1").val()==''){
				alert('항목1을  입력해주세요.')
				$("#dspName1").focus();
				return;
			}
			if($("#dspName2").val()==''){
				alert('항목2을  입력해주세요.')
				$("#dspName2").focus();
				return;
			}
			break;
		case "3" :  
			if($("#dspName1").val()==''){
				alert('항목1을  입력해주세요.')
				$("#dspName1").focus();
				return;
			}
			if($("#dspName2").val()==''){
				alert('항목2을  입력해주세요.')
				$("#dspName2").focus();
				return;
			}
			if($("#dspName3").val()==''){
				alert('항목3을  입력해주세요.')
				$("#dspName3").focus();
				return;
			}
			
			break;
		case "4" :  
			if($("#dspName1").val()==''){
				alert('항목1을  입력해주세요.')
				$("#dspName1").focus();
				return;
			}
			if($("#dspName2").val()==''){
				alert('항목2을  입력해주세요.')
				$("#dspName2").focus();
				return;
			}
			if($("#dspName3").val()==''){
				alert('항목3을  입력해주세요.')
				$("#dspName3").focus();
				return;
			}
			if($("#dspName4").val()==''){
				alert('항목4을  입력해주세요.')
				$("#dspName4").focus();
				return;
			}
			break;
		case "5" :  
			if($("#dspName1").val()==''){
				alert('항목1을  입력해주세요.')
				$("#dspName1").focus();
				return;
			}
			if($("#dspName2").val()==''){
				alert('항목2을  입력해주세요.')
				$("#dspName2").focus();
				return;
			}
			if($("#dspName3").val()==''){
				alert('항목3을  입력해주세요.')
				$("#dspName3").focus();
				return;
			}
			if($("#dspName4").val()==''){
				alert('항목4을  입력해주세요.')
				$("#dspName4").focus();
				return;
			}
			if($("#dspName5").val()==''){
				alert('항목5을  입력해주세요.')
				$("#dspName5").focus();
				return;
			}
			break;
		default :
			$("#dsp1").hide;
			$("#dspName1").attr('disabled', true);
			$("#dsp2").hide;
			$("#dspName2").attr('disabled', true);
			$("#dsp3").hide;
			$("#dspName3").attr('disabled', true);
			$("#dsp4").hide;
			$("#dspName4").attr('disabled', true);
			$("#dsp5").hide;
			$("#dspName5").attr('disabled', true);
		} */
		
		//$("#emailAdr").removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0205/ech0205RsjUseUpdate.do'/>").submit();
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
			<form:form commandName="cr3210mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1000mVO.corpCd }"/>
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1000mVO.rsNo }"/>			
			<input type="hidden" id="rsjNo" name="rsjNo" value="${cr3210mVO.rsjNo }"/>
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>연구정보</h4>
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
				<h4>연구대상자</h4>
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
							<input type="radio" name="reYn" id="reYn1" value="Y"/>
						    <label for="useY">회수</label>
						    <input type="radio" name="reYn" id="reYn2" value="N"/>
						    <label for="useN">미회수</label>
						</td>
						<th scope="row" class="bl">중지여부</th>
						<td>
							<select id="stYn" name="stYn" class="p20">
								<option value="" <c:if test="${cr3210mVO.stYn eq '' }">selected="selected"</c:if> >선택</option>
								<option value="Y" <c:if test="${cr3210mVO.stYn eq 'Y' }">selected="selected"</c:if> >중지</option>
								<option value="N" <c:if test="${cr3210mVO.stYn eq 'N' }">selected="selected"</c:if> >진행</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">특이사항</th>
						<td colspan="3">
							<textarea id="remk" name="remk"><c:out value="${cr3210mVO.remk }" escapeXml="false"/></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //사용체크정보 -->
			</form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_update(); return false;" >저장</a>
			</div>
			<!-- //버튼 -->			
		</div>	
		<!-- //contents -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>		
	</div>
	<!-- 팝업 -->
	<input type="checkbox" id="modi-pop" class="hidden" />
	<div class="black-pop">&nbsp;</div>
	<!-- 주소찾기 -->
	<div class="modi-popup" id="addrPop">
	</div>
	<!--// 주소찾기 -->
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>