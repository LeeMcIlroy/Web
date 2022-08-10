<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>한성대학교 디자인아트 교육원</title>
<!-- header -->
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<!--// header -->
</head>
<body>
<div class="wrap">
	<!-- topnav -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!-- topnav -->
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
			<div class="title_area">
				<h3>전공소식관리</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 사이트관리 &gt; 전공소식관리 &nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
			<div class="cont_box">
			<!-- content -->
			<form:form commandName="searchVO" id="frm" name="frm">
				<input type="hidden" id="mbSeq" name="mbSeq"/>
				<input type="hidden" id="mbSort" name="mbSort"/>
				<div class="tbl_top_side">
					<div class="side_r">
						<ul>
							<li>
								<form:select path="searchType" class="se_base w100" onchange="fn_change(); return false;">
									<form:option value="">구분</form:option>
									<c:forEach var="list" items="${deptList }">
										<form:option value="${list.mCode }"><c:out value="${list.dept }"/></form:option>
									</c:forEach>
								</form:select>
							</li>
							<li>
								<select class="se_base w100">
									<option>제목</option>
								</select>
							</li>
							<li>
								<form:input path="searchWord" class="in_base w150" />
							</li>
							<li>
								<a href="#" class="btn_type05 input_btn" onclick="fn_list('1'); return false;">검색</a>
							</li>
						</ul>
					</div>
				</div>
				<table class="list_tbl_03" summary="전공소식 목록">
					<caption>전공소식관리</caption>
					<colgroup>
						<col style="width:5%" />
						<col style="width:11%" />
						<col style="width:*%" />
						<col style="width:4%" />
						<col style="width:4%" />
						<col style="width:4%" />
						<col style="width:4%" />
						<col style="width:4%" />
						<col style="width:4%" />
						<col style="width:4%" />
						<col style="width:4%" />
						<col style="width:4%" />
						<col style="width:10%" />
						<col style="width:5%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">구분</th>
							<th scope="col">제목</th>
							<th scope="col" colspan="9">메인 위치</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${sortList }" var="result" varStatus="status">
						<tr>
							<td>-</td>
							<td><c:out value="${result.dept }"/></td>
							<td onclick="fn_view(<c:out value="${result.mbSeq}"/>); return false;" style="cursor: pointer;"><c:out value="${result.mbTitle }" escapeXml="false"/></td>
							<c:if test="${result.mbSort != 0}">
								<td><a href="#" onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'0'); return false;">NO</a></td>
							</c:if>
							<c:if test="${result.mbSort == 0}">
								<td class="bg_yes">NO</td>
							</c:if>
							<c:if test="${result.mbSort != 1}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'1'); return false;">1</a></td>
							</c:if>
							<c:if test="${result.mbSort == 1}">
								<td class="bg_yes">1</td>
							</c:if>
							<c:if test="${result.mbSort != 2}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'2'); return false;">2</a></td>
							</c:if>
							<c:if test="${result.mbSort == 2}">
								<td class="bg_yes">2</td>
							</c:if>
							<c:if test="${result.mbSort != 3}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'3'); return false;">3</a></td>
							</c:if>
							<c:if test="${result.mbSort == 3}">
								<td class="bg_yes">3</td>
							</c:if>
							<c:if test="${result.mbSort != 4}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'4'); return false;">4</a></td>
							</c:if>
							<c:if test="${result.mbSort == 4}">
								<td class="bg_yes">4</td>
							</c:if>
							<c:if test="${result.mbSort != 5}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'5'); return false;">5</a></td>
							</c:if>
							<c:if test="${result.mbSort == 5}">
								<td class="bg_yes">5</td>
							</c:if>
							<c:if test="${result.mbSort != 6}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'6'); return false;">6</a></td>
							</c:if>
							<c:if test="${result.mbSort == 6}">
								<td class="bg_yes">6</td>
							</c:if>
							<c:if test="${result.mbSort != 7}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'7'); return false;">7</a></td>
							</c:if>
							<c:if test="${result.mbSort == 7}">
								<td class="bg_yes">7</td>
							</c:if>
							<c:if test="${result.mbSort != 8}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'8'); return false;">8</a></td>
							</c:if>
							<c:if test="${result.mbSort == 8}">
								<td class="bg_yes">8</td>
							</c:if>
							<td><c:out value="${result.mbRegDate }"/></td>
							<td><c:out value="${result.mbCount }"/></td>
						</tr>
						</c:forEach>
						<c:forEach items="${resultList }" var="result" varStatus="status">
						<tr>
							<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
							<td><c:out value="${result.dept }"/></td>
							<td onclick="fn_view(<c:out value="${result.mbSeq}"/>); return false;" style="cursor: pointer;"><c:out value="${result.mbTitle }" escapeXml="false"/></td>
							<c:if test="${result.mbSort != 0}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'0'); return false;">NO</a></td>
							</c:if>
							<c:if test="${result.mbSort == 0}">
								<td class="bg_no">NO</td>
							</c:if>
							<c:if test="${result.mbSort != 1}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'1'); return false;">1</a></td>
							</c:if>
							<c:if test="${result.mbSort == 1}">
								<td class="bg_yes">1</td>
							</c:if>
							<c:if test="${result.mbSort != 2}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'2'); return false;">2</a></td>
							</c:if>
							<c:if test="${result.mbSort == 2}">
								<td class="bg_yes">2</td>
							</c:if>
							<c:if test="${result.mbSort != 3}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'3'); return false;">3</a></td>
							</c:if>
							<c:if test="${result.mbSort == 3}">
								<td class="bg_yes">3</td>
							</c:if>
							<c:if test="${result.mbSort != 4}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'4'); return false;">4</a></td>
							</c:if>
							<c:if test="${result.mbSort == 4}">
								<td class="bg_yes">4</td>
							</c:if>
							<c:if test="${result.mbSort != 5}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'5'); return false;">5</a></td>
							</c:if>
							<c:if test="${result.mbSort == 5}">
								<td class="bg_yes">5</td>
							</c:if>
							<c:if test="${result.mbSort != 6}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'6'); return false;">6</a></td>
							</c:if>
							<c:if test="${result.mbSort == 6}">
								<td class="bg_yes">6</td>
							</c:if>
							<c:if test="${result.mbSort != 7}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'7'); return false;">7</a></td>
							</c:if>
							<c:if test="${result.mbSort == 7}">
								<td class="bg_yes">7</td>
							</c:if>
							<c:if test="${result.mbSort != 8}">
								<td><a href="#"  onclick="fn_modify_sort('<c:out value="${result.mbSeq}"/>' ,'8'); return false;">8</a></td>
							</c:if>
							<c:if test="${result.mbSort == 8}">
								<td class="bg_yes">8</td>
							</c:if>
							<td><c:out value="${result.mbRegDate }"/></td>
							<td><c:out value="${result.mbCount }"/></td>
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
			</form:form>
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
<script type="text/javascript">
	
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/news/admNewsList.do'/>").submit();
	}
	
	// 조회
	function fn_view(mbSeq){
		$("#mbSeq").val(mbSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/news/admNewsView.do'/>").submit();
	}

	// 전공소식 정렬 수정
	function fn_modify_sort(mbSeq, mbSort){
		$.ajax({
			url: "/qxerpynm/siteMng/news/admNewsSortUpdate.do"
			, type: "get"
			, data: { 
				"mbSeq" : mbSeq
				, "mbSort" : mbSort
			}
			, dataType:"json"
			, success: function(data){
				//alert(data);
				location.reload();
			}
			, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
</script>
</body>
</html>