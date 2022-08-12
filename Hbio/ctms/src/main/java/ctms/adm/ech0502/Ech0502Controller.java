package ctms.adm.ech0502;

import java.sql.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.adm.ech0502.Ech0502Controller;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.Rs5010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.sourceforge.jtds.jdbc.DateTime;

@Controller
public class Ech0502Controller extends AdmCmmController{
	
private static final Logger LOGGER = LoggerFactory.getLogger(Ech0502Controller.class);

	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	@Autowired private Ech0502DAO ech0502DAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private ExcelUtil excelUtil;

	//로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/lgn/admLoginView.do";
	}
	//보고서 목록화면으로 리다이렉트합니다.
	private String redirectEch0502List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0502/ech0502List.do";
	}
	//보고서 등록화면으로 리다이렉트합니다.
		private String redirectEch0502Modify(RedirectAttributes reda, String message){
			reda.addFlashAttribute("message", message);
			return "redirect:/qxsepmny/ech0502/ech0502Modify.do";
		}
	/**
	 * 관리자 코딩 화면으로 이동합니다.
	 * @param model
	 * @return 코딩 화면
	 * @throws Exception
	 */
	
	@RequestMapping("/qxsepmny/ech0502/ech0502List.do")	
	public String ech0502List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO ,HttpServletResponse response) throws Exception {
		LOGGER.debug("/qxsepmny/ech0502/ech0502List.do - 보고서양식관리  목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0502DAO.selectEch0502List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		//검색항목 설정 시작
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//보고서종류(공통코드) 목록 searchCondition6
		
		List<EgovMap> ct2010 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2010");
		model.addAttribute("ct2010", ct2010);
		
		//임상분류(공통코드) 목록 searchCondition5
		List<EgovMap> ct2030 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2030");
		model.addAttribute("ct2030", ct2030);
				
		//-- 검색항목 설정 끝
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		System.out.println(listVO.toString());
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0502/ech0502List";
	}
	
	// ********************************( 관리자 보고서양식관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0502/ech0502View.do")
	public String ech0502View(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String rptNo , String rsField ,HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0502/ech0502View.do - 보고서양식관리 상세보기화면");
		LOGGER.debug("rptNo = " + rptNo);
		
			Rs5010mVO resultVO = new Rs5010mVO();
			
			
			if(!EgovStringUtil.isEmpty(rptNo)){
				resultVO = ech0502DAO.selectEch0502selectOne(Integer.parseInt(rptNo));
				
				EgovMap map = new EgovMap();
				map.put("boardSeq", resultVO.getRptNo());
				map.put("boardType", "RPTFORM");
				List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
				model.addAttribute("attachList", attachList);
				
				EgovMap attachMap = new EgovMap();
				
				for(Ct7000mVO attach : attachList){
					attachMap.put(attach.getFileKey(), attach);
				}
				
 				model.addAttribute("attachMap", attachMap);
			}else{
				String message = "존재하지 않는 연구과제입니다.";
				return redirectEch0502List(reda, message);
			}
			model.addAttribute("rs5010mVO", resultVO);

			return "/adm/ech0502/ech0502View";
	}	
	// ********************************( 관리자 보고서양식관리 등록화면********************************
	@RequestMapping("/qxsepmny/ech0502/ech0502Modify.do")
	public String ech0502Modify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String rptNo ,HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0502/ech0502Modify.do - 보고서양식관리 신규화면");
		LOGGER.debug("rptNo - 보고서양식관리 신규화면",rptNo);
		Rs5010mVO resultVO = new Rs5010mVO();
		
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		
		if(!EgovStringUtil.isEmpty(rptNo)){
			resultVO = ech0502DAO.selectEch0502selectOne(Integer.parseInt(rptNo));
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", resultVO.getRptNo());
			map.put("boardType", "RPTFORM");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
			
			EgovMap attachMap = new EgovMap();
			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);
			
		}
			
			//보고서종류 가져오기
			List<EgovMap> ct2010 = cmmDAO.selectCmmCdList(adminVO.getCorpCd(), "CT2010");
			model.addAttribute("ct2010", ct2010);
			
			//임상분류(공통코드) 목록 
			List<EgovMap> ct2030 = cmmDAO.selectCmmCdList(adminVO.getCorpCd(), "CT2030");
		    model.addAttribute("ct2030", ct2030);
		
		
		
		
		model.addAttribute("rs5010mVO", resultVO);

		return "/adm/ech0502/ech0502Modify";
	}	
	
	@RequestMapping("/qxsepmny/ech0502/ech0502Update.do" )
	public String admEch0501Update(@ModelAttribute("rs5010mVO") Rs5010mVO rs5010mVO, String[] delFile, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0502/ech0502Update.do -  보고서양식관리 수정&등록");
		LOGGER.debug("rs5010mVO = " + rs5010mVO.toString());
		String message = "";
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		if(rs5010mVO.getRptNo() == 0){
			
			if(rs5010mVO.getRptCls().equals("") || rs5010mVO.getRptfrName().equals("")){
				message = "모든 항목 작성해주셔야합니다. ";
				return redirectEch0502Modify(reda, message);
			}
			else				
			{
				rs5010mVO.setCorpCd(adminVO.getCorpCd());
				rs5010mVO.setDataRegNt(adminVO.getAdminId());
				rs5010mVO.setBranchCd(adminVO.getBranchCd());

				int rptNo = ech0502DAO.insertEch0502(rs5010mVO);
				rs5010mVO.setRptNo(rptNo);
				EgovMap map = new EgovMap();
				map.put("boardSeq", rptNo);
				map.put("boardType", "RPTFORM");
				List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
				model.addAttribute("attachList", attachList);
				
				EgovMap attachMap = new EgovMap();
				
				for(Ct7000mVO attach : attachList){
					attachMap.put(attach.getFileKey(), attach);
				}
				
				model.addAttribute("attachMap", attachMap);
				message = "등록이 완료되었습니다.";
			}
		}else{
			rs5010mVO.setRptNo(rs5010mVO.getRptNo());
			ech0502DAO.updateEch0502(rs5010mVO);
			message = "수정이 완료되었습니다.";
			if(delFile != null){
				for(String seq : delFile){
					System.out.println(seq);
					Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					cmmDAO.deleteAttachFile(delAttach.getAttachNo());
					fileUtil.deleteFile(delAttach.getRegFileName());
				}
			}
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "RPTFORM");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardNo(String.valueOf(rs5010mVO.getRptNo())); //연구번호 
				attachVO.setBoardType("RPTFORM");//폴더명
				//attachVO.setFileKey(fileInfoVO.getFileKey()); //파일명 네임값도 컬럼에넣기(삭제하거나 리스트출력시 키값사용)
				
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		return redirectEch0502List(reda, message);
	}


	@RequestMapping("/qxsepmny/ech0502/ech0502Delete.do")
	public String admEch0502Delete(@ModelAttribute("rs5010mVO") Rs5010mVO rs5010mVO, HttpServletRequest httpServletRequest, ModelMap model, RedirectAttributes reda) throws Exception{
		LOGGER.debug("/qxsepmny/ech0502/ech0502Delete.do -  보고서양식관리 첨부파일삭제");
		LOGGER.debug("rs5010mVO = " + rs5010mVO.toString());
		
		String message = "";
		if(rs5010mVO.getRptNo() !=0){
			int chk = ech0502DAO.deleteEch0502(rs5010mVO.getRptNo());
			
			if(chk > 0){
				EgovMap map = new EgovMap();
				map.put("boardSeq", rs5010mVO.getRptNo());
				map.put("boardType", "RPTFORM");
				List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
				
				for(Ct7000mVO attachVO : attachList){
					cmmDAO.deleteAttachFile(attachVO.getAttachNo());
					fileUtil.deleteFile(attachVO.getRegFileName());
				}
				
				message = "해당 연구과제의 삭제가 완료되었습니다.";
			}
		}
		
		return redirectEch0502List(reda, message);
	}
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0502/ech0502Excel.do")
	public void ech0101Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0502/ech0502Excel.do - 보고서양식 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0502DAO.selectAdmEch0502Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
	   	AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "보고서양식관리", "ech0502", request, response);
	}
}
