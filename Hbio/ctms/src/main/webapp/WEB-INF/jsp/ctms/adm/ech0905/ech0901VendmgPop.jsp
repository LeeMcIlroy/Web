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
		if(confirm('고객사의 간편정보를 저장합니다.\r\n저장하시겠습니까?')){
			//필수정보
			var corpCd = $("#corpCd").val();
			var vendName = $("#vendName").val();
			if(vendName==''){
				alert('회사명을 입력해주세요')
				$('#vendName').focus();
				return;
			}
			//var resrDt = $("#datepicker01").val();
			var vendSm = $("#vendSm").val();
			if(vendSm==''){
				alert('회사약칭을 입력해주세요')
				$('#vendSm').focus();
				return;
			}
			var excutName = $("#excutName").val();
			if(excutName==''){
				alert('대표자명을 입력해주세요')
				$('#excutName').focus();
				return;
			}
			var vendCls = $("#vendCls").val();
			if(vendCls==''){
				alert('회사구분을 입력해주세요')
				$('#vendCls').focus();
				return;
			}
			//var mtSt = $("input:radio[name='mtSt']:checked").val();
			
			//추가정보
			var regno1 = $("#regno1").val();
			/* if(regno1 != '') {
				var exptext = /^[0-9]*$/;
			    if(exptext.test(regno1)==false){
			        //숫자만 입력
			        alert("숫자만 입력해주세요.");
			        $('#regno1').focus();
			        return;
			    }	
			} */

			var regno2 = $("#regno2").val();
			var regno3 = $("#regno3").val();
			var mngName = $("#mngName").val();
			var mngOrg = $("#mngOrg").val();
			
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0901/ech0901AjaxSaveVend.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"vendCls="+vendCls+"&"+"vendName="+vendName+"&"+"vendSm="+vendSm+"&"+"excutName="+excutName+"&"+"regno1="+regno1+"&"+"regno2="+regno2+"&"+"regno3="+regno3+"&"+"mngName="+mngName+"&"+"mngOrg="+mngOrg
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					//window.opener.fn_list(1);
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
		<h2>고객사 간편등록</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<form:form commandName="ct2000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${ct2000mVO.corpCd}">
			<input type="hidden" id="vendNo" name="vendNo" value="${ct2000mVO.vendNo eq ''?rsNo:ct2000mVO.vendNo}">
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
					<th scope="row"><i>*</i>회사명</th>
					<td>
						<input type	="text" value="<c:out value="${ct2000mVO.vendName }" />"  class="input-data" id="vendName" name="vendName"/>
					</td>	
				</tr>
				<tr>
					<th scope="row"><i>*</i>회사약칭</th>
					<td>
						<input type	="text" value="<c:out value="${ct2000mVO.vendSm }" />"  class="input-data" id="vendSm" name="vendSm"/>
					</td>	
				</tr>
				<tr>
					<th scope="row"><i>*</i>대표자명</th>
					<td>
						<input type	="text" value="<c:out value="${ct2000mVO.excutName }" />"  class="input-data" id="excutName" name="excutName"/>
					</td>	
				</tr>
				<tr>
					<th scope="row"><i>*</i>회사구분</th>
					<td>
						<!-- 회사구분 목록(공통코드) CM4000M - CM1010  -->
						<select id="vendCls" name=vendCls>
							<c:forEach var="result" items="${cm1010}">
								<option value="${result.cd}"<c:if test="${result.cd eq ct2000mVO.vendCls}">selected="selected"</c:if>>${result.cdName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</tbody>
		</table>	
		<table class="tbl_view mb01">
			<colgroup>
				<col style="width:90px" />
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">사업자번호</th>
					<td>
						<form:input path="regno1" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="3"/> -
						<form:input path="regno2" class="p25" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2"/> -
						<form:input path="regno3" class="p30" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="5"/>
					</td>
				</tr>
				<tr>
					<th scope="row">담당자명</th>
					<td>
						<input type="text" value="<c:out value="${ct2000mVO.mngName }" />" class="input_data" id="mngName" name="mngName"/>
					</td>
				</tr>
				<tr>	
					<th scope="row">부서/직위</th>
					<td>
						<input type="text" value="<c:out value="${ct2000mVO.mngOrg }" />" class="input_data" id="mngOrg" name="mngOrg"/>
					</td>
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