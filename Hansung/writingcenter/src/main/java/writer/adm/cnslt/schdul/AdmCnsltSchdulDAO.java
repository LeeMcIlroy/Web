package writer.adm.cnslt.schdul;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.AdminVO;
import writer.valueObject.CnsltScheduleVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class AdmCnsltSchdulDAO extends EgovAbstractDAO {


	// 목록
	@SuppressWarnings("unchecked")
	public List<CnsltScheduleVO> selectCnsltScheduleList(CmmnSearchVO searchVO){
		return (List<CnsltScheduleVO>) list("AdmCnsltSchdulDAO.selectCnsltScheduleList", searchVO);
	}
	
	// 조회
	public CnsltScheduleVO selectCnsltScheduleOne(String schSeq){
		Map<String, String> map = new HashMap<>();
		map.put("schSeq", schSeq);
		
		return (CnsltScheduleVO) select("AdmCnsltSchdulDAO.selectCnsltScheduleOne", map);
	}
	
	// 조회 (조건 검색)
	public CnsltScheduleVO selectCnsltScheduleOne(CnsltScheduleVO cnsltScheduleVO) {
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		Map<String, Object> map = new HashMap<>();
		map.put("adminVO", adminVO);
		map.put("cnsltScheduleVO", cnsltScheduleVO);
		
		return (CnsltScheduleVO) select("AdmCnsltSchdulDAO.selectCnsltScheduleOne", map);
	}
		
	
	// 등록
	public void cnsltScheduleInsert(CnsltScheduleVO cnsltScheduleVO){
		if (selectCnsltScheduleOne(cnsltScheduleVO) == null) {
			AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
			Map<String, Object> map = new HashMap<>();
			map.put("adminVO", adminVO);
			map.put("cnsltScheduleVO", cnsltScheduleVO);
			
			insert("AdmCnsltSchdulDAO.cnsltScheduleInsert", map);
		}
	}
	
	// 수정
	public void cnsltScheduleUpdate(CnsltScheduleVO cnsltScheduleVO){
		if (selectCnsltScheduleOne(cnsltScheduleVO) == null) {
			update("AdmCnsltSchdulDAO.cnsltScheduleUpdate", cnsltScheduleVO);
		}else{
			cnsltScheduleDelete(cnsltScheduleVO.getSchSeq());
		}
	}
	
	// 삭제
	public void cnsltScheduleDelete(String schSeq){
		delete("AdmCnsltSchdulDAO.cnsltScheduleDelete", schSeq);
	}
	
}
