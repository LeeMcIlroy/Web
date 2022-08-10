package writer.usr.board.qna;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import writer.valueObject.QnaVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class BoardQnaController {

	private final static Logger LOGGER = LoggerFactory.getLogger(BoardQnaController.class);
	@Autowired private BoardQnaDAO boardQnaDAO;
	
	
	// 검색 조건을 가지고 목록페이지로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/usr/board/qna/boardQnaList.do";		// 목록
		
		return redirectPage;
		
	}
	// 목록
	@RequestMapping("/usr/board/qna/boardQnaList.do")
	public String boardQnaList(ModelMap model, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request)throws Exception{
		LOGGER.info("/usr/board/qna/boardQnaList.do - 사용자 > 게시판 > Q&A 목록");
		LOGGER.debug("searchVO - "+searchVO.toString());
		request.getSession().setAttribute("menuNo", "702");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=boardQnaDAO.selectBoardQnaList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/usr/board/qna/boardQnaList";
	}
	
	// 글쓰기 & 수정 화면
	@RequestMapping("/usr/board/qna/boardQnaModifyView.do")
	public String boardQnaModifyView(ModelMap model, @ModelAttribute("searchVO")CmmnSearchVO searchVO, String qnaSeq, RedirectAttributes reda, HttpSession session)throws Exception{
		LOGGER.info("/usr/board/qna/boardQnaModifyView.do - 사용자 > 게시판 > Q&A 글쓰기 & 수정 화면");
		LOGGER.debug("qnaSeq - "+qnaSeq);
		
			
		QnaVO qnaVO=null;
		if(EgovStringUtil.isEmpty(qnaSeq)){
			//등록
			qnaVO=new QnaVO();
		}else{
			//수정
			qnaVO=boardQnaDAO.selectBoardQnaOne(qnaSeq);
			
			if (qnaVO == null) {
				searchVO.setMessage("글이 존재하지 않습니다.");
				LOGGER.debug(searchVO.getMessage());
				return redirectListPage(searchVO, reda);
			}
			
			
		}
		model.addAttribute("qnaVO", qnaVO);
		return "/usr/board/qna/boardQnaModify";
	}
	
	// 등록 & 수정
	@RequestMapping("/usr/board/qna/boardQnaModify.do")
	public String boardQnaModify(ModelMap model, @ModelAttribute("searchVO")CmmnSearchVO searchVO, QnaVO qnaVO, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/board/qna/boardQnaModify.do - 사용자 > 게시판 > Q&A 등록 & 수정");
		LOGGER.debug("qnaVO - "+qnaVO.toString());
		
		@SuppressWarnings("unchecked")
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		
		qnaVO.setQstRegId(userVO.get("memCode"));
		qnaVO.setQstRegName(userVO.get("memName"));
		
		if("".equals(qnaVO.getQstTitle()) || qnaVO.getQstTitle()==null){
			searchVO.setMessage("제목이 입력되지 않았습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		if("".equals(qnaVO.getQstContent()) || qnaVO.getQstContent()==null){
			searchVO.setMessage("내용이 입력되지 않았습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		if(EgovStringUtil.isEmpty(qnaVO.getQnaSeq())){
			//등록
			boardQnaDAO.insertBoardQnaOne(qnaVO);
		}else{
			//수정
			boardQnaDAO.updateBoardQnaOne(qnaVO);
		}
		searchVO.setMessage("등록되었습니다.");
		LOGGER.debug("searchVO - "+searchVO.toString());
		return redirectListPage(searchVO, reda);
	}
	
	//조회
	@RequestMapping("/usr/board/qna/boardQnaView.do")
	public String boardQnaView(ModelMap model, String qnaSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, RedirectAttributes reda, HttpSession session)throws Exception{
		LOGGER.info("/usr/board/qna/boardQnaView.do - 사용자 > 게시판 > Q&A 조회");
		LOGGER.debug("qnaSeq - "+qnaSeq);
		
		session.setAttribute("menuNo", "702");
		
		QnaVO qnaVO = boardQnaDAO.selectBoardQnaOne(qnaSeq);
		if (qnaVO == null) {
			searchVO.setMessage("글이 존재하지 않습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		qnaVO.setQstContent((EgovWebUtil.clearXSSMinimum(qnaVO.getQstContent())).replaceAll("\r\n", "<br>"));
		
		qnaVO.setAnsContent((EgovWebUtil.clearXSSMinimum(qnaVO.getAnsContent())).replaceAll("\r\n", "<br>"));

		model.addAttribute("qnaVO",qnaVO);
		return "/usr/board/qna/boardQnaView";
	}
	
	//삭제
	@RequestMapping("/usr/board/qna/boardQnaDelete.do")
	public String boardQnaDelete(ModelMap model, String qnaSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, RedirectAttributes reda )throws Exception{
		LOGGER.info("/usr/board/qna/boardQnaDelete.do - 사용자 > 게시판 > Q&A 삭제");
		LOGGER.debug("qnaSeq - "+qnaSeq);
		
		boardQnaDAO.deleteBoardQnaOne(qnaSeq);
		
		searchVO.setMessage("삭제되었습니다.");
		LOGGER.debug(searchVO.getMessage());
		return redirectListPage(searchVO, reda);
	}
}
