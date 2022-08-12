package ctms.adm.ech0103;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.tribes.util.Arrays;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.mail.MailSendUtil;
import component.sms.SmsSendUtil;
import component.util.ComStringUtil;

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Rm2000mVO;
import ctms.valueObject.Rm1000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0103Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0103Controller.class);
	@Autowired private Ech0103DAO ech0103DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
			
	
	//로그인화면으로 리다이렉트합니다.
	//private String redirectLoginView(RedirectAttributes reda, String message){
	//	reda.addFlashAttribute("message", message);
	//	return "redirect:/qxsepmny/lgn/admLoginView.do";
	//}
	
	/**
	 * 관리자 코딩 화면으로 이동합니다.
	 * @param model
	 * @return 코딩 화면
	 * @throws Exception
	 */
	
	
	// ******************************** 20201228 관리자 예약관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0103/ech0103List.do")	
	public String ech0103List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech0103List.do - 예약관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		//검색항목 설정 시작
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());		
		
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 연구과제 목록만 표시 
		//관리자인 경우 소속지사를 설정하지 않는다 1:관리자권한 2:일반사용자권한
		if(adminVO.getAdminType().equals("2")) { 
			searchVO.setBranchCd(adminVO.getBranchCd());
			searchVO.setSearchCondition7(adminVO.getBranchCd());
			}
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition7())){
			searchVO.setBranchCd(searchVO.getSearchCondition7()); 
		}

		//시작일자 searchCondition1 종료일자 searchCondition2 기간구분 searchCondition4
		//searchWord 검색어구분 searchCondition3
		//연도목록
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		
		EgovMap map = new EgovMap();
		
		map.put("searchYear", searchVO.getSearchYear());
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());;
	 	
	 	if(adminVO.getAdminType().equals("2")) 
		{ 
			map.put("branchCd", adminVO.getBranchCd()); 
			//지사명 (일반대상자) 목록
			List<EgovMap> branchOne = cmmDAO.selectBranchListOne(map);
			model.addAttribute("branch", branchOne);

		}else {
			//지사명  목록 
			List<EgovMap> branch = cmmDAO.selectBranchList(searchVO.getCorpCd());
			model.addAttribute("branch", branch);
			
			if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition7())){
				map.put("branchCd", searchVO.getSearchCondition7());
			}else {
				map.put("branchCd", "");
			}
		}
		
		//List<EgovMap> rsCdList = ech0101DAO.selectEch0101StaffList(map);
		List<EgovMap> yearRsCdList = cmmDAO.selectCmmYearRsCdList2(map);
		
		model.addAttribute("yearRsCdList", yearRsCdList);
		
		//임상분류(공통코드) 목록 searchCondition5
		List<EgovMap> ct2030 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2030");
		model.addAttribute("ct2030", ct2030);
		
		//연구상태(공통코드) 목록 searchCondition5
		List<EgovMap> ct2050 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2050");
		model.addAttribute("ct2050", ct2050);
		
		//-- 검색항목 설정 끝
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0103DAO.selectEch0103List(searchVO);
		model.addAttribute("resultList", listVO.getEgovList());
		
        EgovMap paramMap = new EgovMap();        
        EgovMap resultMap = new EgovMap();

        for(EgovMap map1 : listVO.getEgovList()){
        	String mapKey = (String) map1.get("rsNo")+map1.get("rsjNo");
        	
        	paramMap.put("corpCd", map1.get("corpCd"));
           	paramMap.put("rsNo", map1.get("rsNo"));
           	paramMap.put("rsjNo", map1.get("rsjNo"));
            List<EgovMap> mtList = ech0103DAO.selectEch0103MtList(paramMap);
            resultMap.put(mapKey, mtList);
        }
        LOGGER.debug("resultMap"+resultMap.toString());
        model.addAttribute("mtList", resultMap);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0103/ech0103List";
	}
	
	// ********************************(연구관리) 20201228 관리자 예약관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0103/ech0103View.do")
	public String ech0103View(@ModelAttribute CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, Rs4000mVO rs4000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech0103View.do - 연구관리 예약관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		String message = "";
		
		//rs1000mVO =  ech0103DAO.selectEch0103RsView(rs1000mVO);	
		
		rs4000mVO =  ech0103DAO.selectEch0103View(rs4000mVO);
				
		//IRB심의정보가 없는 경우 등록화면으로 전환
		if (rs4000mVO == null) {
			//model.addAttribute("NotiPageGubun","NotiRegist");			
			message = "예약정보를 등록해주세요.";
			String rsNo = rs1000mVO.getRsNo();			
			return redirectModify(reda, message, rsNo);
		}
						
		//model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("rs4000mVO", rs4000mVO);		
		model.addAttribute("pageIndex", searchVO.getPageIndex());
										
		return "/adm/ech0103/ech0103View";
	}	

	// ********************************(연구관리) 20201228 관리자 예약관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0103/ech0103Modify.do")
	public String ech0103Modify(@ModelAttribute("rs4000mVO") Rs4000mVO rs4000mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech0103Modify.do - 관리자 예약관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		
		// 회사코드 설정 
		rs4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		LOGGER.debug("==============================================");
		LOGGER.debug(rs4000mVO.toString());
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");	 		 	
	
	 	//등록화면으로
	 	if (EgovStringUtil.isEmpty(rs4000mVO.getResrNo())) {
			
			//model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(rs4000mVO.getResrNo())){
						
				rs4000mVO = ech0103DAO.selectEch0103View(rs4000mVO);
							
				model.addAttribute("NotiPageGubun","NotiUpdate");
				model.addAttribute("rs4000mVO", rs4000mVO);
				
		}
			
			return "/adm/ech0103/ech0103Modify";
	}

	// ********************************(연구관리) 20201128 관리자 예약관리 저장 ********************************
	@RequestMapping("/qxsepmny/ech0103/ech0103Update.do")
	public String ech0103Save(@ModelAttribute("rs4000mVO") Rs4000mVO rs4000mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech0103Update.do - 관리자 예약관리 저장");
		String message = "";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드(CTMS운영) 설정
		rs4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		// 등록수정자 설정
		rs4000mVO.setDataRegnt("aid");
		LOGGER.debug("==============================================");
		LOGGER.debug(rs4000mVO.toString());
		
		if(EgovStringUtil.isEmpty(rs4000mVO.getResrNo())){
		    
			//작성자 안에 세션 name 입력
			//noticeVO.setNoti_writer(adminVO.getName());
			//rs4000mVO.setRvNo(rs4000mVO.getRvNo1()+rs4000mVO.getRvNo2()+rs4000mVO.getRvNo3()+rs4000mVO.getRvNo4()+rs4000mVO.getRvNo5());			
			ech0103DAO.insertEch0103(rs4000mVO);
			
			message = "등록이 완료되었습니다.";

		}else{
			ech0103DAO.updateEch0103(rs4000mVO);
	
			message = "수정이 완료되었습니다.";			
			}
	
		return redirectList(reda, message);

	}

	// ********************************(연구관리) 20201228 관리자 예약관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0103/ech0103Delete.do")
	public String ech0103Delete(@ModelAttribute Rs4000mVO rs4000mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech0103Delete.do - 관리자 예약관리 삭제");
		String message = "";
		
		//IRBM심의관리 삭제
		if(!EgovStringUtil.isEmpty(rs4000mVO.getResrNo())){
		
			ech0103DAO.deleteEch0103(rs4000mVO);
		
			message = "IRB심의정보가 삭제되었습니다.";
		}
		return redirectList(reda, message);

	}

	// 예약관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0103/ech0103List.do";
	}
	
	// 예약관리 등록/수정화면으로 리다이렉트
		private String redirectModify(RedirectAttributes reda, String message, String rsNo) {
			reda.addFlashAttribute("message", message);
			reda.addFlashAttribute("rsNo", rsNo);
			return "redirect:/qxsepmny/ech0103/ech0103Modify.do";
	}

	// 예약관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0103/ech0103Excel.do")
	public void ech0103Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech0103Excel.do - 예약관리 목록 엑셀 다운로드");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0103DAO.selectEch0103Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "예약 리스트", "ech0103", request, response);
	}

	// 에약관리 팝업
	@RequestMapping("/qxsepmny/ech0103/ech1003MtmgPop.do")
	public String ech1003MtmgPop(String corpCd, String rsNo, String rsjNo, String resrNo,  Rs4000mVO rs4000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech1003MtmgPop.do - 연구대상자별 예약관리");
		//세션 호출
	 	//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		rs4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//연구대상자 예약 설정
		rs4000mVO.setRsNo(rsNo);
		rs4000mVO.setRsjNo(rsjNo);		
		rs4000mVO.setResrNo(resrNo);
		
		//resrNo 값이 없으면 등록화면 있으면 수정화면을 표시 
		//등록화면으로
	 	if (EgovStringUtil.isEmpty(rs4000mVO.getResrNo())) {
			
			//model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(rs4000mVO.getResrNo())){
				
				
				rs4000mVO = ech0103DAO.selectEch0103View(rs4000mVO);
				LOGGER.debug("rs4000mVO="+rs4000mVO.toString());
							
				model.addAttribute("NotiPageGubun","NotiUpdate");
				model.addAttribute("rs4000mVO", rs4000mVO);				
		}
			
		return "/adm/ech0103/ech1003MtmgPop";
		
	}
	
	// 일괄예약관리 팝업
	@RequestMapping("/qxsepmny/ech0103/ech1003MtmgAllPop.do")
	public String ech1003MtmgAllPop(String corpCd, String rsNo, String resrNo,  String[] rsjSeq, Rs4000mVO rs4000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech1003MtmgAllPop.do - 연구대상자별 일괄예약관리");
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		rs4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	
		//대상자 목록을 표시한다.
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsjSeq", rsjSeq);
		
		List<EgovMap> resultList = ech0103DAO.selectEch0103SendList(map);
		
		
		model.addAttribute("resultList", resultList);
		
		model.addAttribute("adminVO", adminVO);
		model.addAttribute("NotiPageGubun","NotiUpdate");
		model.addAttribute("rs4000mVO", rs4000mVO);
		
		return "/adm/ech0103/ech1003MtmgAllPop";
		
	}

	
	// 예약등록 
	@RequestMapping("/qxsepmny/ech0103/ech1003AjaxSaveStep.do")
	public View ech1003AjaxSaveStep(String corpCd,String rsNo, String rsjNo, String resrDt, String resrHr, String resrMm, String mtSt, String mtCnt, String resrNo, String regDt, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0103/ech1003AjaxSaveStep.do - 예약등록");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("rsNo", rsNo);
		map.put("rsjNo", rsjNo);
		map.put("resrDt", resrDt);
		map.put("resrHr", resrHr);
		map.put("resrMm", resrMm);
		map.put("mtSt", mtSt);
		map.put("mtCnt", mtCnt);
		map.put("dataRegnt", "aid");
		//수정
		map.put("resrNo", resrNo);
		map.put("regDt", regDt);
		
		
		if (!EgovStringUtil.isEmpty(resrNo)) {

			//예약수정
			ech0103DAO.updateEch1003AjaxSaveStep(map);
			
		}else {
			//예약등록
			ech0103DAO.insertEch1003AjaxSaveStep(map);	
		}
			
		
		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}

	// 일괄예약등록 
	@RequestMapping("/qxsepmny/ech0103/ech1003AjaxSaveAllStep.do")
	public View ech1003AjaxSaveStepAll(String corpCd,String rsNo, String resrDt, String resrHr, String resrMm, String mtSt, String mtCnt, String resrNo, String regDt, String[] rsjSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0103/ech1003AjaxSaveAllStep.do - 일괄예약등록");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("resrDt", resrDt);
		map.put("resrHr", resrHr);
		map.put("resrMm", resrMm);
		map.put("mtSt", mtSt);
		map.put("mtCnt", mtCnt);
		map.put("dataRegnt",EgovUserDetailsHelper.getAuthenticatedAdminId());
		//수정
		map.put("resrNo", resrNo);
		map.put("regDt", regDt);

		String trsjNo = "";
		String trsNo = "";
		
		for(int i=0;i<rsjSeq.length;i++) {
			trsNo = rsjSeq[i].substring(0, 8); // 연구과제번호 8자리
			trsjNo = rsjSeq[i].substring(8, 16); // 연구대상자번호 8자리
			//trsNo = rsjSeq[i].substring(0, 14); // 연구과제번호 = RS_CD 14
			//trsjNo = rsjSeq[i].substring(14, 22); // 연구대상자번호 8자리
		    map.put("rsNo", trsNo);
		    map.put("rsjNo", trsjNo);
		    LOGGER.debug("rsjSeq[i]="+rsjSeq[i]);
		    ech0103DAO.insertEch1003AjaxSaveStep(map);		
		}

		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}

	// 일괄SMS발송 팝업
	@RequestMapping("/qxsepmny/ech0103/ech0103SmsAllPop.do")
	public String ech0103SmsAllPop(String corpCd, String rsNo, String resrNo,  String[] rsjSeq, Rm2000mVO rm2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech0103SmsAllPop.do - 연구대상자별 일괄SMS발송");
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		rm2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	
		//대상자 목록을 표시한다.
		String[] trsjSeq = new String[rsjSeq.length];
		String[] trsSeq = new String[rsjSeq.length];
		
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//for(int i=0;i<rsjSeq.length;i++) {
			//trsSeq[i] = rsjSeq[i].substring(0, 8); // 연구과제번호 8자리;
			//trsjSeq[i] = rsjSeq[i].substring(8, 16); // 연구대상자번호 8자리;
		    //LOGGER.debug("rsjSeq["+i+"]"+rsjSeq[i]);
		//}
		
		map.put("rsjSeq", rsjSeq);
		map.put("rsSeq", trsSeq);

		List<EgovMap> resultList = ech0103DAO.selectEch0103SendList(map);
		
		//SMS예시 문항 목록을 구성한다.
		List<EgovMap> smsList = cmmDAO.selectSmsSplList(map);

		//접수일자에 현재일자 설정
		rm2000mVO.setRecsDt(EgovStringUtil.getDateMinus());
		
		model.addAttribute("smsList", smsList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("adminVO", adminVO);
		model.addAttribute("NotiPageGubun","NotiUpdate");
		model.addAttribute("rm2000mVO", rm2000mVO);
		
		return "/adm/cmm/admSmsAllPop";
	}
	
	// 예약SMS발송 팝업
	@RequestMapping("/qxsepmny/ech0103/ech0103SmsMtPop.do")
	public String ech0103SmsMtPop(String corpCd, String rsNo, String resrNo,  String[] rsjSeq, Rm2000mVO rm2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech0103SmsMtPop - 연구대상자별 예약SMS발송");
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//대상자 목록을 표시한다.
		String trsSeq = "";
		String trsjSeq = "";
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		for(int i=0;i<rsjSeq.length;i++) {
			trsSeq = rsjSeq[i].substring(0, 8); // 연구과제번호 8자리;
			trsjSeq = rsjSeq[i].substring(8, 16); // 연구대상자번호 8자리;
			//trsSeq = rsjSeq[i].substring(0, 14); // 연구과제번호 = RS_CD
			//trsjSeq = rsjSeq[i].substring(14, 22); // 연구대상자번호 8자리;
		    //LOGGER.debug("rsjSeq["+i+"]"+rsjSeq[i]);
		}
		map.put("rsjSeq", rsjSeq);

		List<EgovMap> resultList = ech0103DAO.selectEch0103SendSmsMtList(map);
		
		//SMS예시 문항 목록을 구성한다.
		List<EgovMap> smsList = cmmDAO.selectSmsSplList(map);

		//접수일자에 현재일자 설정
		rm2000mVO.setRecsDt(EgovStringUtil.getDateMinus());

		model.addAttribute("smsList", smsList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("adminVO", adminVO);
		model.addAttribute("NotiPageGubun","NotiUpdate");

		//rm2000mVO 설정
		rm2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rm2000mVO.setRsjNo(trsjSeq);
		
		rm2000mVO = ech0103DAO.selectEch0103RsjDetail(rm2000mVO);


		rm2000mVO.setRecsDt(EgovStringUtil.getDateMinus());	
		LOGGER.debug("rm2000mVO="+rm2000mVO.toString());
		model.addAttribute("rm2000mVO", rm2000mVO);
		
		return "/adm/cmm/admSmsMtPop";
		
	}

	
	// 일괄이메일발송 팝업
	@RequestMapping("/qxsepmny/ech0103/ech0103EmailAllPop.do")
	public String ech0103EmailAllPop(String corpCd, String rsNo, String resrNo,  String[] rsjSeq, Rm1000mVO rm1000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0103/ech0103EmailAllPop.do - 연구대상자별 일괄이메일발송");
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		rm1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	
		//대상자 목록을 표시한다.
		String[] trsjSeq = new String[rsjSeq.length];
		String[] trsSeq = new String[rsjSeq.length];
		
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//for(int i=0;i<rsjSeq.length;i++) {
			//trsSeq[i] = rsjSeq[i].substring(0, 8); // 연구과제번호 8자리;
			//trsjSeq[i] = rsjSeq[i].substring(8, 16); // 연구대상자번호 8자리;
		    //LOGGER.debug("rsjSeq["+i+"]"+rsjSeq[i]);
		//}
		
		map.put("rsjSeq", rsjSeq);
		map.put("rsSeq", trsSeq);

		//발송대상자 목록 - 목록선택 인원
		List<EgovMap> resultList = ech0103DAO.selectEch0103SendList(map);
		
		//이메일예시 문항 목록을 구성한다.
		List<EgovMap> emailList = cmmDAO.selectMailSplList(map);

		rm1000mVO.setRecmDt(EgovStringUtil.getDateMinus());
		
		model.addAttribute("emailList", emailList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("adminVO", adminVO);
		model.addAttribute("NotiPageGubun","NotiUpdate");
		model.addAttribute("rm1000mVO", rm1000mVO);
		
		return "/adm/cmm/admMailAllPop";
		
	}



		
}
