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
$(document).ready(function(){

	

})

//보고서 수정화면
function fn_modify(){
			
	$("#detailForm").attr("action","<c:url value='/qxsepmny/ech0501/ech0501Modify.do'/>").submit();
}
//파일 다운로드
function fn_filedownload(attachSeq, boardType){
	
	location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
}
//리스트 목록으로
function fn_list(){		

	$("#reList").attr("action","<c:url value='/qxsepmny/ech0501/ech0501List.do'/>").submit();
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
	            <jsp:param name="dept2" value="보고서관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
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
                        <td><c:out value="${rs1000mVO[0].vendNm }"/></td>
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
                        <td><c:out value="${rs1000mVO[0].rvStNm }"/></td>
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
                            	 <p>보고일자  : <c:out value="${rs5020Map.rsImage.rptDt }"/></p> 
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
                             	<p>보고일자  : <c:out value="${rs5020Map.rsPlan.rptDt }"/></p>                        
							</div>
                        </td>
                    </tr>
                    <tr id="draftRpt_tr">
                        <th scope="row"><i>*</i>초안보고서</th>
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
                        	<p>보고일자  : <c:out value="${rs5020Map.draftRpt.rptDt }"/></p> 
                            </div>
                        </td>
                    </tr>
                    <tr id="finalRpt_tr">
                        <th scope="row"><i>*</i>최종보고서</th>
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
                            	<p>보고일자  : <c:out value="${rs5020Map.finalRpt.rptDt }"/></p>
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
                            	<p>보고일자 : <c:out value="${rs5020Map.summary.rptDt }"/></p> 
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
                            	 <p>보고일자 : <c:out value="${rs5020Map.korRpt.rptDt }"/></p> 
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
                            	 <p>보고일자 : <c:out value="${rs5020Map.engRpt.rptDt }"/></p> 
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
                             	<p>보고일자  :<c:out value="${rs5020Map.gita1.rptDt }"/></p> 
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
                            	 <p>보고일자 : <c:out value="${rs5020Map.gita2.rptDt }"/></p> 
                            </div>
                        </td>
                        
                    </tr>
                    
                </tbody>
            </table>
  </form:form>
            <!-- //보고서 관리 -->
			<!-- 버튼 -->
					<%
					   String word1 = request.getParameter("searchCondition1");
					   String word2 = request.getParameter("searchCondition2");
					   String word3 = request.getParameter("searchCondition3");
					   String word4 = request.getParameter("searchCondition4");
					   String word5 = request.getParameter("searchCondition5");
					   String word6 = request.getParameter("searchCondition6");
					   if(word6 == null){
						   word6 ="";
					   }
					   String searchWord = request.getParameter("searchWord");
					   String year = request.getParameter("searchYear");
					%>
				<form method="post" id="reList">
					<input type="hidden"  id="searchCondition1" name="searchCondition1" value="<%=word1 %>"/>
					<input type="hidden"  id="searchCondition2" name="searchCondition2" value="<%=word2 %>"/>
					<input type="hidden"  id="searchCondition3" name="searchCondition3" value="<%=word3 %>"/>
					<input type="hidden"  id="searchCondition4" name="searchCondition4" value="<%=word4 %>"/>
					<input type="hidden"  id="searchCondition5" name="searchCondition5" value="<%=word5 %>"/>
					<input type="hidden"  id="searchCondition6" name="searchCondition6" value="<%=word6 %>"/>
					<input type="hidden"  id="searchYear" name="searchYear" value="<%=year%>"/>
					<input type="hidden"  id="searchWord" name="searchWord" value="<%=searchWord%>"/>

				</form>
			<div class="btn_area">
			 	<a href="#" class="btn_sub" onclick="fn_list();" >목록</a> 
				<c:if test="${rs1000mVO[0].dateLockyn eq 'N' }">
			   		 <a href ="#" onclick="fn_modify();">수정</a>
				</c:if>
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