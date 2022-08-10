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
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/enter/brodata/admBroDataList.do'/>").submit();
	}

	// 수정화면
	function fn_modify(bdSeq){
		$("#bdSeq").val(bdSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/enter/brodata/admBroDataModify.do'/>").submit();
	}

	// 삭제
	function fn_delete(bdSeq){
		if(confirm("정말 삭제하시겠습니까?\n삭제한 데이터는 복구할 수 없습니다.")){
			$("#bdSeq").val(bdSeq);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/enter/brodata/admBroDataDelete.do'/>").submit();
		}
	}

	
	// 파일 다운로드
	function fn_filedownload(bdSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+bdSeq+"&type="+type;
	}

</script>
<body>
<form id="frm" name="frm">
<input type="hidden" id="bdSeq" name="bdSeq"/>
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
					<c:param name="dept2" value="작품자료실"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<!-- table -->
					<table class="view_tbl_03 mb30 mt30" summary="작품자료실">
						<caption>작품자료실</caption>
						<colgroup>
							<col width="13%" />
							<col width="20%" />
							<col width="13%" />
							<col width="20%" />
						</colgroup>
						<tbody>
							<tr class="first">
								<th scope="row" colspan="6"><c:out value="${resultVO.bdName }" escapeXml="false"/></th>
							</tr>
							<tr>
								<th scope="row">작성자</th>
								<td><c:out value="${resultVO.regName }"/></td>
								<th scope="row">작성일</th>
								<td><c:out value="${resultVO.regDate }"/></td>
							</tr>
							<tr>
								<th scope="row">첨부파일</th>
								<td colspan="3">
									<a href="#" onclick="fn_filedownload(<c:out value='${resultVO.bdSeq }'/>, 'BRODATA'); return false;">
										<c:out value="${resultVO.bdOriginFileName }"/>
									</a>
								</td>
							</tr>
							<tr>
								<th scope="row">브로셔공유URL</th>
								<td colspan="3"><c:out value="${resultVO.bdUrl }"/></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" onclick="fn_modify(<c:out value='${resultVO.bdSeq }'/>); return false;" class="b_type01">수정</a>
							<a href="#" onclick="fn_delete(<c:out value='${resultVO.bdSeq }'/>); return false;" class="b_type02">삭제</a>
							<a href="#" onclick="fn_list(); return false;" class="b_type03">목록</a>
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
<!-- 목록 검색 조건 -->
<input type="hidden" id="menuType" name="menuType" value="${searchVO.menuType }"/>
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<!--// 목록 검색 조건 -->
<input type="hidden" id="message" name="message" value="${message }"/>
</form>
</body>
</html>