package writer.usr.cmm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.ClassVO;
import writer.valueObject.DepartmentVO;
import writer.valueObject.SemesterVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class CmmDAO extends EgovAbstractDAO {

	// 학기강의실 목록
	@SuppressWarnings("unchecked")
	public List<SemesterVO> selectSmtrList(CmmnSearchVO searchVO){
		return (List<SemesterVO>) list("CmmDAO.selectSmtrList", searchVO);
	}
	
	// 계열 목록
	@SuppressWarnings("unchecked")
	public List<DepartmentVO> selectDeptList(CmmnSearchVO searchVO){
		return (List<DepartmentVO>) list("CmmDAO.selectDeptList", searchVO);
	}
	
	// 반_교수 목록
	@SuppressWarnings("unchecked")
	public List<ClassVO> selectClsList(CmmnSearchVO searchVO){
		return (List<ClassVO>) list("CmmDAO.selectClsList", searchVO);
	}
	
	// 반_교수 조회
	public EgovMap selectClsOne(String clsSeq){
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		Map<String, Object> map = new HashMap<>();
		map.put("userVO", userVO);
		map.put("clsSeq", clsSeq);
		return (EgovMap) select("CmmDAO.selectClsOne", map);
	}
	
	/******************************************** 임시 ********************************************/
	public void insert(){
		List<EgovMap> resultList = (List<EgovMap>) list("CmmDAO.tempSelectList");
		for(EgovMap vo : resultList){
			insert("CmmDAO.tempInsert", vo);
		}
		
	}
	
}
