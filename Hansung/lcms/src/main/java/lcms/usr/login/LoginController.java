package lcms.usr.login;

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
import lcms.usr.lec.com.LecComDAO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LoginController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired private LoginDAO loginDAO;
	@Autowired private LecComDAO lecComDAO;
	@Resource View jsonView;
	
	//로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/login/loginView.do";
	}
	
	private String redirectIndex(String returnUrl){
		return returnUrl;
	}
	
	// 학생&강사 로그인화면
	@RequestMapping("/usr/login/loginView.do")
	public String loginView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/loginView.do - 학생&강사 로그인화면");
		
		return "/usr/login/loginView";
	}
	
	//로그인
	@SuppressWarnings("unused")
	@RequestMapping("/usr/login/loginProc.do")
	public String loginProc(@ModelAttribute("searchVO") CmmnSearchVO searchVO, UsrVO usrVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/login/loginProc.do - 학생&강사 로그인 프로세스");
		LOGGER.debug("usrVO = " + usrVO.toString());
		/**
		 * 1. 학생/교사 분기처리
		 * 2. 로그인 체크
		 * 3. 강의정보 조회 
		 * 4. 세션에 강의 정보 세팅
		 * #비밀번호 암호로직 확인 필요함 인코딩 정보가 다른듯함 > 암호화 한후 값이 다름
		 */
		String message = "";
		String returnUrl = "";
		List<EgovMap> lectList = new ArrayList<EgovMap>();
		EgovMap lectMap = new EgovMap();
		
		EgovMap semeMap = cmmDAO.selectOpenSeme();

		if( usrVO != null ){
			usrVO.setMemberPw(EgovFileScrty.encryptPassword(usrVO.getMemberPw(), usrVO.getMemberCode()));
			loginDAO.updateLoginDateTime(usrVO);
			UsrVO resultVO = loginDAO.selectUsrLoginProc(usrVO);
			
			if(resultVO == null){
				message = "로그인 정보가 올바르지 않습니다.";
				return redirectLoginView(reda, message);
			}else{
				String memberType = resultVO.getMemberType();
				lectList = lecComDAO.LectList(resultVO); //강의정보 조회
				
				String memberAbs = "";
				String lapse = "";
				
				if( memberType.equals("PRF") ){//강사
					if("퇴사".equals(resultVO.getStatus())){
						message = "유효하지 않은 아이디입니다.";
						return redirectLoginView(reda, message);
					}else{

						if("5".equals(resultVO.getLoginFail())){
							message = "사용이 중지된 계정입니다.\r\n관리자에게 문의하세요.";
							return redirectLoginView(reda, message);
						}else if( !usrVO.getMemberPw().equals(resultVO.getMemberPw()) ){
							resultVO.setLoginFail(String.valueOf(Integer.parseInt(resultVO.getLoginFail())+1));
							loginDAO.updateLoginFail(resultVO);
							message = "로그인 정보가 올바르지 않습니다.\r\n5회 이상 실패시 로그인하실 수 없습니다.\r\n"+resultVO.getLoginFail()+"회 실패하였습니다.";
							return redirectLoginView(reda, message);
						}

						EgovMap map = new EgovMap();
						map.put("memberCode", resultVO.getMemberCode());
						map.put("lectYear", (String) semeMap.get("semYear"));
						map.put("lectSem", (String) semeMap.get("semester"));
						String chkLec = loginDAO.selectchkLec(map);
						request.getSession().setAttribute("chkLec", chkLec);
						
						//비밀번호 변경 경과일 30D 이후
						List<EgovMap> lapList = loginDAO.selectLapList(searchVO);
						for (int i = 0; i < lapList.size(); i++) {
							if(lapList.get(i).get("memberCode").equals(resultVO.getMemberCode())){
								lapse = "Y";
								request.getSession().setAttribute("lapse", lapse);//학생비밀번호 변경 경과일
							}
						}
						// //비밀번호 변경 경과일 30D 이후
						returnUrl ="redirect:/usr/lec/myPage/lecNoticeList.do";
					}
				}else if( memberType.equals("STD") ){//학생
					EgovMap map = new EgovMap();
					map.put("memberCode", resultVO.getMemberCode());
					map.put("lectYear", (String) semeMap.get("semYear"));
					map.put("lectSem", (String) semeMap.get("semester"));
					String cnt = loginDAO.selectStudLectMapCheck(map);
					request.getSession().setAttribute("chkStd", cnt);

					if(cnt.equals("0")){
						message = "유효하지 않은 아이디입니다.";
						return redirectLoginView(reda, message);
					}else{
						if("100".equals(resultVO.getLoginFail())){
							message = "사용이 중지된 계정입니다.\r\n관리자에게 문의하세요.";
							return redirectLoginView(reda, message);
						}else if( !usrVO.getMemberPw().equals(resultVO.getMemberPw()) ){
							resultVO.setLoginFail(String.valueOf(Integer.parseInt(resultVO.getLoginFail())+1));
							loginDAO.updateLoginFail(resultVO);
							message = "로그인 정보가 올바르지 않습니다.\r\n5회 이상 실패시 로그인하실 수 없습니다.\r\n"+resultVO.getLoginFail()+"회 실패하였습니다.";
							return redirectLoginView(reda, message);
						}
						//비밀번호 변경 경과일 30D 이후
						List<EgovMap> lapList = loginDAO.selectLapList(searchVO);
						for (int i = 0; i < lapList.size(); i++) {
							if(lapList.get(i).get("memberCode").equals(resultVO.getMemberCode())){
								lapse = "Y";
								request.getSession().setAttribute("lapse", lapse);//학생비밀번호 변경 경과일
							}
						}
						// //비밀번호 변경 경과일 30D 이후
						//학생 결석경고 경고창
						if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
							searchVO.setSearchCondition1((String) semeMap.get("semYear"));
							searchVO.setSearchCondition2((String) semeMap.get("semester"));
						}
						List<EgovMap> hstrList = loginDAO.selectAbsWrnHstrList(searchVO);
						for (int i = 0; i < hstrList.size(); i++) {
							if(hstrList.get(i).get("memberCode").equals(resultVO.getMemberCode())){
								memberAbs = "Y";
								request.getSession().setAttribute("memberAbs", memberAbs);//학생 결석경고 유무
							}
						}
						// //학생 결석경고 경고창
						
						returnUrl = "redirect:/usr/std/lecRoom/stdLecEvalList.do";
					}
				}else{
					returnUrl ="redirect:/usr/lec/myPage/lecNoticeList.do";
				}
			}
			String selLectCode = "";
			String selLectName = "";
			
			if( lectList.size() != 0 ){
				lectMap = lectList.get(0);
				selLectCode = Integer.toString( (int)lectList.get(0).get("lectSeq"));
				selLectName = (String) lectList.get(0).get("lectName");
			}
			
			EgovMap semester = lecComDAO.selectSemeter();
			
			request.getSession().setAttribute("selLectCode", selLectCode);//선택 강의코드
			request.getSession().setAttribute("selLectName", selLectName);//선택 강의이름
			request.getSession().setAttribute("usrSession", resultVO);//유저정보 세션 등록
			request.getSession().setAttribute("lecSession", lectMap);//강의정보 세션 등록
			request.getSession().setAttribute("lectList", lectList);//강의실정보 세션 등록
			request.getSession().setAttribute("semester", semester);//현재학기정보 세션 등록
			request.getSession().setAttribute("openSem", semester);//개설학기정보 세션 등록
			
			if(resultVO != null){
				resultVO.setLoginFail("0");
				loginDAO.updateLoginFail(resultVO);
				
				EgovMap map = new EgovMap();
				String clientIp = ComStringUtil.getClientIP(request);
				
				String loginType = "";
				if("PRF".equals(resultVO.getMemberType())){
					loginType = "2";
				}else{
					loginType = "3";
				}
				
				map.put("loginId", resultVO.getMemberCode());
				map.put("name", resultVO.getName());
				map.put("loginType", loginType);
				map.put("acceIp", clientIp);
				
				cmmDAO.insertLoginLog(map);
			}
			
			return redirectIndex(returnUrl);
		}else{
			message = "로그인 정보가 올바르지 않습니다.";
		}

		return redirectLoginView(reda, message);
	}
	
	// 사용자 로그아웃
	@RequestMapping("/usr/login/admLogout.do")
	public String admLogout(HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/login/admLogout.do - 사용자 로그아웃");
		
		String message = "로그아웃 되었습니다.";
		request.getSession().removeAttribute("usrSession");
		
		return redirectLoginView(reda, message);
	}
	
	//강의실 변경
	@RequestMapping("/usr/login/changeLect.do")
	public String changeLect(HttpServletRequest request, ModelMap model, RedirectAttributes reda ) throws Exception {
		LOGGER.debug("/usr/login/changeLect.do - 사용자 강의실 변경");
		
		UsrVO resultVO = (UsrVO)request.getSession().getAttribute("usrSession");
		String message = "";
		String returnUrl = "";
		
		if( resultVO != null ){
			String memberType = resultVO.getMemberType();
			
			if( memberType.equals("PRF") ){//강사
				returnUrl ="redirect:/usr/lec/myPage/lecNoticeList.do";
				
			}else if( memberType.equals("STD") ){//학생
				returnUrl = "redirect:/usr/std/myPage/stdNoticeList.do";
			}else{
				returnUrl ="redirect:/usr/lec/myPage/lecNoticeList.do";
			}
			String selLectCode = request.getParameter("selLectCode");
			String selLectName = request.getParameter("selLectName");
			
			EgovMap lectMap = lecComDAO.SelectLectMap(selLectCode); //강의정보 조회
			
			EgovMap semester = lecComDAO.selectLecSemeter(lectMap);
			
			request.getSession().setAttribute("selLectCode", selLectCode);//선택 강의코드
			request.getSession().setAttribute("selLectName", selLectName);//선택 강의이름
			request.getSession().setAttribute("lecSession", lectMap);//강의정보 세션 등록
			request.getSession().setAttribute("semester", semester);//선택 강의의 학기정보 세션 등록
			
			return redirectIndex(returnUrl);
		}else{
			message = "세션이 종료되었습니다.";
		}
		
		return redirectLoginView(reda, message);
	}
	
}
