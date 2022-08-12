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

	//보고서 저장	
	function fn_modify(){
	 	$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0502/ech0502Modify.do'/>").submit();
	 	
	//목록으로
	}
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0502/ech0502List.do'/>";
	}
	//보고서 양식 삭제
	function fn_delete(){
		if(confirm('해당 양식을 삭제하시겠습니까?')){
			$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0502/ech0502Delete.do'/>").submit();
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
		    <form:form commandName="rs5010mVO" id="detailForm" name="detailForm" enctype="multipart/form-data">
            	<form:hidden path="rptNo"/>
            </form:form>
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
                        <th scope="row">임상분류</th>
                        <td>
                        	<!-- <select>
                        		<option>선택</option>
                        	</select> -->
                        	<c:out value="${rs5010mVO.rsFieldNm}"/>
                        </td>
                        <th scope="row" class="bl">보고서종류</th>
                        <td>                      	
                        	<c:out value="${rs5010mVO.rptClsNm }"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">보고서 양식명</th>
                        <td colspan="3">
                        	<c:out value="${rs5010mVO.rptfrName }"/>
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
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt01.attachNo }'/>', '<c:out value='${attachMap.attachRpt01.boardType }'/>'); return false;">
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
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt02.attachNo }'/>', '<c:out value='${attachMap.attachRpt02.boardType }'/>'); return false;">
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
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt03.attachNo }'/>', '<c:out value='${attachMap.attachRpt03.boardType }'/>'); return false;">
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
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt04.attachNo }'/>', '<c:out value='${attachMap.attachRpt04.boardType }'/>'); return false;">
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
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt05.attachNo }'/>', '<c:out value='${attachMap.attachRpt05.boardType }'/>'); return false;">
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
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02" onclick="fn_list();">취소</a>
				<a href="#" onclick="fn_delete(); return false;">삭제</a>
				<a href="#" onclick="fn_modify();">수정</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	
</div>	
<!-- //wrap -->
</body>
</html>