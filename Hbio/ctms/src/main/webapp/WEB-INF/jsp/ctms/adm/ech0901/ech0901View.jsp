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
	
		var ynAdmin = '<c:out value="${cs1000mVO.isAdminType}"/>';
		var ynDrt = '<c:out value="${cs1000mVO.isRsDrt}"/>';
		var ynStaff = '<c:out value="${cs1000mVO.isRsStaff}"/>';
		
		
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
				}
			}
		}	
	
		//삭제불가능 "N" - 삭제 x
		var ynDel = '<c:out value="${cs1000mVO.isDelCntr}"/>';
		if(ynDel=="N") {
			$("#btnDel").hide();
		}

		
	});
		
	function fn_list(){
		$("#frm2").attr("action","<c:url value='/qxsepmny/ech0901/ech0901List.do'/>").submit();
	}	
	
	function fn_modify(){
	 	$("#frm").attr("action","<c:url value='/qxsepmny/ech0901/ech0901Modify.do'/>").submit();
	}
	
	function fn_delete(){
		if(confirm('해당 상담정보를 삭제하시겠습니까?')){
			$("#frm").attr("action","<c:url value='/qxsepmny/ech0901/ech0901Delete.do'/>").submit();
		}
	}
	
	//파일 다운로드
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
		<h2>상담관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="영업관리"/>
	            <jsp:param name="dept2" value="상담관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>상담정보</h4>
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
            <form:form commandName="cs1000mVO" id="frm" name="frm">
            	<form:hidden path="corpCd"/>
            	<form:hidden path="csNo"/>
            	<form:hidden path="isAdminType"/>
            	<form:hidden path="isRsDrt"/>
            	<form:hidden path="isRsStaff"/>
            	<form:hidden path="isDelCntr"/>
            </form:form>
            <!-- 상담정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">상담일자</th>
                        <td>
                        	<div class="date_sec">
                                <span><c:out value="${cs1000mVO.csDt }"/></span>
                            </div>
                        </td>    
                        <th scope="row" class="bl">상담자</th>
                        <td><c:out value="${cs1000mVO.empName }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">고객사</th>
                        <td><c:out value="${cs1000mVO.vendName }"/></td>
                        <th scope="row" class="bl">상담분야</th>
                        <td><c:out value="${cs1000mVO.csClsNm }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">상담내용</th>
                        <td colspan="3" >
                        <textarea><c:out value="${cs1000mVO.csCont }"/></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">담당자</th>
                        <td><c:out value="${cs1000mVO.rcsName }"/></td>
                        <th scope="row" class="bl">연락처</th>
                        <td><c:out value="${cs1000mVO.rcsTel }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">메일주소</th>
                        <td colspan="3"><c:out value="${cs1000mVO.rcsEmail }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">비고</th>
                        <td colspan="3" >
                        <textarea><c:out value="${cs1000mVO.remk }"/></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">담당지사</th>
                        <td colspan="3" class="p15"><c:out value="${cs1000mVO.branchName }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">관리번호</th>
                        <td colspan="3" class="p15"><c:out value="${cs1000mVO.csNo }"/></td>
                    </tr>
                </tbody>
            </table>
            <!-- //상담정보 -->
            <div class="sub_title_area">
                <h4>파일첨부</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 파일첨부 -->
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
                        <td colspan="3">
								<c:forEach items="${attachList }" var="file" varStatus="status">
									<a href="#" onclick="fn_filedownload('<c:out value='${file.attachNo}'/>','CS'); return false;" style="text-decoration: underline;">
										<c:out value="${file.orgFileName }" />
									</a>
									<br>
									<%-- <input type="hidden" id="delSeqList" name="delSeqList" value="<c:out value="${file.attachNo }" />"> --%>
								</c:forEach>

								</td>
                        
