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
		
		// 연구대상자 목록에서 선택
		$("#all-chk").change(function(){
			$("input[name=rsjSeq]").prop("checked", $(this).prop('checked'));
		});
		
		var message = '<c:out value="${message}"/>';
		if(message != ''){
			alert(message);
			opener.location.reload();
			window.close();
		}
		
		$("#btn_srch_deatil").click(function(){ 
			if($("#srch_detail").is(":visible")){ 
				$("#srch_detail").css("display", "none"); 
			}else{ 
				$("#srch_detail").css("display", "block"); 
			} 
		});
		
	});
	
	// 연구대상자선정 일괄등록 
	function fn_code(){
		if($("input[name=rsjSeq]:checked").length == 0){
			alert('연구대상자를 선택해 주세요.');
			return;
		}
		if(confirm('연구대상자로 일괄 등록합니다.\r\n등록하시겠습니까?')){		
			$("#listForm").attr("method", "post").attr("action", "<c:url value='/qxsepmny/ech1001/ech1001RsiCodeBat.do'/>").submit();
		}			
	}	
	
	//검색어 clear
	function fn_resetWord(){
		$("#searchWord").val("");
		$("#searchWord").focus();
	}
	
	//연구과제관리 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech1001/ech1001List.do'/>").submit();
	}
	
</script>
<body>

