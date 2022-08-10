<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/smg/smgList.do'/>").submit();
	}

	// 등록 & 수정 화면
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/smg/smgModify.do'/>").submit();
	}
	
	// 삭제 
	function fn_delete(){
		if(confirm("삭제하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/smg/smgDelete.do'/>").submit();
		}
	}
	// 댓글 입력
	function fn_comment_update(){
		if($("#cbcoContent").val() == ''){
			alert("댓글 내용을 입력해주세요");
			$("#cbcoContent").focus();
			return false;
		}
		$.ajax({
			url: "<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/smg/smgCommentUpdate.do'/>"
			, type: "post"
			, data: $("#frm").serialize()
			, dataType:"json"
			, success: function(data){
				$("#commentList").empty();
				$("#cbcoContent").val('');
				cbCommentList = data.cbCommentList;
				
				$.each(cbCommentList, function(i, result){
					var tags = '';
					tags += '<div class="cmt_cont">';
					tags += '	<dl>';
					tags += '		<dt>'+result.cbcoRegName+'<span>'+result.cbcoRegDate+'</span>';
					tags += '		<span class="comment_cont">';
					if(result.cbcoRegSeq == ''){
						tags += '		| <a href="#" onclick="fn_comment_delete('+result.cbcoSeq+' ); return false;">삭제</a>';	
					}
					tags += '		</span>';
					tags += '		</dt>';
					tags += '		<dd>'+result.cbcoContent+' </dd>';
					tags += '	</dl>';
					tags += '</div>';
					
					$("#commentList").append(tags);
				});
				
				alert("댓글이 등록되었습니다.");
				
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	// 댓글 삭제
	function fn_comment_delete(cbcoSeq){
		if(confirm("삭제하시겠습니까?")){
			$("#cbcoSeq").val(cbcoSeq);
			
			$.ajax({
				url: "<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/smg/smgCommentDelete.do'/>"
				, type: "post"
				, data: $("#frm").serialize()
				, dataType:"json"
				, success: function(data){
					$("#commentList").empty();
					$("#cbcoContent").val('');
					cbCommentList = data.cbCommentList;
					
					$.each(cbCommentList, function(i, result){
						var tags = '';
						tags += '<div class="cmt_cont">';
						tags += '	<dl>';
						tags += '		<dt>'+result.cbcoRegName+'<span>'+result.cbcoRegDate+'</span>';
						tags += '		<span class="comment_cont">';
						if(result.cbcoRegSeq == ''){
							tags += '		| <a href="#" onclick="fn_comment_delete('+result.cbcoSeq+' ); return false;">삭제</a>';	
						}
						tags += '		</span>';
						tags += '		</dt>';
						tags += '		<dd>'+result.cbcoContent+' </dd>';
						tags += '	</dl>';
						tags += '</div>';
						
						$("#commentList").append(tags);
					});
					
					alert("댓글이 삭제되었습니다.");
					
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	// 파일 다운로드
	function fn_filedownload(cbupSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+cbupSeq+"&type="+type;
	}
	
	
</script>
<body>
<form:form commandName="cmmBoardVO" id="frm" name="frm">
<form:hidden path="cbSeq"/>
<input type="hidden" id="cbcoRegName" name="cbcoRegName" value="${cmmBoardVO.regName }"/>
<input type="hidden" id="cbcoSeq" name="cbcoSeq" />

	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<!-- container -->
	<div class="main_content" id="content">
		<div class="width_box">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
			<!--// lnb -->
			<!-- content -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="캠퍼스생활"/>
		            <jsp:param name="dept2" value="학사Q&A"/>
	           	</jsp:include>
				<div class="transform_table notice_type">
					<div class="tbl_view">
						<ul class="tbl_view_m">
							<li class="txt_left"><c:out value="${cmmBoardVO.cbTitle }" escapeXml="false"/></li>
							<li>작성자 : <c:out value="${cmmBoardVO.regName }"/></li>
							<li><c:out value="${cmmBoardVO.cbRegDate }"/></li>
							<li><c:out value="${cmmBoardVO.cbCount }"/></li>
						</ul>
						<div class="tbl_cont">
							<c:out value="${cmmBoardVO.cbContent }" escapeXml="false"/>
						</div>
						<c:if test="${!empty cbUpfileList }">
							<ul class="tbl_file">
								<li>첨부파일</li>
								<li>
									<c:forEach items="${cbUpfileList }" var="cbUpfile">
										<a href="#" onclick="fn_filedownload(<c:out value='${cbUpfile.cbupSeq }'/>, 'CMMBOARD'); return false;">
											<c:out value="${cbUpfile.cbupOriginFilename }"/>
										</a>
									</c:forEach>
								</li>
							</ul>
						</c:if>
					</div>
				</div>
				
				<div class="btn_box">
					<c:if test="${cmmBoardVO.regSeq eq 0}">
						<a href="#" class="btn_go_mody" onclick="fn_modify(); return false;">수정</a>
						<a href="#" class="btn_go_del" onclick="fn_delete(); return false;">삭제</a>
					</c:if>
					<a href="#" class="btn_go_list" onclick="fn_list(); return false;">목록</a>
				</div>
				<c:if test="${cmmBoardVO.regSeq eq 0 }">
					<div class="comment">
						<div id="commentList">
							<c:forEach var="list" items="${cbCommentList }">
								<dl>
									<dt><c:out value="${list.cbcoRegName }"/> <span><c:out value="${list.cbcoRegDate }"/></span> <span class="comment_cont">
									<c:if test="${empty list.cbcoRegSeq}"><%-- <a href="#" onclick="fn_comment_update(<c:out value="${list.cbcoSeq }"/>); return false;">수정</a>  --%>| <a href="#" onclick="fn_comment_delete(<c:out value="${list.cbcoSeq }"/>); return false;">삭제</a></c:if></span></dt>
									<dd>
										<c:out value="${list.cbcoContent }" escapeXml="false"/>
									</dd>
								</dl>
							</c:forEach>
						</div>
						<div class="input_comment">
							<textarea cols="5" rows="5" id="cbcoContent" name="cbcoContent" ></textarea>
							<a href="#" onclick="fn_comment_update(); return false;">입력</a>
						</div>
					</div>
				</c:if>
				<!-- rolling banner -->
				<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
				<!-- //rolling banner -->
				<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
			</div>
			<!--// content -->
		</div>
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<!-- 목록 검색 조건 -->
<input type="hidden" id="menuType" name="menuType" value="${searchVO.menuType }"/>
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<!--// 목록 검색 조건 -->
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>