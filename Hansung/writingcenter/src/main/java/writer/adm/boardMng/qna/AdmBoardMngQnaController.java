package writer.adm.boardMng.qna;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.AdminVO;
import writer.valueObject.QnaVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmBoardMngQnaController {
	
	private final static Logger LOGGER=LoggerFactory.getLogger(AdmBoardMngQnaController.class);
	
	private String logJob;
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	@Autowired private AdmBoardMngQnaDAO admQnaDAO;
	
	
	// 검색 조건을 가지고 목록페이지로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/xabdmxgr/boardMng/qna/admBoardMngQnaList.do";		// 목록
		
		return redirectPage;
		
	}
		
	//목록
	@RequestMapping("/xabdmxgr/boardMng/qna/admBoardMngQnaList.do")
	public String admBoardMngQnaList(ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO") CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/qna/admBoardMngQnaList.do - 관리자 > 게시판관리 > Q&A 목록");
		LOGGER.debug("searchVO - "+searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "402");
		
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=admQnaDAO.selectBoardMngQnaList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("listVO", listVO.getEgovList());
		return "/adm/boardMng/qna/admBoardMngQnaList";
	}
	
	//조회
	@RequestMapping("/xabdmxgr/boardMng/qna/admBoardMngQnaView.do")
	public String admBoardMngQnaView(ModelMap model, String qnaSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/qna/admBoardMngQnaView.do - 관리자 > 게시판관리 > Q&A 조회");
		LOGGER.debug("qnaSeq - "+qnaSeq);
		
		QnaVO resultVO=admQnaDAO.selectBoardMngQnaOne(qnaSeq);
		
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getRemoteAddr();
		logJob="게시판 관리 > Q&A 조회("+qnaSeq+")";
		admCmmLogDAO.insertLogOne(logJob, ip);
		
		if (resultVO == null) {
			searchVO.setMessage("글이 존재하지 않습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		// 스크립트 치환
		resultVO.setQstContent((EgovWebUtil.clearXSSMinimum(resultVO.getQstContent())).replaceAll("\r\n", "<br>"));
		resultVO.setAnsContent((EgovWebUtil.clearXSSMinimum(resultVO.getAnsContent())).replaceAll("\r\n", "<br>"));
		
		model.addAttribute("result",resultVO);
		return "/adm/boardMng/qna/admBoardMngQnaView";
	}
	
	//답변등록 화면
	@RequestMapping("/xabdmxgr/boardMng/qna/admBoardMngQnaModifyView.do")
	public String admBoardMngQnaModifyView(ModelMap model, String qnaSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/qna/admBoardMngQnaModifyView.do - 관리자 > 게시판관리 > Q&A 답변등록 화면");
		LOGGER.debug("qnaSeq - "+qnaSeq);
		
		QnaVO resultVO=admQnaDAO.selectBoardMngQnaOne(qnaSeq);
		
		
		if (resultVO == null) {
			searchVO.setMessage("글이 존재하지 않습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		// 스크립트 치환
		resultVO.setQstContent((EgovWebUtil.clearXSSMinimum(resultVO.getQstContent())).replaceAll("\r\n", "<br>"));
		//resultVO.setAnsContent((EgovWebUtil.clearXSSMinimum(resultVO.getAnsContent())).replaceAll("\r\n", "<br>"));
		
		model.addAttribute("result",resultVO);
		
		return "adm/boardMng/qna/admBoardMngQnaModify";
	}
	
	//답변 등록 & 수정
	@RequestMapping("/xabdmxgr/boardMng/qna/admBoardMngQnaModify.do")
	public String admBoardMngQnaModify(ModelMap model, QnaVO qnaVO, RedirectAttributes reda, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request) throws Exception {
		LOGGER.info("/xabdmxgr/boardMng/qna/admBoardMngModify.do - 관리자 > 게시판관리 > Q&A 답변 등록 & 수정");
		LOGGER.debug("QnaVO - "+qnaVO.toString());
		LOGGER.debug("QnaVO - "+searchVO.toString());
		
		if(EgovStringUtil.isEmpty(qnaVO.getAnsTitle())){
			searchVO.setMessage("제목이 입력되지 않았습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		if(EgovStringUtil.isEmpty(qnaVO.getAnsContent())){
			searchVO.setMessage("내용이 입력되지 않았습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}

		if(!EgovUserDetailsHelper.isAuthenticatedAdmin()){
			searchVO.setMessage("로그인 정보가 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		AdminVO adminVO=(AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		qnaVO.setAnsRegId(adminVO.getMemCode());
		qnaVO.setAnsRegName(adminVO.getMemName());
		admQnaDAO.updateBoardMngQnaOne(qnaVO);
		
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getRemoteAddr();
		logJob="게시판 관리 > Q&A 답변등록("+qnaVO.getQnaSeq()+")";
		admCmmLogDAO.insertLogOne(logJob, ip);
		
		searchVO.setMessage("등록되었습니다");
		
		return redirectListPage(searchVO, reda);
	}
	
	//삭제 
	@RequestMapping("/xabdmxgr/boardMng/qna/admBoardMngQnaDelete.do")
	public String admBoardMngQnaDelete(ModelMap model, String qnaSeq, RedirectAttributes reda, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request) throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/qna/admBoardMngQnaModify.do - 관리자 > 게시판관리 > Q&A 답변 등록 & 수정");
		LOGGER.debug("QnaVO - "+searchVO.toString());
		
		admQnaDAO.deleteBoardMngQnaOne(qnaSeq);
		
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getRemoteAddr();
		logJob="게시판 관리 > Q&A 질문삭제("+qnaSeq+")";
		admCmmLogDAO.insertLogOne(logJob, ip);
		
		searchVO.setMessage("삭제되었습니다.");
		return redirectListPage(searchVO, reda);
	}
}
