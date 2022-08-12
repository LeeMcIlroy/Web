<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<style type="text/css">
</style>
<script type="text/javascript">

	$(document).ready(function() {
		
		var ynadminType = '<c:out value="${admintype}"/>';
		if(ynadminType == '2'){ //일반사용자권한 - 삭제, 수정 버튼 숨기기
			$('.nonDisp').css("display","none");
		}

		$("#tab-1").show();
		$("#tab1").addClass("on");
		$("#tab-2").hide();
		$("#tab2").removeClass("on");
		
		
	  $(".tab_title li").click(function() {
	    var idx = $(this).index();
	    
	    switch (idx) {
		case 0:
			$("#tab-1").show();
			$("#tab1").addClass("on");
			$("#tab-2").hide();
			$("#tab2").removeClass("on");
	    	break;
		case 1:
			$("#tab-1").hide();
			$("#tab1").removeClass("on");
			$("#tab-2").show();
			$("#tab2").addClass("on");
	    	break;	
	  	default:
	  		$("#tab-1").show();
			$("#tab1").addClass("on");
			$("#tab-2").hide();
			$("#tab2").removeClass("on");
		}
	    
	    //$(".tab_title li").removeClass("on");
	    //$(".tab_title li").eq(idx).addClass("on");
	    //$(".tab_cont > div").hide();
	    //$(".tab_cont > div").eq(idx).show();
	  })
	});

	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0701/ech0701List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0701/ech0701Modify.do'/>").submit();
	}
	
	//CTMS운영사 페이지 삭제
	function fn_delete(){
		if (confirm("회사정보를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0701/ech0701Delete.do'/>").submit();
			
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
		<h2>기준정보</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="기준정보"/>
	            <jsp:param name="dept2" value="회사관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="ct1000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${ct1000mVO.corpCd }"/>
				<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
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
							<th scope="row">회사명</th>
							<td>
								<c:out value="${ct1000mVO.corpName}" />
							</td>
							<th scope="row" class="bl">회사코드(변경불가)</th>
							<td>
								<c:out value="${ct1000mVO.corpCd}" />
							</td>
						</tr>
						<tr>
							<th scope="row">사업자번호</th>
							<td>
								<c:out value="${ct1000mVO.regno1}" />-<c:out value="${ct1000mVO.regno2}" />-<c:out value="${ct1000mVO.regno3}" />
								
							</td>
							<th scope="row" class="bl">사용여부</th>
							<td>
								<c:out value="${ct1000mVO.useYnNm}" />
							</td>	
						</tr>
						<tr>
							<th scope="row">대표이사</th>
							<td>
								<c:out value="${ct1000mVO.excutName}" />
							</td>
							<th scope="row" class="bl">개인정보책임자</th> 
 							<td>
								<c:out value="${ct1000mVO.privmngName}" />
							</td>
						</tr>
						<tr>
							<th scope="row">홈페이지</th>
							<td>
								<c:out value="${ct1000mVO.homepage}" />
							</td>
							<th scope="row" class="bl">대표전화번호</th>
							<td>
								<c:out value="${ct1000mVO.telno}" />
							</td>
						</tr>
						<tr>
							<th scope="row">고객센터번호</th>
							<td>
								<c:out value="${ct1000mVO.cntrTelno}" />
							</td>
							<th scope="row" class="bl">대표이메일</th>
							<td>
								<c:out value="${ct1000mVO.email}" />
							</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td colspan="3">
								<c:out value="${ct1000mVO.postNo}" />
								<c:out value="${ct1000mVO.addrMain}" />
								<c:out value="${ct1000mVO.addrGita}" />
							</td>
						</tr>
						<tr>
							<th scope="row">연구고유번호</th>
							<td>
								<c:out value="${ct1000mVO.rsNo1}" />
							</td>
							<th scope="row" class="bl">IRB심의고유번호</th>
							<td>
								<c:out value="${ct1000mVO.rvNo1}" />
							</td>
						</tr>
						<tr>
							<th scope="row">견적고유번호</th>
							<td>
								<c:out value="${ct1000mVO.opNo1}" />
							</td>
							<th scope="row" class="bl">계약고유번호</th>
							<td>
								<c:out value="${ct1000mVO.ctrtNo1}" />
							</td>
						</tr>
						<%-- <tr>
							<th scope="row">로고이미지</th>
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
							</td> 
						</tr> --%>
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 탭버튼 -->
	            <div class="tab_area tab06">
	                <ul class="tab_title">
	                	<li><a href="#" id="tab1" class="tab-link current on" data-tab="tab-1">이용약관</a></li>
	                	<li><a href="#" id="tab2" class="tab-link" data-tab="tab-2">개인정보처리방침</a></li>
	                </ul>
	            </div>
	            <!-- //탭버튼 -->
	            <!-- 상세내용 -->
	            <div class="tab_con">
		            <div id="tab-1" class="tab-content current on">
		            	<c:out value="${ct1000mVO.useRule}" escapeXml="false;"/>	            
		            </div>
		            <div id="tab-2" class="tab-content">
		            	<c:out value="${ct1000mVO.privRule}" escapeXml="false;"/>	            
		            </div>
	            </div>
	            <!-- //상세내용 -->
            </form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<!--  <a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_delete(); return false;" class="type02" >삭제</a> -->
				<a href="#" onclick="fn_update(); return false;" class="nonDisp type02" >수정</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>