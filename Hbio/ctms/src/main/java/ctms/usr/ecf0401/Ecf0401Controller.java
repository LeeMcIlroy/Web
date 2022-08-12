package ctms.usr.ecf0401;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Ecf0401Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ecf0401Controller.class);
	@Autowired private Ecf0401DAO ecf0401DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	// 시험지원 목록화면 리다이렉트
	private String redirectList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/ecf0401/ecf0401List.do";
	}	
		
	/**
	 * 시험지원 목록
	 * 
	 * @param model
	 * @return 시험지원 목록화면
	 * @throws Exception
	 */	
	
	@RequestMapping("/usr/ecf0401/ecf0401List.do")
	public String ech0401List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/usr/ecf0401/ecf0401List.do - 시험지원 목록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		//회사코드 설정
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedCorpCd());
		
		Sb1000mVO sessionVO = (Sb1000mVO) EgovUserDetailsHelper.getAuthenticatedUser();
		searchVO.setRsjNo(sessionVO.getRsjNo());
		
		List<EgovMap> resultList = ecf0401DAO.selectEcf0401List(searchVO);
		model.addAttribute("resultList", resultList);
		
		return "/usr/ecf0401/ecf0401List";
		
	}
	
	// 시험지원 등록
	@RequestMapping("/usr/ecf0401/ecf0401RsiCode.do")
	public String ecf0401RsiCode(@ModelAttribute("searchVO") CmmnSearchVO searchVO, Rs1000mVO rs1000mVO, Rs2000mVO rs2000mVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/ecf0401/ecf0401RsiCode.do - 시험지원 등록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		//회사코드 설정
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedCorpCd());
		
		String message = "";
		
		EgovMap map = new EgovMap();
		map.put("corpCd", searchVO.getCorpCd());
		map.put("rsNo", searchVO.getRsNo());
		map.put("rsjNo", EgovUserDetailsHelper.getAuthenticatedRsjNo());
		
		// 선정대상자 정보 검색 
		Sb1000mVO sb1000mVO = ecf0401DAO.selectEcf0401RsiCode(map);
		
		// 연구과제 정보 검색
		rs1000mVO.setCorpCd(searchVO.getCorpCd());
		
		//rs1000mVO.setRsNo(EgovUserDetailsHelper.getAuthenticatedRsjNo());
		rs1000mVO.setRsNo(searchVO.getRsNo());
		rs1000mVO =  ecf0401DAO.selectEcf0401RsView(rs1000mVO);		

		if(!EgovStringUtil.isEmpty(sb1000mVO.getRsjNo())){
			
			// 연구대상자선정을 등록
			rs2000mVO.setCorpCd(sb1000mVO.getCorpCd());
			rs2000mVO.setRsNo(searchVO.getRsNo());
			rs2000mVO.setAppYn("Y");
			rs2000mVO.setFirstSt("N");
			rs2000mVO.setCfmYn("N");					
			rs2000mVO.setPoolYn("N");
			rs2000mVO.setRsiNo1(rs1000mVO.getRsNo5()+rs1000mVO.getRsNo6());
			rs2000mVO.setRsiNo2(rs1000mVO.getRsNo7());
			rs2000mVO.setRsjNo(sb1000mVO.getRsjNo());
			rs2000mVO.setAppstaCls("10");
			rs2000mVO.setAppStdt(rs1000mVO.getRsStdt());
			rs2000mVO.setAppEndt(rs1000mVO.getRsEndt());
			rs2000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedUserId());
			
			ecf0401DAO.insertEcf0401Sub(rs2000mVO);
			
			message = "시험지원이 완료되었습니다.";
		}
		
		return redirectList(reda, message);
	}

}
