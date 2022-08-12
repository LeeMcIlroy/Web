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
		var ynappstaCls = '<c:out value="${rs2010mVO.appstaCls}"/>';
		switch(ynappstaCls) {
		case "10" :  
			$("#appstaCls1").attr('checked', 'checked');
			break;
		case "20" :  
			$("#appstaCls2").attr('checked', 'checked');
			break;
		case "30" :  
			$("#appstaCls3").attr('checked', 'checked');
			break;
		case "40" :  
			$("#appstaCls4").attr('checked', 'checked');
			break;
		default :
			$("#appstaCls1").attr('checked', 'checked');	
		}		
	});
	

	function fn_step(){
		if(confirm('피험자의 정보를  저장합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var subNo = $("#subNo").val();
			var etc = $("#etc").val(); //특이사항
			var appstaCls = $("input:radio[name='appstaCls']:checked").val(); //참여상태
			var appStdt = $("#datepicker01").val(); //참여시작일자
			var appEndt = $("#datepicker02").val(); //참여종료일자
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102AjaxSaveRsjmg.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"subNo="+subNo+"&"+"etc="+etc+"&"+"appstaCls="+appstaCls+"&"+"appStdt="+appStdt+"&"+"appEndt="+appEndt
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.opener.fn_view2(6);
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
		<h2>피험자관리</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<form:form commandName="rs2010mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs2010mVO.corpCd}">
			<input type="hidden" id="rsNo" name="rsNo" value="${rs2010mVO.rsNo eq ''?rsNo:rs2010mVO.rsNo}">
			<input type="hidden" id="subNo" name="subNo" value="${rs2010mVO.subNo eq ''?subNo:rs2010mVO.subNo}">
			<input type="hidden" id="rsCd" name="rsCd" value="${rs2010mVO.rsCd eq ''?rsCd:rs2010mVO.rsCd}">
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
					<td><c:out value="${rs2010mVO.rsCd }" /></td>
					
				</tr>
				<tr>
					<th scope="row">이름</th>
					<td><c:out value="${rs2010mVO.rsjName }" />(<c:out value="${rs2010mVO.brDt }" />)</td>
					
				</tr>
				<tr>
					<th scope="row">특이사항</th>
					<td>
						<textarea class="type02 type03" id="etc" name="etc"><c:out value="${rs2010mVO.etc }" /></textarea>
					</td>	
				</tr>
				<tr>
					<th scope="row">참여상태</th>
					<td>
						<input type="radio" name="appstaCls" id="appstaCls1" value="10"/>
					    <label for="appstaCls1">예정</label>
					    <input type="radio" name="appstaCls" id="appstaCls2" value="20"/>
					    <label for="appstaCls2">진행</label>
					    <input type="radio" name="appstaCls" id="appstaCls3" value="30"/>
					    <label for="appstaCls3">완료</label>
					    <input type="radio" name="appstaCls" id="appstaCls4" value="40"/>
					    <label for="appstaCls4">취소</label>
					</td>	
				</tr>
				<tr>
					<th scope="row">참여시작일자</th>
					<td>
						<div class="date_sec type02 mb02">
							<span>
								<input name="appStdt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${rs2010mVO.appStdt }" />" class="date required" title="시작일자" />
								<label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
						</div>
					</td>	
				</tr>
				<tr>
					<th scope="row">참여종료일자</th>
					<td>
						<div class="date_sec type02 mb02">
							<span>
								<input name="appEndt" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${rs2010mVO.appEndt }" />" class="date required" title="종료일자" />
								<label for="datepicker02" class="btn_cld">날짜검색</label>
							</span>
						</div>
					</td>	
				</tr>
				
				<%-- <tr>
					<th scope="row"><i>*</i>방문횟수</th>
					<td>
						<select id="mtCnt" name="mtCnt" class="p50">
							<option value="" <c:if test="${rs2010mVO.mtCnt eq '' }">selected="selected"</c:if> >선택</option>
							<option value="1" <c:if test="${rs2010mVO.mtCnt eq '1' }">selected="selected"</c:if> >1</option>
							<option value="2" <c:if test="${rs2010mVO.mtCnt eq '2' }">selected="selected"</c:if> >2</option>
							<option value="3" <c:if test="${rs2010mVO.mtCnt eq '3' }">selected="selected"</c:if> >3</option>
							<option value="4" <c:if test="${rs2010mVO.mtCnt eq '4' }">selected="selected"</c:if> >4</option>
							<option value="5" <c:if test="${rs2010mVO.mtCnt eq '5' }">selected="selected"</c:if> >5</option>
						</select>&nbsp;회차
					</td>
				</tr>
				<tr>
					<th scope="row"><i>*</i>예약일</th>
					<td>
						<div class="date_sec type02 mb02">
							<span>
								<input name="resrDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${rs2010mVO.resrDt }" />" class="date required" title="예약일자" />
								<label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
						</div>
						<br />
						<select id="resrHr" name="resrHr" class="p30">
							<option value="" <c:if test="${rs2010mVO.resrHr eq '' }">selected="selected"</c:if> >선택</option>
							<option value="9" <c:if test="${rs2010mVO.resrHr eq '9' }">selected="selected"</c:if> >9</option>
							<option value="10" <c:if test="${rs2010mVO.resrHr eq '10' }">selected="selected"</c:if> >10</option>
							<option value="11" <c:if test="${rs2010mVO.resrHr eq '11' }">selected="selected"</c:if> >11</option>
							<option value="12" <c:if test="${rs2010mVO.resrHr eq '12' }">selected="selected"</c:if> >12</option>
							<option value="13" <c:if test="${rs2010mVO.resrHr eq '13' }">selected="selected"</c:if> >13</option>
							<option value="14" <c:if test="${rs2010mVO.resrHr eq '14' }">selected="selected"</c:if> >14</option>
							<option value="15" <c:if test="${rs2010mVO.resrHr eq '15' }">selected="selected"</c:if> >15</option>
							<option value="16" <c:if test="${rs2010mVO.resrHr eq '16' }">selected="selected"</c:if> >16</option>
							<option value="17" <c:if test="${rs2010mVO.resrHr eq '17' }">selected="selected"</c:if> >17</option>
							<option value="18" <c:if test="${rs2010mVO.resrHr eq '18' }">selected="selected"</c:if> >18</option>
						</select>시&nbsp;&nbsp;
						<select id="resrMm" name="resrMm" class="p30">
							<option value="" <c:if test="${rs2010mVO.resrMm eq '' }">selected="selected"</c:if> >선택</option>
							<option value="0" <c:if test="${rs2010mVO.resrMm eq '0' }">selected="selected"</c:if> >00</option>
							<option value="10" <c:if test="${rs2010mVO.resrMm eq '10' }">selected="selected"</c:if> >10</option>
							<option value="20" <c:if test="${rs2010mVO.resrMm eq '20' }">selected="selected"</c:if> >20</option>
							<option value="30" <c:if test="${rs2010mVO.resrMm eq '30' }">selected="selected"</c:if> >30</option>
							<option value="40" <c:if test="${rs2010mVO.resrMm eq '40' }">selected="selected"</c:if> >40</option>
							<option value="50" <c:if test="${rs2010mVO.resrMm eq '50' }">selected="selected"</c:if> >50</option>
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
					<td><c:out value="${rs2010mVO.scrYn }" /></td>
				</tr> --%>
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