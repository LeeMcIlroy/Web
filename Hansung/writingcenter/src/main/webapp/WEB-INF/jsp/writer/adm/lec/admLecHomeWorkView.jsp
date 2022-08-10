<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	//조회
	function fn_select(hmwkSeq){
		$("#hmwkSeq").val(hmwkSeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecHomeWorkView.do'/>").submit();
	}

	//수정화면
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecHomeWorkModify.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(){
		if(confirm("한번 삭제한 데이터는 되돌릴 수 없습니다.\n정말로 삭제하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/lecHmwkCommentDelete.do'/>").submit();
		}
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/admLecHomeWorkList.do'/>").submit();
	}
	
	// 댓글 등록
	function fn_cmmt_insert(){
		if($("#cmtContent").val() == ''){
			alert("댓글 내용을 입력해주세요.");
			return false;
		}
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/lecHmwkCommentInsert.do'/>").submit();
	}
	
	// 댓글 삭제
	function fn_cmmt_delete(cmtSeq){
		if(confirm("댓글을 삭제하시겠습니까?")){
			$("#cmtSeq").val(cmtSeq);
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lec/lecHmwkCommentDelete.do'/>").submit();
		}
	}
	
	// 댓글 더보기
	function fn_cmmt_add_list(){
		$("#pageCmmtIndex").val(parseInt($("#pageCmmtIndex").val())+1);
		$.ajax({
			url: "<c:url value='/xabdmxgr/lec/lecHmwkCommentAddList.do'/>"
			, type: "post"
			, data: $("#frm").serialize()
			, dataType:"json"
			, success: function(data){
				cmmtList = data.cmmtList;
				console.log(cmmtList.length);
				
				if(cmmtList.length == 0){
					alert("마지막 댓글입니다."); 
					return false;
				}
				
				$.each(cmmtList, function(i, result){
					var tags = '';
					tags += '<div class="cmt_cont">';
					tags += '<span>'+result.regName+'</span>&nbsp;'+result.regDate;
					tags += '<div class="cmt_fuction">';
					tags += '<a href="#" class="btn_s_del" onclick="fn_cmmt_delete('+result.cmtSeq+'); return false;">삭제</a></div>';
					tags += '<p>'+fn_removeTag(result.cmtContent)+'</p>';
					tags += '</div>';
					
					$(".cmt_box").append(tags);
				});
				
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}

	// 파일 다운로드
	function fn_download(type, upSeq){
		location.href = "<c:url value='/cmmn/file/downloadFile.do?type="+type+"&fileId="+upSeq+"'/>";
	}
	
</script>
<body>
<form:form commandName="homeworkVO" id="frm" name="frm">
<form:hidden path="hmwkSeq" />
<input type="hidden" id="cmtSeq" name="cmtSeq"/>
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
				<table class="view_tbl_03 mt30 mb30" summary="C/L 분류 관리">
					<caption>C/L 분류</caption>
					<colgroup>
						<col width="14%" />
						<col width="20%" />
						<col width="13%" />
						<col width="20%" />
						<col width="13%" />
						<col width="20%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<c:choose>
								<c:when test="${!empty homeworkVO.hmwkNames && !empty homeworkVO.hmwkHakbuns && !empty homeworkVO.hmwkDepts }">
									<th scope="col">이름</th>
									<td><c:out value="${homeworkVO.hmwkNames }"/></td>
									<th scope="col">학과</th>
									<td><c:out value="${homeworkVO.hmwkDepts }"/></td>
									<th scope="col">학번</th>
									<td><c:out value="${homeworkVO.hmwkHakbuns }"/></td>
								</c:when>
								<c:otherwise>
									<th scope="col">이름</th>
									<td><c:out value="${homeworkVO.hmwkRegName }"/></td>
									<th scope="col">학과</th>
									<td><c:out value="${homeworkVO.hmwkRegDept }"/></td>
									<th scope="col">학번</th>
									<td><c:out value="${homeworkVO.hmwkRegId }"/></td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td colspan="5"><c:out value="${homeworkVO.hmwkContent }" escapeXml="false"/></td>
						</tr>
						<tr>
							<th scope="col">과제 파일</th>
							<td colspan="3">
								<c:forEach items="${hmwkFileList }" var="hmwkFile">
									<c:if test="${hmwkFile.upType eq 'BEFORE' }">
										<a href="#" onclick="fn_download('HOMEWORK', <c:out value='${hmwkFile.upSeq }'/>); return false;">
											<c:out value="${hmwkFile.upOriginFileName }"/>
										</a><br />
									</c:if>
								</c:forEach>
							</td>
							<th scope="col">제출일</th>
							<td><c:out value="${homeworkVO.hmwkRegDate }"/></td>
						</tr>
						<tr>
							<th scope="row">첨삭 지도 파일</th>
							<td colspan="3">
								<c:forEach items="${hmwkFileList }" var="hmwkFile">
									<c:if test="${hmwkFile.upType eq 'AFTER' }">
										<a href="#" onclick="fn_download('HOMEWORK', <c:out value='${hmwkFile.upSeq }'/>); return false;">
											<c:out value="${hmwkFile.upOriginFileName }"/>
										</a><br />
									</c:if>
								</c:forEach>
							</td>
							<th scope="col">첨삭일</th>
							<td><c:out value="${homeworkVO.hmwkUpdtDate }"/></td>
						</tr>
						<tr>
							<th scope="row">총평</th>
							<td colspan="5"><c:out value="${homeworkVO.hmwkContent2 }" escapeXml="false"/></td>
						</tr>
						<tr>
							<th scope="row">상태</th>
							<td colspan="5">
								<c:if test="${homeworkVO.hmwkStatus eq 1 }">
									<a href="#" class="ta_s_btn03">제출</a>
								</c:if>
								<c:if test="${homeworkVO.hmwkStatus eq 2 }">
									<a href="#" class="ta_s_btn01">첨삭완료</a>
								</c:if>
								<c:if test="${homeworkVO.hmwkStatus eq 3 }">
									<a href="#" class="ta_s_btn01">첨삭완료</a>
									<a href="#" class="ta_s_btn02">첨삭확인완료</a>
								</c:if>
								<c:if test="${homeworkVO.hmwkStatus eq 4 }">
									<a href="#" class="ta_s_btn01">첨삭진행중</a>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#" class="b_type02" onclick="fn_modify(); return false;">
							<c:if test="${empty homeworkVO.hmwkUpdtDate }">첨삭 등록</c:if>
							<c:if test="${!empty homeworkVO.hmwkUpdtDate }">첨삭 수정</c:if>
						</a>
						<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
						<c:if test="${!empty homeworkVO.prevHmwkSeq }">
							<a href="#" class="b_type04" onclick="fn_select(<c:out value='${homeworkVO.prevHmwkSeq }'/>); return false;">이전</a>
						</c:if>
						<c:if test="${!empty homeworkVO.nextHmwkSeq }">
							<a href="#" class="b_type04" onclick="fn_select(<c:out value='${homeworkVO.nextHmwkSeq }'/>); return false;">다음</a>
						</c:if>
					</div>
				</div>
				<div class="coment_write">
					<div class="cmt_int">
						<textarea cols="5" rows="5" id="cmtContent" name="cmtContent"></textarea>
						<a href="#" onclick="fn_cmmt_insert(); return false;">등록하기</a>
					</div>
					<div class="cmt_up">
						<div class="cmt_total">ㆍ총 댓글수 : <span><c:out value="${cmmtListCnt }"/></span>건</div>
						<div class="cmt_box">
							<c:forEach items="${cmmtList }" var="cmmt">
								<div class="cmt_cont">
									<span><c:out value="${cmmt.regName }"/></span>&nbsp;<c:out value="${cmmt.regDate }"/>
									<div class="cmt_fuction">
										<a href="#" class="btn_s_del" onclick="fn_cmmt_delete(<c:out value='${cmmt.cmtSeq }'/>); return false;">삭제</a>
									</div>
									<p><c:out value="${cmmt.cmtContent }" escapeXml="false"/></p>
								</div>
							</c:forEach>
						<%--
							<div class="cmt_cont">
								<span>홍길동</span> 2017-03-28
								<div class="cmt_fuction"><a href="#" class="btn_s_modi">수정</a><a href="#" class="btn_s_del">삭제</a></div>
								<p>기대 하고 있습니다.</p>
							</div>
							<div class="cmt_int">
								<textarea cols="5" rows="5"></textarea>
								<a  href="#">등록하기</a>
							</div>
					 	--%>
						</div>
					</div>
				</div>

				<div class="btn_box">
					<div class="btn_c">
						<a href="#" class="b_type03" onclick="fn_cmmt_add_list(); return false;">더보기</a>
						<input type="hidden" id="pageCmmtIndex" name="pageCmmtIndex" value="1"/>
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
<input type="hidden" id="message" name="message" value="${message }"/>
<!-- 목록페이지 조건 -->
<input type="hidden" id="searchClass" name="searchClass" value="${searchVO.searchClass }"/>
<input type="hidden" id="searchSubject" name="searchSubject" value="${searchVO.searchSubject }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="pageIndex2" name="pageIndex2" value="${searchVO.pageIndex2 }"/>
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="searchWord2" name="searchWord2" value="${searchVO.searchWord2 }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>