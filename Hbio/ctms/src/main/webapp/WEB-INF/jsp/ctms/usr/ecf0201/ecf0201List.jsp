<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script type="text/javascript">
	function fn_list(){
		$("#frm").attr("action", "<c:url value='/usr/ecf0201/ecf0201List.do'/>").submit();
	}
	
	function fn_update(chkNum){
		$("#chkNum").val(chkNum);
		$("#frm").attr("action", "<c:url value='/usr/ecf0201/ecf0201Update.do'/>").submit();
	}
	
	function fn_etc(num){
		$("#remk").val($("#remk_"+num).val());
		$("#frm").attr("action", "<c:url value='/usr/ecf0201/ecf0201RemkUpdate.do'/>").submit();
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<form:form commandName="searchVO" id="frm" name="frm">
		<input type="hidden" id="chkDt" name="chkDt" value="<c:out value='${nowDate }'/>"/>
		<input type="hidden" id="chkNum" name="chkNum"/>
		<input type="hidden" id="remk" name="remk"/>
		<!-- contents -->
		<div class="contents">
			<c:choose>
				<c:when test="${rsList != null && rsList.size() != 0 && usrSession.regLv eq '2' }">
					<!-- 임상시험 선택 -->
					<div class="top_select">
						<form:select path="rsNo" class="top_select_se" onchange="fn_list(); return false;">
							<form:option value="">임상시험 선택</form:option>
							<c:forEach items="${rsList }" var="rsMap">
								<form:option value="${rsMap.rsNo }"><c:out value="${rsMap.rsName }"/></form:option>
								<c:if test="${searchVO.rsNo eq rsMap.rsNo }">
									<c:set var="rsiNo" value="${rsMap.rsiNo }"/>
								</c:if>
							</c:forEach>
						</form:select>
					</div>
					<!-- //임상시험 선택 -->
					<c:if test="${timeMap != null }">
						<!-- 사용체크 -->
						<div class="usage_check_con">
							<!-- 전달사항 -->
							<div class="text_box type02">
								<c:out value="${timeMap.cont }"/>
							</div>
							<!-- //전달사항 -->
							<!-- 일정 -->
							<p>사용체크 일정 <span><c:out value="${timeMap.chkStdt }"/> ~ <c:out value="${timeMap.chkEndt }"/></span></p>
							<!-- //일정 -->
							<ul>
								<c:forEach items="${timeList }" var="result" varStatus="status">
									<c:set var="chkDt" value="${result.chkDt2 }"/>
									<li>
										<div>
											<em><c:out value="${result.chkDt }"/></em>
											<span>
												<c:if test="${timeMap.dspName1 != null && timeMap.dspName1 ne '' && timeMap.chkCnt >= 1 }">
													<span>
														<c:if test="${resultMap[chkDt] == null }">
															<c:if test="${result.chkDtInt == nowDateInt  }">
																<a href="#" class="btn_sub" onclick="fn_update('1'); return false;">
																	<c:out value="${timeMap.dspName1 }"/>
																</a>
															</c:if>
															<c:if test="${result.chkDtInt < nowDateInt  }">
																<a class="btn_sub type02"><c:out value="${timeMap.dspName1 }"/></a>
															</c:if>
														</c:if>
														<c:if test="${resultMap[chkDt] != null }">
															<c:if test="${result.chkDtInt == nowDateInt  }">
																<c:if test="${resultMap[chkDt].chk1 eq 'Y' }">
																	<a class="btn_sub type03"><c:out value="${timeMap.dspName1 }"/></a>
																</c:if>
																<c:if test="${resultMap[chkDt].chk1 ne 'Y' }">
																	<a href="#" class="btn_sub" onclick="fn_update('1'); return false;">
																		<c:out value="${timeMap.dspName1 }"/>
																	</a>
																</c:if>
															</c:if>
															<c:if test="${result.chkDtInt != nowDateInt  }">
																<c:if test="${resultMap[chkDt].chk1 eq 'Y' }">
																	<a class="btn_sub type03"><c:out value="${timeMap.dspName1 }"/></a>
																</c:if>
																<c:if test="${resultMap[chkDt].chk1 ne 'Y' }">
																	<a class="btn_sub type02"><c:out value="${timeMap.dspName1 }"/></a>
																</c:if>
															</c:if>
														</c:if>
													</span>
												</c:if>
												<c:if test="${timeMap.dspName2 != null && timeMap.dspName2 ne '' && timeMap.chkCnt >= 2 }">
													<span>
														<c:if test="${resultMap[chkDt] == null }">
															<c:if test="${result.chkDtInt == nowDateInt  }">
																<a href="#" class="btn_sub" onclick="fn_update('2'); return false;">
																	<c:out value="${timeMap.dspName2 }"/>
																</a>
															</c:if>
															<c:if test="${result.chkDtInt < nowDateInt  }">
																<a class="btn_sub type02"><c:out value="${timeMap.dspName2 }"/></a>
															</c:if>
														</c:if>
														<c:if test="${resultMap[chkDt] != null }">
															<c:if test="${result.chkDtInt == nowDateInt  }">
																<c:if test="${resultMap[chkDt].chk2 eq 'Y' }">
																	<a class="btn_sub type03"><c:out value="${timeMap.dspName2 }"/></a>
																</c:if>
																<c:if test="${resultMap[chkDt].chk2 ne 'Y' }">
																	<a href="#" class="btn_sub" onclick="fn_update('2'); return false;">
																		<c:out value="${timeMap.dspName2 }"/>
																	</a>
																</c:if>
															</c:if>
															<c:if test="${result.chkDtInt != nowDateInt  }">
																<c:if test="${resultMap[chkDt].chk2 eq 'Y' }">
																	<a class="btn_sub type03"><c:out value="${timeMap.dspName2 }"/></a>
																</c:if>
																<c:if test="${resultMap[chkDt].chk2 ne 'Y' }">
																	<a class="btn_sub type02"><c:out value="${timeMap.dspName2 }"/></a>
																</c:if>
															</c:if>
														</c:if>
													</span>
												</c:if>
												<c:if test="${timeMap.dspName3 != null && timeMap.dspName3 ne '' && timeMap.chkCnt >= 3 }">
													<span>
														<c:if test="${resultMap[chkDt] == null }">
															<c:if test="${result.chkDtInt == nowDateInt  }">
																<a href="#" class="btn_sub" onclick="fn_update('3'); return false;">
																	<c:out value="${timeMap.dspName3 }"/>
																</a>
															</c:if>
															<c:if test="${result.chkDtInt < nowDateInt  }">
																<a class="btn_sub type02"><c:out value="${timeMap.dspName3 }"/></a>
															</c:if>
														</c:if>
														<c:if test="${resultMap[chkDt] != null }">
															<c:if test="${result.chkDtInt == nowDateInt  }">
																<c:if test="${resultMap[chkDt].chk3 eq 'Y' }">
																	<a class="btn_sub type03"><c:out value="${timeMap.dspName3 }"/></a>
																</c:if>
																<c:if test="${resultMap[chkDt].chk3 ne 'Y' }">
																	<a href="#" class="btn_sub" onclick="fn_update('3'); return false;">
																		<c:out value="${timeMap.dspName3 }"/>
																	</a>
																</c:if>
															</c:if>
															<c:if test="${result.chkDtInt != nowDateInt  }">
																<c:if test="${resultMap[chkDt].chk3 eq 'Y' }">
																	<a class="btn_sub type03"><c:out value="${timeMap.dspName3 }"/></a>
																</c:if>
																<c:if test="${resultMap[chkDt].chk3 ne 'Y' }">
																	<a class="btn_sub type02"><c:out value="${timeMap.dspName3 }"/></a>
																</c:if>
															</c:if>
														</c:if>
													</span>
												</c:if>
												<c:if test="${timeMap.dspName4 != null && timeMap.dspName4 ne '' && timeMap.chkCnt >= 4 }">
													<span>
														<c:if test="${resultMap[chkDt] == null }">
															<c:if test="${result.chkDtInt == nowDateInt  }">
																<a href="#" class="btn_sub" onclick="fn_update('4'); return false;">
																	<c:out value="${timeMap.dspName4 }"/>
																</a>
															</c:if>
															<c:if test="${result.chkDtInt < nowDateInt  }">
																<a class="btn_sub type02"><c:out value="${timeMap.dspName4 }"/></a>
															</c:if>
														</c:if>
														<c:if test="${resultMap[chkDt] != null }">
															<c:if test="${result.chkDtInt == nowDateInt  }">
																<c:if test="${resultMap[chkDt].chk4 eq 'Y' }">
																	<a class="btn_sub type03"><c:out value="${timeMap.dspName4 }"/></a>
																</c:if>
																<c:if test="${resultMap[chkDt].chk4 ne 'Y' }">
																	<a href="#" class="btn_sub" onclick="fn_update('4'); return false;">
																		<c:out value="${timeMap.dspName4 }"/>
																	</a>
																</c:if>
															</c:if>
															<c:if test="${result.chkDtInt != nowDateInt  }">
																<c:if test="${resultMap[chkDt].chk4 eq 'Y' }">
																	<a class="btn_sub type03"><c:out value="${timeMap.dspName4 }"/></a>
																</c:if>
																<c:if test="${resultMap[chkDt].chk4 ne 'Y' }">
																	<a class="btn_sub type02"><c:out value="${timeMap.dspName4 }"/></a>
																</c:if>
															</c:if>
														</c:if>
													</span>
												</c:if>
												<c:if test="${timeMap.dspName5 != null && timeMap.dspName5 ne '' && timeMap.chkCnt >= 5 }">
													<span>
														<c:if test="${resultMap[chkDt] == null }">
															<c:if test="${result.chkDtInt == nowDateInt  }">
																<a href="#" class="btn_sub" onclick="fn_update('5'); return false;">
																	<c:out value="${timeMap.dspName5 }"/>
																</a>
															</c:if>
															<c:if test="${result.chkDtInt < nowDateInt  }">
																<a class="btn_sub type02"><c:out value="${timeMap.dspName5 }"/></a>
															</c:if>
														</c:if>
														<c:if test="${resultMap[chkDt] != null }">
															<c:if test="${result.chkDtInt == nowDateInt  }">
																<c:if test="${resultMap[chkDt].chk5 eq 'Y' }">
																	<a class="btn_sub type03"><c:out value="${timeMap.dspName5 }"/></a>
																</c:if>
																<c:if test="${resultMap[chkDt].chk5 ne 'Y' }">
																	<a href="#" class="btn_sub" onclick="fn_update('5'); return false;">
																		<c:out value="${timeMap.dspName5 }"/>
																	</a>
																</c:if>
															</c:if>
															<c:if test="${result.chkDtInt != nowDateInt  }">
																<c:if test="${resultMap[chkDt].chk5 eq 'Y' }">
																	<a class="btn_sub type03"><c:out value="${timeMap.dspName5 }"/></a>
																</c:if>
																<c:if test="${resultMap[chkDt].chk5 ne 'Y' }">
																	<a class="btn_sub type02"><c:out value="${timeMap.dspName5 }"/></a>
																</c:if>
															</c:if>
														</c:if>
													</span>
												</c:if>
											</span>
											<p>특이사항</p>
											<div>
												<textarea id="remk_<c:out value='${status.count }'/>" name="remk_<c:out value='${status.count }'/>" <c:out value='${result.chkDtInt != nowDateInt?"disabled":"" }'/>><c:out value="${resultMap[chkDt].remk }"/></textarea>
												<c:if test="${result.chkDtInt == nowDateInt }">
													<a href="#" onclick="fn_etc('<c:out value='${status.count }'/>'); return false;">전송</a>
												</c:if>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</div>
						<!-- //사용체크 -->
					</c:if>
				</c:when>
				<c:otherwise>
					<!-- 임상시험 없는 경우 -->
					<div class="text_box">
						참여중인 임상시험이 없습니다.<br />임상에 참여하시려면 회원정보를 정확하게 등록하여야 합니다.<br />회원정보 등록 후 임상에 지원하시기 바랍니다.
					</div>
					<!-- 하단버튼 -->
					<div class="btn_area">
						<span><a href="<c:url value='/usr/ecf0501/ecf0501Modify.do'/>">회원정보 변경</a></span>
						<span><a href="<c:url value='/usr/ecf0401/ecf0401List.do'/>">임상시험 지원</a></span>
					</div>
					<!-- //임상시험 없는 경우 -->
				</c:otherwise>
			</c:choose>
		</div>
		<!-- //contents -->
		<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
	</form:form>
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- //footer -->
</div>
<!-- //wrap -->
</body>
</html>