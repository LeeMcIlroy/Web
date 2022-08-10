package writer.usr.board.free;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.usr.cmm.CmmCmmtDAO;
import writer.usr.cmm.CmmnBoardDAO;
import writer.usr.cntst.CntstController;
import writer.valueObject.BoardVO;
import writer.valueObject.cmmn.CmmnCommentVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class BoardFreeController {

	private final static Logger LOGGER = LoggerFactory.getLogger(CntstController.class);
	@Autowired CmmnBoardDAO cmmnBoardDAO;
	@Autowired private CmmCmmtDAO cmmCmmtDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	@Resource View jsonView;
	
	// 검색 조건을 가지고 목록페이지(조회_주제목록)로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/usr/board/free/boardFreeList.do";		// 목록
		
		return redirectPage;
		
	}
		
	// 목록
	@RequestMapping("/usr/board/free/boardFreeList.do")
	public String boardFreeList(ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO")CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/usr/board/free/boardFreeList.do - 사용자 > 게시판 > 자유게시판 목록");
		LOGGER.debug("searchVO - "+searchVO.toString());
		request.getSession().setAttribute("menuNo", "703");
		
		searchVO.setSearchType("FREE");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=cmmnBoardDAO.selectCmmnBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/usr/board/free/boardFreeList";
	}
	
	
	
	// 조회
	@RequestMapping("/usr/board/free/boardFreeView.do")
	public String boardFreeView(ModelMap model, String brdSeq, @RequestParam(defaultValue="1") String pageCmmtIndex, @ModelAttribute("searchVO")CmmnSearchVO searchVO, RedirectAttributes reda, HttpSession session)throws Exception{
		LOGGER.info("/usr/board/free/boardFreeView.do - 사용자 > 게시판 > 자유게시판 조회");
		LOGGER.debug("brdSeq"+brdSeq);
		session.setAttribute("menuNo", "703");
		BoardVO boardVO=cmmnBoardDAO.selectCmmnBoardOne(brdSeq);
		
		List<EgovMap> upfileList=cmmnBoardDAO.selectCmmnBoardUpfileList(brdSeq);
		
		if(boardVO==null){
			searchVO.setMessage("게시글이 없습니다.");
			LOGGER.debug("message-"+searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}

		boardVO.setBrdContent(EgovWebUtil.clearXSSMinimum(boardVO.getBrdContent()).replaceAll("\r\n", "<br>"));
		
		model.addAttribute("boardVO",boardVO);
		model.addAttribute("upfileList", upfileList);
		// 댓글
		CmmnListVO cmmtListVO = cmmCmmtDAO.selectBoardMngFreeCommentList(brdSeq, pageCmmtIndex);
		
		for(EgovMap vo : cmmtListVO.getEgovList()){
			vo.put("cmtContent", (EgovWebUtil.clearXSSMinimum(vo.get("cmtContent").toString()).replaceAll("\r\n", "<br>")));
		}
		
		model.addAttribute("cmmtListCnt", cmmtListVO.getTotalRecordCount());
		model.addAttribute("cmmtList", cmmtListVO.getEgovList());
		
		return "/usr/board/free/boardFreeView";
	}
	
	// 등록&수정화면
	@RequestMapping("/usr/board/free/boardFreeModify.do")
	public String boardFreeModify(String brdSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, @RequestParam(value="fileDeleteChk", defaultValue="")String fileDeleteChk) throws Exception {
		LOGGER.info("/usr/board/free/boardFreeModify.do - 사용자 > 게시판 > 자유게시판 등록&수정화면");
		LOGGER.debug("serachVO = "+searchVO.toString());
		LOGGER.debug("brdSeq = "+brdSeq);
		BoardVO boardVO = null;
		if(EgovStringUtil.isEmpty(brdSeq)){
			// 등록화면
			boardVO = new BoardVO();
		}else{
			// 수정화면
			boardVO = cmmnBoardDAO.selectCmmnBoardOne(brdSeq);
			//boardVO.setBrdContent(boardVO.getBrdContent().replaceAll("<br>", "\r\n"));
/*
			// 첨부파일 삭제
			if (!EgovStringUtil.isEmpty(fileDeleteChk)) {
				String[] arrUpSeq = (fileDeleteChk).split(",");
				List<String> upSeqList = new ArrayList<>();
				for(String upSeq : arrUpSeq){
					EgovMap upfile = cmmnBoardDAO.selectCmmnBoardUpfileOne(upSeq);
					cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
					upSeqList.add(upSeq);
				}
				cmmnBoardDAO.deleteCmmnBoardUpfileList(upSeqList); // 데이터 삭제
			}
*/
			model.addAttribute("boardUpfileList", cmmnBoardDAO.selectCmmnBoardUpfileList(brdSeq));
		}
		model.addAttribute("boardVO", boardVO);
		return "/usr/board/free/boardFreeModify";
	}
		
	// 등록&수정
	@RequestMapping("/usr/board/free/boardFreeUpdate.do")
	public String boardFreeUpdate(BoardVO boardVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda, MultipartHttpServletRequest multiRequest) throws Exception {
		LOGGER.info("/usr/board/free/boardFreeUpdate.do - 사용자 > 게시판 > 자유게시판 등록&수정");
		LOGGER.debug("board = "+boardVO.toString());
		
		String message = "";
		String rsBrdSeq = "";
	
		
		// 첨부파일 조건확인
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("첨부된 파일이 잘못되었습니다.");
			searchVO.setMessage("첨부된 파일이 잘못되었습니다.");
			return redirectListPage(searchVO, reda);
		}
		
		boardVO.setBrdType("FREE");
		boardVO.setBrdNoticeYn("N");
		//boardVO.setBrdContent(EgovWebUtil.clearXSSMinimum(boardVO.getBrdContent()).replaceAll("\r\n", "<br>"));
		if(EgovStringUtil.isEmpty(boardVO.getBrdSeq())){
			// 등록
			rsBrdSeq = cmmnBoardDAO.insertCmmnBoardOne(boardVO);
			message = "등록되었습니다.";
		}else{
			// 수정
			cmmnBoardDAO.updateCmmnBoardOne(boardVO);
			rsBrdSeq = boardVO.getBrdSeq();
			message = "수정되었습니다.";
		}
		
		// 첨부파일
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "FREE");
		for(FileInfoVO vo : fileInfoList){
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("fileInfoVO", vo);
			map.put("brdSeq", rsBrdSeq);
			cmmnBoardDAO.insertCmmnBoardUpfileOne(map);
		}
