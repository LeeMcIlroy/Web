package hsDesign.adm.siteMng.admin;

import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.AdminVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

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

import component.web.PaginationController;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdmAdminController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmAdminController.class);
	@Autowired private AdmAdminDAO admAdminDAO;

	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	@Resource View jsonView;
	//관리자목록화면으로 리다이렉트합니다.
	private String redirectAdminList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxerpynm/siteMng/admin/admAdminList.do";
	}
	
	//일반관리자 관리화면으로 리다이렉트합니다.
	private String redirectAdminUserModify(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxerpynm/siteMng/admin/admUserModify.do";
	}

	/**
	 * 관리자목록 화면으로 이동합니다.
	 * @param model
	 * @return 관리자목록화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/admin/admAdminList.do")
	public String admAdminList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/admin/admAdminList.do - 관리자목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "601");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO result = admAdminDAO.selectAdmAdminList(searchVO);
		paginationInfo.setTotalRecordCount(result.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", result.getEgovList());
		
		// 로그등록
		admLogInsert(null, "관리자", "목록", request);
		
		return "/adm/siteMng/admin/admAdminList";
	}
	
	/**
	 * 관리자 등록&수정 화면으로 이동합니다.
	 * @param model
	 * @return 관리자 등록&수정 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/admin/admAdminModify.do")
	public String admAdminModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String admSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/admin/admAdminList.do - 관리자목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("admSeq = "+admSeq);
		
		if(admSeq.equals("0")){
			LOGGER.debug("신규 등록");
			model.addAttribute("adminVO", new AdminVO());
		}else{
			LOGGER.debug("수정 조회");
			AdminVO paramVO = admAdminDAO.selectAdmAdminOne(admSeq);
			if(paramVO.getAdmId().equals("admin")){
				model.addAttribute("system", "Y");
			}else{
				model.addAttribute("system", "N");
			}
			model.addAttribute("adminVO", paramVO);
		}
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/siteMng/admin/admAdminModify";
	}
	
	
	/**
	 * 관리자 등록&수정
	 * @param model
	 * @return 관리자 등록&수정 
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/admin/admAdminUpdate.do")
	public String admAdminUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, AdminVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/admin/admAdminList.do - 관리자목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		String message="";
		if(EgovStringUtil.isEmpty(paramVO.getAdmSeq())){
			LOGGER.debug("신규 등록");
			String result = admAdminDAO.selectAdmAdminIdCheck(paramVO);
			
			if("1".equals(result)){
				message = "관리자 등록에 실패했습니다. 아이디 중복확인을 해주세요.";
			}else{
				paramVO.setAdmPwd("qwer$1234");
				admAdminDAO.insertAdmAdmin(paramVO);
				message = "신규 관리자가 등록되었습니다.";
				
				// 로그등록
				admLogInsert(null, "관리자 등록", paramVO.getAdmId(), request);
			}
		}else{
			LOGGER.debug("수정");
			if(!EgovStringUtil.isEmpty(paramVO.getAdmPwd())){
				System.out.println("비밀번호 수정");
				String encryptPw = EgovFileScrty.encryptPassword(paramVO.getAdmPwd(), paramVO.getAdmId());
				paramVO.setAdmPwd(encryptPw);
			}
			
			String sessionId = EgovUserDetailsHelper.getAuthenticatedAdminId();
			if(sessionId.equals("admin")){
				admAdminDAO.updateAdmSystemAdmin(paramVO);
			}else{
				admAdminDAO.updateAdmNomalAdmin(paramVO);
			}
			message = "관리자가 수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "관리자 수정", paramVO.getAdmId(), request);
		}
		
		return redirectAdminList(reda, message);
	}
	
	
	@RequestMapping("/qxerpynm/siteMng/admin/admAdminPwdClear.do")
	public String admAdminPwdClear(@ModelAttribute("searchVO") CmmnSearchVO searchVO, AdminVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/admin/admAdminList.do - 관리자목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		paramVO.setAdmPwd(EgovFileScrty.encryptPassword("qwer$1234", paramVO.getAdmId()));
		admAdminDAO.updateAdmPwdClear(paramVO);
		
		// 로그등록
		admLogInsert(null, "관리자 비밀번호 초기화", paramVO.getAdmId(), request);
		
		return redirectAdminList(reda, paramVO.getAdmId()+"의 비밀번호가 초기화되었습니다.");
	}
	
	/**
	 * 관리자 등록 아이디 중복확인
	 * @param paramVO
	 * @return
	 */
	@RequestMapping("/qxerpynm/siteMng/admin/ajaxAdmAdminIdCheck.do")
	public View admAdminIdCheck(AdminVO paramVO, ModelMap model){
		LOGGER.info("/qxerpynm/siteMng/admin/ajaxAdmAdminIdCheck.do - 관리자등록 중복확인");
		LOGGER.debug("paramVO : " + paramVO.toString());
		
		String result = admAdminDAO.selectAdmAdminIdCheck(paramVO);
		
		if("1".equals(result)){
			model.addAttribute("result", "Y");
		}else{
			model.addAttribute("result", "N");
		}
		
		return jsonView;
	}
	
	/**
	 * 일반 관리자 수정 화면으로 이동합니다.
	 * @param model
	 * @return 관리자 등록&수정 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/admin/admUserModify.do")
	public String admUserModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO,  HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/admin/admUserModify.do - 일반 관리자 수정 화면");
		LOGGER.debug("searchVO = "+searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "701");
		
		AdminVO paramVO  = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		model.addAttribute("adminVO", admAdminDAO.selectAdmAdminOne(paramVO.getAdmSeq()));
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/siteMng/admin/admUserModify";
	}
	
	/**
	 * 일반 관리자 수정.
	 * @param model
	 * @return 관리자 등록&수정 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/admin/admUserUpdate.do")
	public String admUserUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, AdminVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/admin/admUserUpdate.do - 일반 관리자 수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		String message="";
		LOGGER.debug("수정");
		if(!EgovStringUtil.isEmpty(paramVO.getAdmPwd())){
			String encryptPw = EgovFileScrty.encryptPassword(paramVO.getAdmPwd(), paramVO.getAdmId());
			paramVO.setAdmPwd(encryptPw);
		}
		
		admAdminDAO.updateAdmNomalAdmin(paramVO);
		message = "관리자가 수정되었습니다.";
		
		// 로그등록
		admLogInsert(null, "관리자 수정", paramVO.getAdmId(), request);
		
		return redirectAdminUserModify(reda, message);
	}
}
