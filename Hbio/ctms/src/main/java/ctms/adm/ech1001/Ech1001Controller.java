package ctms.adm.ech1001;

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
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech1001Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech1001Controller.class);
	@Autowired private Ech1001DAO ech1001DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
			
	
	//로그인화면으로 리다이렉트합니다.
	//private String redirectLoginView(RedirectAttributes reda, String message){
		//reda.addFlashAttribute("message", message);
		//return "redirect:/qxsepmny/lgn/admLoginView.do";
	//}
	
	/**
	 * 관리자 코딩 화면으로 이동합니다.
	 * @param model
	 * @return 코딩 화면
	 * @throws Exception
	 */
	// ********************************(피험자관리) 20201203 관리자 피험자관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech1001/ech1001List.do")	
	public String ech1001List(String corpCd, String rsNo, String search1, String search2, String search3, String search4, Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech1001/ech1001List.do - 피험자관리 피험자관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		//회사(CTMS운영)코드 설정
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		//연구과제의 모집성별, 모집나이 제한 
		if(!EgovStringUtil.isEmpty(searchVO.getRsNo())) {
			EgovMap map = new EgovMap(); 
			map.put("corpCd", searchVO.getCorpCd()); 
			map.put("rsNo", searchVO.getRsNo()); 
			
			rs1010mVO = ech1001DAO.selectEch1001RsView(rs1010mVO);
			
			if(rs1010mVO.getAgeSt().isEmpty()) {
				searchVO.setSearchCondition5("0");
			}else {
				searchVO.setSearchCondition5(rs1010mVO.getAgeSt());
			}
			if(rs1010mVO.getAgeEn().isEmpty()) {
				searchVO.setSearchCondition6("99");
			}else {
				searchVO.setSearchCondition6(rs1010mVO.getAgeEn());
			}
			if(rs1000mVO.getGenYn().equals("1")) { 
				searchVO.setSearchCondition1("1");
			}else { 
				if(rs1000mVO.getGenYn().equals("2")) {
					searchVO.setSearchCondition1("2"); 
				}else { 
					searchVO.setSearchCondition1("");
				} 
			}
		}
		
		// 피험자중복선정 방지-이미 해당 연구과제에 선정된 인원은 제외해야 한다  
		CmmnListVO listVO = ech1001DAO.selectEch1001List(searchVO); 
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech1001/ech1001List";
	}
	

	// 연구대상자선정 일괄등록
	@RequestMapping("/qxsepmny/ech1001/ech1001RsiCodeBat.do")
	public String ech0102RsiCodeBat(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String[] rsjSeq, Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, Rs2000mVO rs2000mVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech1001/ech1001RsiCodeBat.do - 연구대상자선정 일괄등록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		String date = EgovStringUtil.getDateMinus();
		String message = "";
		String success = "";
		
		EgovMap map = new EgovMap();
		map.put("corpCd", searchVO.getCorpCd());
		map.put("rsNo", searchVO.getRsNo());
		map.put("rsjSeq", rsjSeq);
		
		// 선정대상자 정보 검색 
		List<Sb1000mVO> resultList = ech1001DAO.selectEch1001RsiCodeBat(map);
		
		// 연구과제 정보 검색
		rs1010mVO.setCorpCd(searchVO.getCorpCd());
		rs1010mVO.setRsNo(searchVO.getRsNo());
		rs1010mVO = ech1001DAO.selectEch1001RsView(rs1010mVO);
		LOGGER.debug("rs1010mVO = " + rs1010mVO.toString());
		
		if(resultList.size() != 0){
			for(Sb1000mVO sb1000mVO : resultList){
				if(!EgovStringUtil.isEmpty(sb1000mVO.getRsjNo())){
					
					// 연구대상자선정을 등록
					rs2000mVO.setCorpCd(sb1000mVO.getCorpCd());
					rs2000mVO.setRsNo(searchVO.getRsNo());
					rs2000mVO.setAppYn("N");
					rs2000mVO.setFirstSt("N");
					rs2000mVO.setCfmYn("N");					
					rs2000mVO.setPoolYn("Y");
					rs2000mVO.setRsiNo1(rs1010mVO.getRsNo5()+rs1010mVO.getRsNo6());
					LOGGER.debug("rs1010mVO.getRsNo5() = " + rs1010mVO.getRsNo5());
					LOGGER.debug("rs1010mVO.getRsNo6() = " + rs1010mVO.getRsNo6());
					//rs2000mVO.setRsiNo2(rs1000mVO.getRsNo7());
					rs2000mVO.setRsjNo(sb1000mVO.getRsjNo());
					rs2000mVO.setAppstaCls("10");
					rs2000mVO.setAppStdt(rs1010mVO.getRsStdt());
					rs2000mVO.setAppEndt(rs1010mVO.getRsEndt());
					rs2000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
					rs2000mVO.setRsCd(rs1010mVO.getRsCd());
					
					ech1001DAO.insertEch1001Sub(rs2000mVO);
					
					message = "연구대상자 선정 일괄등록이 완료되었습니다.";
					success = "true";
				}
			}
		}else{
			message = "선정할 연구대상자가 없습니다.";
			success = "false";
		}
		
		return redirectListM(reda, message, success);
	}
	
	// 연구대상자선정 목록화면 리다이렉트
	private String redirectListM(RedirectAttributes reda, String message, String success){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("success", success);
		return "redirect:/qxsepmny/ech1001/ech1001List.do";
	}	
}
