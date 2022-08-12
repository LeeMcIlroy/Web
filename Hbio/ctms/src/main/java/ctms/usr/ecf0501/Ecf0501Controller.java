package ctms.usr.ecf0501;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ecf0501Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ecf0501Controller.class);
	@Autowired private Ecf0501DAO ecf0501DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
			
	
	//로그인화면으로 리다이렉트합니다.
	//private String redirectLoginView(RedirectAttributes reda, String message){
	//	reda.addFlashAttribute("message", message);
	//	return "redirect:/usr/lgn/admLoginView.do";
	//}

	// ********************************(피험자관리) 20201128 관리자 피험자관리 등록&수정 화면********************************
	@RequestMapping("/usr/ecf0501/ecf0501Modify.do")
	public String ecf0501Modify(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, Sb1010mVO sb1010mVO, CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/usr/ecf0501/ecf0501Modify.do - 관리자 피험자관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
				
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		Sb1000mVO sessionVO = (Sb1000mVO) EgovUserDetailsHelper.getAuthenticatedUser();
		LOGGER.debug("sessionVO="+sessionVO.toString());
		LOGGER.debug("getAuthenticatedRsjNo="+EgovUserDetailsHelper.getAuthenticatedRsjNo());
		
		//회사코드 설정
		sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedCorpCd());
		sb1010mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedCorpCd());
		
		//회원(연구대상자번호 설정 
		sb1000mVO.setRsjNo(EgovUserDetailsHelper.getAuthenticatedRsjNo());
		sb1000mVO = ecf0501DAO.selectEcf0501View(sb1000mVO);		
		
		sb1010mVO.setRsjNo(sb1000mVO.getRsjNo());
		sb1010mVO = ecf0501DAO.selectEcf0501ResearchCls(sb1010mVO);
			
		// 핸드폰 번호을 3-4-4 형식으로 나눈다. 핸드폰번호는 - 없이 저장
		if (!EgovStringUtil.isEmpty(sb1000mVO.getHpNo())) {
			
			String hpNo = sb1000mVO.getHpNo();
			sb1000mVO.setMobile1(hpNo.substring(0, 3)); // 핸드폰번호1 3자리
			sb1000mVO.setMobile2(hpNo.substring(3, 7)); // 핸드폰번호2 4자리
			//sb1000mVO.setMobile3(hpNo.substring(7, 4)); // 핸드폰번호2 4자리
			sb1000mVO.setMobile3(hpNo.substring(hpNo.length()-4, hpNo.length())); // 핸드폰번호3 4자리
		}
			
		//생년월일 분리하기
		if (!EgovStringUtil.isEmpty(sb1000mVO.getBrDt())) {
			String brDt = sb1000mVO.getBrDt();
			
			String[] spbrDt = brDt.split("-");
			sb1000mVO.setBrDtY(spbrDt[0].toString());
			sb1000mVO.setBrDtM(spbrDt[1].toString());
			sb1000mVO.setBrDtD(spbrDt[2].toString());
		}	
		
		//이메일 분리하기
		if (!EgovStringUtil.isEmpty(sb1000mVO.getEmail())) {
			String email = sb1000mVO.getEmail();
			
			String[] spemail = email.split("@");
			sb1000mVO.setEmailId(spemail[0].toString());
			sb1000mVO.setEmailAdr(spemail[1].toString());
		}
		
		//계좌번호 복호화
		if (!EgovStringUtil.isEmpty(sb1000mVO.getAcctNo())) {
			sb1000mVO.setAcctNo(EgovFileScrty.decode(sb1000mVO.getAcctNo()));
		}
		
		//sb1000mVO.setHplogin("Y");
		sb1000mVO.setHplogin(sessionVO.getHplogin());
		LOGGER.debug("setHplogin="+sessionVO.getHplogin().toString());
		
		model.addAttribute("NotiPageGubun","NotiUpdate");
		model.addAttribute("sb1000mVO", sb1000mVO);
		model.addAttribute("sb1010mVO", sb1010mVO); // 연구대상자(피험자) 유형
		
		return "/usr/ecf0501/ecf0501Modify";
	}

	// ********************************(피험자관리) 20201128 관리자 피험자관리 저장 ********************************
	@RequestMapping("/usr/ecf0501/ecf0501Update.do")
	public String ecf0501Save(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, Sb1010mVO sb1010mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/usr/ecf0501/ecf0501Update.do - 관리자 피험자관리 저장");
		String message = "";
		
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
		
		//Sb1000mVO sessionVO = (Sb1000mVO) EgovUserDetailsHelper.getAuthenticatedUser();
		//LOGGER.debug("sessionVO="+sessionVO.toString());
		
		// 회사코드(CTMS운영) 설정
		sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedCorpCd());
		sb1010mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedCorpCd());
		
		//연구대상자번호 설정 
		sb1000mVO.setRsjNo(EgovUserDetailsHelper.getAuthenticatedRsjNo());
		sb1010mVO.setRsjNo(EgovUserDetailsHelper.getAuthenticatedRsjNo());
		
		//등록자 설정 - 아이디가 아니고 EMP_NO ? USRE_ID는 변경 가능함  
		sb1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedUserId());
		sb1010mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedUserId());
	
		//핸드폰 합치기 - 는 사용하지 않음
		if (!EgovStringUtil.isEmpty(sb1000mVO.getMobile2())) {
			sb1000mVO.setHpNo(sb1000mVO.getMobile1()+sb1000mVO.getMobile2()+sb1000mVO.getMobile3());
		}
		
		//생년월일 합치기
		if (!EgovStringUtil.isEmpty(sb1000mVO.getBrDtY())) {
			sb1000mVO.setBrDt(sb1000mVO.getBrDtY()+"-"+sb1000mVO.getBrDtM()+"-"+sb1000mVO.getBrDtD());
		}
		
		//이메일 합치기
		if (!EgovStringUtil.isEmpty(sb1000mVO.getEmailId())) {
			sb1000mVO.setEmail(sb1000mVO.getEmailId()+"@"+sb1000mVO.getEmailAdr());
		}
		
		//계좌번호 암호화 
		sb1000mVO.setAcctNo(EgovFileScrty.encode(sb1000mVO.getAcctNo()));
		
		//정보등록단계 설정 2  
		sb1000mVO.setRegLv("2");
		
		// 연구대상자 수정
		ecf0501DAO.updateEcf0501(sb1000mVO);
		
		// 연구대상자 유형 수정
		ecf0501DAO.updateEcf0501ResearchCls(sb1010mVO);
			
		message = "수정이 완료되었습니다.";

		// return redirectList(reda, message);
		//return redirectLoginView(reda, message);
		return redirectLogout(reda, message);
	}

	// 피험자관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/ecf0501/ecf0501Modify.do";
	}

	// 로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/login/loginView.do";		
	}
	
	// 로그아웃으로 리다이렉트합니다.
	private String redirectLogout(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/login/logout.do";		
	}
		
	// 연구대상자(회원) 비밀번호 수정 화면
	@RequestMapping("/usr/ecf0501/ecf0501ModifyPw.do")
	public String ecf0501AjaxPasswordUpdate(@ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/usr/ecf0501/ecf0501AjaxPasswordUpdate.do - 연구대상자(회원) 비밀번호 수정 화면");
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedCorpCd());
		map.put("userId", EgovUserDetailsHelper.getAuthenticatedUserId());
		LOGGER.debug("corpCd="+EgovUserDetailsHelper.getAuthenticatedCorpCd());
		LOGGER.debug("userId="+EgovUserDetailsHelper.getAuthenticatedUserId());
		
		Sb1000mVO resultVO = ecf0501DAO.selectEcf0501Profile(map);
		
		model.addAttribute("sb1000mVO", resultVO);
		
		return "/usr/ecf0501/ecf0501ModifyPw";
	}	
	
	
	// 연구대상자(회원) 비밀번호 수정
	@RequestMapping("/usr/ecf0501/ecf0501AjaxPasswordUpdate.do")
	public String ecf0501AjaxPasswordUpdate(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, String adminPw, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception{
		LOGGER.debug("/usr/ecf0501/ecf0501AjaxPasswordUpdate.do - 관리자 비밀번호 수정");
		String message = "";

		if(sb1000mVO != null){
			sb1000mVO.setPwNo(EgovFileScrty.encryptPassword(adminPw, sb1000mVO.getUserId()));
			LOGGER.debug("setPwNo"+sb1000mVO.getPwNo());
			LOGGER.debug("userId"+sb1000mVO.getUserId());

			ecf0501DAO.ecf0501AjaxPasswordUpdate(sb1000mVO);
			message = "수정이 완료 되었습니다.";
		}
		return redirectEcf0501Profile(reda, message);
	}
	
	//프로필화면으로 리다이렉트합니다.
	private String redirectEcf0501Profile(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/ecf0501/ecf0501Modify.do";
	}

	// 연구대상자(회원) 비밀번호 조회
	@RequestMapping("/usr/ecf0501/ecf0501AjaxUsrPwChk.do")
	public View ecf0501AjaxUsrPwChk(String adminPw, String pass, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/usr/ecf0501/ecf0501AjaxUsrPwChk.do - 연구대상자(회원) 비밀번호 조회");
		
		// AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedCorpCd());
		map.put("userId", EgovUserDetailsHelper.getAuthenticatedUserId());
		map.put("pwNo",adminPw);
		
		LOGGER.debug("corpCd="+EgovUserDetailsHelper.getAuthenticatedCorpCd());
		LOGGER.debug("userId="+EgovUserDetailsHelper.getAuthenticatedUserId());
		LOGGER.debug("pwNo="+adminPw);
		LOGGER.debug("pass="+pass);
		
		Sb1000mVO sb1000mVO = ecf0501DAO.selectEcf0501Profile(map);
		LOGGER.debug("sb1000mVO="+sb1000mVO);
		
		boolean status = false;
		
		if(!EgovStringUtil.isEmpty(sb1000mVO.getPwNo())){
			sb1000mVO.setPwNo(EgovFileScrty.encryptPassword(adminPw, sb1000mVO.getUserId()));
			
			int cnt = ecf0501DAO.selectEcf0501AjaxUsrPwChk(sb1000mVO);
			
			if(cnt > 0){
				status = true;
			}else{
				status = false;
			}
		}
		
		model.addAttribute("sb1000mVO", sb1000mVO);
		model.addAttribute("status", status);
		
		return jsonView;
	}
	
	
	
}
