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
		var actchk = '<c:out value="${act }" />';
		if(actchk == "Y") {
			opener.parent.location.reload();
			window.close();
		}
		var delFile=[];
	    var rptName=[];
		
		$('#btn_add').click(function(){
			
			var getSelect = $('#ct2010 option:selected').val(); //선택된 셀렉트박스 값
			var leng = $('select').length; // 셀렉트 박스가 만들어지는 개수로  리밋걸기
			if(getSelect == '선택'){
			 	alert("등록하실 동의서 항목을 선택해주세요.");
				return;
			}
				if(leng < 2){
					var html = '';
					html+= ' <div class="attach_sec type02 mb02" id="attachRpt_div">';
					html+= '<select id="ct2010" name="ct2010" style="width:150px;" >';
					html+= '<option selected="selected">선택</option>';
		    		html+= '<option value="prIcf">개인정보제공동의서</option>';
					html+= '<option value="rsIcf">연구참여동의서</option>';
		    		html+= '</select>';
				 	html+= '</div>'; 

				 	var etcs= [];
				 	$('select[name=ct2010] option:selected').each(function(item){
				 		etcs.push ($(this).attr('value'));
				 	});
					 	
					 	$('#file_td').append(html);
						 for(var key in etcs)
						 { 
							 if(etcs[key] == "prIcf")
							     	$('#ct2010 option[value = "prIcf"] ').remove();		 
						     if(etcs[key] == "rsIcf") 
									$('#ct2010 option[value = "rsIcf" ] ').remove();
						  }

				 $('#ct2010').change(function(){
						var html2 ='';
						var selectedValue = $('#ct2010 option:selected').val();
	 			 		
					    $('#ct2010 option[value != '+selectedValue+' ] ').remove(); //선택된 값 제외하고는 다 옵션에서제거
						$('#attachRpt_div').attr('id', ''+selectedValue+'_div'); //div 이름변경  */
						$('#ct2010').attr('id', 'ct2010_'+selectedValue+''); 
						html2+= '<input type="file" id="'+selectedValue+'" name="'+selectedValue+'" onchange="fn_file_add(\''+selectedValue+'\'); return false;" />';
						html2+= '<label for="'+selectedValue+'" id="'+selectedValue+'_label" class="btn_sub">파일업로드</label> '; 
	 			 		$('#'+selectedValue+'_div').append(html2);//파일첨부 동적생성
	 			 	
	 			 		$('#btn_add').click(function(){
	 			 			//파일넣기전에 추가버튼 누를시 실행
						    var fileCheck = document.getElementById(selectedValue).value;
						    if(!fileCheck){
						        $('#attachRpt_div').remove();
						        alert("파일을 첨부해 주세요");
						        return false;
						    }
						  
	 			 		})
	 			 		
						var previous = selectedValue ;
						if(previous != ''){
							$('#ct2010').live('click', function () {
							        //update previous value
							        previous = $(this).val();
							    }).change(function() {
							    	
									var temp = $('#ct2010 option:selected').val();
								
									$('#'+previous+'_div').attr('id',temp+'_div');  // 이전값의 div id를 현재 선택된 값으로 바까줌
							        $('input#'+previous+'').removeAll(); //이전값 input 태그 삭제
									$('label#'+previous+'_label').removeAll(); //이전값 라벨태그 삭제
									
								    html2+= '<input type="file" id="'+temp+'" name="'+temp+'" onchange="fn_file_add(\''+temp+'\'); return false;" />';
									html2+= '<label for="'+temp+'" id="'+temp+'_label" class="btn_sub">파일업로드</label> '; 
									$('#'+temp+'_div').append(html2); 
						    	}); 		
						}	
				 });// $('#ct2010').change End
					
				}else{
					return;
				}
		})

	});

	//파일삭제
	function fn_delfile(fileKey, seq ,rptNo){
		var html = '';
		if(seq != ''){
			delFile= seq;
			html += '<input type="hidden" id="delFile" name="delFile" value="'+delFile+'"/>'; //파일테이블 번호
			html += '<input type="hidden" id="rptNo" name="rptNo" value="'+rptNo+'"/>'; //보고서 태이블 번호
			$("#file_td").append(html);
		}
		html += '<input type="file" id="'+fileKey+'" name="'+fileKey+'" onchange="fn_file_add(\''+fileKey+'\'); return false;"/>';
		html += '<label for="'+fileKey+'" id="'+fileKey+'_label" class="btn_sub">파일업로드</label>';
		$("#"+fileKey+"_div").remove();
		
		 $('#attachRpt_div').remove();
		 

	}

	//파일업로드해서파일선택시
	function fn_file_add(fileKey){
		
		if(fileCheck_adm(fileKey)){
			var fileValue = $('#'+fileKey).val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
			var html = '';
			
			html+= '<div>';
			html+= '<span>'+fileName+'</span>';
			html+= '<a href="#" onclick="fn_delfile(\''+fileKey+'\',\'\');">삭제</a>';
			html+= '</div>';
			
			$("#"+fileKey+"_label").addClass('dpn');
			
			$("#"+fileKey+"_div").append(html);
			
	     }
	}
	
	function fn_step(){
		if(confirm('연구대상자의 동의서를 저장합니다.\r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			var subNo = $("#subNo").val();
			
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0206/ech0206AjaxSaveIcf.do'/>"
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
	
	
	//보고서 저장	
	function fn_save(){
	 	$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0206/ech0206IcfUpdate.do'/>").submit();
	 	$("#"+fileKey+"_div").remove();
	}
	
	
</script>
<body>
<!-- pop_wrap -->
<div class="pop_wrap">
	<!-- pop_header -->
	<div class="pop_header">
		<h1 class="hidden"><a href="#">H&amp;Bio</a></h1>
		<h2>동의서첨부관리</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<form:form commandName="cr4000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${cr4000mVO.corpCd}">
			<input type="hidden" id="rsNo" name="rsNo" value="${cr4000mVO.rsNo eq ''?rsNo:cr4000mVO.rsNo}">
			<input type="hidden" id="subNo" name="subNo" value="${cr4000mVO.subNo eq ''?subNo:cr4000mVO.subNo}">
			<input type="hidden" id="pricfYn" name="pricfYn" value="${cr4000mVO.pricfYn eq ''?pricfYn:cr4000mVO.pricfYn}">
			<input type="hidden" id="rsicfYn" name="rsicfYn" value="${cr4000mVO.rsicfYn eq ''?rsicfYn:cr4000mVO.rsicfYn}">
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<div class="pop_con type02">
		<!-- 동의서관리 -->
		<table class="tbl_view mb01">
			<colgroup>
				<col style="width:200px" />				
				<col style="width:500px" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">연구코드</th>
					<td><c:out value="${cr4000mVO.rsCd }" /></td>					
				</tr>
				<tr>
					<th scope="row">연구대상자</th>
					<td><c:out value="${cr4000mVO.rsjName }" /></td>					
				</tr>
				<tr>
	                <th scope="row">첨부파일</th>
                    <td id="file_td">
						<c:if test="${attachMap.prIcf.orgFileName != null}">	
	                    	<div class="attach_sec type02 mb02" id="prIcf_div">
	                         	<select name="ct2010" id="ct2010_prIcf"  style="width:150px;">	 
									<c:if test="${rs5020mVO.prIcf.rptCls != null}">
										<option value="prIcf" selected>개인정보제공동의서</option>									
									</c:if>	
	                            </select>
	                            <c:choose>
	                            	<c:when test="${attachMap.prIcf != null }">
			                        	<div>
			                            	<span><c:out value="${attachMap.prIcf.orgFileName }"/></span>
			                            	<a href="#" onclick="fn_delfile('prIcf','<c:out value="${attachMap.prIcf.attachNo }"/>','<c:out value="${rs5020mVO.prIcf.rptNo }"/>');">삭제</a>
			                            </div>
	                            	</c:when>
	                            	<c:otherwise>
		                            	<input type="file" id="prIcf" name="prIcf" onchange="fn_file_add('prIcf'); return false;"/>
		                            	<label for="prIcf" id="prIcf_label" class="btn_sub">파일업로드</label>
	                            	</c:otherwise>
	                            </c:choose>
	                        </div>                
						</c:if>
						<c:if test="${attachMap.rsIcf.orgFileName != null}">	
                            <div class="attach_sec type02 mb02" id="rsIcf_div">
                             	<select name="ct2010" id="ct2010_rsIcf" style="width:150px;">
									<c:if test="${rs5020mVO.rsIcf.rptCls != null}">
										<option value="rsIcf" selected>연구참여동의서</option>									
									</c:if>		    
                            	</select>
                           		<c:choose>
                            		<c:when test="${attachMap.rsIcf != null }">
		                            	<div>
		                            		<span><c:out value="${attachMap.rsIcf.orgFileName }"/></span>
		                            		<a href="#" onclick="fn_delfile('rsIcf','<c:out value="${attachMap.rsIcf.attachNo }"/>','<c:out value="${rs5020mVO.rsIcf.rptNo }"/>');">삭제</a>
		                            	</div>
                            		</c:when>
                            		<c:otherwise>
		                            	<input type="file" id="rsIcf" name="rsIcf" onchange="fn_file_add('rsIcf'); return false;"/>
		                            	<label for="rsIcf" id="rsIcf_label" class="btn_sub">파일업로드</label>
                            		</c:otherwise>
                            	</c:choose>
                            </div>
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //파일첨부관리 -->
		</form:form>
		<div>
			<span style="color:red;">* 파일 삭제시는 첨부된 파일을 삭제한 후 아래 '저장' 버튼을 눌러주세요. </span>
		<div>
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="javascript:window.close();" class="type02">취소</a>
			<a href="#" onclick="fn_save(); return false;" >저장</a>
			<a id="btn_add" class="type02">파일첨부</a>
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