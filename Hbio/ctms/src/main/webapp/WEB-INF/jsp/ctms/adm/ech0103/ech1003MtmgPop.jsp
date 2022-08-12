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
		
		var ynmtSt = '<c:out value="${rs4000mVO.mtSt}"/>';
		
		switch(ynmtSt) {
		case "10" :  
			$("#mtSt1").attr('checked', 'checked');
			break;
		case "20" :  
			$("#mtSt2").attr('checked', 'checked');
			break;
		case "30" :  
			$("#mtSt3").attr('checked', 'checked');
			break;
		case "40" :  
			$("#mtSt4").attr('checked', 'checked');
			break;
		case "50" :  
			$("#mtSt5").attr('checked', 'checked');
			break;
		default :
			$("#mtSt1").attr('checked', 'checked');	
		}
				
		//if(ynuseYn == 'Y'){
			//$("#useY").attr('checked', 'checked');
		//}else{
			//$("#useN").attr('checked', 'checked');
		//}
	});
	
	function fn_update(){
	
		var mtCnt = $('#mtCnt').val();
		
		if(mtCnt==''){
			alert('방문회수를 입력해주세요.')
			$('#mtCnt').focus();
			return;
		}
		
		
		var regDt = $('#datepicker01').val();
			
		if(regDt==''){
			alert('예약일을 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
					
		var resrHr = $('#resrHr').val();
		
		if(resrHr==''){
			alert('예약시간을 입력해주세요.')
			$('#resrHr').focus();
			return;
		}
		
		var resrMm = $('#resrMm').val();
		
		if(resrMm==''){
			alert('예약분을 입력해주세요.')
			$('#resrMm').focus();
			return;
		}
				
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0103/ech0103Update.do'/>").submit();
	}

	function fn_step(){
		if(confirm('대상자의 예약정보를 저장합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var rsjNo = $("#rsjNo").val();
			var resrDt = $("#datepicker01").val();
			var resrHr = $("#resrHr").val();
			var resrMm = $("#resrMm").val();
			var mtSt = $("input:radio[name='mtSt']:checked").val();
			var mtCnt = $("#mtCnt").val();	
			//예약번호 - 수정모드
			var resrNo = $("#resrNo").val();
			var regDt = $("#regDt").val();
			
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0103/ech1003AjaxSaveStep.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"rsjNo="+rsjNo+"&"+"resrDt="+resrDt+"&"+"resrHr="+resrHr+"&"+"resrMm="+resrMm+"&"+"mtSt="+mtSt+"&"+"mtCnt="+mtCnt+"&"+"resrNo="+resrNo+"&"+"regDt="+regDt
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.opener.fn_list(1);
					window.close();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
</script>
<body>
<!-- pop_wrap -->
<div class="pop_wrap">
	<!-- pop_header -->
	<div class="pop_header">
		<h1 class="hidden"><a href="#">H&amp;Bio</a></h1>
		<h2>예약관리</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<form:form commandName="rs4000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs4000mVO.corpCd}">
			<input type="hidden" id="rsNo" name="rsNo" value="${rs4000mVO.rsNo eq ''?rsNo:rs4000mVO.rsNo}">
			<input type="hidden" id="rsjNo" name="rsjNo" value="${rs4000mVO.rsjNo eq ''?rsjNo:rs4000mVO.rsjNo}">
			<input type="hidden" id="resrNo" name="resrNo" value="${rs4000mVO.resrNo eq ''?resrNo:rs4000mVO.resrNo}">
			<input type="hidden" id="rsCd" name="rsCd" value="${rs4000mVO.rsCd eq ''?rsCd:rs4000mVO.rsCd}">
			<input type="hidden" id="regDt" name="regDt" value="${rs4000mVO.regDt eq ''?regDt:rs4000mVO.regDt}">
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<div class="pop_con type03">
		<!-- 예약관리 -->
		<table class="tbl_view mb01">
			<colgroup>
				<col style="width:90px" />
				
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">연구코드</th>
					<td><c:out value="${rs4000mVO.rsCd }" /></td>
					
				</tr>
				<tr>
					<th scope="row"><i>*</i>방문횟수</th>
					<td>
						<select id="mtCnt" name="mtCnt" class="p50">
							<option value="" <c:if test="${rs4000mVO.mtCnt eq '' }">selected="selected"</c:if> >선택</option>
							<option value="1" <c:if test="${rs4000mVO.mtCnt eq '1' }">selected="selected"</c:if> >1</option>
							<option value="2" <c:if test="${rs4000mVO.mtCnt eq '2' }">selected="selected"</c:if> >2</option>
							<option value="3" <c:if test="${rs4000mVO.mtCnt eq '3' }">selected="selected"</c:if> >3</option>
							<option value="4" <c:if test="${rs4000mVO.mtCnt eq '4' }">selected="selected"</c:if> >4</option>
							<option value="5" <c:if test="${rs4000mVO.mtCnt eq '5' }">selected="selected"</c:if> >5</option>
						</select>&nbsp;회차
					</td>
				</tr>
				<tr>
					<th scope="row"><i>*</i>예약일</th>
					<td>
						<div class="date_sec type02 mb02">
							<span>
								<input name="resrDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${rs4000mVO.resrDt }" />" class="date required" title="예약일자" />
								<label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
						</div>
						<br />
						<select id="resrHr" name="resrHr" class="p30">
							<option value="" <c:if test="${rs4000mVO.resrHr eq '' }">selected="selected"</c:if> >선택</option>
							<option value="9" <c:if test="${rs4000mVO.resrHr eq '9' }">selected="selected"</c:if> >9</option>
							<option value="10" <c:if test="${rs4000mVO.resrHr eq '10' }">selected="selected"</c:if> >10</option>
							<option value="11" <c:if test="${rs4000mVO.resrHr eq '11' }">selected="selected"</c:if> >11</option>
							<option value="12" <c:if test="${rs4000mVO.resrHr eq '12' }">selected="selected"</c:if> >12</option>
							<option value="13" <c:if test="${rs4000mVO.resrHr eq '13' }">selected="selected"</c:if> >13</option>
							<option value="14" <c:if test="${rs4000mVO.resrHr eq '14' }">selected="selected"</c:if> >14</option>
							<option value="15" <c:if test="${rs4000mVO.resrHr eq '15' }">selected="selected"</c:if> >15</option>
							<option value="16" <c:if test="${rs4000mVO.resrHr eq '16' }">selected="selected"</c:if> >16</option>
							<option value="17" <c:if test="${rs4000mVO.resrHr eq '17' }">selected="selected"</c:if> >17</option>
							<option value="18" <c:if test="${rs4000mVO.resrHr eq '18' }">selected="selected"</c:if> >18</option>
						</select>시&nbsp;&nbsp;
						<select id="resrMm" name="resrMm" class="p30">
							<option value="" <c:if test="${rs4000mVO.resrMm eq '' }">selected="selected"</c:if> >선택</option>
							<option value="0" <c:if test="${rs4000mVO.resrMm eq '0' }">selected="selected"</c:if> >00</option>
							<option value="10" <c:if test="${rs4000mVO.resrMm eq '10' }">selected="selected"</c:if> >10</option>
							<option value="20" <c:if test="${rs4000mVO.resrMm eq '20' }">selected="selected"</c:if> >20</option>
							<option value="30" <c:if test="${rs4000mVO.resrMm eq '30' }">selected="selected"</c:if> >30</option>
							<option value="40" <c:if test="${rs4000mVO.resrMm eq '40' }">selected="selected"</c:if> >40</option>
							<option value="50" <c:if test="${rs4000mVO.resrMm eq '50' }">selected="selected"</c:if> >50</option>
						</select>분
					</td>
				</tr>
				<tr>
					<th scope="row"><i>*</i>참여상태</th>
					<td>
						<input type="radio" name="mtSt" id="mtSt1" value="10"/>
					    <label for="mtSt1">예약</label>
					    <input type="radio" name="mtSt" id="mtSt2" value="20"/>
					    <label for="mtSt2">예약취소</label>
					    <input type="radio" name="mtSt" id="mtSt3" value="30"/>
					    <label for="mtSt3">참여</label>
					    <input type="radio" name="mtSt" id="mtSt4" value="40"/>
					    <label for="mtSt4">참여취소</label>
					    <input type="radio" name="mtSt" id="mtSt5" value="50"/>
					    <label for="mtSt5">온라인참여</label>
					</td>
				</tr>
				<tr>
					<th scope="row">스크리닝예약여부</th>
					<td><c:out value="${rs4000mVO.scrYn }" /></td>
				</tr>
			</tbody>
		</table>
		<!-- //예약관리 -->
		</form:form>
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="javascript:window.close();" class="type02">취소</a>
			<!-- <a href="#" onclick="fn_update(); return false;" >저장</a>  -->
			<a href="#" onclick="fn_step(); return false;" >저장</a>
		</div>
		<!-- //버튼 -->
	</div>
	<!-- //pop_con -->
	<!-- 팝업 -->
	<input type="checkbox" id="modi-pop" class="hidden" />
	<div class="black-pop">&nbsp;</div>
	<!-- 주소찾기 -->
	<div class="modi-popup" id="addrPop">
	</div>
	<!--// 주소찾기 -->
</div>	
<!-- //pop_wrap -->
</body>
</html>