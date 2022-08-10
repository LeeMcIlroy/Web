package hsDesign.adm.webtoon;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import component.file.FileInfoVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.AdminVO;
import hsDesign.valueObject.WebtoonVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmWebtoonDAO extends EgovAbstractDAO {
	
	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectWebtoonList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmWebtoonDAO.selectWebtoonListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmWebtoonDAO.selectWebtoonList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public WebtoonVO selectWebtoonOne(String wSeq){
		return (WebtoonVO) select("AdmWebtoonDAO.selectWebtoonOne", wSeq);
	}
	
	// 등록
	public String webtoonInsert(WebtoonVO webtoonVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		webtoonVO.setRegSeq(adminVO.getAdmSeq());
		webtoonVO.setRegName(adminVO.getAdmName());
		return (String) insert("AdmWebtoonDAO.webtoonInsert", webtoonVO);
	}
	
	// 수정
	public void webtoonUpdate(WebtoonVO webtoonVO){
		update("AdmWebtoonDAO.webtoonUpdate", webtoonVO);
	}
	
	// 썸네일 등록
	public void webtoonThumbnailInsert(FileInfoVO fileInfoVO, String wSeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("wSeq", wSeq);
		update("AdmWebtoonDAO.webtoonThumbnailInsert", map);
	}
	
	// 삭제
	public void webtoonDelete(String wSeq){
		delete("AdmWebtoonDAO.webtoonDelete", wSeq);
	}
	
	/************************************************************** 웹툰 카테고리 **************************************************************/
	
	// 카테고리 목록
	@SuppressWarnings("unchecked")
	public List<WebtoonVO> selectWebtoonCategoryList(CmmnSearchVO searchVO){
		return (List<WebtoonVO>) list("AdmWebtoonDAO.selectWebtoonCategoryList", searchVO);
	}
	
	// 카테고리 목록Cnt
	public int selectWebtoonCategoryListCnt(CmmnSearchVO searchVO){
		return (int) select("AdmWebtoonDAO.selectWebtoonCategoryListCnt", searchVO);
	}
	
	// 카테고리 조회
	public WebtoonVO selectWebtoonCategoryOne(String wcSeq){
		return (WebtoonVO) select("AdmWebtoonDAO.selectWebtoonCategoryOne", wcSeq);
	}
	
	// 등록
	public void webtoonCategoryInsert(WebtoonVO webtoonVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		webtoonVO.setRegSeq(adminVO.getAdmSeq());
		webtoonVO.setRegName(adminVO.getAdmName());
		insert("AdmWebtoonDAO.webtoonCategoryInsert", webtoonVO);
	}
	
	// 수정
	public void webtoonCategoryUpdate(WebtoonVO webtoonVO){
		update("AdmWebtoonDAO.webtoonCategoryUpdate", webtoonVO);
	}
	
	// 삭제
	public void webtoonCategoryDelete(String wcSeq){
		delete("AdmWebtoonDAO.webtoonCategoryDelete", wcSeq);
	}
}
