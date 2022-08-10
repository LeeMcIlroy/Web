package writer.usr.cnslt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import component.file.FileInfoVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.CnsltApplyVO;
import writer.valueObject.CnsltScheduleVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class CnsltDAO2 extends EgovAbstractDAO {
	
	// 목록
	@SuppressWarnings("unchecked")
	public List<CnsltScheduleVO> selectCnsltScheduleList(CmmnSearchVO searchVO){
		return (List<CnsltScheduleVO>) list("UsrCnsltSchdulDAO.selectCnsltScheduleList", searchVO);
	}
	
}
