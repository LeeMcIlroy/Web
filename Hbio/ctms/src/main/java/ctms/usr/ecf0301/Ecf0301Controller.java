package ctms.usr.ecf0301;

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

import component.file.CmmnFileMngUtil;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Ecf0301Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ecf0301Controller.class);
	@Autowired private Ecf0301DAO ecf0301DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		
	/**
	 * 설문참여 목록
	 * 
	 * @param model
	 * @return 설문참여 목록화면
	 * @throws Exception
	 */	
	
	@RequestMapping("/usr/ecf0301/ecf0301List.do")
	public String ech0301List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/usr/ecf0301/ecf0301List.do -  설문참여 목록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		//회사코드 설정
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedCorpCd());
		
		Sb1000mVO sessionVO = (Sb1000mVO) EgovUserDetailsHelper.getAuthenticatedUser();
		List<EgovMap> rsList = ecf0301DAO.selectEcf0301RsList(sessionVO);
		model.addAttribute("rsList", rsList);
		
		if(!EgovStringUtil.isEmpty(searchVO.getRsNo())){
			searchVO.setRsjNo(sessionVO.getRsjNo());
			List<EgovMap> resultList = ecf0301DAO.selectEcf0301List(searchVO);
			model.addAttribute("resultList", resultList);
		}
		
		return "/usr/ecf0301/ecf0301List";
		
	}

}
