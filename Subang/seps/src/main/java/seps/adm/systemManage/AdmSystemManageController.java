package seps.adm.systemManage;

import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import seps.cmmn.CmmnDAO;
import seps.valueObject.AuthVO;
import seps.valueObject.UserInfoVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;

@Controller
public class AdmSystemManageController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmSystemManageController.class);
	
	@Resource View jsonView;
	@Autowired AdmSystemManageDAO dao;
	@Autowired CmmnDAO cmmnDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/adm/systemManage/systemManageList.do";
	}
	
	/**
	 * 관리자관리 목록 화면
	 * @param searchVO
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/systemManage/systemManageList.do")
	public String systemManageList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/systemManage/systemManageList.do - 관리자관리 목록 화면");
		if(session != null) session.setAttribute("leftMeneNo", "501");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		
		CmmnListVO listVO = dao.selectSystemManageList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/systemManage/systemManageList";
	}
	
	/**
	 * 관리자관리 조회화면
	 * @param searchVO
	 * @param model
	 * @param userInfoId
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping("/adm/systemManage/systemManageView.do")
	public String systemManageView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String userInfoId, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/systemManage/systemManageView.do - 관리자관리 조회화면");
		
		model.addAttribute("userInfoVO", dao.selectSystemManageView(userInfoId));
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/systemManage/systemManageView";
	}
	
	/**
	 *  관리자관리 등록 화면
	 * @param searchVO
	 * @param userInfoId
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/systemManage/systemManageModify.do")
	public String systemManageModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String userInfoId, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/systemManage/systemManageModify.do - 관리자관리 등록&수정 화면");
		
		//model.addAttribute("menuList", cmmnDAO.selectAuthList());
		if(EgovStringUtil.isEmpty(userInfoId)){
			model.addAttribute("userInfoVO", new UserInfoVO());
		}else{
			model.addAttribute("userInfoVO", dao.selectSystemManageView(userInfoId));
		}
		model.addAttribute("searchVO", searchVO);
		return "/adm/systemManage/systemManageModify";
	}
	
	
	/**
	 *  관리자관리 등록&수정 처리
	 * @param searchVO
	 * @param paramVO
	 * @param model
	 * @param session
	 * @param request
	 * @param reda
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/systemManage/systemManageSubmit.do")
	public String systemManageSubmit(@ModelAttribute("searchVO") CmmnSearchVO searchVO, UserInfoVO paramVO, ModelMap model, HttpSession session, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/systemManage/systemManageSubmit.do - 관리자관리 등록&수정 처리");
		LOGGER.debug("paramVO >> " +paramVO.toString());
		String message = "등록되었습니다";
		
		// 연락처 & 이메일 set - start
		paramVO.setUserTel(ComStringUtil.setTelFormat(paramVO.getUserTel1(), paramVO.getUserTel2(), paramVO.getUserTel3()));
		if(!EgovStringUtil.isEmpty(paramVO.getUserMail1()) && !EgovStringUtil.isEmpty(paramVO.getUserMail2())){
			paramVO.setUserMail(ComStringUtil.setEmailFormat(paramVO.getUserMail1(), paramVO.getUserMail2()));
		}
		// 연락처 & 이메일 set - end

		//계정정보 소문자로 변경
		paramVO.setUserId(paramVO.getUserId().toLowerCase());
		paramVO.setUserPw(paramVO.getUserPw().toLowerCase());
		
		if(EgovStringUtil.isEmpty(paramVO.getUserInfoId())){
			//신규
			String encryptPw = EgovFileScrty.encryptPassword(paramVO.getUserPw(), paramVO.getUserId());
			paramVO.setUserPw(encryptPw);
			
			paramVO.setUserInfoId(dao.insertSystemManage(paramVO));
			/*관리자는 모든접근권한 부여*/
			List<String> menuIds = new ArrayList<>();
			List<AuthVO> authList = cmmnDAO.selectAuthList();
			for(AuthVO vo : authList){
				menuIds.add(vo.getAuthId());
			}
			paramVO.setMenuIds(menuIds);
			cmmnDAO.insertAuth(paramVO);
		}else{
			//수정
			if(!EgovStringUtil.isEmpty(paramVO.getUserPw())){
				String encryptPw = EgovFileScrty.encryptPassword(paramVO.getUserPw(), paramVO.getUserId());
				paramVO.setUserPw(encryptPw);
			}
			
			dao.updateSystemManage(paramVO);
			message = "수정되었습니다.";
		}
		
		
		return redirectListPage( message, searchVO, reda);
	}
	
	/**
	 *  관리자관리 삭제 처리
	 * @param searchVO
	 * @param userInfoId
	 * @param model
	 * @param session
	 * @param request
	 * @param reda
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/systemManage/systemManageDelete.do")
	public String systemManageDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String userInfoId, ModelMap model, HttpSession session, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/systemManage/systemManageSubmit.do - 관리자관리 삭제 처리");

		//권한 삭제후 계정 삭제
		UserInfoVO deleteVO = new UserInfoVO();
		deleteVO.setUserInfoId(userInfoId);
		cmmnDAO.deleteAuth(deleteVO);
		dao.deleteSystemManage(userInfoId);
		return redirectListPage( "삭제되었습니다", searchVO, reda);
	}
	
	
	/**
	 * 아이디 중복확인
	 * @param Strring
	 * @return
	 */
	@RequestMapping("/adm/systemManage/ajaxSystemManageCheck.do")
	public View admAdminIdCheck(String userId, ModelMap model){
		LOGGER.info("/adm/systemManage/ajaxSystemManageCheck.do - 관리자등록 중복확인");
		
		String result = dao.selectAdmSystemManageIdCheck(userId);
		
		if("1".equals(result)){
			model.addAttribute("result", "Y");
		}else{
			model.addAttribute("result", "N");
		}
		
		return jsonView;
	}
	
	/**
	 * 데이터연계현황 조회
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/systemManage/apiStatusView.do")
	public String apiStatusView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/adm/systemManage/apiStatusView.do - 관리자 > 운영관리 > 데이터연계현황");
		if(session != null) session.setAttribute("leftMeneNo", "502");
		model.addAttribute("resultList", dao.selectApiStatusList());
		return "/adm/systemManage/apiStatusView";
	}
}
