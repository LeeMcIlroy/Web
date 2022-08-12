<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/general/exper/admExperList.do'/>").submit();
	}

	function fn_delete(exaSeq){
		if(confirm("삭제하시겠습니까?")){
			$("#exaSeq").val(exaSeq);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/general/exper/admExperDelete.do'/>").submit();
		}
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="exaSeq" name="exaSeq"/>
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
					<c:param name="dept2" value="진로체험신청"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<div class="tbl_top_side">
						<div class="side_r">
							<ul>
								<li>
									<form:select path="searchCondition1" class="se_base w100">
										<form:option value="name">신청자명</form:option>
										<form:option value="school">학교명</form:option>
									</form:select>
								</li>
								<li>
									<form:input path="searchWord" class="in_base w150"/>
								</li>
								<li>
									<a href="#" onclick="fn_list(1); return false;" class="btn_type05 input_btn">검색</a>
								</li>
							</ul>
						</div>
					</div>
					<table class="list_tbl_03" summary="진로체험신청 목록">
						<caption>진로체험신청</caption>
						<colgroup>
							<col style="width:" />
							<col style="width:" />
							<col style="width:" />
							<col style="width:" />
							<col style="width:" />
							<col style="width:" />
							<col style="width:" />
							<col style="width:" />
						</colgroup>
						<thead>
							<tr class="first">
								<th scope="col">번호</th>
								<th scope="col">신청자명</th>
								<th scope="col">학교명</th>
								<th scope="col">연락처(이메일)</th>
								<th scope="col">체험과정</th>
								<th scope="col">신청일자</th>
								<th scope="col">등록일</th>
								<th scope="col">비고</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td><c:out value="${result.exaAplyName }"/></td>
									<td><c:out value="${result.exaSchName }"/></td>
									<td>
										<c:out value="${result.exaTel }"/>
										<c:if test="${!empty result.exaEmail}"><br />(<c:out value="${result.exaEmail }"/>)</c:if>
									</td>
									<td class="ta_left"><c:out value="${result.arrExcCd }" escapeXml="false"/></td>
									<td>
										<c:out value="${result.exaStDate }"/>&nbsp;~&nbsp;<c:out value="${result.exaEdDate }"/>
									</td>
									<td>
										<fmt:formatDate value="${result.regDate }" type="both" pattern="yyyy-MM-dd"/>
									</td>
									<td>
										<a href="#" onclick="fn_delete(<c:out value='${result.exaSeq }'/>); return false;" class="b_type03">삭제</a>
									</td>
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
<input type="hidden" id="message" name="message" value="${message}" />
</form:form>
</body>
</html>