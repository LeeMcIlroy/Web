package hsDesign.adm.siteMng.news;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmNewsDAO extends EgovAbstractDAO {

	//전공소식관리 목록
	public CmmnListVO selectAdmNewsList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("AdmNewsDAO.selectAdmNewsListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmNewsDAO.selectAdmNewsList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//전공소식관리 표출 목록
	public List<EgovMap> selectAdmNewsSortList(CmmnSearchVO searchVO) {
		List<EgovMap> resultList = (List<EgovMap>) list("AdmNewsDAO.selectAdmNewsSortList", searchVO);
		return resultList;
	}
	
	//전공소식관리 정렬 체크
	public int selectAdmNewsSortChk(MajorBoardVO paramVO) {
		int sortCnt = (int) select("AdmNewsDAO.selectAdmNewsSortChk", paramVO);
		return sortCnt;
	}
	
	//전공소식 이전 정렬 수정
	public void updateAdmNewsPreSort(MajorBoardVO paramVO){
		update("AdmNewsDAO.updateAdmNewsPreSort", paramVO);
	}

	//전공소식 정렬 수정
	public void updateAdmNewsSort(MajorBoardVO paramVO){
		update("AdmNewsDAO.updateAdmNewsSort", paramVO);
	}

	public MajorBoardVO selectAdmNewsOne(String mbSeq) {
		MajorBoardVO resultVO = (MajorBoardVO)select("AdmNewsDAO.selectAdmNewsOne", mbSeq);
		return resultVO;
	}

	public List<EgovMap> selectAdmNewsDeptList() {
		List<EgovMap> result = (List<EgovMap>) list("AdmNewsDAO.selectAdmNewsDeptList");
		return result;
	}
	
}