<!-- pop_wrap -->
<div class="pop_wrap">
	<!-- pop_header -->
	<div class="pop_header">
		<h1 class="hidden"><a href="#">H&amp;Bio</a></h1>
		<h2>피험자 조회</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<form:form commandName="searchVO" id="listForm" name="listForm">
	<input type="hidden" id="corpCd" name="corpCd"  value="${searchVO.corpCd}"/>
	<input type="hidden" id="rsNo" name="rsNo" value="${searchVO.rsNo}"/>
	<div class="pop_con">
		<!-- 검색영역 -->
		<div class="srch_area">
			<ul>
				<li>
					<p>성별</p>
					<span>
						<select name="searchCondition1" id="searchCondition1" >
							<option value="" <c:if test="${searchVO.searchCondition1  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="1" <c:if test="${searchVO.searchCondition1  eq '1' }">selected="selected"</c:if> >남</option>
							<option value="2" <c:if test="${searchVO.searchCondition1  eq '2' }">selected="selected"</c:if> >여</option>
						</select>
					</span>
				</li>
				<li>
					<p>나이</p>
					<span>
						<select name="searchCondition2" id="searchCondition2" >
							<option value="" <c:if test="${searchVO.searchCondition2  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="1" <c:if test="${searchVO.searchCondition2  eq '1' }">selected="selected"</c:if> >20세미만</option>
							<option value="2" <c:if test="${searchVO.searchCondition2  eq '2' }">selected="selected"</c:if> >20~39세</option>
							<option value="3" <c:if test="${searchVO.searchCondition2  eq '3' }">selected="selected"</c:if> >40~59세</option>
							<option value="4" <c:if test="${searchVO.searchCondition2  eq '4' }">selected="selected"</c:if> >60세이상</option>
						</select>
					</span>
				</li>
				<li>
					<p>모집나이</p>					
					<span>
						<input type="text" name="searchCondition5" class="p30" placeholder="00" />~
						<input type="text" name="searchCondition6" class="p30" placeholder="99" />세 이하
					</span>
				</li>	
				<li>
					<p>참여횟수</p>
					<span>
						<select name="searchCondition4" id="searchCondition4" >
							<option value="" <c:if test="${searchVO.searchCondition4  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="1" <c:if test="${searchVO.searchCondition4  eq '1' }">selected="selected"</c:if> >1회이하</option>
							<option value="2" <c:if test="${searchVO.searchCondition4  eq '2' }">selected="selected"</c:if> >2회</option>
							<option value="3" <c:if test="${searchVO.searchCondition4  eq '3' }">selected="selected"</c:if> >3회이상</option>
						</select>						
					</span>
				</li>
				<li>
					<p>검색어</p>
					<span>
						<select name="searchCondition3" id="searchCondition3" onchange="fn_resetWord(); return false;">
							<option value="" <c:if test="${searchVO.searchCondition3  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="1" <c:if test="${searchVO.searchCondition3  eq '1' }">selected="selected"</c:if> >전체</option>
							<option value="2" <c:if test="${searchVO.searchCondition3  eq '2' }">selected="selected"</c:if> >이름</option>
							<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >거주지</option>
							<option value="4" <c:if test="${searchVO.searchCondition3  eq '4' }">selected="selected"</c:if> >핸드폰번호</option>
						</select>
					</span>
					<span class="type02">
						<input type="text" name="searchWord" class="input-data" placeholder="검색어 입력" />
					</span>
				</li>
			</ul>
			<!-- 조회버튼 -->
			<a href="#" onclick="fn_list(1); return false;">조회</a>
		</div>
		<a href="#" class="btn_sub" id="btn_srch_deatil">연구대상자 특성조건 펼치기</a>				
		<div class="srch_area" id="srch_detail" style="display: none;">
			<ul>
				<li>
					<p>안면여드름</p>
					<span>
						<select name="searchParam1" id="searchParam1">
							<option value="" <c:if test="${searchVO.searchParam1  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam1  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam1  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>등여드름</p>
					<span>
						<select name="searchParam2" id="searchParam2">
							<option value="" <c:if test="${searchVO.searchParam2  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam2  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam2  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>팔자주름</p>
					<span>
						<select name="searchParam3" id="searchParam3">
							<option value="" <c:if test="${searchVO.searchParam3  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam3  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam3  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>셀룰라이트</p>
					<span>
						<select name="searchParam4" id="searchParam4">
							<option value="" <c:if test="${searchVO.searchParam4  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam4  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam4  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>눈가주름</p>
					<span>
						<select name="searchParam5" id="searchParam5">
							<option value="" <c:if test="${searchVO.searchParam5  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam5  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam5  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>다크서클</p>
					<span>
						<select name="searchParam6" id="searchParam6">
							<option value="" <c:if test="${searchVO.searchParam6  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam6  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam6  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>광피부타입</p>
					<span>
						<select name="searchParam7" id="searchParam7">
							<option value="" <c:if test="${searchVO.searchParam7  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam7  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam7  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>색소침착</p>
					<span>
						<select name="searchParam8" id="searchParam8">
							<option value="" <c:if test="${searchVO.searchParam8  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam8  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam8  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>탈모</p>
					<span>
						<select name="searchParam9" id="searchParam9">
							<option value="" <c:if test="${searchVO.searchParam9  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam9  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam9  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>아이백</p>
					<span>
						<select name="searchParam10" id="searchParam10">
							<option value="" <c:if test="${searchVO.searchParam10  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam10  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam10  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>민감여부</p>
					<span>
						<select name="searchParam11" id="searchParam11">
							<option value="" <c:if test="${searchVO.searchParam11  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam11  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam11  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>비듬</p>
					<span>
						<select name="searchParam12" id="searchParam12">
							<option value="" <c:if test="${searchVO.searchParam12  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam12  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam12  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
				<li>
					<p>홍조</p>
					<span>
						<select name="searchParam13" id="searchParam13">
							<option value="" <c:if test="${searchVO.searchParam13  eq '' }">selected="selected"</c:if> >선택</option>
							<option value="Y" <c:if test="${searchVO.searchParam13  eq 'Y' }">selected="selected"</c:if> >있음</option>
							<option value="N" <c:if test="${searchVO.searchParam13  eq 'N' }">selected="selected"</c:if> >없음</option>
						</select>
					</span>
				</li>
			</ul>
			
		</div>
		<!-- //검색영역 -->
		<!-- 목록 -->
		<table class="tbl_list">
			<colgroup>
				<col style="width:4%" />
				<col style="width:6%" />
				<col style="width:8%" />
				<col style="width:8%" />
				<col style="width:6%" />
				<col style="width:6%" />
				<col style="width:auto" />
				<col style="width:14%" />
				<col style="width:6%" />
				<col style="width:10%" />
				<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" id="all-chk"/></th>
					<th scope="col">번호</th>
					<th scope="col">이름</th>
					<th scope="col">생년월일</th>
					<th scope="col">나이</th>
					<th scope="col">성별</th>
					<th scope="col">거주지</th>
					<th scope="col">핸드폰</th>
					<th scope="col">연구<br />순응도</th>
					<th scope="col">참여횟수</th>
					<th scope="col">메모</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">			
					<tr>
						<td><input type="checkbox" name="rsjSeq" value="<c:out value='${result.rsjNo }'/>"/></td>		
						<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
						<td onclick="fn_view('<c:out value="${result.corpCd }"/>','<c:out value="${result.rsjNo }"/>'); return false;"><c:out value="${result.rsjName }"/></td>
						<td><c:out value="${result.brDt}"/></td>
						<td><c:out value="${result.age}"/></td>
						<td><c:out value="${result.genYnNm}"/></td>
						<td><c:out value="${result.addr}"/></td>
						<td><c:out value="${result.hpNo}"/></td>
						<td><c:out value="${result.rsjStClsNm}"/></td>						
						<td><c:out value="${result.jnCnt}"/></td>						
						<td><c:out value="${result.remk}"/></td>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="11">연구대상자 정보가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<!-- //목록 -->
		</form:form>
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="javascript:window.close();" class="type02">취소</a>
			<a href="#" onclick="fn_code(); return false;" >저장</a>
		</div>
		<!-- //버튼 -->
	</div>
	<!-- //pop_con -->
</div>
<!-- //pop_wrap -->
</body>
</html>
