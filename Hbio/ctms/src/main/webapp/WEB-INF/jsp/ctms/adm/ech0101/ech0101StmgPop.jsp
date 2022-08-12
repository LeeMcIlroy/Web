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
		var ynmode = '<c:out value="${rs1030mVO.mode}"/>';
		
		if(ynmode=='u'){$('#empNo').attr('disabled', 'true');}
		
		var ynrsstCls = '<c:out value="${rs1030mVO.rsstCls}"/>';
		
		switch(ynrsstCls) {
		case "10" :  
			$("#rsstCls1").attr('checked', 'checked');
			break;
		case "20" :  
			$("#rsstCls2").attr('checked', 'checked');
			break;
		case "30" :  
			$("#rsstCls3").attr('checked', 'checked');
			break;
		case "40" :  
			$("#rsstCls4").attr('checked', 'checked');
			break;		
		default :
			$("#rsstCls1").attr('checked', 'checked');	
		}
				
		//if(ynuseYn == 'Y'){
			//$("#useY").attr('checked', 'checked');
		//}else{
			//$("#useN").attr('checked', 'checked');
		//}
	});
	
	function fn_update(){
	
		var empNo = $('#empNo').val();
		
		if(empNo==''){
			alert('참여연구담당자를 입력해주세요.')
			$('#empNo').focus();
			return;
		}
		
		var regDt = $('#datepicker01').val();
			
		if(regDt==''){
			alert('참여시작일을 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
		
		var regDt = $('#datepicker02').val();
		
		if(regDt==''){
			alert('참여종료일을 입력해주세요.')
			$('#datepicker02').focus();
			return;
		}
		
		fn_step();
		//$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0101/ech0101Update.do'/>").submit();
	}

	function fn_step(){
		if(confirm('연구과제의 참여 연구담당자정보를 저장합니다.\r\n저장하시겠습니까?')){
			var mode = $("#mode").val();
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var empNo = $("#empNo").val();
			var empName = $("#empName").val();
			var jnStdt = $("#datepicker01").val();
			var jnEndt = $("#datepicker02").val();
			var rsstCls = $("input:radio[name='rsstCls']:checked").val();
			var rsCd = $('#rsCd').val();
			var subrsCd = rsCd.substring(0,14);
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101AjaxSaveStaff.do'/>"
				, type: "post"
				, data: "mode="+mode+"&"+"corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"empNo="+empNo+"&"+"jnStdt="+jnStdt+"&"+"jnEndt="+jnEndt+"&"+"rsstCls="+rsstCls+"&"+"empName="+empName+"&"+"rsCd="+subrsCd
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					location.reload();
			    	localStorage.setItem("stmg","stmg");
					opener.location.reload();
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
		<h2>참여연구담당자관리</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<form:form commandName="rs1030mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="mode" name="mode" value="${rs1030mVO.mode eq ''?mode:rs1030mVO.mode}">>
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1030mVO.corpCd}">
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1030mVO.rsNo eq ''?rsNo:rs1030mVO.rsNo}">
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
			<input type="hidden" id="rsCd" name="rsCd" value="${rs1030mVO.rsCd }">
	<div class="pop_con type03">
		<!-- 참여연구담당자관리 -->
		<table class="tbl_view mb01">
			<colgroup>
				<col style="width:90px" />
				
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">연구코드</th>
					<td><c:out value="${rs1030mVO.rsCd }" /></td>
				</tr>
				<tr>
					<th scope="row"><i>*</i>참여연구담당(변경불가)</th>
					<td>
						<!-- 구성원목록 CT1030M 테이블    이름, 사용자코드  -->							
						<select id="empNo" name=empNo>
							<c:forEach var="result" items="${staff}">
								<option value="${result.empNo}"<c:if test="${result.empNo eq rs1030mVO.empNo}">selected="selected"</c:if>>${result.empName}(${result.orgName})</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">연구자명</th>
					<td><c:out value="${rs1030mVO.empName }" /></td>
				<tr>	
				<tr>
					<th scope="row"><i>*</i>참여시작일</th>
					<td>
						<div class="date_sec type02 mb02">
							<span>
								<input name="jnStdt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${rs1030mVO.jnStdt }" />" class="date required" title="시작일자" />
								<label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
						</div>
					</td>
				</tr>
				<tr>					
				 	<th scope="row"><i>*</i>참여종료일</th>
					<td>
						<div class="date_sec type02 mb02">
							<span>
								<input name="jnEndt" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${rs1030mVO.jnEndt }" />" class="date required" title="종료일자" />
								<label for="datepicker02" class="btn_cld">날짜검색</label>
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><i>*</i>참여상태</th>
					<td>
						<input type="radio" name="rsstCls" id="rsstCls1" value="10"/>
					    <label for="rsstCls1">예정</label>
					    <input type="radio" name="rsstCls" id="rsstCls2" value="20"/>
					    <label for="rsstCls2">진행</label>
					    <input type="radio" name="rsstCls" id="rsstCls3" value="30"/>
					    <label for="rsstCls3">완료</label>
					    <input type="radio" name="rsstCls" id="rsstCls4" value="40"/>
					    <label for="rsstCls4">취소</label>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //참여지사관리 -->
		</form:form>
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="javascript:window.close();" class="type02">취소</a>
			<a href="#" onclick="fn_update(); return false;" >저장</a>
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