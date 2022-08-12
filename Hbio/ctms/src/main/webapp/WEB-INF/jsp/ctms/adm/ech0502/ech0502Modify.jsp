<%@ page language="java" contentType="text/html; charset=UTF-8;" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">	

    //보고서 저장	
	function fn_save(){
		if(fn_validate("detailForm")){
		 	$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0502/ech0502Update.do'/>").submit();
		}
	}

	//목록으로
	function fn_list(){
		
		location.href = "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0502/ech0502List.do'/>";	
		
	}
	//첨부파일 삭제
	function fn_delfile(fileKey, seq){
	
		var html = '';
		if(seq != ''){
			html += '<input type="hidden" id="delFile" name="delFile" value="'+seq+'"/>';
		}
			html += '<input type="file" id="'+fileKey+'" name="'+fileKey+'" onchange="fn_file_add(\''+fileKey+'\'); return false;"/>';
			html += '<label for="'+fileKey+'" id="'+fileKey+'_label" class="btn_sub">파일업로드</label>';
		
		
		$("#"+fileKey+"_div").html(html);
	}
	//첨부파일 추가
	function fn_file_add(fileKey){
		
		if(fileCheck_adm(fileKey)){
			var fileValue = $('#'+fileKey).val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
			var html = ''
		
			html+= '<div>';
			html+= '<span>'+fileName+'</span>';
			html+= '<a href="#" onclick="fn_delfile(\''+fileKey+'\',\'\');">삭제</a>';
			html+= '</div>'; 
			
			$("#"+fileKey+"_label").addClass('dpn');
			$("#"+fileKey+"_div").append(html); 
        } 
	}
</script>
<body>
<form:form commandName="rs5010mVO" id="detailForm" name="detailForm" enctype="multipart/form-data">
<form:hidden path="rptNo"/>
<input type="hidden" id="rptNo" name="rptNo">
<input type="hidden" id="corpCd" name="corpCd" value="${rs5010mVO.corpCd}">
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
	            <jsp:param name="dept2" value="보고서양식관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			
			<!-- 서브타이틀 -->
            <div class="sub_title_area type02">
                <h4>기본정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 기본정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                  <tbody>
                   <tr>
                        <th scope="row" class="bl"><i></i>임상분류</th>
                        <td>
                            <!-- 임상분류 목록(공통코드) CM4000M - CT2030  M P G O -->
							<form:select id="rsField" path="rsField">
								<form:option value="">선택</form:option>
									<c:forEach var="result" items="${ct2030}">									
										<form:option value="${result.cd}"><c:out value="${result.cdName}"/></form:option>										
									</c:forEach>
							</form:select>
                        </td>
                        <th scope="row" class="bl">보고서종류</th>
                        <td>
                       	   <form:select id="rptCls" path="rptCls">
								<form:option value="">선택</form:option>
									<c:forEach var="result" items="${ct2010}">									
										<form:option value="${result.cd}"><c:out value="${result.cdName}"/></form:option>										
									</c:forEach>
							</form:select>
                        </td>
                       
                    </tr>
                    <tr>
                        <th scope="row">보고서 양식명</th>
                        <td colspan="3">
                        	<form:input path="rptfrName"/>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //기본정보 -->
            <!-- 서브타이틀 -->
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
                        <td colspan="3" id="file_td">
                            <div class="attach_sec type02 mb02" id="attachRpt01_div">
	                            	<c:choose>
		                            		<c:when test="${attachMap.attachRpt01 != null }">
				                            	<div>
				                            		<span><c:out value="${attachMap.attachRpt01.orgFileName }"/></span>
				                            		<a href="#" onclick="fn_delfile('attachRpt01','<c:out value="${attachMap.attachRpt01.attachNo }"/>');">삭제</a>
				                            	</div>
		                            		</c:when>
		                            		<c:otherwise>
				                            	 <input type="file" id="attachRpt01" name="attachRpt01" onchange="fn_file_add('attachRpt01'); return false;"/>
				                            	<label for="attachRpt01" id="attachRpt01_label" class="btn_sub">파일업로드</label>  
		                            		</c:otherwise>
	                            	</c:choose>
                            </div>
                        	 <div class="attach_sec type02 mb02" id="attachRpt02_div">
                                 <c:choose>
	                            		<c:when test="${attachMap.attachRpt02 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt02.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt02','<c:out value="${attachMap.attachRpt02.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	 <input type="file" id="attachRpt02" name="attachRpt02" onchange="fn_file_add('attachRpt02'); return false;"/>
			                            	<label for="attachRpt02" id="attachRpt02_label" class="btn_sub">파일업로드</label> 	
	                            		</c:otherwise>
                            	</c:choose> 
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt03_div">
                                 <c:choose>
	                            		<c:when test="${attachMap.attachRpt03 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt03.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt03','<c:out value="${attachMap.attachRpt03.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                                <input type="file" id="attachRpt03" name="attachRpt03" onchange="fn_file_add('attachRpt03'); return false;"/>
			                            	<label for="attachRpt03" id="attachRpt03_label" class="btn_sub">파일업로드</label>    
	                            		</c:otherwise>
                            	</c:choose>     
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt04_div">
                          	     <c:choose>
	                            		<c:when test="${attachMap.attachRpt04 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt04.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt04','<c:out value="${attachMap.attachRpt04.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	 <input type="file" id="attachRpt04" name="attachRpt04" onchange="fn_file_add('attachRpt04'); return false;"/>
			                            	<label for="attachRpt04" id="attachRpt04_label" class="btn_sub">파일업로드</label> 
	                            		</c:otherwise>
                            	</c:choose>     
                            </div>
                            <div class="attach_sec type02 mb02" id="attachRpt05_div">
              	     			<c:choose>
	                            		<c:when test="${attachMap.attachRpt05 != null }">
			                            	<div>
			                            		<span><c:out value="${attachMap.attachRpt05.orgFileName }"/></span>
			                            		<a href="#" onclick="fn_delfile('attachRpt05','<c:out value="${attachMap.attachRpt05.attachNo }"/>');">삭제</a>
			                            	</div>
	                            		</c:when>
	                            		<c:otherwise>
			                            	 <input type="file" id="attachRpt05" name="attachRpt05" onchange="fn_file_add('attachRpt05'); return false;"/>
			                            	<label for="attachRpt05" id="attachRpt05_label" class="btn_sub">파일업로드</label> 
	                            		</c:otherwise>
                            	</c:choose> 
                            </div>  
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //파일첨부 -->
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list();" >취소</a>
				<a href="#" onclick="fn_save(); return false;">저장</a>		                
	        </div>
			<div>
			 	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	
	<!-- //container -->
</div>	
</form:form>
<!-- //wrap -->
</body>
</html>