<%--                         <td colspan="3">
                            <div class="attach_sec type02 mb02" id="attachRpt01_div">
                            	<input type="file" id="in_file01" name="attachRpt01" />
                            	<c:choose>
                            		<c:when test="${attachMap.attachRpt01 == null }">
		                            	<script type="text/javascript">
		                            			 $('#attachRpt01_div').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                           			<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt01.attachNo }'/>', '<c:out value='${attachMap.attachRpt01.boardType }'/>'); return false;" style="text-decoration: underline;">
	                           				<c:out value="${attachMap.attachRpt01.orgFileName }"/>
	                          			</a>
                            		</span>
                            	</div>
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt02_div">
                            	<input type="file" id="in_file02" name="attachRpt02" />
								<c:choose>
                            		<c:when test="${attachMap.attachRpt02 == null }">
		                            	<script type="text/javascript">
		                            			 $('#attachRpt02_div').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt02.attachNo }'/>', '<c:out value='${attachMap.attachRpt02.boardType }'/>'); return false;" style="text-decoration: underline;">
	                           				<c:out value="${attachMap.attachRpt02.orgFileName }"/>
	                          			</a>
                            		</span>
                            	</div>
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt03_div">
                            	<input type="file" id="in_file03" name="attachRpt03" />
                           		<c:choose>
                            		<c:when test="${attachMap.attachRpt03 == null }">
		                            	<script type="text/javascript">
		                            			 $('#attachRpt03_div').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt03.attachNo }'/>', '<c:out value='${attachMap.attachRpt03.boardType }'/>'); return false;" style="text-decoration: underline;">
	                           				<c:out value="${attachMap.attachRpt03.orgFileName }"/>
	                          			</a>
                            		</span>
                            	</div>
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt04_div">
                            	<input type="file" id="in_file04"  name="attachRpt04" />
                            	<c:choose>
                            		<c:when test="${attachMap.attachRpt04 == null }">
		                            	<script type="text/javascript">
		                            			 $('#attachRpt04_div').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt04.attachNo }'/>', '<c:out value='${attachMap.attachRpt04.boardType }'/>'); return false;" style="text-decoration: underline;">
	                           				<c:out value="${attachMap.attachRpt04.orgFileName }"/>
	                          			</a>
                            		</span>
                            		
                            	</div>
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt05_div">
                            	<input type="file" id="in_file05" name="attachRpt05"/>
                            	<c:choose>
                            		<c:when test="${attachMap.attachRpt05 == null }">
		                            	<script type="text/javascript">
		                            			 $('#attachRpt05_div').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>								                  		
                            		<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt05.attachNo }'/>', '<c:out value='${attachMap.attachRpt05.boardType }'/>'); return false;" style="text-decoration: underline;">
	                           				<c:out value="${attachMap.attachRpt05.orgFileName }"/>
	                          			</a>
                            		</span>
                            	</div>
                            </div>
                        </td> --%>
                    </tr>
                </tbody>
            </table>
            <!-- //파일첨부 -->
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list();" class="type02">목록</a>
				<a href="#" onclick="fn_delete(); return false;" id="btnDel">삭제</a>
				<a href="#" onclick="fn_modify(); return false;" id="btnModi">수정</a>
			</div>
			<!-- //버튼 -->
			<!-- 상담목록, 견적목록, 계약목록, 연구과제목록 표시 되어야 할 곳 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info" id="mtl">			
				<h4>상담 이력</h4>
				<!-- 버튼 -->
				<div>
					<%-- <a href="#" class="btn_sub type02" onclick="fn_mtlpop('i','<c:out value="${rs1000mVO.corpCd }"/>','<c:out value="${rs1000mVO.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>',''); return false;" id="btnRegMtl">등록</a>
					<a href="#" class="btn_sub" onclick="fn_delMtl(); return false;" id="btnDelMtl">삭제</a> --%>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 상담 정보 -->
			<table class="tbl_list">
				<colgroup>
					<%-- <col style="width:5%" /> --%>
					<col style="width:5%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:10%" />
					<col style="width:auto" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<!-- <th><input type="checkbox" id="all-cs"/></th> -->
						<th scope="col">번호</th>
						<th scope="col">상담일자</th>
						<th scope="col">상담자</th>
						<th scope="col">상담분야</th>
						<th scope="col">상담내용</th>
						<th scope="col">담당자</th>
						<th scope="col">연락처</th>
						<th scope="col">이메일</th>
						<th scope="col">비고</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="resultcs" items="${csList}" varStatus="status">
					<tr>					
						<%-- <td><input type="checkbox" name="csSeq" value="<c:out value='${resultcs.csNo }'/>"/></td> --%>
						<td><c:out value="${resultcs.rownum }"/></td>
						<td><c:out value="${resultcs.csDt }"/></td>
						<td><c:out value="${resultcs.empName }"/></td>
						<td><c:out value="${resultcs.csClsNm }"/></td>
						<td><c:out value="${resultcs.csCont }"/></td>
						<td><c:out value="${resultcs.rcsName }"/></td>
						<td><c:out value="${resultcs.rcsTel }"/></td>
						<td><c:out value="${resultcs.rcsEmail }"/></td>
						<td><c:out value="${resultcs.remk}"/></td>
					</tr>
				</c:forEach>
				<c:if test="${csList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="9">상담 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
            <!-- //상담정보 -->
<%-- 			<!-- 테이블 상단 정보 -->
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
						<td><input type="checkbox" name="opSeq" value="<c:out value='${resultop.opNo }'/>"/></td>
						<td><c:out value="${resultop.rownum }"/></td>
						<td><c:out value="${resultop.opCd }"/></td>
						<td><c:out value="${resultop.opDt }"/></td>
						<td><c:out value="${resultop.opName }"/></td>
						<td><c:out value="${resultop.rsPay }"/></td>
						<td><c:out value="${resultop.rsPayvt}"/></td>
						<td><c:out value="${resultop.rsTpay}"/></td>
						<td><c:out value="${resultop.vmngName}"/></td>
						<td><a href="#" onclick="fn_oppop('u','<c:out value="${resultop.corpCd }"/>','<c:out value="${resultop.opNo }"/>'); return false;" class="btn_sub btnModiMtl" >보기</a></td>
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
