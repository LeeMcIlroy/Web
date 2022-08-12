package seps.cmmn;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import seps.cmmn.CmmnController;
import seps.cmmn.CmmnDAO;
import seps.cmmn.LoginDAO;
import seps.valueObject.AuthVO;
import seps.valueObject.UserInfoVO;

@Controller
public class CmmnController {
  private static final Logger LOGGER = LoggerFactory.getLogger(CmmnController.class);
  
  @Resource
  View jsonView;
  
  @Autowired
  private CmmnDAO cmmnDAO;
  
  @Autowired
  private LoginDAO loginDAO;
  
  @RequestMapping({"/loginView.do"})
  public String loginView(HttpSession session) throws Exception {
    LOGGER.info("/loginView.do - 로그인 화면");
    session.setAttribute("adminPage", "N");
    if (EgovUserDetailsHelper.isAuthenticatedUser().booleanValue())
      return "redirect:/usr/dashboard/main.do"; 
    return "/loginView";
  }
  
  @RequestMapping({"/login.do"})
  public String tmpLogin(UserInfoVO userInfoVO, HttpSession session, RedirectAttributes reda) throws Exception {
    LOGGER.info("/login.do - 로그인");
    if (EgovStringUtil.isEmpty(userInfoVO.getUuid()) && (EgovStringUtil.isEmpty(userInfoVO.getUserId()) || EgovStringUtil.isEmpty(userInfoVO.getUserPw()))) {
      LOGGER.warn("아이디 or 비밀번호를 입력하지 않았습니다.");
      reda.addFlashAttribute("message", "로그인 정보가 없습니다.\n아이디와 비밀번호를 확인해주세요.");
      reda.addFlashAttribute("autoLogin", "N");
      return "redirect:/loginView.do";
    } 
    userInfoVO.setUserId(userInfoVO.getUserId().toLowerCase());
    userInfoVO.setUserPw(userInfoVO.getUserPw().toLowerCase());
    String encryptPw = EgovFileScrty.encryptPassword(userInfoVO.getUserPw(), userInfoVO.getUserId());
    userInfoVO.setUserPw(encryptPw);
    UserInfoVO resultVO = this.loginDAO.actionLogin(userInfoVO);
    if (resultVO == null) {
      LOGGER.warn("로그인 정보가 없습니다.");
      reda.addFlashAttribute("message", "로그인 정보가 없습니다.\n아이디와 비밀번호를 확인해주세요.");
      reda.addFlashAttribute("autoLogin", "N");
      return "redirect:/loginView.do";
    } 
    this.loginDAO.updateUserLog(resultVO.getUserInfoId());
    session.setAttribute("userSession", resultVO);
    List<AuthVO> menuList = EgovUserDetailsHelper.getAuthenticatedAthrList();
    String[] requestURI = { "/usr/dashboard/main.do", "/usr/dashboard/dongbu.do", "/usr/dashboard/olympic.do", "/usr/totalInfo/periodWeatherInfo.do", "/usr/floodCenter/noticeList.do", "/usr/hotLine/hotLineList.do" };
    for (AuthVO menuVO : menuList) {
      for (int i = 0; i < requestURI.length; i++) {
        Pattern p2 = Pattern.compile(".*\\" + menuVO.getUrl());
        Matcher m2 = p2.matcher(requestURI[i]);
        boolean a2 = m2.matches();
        LOGGER.debug(String.valueOf(menuVO.getUrl()) + " = " + a2);
        if (a2)
          return "redirect:" + requestURI[i]; 
      } 
    } 
    return "redirect:/logout.do";
  }
  
  @RequestMapping({"/logout.do"})
  public String logout(HttpSession session, HttpServletResponse response, HttpServletRequest request, RedirectAttributes reda) throws Exception {
    LOGGER.info("/logout.do - 로그아웃");
    session.removeAttribute("userSession");
    session.removeAttribute("leftMenuCode");
    reda.addFlashAttribute("autoLogin", "N");
    return "redirect:/loginView.do";
  }
  
  @RequestMapping({"/usr/special/solution.do"})
  public String dashboardTest(String specialCode, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
    LOGGER.info("/usr/dashboard/special.do - 특보발령 대비 자료");
    if (EgovStringUtil.isEmpty(specialCode) || specialCode.equals("0"))
      return "redirect:/usr/dashboard/main.do"; 
    return "/usr/solution/solutionView" + specialCode;
  }
}


