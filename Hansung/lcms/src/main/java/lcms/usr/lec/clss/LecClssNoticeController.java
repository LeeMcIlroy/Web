package lcms.usr.lec.clss;

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
import lcms.usr.lec.com.LecComDAO;
import lcms.valueObject.AttachVO;
import lcms.valueObject.CountryVO;
import lcms.valueObject.EvalVO;
import lcms.valueObject.LecClssNoticeVO;
import lcms.valueObject.LectureVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecClssNoticeController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecClssNoticeController.class);
	
	@Autowired private LecClssNoticeDAO lecClssNoticeDAO;
	@Resource View jsonView;
	@Resource private CmmnFileMngUtil fileUtil;
	
	// 강사 - 수업 - 강의공지 목록 화면
	@RequestMapping("/usr/lec/clss/lecClssNoticeList.do")
	public String lecClssNoticeList(@ModelAttribute("lecClssNoticeVO") LecClssNoticeVO lecClssNoticeVO, HttpSession session, HttpServletRequest request, ModelMap model, LectureVO lectureVO, String lcnotiSeq) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssNoticeList.do - 강사 -수업-강의공지 목록 화면");
		request.getSession().setAttribute("lecMenuNo", "102");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		request.getSession().setAttribute("selLectCode", selLectCode);
		lecClssNoticeVO.setLectCode(selLectCode);

		//세션값 비교
		EgovMap lecSession = (EgovMap)session.getAttribute("lecSession");
		String lectSemNm = (((String)lecSession.get("lectSem")).equals("1")?"봄학기":((String)lecSession.get("lectSem")).equals("2")?"여름학기":((String)lecSession.get("lectSem")).equals("3")?"가을학기":"겨울학기");
		String lectSemYear = (((String)lecSession.get("lectYear")));
		model.addAttribute("lectSemNm", lectSemNm);
		model.addAttribute("lectSemYear", lectSemYear);
		
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(lecClssNoticeVO);
		CmmnListVO listVO = lecClssNoticeDAO.LecClssNoticeList(lecClssNoticeVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
			
//		CmmnListVO attachList = lecClssNoticeDAO.selectAttachListFiles(lecClssNoticeVO);
//		model.addAttribute("attachList", attachList.getEgovList());

		EgovMap map = new EgovMap();
		List<AttachVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/usr/lec/clss/lecClssNoticeList";
	}
	
	// 강사 - 수업 - 강의공지 상세 화면
	@RequestMapping("/usr/lec/clss/lecClssNoticeView.do")
	public String lecClssNoticeView(HttpSession session, HttpServletRequest request, ModelMap model, LecClssNoticeVO lecClssNoticeVO) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssNoticeView.do - 강사 -수업-강의공지 상세 화면");
		request.getSession().setAttribute("lecMenuNo", "102");
		
		String lcnotiSeq = lecClssNoticeVO.getLcnotiSeq();
		EgovMap noticeMap =  lecClssNoticeDAO.selectLcnotiOne(lcnotiSeq);

		model.addAttribute("leftMenuType", "102");
		model.addAttribute("topMenuType", "10");
		model.addAttribute("result", noticeMap);
		
		if(!EgovStringUtil.isEmpty(lcnotiSeq)){
			lcnotiSeq = lecClssNoticeVO.getLcnotiSeq();
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", lcnotiSeq);
			map.put("boardType", "LEC");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
					
			model.addAttribute("attachList", attachList);
			
		}
		
		return "/usr/lec/clss/lecClssNoticeView";
	}
	
