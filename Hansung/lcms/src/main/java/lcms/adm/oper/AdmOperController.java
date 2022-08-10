package lcms.adm.oper;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.excel.ExcelUtil;
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;
import lcms.valueObject.AdminVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmOperController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmOperController.class);
	@Autowired private AdmOperDAO admOperDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private View jsonView;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//로그인화면으로 리다이렉트합니다.
	private String redirectAdminList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/oper/admAdminList.do";
	}
	
	//프로필화면으로 리다이렉트합니다.
	private String redirectAdminProfile(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/oper/admAdminProfileView.do";
	}
	
	// 관리자 사용자관리 목록화면
	@RequestMapping("/qxsepmny/oper/admAdminList.do")
	public String admAdminList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/oper/admAdminList.do - 관리자 사용자관리 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "701");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admOperDAO.selectAdmAdminList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/oper/admAdminList";
	}
	
	// 관리자 사용자관리 조회화면
	@RequestMapping("/qxsepmny/oper/admAdminView.do")
	public String admAdminView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String adminId, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/oper/admAdminView.do - 관리자 사용자관리 조회화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		LOGGER.debug("adminId = " + adminId);
		request.getSession().setAttribute("admMenuNo", "701");
		
		AdminVO adminVO = admOperDAO.selectAdmAdminView(adminId);
		model.addAttribute("adminVO", adminVO);
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(yearList.get(0));
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		return "/adm/oper/admAdminView";
	}

	// 관리자 사용자관리 등록화면
	@RequestMapping("/qxsepmny/oper/admAdminModify.do")
	public String admAdminModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/oper/admAdminModify.do - 관리자 사용자관리 등록화면");
		request.getSession().setAttribute("admMenuNo", "701");
		
		model.addAttribute("adminVO", new AdminVO());
		
		return "/adm/oper/admAdminModify";
	}

	// 관리자 사용자관리 아이디 중복체크
	@RequestMapping("/qxsepmny/oper/admAjaxAdminIdChk.do")
	public View admAjaxAdminIdChk(String adminId, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/oper/admAjaxAdminIdChk.do - 관리자 사용자관리 중복체크");
		LOGGER.debug("adminId = " + adminId);
		
		boolean status = false;
		
		if(!EgovStringUtil.isEmpty(adminId)){
			int cnt = admOperDAO.selectAdmAdminIdChk(adminId);
			if(cnt > 0){
				status = false;
			}else{
				status = true;
			}
		}
		model.addAttribute("status", status);
		
		return jsonView;
	}
	
	// 관리자 사용자관리 등록&수정
	@RequestMapping("/qxsepmny/oper/admAdminUpdate.do")
	public String admAdminUpdate(@ModelAttribute("adminVO") AdminVO adminVO, String[] acceIp, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/oper/admAdminUpdate.do - 관리자 사용자관리 등록&수정");
		request.getSession().setAttribute("admMenuNo", "701");
		String message = "";
		adminVO.setAcceIp(acceIp[0]+"."+acceIp[1]+"."+acceIp[2]+"."+acceIp[3]);
		
		if(EgovStringUtil.isEmpty(adminVO.getAdminPw())){
			admOperDAO.updateAdmin(adminVO);
			message = "수정이 완료되었습니다.";
		}else{
			adminVO.setAdminPw(EgovFileScrty.encryptPassword(adminVO.getAdminPw(), adminVO.getAdminId()));
			admOperDAO.insertAdmin(adminVO);
			message = "등록이 완료되었습니다.";
		}
		
		return redirectAdminList(reda, message);
	}
	
	// 관리자 개인정보처리(로그) 목록화면
	@RequestMapping("/qxsepmny/oper/admLogList.do")
	public String admLogList(@ModelAttribute("searchVO") CmmnSearchVO searchVO,HttpServletRequest request,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/oper/admLogList.do - 관리자 개인정보처리(로그) 목록화면");
		request.getSession().setAttribute("admMenuNo", "702");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = admOperDAO.selectAdmLogList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
				
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/oper/admLogList";
	}
	
	// 관리자 개인정보처리(로그) 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/oper/admLogExcel.do")
	public void admLogExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/oper/admLogExcel.do - 관리자 개인정보처리(로그) 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admOperDAO.selectAdmLogExcel(searchVO);
		dataMap.put("resultList", resultList);
				
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
					
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
					
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "개인정보처리(로그) 리스트", "LogList", request, response);
	}
	
	// 관리자 프로필 화면
	@RequestMapping("/qxsepmny/oper/admAdminProfileView.do")
	public String admProfileView(@ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/oper/admAdminProfileView.do - 관리자 profile 목록");
		request.getSession().setAttribute("admMenuNo", "901");
		AdminVO adminVO = ((AdminVO)session.getAttribute("adminSessionLcms")!=null)?(AdminVO)session.getAttribute("adminSessionLcms"):null;
		
		AdminVO resultVO = admOperDAO.selectAdmProfile(adminVO);
		String clientIp = ComStringUtil.getClientIP(request);
		model.addAttribute("adminVO", resultVO);
		model.addAttribute("clientIp", clientIp);
		
		return "/adm/oper/admAdminProfileView";
	}
	
	// 관리자 비밀번호 조회
	@RequestMapping("/qxsepmny/oper/admAjaxAdminPwChk.do")
	public View ajaxAdminPwChk(String adminPw, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/oper/admAjaxAdminPwChk.do - 관리자 비밀번호 조회");
		
		AdminVO adminVO = ((AdminVO)session.getAttribute("adminSessionLcms")!=null)?(AdminVO)session.getAttribute("adminSessionLcms"):null;
		AdminVO resultVO = admOperDAO.selectAdmProfile(adminVO);
		
		boolean status = false;
		
		if(!EgovStringUtil.isEmpty(adminVO.getAdminPw())){
			adminVO.setAdminPw(EgovFileScrty.encryptPassword(adminPw, adminVO.getAdminId()));
		
			int cnt = admOperDAO.selectadmAjaxAdminPwChk(adminVO);
			
			if(cnt > 0){
				status = true;
			}else{
				status = false;
			}
		}
		
		model.addAttribute("adminVO", resultVO);
		model.addAttribute("status", status);
		
		return jsonView;
	}
	
	// 관리자 비밀번호 수정
	@RequestMapping("/qxsepmny/oper/admAjaxPasswordUpdate.do")
	public String lecAjaxPasswordUpdate(@ModelAttribute("adminVO") AdminVO adminVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception{
		LOGGER.debug("/qxsepmny/oper/admAjaxPasswordUpdate.do - 관리자 비밀번호 수정");
		LOGGER.debug("adminVO = " + adminVO);
		
		String message = "";
		
		if(adminVO != null){
			adminVO.setAdminPw(EgovFileScrty.encryptPassword(adminVO.getAdminPw(), adminVO.getAdminId()));
			admOperDAO.admAjaxPasswordUpdate(adminVO);
			message = "수정이 완료 되었습니다.";
		}
		return redirectAdminProfile(reda, message);
		
	}
	
	// 관리자 비밀번호 재설정
	@RequestMapping("/qxsepmny/oper/admAjaxProfClearPw.do")
	public View admAjaxProfClearPw(AdminVO adminVO, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/oper/admAjaxProfClearPw.do - 관리자 비밀번호 재설정");
		LOGGER.debug("adminVO = " + adminVO);
		String message = "";
		if(adminVO !=null){ 
			adminVO.setAdminPw(EgovFileScrty.encryptPassword(adminVO.getAdminId(), adminVO.getAdminId()));
			admOperDAO.updateAdmAjaxProfClearPw(adminVO);
			message = "비밀번호가 초기화되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}

	// 관리자 로그인 횟수 초기화
	@RequestMapping("/qxsepmny/oper/admAjaxClearLgnFail.do")
	public View admAjaxClearLgnFail(String adminId, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/oper/admAjaxClearLgnFail.do - 관리자 로그인 횟수 초기화");
		LOGGER.debug("adminId = " + adminId);
		String message = "";
		if(!EgovStringUtil.isEmpty(adminId)){ 
			admOperDAO.updateAdmAjaxClearLgnFail(adminId);
			message = "로그인 횟수가 초기화되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
	// 관리자 접속이력 목록화면
	@RequestMapping("/qxsepmny/oper/admLoginLogList.do")
	public String admLoginLogList(@ModelAttribute("searchVO") CmmnSearchVO searchVO,HttpServletRequest request,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/oper/admLoginLogList.do - 관리자 접속이력 목록화면");
		request.getSession().setAttribute("admMenuNo", "703");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admOperDAO.selectAdmLoginLogList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
				
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/oper/admLoginLogList";
	}
	
	// 관리자 접속이력 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/oper/admLoginLogExcel.do")
	public void admLoginLogExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/oper/admLoginLogExcel.do - 관리자 접속이력 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admOperDAO.selectAdmLoginLogExcel(searchVO);
		dataMap.put("resultList", resultList);
				
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
					
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
					
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "접속이력 리스트", "LoginLogList", request, response);
	}
}
