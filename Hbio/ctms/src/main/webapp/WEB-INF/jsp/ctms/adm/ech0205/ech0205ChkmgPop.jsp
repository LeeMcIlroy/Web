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


	});

	function fn_step(){
		if(confirm('연구대상자의 사용정보를 저장합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var rsjNo = $("#rsjNo").val();
			var chkDt = $("#chkDt").val();
			var chk1  = $("#chk1").val();
			var chk2  = $("#chk2").val();
			var chk3  = $("#chk3").val();
			var chk4  = $("#chk4").val();
			var chk5  = $("#chk5").val();
			var remk  = $("#remk").val();
			var chkCnt = 0;
			if(chk1=="Y") {chkCnt = chkCnt + 1};
			if(chk2=="Y") {chkCnt = chkCnt + 1};
			if(chk3=="Y") {chkCnt = chkCnt + 1};
			if(chk4=="Y") {chkCnt = chkCnt + 1};
			if(chk5=="Y") {chkCnt = chkCnt + 1};
			//사용여부 값변경여부 확인 변경된 경우 일자를 갱신한다. 
			var crchk1 = '<c:out value="${cr3240mVO.chk1}"/>';
			var crchk2 = '<c:out value="${cr3240mVO.chk2}"/>';
			var crchk3 = '<c:out value="${cr3240mVO.chk3}"/>';
			var crchk4 = '<c:out value="${cr3240mVO.chk4}"/>';
			var crchk5 = '<c:out value="${cr3240mVO.chk5}"/>';
			var chk1Dt = "N";
			var chk2Dt = "N";
			var chk3Dt = "N";
			var chk4Dt = "N";
			var chk5Dt = "N";
			if(crchk1 != chk1 ){
				chk1Dt = "Y"
			}else{
				chk1Dt = '<c:out value="${cr3240mVO.chk1Dt}"/>';
			};
			
			if(crchk2 != chk2 ){
				chk2Dt = "Y"
			}else{
				chk2Dt = '<c:out value="${cr3240mVO.chk2Dt}"/>';
			};
			
			if(crchk3 != chk3 ){
				chk3Dt = "Y"
			}else{
				chk3Dt = '<c:out value="${cr3240mVO.chk3Dt}"/>';
			};
			
			if(crchk4 != chk4 ){
				chk4Dt = "Y"
			}else{
				chk4Dt = '<c:out value="${cr3240mVO.chk4Dt}"/>';
			};
			
			if(crchk5 != chk5 ){
				chk5Dt = "Y"
			}else{
				chk5Dt = '<c:out value="${cr3240mVO.chk5Dt}"/>';
			};
			
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205AjaxSaveChkmg.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"rsjNo="+rsjNo+"&"+"chkDt="+chkDt+"&"+"chkCnt="+chkCnt+"&"+"chk1="+chk1+"&"+"chk2="+chk2+"&"+"chk3="+chk3+"&"+"chk4="+chk4+"&"+"chk5="+chk5+"&"+"chk1Dt="+chk1Dt+"&"+"chk2Dt="+chk2Dt+"&"+"chk3Dt="+chk3Dt+"&"+"chk4Dt="+chk4Dt+"&"+"chk5Dt="+chk5Dt+"&"+"remk="+remk
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.opener.fn_view();
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
		<h2>사용내역관리</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<form:form commandName="cr3240mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${cr3240mVO.corpCd}">
			<input type="hidden" id="rsNo" name="rsNo" value="${cr3240mVO.rsNo eq ''?rsNo:cr3240mVO.rsNo}">
			<input type="hidden" id="rsjNo" name="rsjNo" value="${cr3240mVO.rsjNo eq ''?rsjNo:cr3240mVO.rsjNo}">
			<input type="hidden" id="chkDt" name="chkDt" value="${cr3240mVO.chkDt eq ''?chkDt:cr3240mVO.chkDt}">
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<div class="pop_con type03">
		<!-- 사용내역관리 -->
		<table class="tbl_view mb01">
			<colgroup>
				<col style="width:90px" />				
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">연구코드</th>
					<td><c:out value="${cr3240mVO.rsCd }" /></td>					
				</tr>
				<tr>
					<th scope="row">사용일자</th>
					<td><c:out value="${cr3240mVO.chkDt }" /></td>					
				</tr>
				<tr>
					<th scope="row">체크1</th>
					<td>
						<select id="chk1" name="chk1" class="p50">
							<option value="" <c:if test="${cr3240mVO.chk1 eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${cr3240mVO.chk1 eq 'Y' }">selected="selected"</c:if> >사용</option>
							<option value="N" <c:if test="${cr3240mVO.chk1 eq 'N' }">selected="selected"</c:if> >미사용</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">체크2</th>
					<td>
						<select id="chk2" name="chk2" class="p50">
							<option value="" <c:if test="${cr3240mVO.chk2 eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${cr3240mVO.chk2 eq 'Y' }">selected="selected"</c:if> >사용</option>
							<option value="N" <c:if test="${cr3240mVO.chk2 eq 'N' }">selected="selected"</c:if> >미사용</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">체크3</th>
					<td>
						<select id="chk3" name="chk3" class="p50">
							<option value="" <c:if test="${cr3240mVO.chk3 eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${cr3240mVO.chk3 eq 'Y' }">selected="selected"</c:if> >사용</option>
							<option value="N" <c:if test="${cr3240mVO.chk3 eq 'N' }">selected="selected"</c:if> >미사용</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">체크4</th>
					<td>
						<select id="chk4" name="chk4" class="p50">
							<option value="" <c:if test="${cr3240mVO.chk4 eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${cr3240mVO.chk4 eq 'Y' }">selected="selected"</c:if> >사용</option>
							<option value="N" <c:if test="${cr3240mVO.chk4 eq 'N' }">selected="selected"</c:if> >미사용</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">체크5</th>
					<td>
						<select id="chk5" name="chk5" class="p50">
							<option value="" <c:if test="${cr3240mVO.chk5 eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${cr3240mVO.chk5 eq 'Y' }">selected="selected"</c:if> >사용</option>
							<option value="N" <c:if test="${cr3240mVO.chk5 eq 'N' }">selected="selected"</c:if> >미사용</option>
						</select>
					</td>
				</tr>
				<tr>
                    <th scope="row">특이사항</th>                        
                    <td>
						<textarea class="type02 type03" id="remk" name="remk"><c:out value="${cr3240mVO.remk }" /></textarea>
					</td>                        
                </tr>
			</tbody>
		</table>
		<!-- //사용내역관리 -->
		</form:form>
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="javascript:window.close();" class="type02">취소</a>
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