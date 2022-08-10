package hsDesign.usr.general.info;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.GeneralEduVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class GeneralInfoDAO extends EgovAbstractDAO{

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectGeneralInfoList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("GeneralInfoDAO.selectGeneralInfoListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("GeneralInfoDAO.selectGeneralInfoList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public GeneralEduVO selectGeneralInfoOne(String geSeq){
		return (GeneralEduVO) select("GeneralInfoDAO.selectGeneralInfoOne", geSeq);
	}
	
	/************************************** 첨부파일 **************************************/
	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectGeneralInfoUpfileList(String geSeq){
		int totalRecordCount = (int) select("GeneralInfoDAO.selectGeneralInfoUpfileListCnt", geSeq);
		List<EgovMap> resultList = (List<EgovMap>) list("GeneralInfoDAO.selectGeneralInfoUpfileList", geSeq);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
}