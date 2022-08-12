<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	
	$(function(){
	
		var ynAdmin = '<c:out value="${rs3000mVO.isAdminType}"/>';
		var ynDrt = '<c:out value="${rs3000mVO.isRsDrt}"/>';
		var ynStaff = '<c:out value="${rs3000mVO.isRsStaff}"/>';
		
		
		if(ynDrt=="N") {
			if(ynStaff=="Y") {
				$("#data_lock").hide();
				$("#data_lock").attr('disabled', 'true');
			}else{
				if(ynAdmin=="1") {
					$("#data_lock").hide();
					$("#data_lock").attr('disabled', 'true');
				}else{
					$("#btnDel").hide();
					$("#btnModi").hide();
					$("#data_lock").hide();
					$("#data_lock").attr('disabled', 'true');
					
					//참여지사 목록
					$("#btnRegBr").hide();
					$("#btnDelBr").hide();
					$(".btnModiBr").attr('onclick', '').unbind('click');			
					
					//참여연구담당자 목록
					$("#btnRegSt").hide();
					$("#btnDelSt").hide();
					$(".btnModiSt").attr('onclick', '').unbind('click');
					}
			}
		}
	
		//삭제불가능 "N" - 삭제 x
		var ynDel = '<c:out value="${rs3000mVO.isDelCntr}"/>';
		if(ynDel=="N") {
			$("#btnDel").hide();
		}
		
		// 수거여부 Y 수거 N 미수거
		var reYn = '<c:out value="${rs3000mVO.reYn}"/>';
		switch (reYn) {
			case 'Y':
				$("#reYn1").attr('checked', 'checked');
		    	break;
			case 'N':
				$("#reYn2").attr('checked', 'checked');
		    	break;			    	
		  default:
		    console.log(`Sorry, we are out of ${expr}.`);
		}
		
		
		
	});

	// data_lock 설정  Y, N 
	function fn_setDataLock(lock){
		if(lock == 'Y') {
			if(confirm('DATA LOCK을 설정합니다. LOCK설정된 후 복구가 되지 않습니다. \r\n저장하시겠습니까?')){
				var corpCd = $("#corpCd").val();
				var csNo = $("#csNo").val();	
				
				$.ajax({
					url: "<c:url value='/qxsepmny/ech0106/ech0106AjaxDataLock.do'/>"
					, type: "post"
					, data: "corpCd="+corpCd+"&"+"csNo="+csNo+"&"+"lock="+lock
					, dataType:"json"
					, success: function(data){
						var status = data.status;
						var message = data.message;
						alert(message);
					}, error: function(){
						alert("오류가 발생하였습니다.");
					}
				});
			} else {
				
				//취소를 한 경우 LOCK 버튼을 해지해야 함.
				$("input[name=data_lock]").attr( 'checked', false );				
			}	
			
		} else {

		
		
		}
	}
	
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100501.do'/>"
					, '관리자 조회', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	function fn_list(){
		$("#frm2").attr("action","<c:url value='/qxsepmny/ech0106/ech0106List.do'/>").submit();
	}	
	
	function fn_modify(){
	 	$("#frm").attr("action","<c:url value='/qxsepmny/ech0106/ech0106Modify.do'/>").submit();
	}
	
	function fn_delete(){
		if(confirm('해당 시험제품정보를 삭제하시겠습니까?')){
			$("#frm").attr("action","<c:url value='/qxsepmny/ech0106/ech0106Delete.do'/>").submit();
		}
	}
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}
	
	
	function fn_open(){
		
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('참여지사를 선택해 주세요.');
			return;
		}
				
		$("#modi-pop").prop("checked", "true");
		
	}
	
	function fn_step(){
		if(confirm('등록하신 참여지사정보를 등록합니다. \r\n저장하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var csNo = $("#csNo").val();			
			var step1 = $("#datepicker01").val();
			var step2 = $("#datepicker02").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205AjaxSaveStep.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"csNo="+csNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					$("#modi-pop").click();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	
	//참여지사관리 추가/수정 
	function fn_brpop(mode, corpCd, csNo, rsCd, branchCd){
		var popupWidth = 400;
		var popupHeight = 500;
		var popupX = (window.screen.width/2)-(popupWidth/2);
		var popupY = (window.screen.height/2)-(popupHeight/2);

		//, '참여지사관리, width='+ popupWidth + ', height=' + popupHeight +', left='+ popupX + ', top='+ popupY + ', menubar=no, status=no, toolbar=no, scrollbars=1');
		//alert('참여지사관리, width='+ popupWidth + ', height=' + popupHeight +', left='+ popupX + ', top='+ popupY + ', menubar=no, status=no, toolbar=no, scrollbars=1');
		//, '참여지사관리, width='+ popupWidth + ', height=' + popupHeight +', left='+ popupX + ', top='+ popupY + ', menubar=no, status=no, toolbar=no, scrollbars=1');
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106BrmgPop.do'/>?mode="+mode+"&corpCd="+corpCd+"&csNo="+csNo+"&rsCd="+rsCd+"&branchCd="+branchCd
				, '참여지사관리', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}	
	
	// 참여지사 삭제
	function fn_del(){
		
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('삭제할 참여지사를 선택해 주세요.');
			return;
		}
		if(confirm('선택하신 지사의 참여정보를 삭제합니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var csNo = $("#csNo").val();
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106AjaxSaveDel.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"csNo="+csNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	
	}

	//참여연구담당자 추가/수정 
	function fn_stpop(mode, corpCd, csNo, rsCd, empNo){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106StmgPop.do'/>?mode="+mode+"&corpCd="+corpCd+"&csNo="+csNo+"&rsCd="+rsCd+"&empNo="+empNo
				, '참여연구담당자관리', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}	
	
	// 참여연구담당자 삭제
	function fn_delst(){
		if($("input[name=rsjSeq2]:checked").length == 0){
			alert('삭제할 참여연구담당자를 선택해 주세요.');
			return;
		}
		if(confirm('선택하신 연구담당자의 참여정보를 삭제합니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var csNo = $("#csNo").val();
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106AjaxSaveDelStaff.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"csNo="+csNo+"&"+"step1="+step1+"&"+"step2="+step2+"&"+$("input[name=rsjSeq2]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	
	}	
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}

	//견적서보기로 변경해야 함  
	function fn_oppop(mode, corpCd, csNo, rsCd, ctrtNo){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106MtlmgPop.do'/>?mode="+mode+"&corpCd="+corpCd+"&csNo="+csNo+"&rsCd="+rsCd+"&ctrtNo="+ctrtNo
				, '시험물질정보관리', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}	
	
	//시험물질 정보 삭제
	function fn_delMtl(){
		if($("input[name=mtlSeq]:checked").length == 0){
			alert('삭제할 시험물질 정보를 선택해 주세요.');
			return;
		}
		if(confirm('선택하신 시험물질 정보를 삭제합니다. \r\n삭제하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var csNo = $("#csNo").val();
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106AjaxSaveDelMtl.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"csNo="+csNo+"&"+$("input[name=mtlSeq]:checked").serialize()
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>시험제품</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="연구관리"/>
	            <jsp:param name="dept2" value="시험제품"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>시험제품정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 검색조건유지 설정 -->
            <form:form commandName="searchVO" id="frm2" name="frm2">
            	<form:hidden path="searchCondition1"/>
            	<form:hidden path="searchCondition2"/>
            	<form:hidden path="searchCondition3"/>
            	<form:hidden path="searchCondition4"/>
            	<form:hidden path="searchCondition5"/>
            	<form:hidden path="searchCondition6"/>
            	<form:hidden path="searchCondition7"/>
            	<form:hidden path="searchCondition8"/>
            	<form:hidden path="searchYear"/>
            	<form:hidden path="searchWord"/>
            </form:form>
            <!-- //검색조건유지 설정 -->
            <form:form commandName="rs3000mVO" id="frm" name="frm">
            	<form:hidden path="corpCd"/>
            	<form:hidden path="itemNo"/>
            	<form:hidden path="isAdminType"/>
            	<form:hidden path="isRsDrt"/>
            	<form:hidden path="isRsStaff"/>
            	<form:hidden path="isDelCntr"/>
            </form:form>
            <!-- 시험제품정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">제품번호</th>
                        <td colspan="3"><c:out value="${rs3000mVO.itemNo }"/></td>    
                    </tr>
                    <tr>
                        <th scope="row">입고일자</th>
                        <td>
                        	<div class="date_sec">
                                <span><c:out value="${rs3000mVO.inhDt }"/></span>
                            </div>
                        </td>    
                        <th scope="row" class="bl">제품담당자</th>
                        <td><c:out value="${rs3000mVO.empName }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">연구번호</th>
                        <td colspan="3" ><c:out value="${rs3000mVO.rsCd }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">고객사</th>
                        <td><c:out value="${rs3000mVO.vendName }"/></td>
                        <th scope="row" class="bl">연구명</th>
                        <td><c:out value="${rs3000mVO.rsName }"/></td>    
                    </tr>
                    <tr>
                    	<th scope="row">제품명</th>
                        <td><c:out value="${rs3000mVO.itemName }"/></td>
                        <th scope="row" class="bl">제품구분</th>
                        <td><c:out value="${rs3000mVO.itemClsNm }"/></td>
                    </tr>
                    <tr>
                        <th scope="row" class="b1">반출일</th>
                        <td>
                        	<div class="date_sec">
                                <span><c:out value="${rs3000mVO.outDt }"/></span>
                            </div>
                        </td>
                        <th scope="row" class="b1">발송일</th>
                        <td>
                        	<div class="date_sec">
                                <span><c:out value="${rs3000mVO.sendDt }"/></span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                    	<th scope="row">수거여부</th>
                        <td>
	                        <input type="radio" name="reYn" id="reYn1" value="Y" readonly />
							<label for="reYn1">수거</label>
							<input type="radio" name="reYn" id="reYn2" value="N" readonly />
	                        <label for="reYn2">미수거</label>
                        </td>
                        <th scope="row" class="b1">수거일</th>
                        <td>
                        	<div class="date_sec">
                                <span><c:out value="${rs3000mVO.reDt }"/></span>
                            </div>
                        </td>
                    </tr>
                    <tr>
                    	<th scope="row">폐기일</th>
                        <td colspan="3">
                        	<div class="date_sec">
                                <span><c:out value="${rs3000mVO.dispoDt }"/></span>
                            </div>
                        </td>
                    </tr>    
                    <tr>
                        <th scope="row">비고</th>
                        <td colspan="3" >
                        <textarea><c:out value="${rs3000mVO.remk }"/></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">담당지사</th>
                        <td colspan="3" class="p15"><c:out value="${rs3000mVO.branchName }"/></td>
                    </tr>
                </tbody>
            </table>
            <!-- //시험제품정보 -->

            <%-- <!-- 서브타이틀 -->
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
                	<tr id="rsImage_tr">
                        <th scope="row">연구이미지</th>
                        <td colspan="3">      
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file01" name="rsImage" />	
                                 <c:choose>
                            		<c:when test="${attachMap.rsImage==null}">
		                            	<script type="text/javascript">
		                            			 $('#rsImage_tr').remove();
		                            	</script>	
                            		</c:when>
                            	</c:choose>
                            	<div>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.rsImage.attachNo }'/>', '<c:out value='${attachMap.rsImage.boardType }'/>'); return false;">
                            				<c:out value="${attachMap.rsImage.orgFileName }"/>
                            			</a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="rsPlan_tr">
                        <th scope="row">연구계획서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file02" name="rsPlan">
                            	<c:choose>
                            		<c:when test="${attachMap.rsPlan == null }">
		                            	<script type="text/javascript">
		                            			 $('#rsPlan_tr').remove();
		                            	</script>	
                            		</c:when>
                            	</c:choose>
                            	<div>
                            		<span>
	                            		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.rsPlan.attachNo }'/>', '<c:out value='${attachMap.rsPlan.boardType }'/>'); return false;">
	                            		<c:out value="${attachMap.rsPlan.orgFileName }"/></a>
                            		</span>
                            	</div>
							</div>
                        </td>
                    </tr>
                    <tr id="draftRpt_tr">
                        <th scope="row">초안보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file03" name="draftRpt"/>   	
                            	<c:choose>
                            		<c:when test="${attachMap.draftRpt == null }">
		                            	<script type="text/javascript">
		                            		 $('#draftRpt_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>                 
                            		<span>
	                    	       		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.draftRpt.attachNo }'/>', '<c:out value='${attachMap.draftRpt.boardType }'/>'); return false;">
		                           			<c:out value="${attachMap.draftRpt.orgFileName  }"/></a>
	                           		</span>             		
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="finalRpt_tr">
                        <th scope="row">최종보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">           
                            	<input type="file" id="in_file04" name="finalRpt" />
                            	
                            	<c:choose>
                            		<c:when test="${attachMap.finalRpt == null }">
		                            	<script type="text/javascript">
		                            			 $('#finalRpt_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	
                            	<div>	
                            		<span>
	                            		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.finalRpt.attachNo }'/>', '<c:out value='${attachMap.finalRpt.boardType }'/>'); return false;">
	                           				<c:out value="${attachMap.finalRpt.orgFileName }"/>
		                          		</a>
                            		</span>
                            	</div>
                         </div>
                        </td>
                    </tr>
                    <tr id="summary_tr">
                        <th scope="row">최종요약문</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file05" name="summary" />
                            	
								<c:choose>
                            		<c:when test="${attachMap.summary == null }">
		                            	<script type="text/javascript">
		                            			 $('#summary_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            		<span id="image5"></span>
                            		<span>
		                           		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.summary.attachNo }'/>', '<c:out value='${attachMap.summary.boardType }'/>'); return false;">
	                           				<c:out value="${attachMap.summary.orgFileName}"/></a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="korRpt_tr">
                        <th scope="row">국문보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file06" name="korRpt" />
							<c:choose>
                            		<c:when test="${attachMap.korRpt == null }">
		                            	<script type="text/javascript">
		                            			 $('#korRpt_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            
                            	<div>
                            		
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.korRpt.attachNo }'/>', '<c:out value='${attachMap.korRpt.boardType }'/>'); return false;">
	                           				<c:out value="${attachMap.korRpt.orgFileName }"/></a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="engRpt_tr">
                        <th scope="row">영문보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file07" name="engRpt"/>
                           		<c:choose>
                            		<c:when test="${attachMap.engRpt == null }">
		                            	<script type="text/javascript">
		                            			 $('#engRpt_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            		<span id="image7"></span>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.engRpt.attachNo }'/>', '<c:out value='${attachMap.engRpt.boardType }'/>'); return false;">
		                           			<c:out value="${attachMap.engRpt.orgFileName }"/></a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="gita1_tr">
                        <th scope="row">기타1</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file08" name="gita1" />
                           		<c:choose>
                            		<c:when test="${attachMap.gita1 == null }">
		                            	<script type="text/javascript">
		                            			 $('#gita1_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            	<span id="image8"></span>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.gita1.attachNo }'/>', '<c:out value='${attachMap.gita1.boardType }'/>'); return false;">
		                           			<c:out value="${attachMap.gita1.orgFileName }"/>
	                          			</a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="gita2_tr">
                        <th scope="row">기타2</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file09" name="gita2" />
                           	
                            	<c:choose>
                            		<c:when test="${attachMap.gita2 == null }">
		                            	<script type="text/javascript">
		                            			 $('#gita2_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            	<span id="image9"></span>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.gita2.attachNo }'/>', '<c:out value='${attachMap.gita2.boardType }'/>'); return false;">
		                           			<c:out value="${attachMap.gita2.orgFileName }"/>
	                          			</a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //첨부파일 --> --%>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list();" class="type02">목록</a>
				<a href="#" onclick="fn_delete(); return false;" id="btnDel">삭제</a>
				<a href="#" onclick="fn_modify(); return false;" id="btnModi">수정</a>
			</div>
			<%-- <!-- //버튼 -->
			<!-- 상담목록, 견적목록, 계약목록, 연구과제목록 표시 되어야 할 곳 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info" id="mtl">			
				<h4>상담 정보</h4>
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_sub type02" onclick="fn_mtlpop('i','<c:out value="${rs1000mVO.corpCd }"/>','<c:out value="${rs1000mVO.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>',''); return false;" id="btnRegMtl">등록</a>
					<a href="#" class="btn_sub" onclick="fn_delMtl(); return false;" id="btnDelMtl">삭제</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 상담 정보 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:10%" />
					<col style="width:auto" />
					<col style="width:8%" />
					<col style="width:20%" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all-cs"/></th>
						<th scope="col">번호</th>
						<th scope="col">상담일자</th>
						<th scope="col">상담자</th>
						<th scope="col">상담분야</th>
						<th scope="col">상담내용</th>
						<th scope="col">담당자</th>
						<th scope="col">비고</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="resultcs" items="${csList}" varStatus="status">
					<tr>					
						<td><input type="checkbox" name="csSeq" value="<c:out value='${resultcs.csNo }'/>"/></td>
						<td><c:out value="${resultcs.rownum }"/></td>
						<td><c:out value="${resultcs.csDt }"/></td>
						<td><c:out value="${resultcs.empName }"/></td>
						<td><c:out value="${resultcs.csClsNm }"/></td>
						<td><c:out value="${resultcs.csCont }"/></td>
						<td><c:out value="${resultcs.rcsName }"/></td>
						<td><c:out value="${resultcs.remk}"/></td>
					</tr>
				</c:forEach>
				<c:if test="${csList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="8">상담 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
            <!-- //상담정보 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info" id="mtl">			
				<h4>견적 정보</h4>
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_sub type02" onclick="fn_mtlpop('i','<c:out value="${rs1000mVO.corpCd }"/>','<c:out value="${rs1000mVO.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>',''); return false;" id="btnRegMtl">등록</a>
					<a href="#" class="btn_sub" onclick="fn_delMtl(); return false;" id="btnDelMtl">삭제</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 견적 정보 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:8%" />
					<col style="width:auto" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:8%" />
					<col style="width:8%" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all-op"/></th>
						<th scope="col">번호</th>
						<th scope="col">견적번호</th>
						<th scope="col">견적일자</th>
						<th scope="col">견적명</th>
						<th scope="col">연구비</th>
						<th scope="col">부가세</th>
						<th scope="col">견적금액</th>
						<th scope="col">수신담당자</th>
						<th scope="col">견적서</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="resultop" items="${opList}" varStatus="status">
					<tr>					
						<td><input type="checkbox" name="opSeq" value="<c:out value='${resultop.ctrtNo }'/>"/></td>
						<td><c:out value="${resultop.rownum }"/></td>
						<td><c:out value="${resultop.opCd }"/></td>
						<td><c:out value="${resultop.opDt }"/></td>
						<td><c:out value="${resultop.opName }"/></td>
						<td><c:out value="${resultop.rsPay }"/></td>
						<td><c:out value="${resultop.rsPayvt}"/></td>
						<td><c:out value="${resultop.rsTpay}"/></td>
						<td><c:out value="${resultop.vmngName}"/></td>
						<td><a href="#" onclick="fn_oppop('u','<c:out value="${resultop.corpCd }"/>','<c:out value="${resultop.ctrtNo }"/>'); return false;" class="btn_sub btnModiMtl" >보기</a></td>
					</tr>
				</c:forEach>
				<c:if test="${mtlList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="10">견적 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
            <!-- //견적정보 --> --%>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
