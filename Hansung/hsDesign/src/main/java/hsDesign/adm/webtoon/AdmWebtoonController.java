package hsDesign.adm.webtoon;

import java.util.List;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.WebtoonVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmWebtoonController extends AdmCmmController {
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmWebtoonController.class);
	
	@Autowired private AdmWebtoonDAO webtoonDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	// 검색조건을 가지고 한툰 목록으로 이동합니다
	private String redirectWebtoonListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxerpynm/webtoon/admWebtoonList.do";
	}
	
	// 목록
	@RequestMapping("/qxerpynm/webtoon/admWebtoonList.do")
	public String admWebtoonList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/webtoon/admWebtoonList.do - 관리자 > 한디원뉴스 > 한툰");
		LOGGER.debug("searchVO = {}", searchVO.toString());
		
		// incLeftMenu set - start
		session.setAttribute("admMenuNo", "405");
		// incLeftMenu set - end

		// webtoon category set - start
		model.addAttribute("webtoonCategory", webtoonDAO.selectWebtoonCategoryList(null));
		// webtoon category set - end

		// webtoon list - start
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		CmmnListVO listVO = webtoonDAO.selectWebtoonList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		// webtoon list - end
		
		// log set - start
		admLogInsert(null, "한툰", "목록", request);
		// log set - end
		
		return "/adm/webtoon/admWebtoonList";
	}
	
	// 조회
	@RequestMapping("/qxerpynm/webtoon/admWebtoonView.do")
	public String admWebtoonView(@RequestParam String wSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/webtoon/admWebtoonView.do - 관리자 > 한디원뉴스 > 한툰 조회");
		LOGGER.debug("wSeq = {}", wSeq);
		model.addAttribute("resultVO", webtoonDAO.selectWebtoonOne(wSeq));
		// log set - start
		admLogInsert(null, "한툰", String.format("조회 | wSeq = %s", wSeq), request);
		// log set - end
		return "/adm/webtoon/admWebtoonView";
	}
	
	// 웹툰 등록&수정 화면
	@RequestMapping("/qxerpynm/webtoon/admWebtoonModify.do")
	public String admWebtoonModify(String wSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/webtoon/admWebtoonModify.do - 관리자 > 한디원뉴스 > 한툰 등록&수정화면");
		LOGGER.debug("wSeq = {}", wSeq);
		
		WebtoonVO webtoonVO = null;
		if(EgovStringUtil.isEmpty(wSeq)){
			// 등록
			webtoonVO = new WebtoonVO();
		}else{
			// 수정
			webtoonVO = webtoonDAO.selectWebtoonOne(wSeq);
		}
		model.addAttribute("webtoonVO", webtoonVO);
		
		// webtoon category set - start
		model.addAttribute("webtoonCategory", webtoonDAO.selectWebtoonCategoryList(null));
		// webtoon category set - end
		
		// log set - start
		admLogInsert(null, "한툰", (EgovStringUtil.isEmpty(wSeq))? "등록화면":String.format("수정화면 | wSeq = %s", wSeq), request);
		// log set - end
		
		return "/adm/webtoon/admWebtoonModify";
	}
	
	// 웹툰 등록&수정
	@RequestMapping("/qxerpynm/webtoon/admWebtoonUpdate.do")
	public String admWebtoonUpdate(WebtoonVO webtoonVO, MultipartHttpServletRequest multiRequest, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/webtoon/admWebtoonUpdate.do - 관리자 > 한디원뉴스 > 한툰 등록&수정");
		LOGGER.debug("webtoonVO = {}", webtoonVO);
		
		String message = "오류발생(-3)";
		String rsWSeq = "";
		
		// 파일 용량 검사
		if(!cmmnFileMngUtil.uploadFileSizeChk(multiRequest)){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardUpdate.do - 오류발생(-4) : fileSize check...");
			return redirectWebtoonListPage("오류발생(-4)", null, reda);
		}
		
		// 파일 확장자 검사
		if(!cmmnFileMngUtil.uploadFileImgExtChk(multiRequest)){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardUpdate.do - 오류발생(-5) : fileExt check...");
			return redirectWebtoonListPage("오류발생(-5)", null, reda);
		}
		
		if(EgovStringUtil.isEmpty(webtoonVO.getwSeq())){
			// 등록
			rsWSeq = webtoonDAO.webtoonInsert(webtoonVO);
			message = "등록되었습니다.";
		}else{
			// 수정
			webtoonDAO.webtoonUpdate(webtoonVO);
			rsWSeq = webtoonVO.getwSeq();
			
			// 업로드 파일이 있으면 기존 파일을 삭제
			if(cmmnFileMngUtil.uploadFileRegiChk(multiRequest)){
				WebtoonVO result = webtoonDAO.selectWebtoonOne(rsWSeq);
				
				// 원본파일 삭제
				cmmnFileMngUtil.deleteFile(result.getwThImgPath());
				
				// thumbnail 삭제
				String fileExt = result.getwThImgPath().substring(result.getwThImgPath().lastIndexOf(".")+1);
				String filePath = result.getwThImgPath().substring(0, result.getwThImgPath().lastIndexOf("."));
				String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
				cmmnFileMngUtil.deleteFile(fileThumbPath);
			}
			message = "수정되었습니다.";
		}
		
		// 첨부파일 등록
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "WEBTOON_THUMB");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				webtoonDAO.webtoonThumbnailInsert(fileInfoVO, rsWSeq);
			}
		}
		
		// log set - start
		admLogInsert(null, "한툰", (EgovStringUtil.isEmpty(webtoonVO.getwSeq()))? "등록":String.format("수정 | wSeq = %s", webtoonVO.getwSeq()), request);
		// log set - end
		
		return redirectWebtoonListPage(message, null, reda);
	}
	
	// 웹툰 삭제
	@RequestMapping("/qxerpynm/webtoon/admWebtoonDelete.do")
	public String admWebtoonDelete(@RequestParam String wSeq, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/webtoon/admWebtoonDelete.do - 관리자 > 한디원뉴스 > 한툰 삭제");
		LOGGER.debug("wSeq = {}", wSeq);
		
		WebtoonVO resultVO = webtoonDAO.selectWebtoonOne(wSeq);
		
		// 이미지 삭제 - start
			// 원본파일 삭제
			cmmnFileMngUtil.deleteFile(resultVO.getwThImgPath());
			
			// thumbnail 삭제
			String fileExt = resultVO.getwThImgPath().substring(resultVO.getwThImgPath().lastIndexOf(".")+1);
			String filePath = resultVO.getwThImgPath().substring(0, resultVO.getwThImgPath().lastIndexOf("."));
			String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
			cmmnFileMngUtil.deleteFile(fileThumbPath);
		// 이미지 삭제 - end
			
		// 글 삭제 - start
		webtoonDAO.webtoonDelete(wSeq);
		// 글 삭제 - end
		
		// log set - start
		admLogInsert(null, "한툰", String.format("삭제 | wSeq = %s", wSeq), request);
		// log set - end
		
		return redirectWebtoonListPage("삭제되었습니다.", null, reda);
	}
	
	/************************************************************** 웹툰 카테고리 **************************************************************/
	// 웹툰 관리 목록
	@RequestMapping("/qxerpynm/webtoon/admWebtoonCategoryList.do")
	public String admWebtoonCategoryList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/webtoon/admWebtoonCategoryList.do - 관리자 > 한디원뉴스 > 한툰 > 웹툰관리 목록");
		LOGGER.debug("searchVO = {}", searchVO.toString());

		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		List<WebtoonVO> resultList = webtoonDAO.selectWebtoonCategoryList(searchVO);
		paginationInfo.setTotalRecordCount(webtoonDAO.selectWebtoonCategoryListCnt(searchVO));
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);

		// log set - start
		admLogInsert(null, "한툰 관리", "목록", request);
		// log set - end
		
		return "/adm/webtoon/admWebtoonCategoryList";
	}
	
	// 웹툰 관리 등록&수정 화면
	@RequestMapping("/qxerpynm/webtoon/admWebtoonCategoryModify.do")
	public String admWebtoonCategoryModify(String wcSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/webtoon/admWebtoonCategoryModify.do - 관리자 > 한디원뉴스 > 한툰 > 웹툰관리 등록&수정화면");
		LOGGER.debug("wcSeq = {}", wcSeq);
		
		WebtoonVO webtoonVO = null;
		
		if(EgovStringUtil.isEmpty(wcSeq)){
			// 등록
			webtoonVO = new WebtoonVO();
		}else{
			// 수정
			webtoonVO = webtoonDAO.selectWebtoonCategoryOne(wcSeq);
		}
		model.addAttribute("webtoonVO", webtoonVO);
		
		// log set - start
		admLogInsert(null, "한툰 관리", (EgovStringUtil.isEmpty(wcSeq))? "등록화면":String.format("수정화면 | wcSeq = %s", wcSeq), request);
		// log set - end
		return "/adm/webtoon/admWebtoonCategoryModify";
	}
	
	// 웹툰 관리 등록&수정
	@RequestMapping("/qxerpynm/webtoon/admWebtoonCategoryUpdate.do")
	public String admWebtoonCategoryUpdate(WebtoonVO webtoonVO, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/webtoon/admWebtoonCategoryUpdate.do - 관리자 > 한디원뉴스 > 한툰 > 웹툰관리 등록&수정");
		LOGGER.debug("webtoonVO = {}", webtoonVO.toString());
		String message = "오류발생(-1)";
		if(EgovStringUtil.isEmpty(webtoonVO.getWcSeq())){
			// 등록
			webtoonDAO.webtoonCategoryInsert(webtoonVO);
			message = "등록되었습니다.";
		}else{
			// 수정
			webtoonDAO.webtoonCategoryUpdate(webtoonVO);
			message = "수정되었습니다.";
		}
		reda.addFlashAttribute("message", message);
		
		// log set - start
		admLogInsert(null, "한툰 관리", (EgovStringUtil.isEmpty(webtoonVO.getWcSeq()))? "등록화면":String.format("수정화면 | wcSeq = %s", webtoonVO.getWcSeq()), request);
		// log set - end
		return "redirect:/qxerpynm/webtoon/admWebtoonCategoryList.do";
	}
	
	// 웹툰 관리 삭제
	@RequestMapping("/qxerpynm/webtoon/admWebtoonCategoryDelete.do")
	public String admWebtoonCategoryDelete(@RequestParam String wcSeq, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/webtoon/admWebtoonCategoryDelete.do - 관리자 > 한디원뉴스 > 한툰 > 웹툰관리 삭제");
		LOGGER.debug("wcSeq = {}", wcSeq);
		
		
		WebtoonVO resultVO = webtoonDAO.selectWebtoonCategoryOne(wcSeq);
		
		if(Integer.parseInt(resultVO.getWebtoonCount()) > 0){
			LOGGER.warn("잘못된 접근입니다. 등록된 웹툰 내용이 있습니다.");
			reda.addFlashAttribute("message", "오류발생(-2");
			return "redirect:/qxerpynm/webtoon/admWebtoonCategoryList.do";
		}
		
		webtoonDAO.webtoonCategoryDelete(wcSeq);
		
		reda.addFlashAttribute("message", "삭제되었습니다.");
		
		// log set - start
		admLogInsert(null, "한툰 관리", String.format("삭제 | wcSeq = %s", wcSeq), request);
		// log set - end
		return "redirect:/qxerpynm/webtoon/admWebtoonCategoryList.do";
	}
}