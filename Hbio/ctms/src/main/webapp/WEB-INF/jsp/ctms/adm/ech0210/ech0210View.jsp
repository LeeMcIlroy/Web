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
	
		var ynAdmin = '<c:out value="${cr2100mVO.isAdminType}"/>';
		var ynDrt = '<c:out value="${cr2100mVO.isRsDrt}"/>';
		var ynStaff = '<c:out value="${cr2100mVO.isRsStaff}"/>';
		
		
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
					
					}
			}
		}
	
		//삭제불가능 "N" - 삭제 x
		var ynDel = '<c:out value="${cr2100mVO.isDelCntr}"/>';
		if(ynDel=="N") {
			$("#btnDel").hide();
		}

		// 사용여부 Y 사용 N 사용안함
		var ynuseYn = '<c:out value="${cr2100mVO.useYn}"/>';
		switch (ynuseYn) {
			case 'Y':
				$("#useYn1").attr('checked', 'checked');
		    	break;
			case 'N':
				$("#useYn2").attr('checked', 'checked');
		    	break;			    	
		  default:
		    console.log(`Sorry, we are out of ${expr}.`);
		}
		
	});

	function fn_list(){
		$("#frm2").attr("action","<c:url value='/qxsepmny/ech0210/ech0210List.do'/>").submit();
	}	
	
	function fn_modify(){
	 	$("#frm").attr("action","<c:url value='/qxsepmny/ech0210/ech0210Modify.do'/>").submit();
	}
	
	function fn_delete(){
		if(confirm('해당 CRF템플릿정보를 삭제하시겠습니까?')){
			$("#frm").attr("action","<c:url value='/qxsepmny/ech0210/ech0210Delete.do'/>").submit();
		}
	}
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}

	//템플릿보기로 변경해야 함  
	function fn_oppop(mode, corpCd, csNo, rsCd, tempNo){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0210/ech0210MtlmgPop.do'/>?mode="+mode+"&corpCd="+corpCd+"&csNo="+csNo+"&rsCd="+rsCd+"&tempNo="+tempNo
				, '시험물질정보관리', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}	
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>CRF템플릿관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="CRF템플릿관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>CRF템플릿정보</h4>
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
            <form:form commandName="cr2100mVO" id="frm" name="frm">
            	<form:hidden path="corpCd"/>
            	<form:hidden path="tempNo"/>
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
                        <th scope="row">템플릿번호</th>
                        <td colspan="3"><c:out value="${cr2100mVO.tempCd }"/></td>    
                    </tr>
                    <tr>
                        <th scope="row">등록일자</th>
                        <td>
                        	<div class="date_sec">
                                <span><c:out value="${cr2100mVO.regDt }"/></span>
                            </div>
                        </td>    
                        <th scope="row" class="bl">담당자</th>
                        <td><c:out value="${cr2100mVO.empName }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">템플릿명</th>
                        <td><c:out value="${cr2100mVO.tempNm }"/></td>
                        <th scope="row" class="bl">템플릿분류</th>
                        <td><c:out value="${cr2100mVO.tempTypeNm }"/></td>
                    </tr>
                    <tr>
	                    <th scope="row">시작일자</th>
                        <td>
                        	<div class="date_sec">
                                <span><c:out value="${cr2100mVO.stDate }"/></span>
                            </div>
                        </td>    
                        <th scope="row" class="bl">종료일자</th>
                        <td>
                        	<div class="date_sec">
                                <span><c:out value="${cr2100mVO.edDate }"/></span>
                            </div>
                        </td>
	                </tr>
	                <tr>
	                	<th scope="row">사용여부</th>
                        <td>
	                        <input type="radio" name="useYn" id="useYn1" value="Y" readonly />
							<label for="useYn1">사용</label>
							<input type="radio" name="useYn" id="useYn2" value="N" readonly />
	                        <label for="useYn2">사용안함</label>
                        </td>
                        <th scope="row" class="bl">구성쪽수</th>
                        <td><c:out value="${cr2100mVO.upageCnt }"/></td>
                    </tr>    
                    <tr>
                        <th scope="row">비고</th>
                        <td colspan="3" >
                        <textarea><c:out value="${cr2100mVO.remk }"/></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">담당지사</th>
                        <td colspan="3" class="p15"><c:out value="${cr2100mVO.branchName }"/></td>
                    </tr>
                    <tr>
                        <th scope="row">관리번호</th>
                        <td colspan="3" class="p15"><c:out value="${cr2100mVO.tempNo }"/></td>
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
                        </td>
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
		</div>
		<!-- //contents -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>
