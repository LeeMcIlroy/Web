package writer.adm.wcGuide.writInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import writer.adm.cmm.AdmCmmLogDAO;
import writer.adm.cmm.AdmCmmnBoardDAO;
import writer.valueObject.BoardVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdmWcGuideWritInfoController {
private static final Logger LOGGER = LoggerFactory.getLogger(AdmWcGuideWritInfoController.class);
	
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	@Autowired private AdmCmmnBoardDAO admBoardDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	/*********************************** 공통 ***********************************/
	// 검색 조건을 가지고 목록페이지(조회_주제목록)로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoList.do";		// 목록
		
		return redirectPage;
		
	}
	
	
	//목록
	@RequestMapping("/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoList.do")
	public String admWcGuideWritInfoList(ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO") CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoList.do - 관리자 > 글쓰기길잡이 > 글쓰기 정보 목록");
		LOGGER.debug("searchVO - "+searchVO);
		request.getSession().setAttribute("admMenuNo", "304");
		
		searchVO.setSearchType("WINFO");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=admBoardDAO.selectCmmnBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> noticeListVO = admBoardDAO.selectCmmnBoardNoticeList(searchVO.getSearchType());
		model.addAttribute("resultList_notice", noticeListVO);
		
		return "/adm/wcGuide/writInfo/admWcGuideWriteInfoList";
	}
	

	//글쓰기 & 수정 화면
	@RequestMapping("/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoModifyView.do")
	public String admWcGuideWritInfoModifyView(ModelMap model, @RequestParam("brdSeq")String brdSeq,  @ModelAttribute("searchVO") CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoModifyView.do - 관리자 > 글쓰기길잡이 > 글쓰기 정보 글쓰기 & 수정 화면");
		LOGGER.debug("brdSeq="+brdSeq);
		LOGGER.debug("searchVO - "+searchVO);
		
		BoardVO boardVO = null;
		if (EgovStringUtil.isEmpty(brdSeq)) {
			// 등록화면
			boardVO = new BoardVO();
		}else {
			// 수정화면
			boardVO=admBoardDAO.selectCmmnBoardOne(brdSeq);
			model.addAttribute("boardUpfileList",admBoardDAO.selectCmmnBoardUpfileList(brdSeq));
			
		}
		
		model.addAttribute("boardVO", boardVO);
		
		return "/adm/wcGuide/writInfo/admWcGuideWriteInfoModify";
	}
	
	
	//글쓰기 & 수정
	@RequestMapping("/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoModify.do")
	public String admWcGuideWritInfoModify(ModelMap model, BoardVO boardVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, RedirectAttributes reda, HttpServletRequest request)throws Exception{
		LOGGER.info("/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoModify.do - 관리자 > 글쓰기길잡이 > 글쓰기 정보 글쓰기 $ 수정");
		LOGGER.debug("boardVO - "+boardVO.toString());
		LOGGER.debug("searchVO - "+searchVO.toString());
		
		//제목 여부 및 공개여부 체크 확인
		if("".equals(boardVO.getBrdTitle()) || boardVO.getBrdTitle()==null){
			searchVO.setMessage("제목이 없습니다");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		if("".equals(boardVO.getBrdNoticeYn()) || boardVO.getBrdNoticeYn()==null){
			searchVO.setMessage("공개여부가 없습니다");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		// 첨부파일 조건확인
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("첨부된 파일이 잘못되었습니다.");
			searchVO.setMessage("첨부된 파일이 잘못되었습니다.");
			return redirectListPage(searchVO, reda);
		}
			
		String rsBrdSeq = "";
		String brdType = "";
		String logJob = "";
		
		if (EgovStringUtil.isEmpty(boardVO.getBrdSeq())) {
			// 등록
			boardVO.setBrdType("WINFO");
			brdType = "WINFO";
			logJob = "게시글 등록";
			rsBrdSeq=admBoardDAO.insertCmmnBoardOne(boardVO);
			searchVO.setMessage("등록되었습니다.");
		}else {
			// 수정
			brdType = "WINFO";
			logJob = "게시글 수정";
			admBoardDAO.updateCmmnBoardOne(boardVO, searchVO.getSearchType());
			rsBrdSeq=boardVO.getBrdSeq();
			searchVO.setMessage("수정되었습니다.");
		}
		
		
		// 첨부파일
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "WINFO");
		for(FileInfoVO vo : fileInfoList){
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("fileInfoVO", vo);
			map.put("brdSeq", rsBrdSeq);
			admBoardDAO.insertCmmnBoardUpfileOne(map);
		}
		// 첨부파일 삭제
		if (!EgovStringUtil.isEmpty(boardVO.getFileDeleteChk())) {
			String[] arrUpSeq = (boardVO.getFileDeleteChk()).split(",");
			List<String> upSeqList = new ArrayList<>();
			for(String upSeq : arrUpSeq){
				EgovMap upfile = admBoardDAO.selectCmmnBoardUpfileOne(upSeq);
				cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
				upSeqList.add(upSeq);
			}
			admBoardDAO.deleteCmmnBoardUpfileList(upSeqList); // 데이터 삭제
		}
	
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne_cmm(brdType, rsBrdSeq, logJob, ip);
		
		return redirectListPage(searchVO, reda);
	}
	
	//조회
	@RequestMapping("/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoView.do")
	public String admWcGuideWritInfoView(ModelMap model, @RequestParam("brdSeq")String brdSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, RedirectAttributes reda, HttpServletRequest request)throws Exception{
		LOGGER.info("/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoView.do - 관리자 > 글쓰기길잡이 > 글쓰기 정보 조회");
		LOGGER.debug("brdSeq - "+brdSeq);
		LOGGER.debug("searchVO - "+searchVO);
		
		BoardVO boardVO=admBoardDAO.selectCmmnBoardOne(brdSeq);
		List<EgovMap> listVO=admBoardDAO.selectCmmnBoardUpfileList(brdSeq);
		
		if (boardVO == null) {
			searchVO.setMessage("선택한글이 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		model.addAttribute("listVO",listVO);
		model.addAttribute("boardVO",boardVO);
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne_cmm(searchVO.getSearchType(), brdSeq, "게시글 조회", ip);
		return "/adm/wcGuide/writInfo/admWcGuideWriteInfoView";
	}
	
	//삭제
	@RequestMapping("/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoDelete.do")
	public String admWcGuideWritInfoDelete(ModelMap model, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, String brdSeq, HttpServletRequest request)throws Exception{
		LOGGER.info("/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoDelete.do - 관리자 > 글쓰기길잡이 > 글쓰기 정보 삭제");
		LOGGER.debug("searchVO - "+searchVO);
		LOGGER.debug("brdSeq - "+brdSeq);
		
		String brdSeqs[]=brdSeq.split(",");
		// 첨부파일 삭제
		for(int i=0;i<brdSeqs.length;i++){
			LOGGER.debug("brdSeqs - "+brdSeqs[i]);
			
			List<EgovMap> upfileList = admBoardDAO.selectCmmnBoardUpfileList(brdSeqs[i]);
			if(!(upfileList.size()==0 || upfileList==null)){
				List<String> upSeqList = new ArrayList<>();
				for(EgovMap upfile : upfileList){
					cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
					upSeqList.add(upfile.get("upSeq").toString());
				}
				admBoardDAO.deleteCmmnBoardUpfileList(upSeqList); // 데이터 삭제
			}
			admBoardDAO.deleteCmmnBoardOne(brdSeqs[i]);        // 주제 삭제
		}
		
		searchVO.setMessage("삭제되었습니다.");
		
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne_cmm(searchVO.getSearchType(), brdSeq, "게시글 삭제", ip);
		
		return redirectListPage(searchVO, reda);
	}
}