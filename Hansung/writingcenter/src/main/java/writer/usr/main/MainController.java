package writer.usr.main;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import WiseAccess.SSO;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.usr.board.qna.BoardQnaDAO;
import writer.usr.cmm.CmmDAO;
import writer.valueObject.ClassVO;
import writer.valueObject.DepartmentVO;
import writer.valueObject.PopupVO;
import writer.valueObject.QestnarAskVO;
import writer.valueObject.QestnarPsnAnsVO;
import writer.valueObject.QestnarPsnVO;
import writer.valueObject.QestnarReplyVO;
import writer.valueObject.QestnarVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class MainController {

	private static final Logger LOGGER = LoggerFactory.getLogger(MainController.class);
	
	@Autowired private MainDAO mainDAO;
	@Autowired private BoardQnaDAO boardQnaDAO;
	
	@Autowired private CmmDAO cmmDAO;
	
	// sso 쿠키 id 확인
	private String getLoginCookieId(HttpServletRequest request){
		// 로그인 쿠키 확인
		SSO sso = new SSO();
		Cookie[] aCookies = request.getCookies();
		if (aCookies != null) {
			for (int i = 0;i < aCookies.length;i++) {
				LOGGER.debug("aCookies["+i+"].getName() = "+aCookies[i].getName());
				LOGGER.debug("aCookies["+i+"].getValue() = "+aCookies[i].getValue());
				if(aCookies[i].getName().equals("ssotoken")){
					if(aCookies[i].getValue() != "") {
						int nResult = sso.verifyToken(aCookies[i].getValue());
						if(nResult >= 0){
							if(!EgovStringUtil.isEmpty(sso.getValueUserID())){
								LOGGER.debug("로그인 쿠키가 있습니다.("+sso.getValueUserID()+")");
								return sso.getValueUserID();
							}
						}
					}
				}
			}
		}
		return "";
	}
/*	
	// 사용자 로그인
	@RequestMapping("/usr/lgn/login.do")
	public String login(HttpSession session, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lgn/login.do - 사용자 > 로그인");
		
		Map<String, String> userVO = new HashMap<>();
		String ssoId = getLoginCookieId(request);	
		if(EgovStringUtil.isEmpty(ssoId)){
			reda.addFlashAttribute("message", "로그인에 실패하셨습니다.\r\n관리자에게 문의해주세요.");
		}else{
			String memCode = "";
			String memName = "";
			String memDept = "";
			String memType = "";
			
			// 교수, 연구원
			EgovMap ssoVO = mainDAO.actionSsoLogin(ssoId);
			
			if(ssoVO != null){
				memCode = ssoVO.get("profCode").toString();
				memName = ssoVO.get("profName").toString();
				memDept = ssoVO.get("profSosok").toString();
				memType = ssoVO.get("memType").toString();
			}else{
				// 학생
				EgovMap ssoStudVO = mainDAO.actionSsoLoginStudent(ssoId);

				if(ssoStudVO == null){
					// 일반 직원
					//reda.addFlashAttribute("message", "로그인에 실패하셨습니다.\n사고와표현 관계자만 로그인 가능합니다.");
					request.setAttribute("type", "USR");
					return "/cmm/ssoLogout";
				}
				
				memCode = ssoStudVO.get("studCode").toString();
				memName = ssoStudVO.get("studName").toString();
				memDept = ssoStudVO.get("studSosok").toString();
				memType = ssoStudVO.get("memType").toString();
			}
			
			
			userVO.put("memCode", memCode);
			userVO.put("memName", memName);
			userVO.put("memDept", memDept);
			userVO.put("memType", memType);
			
			session.setAttribute("userSession", userVO);
		}
		
		return "redirect:/";
	}
*/
	// 사용자 임시 로그인 화면
	@RequestMapping("/usr/lgn/tmpLoginView.do")
	public String loginView() throws Exception {
		LOGGER.info("/usr/lgn/tmpLoginView.do - 사용자 > 임시 로그인 화면");
		return "/usr/main/loginView";
	}
	
	// 사용자 SSO 미연동 로그인
	@RequestMapping("/usr/lgn/tmpLogin.do")
	public String tmpLogin(String memCode, String memDept, String memName, String memType, HttpSession session) throws Exception {
		LOGGER.info("/usr/lgn/tmpLogin.do - 사용자 > SSO 미연동 로그인");
		Map<String, String> userVO = new HashMap<>();
		userVO.put("memCode", "999999");
		userVO.put("memDept", "테스트");
		userVO.put("memName", "테스터");
		userVO.put("memType", memType);
		session.setAttribute("userSession", userVO);
		return "redirect:/";
	}

	// 사용자 로그아웃
	@RequestMapping("/usr/lgn/logout.do")
	public String logout(HttpSession session, HttpServletResponse response, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/lgn/logout.do - 사용자 > 로그아웃");
		session.removeAttribute("userSession");
		return "redirect:/usr/main/index.do";
	}
	// 메인 화면
	@RequestMapping("/usr/main/index.do")
	public String index(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/main/index.do - 사용자 > index");
		LOGGER.debug("searchVO - "+searchVO.toString());
		
		// 팝업 목록
		model.addAttribute("popupList", mainDAO.selectPopupList());
		
		// 공지사항 목록
		searchVO.setSearchType("NOTI");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 6, 10);
		List<EgovMap> noticeList=mainDAO.selectNoticeList(searchVO);
		
		// Q&A
		searchVO.setSearchType("");
		CmmnListVO qnaList=boardQnaDAO.selectBoardQnaList(searchVO);
		
		searchVO.setRecordCountPerPage(10);
		model.addAttribute("noticeList",noticeList);
		model.addAttribute("qnaList",qnaList.getEgovList());
		
		// 설문조사 기간조회
		Map<String, Object> userVO = (Map<String, Object>) EgovUserDetailsHelper.getAuthenticatedUser();
		
		
		if(userVO != null){
			
			Date day = new Date();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			
			String today = transFormat.format(day);
			List<String> qestnarDate = mainDAO.selectQestnarInfoDateOne(today);
			
			List<String> qestSeqs = new ArrayList<String>();
			String qstnrPopup = "N";
			
			for(int i=0;i<qestnarDate.size();i++){
				Map<String, String> map = new HashMap<String, String>();
				map.put("qstnrSeq", qestnarDate.get(i));
				map.put("psnHakbun", (String) userVO.get("memCode"));
				
				String rsPsnSeq = mainDAO.selectQestnarPsnOne(map);
				
				if(EgovStringUtil.isEmpty(rsPsnSeq)){
						
					qstnrPopup = "Y";
					qestSeqs.add(qestnarDate.get(i));
					
				}
				
			}
			model.addAttribute("qstnrPopup", qstnrPopup);
			model.addAttribute("qstnrSeqs", qestSeqs);
			
		}
		
		return "/usr/index";
	}
	
	// 팝업 조회
	@RequestMapping("/usr/main/popupView.do")
	public String popupView(@RequestParam String popSeq, ModelMap model) throws Exception {
		LOGGER.info("/usr/main/popupView.do - 사용자 > 메인 > 팝업");
		PopupVO popupVO = mainDAO.selectPopupOne(popSeq);
		model.addAttribute("popupVO", popupVO);
		return "/usr/popupView";
	}
	
	// 센터소개 > 설립 취지
	@RequestMapping("/usr/main/wcInfoObjectView.do")
	public String wcInfoObjectView(HttpSession session) throws Exception {
		LOGGER.info("/usr/main/wcInfoObjectView.do - 사용자 > 센터소개 > 설립 취지");
		session.setAttribute("menuNo", "201");
		return "/usr/main/wcInfoObjectView";
	}
	
	// 센터소개 > 사고와표현 교육과정
	@RequestMapping("/usr/main/wcInfoCurrculumView.do")
	public String wcInfoCurrculumView(HttpSession session) throws Exception {
		LOGGER.info("/usr/main/wcInfoCurrculumView.do - 사용자 > 센터소개 > 사고와표현 교육과정");
		session.setAttribute("menuNo", "202");
		return "/usr/main/wcInfoCurrculumView";
	}
	
	// 센터소개 > 강좌소개
	@RequestMapping("/usr/main/wcInfoCourseView.do")
	public String wcInfoCourseView(HttpSession session) throws Exception {
		LOGGER.info("/usr/main/wcInfoCourseView.do - 사용자 > 센터소개 > 강좌소개");
		session.setAttribute("menuNo", "203");
		return "/usr/main/wcInfoCourseView";
	}
	
	// 강의와 첨삭 > 강의와 첨삭
	@RequestMapping("/usr/main/courseAndEditInfo01.do")
	public String courseAndEditInfo01(HttpSession session) throws Exception {
		LOGGER.info("/usr/main/courseAndEditInfo01.do - 사용자 > 강의와 첨삭 > 강의와 첨삭");
		session.setAttribute("menuNo", "301");
		return "/usr/main/courseAndEditInfo01";
	}
	
	// 강의와 첨삭 > 2017년도 운영 강좌
	@RequestMapping("/usr/main/courseAndEditInfo02.do")
	public String courseAndEditInfo02(HttpSession session) throws Exception {
		LOGGER.info("/usr/main/courseAndEditInfo02.do - 사용자 > 강의와 첨삭 > 2017년도 운영 강좌");
		session.setAttribute("menuNo", "302");
		return "/usr/main/courseAndEditInfo02";
	}
	
	// 강의와 첨삭 > 첨삭 시스템
	@RequestMapping("/usr/main/courseAndEditInfo03.do")
	public String courseAndEditInfo03(HttpSession session) throws Exception {
		LOGGER.info("/usr/main/courseAndEditInfo03.do - 사용자 > 강의와 첨삭 > 첨삭 시스템");
		session.setAttribute("menuNo", "303");
		return "/usr/main/courseAndEditInfo03";
	}
	
	// 게시판 > 비교과포인트 안내
	@RequestMapping("/usr/board/boardCompareNpointView.do")
	public String boardCompareNpointView(HttpSession session) throws Exception {
		LOGGER.info("/usr/board/boardCompareNpointView.do - 사용자 > 게시판 > 비교과포인트 안내");
		session.setAttribute("menuNo", "704");
		return "/usr/board/boardCompareNpointView";
	}
	
	// 설문조사 조회
	@RequestMapping("/usr/main/questionaireModify.do")
	public String questionaireModify(String qstnrSeq, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/usr/main/questionaireModify.do - 사용자 > 설문조사 조회");
		LOGGER.debug("qstnrSeq - "+qstnrSeq);
		
		QestnarVO resultVO = mainDAO.selectQestnarInfoOne(qstnrSeq);
		
		List<QestnarAskVO> qestnarAskVO = mainDAO.selectQestnarAskOne(qstnrSeq);
		List<QestnarReplyVO> qestnarReplyVO = mainDAO.selectQestnarReplyOne(qstnrSeq);
		
		searchVO.setSearchSemester(resultVO.getSmtrSeq());
		
		List<DepartmentVO> deptList = cmmDAO.selectDeptList(searchVO);
		model.addAttribute("deptList", deptList);
		
		List<ClassVO> clsList = cmmDAO.selectClsList(searchVO);
		model.addAttribute("clsList", clsList);
		
		model.addAttribute("resultVO", resultVO);
		model.addAttribute("qestnarAskList", qestnarAskVO);
		model.addAttribute("qestnarReplyList", qestnarReplyVO);
		
		return "/usr/questionaireModify";
	}
	
	
	//설문조사 등록
	@RequestMapping("/usr/main/questionaireUpdate.do")
	public String questionaireUpdate(QestnarPsnVO qestnarPsnVO, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/main/questionaireUpdate.do - 사용자 > 설문조사 등록");
		LOGGER.debug("qestnarPsnVO - "+qestnarPsnVO.toString());
		LOGGER.debug("qestnarPsnAnsVO - "+qestnarPsnVO.getAnsList().toString());
		
		Map<String, Object> userVO = (Map<String, Object>) EgovUserDetailsHelper.getAuthenticatedUser();
		
		Map<String, String> rsMap = new HashMap<String, String>();
		rsMap.put("qstnrSeq", qestnarPsnVO.getQstnrSeq());
		rsMap.put("psnHakbun", (String) userVO.get("memCode"));
		
		String rsSeq = mainDAO.selectQestnarPsnOne(rsMap);
		
		if(!EgovStringUtil.isEmpty(rsSeq)){
			LOGGER.info("이미 완료한 설문 조사 입니다.");
			model.addAttribute("message", "이미 완료한 설문 조사 입니다.");
			model.addAttribute("finish", true);
			return "/usr/questionaireModify";
		}
		if(EgovStringUtil.isEmpty(qestnarPsnVO.getClsSeq())){
			LOGGER.info("강의가 존재하지 않습니다.");
			model.addAttribute("message", "강의가 존재하지 않습니다.");
			model.addAttribute("finish", true);
			return "/usr/questionaireModify";
		}
		qestnarPsnVO.setPsnHakbun((String) userVO.get("memCode"));
		qestnarPsnVO.setPsnName((String) userVO.get("memName"));

		String rsPsnSeq = mainDAO.insertQestnarPsnOne(qestnarPsnVO);
		mainDAO.updateQestnarRespCount(qestnarPsnVO.getQstnrSeq());
		
		List<QestnarPsnAnsVO> ansList = qestnarPsnVO.getAnsList();
		for(int i=0;i<ansList.size();i++){
			//if(!("".equals(ansList.get(i).getPreNo()) || ansList.get(i).getPreNo() == null)){
			//if(!EgovStringUtil.isEmpty(ansList.get(i).getPreNo())){
				
				ansList.get(i).setPsnSeq(rsPsnSeq);
				if(ansList.get(i).getAskType().equals("3")){
					// 주관식
					Map<String, String> params = new HashMap<>();
					params.put("askNo", ansList.get(i).getAskNo());
					params.put("psnSeq", ansList.get(i).getPsnSeq());
					params.put("pansTxt", EgovWebUtil.clearXSSMinimum(ansList.get(i).getPansTxt()));
					
					mainDAO.insertQestnarAns(params);
					
				}else if(ansList.get(i).getAskType().equals("2")){
					// 복수형
					String rsPreNo[] = ansList.get(i).getPreNo().split(",");
					for(int j=0;j<rsPreNo.length;j++){
						QestnarPsnAnsVO rsPsnAnsVO = new QestnarPsnAnsVO(ansList.get(i).getAskNo(), rsPreNo[j], ansList.get(i).getPsnSeq());
						
						mainDAO.insertQestnarPsnAnsOne(rsPsnAnsVO);
						
						Map<String, String> map=new HashMap<String, String>();
						map.put("qstnrSeq", qestnarPsnVO.getQstnrSeq());
						map.put("askNo", ansList.get(i).getAskNo());
						map.put("repNo", rsPreNo[j]);
						mainDAO.updateQestnarRepChoiceCount(map);
					}
					
				}else if(ansList.get(i).getAskType().equals("1")){
					// 단답형
					mainDAO.insertQestnarPsnAnsOne(ansList.get(i));
					
					Map<String, String> map=new HashMap<String, String>();
					map.put("qstnrSeq", qestnarPsnVO.getQstnrSeq());
					map.put("askNo", ansList.get(i).getAskNo());
					map.put("repNo", ansList.get(i).getPreNo());
					mainDAO.updateQestnarRepChoiceCount(map);
					
				}
			//}
		}
	
		searchVO.setMessage("설문조사가 등록되었습니다."); 
		model.addAttribute("message", "설문조사가 등록되었습니다.");
		model.addAttribute("finish", true);
		return "/usr/questionaireModify";
		
		
	}
/*	
	// 임시
	@RequestMapping("/cmm/tmp/insert.do")
	public void tmpInsert(){
		cmmDAO.insert();
	}
*/
}
