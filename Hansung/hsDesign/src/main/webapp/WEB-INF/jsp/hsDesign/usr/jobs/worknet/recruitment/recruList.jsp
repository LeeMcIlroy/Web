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
		$("#frm").attr("method", "post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/recruitment/recruList.do'/>").submit();
	}

		/* $(document).ready(function() {
				$.ajax({
					url : "/usr/jobs/worknet/recruitment/AjaxRecruList.do"
					,type : "post"
					,data : JSON
					,dataType : 'json'
					,contentType: "application/json; charset=UTF-8"
					,success : function(data) {
						var resultList = data.resultList;
						var pList = JSON.parse(resultList);
						var rsList = pList.wantedRoot;

						var tot = pList.wantedRoot.total;
						tot += '<input type="hidden" id="dis" value="'+rsList.display+'" />';
						$("#total").prepend(tot);
						
						var html = '';
						
						for (var i = 0; i < rsList.display; i++) {
							if(rsList.wanted[i].empTpCd == 10 || rsList.wanted[i].empTpCd == 11){
								empTpCd= "정규직";
							}else if(rsList.wanted[i].empTpCd == 20 || rsList.wanted[i].empTpCd == 21){
								empTpCd= "비정규직";
							}
							html += '<ul>';
							html += '	<li>'+rsList.wanted[i].company+'</li>';
							html += '	<li><a href="javascript:fn_select(&#39;'+rsList.wanted[i].wantedAuthNo+'&#39;,'+i+');" id="title'+i+'">'+rsList.wanted[i].title+'</a><br/>';
							html += 	rsList.wanted[i].career+' | '+rsList.wanted[i].minEdubg+' | '+rsList.wanted[i].region+'</li>';
							html += '	<li>'+rsList.wanted[i].salTpNm+' : '+rsList.wanted[i].sal+'<br/>';
							html += '	'+empTpCd+' | '+rsList.wanted[i].holidayTpNm+'</li>';
							html += '	<li>'+rsList.wanted[i].closeDt+'마감<br/>';
							html += 	rsList.wanted[i].regDt+'등록</li>';
							html += '	<input type="hidden" id="wantedAuthNo'+i+'" value="'+rsList.wanted[i].wantedAuthNo+'">';
							html += '</ul>';
						}
						$(".rec_tbl_td").append(html);
						
// 						console.log(rsList.wanted[0].maxSal)
					}
				});
// 				return false;
		}) */
		
// 		$(document).on("click", "#title1", function(){
// 			var wantedAuthNo = $("#wantedAuthNo1").val();
// 			fn_select(wantedAuthNo)
// 		});

		
		
	// 조회
	 function fn_select(giNo,i){
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/recruitment/recruView.do'/>?giNo="+giNo).submit();
	} 
/* 	function fn_select(wantedAuthNo,i){
		//var wantedAuthNo =$('#wantedAuthNo').val()
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/recruitment/recruView.do'/>?wantedAuthNo="+wantedAuthNo).submit();
	} */
	function fn_major(type){
		$("#searchCondition2").val(type);
		fn_list(1);
	}
	
	
