<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>

	/* 목록으로 */
	function fn_goList(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/boardMng/cntst/admBoardMngPptAplyList.do'/>").submit();
	}
	
	/* 삭제 */
	function fn_delete(){
		if(confirm("게시글을 삭제하시겠습니까?")==true){
			$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/cntst/admBoardMngPptAplyDelete.do'/>").submit();			
		}else{
			return false;
		}
	}
</script>
<body>
<form id="frm">
<div class="wrap">
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="aplySeq" name="aplySeq" value="<c:out value='${cntstApplyVO.aplySeq }'/>" />
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
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
			<div class="title_area">
				<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="게시판관리"/>
		            <jsp:param name="dept2" value="신청자(PT대회)"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<div class="section_top_area mt30">
					<h4>신청정보</h4>
				</div>
				<table class="view_tbl_03 mb30 mt30" summary="신청자(PT대회)">
					<caption>신청자(PT대회)</caption>
					<colgroup>
						<col width="10%" />
						<col width="40%" />
						<col width="10%" />
						<col width="40%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">팀명</th>
							<td>
								 <c:out value="${cntstApplyVO.teamName }"/>
							</td>
							<th scope="row">주제번호</th>
							<td>
								 <c:out value="${cntstApplyVO.titleNum }"/> 	
							</td>
						</tr>
						<tr>
							<th scope="row">주제</th>
							<td>
								 <c:out value=""/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="section_top_area mt30">
					<h4>참여자1</h4>
				</div>
				<table class="view_tbl_03 mb30 mt30" summary="신청자(PT대회)">
					<caption>신청자(PT대회)</caption>
					<colgroup>
						<col width="10%" />
						<col width="40%" />
						<col width="10%" />
						<col width="40%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">성명</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyName }"/>
							</td>
							<th scope="row">학번</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyHakbun }"/> 	
							</td>
						</tr>
						<tr>
							<th scope="row">학적구분</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyRegistYn eq 'Y'?'재학':'휴학' }"/>
							</td>
							<th scope="row">휴대폰</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyMphone }"/> 	
							</td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td colspan="3">
								 <c:out value="${cntstApplyVO.aplyEmail }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">소속</th>
							<td colspan="3">
								 <c:out value="${cntstApplyVO.aplyDept }"/>&nbsp;<c:out value="${cntstApplyVO.aplyGrade }"/>학년
							</td>
						</tr>
						<tr>
							<th scope="row">신청일시</th>
							<td>
								 <c:out value="${cntstApplyVO.regDate }"/>
							</td>
							<th scope="row">신청번호</th>
							<td>
								 <c:out value=""/> 	
							</td>
						</tr>
					</tbody>
				</table>
				<div class="section_top_area mt30">
					<h4>참여자2</h4>
				</div>
				<table class="view_tbl_03 mb30 mt30" summary="신청자(PT대회)">
					<caption>신청자(PT대회)</caption>
					<colgroup>
						<col width="10%" />
						<col width="40%" />
						<col width="10%" />
						<col width="40%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">성명</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyName2 }"/>
							</td>
							<th scope="row">학번</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyHakbun2 }"/> 	
							</td>
						</tr>
						<tr>
							<th scope="row">학적구분</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyRegistYn2 eq 'Y'?'재학':'휴학' }"/>
							</td>
							<th scope="row">휴대폰</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyMphone2 }"/> 	
							</td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td colspan="3">
								 <c:out value="${cntstApplyVO.aplyEmail2 }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">소속</th>
							<td colspan="3">
								 <c:out value="${cntstApplyVO.aplyDept2 }"/>&nbsp;<c:out value="${cntstApplyVO.aplyGrade2 }"/>학년
							</td>
						</tr>
						<tr>
							<th scope="row">신청일시</th>
							<td>
								 <c:out value="${cntstApplyVO.regDate }"/>
							</td>
							<th scope="row">신청번호</th>
							<td>
								 <c:out value=""/> 	
							</td>
						</tr>
					</tbody>
				</table>
				<div class="section_top_area mt30">
					<h4>참여자3</h4>
				</div>
				<table class="view_tbl_03 mb30 mt30" summary="신청자(PT대회)">
					<caption>신청자(PT대회)</caption>
					<colgroup>
						<col width="10%" />
						<col width="40%" />
						<col width="10%" />
						<col width="40%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">성명</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyName3 }"/>
							</td>
							<th scope="row">학번</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyHakbun3 }"/> 	
							</td>
						</tr>
						<tr>
							<th scope="row">학적구분</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyRegistYn3 eq 'Y'?'재학':'휴학' }"/>
							</td>
							<th scope="row">휴대폰</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyMphone3 }"/> 	
							</td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td colspan="3">
								 <c:out value="${cntstApplyVO.aplyEmail3 }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">소속</th>
							<td colspan="3">
								 <c:out value="${cntstApplyVO.aplyDept3 }"/>&nbsp;<c:out value="${cntstApplyVO.aplyGrade3 }"/>학년
							</td>
						</tr>
						<tr>
							<th scope="row">신청일시</th>
							<td>
								 <c:out value="${cntstApplyVO.regDate }"/>
							</td>
							<th scope="row">신청번호</th>
							<td>
								 <c:out value=""/> 	
							</td>
						</tr>
					</tbody>
				</table>
				<div class="section_top_area mt30">
					<h4>개인정보 수집 및 이용 동의</h4>
				</div>
				<div class="g_box">
					<p class="mb20 ml10 tx_l">
						본인은 다음의 목적과 관련하여 발표 영상 촬영 및 이용에 동의합니다.<br/><br/>
						1. 이용 항목 및 목적<br/><br/>
						1) 수집·이용 정보 : 한성인 프레젠테이션 대회 발표 영상<br/><br/>
						2) 목적 : ① 교육 및 연구 자료로 활용<br/><br/>
						② 우수 발표 사례로 라이팅 센터 홈페이지 게재<br/><br/> 
						(홈페이지에 가입한 교내 학생들에게 공개됨)<br/><br/>
						③ 수업 시간 자료로 활용할 수 있음<br/><br/>
						2. 정보의 보유 및 이용 기간<br/><br/>
						수집한 정보는 수집·이용에 관한 동의일로부터 일정기간 보존합니다. 단, 발표자가 정보 삭제를 요청할 경우 지체 없이 파기합니다.
					</p>
				</div>
				<table class="view_tbl_03 mb30 mt30" summary="신청자(글쓰기대회)">
					<caption>신청자(글쓰기대회)</caption>
					<colgroup>
						<col width="10%" />
						<col width="40%" />
						<col width="10%" />
						<col width="40%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">동의일시</th>
							<td>
								 <c:out value="${cntstApplyVO.regDate }"/>
							</td>
							<th scope="row">동의자</th>
							<td>
								 <c:out value="${cntstApplyVO.aplyName }"/> 	
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_delete(); return false;">삭제</a>
							<a href="#" class="b_type03" onclick="fn_goList(); return false;">목록</a>
						</div>
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
</form>
</body>
</html>