package hsDesign.adm.general.info;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import component.file.FileInfoVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.GEUpfileVO;
import hsDesign.valueObject.GeneralEduVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmGeneralInfoDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectGeneralInfoList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmGeneralInfoDAO.selectGeneralInfoListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmGeneralInfoDAO.selectGeneralInfoList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public GeneralEduVO selectGeneralInfoOne(String geSeq){
		return (GeneralEduVO) select("AdmGeneralInfoDAO.selectGeneralInfoOne", geSeq);
	}

	// 등록
	public String generalInfoInsert(GeneralEduVO generalEduVO){
		return (String) insert("AdmGeneralInfoDAO.generalInfoInsert", generalEduVO);
	}
	
	// 수정
	public void generalInfoUpdate(GeneralEduVO generalEduVO){
		update("AdmGeneralInfoDAO.generalInfoUpdate", generalEduVO);
	}
	
	// 삭제
	public void generalInfoDelete(String geSeq){
		delete("AdmGeneralInfoDAO.generalInfoDelete", geSeq);
	}
	
	/************************************** 첨부파일 **************************************/
	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectGeneralInfoUpfileList(String geSeq){
		int totalRecordCount = (int) select("AdmGeneralInfoDAO.selectGeneralInfoUpfileListCnt", geSeq);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmGeneralInfoDAO.selectGeneralInfoUpfileList", geSeq);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public GEUpfileVO selectGeneralInfoUpfileOne(String geupSeq){
		return (GEUpfileVO) select("AdmGeneralInfoDAO.selectGeneralInfoUpfileOne", geupSeq);
	}
	
	// 등록
	public void generalInfoUpfileInsert(FileInfoVO fileInfoVO, String geSeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("geSeq", geSeq);
		insert("AdmGeneralInfoDAO.generalInfoUpfileInsert", map);
	}
	
	// 삭제
	public void generalInfoUpfileDelete(String geupSeq){
		delete("AdmGeneralInfoDAO.generalInfoUpfileDelete", geupSeq);
	}
}
