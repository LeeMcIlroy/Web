package component.web;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.valueObject.cmmn.CmmnSearchVO;

public class PaginationController {
	
	//목록 페이징
	public static PaginationInfo getPaginationInfo(CmmnSearchVO searchVO) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(10);

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		return paginationInfo;
	}
	public static PaginationInfo getPaginationInfo2(CmmnSearchVO searchVO) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex2());
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(10);
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		return paginationInfo;
	}
	public static PaginationInfo getPaginationInfo(CmmnSearchVO searchVO, int recordCount, int pageSize) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(recordCount);
		paginationInfo.setPageSize(pageSize);
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		return paginationInfo;
	}
	
	//댓글 목록 페이징
	public static PaginationInfo getPaginationCommentInfo(String pageCommentIndex) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(Integer.parseInt(pageCommentIndex)); //현재 페이지
		paginationInfo.setRecordCountPerPage(10); //페이지당 댓글수
		paginationInfo.setPageSize(10); //화면에 보여질 페이지수
		return paginationInfo;
	}

	/**
	 * paginationInfo
	 * paginationInfoM
	 * @param model ModelMap
	 * @param paginationInfo PC용 페이징객체
	 * @param totalRecordCount 총 건수
	 */
	/*
	public static void addModel(ModelMap model, PaginationInfo paginationInfo, int totalRecordCount) {
		paginationInfo.setTotalRecordCount(totalRecordCount);
		model.addAttribute("paginationInfo", paginationInfo);
		
		PaginationInfo paginationInfoM = new PaginationInfo();
		paginationInfoM.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		paginationInfoM.setRecordCountPerPage(10);
		paginationInfoM.setPageSize(3);
		paginationInfoM.setTotalRecordCount(totalRecordCount);
		model.addAttribute("paginationInfoM", paginationInfoM);
	}
	*/
}
