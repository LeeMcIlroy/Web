package seps.adm.userManage;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import seps.cmmn.CmmnDAO;
import seps.valueObject.UserInfoVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;
import component.web.PaginationController;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdmUserManageController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmUserManageController.class);
	
	@Resource View jsonView;
	@Autowired AdmUserManageDAO dao;
	@Autowired CmmnDAO cmmnDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/adm/userManage/userManageList.do";
	}
	
	// 사용자관리 화면
	@RequestMapping("/adm/userManage/userManageList.do")
	public String userManageList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/userManage/userManageList.do - 사용자관리 화면");
		if(session != null) session.setAttribute("leftMeneNo", "201");
		session.setAttribute("adminPage", "Y");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		
		CmmnListVO listVO = dao.selectUserManageList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/userManage/userManageList";
	}
	
	// 사용자관리 조회화면
	@RequestMapping("/adm/userManage/userManageView.do")
	public String userManageView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String userInfoId, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/userManage/userManageView.do - 사용자관리 조회화면");
		LOGGER.debug("userInfoId > " + userInfoId);
		UserInfoVO returnVO = dao.selectUserManageView(userInfoId);
		returnVO.setMenuIds(cmmnDAO.selectAuthListOne(userInfoId));
		model.addAttribute("userInfoVO", returnVO );
		model.addAttribute("menuList", cmmnDAO.selectAuthList());
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/userManage/userManageView";
	}
	
	// 사용자관리 등록 화면
	@RequestMapping("/adm/userManage/userManageModify.do")
	public String userManageModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String userInfoId, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/userManage/userManageModify.do - 사용자관리 등록&수정 화면");
		UserInfoVO returnVO  = new UserInfoVO();
		if(!EgovStringUtil.isEmpty(userInfoId)){
			returnVO = dao.selectUserManageView(userInfoId);
			returnVO.setMenuIds(cmmnDAO.selectAuthListOne(userInfoId));
		}
		model.addAttribute("userInfoVO", returnVO );
		model.addAttribute("menuList", cmmnDAO.selectAuthList());
		model.addAttribute("searchVO", searchVO);
		return "/adm/userManage/userManageModify";
	}
	
	
	// 사용자관리 등록 처리
	@RequestMapping("/adm/userManage/userManageSubmit.do")
	public String userManageSubmit(@ModelAttribute("searchVO") CmmnSearchVO searchVO, UserInfoVO paramVO, ModelMap model, HttpSession session, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/userManage/userManageSubmit.do - 사용자관리 등록&수정 처리");
		LOGGER.debug("paramVO >> " +paramVO.toString());
		String message = "등록되었습니다";
		
		//아이디 소문자로 변경
		paramVO.setUserId(paramVO.getUserId().toLowerCase());
		paramVO.setUserPw(paramVO.getUserPw().toLowerCase());
		
		if(!EgovStringUtil.isEmpty(paramVO.getUserPw())){
			String encryptPw = EgovFileScrty.encryptPassword(paramVO.getUserPw(), paramVO.getUserId());
			paramVO.setUserPw(encryptPw);
		}
		
		if(EgovStringUtil.isEmpty(paramVO.getUserInfoId())){
			//신규
			dao.insertUserManage(paramVO);
		}else{
			//수정
			dao.updateUserManage(paramVO);
			message = "수정되었습니다.";
		}
		
		/*권한 삭제후 등록*/
		cmmnDAO.deleteAuth(paramVO);
		cmmnDAO.insertAuth(paramVO);
		
		return redirectListPage( message, searchVO, reda);
	}
	
	/**
	 * 아이디 중복확인
	 * @param Strring
	 * @return
	 */
	@RequestMapping("/adm/userManage/ajaxUserManageCheck.do")
	public View admUserIdCheck(String userId, ModelMap model){
		LOGGER.info("/adm/userManage/ajaxUserManageCheck.do - 관리자등록 중복확인");
		
		String result = dao.selectAdmUserManageIdCheck(userId);
		
		if("1".equals(result)){
			model.addAttribute("result", "Y");
		}else{
			model.addAttribute("result", "N");
		}
		
		return jsonView;
	}
	
	// 사용자 삭제
	@RequestMapping("/adm/userManage/userManageDelete.do")
	public String userManageDelete(@RequestParam String userInfoId, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/userManage/userManageDelete.do - 관리자 > 사용자관리 > 사용자관리 - 삭제");
		LOGGER.debug("userInfoId = {}", userInfoId);
		
		// 권한 삭제 - start
		UserInfoVO paramVO = new UserInfoVO();
		paramVO.setUserInfoId(userInfoId);
		cmmnDAO.deleteAuth(paramVO);
		// 권한 삭제 - end
		
		dao.deleteUserManage(userInfoId);
		return redirectListPage("삭제되었습니다.", searchVO, reda);
	}
	
}