</script>
<body>
	<form:form commandName="searchVO" id="frm" name="frm">
		<form:hidden path="searchCondition2"/>
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
						<div class="top_tab type_li7">
							<ul>
								<li <c:if test="${searchVO.searchCondition2 eq '실내디자인' }">class="active"</c:if> ><a href="#" onclick="fn_major('실내디자인');">실내디자인</a></li>
								<li <c:if test="${searchVO.searchCondition2 eq '시각디자인' }">class="active"</c:if> ><a href="#" onclick="fn_major('시각디자인');">시각디자인</a></li>
								<li <c:if test="${searchVO.searchCondition2 eq '산업디자인' }">class="active"</c:if> ><a href="#" onclick="fn_major('산업디자인');">산업디자인</a></li>
								<li <c:if test="${searchVO.searchCondition2 eq '디지털아트(디자인)' }">class="active"</c:if> ><a href="#" onclick="fn_major('디지털아트(디자인)');">디지털아트(디자인)</a></li>
								<li <c:if test="${searchVO.searchCondition2 eq '디지털아트(게임)' }">class="active"</c:if> ><a href="#" onclick="fn_major('디지털아트(게임)');">디지털아트(게임)</a></li>
								<li <c:if test="${searchVO.searchCondition2 eq '패션디자인' }">class="active"</c:if> ><a href="#" onclick="fn_major('패션디자인');">패션디자인</a></li>
								<li <c:if test="${searchVO.searchCondition2 eq '미용학' }">class="active"</c:if> ><a href="#" onclick="fn_major('미용학');">미용학</a></li>
							</ul>
						</div>
						
				<!-- 검색  -->
					<div class="list_sh">
						<ul>
							<li>
								<form:select path="searchCondition1">
									<form:option value="">키워드</form:option>
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
					<div id="total"><c:out value="${totRec}"/> 건이 검색 되었습니다.</div>
					</div>
 				<!--//검색 -->
						<div class="img_list_type">
							<div class="transform_table consult_type">
								<ul class="tbl_th">
									<li style="width: 25%;">회사명</li>
									<li style="width: 38%;">채용공고명 / 지원자격</li>
									<li style="width: 22%;">근무조건</li>
									<li style="width: 15%;">등록/마감일</li>
								</ul>
								<div class="rec_tbl_td">
									<!-- 0420수정 --><!-- 테이블 추가되는 부분 -->
									<c:forEach items="${resultList }" var="result" varStatus="status">
								
										<c:set var="i" value="${status.index }"/>
										<ul>
											<li style="text-align: left;"><c:out value="${result.cName }"/></li>
											<li><a href="<c:out value="${result.jkUrl }"/>" target="_blank"><c:out value="${result.giSubject }"/></a><br/>
												
												<c:choose>
													<c:when test="${result.giCareer == '1'}">신입</c:when>
													<c:when test="${result.giCareer == '2'}">경력</c:when>
													<c:when test="${result.giCareer == '3'}">신입/경력</c:when>
													<c:when test="${result.giCareer == '4'}">무관</c:when>											
												</c:choose>
												|
												<c:choose>
													<c:when test="${result.giEduCutline == '0'}">무관</c:when>
													<c:when test="${result.giEduCutline == '3'}">고등학교졸업</c:when>
													<c:when test="${result.giEduCutline == '4'}">대졸(2,3년)</c:when>
													<c:when test="${result.giEduCutline == '5'}">대졸(4년제)</c:when>
													<c:when test="${result.giEduCutline == '6'}">석사</c:when>
													<c:when test="${result.giEduCutline == '7'}">박사</c:when>
												</c:choose>
											</li>
											<li>
												<c:choose>
													<c:when test="${result.giPay == '0'}">회사 내규에 따름</c:when>
													<c:when test="${result.giPay == '1'}">연봉 : 
														<c:if test="${fn:length(result.giPayTerm) > 6 }"><c:out value="${fn:replace(result.giPayTerm,',','~')}"/> (만원)</c:if>
														<c:if test="${fn:length(result.giPayTerm) == 6 }"><c:out value="${fn:substring(result.giPayTerm,0,4)}"/> (만원)</c:if>
														
													</c:when>
													
													<c:when test="${result.giPay == '2'}">월급 : 
														<c:if test="${fn:length(result.giPayTerm) > 5 }"><c:out value="${fn:replace(result.giPayTerm,',','~')}"/> (만원)</c:if>
														<c:if test="${fn:length(result.giPayTerm) == 5}"><c:out value="${fn:substring(result.giPayTerm,0,3)}"/> (만원)</c:if>
													</c:when>
													<c:when test="${result.giPay == '3'}">주급 : <c:out value="${fn:replace(result.giPayTerm,',','~')}"/> (원) </c:when>
													<c:when test="${result.giPay == '4'}">일급 : <c:out value="${fn:replace(result.giPayTerm,',','~')}"/> (원) </c:when>
													<c:when test="${result.giPay == '5'}">시급 : <c:out value="${fn:replace(result.giPayTerm,',','~')}"/> (원) </c:when>
													<c:when test="${result.giPay == '6'}">건별 : <c:out value="${fn:replace(result.giPayTerm,',','~')}"/> (원) </c:when>
													
												</c:choose> 
											    </br>
											    <c:choose>
													<c:when test="${result.giJobType == '1'}">정규직</c:when>
													<c:when test="${result.giJobType == '1,2'}">정규직,계약직</c:when>
													
													<c:when test="${result.giJobType == '2'}">계약직</c:when>
													<c:when test="${result.giJobType == '3'}">인턴직</c:when>
													<c:when test="${result.giJobType == '4'}">파견직</c:when>
													<c:when test="${result.giJobType == '5'}">도급</c:when>
													<c:when test="${result.giJobType == '6'}">프리랜서</c:when>
													<c:when test="${result.giJobType == '7'}">아르바이트</c:when>
													<c:when test="${result.giJobType == '8'}">연수생/교육생</c:when>
													<c:when test="${result.giJobType == '9'}">병역특례</c:when>
													<c:when test="${result.giJobType == '10'}">위촉직/개인사업자</c:when>
													
												</c:choose>
												 </li>
											<li>
													<c:out value="${fn:substring(result.giEndDate,0,4)}/${fn:substring(result.giEndDate,4,6)}/${fn:substring(result.giEndDate,6,8) }"/> 마감</br>
													<c:out value="${fn:substring(result.giWDate,0,4)}/${fn:substring(result.giWDate,4,6)}/${fn:substring(result.giWDate,6,8) }"/> 등록
													
											
											</li>
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