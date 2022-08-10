package lcms.adm.clss;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.AbsentConsultVO;
import lcms.valueObject.ConsultVO;
import lcms.valueObject.LectureVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmClssDAO extends EgovAbstractDAO {

	// 업무담당자 수강신청 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmEnroList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmClssDAO.selectAdmEnroListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmEnroList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 수강신청 조회
	public LectureVO selectAdmEnroView(String lectSeq) throws Exception {
		return (LectureVO) select("AdmClssDAO.selectAdmEnroView", lectSeq);
	}

	// 업무담당자 수강신청 현황 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmStdList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmClssDAO.selectAdmStdListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmStdList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 수강신청작업 학생리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAjaxStdList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmAjaxStdList", searchVO);
	}

	// 업무담당자 수강신청작업
	public void insertAdmAjaxStdMapSave(EgovMap map) throws Exception {
		insert("AdmClssDAO.insertAdmAjaxStdMapSave", map);
	}

	// 업무담당자 수료산정 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmComplList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmClssDAO.selectAdmComplListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmComplList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 수료산정 신청결과 수정
	public void updateAdmCompl(EgovMap map) throws Exception {
		update("AdmClssDAO.updateAdmCompl", map);
	}

	// 업무담당자 출결 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmAttendList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmClssDAO.selectAdmAttendListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmAttendList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 성적 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmGradeList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmClssDAO.selectAdmGradeListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmGradeList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 상담 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmConsulList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmClssDAO.selectAdmConsulListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmConsulList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 학생 출결 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAtteTimeList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmAtteTimeList", searchVO);
	}

	// 업무담당자 출결 마지막 교시 조회
	@SuppressWarnings("unchecked")
	public List<String> selectAdmClstmList(CmmnSearchVO searchVO) throws Exception {
		return (List<String>) list("AdmClssDAO.selectAdmClstmList", searchVO);
	}

	// 업무담당자 출결 비고 조회
	public EgovMap selectAdmAjaxAtteEtc(EgovMap paramMap) throws Exception {
		return (EgovMap) select("AdmClssDAO.selectAdmAjaxAtteEtc", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAdminList() throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmAdminList");
	}

	// 업무담당자 상담 조회
	public ConsultVO selectAdmConsulModify(String consultSeq) throws Exception {
		return (ConsultVO) select("AdmClssDAO.selectAdmConsulModify", consultSeq);
	}

	// 업무담당자 상담 등록
	public void insertAdmConsult(ConsultVO consultVO) throws Exception {
		insert("AdmClssDAO.insertAdmConsult", consultVO);
	}

	// 업무담당자 상담 수정
	public void updateAdmConsult(ConsultVO consultVO) throws Exception {
		update("AdmClssDAO.updateAdmConsult", consultVO);
	}

	// 업무담당자 상담 조회
	public ConsultVO selectAdmConsulView(String consultSeq) throws Exception {
		return (ConsultVO) select("AdmClssDAO.selectAdmConsulView", consultSeq);
	}

	// 업무담당자 상담 이력 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmConsulPop(String memberCode) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmConsulPop", memberCode);
	}

	// 업무담당자 성적 상세 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO admGradeDtl(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("AdmClssDAO.admGradeDtlCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmClssDAO.admGradeDtl", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	
	// 업무담당자 수강신청 학생 학적 수정
	public void updateAdmStdStatus(String mCode) throws Exception {
		update("AdmClssDAO.updateAdmStdStatus", mCode);
	}

	public int selectAdmAjaxGradeCnt(EgovMap map) throws Exception {
		return (int) select("AdmClssDAO.selectAdmAjaxGradeCnt", map);
	}

	public void updateAdmAjaxGradeAdmis(EgovMap map) throws Exception {
		update("AdmClssDAO.updateAdmAjaxGradeAdmis", map);
	}

	public String selectAdmCompleYn(EgovMap map) throws Exception {
		return (String) select("AdmClssDAO.selectAdmCompleYn", map);
	}

	public void updateMemberStatus(EgovMap map) throws Exception {
		update("AdmClssDAO.updateMemberStatus", map);
	}

	public EgovMap admGradeView(EgovMap map) throws Exception {
		return (EgovMap) select("AdmClssDAO.admGradeView", map);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAjaxComplNumList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmAjaxComplNumList", searchVO);
	}

	public String selectAdmAjaxComplNumCnt(EgovMap map) throws Exception {
		return (String) select("AdmClssDAO.selectAdmAjaxComplNumCnt", map);
	}

	public void updateAdmAjaxComplNum(EgovMap map) throws Exception {
		update("AdmClssDAO.updateAdmAjaxComplNum", map);
	}

	public String selectAdmAjaxStdMapDelYn(EgovMap map) throws Exception {
		return (String) select("AdmClssDAO.selectAdmAjaxStdMapDelYn", map);
	}

	public void deleteAdmAjaxStdMapDel(EgovMap map) throws Exception {
		delete("AdmClssDAO.deleteAdmAjaxStdMapDel", map);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmSatisList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmClssDAO.selectAdmSatisListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmSatisList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmSurveyList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmSurveyList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStatisTotalList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmStatisTotalList", searchVO);
	}

	public EgovMap selectAdmSatisView(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("AdmClssDAO.selectAdmSatisView", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmSatisScoreList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmSatisScoreList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmSatisQuesList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmSatisQuesList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStatisTxtList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmStatisTxtList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmSatisPrfList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("AdmClssDAO.selectAdmSatisPrfListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmSatisPrfList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmSatisPrfLectList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("AdmClssDAO.selectAdmSatisPrfLectListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmSatisPrfLectList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStatisPrfQuesList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmStatisPrfQuesList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStatisLectList(CmmnSearchVO searchVO) throws Exception{
		return (List<EgovMap>) list("AdmClssDAO.selectAdmStatisLectList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStatisPrfLectQuesList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmStatisPrfLectQuesList", searchVO);
	}

	public void insertAdmFuncStatus(EgovMap map) throws Exception {
		insert("AdmClssDAO.insertAdmFuncStatus", map);
	}

	public void insertAdmFuncStatusStdMap(EgovMap map) throws Exception {
		insert("AdmClssDAO.insertAdmFuncStatusStdMap", map);
	}
//	학생명단 인쇄 팝업(상단)
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStdPrtList(String lectSeq) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmStdPrtList",lectSeq);
	}
//	학생명단 인쇄 팝업(하단)
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStudent(String lectSeq) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmStudent",lectSeq);
	}

	// 수료산정 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmComplExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmComplExcel", searchVO);
	}
	//결석자 현황
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAbsentStatusList(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("AdmClssDAO.selectAbsentStatusList", searchVO);
	}
	//결석자 현황 과목별 cnt
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAbsentStatusTot(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("AdmClssDAO.selectAbsentStatusTot", searchVO);
	}
	//결석자 하단 리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAbsentStdList(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("AdmClssDAO.selectAbsentStdList", searchVO);
	}
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAbsentLectList(CmmnSearchVO searchVO) throws Exception{
		return (List<EgovMap>) list("AdmClssDAO.selectAbsentLectList", searchVO);
	}
	// 관리자 결석자 현황 > 개인별 상담이력 
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxAbsentPoPSearchList(EgovMap map) throws Exception{
		return (List<EgovMap>) list("AdmClssDAO.admAjaxAbsentPoPSearchList", map);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmAbsCounselList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmClssDAO.selectAdmAbsCounselListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmAbsCounselList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	// 관리자 결석자상담 수정화면 조회
	public AbsentConsultVO selectAdmAbsCounselModify(String absentSeq) throws Exception {
		return (AbsentConsultVO) select("AdmClssDAO.selectAdmAbsCounselModify", absentSeq);
	}

	// 관리자 결석자상담 등록화면 조회
	public AbsentConsultVO selectAdmAbsCounselNew(EgovMap map) throws Exception {
		return (AbsentConsultVO) select("AdmClssDAO.selectAdmAbsCounselNew", map);
	}

	// 관리자 결석자상담 등록
	public void insertAdmAbsCounselSubmit(AbsentConsultVO absentConsultVO) throws Exception {
		insert("AdmClssDAO.insertAdmAbsCounselSubmit", absentConsultVO);
	}
	
	// 관리자 결석자상담 수정
	public void updateAdmAbsCounselSubmit(AbsentConsultVO absentConsultVO) throws Exception {
		update("AdmClssDAO.updateAdmAbsCounselSubmit", absentConsultVO);
	}
	//결석경고
	@SuppressWarnings("unchecked")
	public CmmnListVO selectadmAbsWrnList(CmmnSearchVO searchVO)  throws Exception {
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectadmAbsWrnList", searchVO);
		return new CmmnListVO(0, egovList);
	}
	//결석경고 엑셀
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectadmAbsWrnExcelList(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("AdmClssDAO.selectadmAbsWrnList", searchVO);
	}
	//결석경고 이력
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAbsWrnHstrList(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("AdmClssDAO.selectAbsWrnHstrList", searchVO);
	}
	//결석경고추가
	public void admAjaxAddWrn(EgovMap map) throws Exception{
		insert("AdmClssDAO.admAjaxAddWrn", map);
	}
	//결석경고삭제
	public void deleteAdmAjaxAbsWrnDel(EgovMap map) throws Exception {
		delete("AdmClssDAO.deleteAdmAjaxAbsWrnDel", map);
	}
	//결석경고인쇄
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmPopWrnList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmPopWrnList",map);
	}
	//lectSeq찾기
	public String selectAbsWrnLectSeq(EgovMap lectMap) throws Exception  {
		return (String) select("AdmClssDAO.selectAbsWrnLectSeq", lectMap);
	}

	public int selectadmAbsWrnTbSeq() throws Exception {
		return (int) select("AdmClssDAO.selectadmAbsWrnTbSeq");
	}
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxAbsCounselEtcList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.admAjaxAbsCounselEtcList", map);
	}

	//분반표 출력
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmDvsList(CmmnSearchVO searchVO) throws Exception {
		List<EgovMap> egovList = (List<EgovMap>) list("AdmClssDAO.selectAdmDvsList", searchVO);
		return new CmmnListVO(0, egovList);
	}
	//분반표 학생목
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectDvsStudent(EgovMap map) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectDvsStudent", map);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmSatisPrfExcelList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmSatisPrfExcelList", searchVO);
	}
	// 수업만족도 미참여 학생리스트 엑셀 다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmSatiExcelList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmSatisExcelList", searchVO);
	}
	//결석자 상담 엑셀 다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAbsComplExcel(CmmnSearchVO searchVO)  throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmAbsComplExcel", searchVO);
	}

	// 급별회의록 목록 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmMeetLogList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmClssDAO.selectAdmMeetLogList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<String> selectAdmMeetLogWeekList(CmmnSearchVO searchVO) throws Exception {
		return (List<String>) list("AdmClssDAO.selectAdmMeetLogWeekList", searchVO);
	}
	//상담이력삭제
	public void deleteAdmConsul(EgovMap map) throws Exception  {
		delete("AdmClssDAO.deleteAdmConsul", map);
	}

}
