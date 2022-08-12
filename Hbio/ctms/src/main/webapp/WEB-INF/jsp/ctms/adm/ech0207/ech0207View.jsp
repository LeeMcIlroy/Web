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

//식별번호 병합
$(function (){
	 $(".rowspan_td").each(function() {   	
	    	
	        var rows = $(".rowspan_td" + ":contains('" + $(this).text() + "')");

	        if (rows.length > 1) {
	            rows.eq(0).attr("rowspan", rows.length);
	            rows.not(":eq(0)").remove();
	        } 
	    });
 	 
})
//localStorage를 이용해서 확정자 피험자 참여자 카운트 가져오기
var cfmCnt = localStorage.getItem("cfmCnt");	

//초기값 설정
function fn_insert(){
	
	var result = new Array();
	
	<c:forEach items="${resultList2}" var="resultList2">
				var data = new Object();
				data.rsjNo 	="${resultList2.rsjNo}";
				data.rsNo  	="${resultList2.rsNo}";
				data.rsiNo 	="${resultList2.rsiNo}";
				//data.brsjNo ="${resultList2.rsiNo}";
				console.log(data);
			result.push(data);
	</c:forEach>
		
     	if(cfmCnt == 0){
     		alert("참여자가 없습니다.");
     		return;
     	}
     	
      	
	for(var j = 1; j<=cfmCnt; j++){
	      
		
		var html ='';

		html += '<tr>';
		html += '<td>'+result[j].rsiNo+'</td>';			
		html += '<td>0</td>';						
		html += '<td>0</td>';
		html += '</tr>';
		
		$('#addRow').append(html);

		$.ajax({

		       type: "POST",
		       url:  "<c:url value='/qxsepmny/ech0207/ech0207View.do'/>",			      
		       data: '',	    	  
               success: function (data) {          		
       	        	 location.reload();		       	 
		       }, 
		       error: function (jqXHR, textStatus, errorThrown) {
		             alert(jqXHR + ' ' + textStatus.msg);
		       }
			});	
		}
		
	}

	function fn_pop(rsiNo,rsNo){
		
		//팝업창 가운데 정렬
		var popupWidth = 730;
		var popupHeight = 650;
		
		var popupX = (window.screen.width / 2) - (popupWidth / 2);
		var popupY = (window.screen.height / 2) - (popupHeight / 2);

		$('#rsNo').val(rsNo);
		$('#rsiNo').val(rsiNo);
		
		var stat  = "width=730, height=650, menubar=no, status=no, toolbar=no, scrollbars=1 ,left="+popupX+" , top="+popupY+" ";
	
		window.open("","tar",stat );
		$('#frm').submit();
	}
	
	function fn_delete(){
		if(confirm('해당 목록을 삭제하시겠습니까?')){
			$("#delfrm").attr("action","<c:url value='/qxsepmny/ech0207/ech0207Delete.do'/>").submit();
		}
	}
	function viewUpdate2(){
		var resultAdd2 = new Array();
		
		<c:forEach items="${resultNew2}" var="new3100m">
			var newdata2 = new Object();
			
			newdata2.rsjNo ="${new3100m.rsjNo}";
			newdata2.rsNo  ="${new3100m.rsNo}";
			newdata2.rsiNo  ="${new3100m.rsiNo}";
			newdata2.mtlNo  ="${new3100m.mtlNo}";
			newdata2.mtlDsp  ="${new3100m.mtlDsp}";
			newdata2.mrsNo  ="${new3100m.mrsNo}";
			newdata2.ncYn  ="${new3100m.ncYn}";
			
			resultAdd2.push(newdata2);
		</c:forEach>
		
		 for(var j = 0; j < resultAdd2.length; j++){
		      
			
				$.ajax({

				       type: "POST",
				       url:  "<c:url value='/qxsepmny/ech0207/ech0207ViewUpdate2.do'/>",
				      
				       data: {
				    	   "rsjNo2"  : resultAdd2[j].rsjNo,
				    	   "rsNo2"  : resultAdd2[j].rsNo,
				    	   "rsiNo2" : resultAdd2[j].rsiNo,
				    	   "mtlNo2" : resultAdd2[j].mtlNo,
				    	   "mtlDsp2" : resultAdd2[j].mtlDsp,
				    	   "mrsNo" : resultAdd2[j].mrsNo,
				    	   "ncYn2"	: resultAdd2[j].ncYn

				       },
					    	  
		               success: function (data) {
				        	 
				       }, 
				       error: function (jqXHR, textStatus, errorThrown) {
				          //alert(jqXHR + ' ' + textStatus.msg);
				       }
					});	 		
		     } 
	}
 	function viewUpdate(){
 		
			$.ajax({

			       type: "POST",
			       url:  "<c:url value='/qxsepmny/ech0207/ech0207ViewUpdate.do'/>",
			      
			       data: {
			    	   //"rsjNo"  : resultAdd[j].rsjNo,
			    	   "rsNo"  : $('#rsNo').val()
			    	   /* "rsiNo" : resultAdd[j].rsiNo,
			    	   "mtlNo" : resultAdd[j].mtlNo,
			    	   "mtlDsp" : resultAdd[j].mtlDsp,
			    	   "ncYn"	: resultAdd[j].ncYn */

			       },
				    	  
	               success: function (data) {
			        	 location.reload();
			        	 
			       }, 
			       error: function (jqXHR, textStatus, errorThrown) {
			          alert(jqXHR + ' ' + textStatus.msg);
			       }
				});	 		
	    // }
		
			     
	} 
 	
 	// 피부자극결과 목록
 	
 function fn_list(){		

 	$("#reList").attr("action","<c:url value='/qxsepmny/ech0207/ech0207List.do'/>").submit();
}


	//피부자극평가(설문)에서 피부자극평가자료(CR3100M, CR3110M) 자동 생성  
	function fn_createSsResult(){
		if(confirm('피부자극평가결과를 자동생성합니다. CRF작성관리를 확인해주세요. \r\n생성하시겠습니까?')){
			var corpCd = $("#corpCd").val();
			var rsNo = $("#rsNo").val();
			
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0207/ech0207AjaxCreateSsResult.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsNo="+rsNo
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

	//피부자극결과 생성 엑셀다운로드
	function fn_excelDown(){
		if(confirm('출력하는 데이터건수에 따라 시간이 지체될 수 있습니다. \r\n진행하시겠습니까?')){
			$("#delfrm").attr("action", "<c:url value='/qxsepmny/ech0207/ech0207ExcelResult.do'/>").submit();
		}
	}

	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>eCRF관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="자료추출"/>
	            <jsp:param name="dept2" value="피부자극결과"/>
           	</jsp:include>
           	<!-- //타이틀 -->
           
           	<form:form commandName="searchVO" id="delfrm" name="delfrm">
           		<form:hidden path="corpCd"/>
            	<form:hidden path="rsNo"/>
            	
           	</form:form>
         
            <!-- 목록 -->
			<table class="tbl_list multi_hd" >
				<colgroup>
					<col style="width:8%" />
					<col style="width:15%" />
					<col style="width:8%" />
					<col style="width:8%" />		
				</colgroup>
				<thead>
					<tr>
						<th scope="col">식별코드</th>
						<th scope="col" >시험물질</th>
						<th scope="col" >첩포 제거 30분 후</th>
						<th scope="col">첩포 제거 24시간 후</th>
					</tr>
				</thead>
				<tbody id="addRow" >
				<c:if test="${resultList.size() != 0 }">
						<c:forEach items="${resultList}" var="result">
							<tr>
						    	<td style= "cursor:pointer; text-decoration: underline;" class="rowspan_td"><a onclick="fn_pop('<c:out value='${result.rsiNo}'/>','<c:out value='${result.rsNo}'/>'); return false;" ><c:out value="${result.rsiNo}"/></a> </td> <!-- 식별번호 -->   
						    	<td style="text-align: left;  border-left:1px solid #dddddd;"><c:out value="${result.mtlDsp } ( ${result.mtlName } )"/></td>
							    <td><c:out value="${result.m30Vl1 }"/> </td>						
							    <td><c:out value="${result.h24Vl1 }"/> </td>					
							</tr>
							<tr style="display:none;">
								<td>
								<form name="frm" id="frm" action="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0207/ech0207Modify.do'/>" target="tar">
									<input type="hidden"  id="rsiNo" name="rsiNo" value="${result.rsiNo}"></input>
									<input type="hidden"  id="rsNo" name="rsNo" value="${result.rsNo}"></input>									
								</form>
								</td>
							</tr>
						</c:forEach>
				</c:if>
				</tbody>
			</table>	
				 <div class="btn_area">
					<c:if test="${resultList.size() == 0 }">
							<!-- <a onclick="fn_createSsResult(); return false;" class="btn_sub type02" >피부자극평가자동생성</a> -->
							<a onclick="fn_insert(); return false;" class="btn_sub" id="btn_setBegin">초기값설정</a>			
					</c:if>
					<%
					   String word1 = request.getParameter("searchCondition1");
					   String word2 = request.getParameter("searchCondition2");
					   String word3 = request.getParameter("searchCondition3");
					   String word4 = request.getParameter("searchCondition4");
					   String word5 = request.getParameter("searchCondition5");
					   String word6 = request.getParameter("searchCondition6");
					   String word7 = request.getParameter("searchCondition7");
					   if(word7 == null) word7 ="";			   
					   String year = request.getParameter("searchYear");
					   String searchWord = request.getParameter("searchWord");

					%>
				<form method="post" action="/qxsepmny/ech0207/ech0207List.do" id="reList">
					<input type="hidden"  id="searchCondition1" name="searchCondition1" value="<%=word1%>"/>
					<input type="hidden"  id="searchCondition2" name="searchCondition2" value="<%=word2%>"/>
					<input type="hidden"  id="searchCondition3" name="searchCondition3" value="<%=word3%>"/>
					<input type="hidden"  id="searchCondition4" name="searchCondition4" value="<%=word4%>"/>
					<input type="hidden"  id="searchCondition5" name="searchCondition5" value="<%=word5%>"/>
					<input type="hidden"  id="searchCondition6" name="searchCondition6" value="<%=word6%>"/>
					<input type="hidden"  id="searchCondition7" name="searchCondition7" value="<%=word7%>"/>
					<input type="hidden"  id="searchYear" name="searchYear" value="<%=year%>"/>
					<input type="hidden"  id="searchWord" name="searchWord" value="<%=searchWord%>"/>					
				</form>				
				 	 <a href="#" class="btn_sub" onclick="fn_list();" >목록</a>
				 	 <a onclick="fn_createSsResult(); return false;" class="btn_sub type02" >피부자극평가자동생성</a> 
					 <a href="#" class="btn_excel" onclick="fn_excelDown(); return false;">엑셀</a>
				<c:if test="${resultList.size() != 0 }">
						<c:if test="${resultNew.size() != 0 }">	
							<a class="btn_sub" onclick="viewUpdate();">추가</a> 
						</c:if>
						<a class="btn_sub" onclick="fn_delete();">삭제</a> 
					</c:if>
				</div>
			<!-- //목록 -->
		</div>
		<!-- //contents -->
	</div>
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>