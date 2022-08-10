<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">
	$(function(){
		//enter
		$("#searchWord").on("keydown", function(e) {
			if (e.keyCode == 13) {
				fn_list(1);
				return false;
			}
		});
	});
	
	// 목록
	function fn_list(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventCancelList.do'/>").submit();
	}
	
	// 조회
	function fn_modify(eveSeq){
		$("#eveSeq").val(eveSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventModify.do'/>").submit();
	}

	// 삭제
	function fn_delete(eveSeq){
		if(confirm("삭제하시겠습니까?")){
			$("#eveSeq").val(eveSeq);
			$("#eveRefundYn").val("Y");
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventDelete.do'/>").submit();
		}
	}
	
	// 행사비 입금여부 수정
	function fn_modify_depoYn(eveSeq, depoYn, refundYn){
		$("#eveSeq").val(eveSeq);
		$("#eveDepoYn").val(depoYn);
		$("#eveRefundYn").val(refundYn);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventDepoYnUpdate.do'/>").submit();
	}
	
	// 행사비 환불여부 수정
	function fn_modify_refundYn(eveSeq, refundYn){
		$("#eveSeq").val(eveSeq);
		$("#eveRefundYn").val(refundYn);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventRefundYnUpdate.do'/>").submit();
	}
	
	// 엑셀 다운로드
	function fn_downloadExcel() {
		$("#eveRefundYn").val("Y");
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/event/admEventExcelDownload.do'/>").submit();
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
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
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<!--// lnb -->
			<!-- content -->
			<div class="content" id="content">
				<!-- 타이틀 영역 -->
				<c:import url="/EgovPageLink.do?link=adm/inc/incPageTitle">
					<c:param name="dept1" value="진로&교양과정"/>
					<c:param name="dept2" value="행사참가취소"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<div class="tbl_top_side">
						<div class="side_r">
							<ul>
								<li>
									<form:select path="searchCondition2" class="se_base w100">
										<form:option value="">환불여부</form:option>
										<form:option value="Y">환불</form:option>
										<form:option value="N">미환불</form:option>
									</form:select>
								</li>
								<li>
									<form:select path="menuType" class="se_base w100">
										<form:option value="">행사회차</form:option>
										<c:forEach items="${eveNumList }" var="eveNum">
											<form:option value="${eveNum }"><c:out value="${eveNum }"/>회차</form:option>
										</c:forEach>
									</form:select>
								</li>
								<li>
									<form:select path="searchCondition1" class="se_base w100">
										<form:option value="name">이름</form:option>
										<form:option value="tel">연락처</form:option>
										<form:option value="email">이메일</form:option>
									</form:select>
								</li>
								<li>
									<form:input path="searchWord" class="in_base w150"/>
								</li>
								<li>
									<a href="#" onclick="fn_list(1); return false;" class="btn_type05 input_btn">검색</a>
									<a href="#" onclick="fn_downloadExcel(); return false;" class="btn_type05 input_btn">엑셀 다운로드</a>
									<input type="hidden" id="resultList" value="<c:out value='${resultList }'/>"/>
								</li>
							</ul>
						</div>
					</div>
					<table class="list_tbl_03" summary="행사참가취소 목록">
						<caption>행사참가취소</caption>
						<colgroup>
							<col style="width:5%" />
							<col style="width:5%" />
							<col style="width:7%" />
							<col style="width:13%" />
							<col style="width:*" />
							<col style="width:5%" />
							<col style="width:5%" />
							<col style="width:5%" />
							<col style="width:5%" />
							<col style="width:10%" />
							<col style="width:14%" />
							<col style="width:5%" />
						</colgroup>
						<thead>
							<tr class="first">
								<th scope="col">번호</th>
								<th scope="col">행사회차</th>
								<th scope="col">이름</th>
								<th scope="col">연락처</th>
								<th scope="col">이메일</th>
								<th scope="col" colspan="2">입금여부</th>
								<th scope="col" colspan="2">환불여부</th>
								<th scope="col">신청일</th>
								<th scope="col">취소일시</th>
								<th scope="col">비고</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td><c:out value="${result.eveNum }"/></td>
									<td><a href="#" onclick="fn_modify('<c:out value="${result.eveSeq }"/>'); return false;"><c:out value="${result.eveName }"/></a> </td>
									<td><c:out value="${result.eveTel }"/></td>
									<td><c:out value="${result.eveEmail }"/></td>
									<c:if test="${result.eveDepoYn == 'Y' }">
									<td class="bg_yes" >YES</td>
									<td onclick="fn_modify_depoYn('<c:out value="${result.eveSeq}"/>' ,'N', '<c:out value="${result.eveRefundYn}"/>'); return false;" style="cursor: pointer;">NO</td>
									</c:if>
									<c:if test="${result.eveDepoYn == 'N' }">
									<td onclick="fn_modify_depoYn('<c:out value="${result.eveSeq}"/>' ,'Y', '<c:out value="${result.eveRefundYn}"/>'); return false;" style="cursor: pointer;">YES</td>
									<td class="bg_no" >NO</td>
									</c:if>
									<c:if test="${result.eveRefundYn == 'Y' }">
									<td class="bg_yes" >YES</td>
									<td onclick="fn_modify_refundYn('<c:out value="${result.eveSeq}"/>' ,'N'); return false;" style="cursor: pointer;">NO</td>
									</c:if>
									<c:if test="${result.eveRefundYn == 'N' }">
									<td onclick="fn_modify_refundYn('<c:out value="${result.eveSeq}"/>' ,'Y'); return false;" style="cursor: pointer;">YES</td>
									<td class="bg_no" >NO</td>
									</c:if>
									<td><c:out value="${result.eveRegDate }"/></td>
									<td><c:out value="${result.eveCancelDate }"/></td>
									<td onclick="fn_delete('<c:out value="${result.eveSeq }"/>'); return false;" style="cursor: pointer;">삭제</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="btm_area">
						<!-- 페이징 -->
						<div class="pagenate">
							<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
							<form:hidden path="pageIndex"/>
						</div>
						<div align="right">
							<a href="${pageContext.request.contextPath }/usr/event/eventModify.do">https://edubank.hansung.ac.kr/usr/event/eventModify.do</a>
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
<input type="hidden" id="eveSeq" name="eveSeq"/>
<input type="hidden" id="eveDepoYn" name="eveDepoYn"/>
<input type="hidden" id="eveRefundYn" name="eveRefundYn"/>

<form:hidden path="searchCondition3"/>

<input type="hidden" id="message" name="message" value="${message}" />
</form:form>
</body>
</html>