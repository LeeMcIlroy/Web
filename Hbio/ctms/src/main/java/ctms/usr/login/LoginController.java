package ctms.usr.login;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.util.Arrays;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.sms.SmsSendUtil;
import component.util.ComStringUtil;
import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct1000mVO;
import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.Ct1060mVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import java.util.List;
import java.util.Random;

@Controller
public class LoginController extends AdmCmmController {

	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	private LoginDAO loginDAO;
	@Resource
	View jsonView;

	// 로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/login/loginView.do";
	}

	// 로그인화면으로 리다이렉트합니다.
	private String redirectLoginViewCtr(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/login/loginViewCtr.do";
	}
	
	// 아이디찾기 화면으로 리다이렉트합니다.
	private String redirectSearchId(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/login/searchId.do";
	}

	// 비밀번호찾기 화면으로 리다이렉트합니다.
	private String redirectSearchPw(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/login/searchPw.do";
	}

	// 로그인화면
	@RequestMapping("/usr/login/loginView.do")
	public String loginView(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, HttpSession session,
			HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/loginView.do - 사용자 로그인화면");
		String message = "";
		
		model.addAttribute("ctrlogin", "N");
		model.addAttribute("hplogin", "N");

		return "/usr/login/loginView";
	}

	//  로그인화면- 임상시험센터
	@RequestMapping("/usr/login/loginViewCtr.do")
	public String loginViewCtr(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, HttpSession session,
			HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/loginViewCtr.do - 사용자 로그인화면 - 임상시험센터");
		String message = "";

		//서버 mac address로 사용할 수 없음
		//사용PC의 mac address를 획득한다(테블릿PC)
		//String strmac = ComStringUtil.getLocalMacAddress();
		// model.addAttribute("strmac", strmac);

		// DB에 저장된 mac address와 비교하여 일치한 경우 핸드폰번호 로그인만 가능하게 한다.
		//EgovMap map = new EgovMap();
		//map.put("strmac", strmac);
		//String chkmacaddr = loginDAO.selectLoginMacAddress(map);
		//if (chkmacaddr.equals("SUCCESS")) { // mac address 등록되여 있는 경우
			//model.addAttribute("hplogin", "Y");
		//} else {
			//model.addAttribute("hplogin", "N");
		//}
		
		model.addAttribute("ctrlogin", "Y");
		model.addAttribute("hplogin", "Y");

		return "/usr/login/loginViewCtr";
	}

	// 로그인
	@RequestMapping("/usr/login/loginProc.do")
	public String loginProc(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, RedirectAttributes reda,
			HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/loginProc.do - 사용자 로그인");
		Sb1000mVO sessionVO = new Sb1000mVO();
		String returnUrl = "";
		String message = "";

		if (!EgovStringUtil.isEmpty(sb1000mVO.getHpNo())) {
			// 핸드폰번호를 사용자를 찾는다
			String hpNoCheck = loginDAO.selectUsrLoginHpNoChk(sb1000mVO);
			// 있는 경우 로그인처리 없는 경우 로그인 실패

			if ("SUCCESS".equals(hpNoCheck)) {
				sessionVO = loginDAO.selectUsrLoginProcHpNo(sb1000mVO);

				if (sessionVO != null) {
					loginDAO.updateLoginDateTime(sessionVO);

					// 핸드폰로그인 여부 설정
					sessionVO.setHplogin("Y");
					// 일반회원로그인 여부 설정
					sessionVO.setCtrlogin("N");
					
					session.setAttribute("usrSession", sessionVO);
					LOGGER.debug("sessionVO1=" + sessionVO.toString());
					LOGGER.debug("sb1000mVO1=" + sb1000mVO.toString());

					returnUrl = "redirect:/usr/ecf0101/ecf0101List.do";
				} else {
					// loginDAO.updateLoginFail(sb1000mVO);
					message = "로그인에 실패하였습니다1.\r\n비밀번호를 확인해 주세요.";
					returnUrl = redirectLoginView(reda, message);
				}
			} else {
				message = "로그인에 실패하였습니다2.\r\n존재하지 않는 계정입니다.";
				returnUrl = redirectLoginView(reda, message);
			}
		} else {

			if (!EgovStringUtil.isEmpty(sb1000mVO.getUserId()) && !EgovStringUtil.isEmpty(sb1000mVO.getPwNo())) {
				sb1000mVO.setPwNo(EgovFileScrty.encryptPassword(sb1000mVO.getPwNo(), sb1000mVO.getUserId()));
				String idCheck = loginDAO.selectUsrLoginIdChk(sb1000mVO);

				System.out.println("----------------- pwNo = " + sb1000mVO.getPwNo());

				if ("SUCCESS".equals(idCheck)) {
					sessionVO = loginDAO.selectUsrLoginProc(sb1000mVO);

					if (sessionVO != null) {
						loginDAO.updateLoginDateTime(sessionVO);
						
						sessionVO.setHplogin("N");
						sessionVO.setCtrlogin("N");
						
						session.setAttribute("usrSession", sessionVO);

						LOGGER.debug("sessionVO2=" + sessionVO.toString());
						LOGGER.debug("sb1000mVO2=" + sb1000mVO.toString());

						returnUrl = "redirect:/usr/ecf0101/ecf0101List.do";
					} else {
						// loginDAO.updateLoginFail(sb1000mVO);
						message = "로그인에 실패하였습니다.\r\n비밀번호를 확인해 주세요.";
						returnUrl = redirectLoginView(reda, message);
					}
				} else {
					message = "로그인에 실패하였습니다.\r\n존재하지 않는 계정입니다.";
					returnUrl = redirectLoginView(reda, message);
				}
			} else {
				message = "로그인에 실패하였습니다.";
				returnUrl = redirectLoginView(reda, message);
			}
		}

		return returnUrl;
	}

	// 로그인 - 임상시험센터
	@RequestMapping("/usr/login/loginProcCtr.do")
	public String loginProcCtr(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, RedirectAttributes reda,
			HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/loginProcCtr.do - 사용자 로그인-임상시험센터");
		Sb1000mVO sessionVO = new Sb1000mVO();
		String returnUrl = "";
		String message = "";

		if (!EgovStringUtil.isEmpty(sb1000mVO.getHpNo())) {
			// 핸드폰번호를 사용자를 찾는다
			String hpNoCheck = loginDAO.selectUsrLoginHpNoChk(sb1000mVO);
			// 있는 경우 로그인처리 없는 경우 로그인 실패

			if ("SUCCESS".equals(hpNoCheck)) {
				sessionVO = loginDAO.selectUsrLoginProcHpNo(sb1000mVO);

				if (sessionVO != null) {
					loginDAO.updateLoginDateTime(sessionVO);

					// 핸드폰로그인 여부 설정
					sessionVO.setHplogin("Y");
					sessionVO.setCtrlogin("Y");
					
					session.setAttribute("usrSession", sessionVO);
					LOGGER.debug("sessionVO1=" + sessionVO.toString());
					LOGGER.debug("sb1000mVO1=" + sb1000mVO.toString());

					returnUrl = "redirect:/usr/ecf0101/ecf0101List.do";
				} else {
					// loginDAO.updateLoginFail(sb1000mVO);
					message = "로그인에 실패하였습니다.\r\n비밀번호를 확인해 주세요.";
					returnUrl = redirectLoginViewCtr(reda, message);
				}
			} else {
				message = "로그인에 실패하였습니다.\r\n존재하지 않는 계정입니다.";
				returnUrl = redirectLoginViewCtr(reda, message);
			}
		} else {

			if (!EgovStringUtil.isEmpty(sb1000mVO.getUserId()) && !EgovStringUtil.isEmpty(sb1000mVO.getPwNo())) {
				sb1000mVO.setPwNo(EgovFileScrty.encryptPassword(sb1000mVO.getPwNo(), sb1000mVO.getUserId()));
				String idCheck = loginDAO.selectUsrLoginIdChk(sb1000mVO);

				System.out.println("----------------- pwNo = " + sb1000mVO.getPwNo());

				if ("SUCCESS".equals(idCheck)) {
					sessionVO = loginDAO.selectUsrLoginProc(sb1000mVO);

					if (sessionVO != null) {
						loginDAO.updateLoginDateTime(sessionVO);

						session.setAttribute("usrSession", sessionVO);

						LOGGER.debug("sessionVO2=" + sessionVO.toString());
						LOGGER.debug("sb1000mVO2=" + sb1000mVO.toString());

						returnUrl = "redirect:/usr/ecf0101/ecf0101List.do";
					} else {
						// loginDAO.updateLoginFail(sb1000mVO);
						message = "로그인에 실패하였습니다.\r\n비밀번호를 확인해 주세요.";
						returnUrl = redirectLoginViewCtr(reda, message);
					}
				} else {
					message = "로그인에 실패하였습니다.\r\n존재하지 않는 계정입니다.";
					returnUrl = redirectLoginViewCtr(reda, message);
				}
			} else {
				message = "로그인에 실패하였습니다.";
				returnUrl = redirectLoginViewCtr(reda, message);
			}
		}

		return returnUrl;
	}
	
	
	// 로그아웃
	@RequestMapping("/usr/login/logout.do")
	public String logout(HttpSession session, RedirectAttributes reda, HttpServletRequest request, ModelMap model)
			throws Exception {
		LOGGER.debug("/usr/login/logout.do - 사용자 로그아웃");

		String message = "로그아웃되었습니다.";

		Sb1000mVO adminVO = ((Sb1000mVO) session.getAttribute("usrSession"));
		LOGGER.debug("adminVO="+adminVO);
		if(adminVO == null) {
			session.removeAttribute("usrSession");
			return redirectLoginView(reda, message);
		}else {
		
			if(adminVO.getCtrlogin().equals("Y")) {
				session.removeAttribute("usrSession");
				return redirectLoginViewCtr(reda, message);
			} else {
				session.removeAttribute("usrSession");
				return redirectLoginView(reda, message);
			}
		}		
	}

	// ********************************(피험자관리) 20201128 관리자 피험자관리 저장
	// ********************************
	@RequestMapping("/usr/login/memberSave.do")
	public String memberSave(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, Sb1010mVO sb1010mVO,
			String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda, ModelMap model)
			throws Exception {
		LOGGER.debug("/qxsepmny/ech0301/ech0301Update.do - 관리자 피험자관리 저장");
		String message = "";

		// 세션 호출
		// AdminVO adminVO = (AdminVO)
		// request.getSession().getAttribute("adminSessionLcms");

		// 회사코드(CTMS운영) 설정
		// sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		// sb1010mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());

		// 등록자 설정 - 아이디가 아니고 EMP_NO ? USRE_ID는 변경 가능함
		// sb1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());

		// 회원초기값 설정
		sb1000mVO.setCorpCd("HNBSRC");
		String regDt = EgovStringUtil.getDateMinus();
		sb1000mVO.setRegDt(regDt);
		sb1000mVO.setBrDt(regDt);
		sb1000mVO.setAcctCp("N");
		sb1000mVO.setRsjStCls("90");
		sb1000mVO.setGenYn("");
		sb1000mVO.setBranchCd("1010"); // 검토
		sb1000mVO.setUserSt("2"); // 관리자 확인일자 설정시 '1'로 변경 됨
		sb1000mVO.setEffStdt(regDt);
		sb1000mVO.setEffEndt("9999-12-31");
		// sb1000mVO.setDataRegdt(regDt);
		sb1000mVO.setDataRegnt("aid");
		// 회원정보등록단계 1 가입 2 정보등록
		sb1000mVO.setRegLv("1");

		// 비밀번호 암호화
		// ct1030mVO.setPwNo(EgovFileScrty.encryptPassword(adminPw,
		// ct1030mVO.getUserId()));
		sb1000mVO.setPwNo(EgovFileScrty.encryptPassword(sb1000mVO.getPwNo(), sb1000mVO.getUserId()));

		LOGGER.debug("sb1000mVO=" + sb1000mVO.toString());

		// 회원등록
		loginDAO.insertMember(sb1000mVO);

		// 연구대상자(피험자) 유형 등록 - 1:1
		sb1010mVO.setCorpCd("HNBSRC");
		sb1010mVO.setRsjNo(sb1000mVO.getRsjNo());
		sb1010mVO.setRsjName(sb1000mVO.getRsjName());
		sb1010mVO.setFaYn("N");
		sb1010mVO.setBaYn("N");
		sb1010mVO.setNfYn("N");
		sb1010mVO.setClYn("N");
		sb1010mVO.setWeYn("N");
		sb1010mVO.setDcYn("N");
		sb1010mVO.setLtYn("N");
		sb1010mVO.setPmYn("N");
		sb1010mVO.setHlYn("N");
		sb1010mVO.setEbYn("N");
		sb1010mVO.setSnYn("N");
		sb1010mVO.setDdYn("N");
		sb1010mVO.setFlYn("N");
		// sb1010mVO.setDataRegdt(regDt);
		sb1010mVO.setDataRegnt("aid");

		// 연구대상자(피험자) 유형 등록 - 1:1
		loginDAO.insertMemberResearchCls(sb1010mVO);

		message = "등록이 완료되었습니다.";

		return redirectLoginView(reda, message);
	}

	// 이용약관 팝업화면
	@RequestMapping("/usr/login/useRulePop.do")
	public String useRulePop(@ModelAttribute("ct1000mVO") Ct1000mVO ct1000mVO, HttpSession session,
			HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/useRulePop.do - 이용약관 팝업 화면");

		ct1000mVO.setCorpCd("HNBSRC");

		ct1000mVO = loginDAO.selectRule(ct1000mVO);

		model.addAttribute("ct1000mVO", ct1000mVO);

		return "/usr/login/useRulePop";
	}

	// 개인정보처리방침 팝업화면
	@RequestMapping("/usr/login/privRulePop.do")
	public String privRulePop(@ModelAttribute("ct1000mVO") Ct1000mVO ct1000mVO, HttpSession session,
			HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/privRulePop.do - 개인정보처리방침 팝업 화면");

		ct1000mVO.setCorpCd("HNBSRC");

		ct1000mVO = loginDAO.selectRule(ct1000mVO);

		model.addAttribute("ct1000mVO", ct1000mVO);

		return "/usr/login/privRulePop";
	}

	// 회원가입
	@RequestMapping("/usr/login/joinMem.do")
	public String joinMem(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, HttpSession session,
			HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/joinMem.do - 회원가입");

		return "/usr/login/joinMem";
	}

	// 아이디찾기
	@RequestMapping("/usr/login/searchId.do")
	public String searchId(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, HttpSession session,
			HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/searchId.do - 아이디찾기");

		return "/usr/login/searchId";
	}

	// 비밀번호찾기
	@RequestMapping("/usr/login/searchPw.do")
	public String searchPw(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, HttpSession session,
			HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/searchPw.do - 비밀번호찾기");

		return "/usr/login/searchPw";
	}

	// 회원(연구대상자) 아이디 중복체크
	@RequestMapping("/usr/login/AjaxUserIdChk.do")
	public View AjaxUserIdChk(String userId, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/AjaxUserIdChk.do - 회원(연구대상자) 아이디 중복체크");

		LOGGER.debug("userId=" + userId);

		boolean status = false;

		if (!EgovStringUtil.isEmpty(userId)) {

			EgovMap map = new EgovMap();
			map.put("corpCd", "HNBSRC");
			map.put("userId", userId);

			int cnt = loginDAO.selectUserIdChk(map);
			if (cnt > 0) {
				status = false;
			} else {
				status = true;
			}
		}
		model.addAttribute("status", status);

		return jsonView;
	}

	// 회원 아이디찾기 인증버호 발송
	@RequestMapping("/usr/login/sendAjaxSetAuthNoId.do")
	public View sendAjaxSetAuthNoId(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, Ct1060mVO ct1060mVO,
			String corpCd, String name, String hpNo, HttpServletRequest request, RedirectAttributes reda,
			ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/sendAjaxSetAuthNo.do - 아이디찾기 인증번호 발송");
		String message = "";
		LOGGER.debug("corpCd=" + corpCd);
		LOGGER.debug("name=" + name);
		LOGGER.debug("hpNo=" + hpNo);

		boolean resultSt = false;

		// 회사코드 설정 - 로그인이 안된 상태에서 회사코드는?
		// sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedCorpCd());
		sb1000mVO.setCorpCd("HNBSRC");

		// 회사코드, 이름+핸드폰번호 존재 확인
		sb1000mVO.setRsjName(name);
		sb1000mVO.setHpNo(hpNo);
		int chk = loginDAO.selectUsrHpCnt(sb1000mVO);
		if (chk == 0) {
			message = "등록된 핸드폰번호가 없습니다";
		} else {

			// 기존 인증번호를 폐기한다 DEL_YN = "Y" 설정, 이전 인증번호를 발급한 후 화면을 빠져나간 경우
			ct1060mVO.setAuth1(hpNo);
			ct1060mVO.setAuth2(name);
			loginDAO.updateAuthCdSt(ct1060mVO);

			// 6자리 난수 발생
			int len = 6;
			int dupCd = 1;
			String randomNo = component.util.ComStringUtil.numberGen(len, dupCd);

			// 인증번호 설정
			ct1060mVO.setAuthCd(randomNo);
			ct1060mVO.setDelYn("N");
			ct1060mVO.setDataRegnt("aid");

			loginDAO.insertAuthCd(ct1060mVO);

			// SMS 발송 로직 구현
			String to = sb1000mVO.getHpNo();
			String from = "01033550107";
			String text = "[에이치앤바이오]인증번호[" + randomNo + "]를 입력해 주세요.";

			SmsSendUtil.sendSms(to, from, text);

			message = "인증번호를 핸드폰으로 발송하였습니다";
			resultSt = true;
		}

		model.addAttribute("message", message);
		model.addAttribute("resultSt", resultSt);
		return jsonView;

	}

	@RequestMapping("/usr/login/idList.do")
	public String idList(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO)
			throws Exception {
		LOGGER.debug("/usr/login/idList.do - 아이디찾기 - 아이디 리스트");
		// request.getSession().setAttribute("admMenuNo", "703");

		// PaginationInfo paginationInfo =
		// PaginationController.getPaginationInfo(searchVO);
		// CmmnListVO listVO = ech0702DAO.selectEch0702List(searchVO);
		// paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());

		// model.addAttribute("resultList", listVO.getEgovList());
		// model.addAttribute("paginationInfo", paginationInfo);

		// model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		// model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		// model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());

		return "/usr/login/idList";
	}

	@RequestMapping("/usr/login/authCdCheck.do")
	public String authCdCheck(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, Ct1060mVO ct1060mVO,
			CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model)
			throws Exception {
		LOGGER.debug("/usr/login/sendAjaxSetAuthNo.do - 아이디찾기 인증번호 발송");
		String message = "";

		// 입력한 인증번호
		String inAuthCd = sb1000mVO.getAuthCd();

		// 저장된 인증번호 획득
		ct1060mVO.setAuth1(sb1000mVO.getHpNo()); // 핸드폰번호
		ct1060mVO.setAuth2(sb1000mVO.getRsjName()); // 이름
		String orgAuthCd = loginDAO.selectAuthCd(ct1060mVO);

		// 현재 인증번호를 폐기한다 DEL_YN = "Y" 설정
		loginDAO.updateAuthCdSt(ct1060mVO);

		// inAuthCd와 orgAuthCd를 비교한다
		if (inAuthCd.equals(orgAuthCd)) {

			message = "인증번호를 확인했습니다.";

			// 회사코드+핸드폰번호+이름 -> 아이디를 검색한다. 반드시 회사코드를 설정한다.
			searchVO.setSearchCondition1("HNBSRC"); // 회사코드
			searchVO.setSearchCondition2(sb1000mVO.getHpNo()); // 핸드폰번호
			searchVO.setSearchCondition3(sb1000mVO.getRsjName()); // 이름
			List<EgovMap> listVO = loginDAO.selectIdList(searchVO);

			model.addAttribute("resultList", listVO);
			model.addAttribute("message", message);
			return "/usr/login/idList";

		} else {
			message = "인증번호가 틀립니다.";
			model.addAttribute("message", message);
			return redirectSearchId(reda, message);
		}

	}

	// 회원 비밀번호찾기 인증버호 발송
	@RequestMapping("/usr/login/sendAjaxSetAuthNoPw.do")
	public View sendAjaxSetAuthNoPw(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, Ct1060mVO ct1060mVO,
			String corpCd, String userId, String hpNo, HttpServletRequest request, RedirectAttributes reda,
			ModelMap model) throws Exception {
		LOGGER.debug("/usr/login/sendAjaxSetAuthNoPw.do - 비밀번호찾기 인증번호 발송");
		String message = "";
		LOGGER.debug("corpCd=" + corpCd);
		LOGGER.debug("userId=" + userId);
		LOGGER.debug("hpNo=" + hpNo);

		boolean resultSt = false;

		// 회사코드 설정 - 로그인이 안된 상태에서 회사코드는?
		// sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedCorpCd());
		sb1000mVO.setCorpCd("HNBSRC");

		// 회사코드, 이름+핸드폰번호 존재 확인
		sb1000mVO.setUserId(userId);
		sb1000mVO.setHpNo(hpNo);
		int chk = loginDAO.selectUsrHpCntPw(sb1000mVO);
		if (chk == 0) {
			message = "등록된 핸드폰번호가 없습니다";
		} else {

			// 기존 인증번호를 폐기한다 DEL_YN = "Y" 설정, 이전 인증번호를 발급한 후 화면을 빠져나간 경우
			ct1060mVO.setAuth1(hpNo);
			ct1060mVO.setAuth2(userId);
			loginDAO.updateAuthCdSt(ct1060mVO);

			// 6자리 난수 발생
			int len = 6;
			int dupCd = 1;
			String randomNo = component.util.ComStringUtil.numberGen(len, dupCd);

			// 인증번호 설정
			ct1060mVO.setAuthCd(randomNo);
			ct1060mVO.setDelYn("N");
			ct1060mVO.setDataRegnt("aid");

			loginDAO.insertAuthCd(ct1060mVO);

			// SMS 발송 로직 구현
			String to = sb1000mVO.getHpNo();
			String from = "01033550107";
			String text = "[에이치앤바이오]인증번호[" + randomNo + "]를 입력해 주세요.";

			SmsSendUtil.sendSms(to, from, text);

			message = "인증번호를 핸드폰으로 발송하였습니다";
			resultSt = true;
		}

		model.addAttribute("message", message);
		model.addAttribute("resultSt", resultSt);
		return jsonView;

	}

	// 회원 비밀번호찾기 인증번호 발송
	@RequestMapping("/usr/login/authCdCheckPw.do")
	public String authCdCheckPw(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, Ct1060mVO ct1060mVO,
			CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model)
			throws Exception {
		LOGGER.debug("/usr/login/sendAjaxSetAuthNo.do - 비밀번호찾기 인증번호 발송");
		String message = "";

		// 입력한 인증번호
		String inAuthCd = sb1000mVO.getAuthCd();

		// 저장된 인증번호 획득
		ct1060mVO.setAuth1(sb1000mVO.getHpNo()); // 핸드폰번호
		ct1060mVO.setAuth2(sb1000mVO.getUserId()); // 아이디
		String orgAuthCd = loginDAO.selectAuthCd(ct1060mVO);

		// 현재 동일아이디 인증번호를 폐기한다 DEL_YN = "Y" 설정
		loginDAO.updateAuthCdSt(ct1060mVO);

		// inAuthCd와 orgAuthCd를 비교한다
		if (inAuthCd.equals(orgAuthCd)) {

			message = "인증번호를 확인했습니다.";

			// 비밀번호 변경 화면으로 전환한다
			// 회사코드+핸드폰번호+이름 -> 아이디를 검색한다. 반드시 회사코드를 설정한다.
			sb1000mVO.setCorpCd("HNBSRC"); // 회사코드

			model.addAttribute("sb1000mVO", sb1000mVO);
			model.addAttribute("message", message);
			return "/usr/login/resetPw";

		} else {
			message = "인증번호가 틀립니다.";
			model.addAttribute("message", message);
			return redirectSearchPw(reda, message);
		}

	}

	// 회원 비밀번호찾기 - 비밀번호 수정
	@RequestMapping("/usr/login/usrAjaxPasswordUpdate.do")
	public String usrAjaxPasswordUpdate(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, String userPw,
			HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0702/ech0702AjaxPasswordUpdate.do - 관리자 비밀번호 수정");
		String message = "";

		if (sb1000mVO != null) {
			sb1000mVO.setPwNo(EgovFileScrty.encryptPassword(userPw, sb1000mVO.getUserId()));
			loginDAO.usrAjaxPasswordUpdate(sb1000mVO);
			message = "비밀번호를 재설정하였습니다.";
		}
		return redirectLoginView(reda, message);

	}

}