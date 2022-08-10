package hsDesign.usr.webtoon;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.WebtoonVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class WebtoonDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectWebtoonList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("WebtoonDAO.selectWebtoonListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("WebtoonDAO.selectWebtoonList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public WebtoonVO selectWebtoonOne(String wSeq){
		update("WebtoonDAO.webtoonCountUpdate", wSeq);
		return (WebtoonVO) select("WebtoonDAO.selectWebtoonOne", wSeq);
	}
	
	/************************************************************** 웹툰 카테고리 **************************************************************/
	// 카테고리 목록
	@SuppressWarnings("unchecked")
	public List<WebtoonVO> selectWebtoonCategoryList(){
		return (List<WebtoonVO>) list("WebtoonDAO.selectWebtoonCategoryList");
	}
	
}
