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
		
		var ynLock = '<c:out value="${rs1000mVO.dataLockYn}"/>';		
		if(ynLock=='Y') {
			$(".btnLockNonDisp").hide();
			//$(".btnLockNonDisp").attr('onclick', '').unbind('click');
				
		}
		
	});
	
			    
	function fn_pop(corpCd, rsNo, rsjNo){
				window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0104/ech0104RsjUsePop.do'/>?corpCd="+corpCd+"&rsNo="+rsNo+"&rsjNo="+rsjNo
					, '????????????????????????', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
		
	//????????????
	function fn_list(){
		$("#frm2").attr("action", "<c:url value='/qxsepmny/ech0104/ech0104List.do'/>").submit();
	}
	
	//??????????????????
	function fn_modify(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0104/ech0104Modify.do'/>").submit();
	}
	
	//?????????????????? ??????
	function fn_delete(){
		if (confirm("IRB?????? ????????? ?????????????????????????")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0104/ech0104Delete.do'/>").submit();
			
		}
	}
	
	//?????? ????????????
	function fn_filedownload(attachSeq, boardType){
		
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>????????????</h2>
		<!-- contents -->
		<div class="contents">
			<!-- ????????? -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="????????????"/>
	            <jsp:param name="dept2" value="IRB????????????"/>
           	</jsp:include>
			<!-- //????????? -->
			<!-- ??????????????? -->
            <div class="sub_title_area type02">
                <h4>????????????</h4>
            </div>
            <!-- //??????????????? -->
            <!-- ?????????????????? ?????? -->
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
            <!-- //?????????????????? ?????? -->
            <form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rs5000mVO.corpCd }"/>
			<input type="hidden" id="rsNo" name="rsNo" value="${rs5000mVO.rsNo eq ''?rsNo:rs5000mVO.rsNo}">
			<input type="hidden" id="rvNo" name="rvNo" value="${rs5000mVO.rvNo eq ''?rvNo:rs5000mVO.rvNo}">
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
            <!-- ???????????? -->
            <table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>					
					<tr>
						<th scope="row">????????????</th>
						<td>
							<c:choose>
                          		<c:when test="${rs1000mVO.dataLockYn eq 'Y' }"><c:out value="${rs1000mVO.rsCd }" /><span style="color:red;">(Data Locked)</span></c:when>
                          		<c:when test="${rs1000mVO.dataLockYn eq 'N' }"><c:out value="${rs1000mVO.rsCd }" /></c:when>
                          	</c:choose>
						</td>					
						<th scope="row" class="bl">?????????</th>
						<td><c:out value="${rs1000mVO.rsName }" /></td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td><c:out value="${rs1000mVO.rsstClsNm }" /></td>
						<th scope="row" class="bl">????????????</th>
						<td><c:out value="${rs1000mVO.rsStdt }" />~<c:out value="${rs1000mVO.rsEndt }" /></td>
					</tr>
					<%-- <tr>
						<th scope="row">????????????</th>
						<td><c:out value="${rs1000mVO.vendName }" /></td>
						<th scope="row" class="bl">?????????</th>
						<td><c:out value="${rs1000mVO.vmngName }" />,<c:out value="${rs1000mVO.vmnghpNo }" />,<c:out value="${rs1000mVO.vmngEmail }" /></td>
					</tr> --%>
				</tbody>
			</table>
            <!-- //???????????? -->
            <!-- ??????????????? -->
            <div class="sub_title_area">
                <h4>IRB ????????????</h4>
            </div>
            <!-- //??????????????? -->
            <!-- IRB ???????????? -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">????????????</th>
                        <td colspan="3">
                            <c:out value="${rs5000mVO.rvNo1 }" />
                            -
                            <c:out value="${rs5000mVO.rvNo2 }" />
                            -
                            <c:out value="${rs5000mVO.rvNo3 }" />
                            -
                            <c:out value="${rs5000mVO.rvNo4 }" />
                            -
                            <c:out value="${rs5000mVO.rvNo5 }" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">????????????</th>
                        <td>
							<input type="radio" name="rvCls" id="rvCls1" />
							<label for="rvCls1">??????</label>
							<input type="radio" name="rvCls" id="rvCls2" />
							<label for="rvCls2">??????</label>
                        </td>
                        <th scope="row" class="bl">????????????</th>
                        <td>
                            <input type="radio" name="rvdocCls" id="rvdocCls1" />
							<label for="rvdocCls1">????????????</label>
							<input type="radio" name="rvdocCls" id="rvdocCls2" />
							<label for="rvdocCls2">????????????</label>
							<input type="radio" name="rvdocCls" id="rvdocCls3" />
							<label for="rvdocCls3">??????</label>
							&nbsp;<input type="text" class="p40" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">????????????</th>
                        <td>
							<input type="radio" name="rvSt" id="rvSt1" />
							<label for="rvSt1">?????????</label>
							<input type="radio" name="rvSt" id="rvSt2" />
							<label for="rvSt">??????</label>
                        </td>
                        <th scope="row" class="bl">????????????</th>
                        <td>
                            <input type="radio" name="rvRs" id="rvRs1" />
							<label for="rvRs1">??????</label>
							<input type="radio" name="rvRs" id="rvRs2" />
							<label for="rvRs2">??????</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">???????????????</th>
                        <td>
							<div class="date_sec">
								<span>
									<c:out value="${rs5000mVO.rvDt }" />
								</span>
							</div>
                        </td>
                        <th scope="row" class="bl">???????????????</th>
                        <td>
                            <div class="date_sec">
								<span>
									<c:out value="${rs5000mVO.plrvDt }" />
								</span>
							</div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">???????????????</th>
                        <td>
							<div class="date_sec">
								<span>
									<c:out value="${rs5000mVO.chrvDt }" />
								</span>
							</div>
                        </td>
                        <th scope="row" class="bl">???????????????</th>
                        <td>
                            <div class="date_sec">
								<span>
									<c:out value="${rs5000mVO.rsrvDt }" />
								</span>
							</div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">IRB ????????????</th>
                        <td>
							<div class="date_sec">
								<span>
									<c:out value="${rs5000mVO.plrvStdt }" />
								</span>
								<em>~</em>
								<span>
									<c:out value="${rs5000mVO.plrvEddt }" />
								</span>
							</div>
                        </td>
                        <th scope="row" class="bl">IRB ????????????</th>
                        <td>
                            <div class="date_sec">
								<span>
									<c:out value="${rs5000mVO.rsrvStdt }" />
								</span>
								<em>~</em>
								<span>
									<c:out value="${rs5000mVO.rsrvEddt }" />
								</span>
							</div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //IRB ???????????? -->
            <!-- ??????????????? -->
            <div class="sub_title_area">
                <h4>????????????</h4>
            </div>
            <!-- //??????????????? -->
            <!-- ???????????? -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr id="irbplan_tr">
                        <th scope="row">IRB???????????????</th>
                        <td colspan="3">      
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file01" name="irbplan" />	
                                 <c:choose>
                            		<c:when test="${attachMap.irbplan==null}">
		                            	<script type="text/javascript">
		                            			 $('#irbplan_tr').remove();
		                            	</script>	
                            		</c:when>
                            	</c:choose>
                            	<div>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.irbplan.attachNo }'/>', '<c:out value='${attachMap.irbplan.boardType }'/>'); return false;">
                            				<c:out value="${attachMap.irbplan.orgFileName }"/>
                            			</a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="irbresult_tr">
                        <th scope="row">IRB???????????????</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file02" name="irbresult">
                            	<c:choose>
                            		<c:when test="${attachMap.irbresult == null }">
		                            	<script type="text/javascript">
		                            			 $('#irbresult_tr').remove();
		                            	</script>	
                            		</c:when>
                            	</c:choose>
                            	<div>
                            		<span>
	                            		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.irbresult.attachNo }'/>', '<c:out value='${attachMap.irbresult.boardType }'/>'); return false;">
	                            		<c:out value="${attachMap.irbresult.orgFileName }"/></a>
                            		</span>
                            	</div>
							</div>
                        </td>
                    </tr>
                    <tr id="irbcfm_tr">
                        <th scope="row">???????????????</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file03" name="irbcfm"/>   	
                            	<c:choose>
                            		<c:when test="${attachMap.irbcfm == null }">
		                            	<script type="text/javascript">
		                            		 $('#irbcfm_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>                 
                            		<span>
	                    	       		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.irbcfm.attachNo }'/>', '<c:out value='${attachMap.irbcfm.boardType }'/>'); return false;">
		                           			<c:out value="${attachMap.irbcfm.orgFileName  }"/></a>
	                           		</span>             		
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr id="irbrj_tr">
                        <th scope="row">???????????????</th>
                        <td colspan="3">
                            <div class="attach_sec type02">           
                            	<input type="file" id="in_file04" name="irbrj" />
                            	<c:choose>
                            		<c:when test="${attachMap.irbrj == null }">
		                            	<script type="text/javascript">
		                            			 $('#irbrj_tr').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	
                            	<div>	
                            		<span>
	                            		<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.irbrj.attachNo }'/>', '<c:out value='${attachMap.irbrj.boardType }'/>'); return false;">
	                           				<c:out value="${attachMap.irbrj.orgFileName }"/>
		                          		</a>
                            		</span>
                            	</div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //???????????? -->
            </form:form>
			<!-- ?????? -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">??????</a>
				<a href="#" onclick="fn_delete(); return false;" class="btnLockNonDisp">??????</a>
				<a href="#" onclick="fn_modify(); return false;" class="btnLockNonDisp">??????</a>
			</div>
			<!-- //?????? -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>