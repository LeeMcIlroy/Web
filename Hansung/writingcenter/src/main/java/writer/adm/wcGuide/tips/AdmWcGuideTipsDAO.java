package writer.adm.wcGuide.tips;

import java.net.UnknownHostException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.AdminVO;
import writer.valueObject.WritingtipsVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class AdmWcGuideTipsDAO extends EgovAbstractDAO {

	
	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectWcGuideTipsList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmWcGuideTipsDAO.selectWcGuideTipsListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmWcGuideTipsDAO.selectWcGuideTipsList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public WritingtipsVO selectWcGuideTipsOne(String tipSeq){
		return (WritingtipsVO) select("AdmWcGuideTipsDAO.selectWcGuideTipsOne", tipSeq);
	}
	
	// 등록
	public void wcGuideTipsInsert(WritingtipsVO writingtipsVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		writingtipsVO.setRegId(adminVO.getMemCode());
		writingtipsVO.setRegName(adminVO.getMemName());
		
		
		insert("AdmWcGuideTipsDAO.wcGuideTipsInsert", writingtipsVO);
	}
	
	// 수정
	public void wcGuideTipsUpdate(WritingtipsVO writingtipsVO){
		update("AdmWcGuideTipsDAO.wcGuideTipsUpdate", writingtipsVO);
	}
	
	// 삭제
	public void wcGuideTipsDelete(String tipSeq){
		delete("AdmWcGuideTipsDAO.wcGuideTipsDelete", tipSeq);
	}
}
