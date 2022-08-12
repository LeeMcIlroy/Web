<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">

	$(function(){
		
		var ynmode = '<c:out value="${rs1040mVO.mode}"/>';
		
		/* if(ynmode=='u'){$('#branchCd').attr('disabled', 'true');} */		
		
		var ynncYn = '<c:out value="${rs1040mVO.ncYn}"/>';
		switch(ynncYn) {
		case "Y" :  // Negative Control 
			$("#ncYn1").attr('checked', 'checked');
			$("#dspmtl").hide();
			$("#mtlName2").attr('disabled', true);
			break;
		case "N" :  // 시험물질
			$("#ncYn2").attr('checked', 'checked');
			$("#dspnc").hide();
			$("#mtlName").attr('disabled', true);
			break;
		default :
			$("#ncYn2").attr('checked', 'checked');
			$("#dspnc").hide();
		}
		
		
	});
	
	function fn_dsp(dspCnt){
		switch(dspCnt) {
		case "Y" :  
			$("#dspnc").show();
			$("#mtlName").removeAttr('disabled');
			$("#dspmtl").hide();
			$("#mtlName2").attr('disabled', true);
			break;
		case "N" : 
			$("#dspnc").hide();
			$("#mtlName").attr('disabled', true);
			$("#dspmtl").show();
			$("#mtlName2").removeAttr('disabled');
			break;
		default :
			$("#dspnc").hide();
			//$("#mtlName").attr('disabled', true);
			$("#dspmtl").show();
			//$("#mtlName2").removeAttr('disabled');
		}
	}

	
	function fn_update(){
		var ynmtlDsp = $('#mtlDsp').val();		
		if(ynmtlDsp==''){
			alert('시험물질표시를 입력해주세요.')
			$('#mtlDsp').focus();
			return;
		}
		
		var ynmtlName 	= $('#mtlName').val();
		var ynmtlName2	= $('#mtlName2').val();
		var ynncYn 		= $("input:radio[name='ncYn']:checked").val();
		if(ynncYn == 'Y') {
			if(ynmtlName==''){
				alert('N.C 물질명칭을 입력해주세요.')
				$('#mtlName').focus();
				return;
			}
		}else{
			if(ynmtlName2==''){
				alert('시험물질명칭을 입력해주세요.')
				$('#mtlName2').focus();
				return;
			}	
		}
		
		fn_step();
		//$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0101/ech0101Update.do'/>").submit();
	}
	
	//물질번호 중복체크(N/C면 체크안함)
	function mtlDspChk(){
	
		//if($("input:radio[name='ncYn']:checked").val() == 'N'){
			
			var mtlDsp = $("#mtlDsp").val();
			var rsCd =$("#rsCd").val();
			var subrsCd = rsCd.substring(0,14);
			$.ajax({			
	
				  url: "<c:url value='/qxsepmny/ech0101/ech0101AjaxMtlDspCheck.do'/>"
				, type: "post"
				, data: "mtlDsp="+mtlDsp+"&"+"rsCd="+subrsCd
				, dataType:"json"
				, success: function(data){
					var status = data.status;
					var message = data.message;
					
					if(!status){
						$("#mtlDsp").val('');
					}else{
						$("#mtlDsp").val(mtlDsp);
					}
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		//}else false;
	}
	//음성대조군 값 변경시 물질번호 초기화
	$(function(){
		$("input:radio[name='ncYn']").change(function(){
			$("#mtlDsp").val('');
		})
	})
	//시험물질정보 수정시 물질번호 및 음성대조군 disabled처리
	$(function(){
		var mtlDsp = $("#mtlDsp").val();
		if(mtlDsp != ''){
			document.getElementById('mtlDsp').disabled = true;
			document.getElementById('ncYn1').disabled = true;
			document.getElementById('ncYn2').disabled = true;
		}
	})
	
	function fn_step(){
		if(confirm('연구과제의 시험물질정보를 저장합니다.\r\n저장하시겠습니까?')){
			var mode = $("#mode").val();
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var mtlNo = $("#mtlNo").val();
			var mtlDsp = $("#mtlDsp").val();
			var mtlName1 = $("#mtlName").val();
			var mtlName = encodeURIComponent(mtlName1);
			var mtlName1 = $("#mtlName2").val();
			var mtlName2 = encodeURIComponent(mtlName1);
			var lotNo = $("#lotNo").val();
			var mtlShp = $("#mtlShp").val();
			var remk = $("#remk").val();
			var rsCd =$("#rsCd").val();
			var mrsNo =$("#mrsNo").val();
			var subrsCd = rsCd.substring(0,14);
			
			/* var remk1 = btoa(remk); //base64 encode; */
			var remk1 = encodeURIComponent(remk);
			var ncYn = $("input:radio[name='ncYn']:checked").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101AjaxSaveMtl.do'/>"
				, type: "post"
				, data: "mode="+mode+"&"+"corpCd="+corpCd+"&"+"rsNo="+rsNo+"&"+"mtlNo="+mtlNo+"&"+"mtlDsp="+"#"+mtlDsp+"&"+"mtlName="+mtlName+"&"+"lotNo="+lotNo+"&"+"mtlShp="+mtlShp+"&"+"remk="+remk+"&"+"remk1="+remk1+"&"+"ncYn="+ncYn+"&"+"mtlName2="+mtlName2+"&"+"rsCd="+subrsCd+"&"+"mrsNo="+mrsNo
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					//팝업창 리로드
					location.reload();
					//부모창 값가져오기
			    	localStorage.setItem("mtl","mtl");
					//부모창 리로드	  
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
		<h2>시험물질 정보관리</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<form:form commandName="rs1040mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="mode" name="mode" value="${rs1040mVO.mode eq ''?mode:rs1040mVO.mode}">>
			<input type="hidden" id="corpCd" name="corpCd" value="${rs1040mVO.corpCd}">
			<input type="hidden" id="rsNo" name="rsNo" value="${rs1040mVO.rsNo eq ''?rsNo:rs1040mVO.rsNo}">
			<input type="hidden" id="mtlNo" name="mtlNo" value="${rs1040mVO.mtlNo eq ''?mtlNo:rs1040mVO.mtlNo}">
			<input type="hidden" id="mrsNo" name="mrsNo" value="${rs1040mVO.mrsNo eq ''?mtlNo:rs1040mVO.mrsNo}">
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
			<input type="hidden" id="rsCd" name="rsCd" value="${rs1040mVO.rsCd }">
	<div class="pop_con type03">
		<!-- 시험물질 정보관리 -->
		<table class="tbl_view mb01">
			<colgroup>
				<col style="width:90px" />
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">연구코드</th>
					<td><c:out value="${rs1040mVO.rsCd }" /></td>
				</tr>
				<tr>
					<th scope="row"><i>*</i>음성대조군여부</th>
					<td>
						<%-- <input name="ncYn" id="ncYn" value="<c:out value="${rs1040mVO.ncYn }" />" class="required" /> --%>
						<input type="radio" name="ncYn" id="ncYn1" value="Y" onchange="fn_dsp($('#ncYn1').val()); return false;"/>
					    <label for="ncYn1">N.C</label>
					    <input type="radio" name="ncYn" id="ncYn2" value="N" onchange="fn_dsp($('#ncYn2').val()); return false;"/>
					    <label for="ncYn2">시험물질</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><i>*</i>시험물질번호</th>
					<td>
						<input name="mtlDsp" id="mtlDsp" value="<c:out value="${fn:substring(rs1040mVO.mtlDsp,1,3) }" />" oninput="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="2" onchange="mtlDspChk(); return false;" class="p15 required" />
					</td>
				</tr>
				<tr>
					<th scope="row"><i>*</i>명칭(N.C)</th>
					<td>
						<div class="check_btn" id="dspnc">
	                       	<!-- NC시험물질 목록(공통코드) CM4000M - CT2080  Squalene MW -->
							<select id="mtlName" name="mtlName" >
								<option value="" <c:if test="${rs1040mVO.mtlName eq '' }">selected="selected"</c:if> >선택</option>
								<c:forEach var="result" items="${ct2080}">
									<option value="${result.cdName}"<c:if test="${result.cdName eq rs1040mVO.mtlName}">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
						</div>
						<div class="check_btn" id="dspmtl">
							<input name="mtlName2" id="mtlName2" value="<c:out value="${rs1040mVO.mtlName }" />" class="required" />
						</div>
                    </td>
                </tr>
				<tr>
					<th scope="row">Lot. No</th>
					<td>
						<input name="lotNo" id="lotNo" value="<c:out value="${rs1040mVO.lotNo }" />" class="required" />
					</td>
				</tr>
				<tr>
					<th scope="row">성상</th>
					<td>
						<input name="mtlShp" id="mtlShp" value="<c:out value="${rs1040mVO.mtlShp }" />" class="required" />
					</td>
				</tr>
				<tr>
					<th scope="row">비고</th>
					<td>
						<input name="remk" id="remk" value="<c:out value="${rs1040mVO.remk }" />" class="required" />
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //시험물질 정보관리 -->
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