package ctms.adm.ech0104;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
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
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.Rs5020mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0104Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0104Controller.class);
	@Autowired private Ech0104DAO ech0104DAO;
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
	
	
	// ******************************** 20201228 관리자 IRB심의관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0104/ech0104List.do")	
	public String ech0104List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0104/ech0104List.do - IRB심의관리 목록화면");
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
		CmmnListVO listVO = ech0104DAO.selectEch0104List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0104/ech0104List";
	}
	
	// ********************************(연구관리) 20201228 관리자 IRB심의관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0104/ech0104View.do")
	public String ech0104View(@ModelAttribute CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, Rs5000mVO rs5000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0104/ech0104View.do - 연구관리 IRB심의관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		String message = "";
		
		rs1000mVO =  ech0104DAO.selectEch0104RsView(rs1000mVO);
		
		rs5000mVO =  ech0104DAO.selectEch0104View(rs5000mVO);

		
		//IRB심의정보가 없는 경우 등록화면으로 전환
		if (rs5000mVO == null) {
			//model.addAttribute("NotiPageGubun","NotiRegist");			
			message = "IRB심의정보를 등록해주세요.";
			//String rsNo = rs1000mVO.getRsNo();	
			String rsNo = searchVO.getRsNo();
			LOGGER.debug("rsNo"+rsNo);
			return redirectModify(reda, message, rsNo);
		}
		
		//첨부파일 확인 
		EgovMap map = new EgovMap();
		//map.put("boardSeq", rs5000mVO.getCorpCd()+rs5000mVO.getRsNo()+rs5000mVO.getRvNo());
		map.put("boardSeq", rs5000mVO.getRsNo());
		map.put("boardType", "IRB");

		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);

		EgovMap attachMap = new EgovMap();
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);		
		}
		model.addAttribute("attachMap", attachMap);

		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("rs5000mVO", rs5000mVO);		
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
										
		return "/adm/ech0104/ech0104View";
	}	

	// ********************************(연구관리) 20201228 관리자 IRB심의관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0104/ech0104Modify.do")
	public String ech0104Modify(@ModelAttribute("rs5000mVO") Rs5000mVO rs5000mVO, Rs1000mVO rs1000mVO, String rsNo, HttpServletRequest request, RedirectAttributes reda, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0104/ech0104Modify.do - 관리자 IRB심의관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		
		// 회사코드 설정 
		rs5000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd()); 
		LOGGER.debug("==============================================");
		LOGGER.debug("rsNo"+rsNo);
		LOGGER.debug("rs1000mVO"+rs1000mVO.toString());
		LOGGER.debug("rs5000mVO"+rs5000mVO.toString());
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");	 		 	
	 	
	 	rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	 	rs1000mVO.setRsNo(rs5000mVO.getRsNo());
		
	 	rs1000mVO =  ech0104DAO.selectEch0104RsView(rs1000mVO);
	 	
	 	//첨부파일 확인
	 	EgovMap mapSelect = new EgovMap();
		mapSelect.put("rsNo",rs1000mVO.getRsName());
		
		List<Rs5020mVO> rs5020mVO = ech0104DAO.selectEch0104selectbox(mapSelect);
		EgovMap attachMapSelect = new EgovMap();
		
		for(Rs5020mVO attach : rs5020mVO){
			attachMapSelect.put(attach.getRptCls(), attach);
		}
		
		model.addAttribute("rs5020mVO", attachMapSelect);
	
		EgovMap map = new EgovMap();
		
		//map.put("boardSeq",  rs5000mVO.getCorpCd()+rs5000mVO.getRsNo()+rs5000mVO.getRvNo());
		map.put("boardSeq",  rs5000mVO.getRsNo());
		map.put("boardType", "IRB");
		

		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);

		EgovMap attachMap = new EgovMap();
		
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}
		
		model.addAttribute("attachMap", attachMap);
		//첨부파일 확인
	 	
	 	//등록화면으로
	 	if (EgovStringUtil.isEmpty(rs5000mVO.getRvNo())) {
			
			//model.addAttribute("adminVO", adminVO);
	 		//RV_NO1 획득 CT1000M 참고 
	 		rs5000mVO.setRvNo1(adminVO.getRvNo1());
			model.addAttribute("NotiPageGubun","NotiRegist");
			model.addAttribute("rs5000mVO", rs5000mVO);
			model.addAttribute("rs1000mVO", rs1000mVO);
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(rs5000mVO.getRvNo())){
						
				rs5000mVO = ech0104DAO.selectEch0104View(rs5000mVO);
							
				model.addAttribute("NotiPageGubun","NotiUpdate");
				model.addAttribute("rs5000mVO", rs5000mVO);
				model.addAttribute("rs1000mVO", rs1000mVO);
				
		}
			
			return "/adm/ech0104/ech0104Modify";
	}

	// ********************************(연구관리) 20201128 관리자 IRB심의관리 저장 ********************************
	@RequestMapping("/qxsepmny/ech0104/ech0104Update.do")
	public String ech0104Save(@ModelAttribute("rs5000mVO") Rs5000mVO rs5000mVO, Rs5020mVO rs5020mVO, String[] delFile , String[]rptName, String[] rptNo, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0104/ech0104Update.do - 관리자 IRB심의관리 저장");
		String message = "";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드(CTMS운영) 설정
		rs5000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		// 등록수정자 설정
		rs5000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		LOGGER.debug("==============================================");
		LOGGER.debug(rs5000mVO.toString());
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "IRB");
		
		if(delFile != null){
			for(String seq : delFile){
				Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
				cmmDAO.deleteAttachFile(delAttach.getAttachNo());
				fileUtil.deleteFile(delAttach.getRegFileName());
			}
		}
		
		if(rptNo != null){
			for(String rptSeq : rptNo){
				Rs5020mVO delData = ech0104DAO.selectReportOne(rptSeq);
				ech0104DAO.deleteReportTable(rptSeq);
			}
		}
		
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("IRB");//폴더명
				attachVO.setBoardNo(rs5000mVO.getRsNo()); //연구번호 
				attachVO.setFileKey(fileInfoVO.getFileKey()); //파일명 네임값도 컬럼에넣기(삭제하거나 리스트출력시 키값사용)
				
				rs5020mVO.setRsNo(rs5000mVO.getRsNo());
				rs5020mVO.setCorpCd(adminVO.getCorpCd()); //회사코드
				rs5020mVO.setBranchCd(adminVO.getBranchCd()); //지사코드
				rs5020mVO.setRptCls(attachVO.getFileKey());//파일테이블에 키값
				rs5020mVO.setDataRegnt(adminVO.getAdminId()); //로그인아이디
				ech0104DAO.insertEch0104report(rs5020mVO);
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		if(EgovStringUtil.isEmpty(rs5000mVO.getRvNo())){
		    
			//작성자 안에 세션 name 입력
			//noticeVO.setNoti_writer(adminVO.getName());
			rs5000mVO.setRvNo(rs5000mVO.getRvNo1()+rs5000mVO.getRvNo2()+rs5000mVO.getRvNo3()+rs5000mVO.getRvNo4()+rs5000mVO.getRvNo5());
			
			
			ech0104DAO.insertEch0104(rs5000mVO);
			
			message = "등록이 완료되었습니다.";

		}else{
			
			ech0104DAO.updateEch0104(rs5000mVO);

			
			message = "수정이 완료되었습니다.";			
			}
	
		//심의결과가 승인인 경우 해당 연구과제를 진행상태로 변경한다.
		//연구과제, 참여지사, 참여자 
		//단, 예정인 경우만 변경 
		if(rs5000mVO.getRvRs().equals("1")) {
			ech0104DAO.updateEch0104RvRs(rs5000mVO);
			ech0104DAO.updateEch0104BrSt(rs5000mVO);
			ech0104DAO.updateEch0104EmpSt(rs5000mVO);
		}
		
		return redirectList(reda, message);

	}

	// ********************************(연구관리) 20201228 관리자 IRB심의관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0104/ech0104Delete.do")
	public String ech0104Delete(@ModelAttribute Rs5000mVO rs5000mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0104/ech0104Delete.do - 관리자 IRB심의관리 삭제");
		String message = "";
		
		//IRBM심의관리 삭제
		if(!EgovStringUtil.isEmpty(rs5000mVO.getRvNo())){
		
			ech0104DAO.deleteEch0104(rs5000mVO);
		
			message = "IRB심의정보가 삭제되었습니다.";
		}
		return redirectList(reda, message);

	}

	// IRB심의관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0104/ech0104List.do";
	}
	
	// IRB심의관리 등록/수정화면으로 리다이렉트
		private String redirectModify(RedirectAttributes reda, String message, String rsNo) {
			reda.addFlashAttribute("message", message);
			reda.addFlashAttribute("rsNo", rsNo);
			return "redirect:/qxsepmny/ech0104/ech0104Modify.do";
	}

	// IRB심의관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0104/ech0104Excel.do")
	public void ech0104Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0104/ech0104Excel.do - IRB심의관리 목록 엑셀 다운로드");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0104DAO.selectEch0104Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "IRB심의 리스트", "ech0104", request, response);
	}
		
		
}
