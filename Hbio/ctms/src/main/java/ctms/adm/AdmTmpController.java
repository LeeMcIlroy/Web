package ctms.adm;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.util.ComStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ctms.adm.cmm.AdmCmmController;
import ctms.valueObject.AdminVO;

@Controller
public class AdmTmpController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmTmpController.class);

	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/lgn/admLoginView.do";
	}
	
	/**
	 * 관리자 코딩 화면으로 이동합니다.
	 * @param model
	 * @return 코딩 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxsepmny/tmp/ech010101.do")
	public String ech010101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech010101.do - 관리자 코딩 화면");
		
		return "/adm/ech010101";
	}

	@RequestMapping("/qxsepmny/tmp/ech010102.do")
	public String ech010102(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech010102.do - 관리자 코딩 화면");
		
		return "/adm/ech010102";
	}

	@RequestMapping("/qxsepmny/tmp/ech010201.do")
	public String ech010201(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech010201.do - 관리자 코딩 화면");
		
		return "/adm/ech010201";
	}

	@RequestMapping("/qxsepmny/tmp/ech010202.do")
	public String ech010202(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech010202.do - 관리자 코딩 화면");
		
		return "/adm/ech010202";
	}

	@RequestMapping("/qxsepmny/tmp/ech100101.do")
	public String ech100101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech100101.do - 관리자 코딩 화면");
		
		return "/adm/ech100101";
	}

	@RequestMapping("/qxsepmny/tmp/ech100501.do")
	public String ech100501(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech100501.do - 관리자 코딩 화면");
		
		return "/adm/ech100501";
	}
	
	// 2020.11.11작업
	@RequestMapping("/qxsepmny/tmp/ech100201.do")
	public String ech100201(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech100201.do - 관리자 코딩 화면");
		
		return "/adm/ech100201";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech100202.do")
	public String ech100202(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech100202.do - 관리자 코딩 화면");
		
		return "/adm/ech100202";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech010301.do")
	public String ech010301(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech010301.do - 관리자 코딩 화면");
		
		return "/adm/ech010301";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech100301.do")
	public String ech100301(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech100301.do - 관리자 코딩 화면");
		
		return "/adm/ech100301";
	}

	@RequestMapping("/qxsepmny/tmp/ech010401.do")
	public String ech010401(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech010401.do - 관리자 코딩 화면");
		
		return "/adm/ech010401";
	}

	@RequestMapping("/qxsepmny/tmp/ech010402.do")
	public String ech010402(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech010402.do - 관리자 코딩 화면");
		
		return "/adm/ech010402";
	}

	@RequestMapping("/qxsepmny/tmp/ech020101.do")
	public String ech020101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020101.do - 관리자 코딩 화면");
		
		return "/adm/ech020101";
	}

	@RequestMapping("/qxsepmny/tmp/ech020102.do")
	public String ech020102(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020102.do - 관리자 코딩 화면");
		
		return "/adm/ech020102";
	}

	@RequestMapping("/qxsepmny/tmp/ech020201.do")
	public String ech020201(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020201.do - 관리자 코딩 화면");
		
		return "/adm/ech020201";
	}	


	@RequestMapping("/qxsepmny/tmp/ech020202.do")
	public String ech020202(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020202.do - 관리자 코딩 화면");
		
		return "/adm/ech020202";
	}

	@RequestMapping("/qxsepmny/tmp/ech020203.do")
	public String ech020203(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020203.do - 관리자 코딩 화면");
		
		return "/adm/ech020203";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020301.do")
	public String ech020301(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020301.do - 관리자 코딩 화면");
		
		return "/adm/ech020301";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020302.do")
	public String ech020302(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020302.do - 관리자 코딩 화면");
		
		return "/adm/ech020302";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020401.do")
	public String ech020401(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020401.do - 관리자 코딩 화면");
		
		return "/adm/ech020401";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020402.do")
	public String ech020402(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020402.do - 관리자 코딩 화면");
		
		return "/adm/ech020402";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020501.do")
	public String ech020501(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020501.do - 관리자 코딩 화면");
		
		return "/adm/ech020501";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020502.do")
	public String ech020502(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020502.do - 관리자 코딩 화면");
		
		return "/adm/ech020502";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020503.do")
	public String ech020503(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020503.do - 관리자 코딩 화면");
		
		return "/adm/ech020503";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020601.do")
	public String ech020601(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020601.do - 관리자 코딩 화면");
		
		return "/adm/ech020601";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020602.do")
	public String ech020602(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020602.do - 관리자 코딩 화면");
		
		return "/adm/ech020602";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020701.do")
	public String ech020701(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020701.do - 관리자 코딩 화면");
		
		return "/adm/ech020701";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020702.do")
	public String ech020702(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020702.do - 관리자 코딩 화면");
		
		return "/adm/ech020702";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech020703.do")
	public String ech020703(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech020703.do - 관리자 코딩 화면");
		
		return "/adm/ech020703";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech030101.do")
	public String ech030101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech030101.do - 관리자 코딩 화면");
		
		return "/adm/ech030101";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech030102.do")
	public String ech030102(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech030102.do - 관리자 코딩 화면");
		
		return "/adm/ech030102";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech030201.do")
	public String ech030201(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech030201.do - 관리자 코딩 화면");
		
		return "/adm/ech030201";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech030202.do")
	public String ech030202(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech030202.do - 관리자 코딩 화면");
		
		return "/adm/ech030202";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech030301.do")
	public String ech030301(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech030301.do - 관리자 코딩 화면");
		
		return "/adm/ech030301";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech030302.do")
	public String ech030302(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech030302.do - 관리자 코딩 화면");
		
		return "/adm/ech030302";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040101.do")
	public String ech040101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040101.do - 관리자 코딩 화면");
		
		return "/adm/ech040101";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040102.do")
	public String ech040102(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040102.do - 관리자 코딩 화면");
		
		return "/adm/ech040102";
	}

	@RequestMapping("/qxsepmny/tmp/ech040401.do")
	public String ech040401(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040401.do - 관리자 코딩 화면");
		
		return "/adm/ech040401";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040402.do")
	public String ech040402(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040402.do - 관리자 코딩 화면");
		
		return "/adm/ech040402";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040103.do")
	public String ech040103(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040103.do - 관리자 코딩 화면");
		
		return "/adm/ech040103";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040403.do")
	public String ech040403(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040403.do - 관리자 코딩 화면");
		
		return "/adm/ech040403";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040104.do")
	public String ech040104(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040104.do - 관리자 코딩 화면");
		
		return "/adm/ech040104";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040404.do")
	public String ech040404(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040404.do - 관리자 코딩 화면");
		
		return "/adm/ech040404";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040105.do")
	public String ech040105(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040105.do - 관리자 코딩 화면");
		
		return "/adm/ech040105";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040405.do")
	public String ech040405(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040405.do - 관리자 코딩 화면");
		
		return "/adm/ech040405";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040106.do")
	public String ech040106(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040106.do - 관리자 코딩 화면");
		
		return "/adm/ech040106";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040406.do")
	public String ech040406(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040406.do - 관리자 코딩 화면");
		
		return "/adm/ech040406";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040107.do")
	public String ech040107(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040107.do - 관리자 코딩 화면");
		
		return "/adm/ech040107";
	}

	@RequestMapping("/qxsepmny/tmp/ech040407.do")
	public String ech040407(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040407.do - 관리자 코딩 화면");
		
		return "/adm/ech040407";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech040301.do")
	public String ech040301(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech040301.do - 관리자 코딩 화면");
		
		return "/adm/ech040301";
	}
	
	
	@RequestMapping("/qxsepmny/tmp/ech050101.do")
	public String ech050101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech050101.do - 관리자 코딩 화면");
		
		return "/adm/ech050101";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech050102.do")
	public String ech050102(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech050102.do - 관리자 코딩 화면");
		
		return "/adm/ech050102";
	}

	@RequestMapping("/qxsepmny/tmp/ech050201.do")
	public String ech050201(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech050201.do - 관리자 코딩 화면");
		
		return "/adm/ech050201";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech050202.do")
	public String ech050202(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech050202.do - 관리자 코딩 화면");
		
		return "/adm/ech050202";
	}

	
	@RequestMapping("/qxsepmny/tmp/ech060101.do")
	public String ech060101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech060101.do - 관리자 코딩 화면");
		
		return "/adm/ech060101";
	}

	@RequestMapping("/qxsepmny/tmp/ech060201.do")
	public String ech060201(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech060201.do - 관리자 코딩 화면");
		
		return "/adm/ech060201";
	}

	@RequestMapping("/qxsepmny/tmp/ech060202.do")
	public String ech060202(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech060202.do - 관리자 코딩 화면");
		
		return "/adm/ech060202";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech060301.do")
	public String ech060301(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech060301.do - 관리자 코딩 화면");
		
		return "/adm/ech060301";
	}

	@RequestMapping("/qxsepmny/tmp/ech060401.do")
	public String ech060401(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech060401.do - 관리자 코딩 화면");
		
		return "/adm/ech060401";
	}

	@RequestMapping("/qxsepmny/tmp/ech060402.do")
	public String ech060402(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech060402.do - 관리자 코딩 화면");
		
		return "/adm/ech060402";
	}

	@RequestMapping("/qxsepmny/tmp/ech100401.do")
	public String ech100401(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech100401.do - 관리자 코딩 화면");
		
		return "/adm/ech100401";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech070101.do")
	public String ech070101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070101.do - 관리자 코딩 화면");
		
		return "/adm/ech0701/ech0701View";
	}

	@RequestMapping("/qxsepmny/tmp/ech070201.do")
	public String ech070201(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070201.do - 관리자 코딩 화면");
		
		return "/adm/ech070201";
	}

	@RequestMapping("/qxsepmny/tmp/ech070202.do")
	public String ech070202(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070202.do - 관리자 코딩 화면");
		
		return "/adm/ech070202";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech070301.do")
	public String ech070301(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070301.do - 관리자 코딩 화면");
		
		return "/adm/ech070301";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech070302.do")
	public String ech070302(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070302.do - 관리자 코딩 화면");
		
		return "/adm/ech070302";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech070401.do")
	public String ech070401(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070401.do - 관리자 코딩 화면");
		
		return "/adm/ech070401";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech070402.do")
	public String ech070402(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070402.do - 관리자 코딩 화면");
		
		return "/adm/ech070402";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech070501.do")
	public String ech070501(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070501.do - 관리자 코딩 화면");
		
		return "/adm/ech070501";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech070601.do")
	public String ech070601(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070601.do - 관리자 코딩 화면");
		
		return "/adm/ech070601";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech070701.do")
	public String ech070701(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070701.do - 관리자 코딩 화면");
		
		return "/adm/ech070701";
	}
	
	@RequestMapping("/qxsepmny/tmp/ech070702.do")
	public String ech070702(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/tmp/ech070702.do - 관리자 코딩 화면");
		
		return "/adm/ech070702";
	}
	
}
