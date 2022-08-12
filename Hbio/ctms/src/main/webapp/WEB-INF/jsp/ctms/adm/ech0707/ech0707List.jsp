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
		//엑셀다운로드권한 
		var ynexauth = '<c:out value="${exauth}"/>';
		if(ynexauth=='N') {
			$('.btn_excel').css("display","none");
		}
		
		var ynadminType = '<c:out value="${admintype}"/>';
		if(ynadminType == '2'){ //일반사용자권한 - 삭제, 수정 버튼 숨기기
			$('.nonDisp').css("display","none");
		}
		
	})

	//공통코드분류관리 상세보기 화면
	function fn_view(corpCd, cdCls, cd){		
	 	$("#corpCd").val(corpCd);
	 	$("#cdCls").val(cdCls);
	 	$("#cd").val(cd);
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0707/ech0707View.do'/>").submit();
	}
	
	//공통코드분류관리 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0707/ech0707List.do'/>").submit();
	}
	
	//공통코드분류관리 등록화면
	function fn_regist(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0707/ech0707Modify.do'/>").submit();
	}
	
	//공통코드분류관리 엑셀다운로드
	function fn_excelDown(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0707/ech0707Excel.do'/>").submit();
	}
	
	// 공통코드 - 대분류와 연동하여 중분류코드 가져오기 2020.12.12 개발2 
	function fn_search_clscat2(){
		var corpCd = $("#corpCd").val();
		alert(corpCd);
		alert(cd);
		var cd = $("#searchCondition1").val();
		$.ajax({
			url: "<c:url value='/qxsepmny/ech0707/ech0707AjaxClsCat2.do' />"
			, type: "post"
			, data: "cd="+$("#searchCondition1").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = '';
				
				for(var i=0; i<resultList.length; i++){
					html += '<option value="'+resultList[i].cd+'">'+resultList[i].cdName+'</option>';
				}
				
				$("#searchCondition2").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
		
	function fn_search_seme(ele){
		$.ajax({
			url: "<c:url value='/qxsepmny/ech0707/ech0707AjaxClsCat2.do' />"
			, type: "post"
			, data: "cd="+$(ele).val()
			, dataType:"json"
			, success: function(data){
				resultList = data.semeList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<option value="'+resultList[i].semester+'">'+resultList[i].semeNm+'</option>';
				}
				
				$("#searchCondition2").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	
</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" id="corpCd" name="corpCd"/>
<input type="hidden" id="cdCls" name="cdCls"/>
<input type="hidden" id="cd" name="cd"/>
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
	            <jsp:param name="dept2" value="공통코드분류관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>대분류</p>
						<span>		
							
							<form:select id="searchCondition1" path="searchCondition1">
								<form:option value="">전체</form:option>
								<c:forEach var="clsCat1" items="${clsCat1}">
									<form:option value="${clsCat1.cd}"><c:out value="${clsCat1.cdName}(${clsCat1.cd}}" /></form:option>
								</c:forEach>
							</form:select>
						</span>
					</li>	
					<li>
						<p>중분류</p>
						<span>
							<form:select id="searchCondition2" path="searchCondition2">
								<form:option value="">전체</form:option>
								<c:forEach var="clsCat2" items="${clsCat2}">
									<form:option value="${clsCat2.cd}"><c:out value="${clsCat2.cdName}(${clsCat2.cd})" /></form:option>
								</c:forEach>
							</form:select>
						</span>
					</li>
					<li>
						<p>사용여부</p>
						<span>
							<select  name="searchCondition3">
								<option value="">전체</option>
								<option value="1">사용</option>
								<option value="2">미사용</option>
							</select> 
						</span>
					</li>
                    <li>
						<p>검색어</p>
						<!--  <span>
							<select name="searchCondition2">
								<option>검색조건</option>
								<option value="1">지사명</option>
							</select>
						</span> -->
                        <span class="type02">
                            <input type="text" name="searchWord" class="input-data" placeholder="코드명칭 또는 설명을  입력하세요" />
                        </span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_list(1); return false;">조회</a>
			</div>
			<!-- //검색영역 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<span>
					총<strong><c:out value="${totalCount }"/></strong>건
				</span>				
				<!-- 버튼 -->
				<div>
					<a href="#" onclick="fn_excelDown(); return false;" class="btn_excel">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<!-- 목록 -->
			<table class="tbl_list tr_link">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:20%" />
					<col style="width:auto%" />
					<col style="width:5%" />
                    <col style="width:5%" />
                    <col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">코드분류</th>
						<th scope="col">공통코드</th>
						<th scope="col">코드명</th>
						<th scope="col">설명</th>
						<th scope="col">정렬순서</th>
						<th scope="col">사용여부</th>
						<th scope="col">분류카테고리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr onclick="fn_view('<c:out value='${result.corpCd}'/>','<c:out value='${result.cdCls}'/>','<c:out value='${result.cd}'/>'); return false;">					
						<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
						<td><c:out value="${result.cdCls }"/></td>
						<td><c:out value="${result.cd }"/></td>
						<td><c:out value="${result.cdName}"/></td>
						<td><c:out value="${result.cdDesc}"/></td>
						<td><c:out value="${result.dspSeq}"/></td>
						<td><c:out value="${result.useYnNm}"/></td>
						<td><c:out value="${result.clsCatNm}"/></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<!-- //목록 -->
			<!--  목록 하단 -->
			<div class="list_btm">
				<!-- 페이징 -->
				<div class="pagenate">
					<div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
					</div>
				</div>
				<!-- //페이징 -->
				<!-- 하단버튼 -->
				<div class="list_btm_btn">
					<a href="#" class="nonDisp" onclick="fn_regist();">등록</a>					
				</div>
				<!-- //하단버튼 -->
			</div>
			<!-- //목록 하단 -->
		</div>
		<!-- //contents -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	</div>
	<!-- //container -->
</div>
<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
<!--// footer -->	
<!-- //wrap -->
</form:form>
</body>
</html>