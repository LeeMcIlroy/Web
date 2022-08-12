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

$(document).find(".date").removeClass('hasDatepicker').datepicker(); //datepicker appand 시 달력을 다시그려줘야하기땜에 클래스를 삭제하ㅡㄴ다.]

function tmp(){
	var etcs= [];
 	$('select[name=ct2010] option:selected').each(function(item){
 	 etcs.push ($(this).attr('value'));
 		
 	});
 	
 	$('#file_td').append(html);
 	
	 for(var key in etcs)
	 { 
		 if(etcs[key] == "rsImage")
		     	$('#ct2010 option[value = "rsImage"] ').remove();		 
	     if(etcs[key] == "rsPlan") 
				$('#ct2010 option[value = "rsPlan" ] ').remove();
	     if(etcs[key] == "korRpt")
				$('#ct2010 option[value = "korRpt" ] ').remove();				     
	     if(etcs[key] == "draftRpt")
				$('#ct2010 option[value = "draftRpt"]').remove();  
	     if(etcs[key] == "finalRpt")
				$('#ct2010 option[value = "finalRpt"]').remove();	 
	     if(etcs[key] == "engRpt")
				$('#ct2010 option[value = "engRpt" ] ').remove();				     
	     if(etcs[key] == "summary")
				$('#ct2010 option[value = "summary"] ').remove();	     
	     if(etcs[key] == "gita1")
				$('#ct2010 option[value = "gita1" ]  ').remove();	     
	     if(etcs[key] == "gita2")
				$('#ct2010 option[value = "gita2" ]  ').remove();	     
	 }

}
$(document).ready(function(){
	$('.date').datepicker();
	//전역변수 선언 (삭제할 파일 키값담을 배열,보고서이름 담는 배열,보고서등록일 배열)
	var delFile=[];
    var rptName=[];
    var rptDate=[];
    var rptNo=[];

	$('#btn_add').click(function(){
		
		var getSelect = $('#ct2010 option:selected').val(); //선택된 셀렉트박스 값
		var leng = $('select').length; // 셀렉트 박스가 만들어지는 개수로  리밋걸기
		if(getSelect == '선택'){
		 	alert("등록하실 보고서 항목을 선택해주세요.");
			return;
		}
			if(leng < 9){

				var html = '';

				html+= ' <div class="attach_sec type02 mb02" id="attachRpt_div">';
				html+= '<select id="ct2010" name="ct2010" style="width:150px;" >';
				html+= '<option selected="selected">선택</option>';
	    		html+= '<option value="rsImage">연구이미지</option>';
				html+= '<option value="rsPlan">연구계획서</option>';
			    html+= '<option value="draftRpt">초안보고서</option>';						   
			    html+= '<option value="finalRpt">최종보고서</option>';
				html+= '<option value="summary">최종요약문</option>';
			    html+= '<option value="korRpt">국문보고서</option>';
			    html+= '<option value="engRpt">영문보고서</option>';
				html+= '<option value="gita1">기타1</option>';
				html+= '<option value="gita2">기타2</option>';
	    		html+= '</select>';
			
			 	html+= '</div>'; 

					var etcs= [];
				 	$('select[name=ct2010] option:selected').each(function(item){
				 	 etcs.push ($(this).attr('value'));
				 		
				 	});
				 	
				 	$('#file_td').append(html);
				 	
					 for(var key in etcs)
					 { 
						 if(etcs[key] == "rsImage")
						     	$('#ct2010 option[value = "rsImage"] ').remove();		 
					     if(etcs[key] == "rsPlan") 
								$('#ct2010 option[value = "rsPlan" ] ').remove();
					     if(etcs[key] == "korRpt")
								$('#ct2010 option[value = "korRpt" ] ').remove();				     
					     if(etcs[key] == "draftRpt")
								$('#ct2010 option[value = "draftRpt"]').remove();  
					     if(etcs[key] == "finalRpt")
								$('#ct2010 option[value = "finalRpt"]').remove();	 
					     if(etcs[key] == "engRpt")
								$('#ct2010 option[value = "engRpt" ] ').remove();				     
					     if(etcs[key] == "summary")
								$('#ct2010 option[value = "summary"] ').remove();	     
					     if(etcs[key] == "gita1")
								$('#ct2010 option[value = "gita1" ]  ').remove();	     
					     if(etcs[key] == "gita2")
								$('#ct2010 option[value = "gita2" ]  ').remove();	     
					 }

			 $('#ct2010').change(function(){
					
					var html2 ='';
					var selectedValue = $('#ct2010 option:selected').val();
					
 			 		
				  //  $('#ct2010 option[value != '+selectedValue+' ] ').remove(); //선택된 값 제외하고는 다 옵션에서제거
					$('#attachRpt_div').attr('id', ''+selectedValue+'_div'); //div 이름변경  */
					$('#ct2010').attr('id', 'ct2010_'+selectedValue+''); 
					html2+= '<input type="file" id="'+selectedValue+'" name="'+selectedValue+'" onchange="fn_file_add(\''+selectedValue+'\'); return false;" />';
					html2+= '<label for="'+selectedValue+'" id="'+selectedValue+'_label" class="btn_sub">파일업로드</label> '; 
 			 		$('#'+selectedValue+'_div').append(html2);//파일첨부 동적생성
 			 		//처음 선택시에
 			 		 $('#ct2010_'+selectedValue).change(function(){
 	                    var selectedValue2 = $('#ct2010_'+selectedValue+' option:selected').val();
						if(document.getElementById(""+selectedValue2+"dt_div")){
							//해당 아이디닶을가진 셀렉트박스의 옵션을 prop으로 선택항 목르로 변경한다.
							$('#ct2010_'+selectedValue+'').val(selectedValue).prop("selected",true);
							alert("해당보고서는 선택하실 수 없습니다")
							
							return ;
							
						}
						else
						{
		 	                $('#'+selectedValue+'_del').attr('id',$('#ct2010_'+selectedValue+' option:selected').val()+'_del');
	 	                    $('#'+selectedValue+'_div').attr('id', $('#ct2010_'+selectedValue+' option:selected').val()+'_div'); 
	 	                    $("select[name=ct2010]").attr('name','ct2010_'+ $('#ct2010_'+selectedValue+' option:selected').val());
	 	                    $('#ct2010_'+selectedValue).attr('id', 'ct2010_'+$('#ct2010_'+selectedValue+' option:selected').val()); //div 이름변경  */
		 	                $('#'+selectedValue2+'_del').remove(); //첨부된 파일 지우기
		 	 	         //   $('#'+selectedValue+'dt_div').remove();//보고알자 지우기
		 	 	         
		 	 	            $('#'+selectedValue+'dt_div').attr('id', selectedValue2+'dt_div'); 
		 	 	            $('#'+selectedValue+'_dt').attr('id', selectedValue2+'_dt'); 
		 	 	            $('#'+selectedValue+'_date').attr('id', selectedValue2+'_date'); 
		 	 	            $('#'+selectedValue+'_dtspan').attr('id', selectedValue2+'_dtspan'); 
	
		 	 	            $('input[name='+selectedValue+'_dt]').attr('name', selectedValue2+'_dt'); 
		 	 	            $('input[name='+selectedValue+'_date]').attr('name', selectedValue2+'_date'); 
		 	 	            
		 	 	            $('#'+selectedValue2+'_dt').val('');
		 	 	            $('#'+selectedValue2+'_date').val('');
	
		 	 	            $('#'+selectedValue+'_dat').remove();
	
	 	                    $('#'+selectedValue).remove();
	 	                    $('#'+selectedValue+'_label').remove();
						}
 	                    
 	                   var html3 ='';
 	              		   html3+= '<input type="file" id="'+selectedValue2+'" name="'+selectedValue2+'" onchange="fn_file_add(\''+selectedValue2+'\'); return false;" />';
						   html3+= '<label for="'+selectedValue2+'" id="'+selectedValue2+'_label" class="btn_sub">파일업로드</label> '; 
 			 		       $('#'+selectedValue2+'_div').append(html3);//파일첨부 동적생성
 			 				

 			 		//두번째부터 
	 			 		 $('#ct2010_'+selectedValue2).change(function(){
								alert("");
	 			 			  var selectedValue3 = $('#ct2010_'+selectedValue2+' option:selected').val();
	 	               			 	                 
	 	 	                    $('#'+selectedValue2+'_div').attr('id', $('#ct2010_'+selectedValue2+' option:selected').val()+'_div'); 
	 	 	                    $("select[name=ct2010]").attr('name','ct2010_'+ $('#ct2010_'+selectedValue2+' option:selected').val());
	 	 	                    $('#ct2010_'+selectedValue2).attr('id', 'ct2010_'+$('#ct2010_'+selectedValue2+' option:selected').val()); //div 이름변경  */
	 	 	                    $('#'+selectedValue2+'_del').remove();  //첨부된 파일 지우기
	 	 	                    $('#'+selectedValue2+'dt_div').attr('id', '#'+selectedValue3+'dt_div'); 
	 	 	                  
								
	 		 	 	            //$('#'+selectedValue2+'dt_div').remove();//보고알자 지우기
	 	 	                 	
	 	 	                    $('#'+selectedValue2).remove(); 
	 	 	                    $('#'+selectedValue2+'_label').remove();
	 	 	                  
	 	 	                   var html4 ='';
	 	 	              		   html4+= '<input type="file" id="'+selectedValue3+'" name="'+selectedValue3+'" onchange="fn_file_add(\''+selectedValue3+'\'); return false;" />';
	 							   html4+= '<label for="'+selectedValue3+'" id="'+selectedValue3+'_label" class="btn_sub">파일업로드</label> '; 
	 	 			 		       $('#'+selectedValue3+'_div').append(html4);//파일첨부 동적생성
	 	 			 		    selectedValue2=selectedValue3;
	 	 			 			
	 	                })
	 	 			 		 
 	                })
 	                
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
	

})

	//보고서 저장	
	function fn_save(){
		$("#rsNo").val();
	 	$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0501/ech0501Update.do'/>").submit();
	 	$("#"+fileKey+"_div").remove();
	}
	//목록으로
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0501/ech0501List.do'/>";
	}
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
		$("#"+fileKey+"dt_div").remove();
		
		$('#attachRpt_div').remove();
		 

	}
	//보고일자 업데이트
	function fn_updateDate(fileKey,rptNo){
		
		var html ='';
	
		if($('#'+fileKey+'_dt').val()!=null){
			
			$('#'+fileKey+'_dat').remove();
			$('#'+fileKey+'_rptNo').remove();

		}
		$('#'+fileKey+'_date').val( $('#'+fileKey+'_dt').val());
		rptDate=$('#'+fileKey+'_date').val();
		rptNo2 = rptNo;
	    html+= '<input type="hidden" id="'+fileKey+'_dat" name="rptDate"  value="'+rptDate+'"/>';
	    html+= '<input type="hidden" id="'+fileKey+'_rptNo" name="rptNo2"  value="'+rptNo2+'"/>';
	    

		$("#"+fileKey+"dt_div").append(html);
		 

	}

	//파일업로드해서파일선택시
	function fn_file_add(fileKey){

		if(fileCheck_adm(fileKey)){
			var fileValue = $('#'+fileKey).val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
			var html = '';
			var html2 = '';

			html+= '<div id="'+fileKey+'_del">';
			html+= '<span>'+fileName+'</span>';
			html+= '<a href="#" onclick="fn_delfile(\''+fileKey+'\',\'\');">삭제</a>';
			html+= '</div>';
			
		if(!document.getElementById(""+fileKey+"dt_div")){
			

			html2+= '<div class ="attach_sec type02 mb02" id="'+fileKey+'dt_div">';
			html2+= '<label style="margin-left:23%;">보고일자</label>';
			html2+= '<span id="'+fileKey+'_dtspan">'
		    html2+= '<input type="text" name="'+fileKey+'_dt" id="'+fileKey+'_dt"  placeholder="0000-00-00" class="date" title="보고일자" style="width:130px;"/>';
		    html2+= '<input type="hidden"  name="'+fileKey+'_date" id="'+fileKey+'_date" value="'+$('#'+fileKey+'_dt').val()+'"/>';

			html2+=	'</span>';
		 	html2+= '</div>'; 
			$("#date_td").append(html2);
		}

			$("#"+fileKey+"_label").addClass('dpn');

			$("#"+fileKey+"_div").append(html);
			
			$(document).find(".date").removeClass('hasDatepicker').datepicker(); //datepicker appand 시 달력을 다시그려줘야하기땜에 클래스를 삭제하ㅡㄴ다.]
			
			$('#'+fileKey+'_dt').change(function(){
				var html3 ='';
				if($('#'+fileKey+'_dt').val()!=null){
					
					$('#'+fileKey+'_dat').remove();

				}
				$('#'+fileKey+'_date').val( $('#'+fileKey+'_dt').val());
				rptDate=$('#'+fileKey+'_date').val();
			    html3+= '<input type="hidden" id="'+fileKey+'_dat" name="rptDate"  value="'+rptDate+'"/>';
	
				$("#"+fileKey+"dt_div").append(html3);
			})
			
			$('#btn_add').click(function(){
		 			//파일넣기전에 추가버튼 누를시 실행
			  
			    var dateCheck = document.getElementById(fileKey+'_dt').value;
				
			    if(!dateCheck){
			    	
			        $('#attachRpt_div').remove();
			        
			        alert("날짜를 선택해 주세요");
			        return false;
			    }
				
		 	})	
			
	     };
	};

</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>보고서</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="보고서"/>
	            <jsp:param name="dept2" value="보고서관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
	
             <form:form commandName="rs5020mVO" id="listForm" name="listForm">
            </form:form>  
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
                        <td><c:out value="${rs1000mVO[0].rsCd }"/></td>
                        <th scope="row" class="bl">연구명</th>
                        <td><c:out value="${rs1000mVO[0].rsName }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">연구지사</th>
                        <td><c:out value="${rs1000mVO[0].branchNm }"/></td>
                        <th scope="row" class="bl">연구목적</th>
                        <td><c:out value="${rs1000mVO[0].rsPps}"/></td>
                    </tr>                  
                    <tr>
                        <th scope="row">연구기간</th>
                        <td><c:out value="${rs1000mVO[0].rsStdt }"/> ~ <c:out value="${rs1000mVO[0].rsEndt }"/></td>
                        <th scope="row" class="bl">고객사명</th>
                        <td>고객사명이 들어갑니다.</td>
                    </tr>
                    <tr>
                        <th scope="row">IRB계획심의</th>
                        <td><c:out value="${rs1000mVO[0].plrvStdt}"/> ~ <c:out value="${rs1000mVO[0].plrvEddt}"/></td>
                        <th scope="row" class="bl">IRB결과심의</th>
						<td><c:out value="${rs1000mVO[0].rsrvStdt}"/> ~ <c:out value="${rs1000mVO[0].rsrvEddt}"/></td>
                    </tr>
                    <tr>
                        <th scope="row">IRB승인일</th>
                        <td><c:out value="${rs1000mVO[0].rsrvDt }"/></td>
                        <th scope="row" class="bl">심의상태</th>
                        <td><c:out value="${rs1000mVO[0].rvSt }"/></td>
                         
                    </tr>
                </tbody>
            </table>
            <!-- //연구정보 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>보고서 관리</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 보고서 관리 -->
<form:form commandName="rs1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
<input type="hidden" id="rsNo" name="rsNo" value="${rs1000mVO[0].rsNo}">
<input type="hidden" id="dateLockyn" name="dateLockyn" value="${rs1000mVO[0].dateLockyn}">

            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                     <tr>
                        <th scope="row">첨부파일</th>
                        <td colspan="2" id="file_td">
						<c:if test="${attachMap.rsImage.orgFileName != null}">	
	                         <div class="attach_sec type02 mb02" id="rsImage_div">
	                            	 <select name="ct2010" id="ct2010_rsImage"  style="width:150px;">	 
											<c:if test="${rs5020mVO.rsImage.rptCls != null}">
												<option value="rsImage" selected>연구이미지</option>									
											</c:if>	
	                            	</select>
	                            	<c:choose>
	                            		<c:when test="${attachMap.rsImage != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.rsImage.orgFileName }"/></span>
			                            		<a  onclick="fn_delfile('rsImage','<c:out value="${attachMap.rsImage.attachNo }"/>','<c:out value="${rs5020mVO.rsImage.rptNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	<input type="file" id="rsImage" name="rsImage" onchange="fn_file_add('rsImage'); return false;"/>
			                            	<label for="rsImage" id="rsImage_label" class="btn_sub">파일업로드</label>
	                            		</c:otherwise>
	                            	</c:choose>                             	
	                        </div>                
						</c:if>
					<c:if test="${attachMap.rsPlan.orgFileName != null}">	
                            <div class="attach_sec type02 mb02" id="rsPlan_div">
                             	<select name="ct2010" id="ct2010_rsPlan" style="width:150px;">
										<c:if test="${rs5020mVO.rsPlan.rptCls != null}">
											<option value="rsPlan" selected>연구계획서</option>									
										</c:if>		    
                            	</select>
                           		<c:choose>
                            		<c:when test="${attachMap.rsPlan != null }">
		                            	<div>
		                            		<span><c:out value="${attachMap.rsPlan.orgFileName }"/></span>
		                            		<a  onclick="fn_delfile('rsPlan','<c:out value="${attachMap.rsPlan.attachNo }"/>','<c:out value="${rs5020mVO.rsPlan.rptNo }"/>');">삭제</a>
		                            	</div>
                            		</c:when>
                            		<c:otherwise>
		                            	<input type="file" id="rsPlan" name="rsPlan" onchange="fn_file_add('rsPlan'); return false;"/>
		                            	<label for="rsPlan" id="rsPlan_label" class="btn_sub">파일업로드</label>
                            		</c:otherwise>
                            	</c:choose>
                            </div>
					</c:if>
					<c:if test="${attachMap.draftRpt.orgFileName != null}">	
                            <div class="attach_sec type02 mb02" id="draftRpt_div">
                            	<select name="ct2010" id="ct2010_draftRpt" style="width:150px;">
										<c:if test="${rs5020mVO.draftRpt.rptCls != null}">
											<option value="draftRpt" selected>초안보고서</option>									
										</c:if>
                            	</select>
                           		<c:choose>
                            		<c:when test="${attachMap.draftRpt != null }">
		                            	<div>
		                            		<span><c:out value="${attachMap.draftRpt.orgFileName }"/></span>
		                            		<a onclick="fn_delfile('draftRpt','<c:out value="${attachMap.draftRpt.attachNo }"/>','<c:out value="${rs5020mVO.draftRpt.rptNo }"/>');">삭제</a>
		                            	</div>
                            		</c:when>
                            		<c:otherwise>
		                            	<input type="file" id="draftRpt" name="draftRpt" onchange="fn_file_add('draftRpt'); return false;"/>
		                            	<label for="draftRpt" id="draftRpt_label" class="btn_sub">파일업로드</label>
                            		</c:otherwise>
                            	</c:choose>
                            </div>
					</c:if>
					<c:if test="${attachMap.finalRpt.orgFileName != null}">	
                            <div class="attach_sec type02 mb02" id="finalRpt_div">           
                           		<select name="ct2010" id="ct2010_finalRpt" style="width:150px;">
											<c:if test="${rs5020mVO.finalRpt.rptCls != null}">
												<option value="finalRpt" selected>최종보고서</option>									
											</c:if>
                            	</select>
                           		<c:choose>
                            		<c:when test="${attachMap.finalRpt != null }">
		                            	<div>
		                            		<span><c:out value="${attachMap.finalRpt.orgFileName }"/></span>
		                            		<a onclick="fn_delfile('finalRpt','<c:out value="${attachMap.finalRpt.attachNo }"/>','<c:out value="${rs5020mVO.finalRpt.rptNo }"/>');">삭제</a>
		                            	</div>
                            		</c:when>
                            		<c:otherwise>
		                            	<input type="file" id="finalRpt" name="finalRpt" onchange="fn_file_add('finalRpt'); return false;"/>
		                            	<label for="finalRpt" id="finalRpt_label" class="btn_sub">파일업로드</label>
                            		</c:otherwise>
                            	</c:choose>
                         </div>
					</c:if>
					<c:if test="${attachMap.summary.orgFileName != null}">	
                          <div class="attach_sec type02 mb02" id="summary_div">
                           		 <select name="ct2010" id="ct2010_summary" style="width:150px;"> 
										<c:if test="${rs5020mVO.summary.rptCls != null}">
											<option value="summary" selected>최종요약문</option>									
										</c:if>
                            	 </select>
                           		 <c:choose>
                            		<c:when test="${attachMap.summary != null }">
		                            	<div>
		                            		<span><c:out value="${attachMap.summary.orgFileName }"/></span>
		                            		<a  onclick="fn_delfile('summary','<c:out value="${attachMap.summary.attachNo }"/>','<c:out value="${rs5020mVO.summary.rptNo }"/>');">삭제</a>
		                            	</div>
                            		</c:when>
                            		<c:otherwise>
		                            	<input type="file" id="summary" name="summary" onchange="fn_file_add('summary'); return false;"/>
		                            	<label for="summary" id="summary_label" class="btn_sub">파일업로드</label>
                            		</c:otherwise>
                            	 </c:choose>
                          </div>
           			</c:if>
					<c:if test="${attachMap.korRpt.orgFileName != null}">	
                            <div class="attach_sec type02 mb02" id="korRpt_div">
                           		 <select name="ct2010" id="ct2010_korRpt" style="width:150px;">	 
										<c:if test="${rs5020mVO.korRpt.rptCls != null}">
											<option value="korRpt" selected>국문보고서</option>									
										</c:if>
                            	</select>
                           		<c:choose>
                            		<c:when test="${attachMap.korRpt != null }">
		                            	<div>
		                            		<span><c:out value="${attachMap.korRpt.orgFileName }"/></span>
		                            		<a onclick="fn_delfile('korRpt','<c:out value="${attachMap.korRpt.attachNo }"/>','<c:out value="${rs5020mVO.korRpt.rptNo }"/>');">삭제</a>
		                            	</div>
                            		</c:when>
                            		<c:otherwise>
		                            	<input type="file" id="korRpt" name="korRpt" onchange="fn_file_add('korRpt'); return false;"/>
		                            	<label for="korRpt" id="korRpt_label" class="btn_sub">파일업로드</label>
                            		</c:otherwise>
                            	</c:choose>
                            </div>
                   
					</c:if>
					<c:if test="${attachMap.engRpt.orgFileName != null}">	
                            <div class="attach_sec type02 mb02" id="engRpt_div">
                            	<select name="ct2010" id="ct2010_engRpt" style="width:150px;">
										<c:if test="${rs5020mVO.engRpt.rptCls != null}">
											<option value="engRpt" selected>영문보고서</option>									
										</c:if>				
                            	</select>
                           		<c:choose>
                            		<c:when test="${attachMap.engRpt != null }">
		                            	<div>
		                            		<span><c:out value="${attachMap.engRpt.orgFileName }"/></span>
		                            		<a onclick="fn_delfile('engRpt','<c:out value="${attachMap.engRpt.attachNo }"/>','<c:out value="${rs5020mVO.engRpt.rptNo }"/>');">삭제</a>
		                            	</div>
                            		</c:when>
                            		<c:otherwise>
		                            	<input type="file" id="engRpt" name="engRpt" onchange="fn_file_add('engRpt'); return false;"/>
		                            	<label for="engRpt" id="engRpt_label" class="btn_sub">파일업로드</label>
                            		</c:otherwise>
                            	</c:choose>
                            </div>
					</c:if>
					<c:if test="${attachMap.gita1.orgFileName != null}">	
               				
                            <div class="attach_sec type02 mb02" id="gita1_div">
                            	<select name="ct2010" id="ct2010_gita1" style="width:150px;">
										<c:if test="${rs5020mVO.gita1.rptCls != null}">
											<option value="gita1" selected>기타1</option>									
										</c:if>
                            	</select>
                           		<c:choose>
                            		<c:when test="${attachMap.gita1 != null }">
		                            	<div>
		                            		<span><c:out value="${attachMap.gita1.orgFileName }"/></span>
		                            		<a onclick="fn_delfile('gita1','<c:out value="${attachMap.gita1.attachNo }"/>','<c:out value="${rs5020mVO.gita1.rptNo }"/>');">삭제</a>
		                            	</div>
                            		</c:when>
                            		<c:otherwise>
		                            	<input type="file" id="gita1" name="gita1" onchange="fn_file_add('gita1'); return false;"/>
		                            	<label for="gita1" id="gita1_label" class="btn_sub">파일업로드</label>
                            		</c:otherwise>
                            	</c:choose>
                            </div>
                    </c:if>
                    <c:if test="${attachMap.gita2.orgFileName != null}">	       
                            <div class="attach_sec type02 mb02" id="gita2_div">
                            	<select name="ct2010" id="ct2010_gita2" style="width:150px;">
										<c:if test="${rs5020mVO.gita2.rptCls != null}">
											<option value="gita2" selected>기타2</option>									
										</c:if>
                            	</select>
                           		<c:choose>
                            		<c:when test="${attachMap.gita2 != null }">
		                            	<div>
		                            		<span><c:out value="${attachMap.gita2.orgFileName }"/></span>
		                            		<a onclick="fn_delfile('gita2','<c:out value="${attachMap.gita2.attachNo }"/>','<c:out value="${rs5020mVO.gita2.rptNo }"/>');">삭제</a>
		                            	</div>
                            		</c:when>
                            		<c:otherwise>
		                            	<input type="file" id="gita2" name="gita2" onchange="fn_file_add('gita2'); return false;"/>
		                            	<label for="gita2" id="gita2_label" class="btn_sub">파일업로드</label>
                            		</c:otherwise>
                            	</c:choose>
                            </div>               
                    </c:if>

                   		 <td id="date_td">
	                   		  <c:if test="${attachMap.rsImage.regDate != null}">	   
	                   		 		<div class="attach_sec type02 mb02" id="rsImagedt_div">
		                   		 		<label style="margin-left:23%;">보고일자</label>
		                   		 		<input type="text" name="rsImage_dt" id="rsImage_dt" value="${rs5020Map.rsImage.rptDt}" class="date" onchange="fn_updateDate('rsImage','<c:out value="${rs5020mVO.rsImage.rptNo }"/>');"  class="date"  style="width:130px;"/>
		                   		 		
		                   		 		<span id="rsImage_dtspan">
		                   		 			<input type="hidden" name="rsImage_date" id="rsImage_date" value="">
		                   		 		</span>
	                   		 		</div>
	                   		 </c:if>
	                   		  <c:if test="${attachMap.rsPlan.regDate != null}">	   
	                   		 		<div class="attach_sec type02 mb02" id="rsPlandt_div">
	                   		 			<label style="margin-left:23%;">보고일자</label>
										<input type="text" id="rsPlan_dt" name="rsPlan_dt" value="${rs5020Map.rsPlan.rptDt}" class="date" onchange="fn_updateDate('rsPlan','<c:out value="${rs5020mVO.rsPlan.rptNo }"/>');" style="width:130px;">                   		 	
										
										<span id="rsPlan_dtspan">
											<input type="hidden" name="rsPlan_date" id="rsPlan_date" value="">
										</span>
									</div>
									
	                   		 </c:if>
	                   		 <c:if test="${attachMap.draftRpt.regDate != null}">	                    		 	
	                   		 		<div class="attach_sec type02 mb02" id="draftRptdt_div">
	                   		 			<label style="margin-left:23%;">보고일자</label>
										<input type="text" id="draftRpt_dt" name="draftRpt_dt"  value="${rs5020Map.draftRpt.rptDt}" class="date" onchange="fn_updateDate('draftRpt','<c:out value="${rs5020mVO.draftRpt.rptNo }"/>');" style="width:130px; ">                   		 	
	                   		 		
	                   		 			<span id="draftRpt_dtspan">
											<input type="hidden" name="draftRpt_date" id="draftRpt_date" value="">
										</span>
	                   		 		</div>
	                   		 </c:if>                		 
	                 		 <c:if test="${attachMap.finalRpt.regDate != null}">	                    		 	
	                   		 		<div class="attach_sec type02 mb02" id="finalRptdt_div">
	                   		 			<label style="margin-left:23%;">보고일자</label>
										<input type="text" id="finalRpt_dt" name="finalRpt_dt" value="${rs5020Map.finalRpt.rptDt}"  class="date" onchange="fn_updateDate('finalRpt','<c:out value="${rs5020mVO.finalRpt.rptNo }"/>');" style="width:130px; ">      
	                   		 			
	                   		 			<span id="finalRpt_dtspan">
											<input type="hidden" name="finalRpt_date" id="finalRpt_date" value="">
										</span>
	                   		 		</div>
	                   		 </c:if>	
	                   		 <c:if test="${attachMap.summary.regDate != null}">	                    		 	
	                   		 		<div class="attach_sec type02 mb02" id="summarydt_div">
	                   		 			<label style="margin-left:23%;">보고일자</label>
										<input type="text" id="summary_dt" name="summary_dt" value="${rs5020Map.summary.rptDt}" class="date" onchange="fn_updateDate('summary','<c:out value="${rs5020mVO.summary.rptNo }"/>');" style="width:130px; ">      
	                   		 			
	                   		 			<span id="summary_dtspan">
											<input type="hidden" name="summary_date" id="summary_date" value="">
										</span>
	                   		 		</div>
	                   		 </c:if>
	                   		 <c:if test="${attachMap.korRpt.regDate != null}">	                    		 	
	                   		 		<div class="attach_sec type02 mb02" id="korRptdt_div">
	                   		 			<label style="margin-left:23%;">보고일자</label>
										<input type="text" id="korRpt_dt" name="korRpt_dt" value="${rs5020Map.korRpt.rptDt}" class="date" onchange="fn_updateDate('korRpt','<c:out value="${rs5020mVO.korRpt.rptNo }"/>');" style="width:130px; ">      
	                   		 			
	                   		 			<span id="korRpt_dtspan">
											<input type="hidden" name="korRpt_date" id="korRpt_date" value="">
										</span>
	                   		 		</div>
	                   		 </c:if>
	                   		 <c:if test="${attachMap.engRpt.regDate != null}">	                    		 			 	
	                   		 		<div class="attach_sec type02 mb02" id="engRptdt_div">
	                   		 			<label style="margin-left:23%;">보고일자</label>
										<input type="text" id="engRpt_dt" name="engRpt_dt" value="${rs5020Map.engRpt.rptDt}" class="date" onchange="fn_updateDate('engRpt','<c:out value="${rs5020mVO.engRpt.rptNo }"/>');"  style="width:130px; ">      
	                   		 		
	                   		 			<span id="engRpt_dtspan">
											<input type="hidden" name="engRpt_date" id="engRpt_date" value="">
										</span>
	                   		 		</div>
	                   		 </c:if>
	                   		 <c:if test="${attachMap.gita1.regDate != null}">	                    		 	
	                   		 	
	                   		 		<div class="attach_sec type02 mb02" id="gita1dt_div">
	                   		 			<label style="margin-left:23%;">보고일자</label>
										<input type="text" id="gita1_dt" name="gita1_dt" value="${rs5020Map.gita1.rptDt}" class="date" onchange="fn_updateDate('gita1','<c:out value="${rs5020mVO.gita1.rptNo }"/>');" style="width:130px; ">      
	                   		 		
	                   		 			<span id="gita1_dtspan">
											<input type="hidden" name="gita1_date" id="gita1_date" value="">
										</span>
	                   		 		</div>
	                  		 </c:if>
	                   		 <c:if test="${attachMap.gita2.regDate != null}">	                    		 	        		 	
	                   		 		<div class="attach_sec type02 mb02" id="gita2dt_div">
	                   		 			<label style="margin-left:23%;">보고일자</label>
										<input type="text" id="gita2_dt" name="gita2_dt" value="${rs5020Map.gita2.rptDt}" class="date" onchange="fn_updateDate('gita2','<c:out value="${rs5020mVO.gita2.rptNo }"/>');" style="width:130px; ">      
		                   		 		
		                   		 		<span id="gita2_dtspan">
											<input type="hidden" name="gita2_date" id="gita2_date" value="">
										</span>
		                   		 	
		                   		 	</div>
	                   		 </c:if>
                   		 </td>
                    </tr>
                  
                </tbody>
            </table>
  </form:form>
           
			<!-- 버튼 -->
			<div class="btn_area">
			 	<a href="#" class="btn_sub" onclick="history.back();">이전</a> 
				<a onclick="fn_save();">저장</a>
				<a  id="btn_add">추가</a>
			</div>
			<!-- //버튼 -->
			<div>
				<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
			
			</div>
		</div>
		<!-- //contents -->
	</div>
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>