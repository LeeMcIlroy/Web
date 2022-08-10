<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="size" value="${stdList.size() }"/>
	<div class="pop-std-box">
		<div class="contents">
			<div class="pop-table-box">
				<table class="std-pop-table-header">
					<colgroup>
						<col width="8%"/>
						<col width="20%"/>
						<col width="20%"/>
						<col width="52%"/>
					</colgroup>
					<tbody>
						<tr>
							<td><a href="#"><img src="<c:url value='/assets/usr/img/logo.png'/>" style="width:58px; vertical-align: middle;"></a></td>
							<td>한국어교육과정</td>
							<td>
								<c:forEach items="${resultList }" var="result">
									<c:out value="${result.lectYear }"/>년도 <c:out value="${result.lectSem eq '1'?'봄학기':result.lectSem eq '2'?'여름학기':result.lectSem eq '3'?'가을학기':result.lectSem eq '4'?'겨울학기':'' }"/>
								</c:forEach>
							</td>
							<td>&nbsp;</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="pop-table-box">
				<table class="std-top-table">
					<colgroup>
						<col />
					</colgroup>
					<tbody>
						<tr>
							<td class="lh25">
								<p>학생&nbsp;명단<span style="font-size: 20px">*각 반별</span></p>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="std-table-box">
				<table class="std-list-table">
					<colgroup>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
					</colgroup>
					<tbody>
						<tr>
							<th>학기</th>
							<th>급</th>
							<th>반</th>
							<th>인원</th>
							<th>담임교사</th>
						</tr>
						<c:forEach items="${resultList }" var="result">
							<tr>
								<td id="std"><%-- <c:out value="${result.lectSem }"/> --%>
									<c:out value="${result.lectYear }"/>-<c:out value="${result.lectSem eq '1'?'봄학기':result.lectSem eq '2'?'여름학기':result.lectSem eq '3'?'가을학기':result.lectSem eq '4'?'겨울학기':'' }"/>
								</td>
								<td>
									<c:set var = "string1" value = "${result.lectName }"/>
								    <c:set var = "length" value = "${fn:length(string1)}"/>
								    <c:set var = "string2" value = "${fn:substring(string1, length -1, length)}" />
								    <c:if test="${string2.matches('[0-9]+') }">
								    	<c:out value="${string2 }"/>급
								    </c:if>
								    <c:if test="${!string2.matches('[0-9]+') }">
								    	1급
								    </c:if>
								</td>
								<td><c:out value="${result.lectDivi }"/></td>
								<td><c:out value="${size}"/>명</td>
								<td id="std"><c:out value="${result.lectClaTea}"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- incStdList(usr),incStdList(adm),incStdAllList -->
			<div class="std-table-box">	
				<table class="std-list-table">
					<colgroup>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
					</colgroup>
					<tbody>
					<!-- 추가 필요한값은 sql문 수정필요 -->
							<tr>
								<c:forEach items="${stdList }" var="std" begin="0" end="4">
									<td id="std">
										<table>
											<tr><td><c:out value="${std.memberCode }" /></td></tr>
											<tr><td><img src="<c:url value='/showImage.do?filePath=${std.imgPath}'/>"  alt="<c:out value="${std.imgName}"/>" style="width:140px; height:170px; text-align: center;" onerror="this.src='<c:url value='/assets/adm/img/nophoto.jpg'/>'"/></td></tr>
											<tr><td><c:out value="${std.name }" /></td></tr>
											<tr><td><c:out value="${std.nation }" /> / <c:out value="${std.gender }" /></td></tr>
											<tr><td><c:out value="${std.tel }" /> / <c:out value="${std.naSns }" /></td></tr>
											<tr><td><c:out value="${std.email }" />&nbsp;</td></tr>
											<tr><td style="border-bottom: 0;"><c:out value="${std.addr1 }" />&nbsp;<c:out value="${std.addr2 }" /></td></tr>
										</table>
									</td>
								</c:forEach>
								<c:if test="${size < 5 }">
									<c:forEach begin="1" end="${5 - size }">
										<td id="std">
											<table>
												<tr><td>&nbsp;</td></tr>
												<tr><td><img src="<c:url value='/assets/adm/img/empty.png'/>" style="width:140px; height:170px; text-align: center;"></td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td style="border-bottom: 0;">&nbsp;</td></tr>
											</table>
										</td>
									</c:forEach>
								</c:if>
							</tr>
					</tbody>
				</table>
			</div>
							
			<div class="std-table-box">	
				<table class="std-list-table">
					<colgroup>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
					</colgroup>
					<tbody>
							<tr>
								<c:forEach items="${stdList }" var="std" begin="5" end="9">
									<td id="std">
										<table>
											<tr><td><c:out value="${std.memberCode }" /></td></tr>
											<tr><td><img src="<c:url value='/showImage.do?filePath=${std.imgPath}'/>"  alt="<c:out value="${std.imgName}"/>" style="width:140px; height:170px; text-align: center;" onerror="this.src='<c:url value='/assets/adm/img/nophoto.jpg'/>'"/></td></tr>
											<tr><td><c:out value="${std.name }" /></td></tr>
											<tr><td><c:out value="${std.nation }" /> / <c:out value="${std.gender }" /></td></tr>
											<tr><td><c:out value="${std.tel }" /> / <c:out value="${std.naSns }" /></td></tr>
											<tr><td><c:out value="${std.email }" />&nbsp;</td></tr>
											<tr><td style="border-bottom: 0;"><c:out value="${std.addr1 }" />&nbsp;<c:out value="${std.addr2 }" /></td></tr>
										</table>
									</td>
								</c:forEach>
								<c:if test="${size < 5 }">
									<c:forEach begin="1" end="5">
										<td id="std">
											<table>
												<tr><td>&nbsp;</td></tr>
												<tr><td><img src="<c:url value='/assets/adm/img/empty.png'/>" style="width:140px; height:170px; text-align: center;"></td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td style="border-bottom: 0;">&nbsp;</td></tr>
											</table>
										</td>
									</c:forEach>
								</c:if>
								<c:if test="${size > 5 && size < 10}">
									<c:forEach begin="1" end="${10 - size }">
										<td id="std">
											<table>
												<tr><td>&nbsp;</td></tr>
												<tr><td><img src="<c:url value='/assets/adm/img/empty.png'/>" style="width:140px; height:170px; text-align: center;"></td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td style="border-bottom: 0;">&nbsp;</td></tr>
											</table>
										</td>
									</c:forEach>
								</c:if>
							</tr>
					</tbody>
				</table>
			</div>
							
			<div class="std-table-box">	
				<table class="std-list-table">
					<colgroup>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
						<col style="width:20%;"/>
					</colgroup>
					<tbody>
							<tr>
								<c:forEach items="${stdList }" var="std" begin="10" end="14">
									<td id="std">
										<table>
											<tr><td><c:out value="${std.memberCode }" /></td></tr>
											<tr><td><img src="<c:url value='/showImage.do?filePath=${std.imgPath}'/>"  alt="<c:out value="${std.imgName}"/>" style="width:140px; height:170px; text-align: center;" onerror="this.src='<c:url value='/assets/adm/img/nophoto.jpg'/>'"/></td></tr>
											<tr><td><c:out value="${std.name }" /></td></tr>
											<tr><td><c:out value="${std.nation }" /> / <c:out value="${std.gender }" /></td></tr>
											<tr><td><c:out value="${std.tel }" /> / <c:out value="${std.naSns }" /></td></tr>
											<tr><td><c:out value="${std.email }" />&nbsp;</td></tr>
											<tr><td style="border-bottom: 0;"><c:out value="${std.addr1 }" />&nbsp;<c:out value="${std.addr2 }" /></td></tr>
										</table>
									</td>
								</c:forEach>
								<c:if test="${size < 5 || size < 10}">
									<c:forEach begin="1" end="5">
										<td id="std">
											<table>
												<tr><td>&nbsp;</td></tr>
												<tr><td><img src="<c:url value='/assets/adm/img/empty.png'/>" style="width:140px; height:170px; text-align: center;"></td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td style="border-bottom: 0;">&nbsp;</td></tr>
											</table>
										</td>
									</c:forEach>
								</c:if>
								<c:if test="${size > 10 && size < 15}">
									<c:forEach begin="1" end="${15 - size }">
										<td id="std">
											<table>
												<tr><td>&nbsp;</td></tr>
												<tr><td><img src="<c:url value='/assets/adm/img/empty.png'/>" style="width:140px; height:170px; text-align: center;"></td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td>&nbsp;</td></tr>
												<tr><td style="border-bottom: 0;">&nbsp;</td></tr>
											</table>
										</td>
									</c:forEach>
								</c:if>
							</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</html>