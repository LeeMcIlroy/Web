<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">

	//체크박스 전체선택 & 전체해제
	$(function(){
		$(document).on("click","#allChkBox",function(){
			var chk=$(this).is(":checked");
			if(chk){
				$("input:checkbox[name='listChkBox']").prop("checked",true);
			}else{
				$("input:checkbox[name='listChkBox']").prop("checked",false);
			}
		});
	});

	// 조회
	function fn_select(hmwkSeq){
		$("#hmwkSeq").val(hmwkSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecHomeWorkView.do'/>").submit();
	}

	// 수정
	function fn_modify(sbjtSeq){
		$("#sbjtSeq").val(sbjtSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecSubjectModify.do'/>").submit();
	}

	/* pagination 페이지 링크 function */
	function fn_list(pageNo){
		$("#pageIndex2").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecHomeWorkList.do'/>").submit();
	}
	
	// 목록으로(주제목록)
	function fn_list_subject(){
		$("#pageIndex2").val(1);
		$("#searchType").val("");
		$("#searchCondition2").val("");
		$("#searchWord2").val("");
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecSubjectList.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(sbjtSeq){
		$("#sbjtSeq").val(sbjtSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecSubjectDelete.do'/>").submit();
	}
	
	// 파일 다운로드
	function fn_download(type, upSeq){
		location.href = "<c:url value='/cmmn/file/downloadFile.do?type="+type+"&fileId="+upSeq+"'/>";
	}
	
	// 첨삭 완료
	function fn_editing_finish(sbjtSeq){
		if(confirm("첨삭진행중을 첨삭완료로 일괄 처리 하시겠습니까?")){
			$("#sbjtSeq").val(sbjtSeq);
			$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/lec/admLecHomeWorkStatusUpdate.do'/>").submit();
			
		}else{
			return false;
		}
	}
	
	function fn_zip_download(){
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/lec/admLecHomeWorkZip.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchClass" />
<form:hidden path="searchSubject" />
<input type="hidden" id="sbjtSeq" name="sbjtSeq"/>
<input type="hidden" id="hmwkSeq" name="hmwkSeq"/>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!--// header -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의실"/>
            	<jsp:param name="dept2" value="${smtrClsInfo.smtrTitle }"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<!-- table -->
				<table class="view_tbl_03 mb30 mt30" summary="C/L 분류 관리">
					<caption>C/L 분류</caption>
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row" colspan="4"><c:out value="${subjectVO.sbjtTitle}"/></th>
						</tr>
						<tr>
							<th scope="row">제출기간</th>
							<td>
								<c:out value="${subjectVO.sbjtStartDate}"/>&nbsp;<c:out value="${subjectVO.sbjtStartTime }"/>&nbsp;
								~
								<c:out value="${subjectVO.sbjtEndDate}"/>&nbsp;<c:out value="${subjectVO.sbjtEndTime }"/>&nbsp;
							</td>
							<th scope="row">등록일</th>
							<td><c:out value="${subjectVO.regDate}"/></td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td colspan="3">
								<c:forEach items="${sbjtUpfileList }" var="sbjtUpfile">
									<a href="#" onclick="fn_download('SUBJECT', <c:out value='${sbjtUpfile.upSeq }'/>); return false;">
										<c:out value="${sbjtUpfile.upOriginFileName }"/>
									</a><br />
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td colspan="4"><c:out value="${subjectVO.sbjtContent }" escapeXml="false"/></td>
						</tr>
					</tbody>
				</table>
				<div class="mt30" style="width:100%; text-align:right;">※ [첨삭완료로 상태변경] 버튼을 클릭하면 첨삭진행중인 모든 과제가 첨삭완료 상태로 변경됩니다.</div>
				<table class="list_tbl_03 mt10" summary="주제 출제 목록">
					<caption>주제 출제</caption>
					<colgroup>
						<col style="width:10%" />
						<col style="width:58%" />
						<col style="width:10%" />
						<col style="width:22%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">작성자</th>
							<th scope="col">제출일자</th>
							<th scope="col">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
                       		<tr onclick="return false;" style="cursor: pointer;">
                       			<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex2-1) * 10 + status.count)}"/></td>
								<td class="ta_left">
									<a href="#" class="comt" onclick="fn_select(<c:out value='${result.hmwkSeq }'/>); return false;">
										<c:choose>
											<c:when test="${!empty result.hmwkNames && !empty result.hmwkHakbuns && !empty result.hmwkDepts }">
												<c:out value="${result.hmwkDepts }"/>/<c:out value="${result.hmwkHakbuns }"/>/<c:out value="${result.hmwkNames }"/>
											</c:when>
											<c:otherwise>
												<c:out value="${result.hmwkRegDept }"/>/<c:out value="${result.hmwkRegId }"/>/<c:out value="${result.hmwkRegName }"/>
											</c:otherwise>
										</c:choose>
										<c:if test="${result.cmmtCnt > 0 }">
											<span>(<c:out value="${result.cmmtCnt }"/>)</span>
										</c:if>
									</a>
								</td>
								<td><c:out value="${result.hmwkRegDate }"/></td>
								<td class="ta_left">
									<c:if test="${result.hmwkStatus eq 1 }">
										<a href="#" class="ta_s_btn03" style="cursor: default;">제출</a>
									</c:if>
									<c:if test="${result.hmwkStatus eq 2 }">
										<a href="#" class="ta_s_btn01" style="cursor: default;">첨삭완료</a>
									</c:if>
									<c:if test="${result.hmwkStatus eq 3 }">
										<a href="#" class="ta_s_btn01" style="cursor: default;">첨삭완료</a>
										<a href="#" class="ta_s_btn02" style="cursor: default;">첨삭확인완료</a>
									</c:if>
									<c:if test="${result.hmwkStatus eq 4 }">
										<a href="#" class="ta_s_btn01" style="cursor: default;">첨삭진행중</a>
									</c:if>
								</td>
                       		</tr>
                       	</c:forEach>
                       	<%--
						<tr>
							<td>10</td>
							<td class="ta_left"><a href="#" class="comt">응용인문학부 국어국문전공/1611***/최**<span>(3)</span></a></td>
							<td>2016-10-04 14:20</td>
							<td class="ta_left">
								<a href="#" class="ta_s_btn01">첨삭완료</a>
								<a href="#" class="ta_s_btn02">첨삭확인완료</a>
								<a href="#" class="ta_s_btn03">제출</a>
							</td>
						</tr>
					 	--%>
					</tbody>
					
				</table>				
				<div class="btm_area">
					<div class="btn_box">						
						<div class="btn_r">
							<a href="#" class="b_type04" onclick="fn_zip_download(); return false;">한번에 다운로드</a>
							<a href="#" class="b_type02" onclick="fn_editing_finish(<c:out value='${subjectVO.sbjtSeq }'/>); return false;">첨삭완료로 상태변경</a>
							<a href="#" class="b_type01" onclick="fn_modify(<c:out value='${subjectVO.sbjtSeq }'/>); return false;">강의 주제 수정</a>
							<c:if test="${subjectVO.hmwkCnt eq 0 }">
								<a href="#" class="b_type02" onclick="fn_delete(<c:out value='${subjectVO.sbjtSeq}'/>); return false;">삭제</a>
							</c:if>
							<a href="#" class="b_type03" onclick="fn_list_subject(); return false;">강의 주제 목록</a>
						</div>
					</div>
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
						<form:hidden path="pageIndex2" />
					</div>
				</div>
				<div class="tbl_top_side">
					<div class="side_c">
						<ul>
							<li>
								<form:select path="searchType" class="se_base w100">
									<form:option value="">전체</form:option>
									<form:option value="1">제출</form:option>
									<form:option value="2">첨삭완료</form:option>
									<form:option value="3">첨삭확인완료</form:option>
									<form:option value="4">첨삭진행중</form:option>
								</form:select>
							</li>
							<li>
								<form:select path="searchCondition2" class="se_base w100">
									<form:option value="name">작성자</form:option>
								</form:select>
							</li>
							<li>
								<form:input path="searchWord2" class="in_base w150" />
							</li>
							<li>
								<a href="#" class="btn_type05 input_btn" onclick="fn_list(1); return false;">검색</a>
							</li>
						</ul>
					</div>
					<div class="total">
						게시물 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건
					</div>
				</div>
			<!-- //content -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
</div>

<input type="hidden" id="message" value="${message}" />

<!-- 목록페이지 조건 -->
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>