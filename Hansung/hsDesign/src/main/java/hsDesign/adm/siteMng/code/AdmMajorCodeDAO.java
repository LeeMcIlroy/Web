package hsDesign.adm.siteMng.code;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.CodeVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmMajorCodeDAO extends EgovAbstractDAO {

	//코드관리 목록
	public CmmnListVO selectAdmMajorCodeList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("AdmMajorCodeDAO.selectAdmMajorCodeListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmMajorCodeDAO.selectAdmMajorCodeList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//코드 조회
	public CodeVO selectAdmMajorCodeOne(String bcSeq){
		return (CodeVO) select("AdmMajorCodeDAO.selectAdmMajorCodeOne", bcSeq);
	}
	
	
	//코드 등록
	public void insertAdmMajorCode(CodeVO paramVO) {
		insert("AdmMajorCodeDAO.insertAdmMajorCode", paramVO);
	}

	//코드 수정
	public void updateAdmMajorCode(CodeVO paramVO) {
		update("AdmMajorCodeDAO.updateAdmMajorCode", paramVO);
	}
}
