<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script type="text/javascript">
	$(function(){
		var cnt = <c:out value="${resultList.size()}"/>;
		if(cnt == 0){
			alert('상담이력이 없습니다.');   
			window.close();
		}
	});
</script>
<body>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<div class="main-content" style="float: left;">
				<div class="title-area">
					<p class="page-lv01" style="text-align:left;">상담이력</p>
				</div>
				<c:forEach items="${resultList }" var="result" varStatus="status">
				<c:if test="${status.first }">
				<p class="sub-title">학생 정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>이름</th>
								<td>
									<c:out value="${result.name }"/>
								</td>
								<th>학번</th>
								<td>
									<c:out value="${result.memberCode }"/>
								</td>
								<th>영문명</th>
								<td>
									<c:out value="${result.eName }"/>
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td>
									<c:out value="${result.status }"/>
								</td>
								<th>급수</th>
								<td>
									<c:out value="${result.step }"/>급
								</td>
								<th>국적</th>
								<td>
									<c:out value="${result.nation }"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				</c:if>
				<p class="sub-title">상담내용</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>상담일자</th>
								<td>
									<c:out value="${result.consultDate }"/>
								</td>
								<th>상담자</th>
								<td>
									<c:out value="${result.profCode }"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>상담구분</th>
								<td>
									<c:out value="${result.consultType }"/>
								</td>
								<th>상담장소</th>
								<td>
									<c:out value="${result.place }"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>상담내용</th>
								<td colspan="3">
									<c:out value="${result.content }" escapeXml="false"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				</c:forEach>
				<%-- <p class="sub-title">첨부파일</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>첨부파일</th>
								<td>
									<c:forEach items="${attachList }" var="attach">
										<p class="file-upload">
											<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>">
												<c:out value="${attach.orgFileName }"/>
											</a>
										</p>
									</c:forEach>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>첨부파일</dt>
							<dd>
								<ul>
									<li>
										<c:forEach items="${attachList }" var="attach">
											<p class="file-upload">
												<a href="<c:url value='/cmmn/file/downloadFile.do?fileId=${attach.attachSeq }&type=${attach.boardType }'/>">
													<c:out value="${attach.orgFileName }"/>
												</a>
											</p>
										</c:forEach>
									</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div> --%>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
</body>
</html>