/*
		// 첨부파일 삭제
		if (!EgovStringUtil.isEmpty(boardVO.getFileDeleteChk())) {
			String[] arrUpSeq = (boardVO.getFileDeleteChk()).split(",");
			List<String> upSeqList = new ArrayList<>();
			for(String upSeq : arrUpSeq){
				EgovMap upfile = cmmnBoardDAO.selectCmmnBoardUpfileOne(upSeq);
				cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
				upSeqList.add(upSeq);
			}
			cmmnBoardDAO.deleteCmmnBoardUpfileList(upSeqList); // 데이터 삭제
		}
*/
		searchVO.setMessage(message);
		
		return redirectListPage(searchVO, reda);
	}
	
	// 첨부파일 삭제
	@RequestMapping("/usr/board/free/boardFreeUpfileDelete.do")
	public View boardFreeUpfileDelete(@RequestParam String upSeq, ModelMap model) {
		LOGGER.info("/usr/board/free/boardFreeUpfileDelete.do - 사용자 > 게시판 > 자유게시판 > 첨부파일 삭제");
		LOGGER.debug("upSeq = {}", upSeq);
		
		int result = 1;
		
		try {
			EgovMap upfile = cmmnBoardDAO.selectCmmnBoardUpfileOne(upSeq);
			cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
			cmmnBoardDAO.deleteCmmnboardUpfileOne(upSeq);
			result = 0;
		}catch(Exception e){
			LOGGER.debug("자유게시판 첨부파일 삭제 오류 (message = {})", e.getMessage());
		}finally {
			model.addAttribute("result", result);
		}
		
		return jsonView;
	}
	
	// 삭제
	@RequestMapping("/usr/board/free/boardFreeDelete.do")
	public String boardFreeDelete(@RequestParam String brdSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/board/free/boardFreeDelete.do - 사용자 > 게시판 > 자유게시판 삭제");
		LOGGER.debug("brdSeq = "+brdSeq);
		
		cmmnBoardDAO.deleteCmmnBoardOne(brdSeq);
		searchVO.setMessage("삭제 되었습니다.");
		
		
		return redirectListPage(searchVO, reda);
	}
	
	// 댓글 더보기
	@RequestMapping("/usr/board/free/boardFreeCommentAddList.do")
	public View boardFreeCommentAddList(@RequestParam String brdSeq, @RequestParam String pageCmmtIndex, ModelMap model) throws Exception {
		LOGGER.info("/usr/board/free/boardFreeCommentAddList.do - 사용자 > 게시판 > 자유게시판 > 댓글 더보기");
		LOGGER.debug("brdSeq = "+brdSeq+", pageCmmtIndex = "+pageCmmtIndex);
		
		CmmnListVO cmmtListVO = cmmCmmtDAO.selectBoardMngFreeCommentList(brdSeq, pageCmmtIndex);
		model.addAttribute("cmmtList", cmmtListVO.getEgovList());
		return jsonView;
	}
	
	// 댓글 등록
	@RequestMapping("/usr/board/free/boardFreeCommentInsert.do")
	public String boardFreeCommentInsert(CmmnCommentVO commentVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/board/free/boardFreeCommentInsert.do - 사용자 > 게시판 > 자유게시판 > 댓글 등록");
		LOGGER.debug("commentVO = "+commentVO.toString());
		
		if (EgovStringUtil.isEmpty(commentVO.getCmtContent()) || EgovStringUtil.isEmpty(commentVO.getBrdSeq())) {
			searchVO.setMessage("내용 또는 원글 번호가 없습니다.(cmtContent = "+commentVO.getCmtContent()+", brdSeq = "+commentVO.getBrdSeq()+")");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		// 등록
		cmmCmmtDAO.boardMngFreeCommentInsert(commentVO);
		reda.addFlashAttribute("message", "댓글이 등록되었습니다.");
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addAttribute("brdSeq", commentVO.getBrdSeq());
		return "redirect:/usr/board/free/boardFreeView.do";
	}
	
	// 댓글 삭제
	@RequestMapping("/usr/board/free/boardFreeCommentDelete.do")
	public String boardFreeCommentDelete(@RequestParam String cmtSeq, @RequestParam String brdSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/board/free/boardFreeCommentDelete.do - 사용자 > 게시판 > 자유게시판 > 댓글 삭제");
		LOGGER.debug("cmtSeq = "+cmtSeq+", brdSeq = "+brdSeq);
		
		// 삭제
		cmmCmmtDAO.boardMngFreeCommentDelete(cmtSeq);
		searchVO.setMessage("댓글이 삭제되었습니다.");
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addAttribute("brdSeq", brdSeq);
		return "redirect:/usr/board/free/boardFreeView.do";		
	}
	
}
