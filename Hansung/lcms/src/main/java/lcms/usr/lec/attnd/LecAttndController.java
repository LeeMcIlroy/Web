package lcms.usr.lec.attnd;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.valueObject.AttachVO;
import lcms.valueObject.AttendVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecAttndController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecAttndController.class);
	
	@Autowired private LecAttndDAO lecAttndDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource View jsonView;
	
	//강사 - 출결 상세화면으로 리다이렉트합니다.
	private String redirectLecAttndList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/attnd/lecAttndList.do";
	}
	
	//강사 - 출결 상세화면으로 리다이렉트합니다.
	private String redirectLecAttndView(RedirectAttributes reda, String attDate, String lectClass, String message){
		reda.addFlashAttribute("attDate", attDate);
		reda.addFlashAttribute("lectClass", lectClass);
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/attnd/lecAttndView.do";
	}
	
	// 강사 - 출결 목록
	@RequestMapping("/usr/lec/attnd/lecAttndList.do")
	public String lecAttndList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/attnd/lecAttndList.do - 강사 - 출결 목록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("lecMenuNo", "301");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		searchVO.setMenuType(selLectCode);
		
		// 첫화면 로드 시 출석일자를 현재 날짜로 세팅
		if(EgovStringUtil.isEmpty(searchVO.getSearchDate())){
			searchVO.setSearchDate(EgovStringUtil.getDateMinus());
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = lecAttndDAO.selectLecAttndList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/usr/lec/attnd/lecAttndList";
	}
	
	// 강사 - 출결 상세
	@RequestMapping("/usr/lec/attnd/lecAttndView.do")
	public String lecAttndView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String attDate, String lectClass, HttpSession session, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/lec/Attnd/lecAttndView.do - 강사 - 출결 상세");
		request.getSession().setAttribute("lecMenuNo", "301");
		
		AttendVO attendVO = new AttendVO();
		
		EgovMap lecSession = (EgovMap) request.getSession().getAttribute("lecSession");
		
		if(!EgovStringUtil.isEmpty(attDate)){
			lecSession.put("attDate", attDate);
		}else{
			lecSession.put("attDate", EgovStringUtil.getDateMinus());
		}
		
		List<EgovMap> lectTimeList = lecAttndDAO.selectLectTime(lecSession);
		
		if(lectTimeList != null){
			List<EgovMap> memberList = lecAttndDAO.selectLecAttndMemberView(lecSession);
			attendVO.setAttendList(lecAttndDAO.selectLecAttndView(lecSession));
			
			model.addAttribute("lectTimeList", lectTimeList);
			model.addAttribute("lecSession", lecSession);
			model.addAttribute("attendVO", attendVO);
			model.addAttribute("memberList", memberList);
			model.addAttribute("attendList", attendVO.getAttendList());
			
			return "/usr/lec/attnd/lecAttndView";
		}else{
			String message = "수업 실시 날짜가 아닙니다.";
			return redirectLecAttndList(reda, message);
		}
	}
	
	// 강사 - 출결 비고 목록 조회
	@RequestMapping("/usr/lec/attnd/lecAjaxAttndEtcList.do")
	public View lecAjaxAttndEtcList(String lectSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/attnd/lecAjaxAttndEtcList.do - 강사 - 출결 비고 목록 조회");
		LOGGER.debug("lectSeq = " + lectSeq);
		
		List<EgovMap> resultList = lecAttndDAO.lecAjaxAttndEtcList(lectSeq);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 강사 - 출결 비고 조회
	@RequestMapping("/usr/lec/attnd/lecAjaxAttndEtc.do")
	public View lecAjaxAttndEtc(String attDate, String memberCode, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/attnd/lecAjaxAttndEtc.do - 강사 - 출결 비고 조회");
		LOGGER.debug("attDate = " + attDate + ", memberCode" + memberCode);
		
		String lectSeq = (String) request.getSession().getAttribute("selLectCode");
		
		EgovMap paramMap = new EgovMap();
		paramMap.put("lectSeq", lectSeq);
		paramMap.put("attDate", attDate);
		paramMap.put("memberCode", memberCode);
		
		EgovMap resultMap = lecAttndDAO.selectLecAjaxAttndEtc(paramMap);
		model.addAttribute("resultMap", resultMap);
		
		if(resultMap != null){
			EgovMap map = new EgovMap();
			map.put("boardSeq", resultMap.get("etcSeq"));
			map.put("boardType", "ETC");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
		}
		
		return jsonView;
	}

	// 강사 - 출결 비고 등록&수정
	@RequestMapping("/usr/lec/attnd/lecAjaxAttndEtcUpdate.do")
	public View lecAjaxAttndEtcUpdate(AttendVO attendVO, String deleteFile, HttpSession session, MultipartHttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/attnd/lecAjaxAttndEtcUpdate.do - 강사 - 출결 비고 등록&수정");
		LOGGER.debug("attendVO = " + attendVO.toString());
		String message = "";
		
		String lectSeq = (String) request.getSession().getAttribute("selLectCode");
		attendVO.setLectSeq(lectSeq);
		if(!EgovStringUtil.isEmpty(attendVO.getEtcSeq())){
			lecAttndDAO.updateLecAjaxAttndEtc(attendVO);
			message = "수정이 완료되었습니다.";
		}else{
			lecAttndDAO.insertLecAjaxAttndEtc(attendVO);
			message = "등록이 완료되었습니다.";
		}
		
		FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile(request, "ETC", attendVO.getEtcSeq());
		if(fileInfoVO != null){
			if(!EgovStringUtil.isEmpty(deleteFile)){
				AttachVO delAttach = cmmDAO.selectAttachOne(deleteFile);
				fileUtil.deleteFile(delAttach.getRegFileName());
				cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
			}
			
			AttachVO attachVO = new AttachVO(fileInfoVO);
			attachVO.setBoardType("ETC");
			attachVO.setBoardSeq(attendVO.getEtcSeq());
			
			cmmDAO.insertAttachFile(attachVO);
		}
			
		model.addAttribute("message", message);
		
		return jsonView;
	}

	// 강사 - 출결 등록&수정
	@RequestMapping("/usr/lec/attnd/lecAttndSubmit.do")
	public String lecAttndSubmit(@ModelAttribute("attendVO") AttendVO attendVO, HttpSession session, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/lec/Attnd/lecAttndSubmit.do - 강사 - 출결 등록&수정");
		LOGGER.debug("attendVO = " + attendVO.toString());
		request.getSession().setAttribute("lecMenuNo", "301");
		String message = "";
		
		List<AttendVO> attendList = attendVO.getAttendList();
		
		for(AttendVO resultVO : attendList){
			message = "저장되었습니다.";
			if(!EgovStringUtil.isEmpty(resultVO.getAttSeq())){
				lecAttndDAO.updateLecAttnd(resultVO);
			}else{
				if(!EgovStringUtil.isEmpty(resultVO.getAttend())){
					resultVO.setLectSeq(attendVO.getLectSeq());
					resultVO.setAttDate(attendVO.getAttDate());
					
					lecAttndDAO.insertLecAttnd(resultVO);
				}
			}
		}
		
		return redirectLecAttndView(reda, attendVO.getAttDate(), attendVO.getLectClass(), message);
	}
}
