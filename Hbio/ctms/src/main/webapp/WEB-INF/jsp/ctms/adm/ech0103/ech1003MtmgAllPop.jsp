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
		//예약정보 설정을 위해 연구대상자 목록 선택
		$("#all-chk").change(function(){
			$("input[name=rsjSeq]").prop("checked", $(this).prop('checked'));
		});
		
		$("input[name=rsjSeq]").prop("checked", "checked");
		
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

	function fn_step(){
		if(confirm('대상자에게 SMS를 발송합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var rsCd = $("#rsCd").val();
			//var rsjNo = $("#rsjNo").val();
			var rsjNo = $("input[name=rsjSeq]:checked").serialize();
			var resrDt = $("#datepicker01").val();
			var resrHr = $("#resrHr").val();
			var resrMm = $("#resrMm").val();
			var mtSt = $("input:radio[name='mtSt']:checked").val();
			var mtCnt = $("#mtCnt").val();	
			//예약번호 - 수정모드
			var resrNo = $("#resrNo").val();
			var regDt = $("#regDt").val();			
			
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0103/ech1003AjaxSaveAllStep.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"rsCd="+rsCd+"&"+"resrDt="+resrDt+"&"+"resrHr="+resrHr+"&"+"resrMm="+resrMm+"&"+"mtSt="+mtSt+"&"+"mtCnt="+mtCnt+"&"+"resrNo="+resrNo+"&"+"regDt="+regDt+"&"+$("input[name=rsjSeq]:checked").serialize()
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
		<h2>SMS 발송</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type02">
	<form:form commandName="rs4000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs4000mVO.corpCd}">
			<input type="hidden" id="rsNo" name="rsNo" value="${rs4000mVO.rsNo eq ''?rsNo:rs4000mVO.rsNo}">
			<input type="hidden" id="rsjNo" name="rsjNo" value="${rs4000mVO.rsjNo eq ''?rsjNo:rs4000mVO.rsjNo}">
			<input type="hidden" id="resrNo" name="resrNo" value="${rs4000mVO.resrNo eq ''?resrNo:rs4000mVO.resrNo}">
			<input type="hidden" id="rsCd" name="rsCd" value="${rs4000mVO.rsCd eq ''?rsCd:rs4000mVO.rsCd}">
			<input type="hidden" id="regDt" name="regDt" value="${rs4000mVO.regDt eq ''?regDt:rs4000mVO.regDt}">
			<input type="hidden" id="rsjSeq" name="rsjSeq">			
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
		<!-- 서브타이틀 -->
		<div class="sub_title_area type02">
			<h3>발송 대상자</h3>
		</div>
		<!-- //서브타이틀 -->
		<!-- 대상자 -->
		<div>
		<div class="hd_fix">
				<table class="tbl_list">
					<!--<colgroup>
						<col style="width:50px" />
						<col style="width:70px" />
						<col style="width:150px" />
						<col style="width:150px" />
						<col style="width:220px" />
						<col style="width:auto" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" width="50"><input type="checkbox" id="all-chk"/></th>
							<th scope="col" width="70">번호</th>
							<th scope="col" width="150">이름</th>
							<th scope="col" width="150">핸드폰</th>
							<th scope="col" width="220">연구코드</th>
							<th scope="col" width="151">참여상태</th>
						</tr>
					</thead> -->
					<colgroup>
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:auto" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" ><input type="checkbox" id="all-chk"/></th>
							<th scope="col" >번호</th>
							<th scope="col" >이름</th>
							<th scope="col" >핸드폰</th>
							<th scope="col" >연구코드</th>
							<th scope="col" >참여상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">			
					<tr>
						<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.rsNo }'/><c:out value='${result.rsjNo }'/>"/></td>
						<td><c:out value="${result.rownum}"/></td>
						<td><c:out value="${result.rsjName}"/></td>
						<td>
							<c:choose>
                        		<c:when test="${result.hpNo eq '' }"><span style="color:red;">(핸드폰번호확인)</span></c:when>
                        		<c:when test="${result.hpNo ne '' }"><c:out value="${result.hpNo }"/></c:when>
                       		</c:choose>
						</td>
						<td><c:out value="${result.rsCd}"/></td>
						<td><c:out value="${result.appstaClsNm}"/></td>
					</tr>
					</c:forEach>
					<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="6">선택한 대상자 정보가 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
		</div>
		</div>
		<!-- //대상자 -->
		<!-- 이메일발송 -->
		<table class="tbl_view">
			<colgroup>
				<col style="width:200px" />
				<col style="width:auto" />
			</colgroup>
			<tbody>
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
			</tbody>
		</table>
		<!-- //이메일발송 -->
		</form:form>
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="javascript:window.close();" class="type02">취소</a>
			<a href="#" onclick="fn_step(); return false;" >저장</a>
		</div>
		<!-- //버튼 -->
	</div>
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</body>
</html>