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
	
		var ynAdmin = '<c:out value="${cs2000mVO.isAdminType}"/>';
		var ynDrt = '<c:out value="${cs2000mVO.isRsDrt}"/>';
		var ynStaff = '<c:out value="${cs2000mVO.isRsStaff}"/>';
		
		
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
		var ynDel = '<c:out value="${cs2000mVO.isDelCntr}"/>';
		if(ynDel=="N") {
			$("#btnDel").hide();
		}
		
		// 회신상태 Y 회신확인 N 미확인
		var rtYn = '<c:out value="${cs2000mVO.rtYn}"/>';
		switch (rtYn) {
			case 'Y':
				$("#rtYn1").attr('checked', 'checked');
		    	break;
			case 'N':
				$("#rtYn2").attr('checked', 'checked');
		    	break;			    	
		  default:
		    console.log(`Sorry, we are out of ${expr}.`);
		}
		
	});

	function fn_list(){
		$("#frm2").attr("action","<c:url value='/qxsepmny/ech0903/ech0903List.do'/>").submit();
	}	
	
	function fn_modify(){
	 	$("#frm").attr("action","<c:url value='/qxsepmny/ech0903/ech0903Modify.do'/>").submit();
	}
	
	function fn_delete(){
		if(confirm('해당 계약정보를 삭제하시겠습니까?')){
			$("#frm").attr("action","<c:url value='/qxsepmny/ech0903/ech0903Delete.do'/>").submit();
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
		<h2>계약관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="영업관리"/>
	            <jsp:param name="dept2" value="계약관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>계약정보</h4>
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
            <form:form commandName="cs2000mVO" id="frm" name="frm">
            	<form:hidden path="corpCd"/>
            	<form:hidden path="ctrtNo"/>
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
                        <th scope="row">계약번호</th>
                        <td colspan="3"><c:out value="${cs2000mVO.ctrtCd }"/></td>    
                    </tr>
                    <tr>
                        <th scope="row">계약일자</th>
                        <td>
                        	<div class="date_sec">
                                <span><c:out value="${cs2000mVO.ctrtDt }"/></span>
                            </div>
                        </td>    
                        <th scope="row" class="bl">계약담당자</th>
                        <td><c:out value="${cs2000mVO.empName }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">견적번호</th>
                        <td><c:out value="${cs2000mVO.opCd }"/>(견적일:<c:out value="${cs2000mVO.opDt }"/>)</td>
                        <th scope="row" class="bl">견적명</th>
                        <td colspan="3" ><c:out value="${cs2000mVO.opName }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">고객사</th>
                        <td><c:out value="${cs2000mVO.vendName }"/></td>
                        <th scope="row" class="bl">계약분야</th>
                        <td><c:out value="${cs2000mVO.ctrtClsNm }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">계약명</th>
                        <td colspan="3" >
                        <textarea><c:out value="${cs2000mVO.ctrtName }"/></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">계약내용</th>
                        <td colspan="3" >
                        <textarea><c:out value="${cs2000mVO.ctrtCont }"/></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">계약시작일자</th>
                        <td><c:out value="${cs2000mVO.ctrtStdt }"/></td>
                        <th scope="row" class="bl">계약종료일자</th>
                        <td><c:out value="${cs2000mVO.ctrtEndt }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">담당자</th>
                        <td><c:out value="${cs2000mVO.vmngName }"/></td>
                        <th scope="row" class="bl">연락처</th>
                        <td><c:out value="${cs2000mVO.vmnghpNo }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">메일주소</th>
                        <td colspan="3"><c:out value="${cs2000mVO.vmngEmail }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">연구비</th>
                        <td><c:out value="${cs2000mVO.rsPay }"/>원</td>
                        <th scope="row" class="bl">부가세</th>
                        <td><c:out value="${cs2000mVO.rsPayvt }"/>원</td>
                    </tr>
                    <tr>
                        <th scope="row">합계</th>
                        <td colspan="3"><c:out value="${cs2000mVO.rsTpay }"/>원</td>
                    </tr>
                    <tr>
                        <th scope="row">비고</th>
                        <td colspan="3" >
                        <textarea><c:out value="${cs2000mVO.remk }"/></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">수금조건</th>
                        <td><c:out value="${cs2000mVO.inCond }"/></td>
                        <th scope="row" class="bl">회신상태</th>
                        <td>
	                        <input type="radio" name="rtYn" id="rtYn1" value="Y" readonly />
							<label for="rtYn1">회신확인</label>
							<input type="radio" name="rtYn" id="rtYn2" value="N" readonly />
	                        <label for="rtYn2">미확인</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">이메일발송일자</th>
                        <td><c:out value="${cs2000mVO.esDt }"/></td>
                        <th scope="row" class="bl">우편발송일자</th>
                        <td><c:out value="${cs2000mVO.psDt }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">누적입금액</th>
                        <td><c:out value="${cs2000mVO.inTamt }"/>원</td>
                        <th scope="row" class="bl">잔금</th>
                        <td><c:out value="${cs2000mVO.inBamt }"/>원</td>
                    </tr>
                    <tr>
                        <th scope="row">담당지사</th>
                        <td colspan="3" class="p15"><c:out value="${cs2000mVO.branchName }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">관리번호</th>
                        <td colspan="3"><c:out value="${cs2000mVO.ctrtNo }"/></td>    
                    </tr>
                </tbody>
            </table>
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
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //파일첨부 -->
            <!-- //상담정보 -->

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
			<!-- //버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info" id="mtl">			
				<h4>입금 정보</h4>
				<!-- 버튼 -->
				<div>
					<%-- <a href="#" class="btn_sub type02" onclick="fn_mtlpop('i','<c:out value="${rs1000mVO.corpCd }"/>','<c:out value="${rs1000mVO.rsNo }"/>','<c:out value="${rs1000mVO.rsCd }"/>',''); return false;" id="btnRegMtl">등록</a>
					<a href="#" class="btn_sub" onclick="fn_delMtl(); return false;" id="btnDelMtl">삭제</a> --%>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 입금 정보 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:auto" />
					<col style="width:8%" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:10%" />
					<col style="width:20%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">입금일자</th>
						<th scope="col">입금차수</th>
						<th scope="col">입금액</th>
						<th scope="col">누적입금액</th>
						<th scope="col">잔금</th>
						<th scope="col">지사</th>
						<th scope="col">비고</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="resultin" items="${inList}" varStatus="status">
					<tr>					
						<td><c:out value="${resultin.rownum }"/></td>
						<td><c:out value="${resultin.inDt }"/></td>
						<td><c:out value="${resultin.inSq }"/></td>
						<td class="txt-r"><fmt:formatNumber value="${resultin.inAmt }" pattern="#,###"/></td>
						<td class="txt-r"><fmt:formatNumber value="${resultin.inTamt }" pattern="#,###"/></td>
						<td class="txt-r"><fmt:formatNumber value="${resultin.inBamt }" pattern="#,###"/></td>
						<td><c:out value="${resultin.branchName}"/></td>
						<td><c:out value="${resultin.remk}"/></td>
					</tr>
				</c:forEach>
				<c:if test="${inList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="8">입금 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
            <!-- //상담정보 -->
			<%-- <!-- 상담목록, 견적목록, 계약목록, 연구과제목록 표시 되어야 할 곳 -->
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
