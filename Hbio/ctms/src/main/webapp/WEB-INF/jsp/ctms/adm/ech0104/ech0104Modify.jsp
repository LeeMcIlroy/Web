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
	
		var ynVal = '<c:out value="${rs5000mVO.rvCls}"/>';
		switch (ynVal) {
			case '1':
				$("#rvCls1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rvCls2").attr('checked', 'checked');
		    	break;
		  	default:
		     	console.log(`Sorry, we are out of ${expr}.`);
		}
		
		var ynVal = '<c:out value="${rs5000mVO.rvdocCls}"/>';
		switch (ynVal) {
			case '1':
				$("#rvdocCls1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rvdocCls2").attr('checked', 'checked');
		    	break;
			case '3':
				$("#rvdocCls3").attr('checked', 'checked');
		    	break;	
		  	default:
		     	console.log(`Sorry, we are out of ${expr}.`);
		}
		
		var ynVal = '<c:out value="${rs5000mVO.rvSt}"/>';
		switch (ynVal) {
			case '1':
				$("#rvSt1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rvSt2").attr('checked', 'checked');
		    	break;				
		  	default:
		     	console.log(`Sorry, we are out of ${expr}.`);
		}
		
		var ynVal = '<c:out value="${rs5000mVO.rvRs}"/>';
		switch (ynVal) {
			case '1':
				$("#rvRs1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rvRs2").attr('checked', 'checked');
		    	break;				
		  	default:
		     	console.log(`Sorry, we are out of ${expr}.`);
		}

		var delFile=[];
	    var rptName=[];
	    
		$('#btn_add').click(function(){
		 	
			var getSelect = $('#ct2010 option:selected').val(); //선택된 셀렉트박스 값
			var leng = $('select').length; // 셀렉트 박스가 만들어지는 개수로  리밋걸기

			
			if(getSelect == '선택'){
			 	alert("등록하실 보고서 항목을 선택해주세요.");
				return;
			}
			if(leng < 4){
				
				var html = '';
				html+= ' <div class="attach_sec type02 mb02" id="attachRpt_div">';
				html+= '<select id="ct2010" name="ct2010" style="width:150px;" >';
				html+= '<option selected="selected">선택</option>';
	    		html+= '<option value="irbplan">IRB신규계획서</option>';
				html+= '<option value="irbresult">IRB결과보고서</option>';
			    html+= '<option value="irbcfm">승인통보서</option>';
			    html+= '<option value="irbrj">보완통보서</option>';
	    		html+= '</select>';
			 	html+= '</div>'; 
				
			 	var etcs= [];
			 	$('select[name=ct2010] option:selected').each(function(item){
			 	 etcs.push ($(this).attr('value'));
			 		
			 	});
			 	
			 	$('#file_td').append(html);

			 	
				 for(var key in etcs)
				 { 
					 if(etcs[key] == "irbplan")
					     	$('#ct2010 option[value = "irbplan"] ').remove();		 
				     if(etcs[key] == "irbresult") 
							$('#ct2010 option[value = "irbresult" ] ').remove();
				     if(etcs[key] == "irbcfm")
							$('#ct2010 option[value = "irbcfm" ] ').remove();				     
				     if(etcs[key] == "irbrj")
							$('#ct2010 option[value = "irbrj"]').remove();
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

	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech010403.do'/>"
					, '제품사용체크결과', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0104/ech0104List.do'/>";
	}
	
	function fn_update(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var regDt = $('#datepicker01').val();
			
		if(regDt==''){
			alert('심의접수일을 입력해주세요.')
			$('#datepicker01').focus();
			return;
		}
			
		$("#rvNo1").removeAttr('disabled');
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0104/ech0104Update.do'/>").submit();
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
			
	     };
	};
	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>연구관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="연구관리"/>
	            <jsp:param name="dept2" value="IRB심의"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<form:form commandName="rs5000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${rs5000mVO.corpCd}">
				<input type="hidden" id="rsNo" name="rsNo" value="${rs5000mVO.rsNo eq ''?rsNo:rs5000mVO.rsNo}">
				<input type="hidden" id="rvNo" name="rvNo" value="${rs5000mVO.rvNo eq ''?rvNo:rs5000mVO.rvNo}">
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
					<%-- <tr>
						<th scope="row">고객사명</th>
						<td><c:out value="${rs1000mVO.vendName }" /></td>
						<th scope="row" class="bl">담당자</th>
						<td><c:out value="${rs1000mVO.vmngName }" />,<c:out value="${rs1000mVO.vmnghpNo }" />,<c:out value="${rs1000mVO.vmngEmail }" /></td>
					</tr> --%>
				</tbody>
            </table>
            <!-- //연구정보 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>IRB 심의정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- IRB 심의정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">IRB심의번호</th>
                        <td colspan="3">
                            <!-- <input type="text" class="p15" value="HBABN01" id="rvNo1" name="rvNo1" disabled="disabled" /> -->
                            <input type="text" class="p15" value="<c:out value="${rs5000mVO.rvNo1 }" />" id="rvNo1" name="rvNo1" disabled="disabled" />
                            -
                            <input type="text" value="<c:out value="${rs5000mVO.rvNo2 }" />"  class="p15" id="rvNo2" name="rvNo2" placeholder="신청년월(210101)" maxlength="6"/>
                            -
                            <input type="text" value="<c:out value="${rs5000mVO.rvNo3 }" />"  class="p15" id="rvNo3" name="rvNo3" placeholder="심의종류(HR)" maxlength="2"/>                             
                            -
                            <input type="text" value="<c:out value="${rs5000mVO.rvNo4 }" />"  class="p15" id="rvNo4" name="rvNo4" placeholder="일련번호(0000)" maxlength="4"/>
                            -
                            <input type="text" value="<c:out value="${rs5000mVO.rvNo5 }" />"  class="p15" id="rvNo5" name="rvNo5" placeholder="관리번호(00)" maxlength="2"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">심의종류</th>
                        <td>
							<input type="radio" name="rvCls" id="rvCls1" value="1" />
							<label for="rvCls1">신속</label>
							<input type="radio" name="rvCls" id="rvCls2" value="2" />
							<label for="rvCls2">정규</label>
                        </td>
                        <th scope="row" class="bl">심의문서</th>
                        <td>
                            <input type="radio" name="rvdocCls" id="rvdocCls1" value="1"/>
							<label for="rvdocCls1">신규계획</label>
							<input type="radio" name="rvdocCls" id="rvdocCls2" value="2"/>
							<label for="rvdocCls2">결과보고</label>
							<input type="radio" name="rvdocCls" id="rvdocCls3" value="3"/>
							<label for="rvdocCls3">기타</label>
							&nbsp;<input type="text" class="p40" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">심의상태</th>
                        <td>
							<input type="radio" name="rvSt" id="rvSt1" value="1"/>
							<label for="rvSt1">심의중</label>
							<input type="radio" name="rvSt" id="rvSt2" value="2"/>
							<label for="rvSt2">완료</label>
                        </td>
                        <th scope="row" class="bl">심의결과</th>
                        <td>
                            <input type="radio" name="rvRs" id="rvRs1" value="1"/>
							<label for="rvRs1">승인</label>
							<input type="radio" name="rvRs" id="rvRs2" value="2"/>
							<label for="rvRs2">보완</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">심의접수일</th>
                        <td>
							<div class="date_sec">
								<span>
									<input name="rvDt" id="datepicker01" placeholder="0000-00-00" value="<c:out value="${rs5000mVO.rvDt }" />" class="date required" title="접수일자" />
									<label for="datepicker01" class="btn_cld">날짜검색</label>
								</span>
							</div>
                        </td>
                        <th scope="row" class="bl">계획승인일</th>
                        <td>
                            <div class="date_sec">
								<span>
									<input name="plrvDt" id="datepicker02" placeholder="0000-00-00" value="<c:out value="${rs5000mVO.plrvDt }" />" class="date required" title="계획승인일" />
									<label for="datepicker02" class="btn_cld">날짜검색</label>
								</span>
							</div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">변경승인일</th>
                        <td>
							<div class="date_sec">
								<span>
									<input name="chrvDt" id="datepicker03" placeholder="0000-00-00" value="<c:out value="${rs5000mVO.chrvDt }" />" class="date required" title="변경승인일" />
									<label for="datepicker03" class="btn_cld">날짜검색</label>
								</span>
							</div>
                        </td>
                        <th scope="row" class="bl">종료승인일</th>
                        <td>
                            <div class="date_sec">
								<span>
									<input name="rsrvDt" id="datepicker04" placeholder="0000-00-00" value="<c:out value="${rs5000mVO.rsrvDt }" />" class="date required" title="종료승인일" />
									<label for="datepicker04" class="btn_cld">날짜검색</label>
								</span>
							</div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">IRB 계획심의</th>
                        <td>
							<div class="date_sec">
								<span>
									<input name="plrvStdt" id="datepicker05" placeholder="0000-00-00" value="<c:out value="${rs5000mVO.plrvStdt }" />" class="date required" title="계획심의시작일" />
									<label for="datepicker05" class="btn_cld">날짜검색</label>
								</span>
								<em>~</em>
								<span>
									<input name="plrvEddt" id="datepicker06" placeholder="0000-00-00" value="<c:out value="${rs5000mVO.plrvEddt }" />" class="date required" title="계획심의종료일" />
									<label for="datepicker06" class="btn_cld">날짜검색</label>
								</span>
							</div>
                        </td>
                        <th scope="row" class="bl">IRB 결과심의</th>
                        <td>
                            <div class="date_sec">
								<span>
									<input name="rsrvStdt" id="datepicker07" placeholder="0000-00-00" value="<c:out value="${rs5000mVO.rsrvStdt }" />" class="date required" title="종료심의시작일" />
									<label for="datepicker07" class="btn_cld">날짜검색</label>
								</span>
								<em>~</em>
								<span>
									<input name="rsrvEddt" id="datepicker08" placeholder="0000-00-00" value="<c:out value="${rs5000mVO.rsrvEddt }" />" class="date required" title="종료심의종료일" />
									<label for="datepicker08" class="btn_cld">날짜검색</label>
								</span>
							</div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //IRB 심의정보 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>첨부파일</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 첨부파일 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                     <td colspan="4" id="file_td">
						<c:if test="${attachMap.irbplan.orgFileName != null}">	
	                         <div class="attach_sec type02 mb02" id="irbplan_div">
	                            	 <select name="ct2010" id="ct2010_irbplan"  style="width:150px;">	 
											<c:if test="${rs5020mVO.irbplan.rptCls != null}">
												<option value="irbplan" selected>IRB신규계획서</option>									
											</c:if>	
	                            	</select>
	                            	<c:choose>
	                            		<c:when test="${attachMap.irbplan != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.irbplan.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('irbplan','<c:out value="${attachMap.irbplan.attachNo }"/>','<c:out value="${rs5020mVO.irbplan.rptNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	<input type="file" id="irbplan" name="irbplan" onchange="fn_file_add('irbplan'); return false;"/>
			                            	<label for="irbplan" id="irbplan_label" class="btn_sub">파일업로드</label>
	                            		</c:otherwise>
	                            	</c:choose> 
	                        </div>                
						</c:if>                    
						<c:if test="${attachMap.irbresult.orgFileName != null}">	
	                         <div class="attach_sec type02 mb02" id="irbresult_div">
	                            	 <select name="ct2010" id="ct2010_irbresult"  style="width:150px;">	 
											<c:if test="${rs5020mVO.irbresult.rptCls != null}">
												<option value="irbresult" selected>IRB결과보고서</option>									
											</c:if>	
	                            	</select>
	                            	<c:choose>
	                            		<c:when test="${attachMap.irbresult != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.irbresult.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('irbresult','<c:out value="${attachMap.irbresult.attachNo }"/>','<c:out value="${rs5020mVO.irbresult.rptNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	<input type="file" id="irbresult" name="irbresult" onchange="fn_file_add('irbresult'); return false;"/>
			                            	<label for="irbresult" id="irbresult_label" class="btn_sub">파일업로드</label>
	                            		</c:otherwise>
	                            	</c:choose> 
	                        </div>                
						</c:if>                    
                    	<c:if test="${attachMap.irbcfm.orgFileName != null}">	
	                         <div class="attach_sec type02 mb02" id="irbcfm_div">
	                            	 <select name="ct2010" id="ct2010_irbcfm"  style="width:150px;">	 
											<c:if test="${rs5020mVO.irbcfm.rptCls != null}">
												<option value="irbcfm" selected>승인통보서</option>									
											</c:if>	
	                            	</select>
	                            	<c:choose>
	                            		<c:when test="${attachMap.irbcfm != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.irbcfm.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('irbcfm','<c:out value="${attachMap.irbcfm.attachNo }"/>','<c:out value="${rs5020mVO.irbcfm.rptNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	<input type="file" id="irbcfm" name="irbcfm" onchange="fn_file_add('irbcfm'); return false;"/>
			                            	<label for="irbcfm" id="irbcfm_label" class="btn_sub">파일업로드</label>
	                            		</c:otherwise>
	                            	</c:choose> 
	                        </div>                
						</c:if>
                    	<c:if test="${attachMap.irbrj.orgFileName != null}">	
	                         <div class="attach_sec type02 mb02" id="irbrj_div">
	                            	 <select name="ct2010" id="ct2010_irbrj"  style="width:150px;">	 
											<c:if test="${rs5020mVO.irbrj.rptCls != null}">
												<option value="irbrj" selected>보완통보서</option>									
											</c:if>	
	                            	</select>
	                            	<c:choose>
	                            		<c:when test="${attachMap.irbrj != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.irbrj.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('irbrj','<c:out value="${attachMap.irbrj.attachNo }"/>','<c:out value="${rs5020mVO.irbrj.rptNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	<input type="file" id="irbrj" name="irbrj" onchange="fn_file_add('irbrj'); return false;"/>
			                            	<label for="irbrj" id="irbrj_label" class="btn_sub">파일업로드</label>
	                            		</c:otherwise>
	                            	</c:choose> 
	                        </div>                
						</c:if>
						</td>
						</tr>
                </tbody>
            </table>
            <!-- //첨부파일 -->
            </form:form>
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_update(); return false;" >저장</a>
				<a  id="btn_add">파일추가</a>
			</div>
			<!-- //버튼 -->
		</div>
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
		<!-- //contents -->
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