//	// 강사 - 수업 - 강의공지 등록/수정 화면
//	@RequestMapping("/usr/lec/clss/lecClssNoticeModify.do")
//	public String lecClssNoticeModify(@ModelAttribute("lecClssNoticeVO") LecClssNoticeVO lecClssNoticeVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
//		LOGGER.debug("/usr/lec/clss/lecClssNoticeModify.do - 강사 -수업-강의공지 등록/수정 화면");
//		request.getSession().setAttribute("lecMenuNo", "102");
//		
//		if(lecClssNoticeVO.getLcnotiSeq() != null){
//			String lcnotiSeq = lecClssNoticeVO.getLcnotiSeq();
//			EgovMap map = lecClssNoticeDAO.selectLcnotiOne(lcnotiSeq);
//			model.addAttribute("lecClssNoticeVO", map);
//		}
//		
//		return "/usr/lec/clss/lecClssNoticeModify";
//	}
		// 강사 - 수업 - 강의공지 등록/수정 화면
		@RequestMapping("/usr/lec/clss/lecClssNoticeModify.do")
		public String admStatusModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String deleteFile,HttpServletRequest request, ModelMap model, String lcnotiSeq) throws Exception {
			LOGGER.debug("lcnotiSeq = " + lcnotiSeq);
			LOGGER.debug("/usr/lec/clss/lecClssNoticeModify.do - 강사 -수업-강의공지 등록/수정 화면");
			LOGGER.debug("searchVO = " + searchVO.toString());
			request.getSession().setAttribute("admMenuNo", "301");
			
			LecClssNoticeVO lecClssNoticeVO = new LecClssNoticeVO();
			
			String selLectCode = (String) request.getSession().getAttribute("selLectCode");
			lecClssNoticeVO.setLectCode(selLectCode);
			
			if(!EgovStringUtil.isEmpty(lcnotiSeq)){
				lecClssNoticeVO = lecClssNoticeDAO.selectlecClssNotice(lcnotiSeq);
				EgovMap map = new EgovMap();
				map.put("boardSeq", lcnotiSeq);
				map.put("boardType", "LEC");
				List<AttachVO> attachList = cmmDAO.selectAttachList(map);
				model.addAttribute("attachList", attachList);
			}
			
			model.addAttribute("lecClssNoticeVO", lecClssNoticeVO);
			
			return "/usr/lec/clss/lecClssNoticeModify";
		}
	
	// 강사 - 과제 등록/수정
	@RequestMapping("/usr/lec/clss/lecClssAddNotice.do")
	public String lecClssAddNotice(MultipartHttpServletRequest request, ModelMap model, @ModelAttribute("lecClssNoticeVO") LecClssNoticeVO lecClssNoticeVO,String[] delSeqList, String deleteFile, RedirectAttributes reda,  HttpSession session) throws Exception {
				LOGGER.debug("/usr/lec/clss/lecClssAddNotice.do - 강사 - 과제 등록/수정");

		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		request.getSession().setAttribute("lecMenuNo", "102");
		String message = "";
		
		lecClssNoticeVO.setLectCode(selLectCode);

		if(!EgovStringUtil.isEmpty(lecClssNoticeVO.getLcnotiSeq())){
			lecClssNoticeDAO.lecClssEditNoti(lecClssNoticeVO);
			
//			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile(request, "LEC", lecClssNoticeVO.getLcnotiSeq());

			if(delSeqList != null){
				for(String delSeq : delSeqList){
					AttachVO delAttach = cmmDAO.selectAttachOne(delSeq);
					fileUtil.deleteFile(delAttach.getRegFileName());
					cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
				}
			}
			message = "수정이 완료되었습니다.";
		}else{
			lecClssNoticeDAO.lecClssAddNoti(lecClssNoticeVO);
		}
		List<FileInfoVO> fileInfoList = fileUtil.uploadAttachedFiles(request, "LEC");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("LEC");
				attachVO.setBoardSeq(lecClssNoticeVO.getLcnotiSeq());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
			message = "등록이 완료되었습니다.";
		
		return redirectlecNoticeList(reda, message);
	}
	
	
	
	// 교사 강의공지 삭제
	@RequestMapping("/usr/lec/clss/lecClssNoticeDelete.do")
	public String admStatusDelete(@ModelAttribute("lecClssNoticeVO") LecClssNoticeVO lecClssNoticeVO, String deleteFile, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssNoticeDelete.do - 교사 강의공지 삭제");
		LOGGER.debug("lecClssNoticeVO = " + lecClssNoticeVO.toString());
		request.getSession().setAttribute("lecMenuNo", "102");
		String message = "";
		
		if(!EgovStringUtil.isEmpty(deleteFile)){
			AttachVO delAttach = cmmDAO.selectAttachOne(deleteFile);
			fileUtil.deleteFile(delAttach.getRegFileName());
			cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
		}
		
		String lcnotiSeq = lecClssNoticeVO.getLcnotiSeq();
		lecClssNoticeDAO.deletelecNotice(lcnotiSeq);
					
		return redirectlecNoticeList(reda, message);
	}
	
	private String redirectlecNoticeList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/clss/lecClssNoticeList.do";
	}
	
}
