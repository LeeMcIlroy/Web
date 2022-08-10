<!-- 200408추가 -->
<!-- 200413수정 --><!-- 200416수정 --><!-- 200417수정 --><!-- 200420수정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	// 목록
	function fn_list(pageNo) {
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/breakingNews/brNewsList.do'/>").submit();
	}

		/* $(document).ready(function() {
				$.ajax({
					url : "/usr/jobs/worknet/breakingNews/AjaxbrNewsList.do"
					,type : "post"
					,data : JSON
					,dataType : 'json'
					,contentType: "application/json; charset=UTF-8"
					,success : function(data) {
						var resultList = data.resultList;
						var pList = JSON.parse(resultList);
						var rsList = pList.dhsOpenEmpInfoList;
						var tot = pList.dhsOpenEmpInfoList.total;
						tot += '<input type="hidden" id="dis" value="'+rsList.display+'" />';
						tot += '<input type="hidden" id="tot" value="'+pList.dhsOpenEmpInfoList.total+'" />';
						$("#total").prepend(tot);
						
						console.log(rsList)
						
						var html = '';
						
						for (var i = 0; i < rsList.display; i++) {
							var list = rsList.dhsOpenEmpInfo[i];
							html += '<ul>';
							html += '	<li>'+list.empBusiNm+'</li>';
							html += '	<li><a href="javascript:fn_select(&#39;'+list.empSeqno+'&#39;,'+i+');" id="title'+i+'">'+list.empWantedTitle+'</a><br/>';
							html += 	list.empWantedTypeNm+'</li>';
							html += '	<li style="text-align : center;">회사내규에 따름</li>';
							html += '	<li>'+list.empWantedEndt+'마감<br/>';
							html += 	list.empWantedStdt+'등록</li>';
							html += '	<input type="hidden" id="empSeqno'+i+'" value="'+list.empSeqno+'">';
							html += '</ul>';
						}
						$(".br_tbl_td").append(html);
						
// 						console.log(rsList.dhsOpenEmpInfo[0].maxSal)
					}
				});
// 				return false;
		}) */
		
// 		$(document).on("click", "#title1", function(){
// 			var empSeqno = $("#empSeqno1").val();
// 			fn_select(empSeqno)
// 		});

		
		
	// 조회
	function fn_select(empSeqno,i){
		var empSeqno = $("#empSeqno"+i).val();
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/breakingNews/brNewsView.do'/>?empSeqno="+empSeqno).submit();
	}
	
	
</script>
<body>
	<form:form commandName="searchVO" id="frm" name="frm">
		<!-- skip_navigation -->
		<dl id="skip_nav">
			<dt>바로가기 메뉴</dt>
			<dd>
				<a href="#content">본문 바로가기</a>
			</dd>
			<dd>
				<a href="#top_menu">메뉴 바로가기</a>
			</dd>
			<dd>
				<a href="#footer">페이지 하단 바로가기</a>
			</dd>
		</dl>
		<!-- //skip_navigation -->
		<div class="content">
			<!-- header area -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
			<!-- //header area -->
			<div class="main_content" id="content">
				<div class="width_box">
					<!-- left menu area-->
					<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
					<!-- //left menu area-->
					<div class="sub_content">
						<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">
							<c:param name="dept1" value="취업센터" />
							<c:param name="dept2" value="채용정보" />
						</c:import>
						<%-- <div class="top_tab type_li2">
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/recruitment/recruList.do'/>">채용정보</a></li>
								<li class="active"><a href="<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/breakingNews/brNewsList.do'/>">공채속보</a></li>
							</ul>
						</div> --%>
				<!-- 검색  -->
					<div class="list_sh">
						<ul>
							<li>
								<form:select path="searchCondition1">
									<form:option value="">채용공고명</form:option>
								</form:select>
							</li>
							<li>
								<form:input path="searchWord"/>
							</li>
							<li>
								<a href="#" onclick="fn_list(1); return false">
									<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_sh.png'/>" alt="찾기" />
								</a>
							</li>
						</ul>
					<div id="total">${totRec }건이 검색 되었습니다.</div>
					</div>
 				<!--//검색 -->
						<div class="img_list_type">
							<div class="transform_table consult_type">
								<ul class="tbl_th">
									<li style="width: 20%;">회사명</li>
									<li style="width: 38%;">채용공고명 / 지원자격</li>
									<li style="width: 22%;">근무조건</li>
									<li style="width: 20%;">등록/마감일</li>
								</ul>
								<div class="br_tbl_td">
									<!-- 0422수정 -->
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<c:set var="i" value="${status.index }"/>
								 	<input type="hidden" id="empSeqno${i }" value="<c:out value="${result.empSeqno}"/>" />
									<ul>
										<li><c:out value="${result.empBusiNm}"/></li>
									 	<li><a href="" onclick="fn_select('<c:out value="${result.empSeqno}"/>',${i }); return false;"><c:out value="${result.empWantedTitle}"/></a><br/>
										 	<c:out value="${result.empWantedTypeNm}"/></li>
									 	<li>회사내규에 따름</li>
									 	<li><fmt:parseDate value="${result.empWantedEndt}" var="empWantedEndate" pattern="yyyyMMdd"/>
											<fmt:formatDate value="${empWantedEndate}" pattern="yy/MM/dd"/> 마감<br/>
											<fmt:parseDate value="${result.empWantedStdt}" var="empWantedStdate" pattern="yyyyMMdd"/>
											<fmt:formatDate value="${empWantedStdate}" pattern="yy/MM/dd"/> 등록</li>
									 </ul>
								 </c:forEach>
								</div>
							</div>
						</div>
						<!-- paging -->
						<div class="pager">
							<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
						<!-- //paging -->
						<!-- rolling banner -->

						<!-- //rolling banner -->
					</div>
				</div>
			</div>
			<!-- footer -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
			<!-- //footer -->
		</div>
		<input type="hidden" id="message" value="${message}" />
	</form:form>
</body>
</html>