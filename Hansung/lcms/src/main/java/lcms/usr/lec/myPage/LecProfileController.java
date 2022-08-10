package lcms.usr.lec.myPage;

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
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.adm.cmm.AdmCmmController;

import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnSearchVO;
import sun.security.x509.IPAddressName;

@Controller
public class LecProfileController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecProfileController.class);
	
	@Autowired private LecProfileDAO lecProfileDAO;
	@Resource View jsonView;
	
	// 공지사항화면로 리다이렉트합니다.
		private String redirectNoticeList(RedirectAttributes reda, String message) {
			reda.addFlashAttribute("message", message);
			return "redirect:/usr/lec/myPage/lecNoticeList.do";
		}
	
	// 교사 프로필 화면 
	@RequestMapping("/usr/lec/myPage/lecProfileView.do")
	public String lecProfileView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model, String lap) throws Exception {
		LOGGER.debug("/usr/lec/myPage/lecProfileView.do - 강사 profile 목록");
		request.getSession().setAttribute("lecMenuNo", "503");
	
		UsrVO usrVO = ((UsrVO)session.getAttribute("usrSession")!=null)?(UsrVO)session.getAttribute("usrSession"):null;
		
	    UsrVO resultVO = lecProfileDAO.selectLecProfile(usrVO);
	    
	    EgovMap lectSession = (EgovMap)session.getAttribute("lecSession");

    	String clientIp = ComStringUtil.getClientIP(request);
    	model.addAttribute("lectSession", lectSession);
    	model.addAttribute("clientIp", clientIp);
		model.addAttribute("usrVO", resultVO);
		model.addAttribute("lap", lap);
		
		return "/usr/lec/myPage/lecProfileView";
	}
	
	// 프로필 수정
	@RequestMapping("/usr/lec/myPage/lecProfileUpdate.do")
	public String lecProfileUpdate(@ModelAttribute("usrVO") UsrVO usrVO,HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception{
		LOGGER.debug("/usr/lec/myPage/lecProfileUpdate.do - 강사 profile 수정");
		request.getSession().setAttribute("lecMenuNo", "503");
		String message = "";
		
		if(!EgovStringUtil.isEmpty(usrVO.getMemberSeq())){
			lecProfileDAO.updateLecProfile(usrVO);
			message = "수정이 완료 되었습니다.";
		}
		
		return  redirectNoticeList(reda, message);
	}
	
	// 비밀번호 조회
	@RequestMapping("/usr/lec/myPage/admAjaxMemberPwChk.do")
	public View ajaxMemberPwChk(String memberPw, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception{
 		LOGGER.debug("/usr/lec/myPage/admAjaxMemberPwChk.do - 교사 비밀번호 조회");
	
		UsrVO usrVO = ((UsrVO)session.getAttribute("usrSession")!=null)?(UsrVO)session.getAttribute("usrSession"):null;
		UsrVO resultVO = lecProfileDAO.selectLecProfile(usrVO);
		
		boolean status = false;
		
		if(!EgovStringUtil.isEmpty(usrVO.getMemberPw())){
		//if(usrVO != null){
			usrVO.setMemberPw(EgovFileScrty.encryptPassword(memberPw, usrVO.getMemberCode()));
			
			int cnt = lecProfileDAO.selectadmAjaxMemberPwChk(usrVO);
		 	
			if(cnt > 0){
				status = true;
			}else{
				status = false;
			}
		}

		//}
		model.addAttribute("usrVO", resultVO);
		model.addAttribute("status", status);
		
		return jsonView;
	}	
	
	// 비밀번호 수정
	@RequestMapping("/usr/lec/myPage/lecAjaxPasswordUpdate.do")
	public String lecAjaxPasswordUpdate(@ModelAttribute("usrVO") UsrVO usrVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception{
		LOGGER.debug("/usr/lec/myPage/lecAjaxPasswordUpdate.do - 강사 비밀번호 수정");
		LOGGER.debug("usrVO = " + usrVO);
		request.getSession().setAttribute("lecMenuNo", "503");
		String message = "";
		
		if(usrVO != null){
			usrVO.setMemberPw(EgovFileScrty.encryptPassword(usrVO.getMemberPw(), usrVO.getMemberCode()));
			lecProfileDAO.lecAjaxPasswordUpdate(usrVO);
			message = "수정이 완료 되었습니다.";
		}
		return  redirectNoticeList(reda, message);
		
	}

		
	
}
