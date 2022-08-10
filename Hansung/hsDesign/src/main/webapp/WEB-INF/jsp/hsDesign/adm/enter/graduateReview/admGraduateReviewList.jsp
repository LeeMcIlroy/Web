<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	// 목록
	function fn_list(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do'/>").submit();
	}

	// 등록&수정화면
	function fn_modify(grSeq){
		$("#grSeq").val(grSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewModify.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="menuType" />
<input type="hidden" id="grSeq" name="grSeq"/>
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
					<c:param name="dept1" value="입학안내"/>
					<c:param name="dept2" value="대학원&타대학 편입"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<div class="mid_tab05 mt20">
						<ul>
							<li>
								<a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do?menuType=01'/>" <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if>>
									실내디자인
								</a>
							</li>
							<li>
								<a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do?menuType=02'/>" <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if>>
									시각디자인
								</a>
							</li>
							<li>
								<a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do?menuType=03'/>" <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if>>
									산업디자인
								</a>
							</li>
							<li>
								<a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do?menuType=04'/>" <c:if test="${searchVO.menuType eq '04' }">class="active"</c:if>>
									디지털아트
								</a>
							</li>
							<li>
								<a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do?menuType=05'/>" <c:if test="${searchVO.menuType eq '05' }">class="active"</c:if>>
									패션디자인
								</a>
							</li>
							<li>
								<a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do?menuType=06'/>" <c:if test="${searchVO.menuType eq '06' }">class="active"</c:if>>
									패션비즈니스
								</a>
							</li>
							<li>
								<a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do?menuType=07'/>" <c:if test="${searchVO.menuType eq '07' }">class="active"</c:if>>
									미용학
								</a>
							</li>
							<li>
								<a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do?menuType=08'/>" <c:if test="${searchVO.menuType eq '08' }">class="active"</c:if>>
									미용학(one-day)
								</a>
							</li>
						</ul>
					</div>
					<div class="tbl_top_side">
					</div>
					<table class="list_tbl_03" summary="대학원&타대학 편입">
						<caption>대학원&타대학 편입</caption>
						<colgroup>
							<col style="width:6%" />
							<col style="width:8%" />
							<col style="width:10%" />
							<col style="width:20%" />
							<col style="width:*" />
							<col style="width:13%" />
							<col style="width:8%" />
						</colgroup>
						<thead>
							<tr class="first">
								<th scope="col">번호</th>
								<th scope="col">이름</th>
								<th scope="col">대학원&편입대학</th>
								<th scope="col">등록학기</th>
								<th scope="col">활동</th>
								<th scope="col">결과(취업센터)</th>
								<th scope="col">상세보기</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td onclick="fn_modify(<c:out value='${result.grSeq }'/>); return false;" style="cursor: pointer;"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td onclick="fn_modify(<c:out value='${result.grSeq }'/>); return false;" style="cursor: pointer;"><c:out value="${result.grName }"/></td>
									<td onclick="fn_modify(<c:out value='${result.grSeq }'/>); return false;" style="cursor: pointer;"><c:out value="${result.grAftSchool }"/></td>
									<td onclick="fn_modify(<c:out value='${result.grSeq }'/>); return false;" style="cursor: pointer;">
										<c:out value="${result.grRegSemesterBegin }"/> ~ <c:out value="${result.grRegSemesterEnd }"/>
									</td>
									<td onclick="fn_modify(<c:out value='${result.grSeq }'/>); return false;" style="cursor: pointer;" class="ta_left"><c:out value="${result.grActivity }" escapeXml="false"/></td>
									<td onclick="fn_modify(<c:out value='${result.grSeq }'/>); return false;" style="cursor: pointer;"><c:out value="${result.grResult }"/></td>
									<td>
										<c:if test="${!empty result.grUrl }">
											<a href="<c:out value='${result.grUrl }' />" target="_blank" >편입&진학후기</a>
										</c:if>
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
						<div class="page_btn">
							<a href="#" onclick="fn_modify(); return false;" class="b_type03">글쓰기</a>
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