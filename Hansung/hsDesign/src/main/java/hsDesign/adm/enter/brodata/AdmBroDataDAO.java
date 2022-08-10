package hsDesign.adm.enter.brodata;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import component.file.FileInfoVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.AdminVO;
import hsDesign.valueObject.BrodataVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmBroDataDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectBroDataList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmBroDataDAO.selectBroDataListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmBroDataDAO.selectBroDataList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public BrodataVO selectBroDataOne(String bdSeq){
		return (BrodataVO) select("AdmBroDataDAO.selectBroDataOne", bdSeq);
	}
	
	// 등록
	public String broDataInsert(BrodataVO brodataVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		brodataVO.setRegSeq(adminVO.getAdmSeq());
		brodataVO.setRegName(adminVO.getAdmName());
		
		return (String) insert("AdmBroDataDAO.broDataInsert", brodataVO);
	}
	
	// 수정 - 이미지 업로드관련
	public void broDataImgUpdate(FileInfoVO fileInfoVO, String rsBdSeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("rsBdSeq", rsBdSeq);
		update("AdmBroDataDAO.broDataImgUpdate", map);
	}
	
	// 수정 - 글 수정
	public void broDataUpdate(BrodataVO brodataVO){
		update("AdmBroDataDAO.broDataUpdate", brodataVO);
	}
	
	// 삭제
	public void broDataDelete(String bdSeq){
		delete("AdmBroDataDAO.broDataDelete", bdSeq);
	}
	
}
