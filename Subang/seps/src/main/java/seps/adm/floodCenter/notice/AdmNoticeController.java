package seps.adm.floodCenter.notice;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import seps.cmmn.CmmnDAO;
import seps.valueObject.NoticeVO;
import seps.valueObject.UserInfoVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;
import valueObject.FileVO;
import component.file.CmmnFileMngUtil;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdmNoticeController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmNoticeController.class);
	
	@Resource View jsonView;
	@Autowired AdmNoticeDAO dao;
	@Autowired CmmnDAO cmmnDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/adm/floodCenter/noticeList.do";
	}
	
	/**
	 * 공지사항설정 목록 화면
	 * @param searchVO
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/floodCenter/noticeList.do")
	public String noticeList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/floodCenter/noticeList.do - 공지사항설정 목록 화면");
		if(session != null) session.setAttribute("leftMeneNo", "301");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		
		CmmnListVO listVO = dao.selectNoticeList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		// 공지글
		model.addAttribute("resultList2", dao.selectNoticeList2());
		
		return "/adm/floodCenter/notice/noticeList";
	}
	
	/**
	 * 공지사항설정 조회화면
	 * @param searchVO
	 * @param model
	 * @param noticeId
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping("/adm/floodCenter/noticeView.do")
	public String noticeView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String noticeId, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/floodCenter/noticeView.do - 공지사항설정 조회화면");
		LOGGER.debug("noticeId > "+noticeId);
		
		NoticeVO returnVO = dao.selectNoticeView(noticeId);
		model.addAttribute("noticeVO", returnVO);
		model.addAttribute("fileVO", cmmnDAO.selectFileBoard("N", noticeId));
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/floodCenter/notice/noticeView";
	}
	
	/**
	 *  공지사항설정 등록 화면
	 * @param searchVO
	 * @param noticeId
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/floodCenter/noticeModify.do")
	public String noticeModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String noticeId, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/floodCenter/noticeModify.do - 공지사항설정 등록&수정 화면");
		
		UserInfoVO sessionVO = (UserInfoVO) EgovUserDetailsHelper.getAuthenticatedUser();
		NoticeVO returnVO = new NoticeVO();
		if(!EgovStringUtil.isEmpty(noticeId)){
			returnVO = dao.selectNoticeView(noticeId);
			returnVO.setUdtNm(sessionVO.getUserNm());
			model.addAttribute("fileVO", cmmnDAO.selectFileBoard("N", noticeId));
		}
		returnVO.setRegNm(sessionVO.getUserNm());
		model.addAttribute("noticeVO", returnVO);
		model.addAttribute("searchVO", searchVO);
		return "/adm/floodCenter/notice/noticeModify";
	}
	
	// 첨부파일 삭제
	@RequestMapping("/adm/floodCenter/noticeUploadFileDelete.do")
	public View noticeUploadFileDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, @RequestParam String attachFileId, ModelMap model) throws Exception {
		LOGGER.info("/adm/floodCenter/noticeUploadFileDelete.do - 관리자 > 수방센터 > 공지사항 등록&수정화면 - 첨부파일 삭제");
		LOGGER.debug("attachedFileId = {}", attachFileId);
		
		String result = "1";
		EgovMap fileVO = cmmnDAO.selectFile(attachFileId);
		if(fileVO != null){
			// 파일 삭제
			cmmnFileMngUtil.deleteFile(fileVO.get("saveFileNm").toString());
			
			// 데이터 삭제
			cmmnDAO.deletetFile(attachFileId);
			
			result = "0";
		}
		model.addAttribute("result", result);
		return jsonView;
	}
	
	/**
	 *  공지사항설정 등록&수정 처리
	 * @param searchVO
	 * @param paramVO
	 * @param model
	 * @param session
	 * @param request
	 * @param reda
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/floodCenter/noticeSubmit.do")
	public String noticeSubmit(@ModelAttribute("searchVO") CmmnSearchVO searchVO, NoticeVO paramVO, String fileDelChk, ModelMap model, HttpSession session, MultipartHttpServletRequest multiRequest, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/floodCenter/noticeSubmit.do - 공지사항설정 등록&수정 처리");
		LOGGER.debug("paramVO >> " +paramVO.toString());
		LOGGER.debug("fileDelChk >> " + fileDelChk);
		String message = "등록되었습니다";
		
		//첨부파일 확인
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("첨부된 파일의 용량 또는 확장자가 잘못되었습니다.");
			message = "첨부된 파일의 용량 또는 확장자가 잘못되었습니다.";
			return redirectListPage(message, searchVO, reda);
		}
		
		
		if(EgovStringUtil.isEmpty(paramVO.getNoticeId())){
			//공지사항 등록
			paramVO.setNoticeId(dao.insertNotice(paramVO));
		}else{
			//공지사항 수정
			dao.updateNotice(paramVO);
			message = "수정되었습니다.";
/*
			//첨부파일 삭제
			if(fileDelChk != null){
				cmmnDAO.deletetFile(fileDelChk);
			}
*/
		}
		

		/*첨부파일 존재할시 등록*/
		if(cmmnFileMngUtil.uploadFileRegiChk(multiRequest)){
			FileVO fileParamVO = new FileVO(cmmnFileMngUtil.uploadAttachedFile(multiRequest, "NOTICE"));
			fileParamVO.setBoardId(paramVO.getNoticeId());
			fileParamVO.setBoardType("N");
			fileParamVO.setRegNm(paramVO.getRegNm());
			cmmnDAO.insertFile(fileParamVO);
		}
		
		return redirectListPage( message, searchVO, reda);
	}
	
	/**
	 *  공지사항설정 삭제 처리
	 * @param searchVO
	 * @param noticeId
	 * @param model
	 * @param session
	 * @param request
	 * @param reda
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/floodCenter/noticeDelete.do")
	public String noticeDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String noticeId, ModelMap model, HttpSession session, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/floodCenter/noticeSubmit.do - 공지사항설정 삭제 처리");

		EgovMap fileVO = cmmnDAO.selectFileBoard("N", noticeId);
		if(fileVO != null){
			// 파일 삭제
			cmmnFileMngUtil.deleteFile(fileVO.get("saveFileNm").toString());
			
			// 데이터 삭제
			cmmnDAO.deletetFile(fileVO.get("attachFileId").toString());
		}
		
		dao.deleteNotice(noticeId);
		return redirectListPage( "삭제되었습니다", searchVO, reda);
	}
	

}
