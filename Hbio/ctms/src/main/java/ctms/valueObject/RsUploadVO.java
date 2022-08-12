package ctms.valueObject;

import java.util.List;

/**
 * @author 홍진기
 * 
 * 연구과제 Upload VO 2021.03.25 v1
 *
 */
public class RsUploadVO {

	private String corpCd               = ""; // 회사코드
    private String rsNo                 = ""; // 연구과제번호
    private String rsNo1                = ""; // 연구고유번호
    private String rsNo2                = ""; // 임상종류
    private String rsNo2Nm              = ""; // 임상종류명
    private String rsNo3                = ""; // 임상분류
    private String rsNo3Nm              = ""; // 임상분류명
    private String rsNo4                = ""; // 프로토콜
    private String rsNo4Nm              = ""; // 프로토콜명
    private String rsNo5                = ""; // 연구연도
    private String rsNo6                = ""; // 차수시작
    private String rsNo7                = ""; // 임상번호
    private String rsCd                 = ""; // 연구코드
    private String regDt                = ""; // 등록일자
    private String rsDrt                = ""; // 연구책임자
    private String rsDrtNm              = ""; // 연구책임자명
    private String rsScnt               = ""; // 연구대상인원
    private String rsMscnt              = ""; // 최대지원자수
    private String rsStdt               = ""; // 연구기간(시작일자)
    private String rsEndt               = ""; // 연구기간(종료일자)
    private String rsstCls              = ""; // 연구상태
    private String rsstClsNm            = ""; // 연구상태명
    private String repDt                = ""; // 결과보고일
    private String visitCnt             = ""; // 방문횟수
    private String duplYn               = ""; // 중복참여여부
    private String rsPos                = ""; // 대상부위
    private String rsName               = ""; // 연구명
    private String rsPps                = ""; // 연구목적
    private String rsPtc                = ""; // 연구방법
    private String vendNo               = ""; // 거래처번호
    private String vendName             = ""; // 거래처번호명
    private String vmngName             = ""; // 거래처담당자명
    private String vmnghpNo             = ""; // 거래처담당자휴대폰
    private String vmngEmail            = ""; // 거래처담당자이메일
    private String rsPay                = ""; // 연구비
    private String rsPayvt              = ""; // 연구비부가세
    private String irbsmYn              = ""; // IRB승인필요여부
    private String itemCls              = ""; // 제품정보
    private String itemClsNm            = ""; // 제품정보명
    private String itemName             = ""; // 제품명
    private String branchCd             = ""; // 등록지사코드
    private String branchNm             = ""; // 등록지사명칭
    private String delYn                = ""; // 삭제여부
    private String dataLockYn           = ""; // 데이터잠금여부
    private String ecrfState            = ""; // eCRF상태
    private String dataRegdt            = ""; // 등록수정일
    private String dataRegnt            = ""; // 등록수정자
    
    private String isAdminType          = ""; // 1 관리자권한  2 일반사용자 
    private String isRsDrt     		    = ""; // 연구책임자여부 Y 연구책임자  N 아님 
    private String isRsStaff     		= ""; // 연구담당자여부 Y 연구담당자  N 아님
    private String isDelCntr     		= ""; // 삭제가능 Y 삭제불가 N
    
    private String rsGrt  			   	= ""; // 신뢰성보증업무담당자
    private String rsGrtNm              = ""; // 신뢰성보증업무담당자명
    private String rsTstdt              = ""; // 연구개시일
    private String rsTendt              = ""; // 연구종료일
    
    private String genYn                = ""; // 모집성별 1:남 2:여 0:제한없음
    private String ageSt                = ""; // 모집나이하한
    private String ageEn                = ""; // 모집나이상한
    
    private String rsplDt				= ""; // 연구계획서일
    private String rsitDt				= ""; // 시험제품정보확인일
    private String rsirbDt				= ""; // IRB승인일
    private String rsrStdt				= ""; // 연구대상자모집시작일
    private String rsrEndt				= ""; // 연구대상자모집종료일
    private String rep2Dt				= ""; // 초안보고일
    
    // 연구대상자 일괄등록
    private String rsiNo				= ""; // 식별번호
    private String rsjName				= ""; // 연구대상자이름
    private String age					= ""; // 나이
    private String appYn				= ""; // 지원여부
    private String firstSt				= ""; // 1차선발
    private String cfmYn				= ""; // 확정
    private String poolYn				= ""; // 풀선발
    private String rsiNo1				= ""; //
    private String rsjNo				= ""; //
    private String appstaCls			= ""; //
    private String appStdt				= ""; //
    private String appEndt				= ""; //
    private String rsiNo3				= ""; //
    private String subNo				= ""; //
    private String rsiNo2				= ""; //
    private String etc				    = ""; //
    
    
    
        
    public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getRsiNo2() {
		return rsiNo2;
	}
	public void setRsiNo2(String rsiNo2) {
		this.rsiNo2 = rsiNo2;
	}
	public String getSubNo() {
		return subNo;
	}
	public void setSubNo(String subNo) {
		this.subNo = subNo;
	}
	public String getRsiNo3() {
		return rsiNo3;
	}
	public void setRsiNo3(String rsiNo3) {
		this.rsiNo3 = rsiNo3;
	}
	public String getAppStdt() {
		return appStdt;
	}
	public void setAppStdt(String appStdt) {
		this.appStdt = appStdt;
	}
	public String getAppEndt() {
		return appEndt;
	}
	public void setAppEndt(String appEndt) {
		this.appEndt = appEndt;
	}
	public String getRsjNo() {
		return rsjNo;
	}
	public void setRsjNo(String rsjNo) {
		this.rsjNo = rsjNo;
	}
	public String getAppstaCls() {
		return appstaCls;
	}
	public void setAppstaCls(String appstaCls) {
		this.appstaCls = appstaCls;
	}
	public String getRsiNo1() {
		return rsiNo1;
	}
	public void setRsiNo1(String rsiNo1) {
		this.rsiNo1 = rsiNo1;
	}
	public String getAppYn() {
		return appYn;
	}
	public void setAppYn(String appYn) {
		this.appYn = appYn;
	}
	public String getFirstSt() {
		return firstSt;
	}
	public void setFirstSt(String firstSt) {
		this.firstSt = firstSt;
	}
	public String getCfmYn() {
		return cfmYn;
	}
	public void setCfmYn(String cfmYn) {
		this.cfmYn = cfmYn;
	}
	public String getPoolYn() {
		return poolYn;
	}
	public void setPoolYn(String poolYn) {
		this.poolYn = poolYn;
	}
	public String getRsiNo() {
		return rsiNo;
	}
	public void setRsiNo(String rsiNo) {
		this.rsiNo = rsiNo;
	}
	public String getRsjName() {
		return rsjName;
	}
	public void setRsjName(String rsjName) {
		this.rsjName = rsjName;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getRsNo() {
		return rsNo;
	}
	public void setRsNo(String rsNo) {
		this.rsNo = rsNo;
	}
	public String getRsNo1() {
		return rsNo1;
	}
	public void setRsNo1(String rsNo1) {
		this.rsNo1 = rsNo1;
	}
	public String getRsNo2() {
		return rsNo2;
	}
	public void setRsNo2(String rsNo2) {
		this.rsNo2 = rsNo2;
	}
	public String getRsNo2Nm() {
		return rsNo2Nm;
	}
	public void setRsNo2Nm(String rsNo2Nm) {
		this.rsNo2Nm = rsNo2Nm;
	}
	public String getRsNo3() {
		return rsNo3;
	}
	public void setRsNo3(String rsNo3) {
		this.rsNo3 = rsNo3;
	}
	public String getRsNo3Nm() {
		return rsNo3Nm;
	}
	public void setRsNo3Nm(String rsNo3Nm) {
		this.rsNo3Nm = rsNo3Nm;
	}
	public String getRsNo4() {
		return rsNo4;
	}
	public void setRsNo4(String rsNo4) {
		this.rsNo4 = rsNo4;
	}
	public String getRsNo4Nm() {
		return rsNo4Nm;
	}
	public void setRsNo4Nm(String rsNo4Nm) {
		this.rsNo4Nm = rsNo4Nm;
	}
	public String getRsNo5() {
		return rsNo5;
	}
	public void setRsNo5(String rsNo5) {
		this.rsNo5 = rsNo5;
	}
	public String getRsNo6() {
		return rsNo6;
	}
	public void setRsNo6(String rsNo6) {
		this.rsNo6 = rsNo6;
	}
	public String getRsNo7() {
		return rsNo7;
	}
	public void setRsNo7(String rsNo7) {
		this.rsNo7 = rsNo7;
	}
	public String getRsCd() {
		return rsCd;
	}
	public void setRsCd(String rsCd) {
		this.rsCd = rsCd;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getRsDrt() {
		return rsDrt;
	}
	public void setRsDrt(String rsDrt) {
		this.rsDrt = rsDrt;
	}
	public String getRsDrtNm() {
		return rsDrtNm;
	}
	public void setRsDrtNm(String rsDrtNm) {
		this.rsDrtNm = rsDrtNm;
	}
	public String getRsScnt() {
		return rsScnt;
	}
	public void setRsScnt(String rsScnt) {
		this.rsScnt = rsScnt;
	}
	public String getRsMscnt() {
		return rsMscnt;
	}
	public void setRsMscnt(String rsMscnt) {
		this.rsMscnt = rsMscnt;
	}
	public String getRsStdt() {
		return rsStdt;
	}
	public void setRsStdt(String rsStdt) {
		this.rsStdt = rsStdt;
	}
	public String getRsEndt() {
		return rsEndt;
	}
	public void setRsEndt(String rsEndt) {
		this.rsEndt = rsEndt;
	}
	public String getRsstCls() {
		return rsstCls;
	}
	public void setRsstCls(String rsstCls) {
		this.rsstCls = rsstCls;
	}
	public String getRsstClsNm() {
		return rsstClsNm;
	}
	public void setRsstClsNm(String rsstClsNm) {
		this.rsstClsNm = rsstClsNm;
	}
	public String getRepDt() {
		return repDt;
	}
	public void setRepDt(String repDt) {
		this.repDt = repDt;
	}
	public String getVisitCnt() {
		return visitCnt;
	}
	public void setVisitCnt(String visitCnt) {
		this.visitCnt = visitCnt;
	}
	public String getDuplYn() {
		return duplYn;
	}
	public void setDuplYn(String duplYn) {
		this.duplYn = duplYn;
	}
	public String getRsPos() {
		return rsPos;
	}
	public void setRsPos(String rsPos) {
		this.rsPos = rsPos;
	}
	public String getRsName() {
		return rsName;
	}
	public void setRsName(String rsName) {
		this.rsName = rsName;
	}
	public String getRsPps() {
		return rsPps;
	}
	public void setRsPps(String rsPps) {
		this.rsPps = rsPps;
	}
	public String getRsPtc() {
		return rsPtc;
	}
	public void setRsPtc(String rsPtc) {
		this.rsPtc = rsPtc;
	}
	public String getVendNo() {
		return vendNo;
	}
	public void setVendNo(String vendNo) {
		this.vendNo = vendNo;
	}
	public String getVendName() {
		return vendName;
	}
	public void setVendName(String vendName) {
		this.vendName = vendName;
	}
	public String getVmngName() {
		return vmngName;
	}
	public void setVmngName(String vmngName) {
		this.vmngName = vmngName;
	}
	public String getVmnghpNo() {
		return vmnghpNo;
	}
	public void setVmnghpNo(String vmnghpNo) {
		this.vmnghpNo = vmnghpNo;
	}
	public String getVmngEmail() {
		return vmngEmail;
	}
	public void setVmngEmail(String vmngEmail) {
		this.vmngEmail = vmngEmail;
	}
	public String getRsPay() {
		return rsPay;
	}
	public void setRsPay(String rsPay) {
		this.rsPay = rsPay;
	}
	public String getRsPayvt() {
		return rsPayvt;
	}
	public void setRsPayvt(String rsPayvt) {
		this.rsPayvt = rsPayvt;
	}
	public String getIrbsmYn() {
		return irbsmYn;
	}
	public void setIrbsmYn(String irbsmYn) {
		this.irbsmYn = irbsmYn;
	}
	public String getItemCls() {
		return itemCls;
	}
	public void setItemCls(String itemCls) {
		this.itemCls = itemCls;
	}
	public String getItemClsNm() {
		return itemClsNm;
	}
	public void setItemClsNm(String itemClsNm) {
		this.itemClsNm = itemClsNm;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getBranchCd() {
		return branchCd;
	}
	public void setBranchCd(String branchCd) {
		this.branchCd = branchCd;
	}
	public String getBranchNm() {
		return branchNm;
	}
	public void setBranchNm(String branchNm) {
		this.branchNm = branchNm;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getDataLockYn() {
		return dataLockYn;
	}
	public void setDataLockYn(String dataLockYn) {
		this.dataLockYn = dataLockYn;
	}
	public String getEcrfState() {
		return ecrfState;
	}
	public void setEcrfState(String ecrfState) {
		this.ecrfState = ecrfState;
	}
	public String getDataRegdt() {
		return dataRegdt;
	}
	public void setDataRegdt(String dataRegdt) {
		this.dataRegdt = dataRegdt;
	}
	public String getDataRegnt() {
		return dataRegnt;
	}
	public void setDataRegnt(String dataRegnt) {
		this.dataRegnt = dataRegnt;
	}
	public String getIsAdminType() {
		return isAdminType;
	}
	public void setIsAdminType(String isAdminType) {
		this.isAdminType = isAdminType;
	}
	public String getIsRsDrt() {
		return isRsDrt;
	}
	public void setIsRsDrt(String isRsDrt) {
		this.isRsDrt = isRsDrt;
	}
	public String getIsRsStaff() {
		return isRsStaff;
	}
	public void setIsRsStaff(String isRsStaff) {
		this.isRsStaff = isRsStaff;
	}
	public String getIsDelCntr() {
		return isDelCntr;
	}
	public void setIsDelCntr(String isDelCntr) {
		this.isDelCntr = isDelCntr;
	}
	public String getRsGrt() {
		return rsGrt;
	}
	public void setRsGrt(String rsGrt) {
		this.rsGrt = rsGrt;
	}
	public String getRsGrtNm() {
		return rsGrtNm;
	}
	public void setRsGrtNm(String rsGrtNm) {
		this.rsGrtNm = rsGrtNm;
	}
	public String getRsTstdt() {
		return rsTstdt;
	}
	public void setRsTstdt(String rsTstdt) {
		this.rsTstdt = rsTstdt;
	}
	public String getRsTendt() {
		return rsTendt;
	}
	public void setRsTendt(String rsTendt) {
		this.rsTendt = rsTendt;
	}
	public String getGenYn() {
		return genYn;
	}
	public void setGenYn(String genYn) {
		this.genYn = genYn;
	}
	public String getAgeSt() {
		return ageSt;
	}
	public void setAgeSt(String ageSt) {
		this.ageSt = ageSt;
	}
	public String getAgeEn() {
		return ageEn;
	}
	public void setAgeEn(String ageEn) {
		this.ageEn = ageEn;
	}
	public String getRsplDt() {
		return rsplDt;
	}
	public void setRsplDt(String rsplDt) {
		this.rsplDt = rsplDt;
	}
	public String getRsitDt() {
		return rsitDt;
	}
	public void setRsitDt(String rsitDt) {
		this.rsitDt = rsitDt;
	}
	public String getRsirbDt() {
		return rsirbDt;
	}
	public void setRsirbDt(String rsirbDt) {
		this.rsirbDt = rsirbDt;
	}
	public String getRsrStdt() {
		return rsrStdt;
	}
	public void setRsrStdt(String rsrStdt) {
		this.rsrStdt = rsrStdt;
	}
	public String getRsrEndt() {
		return rsrEndt;
	}
	public void setRsrEndt(String rsrEndt) {
		this.rsrEndt = rsrEndt;
	}
	public String getRep2Dt() {
		return rep2Dt;
	}
	public void setRep2Dt(String rep2Dt) {
		this.rep2Dt = rep2Dt;
	}
	@Override
	public String toString() {
		return "RsUploadVO [corpCd=" + corpCd + ", rsNo=" + rsNo + ", rsNo1=" + rsNo1 + ", rsNo2=" + rsNo2
				+ ", rsNo2Nm=" + rsNo2Nm + ", rsNo3=" + rsNo3 + ", rsNo3Nm=" + rsNo3Nm + ", rsNo4=" + rsNo4
				+ ", rsNo4Nm=" + rsNo4Nm + ", rsNo5=" + rsNo5 + ", rsNo6=" + rsNo6 + ", rsNo7=" + rsNo7 + ", rsCd="
				+ rsCd + ", regDt=" + regDt + ", rsDrt=" + rsDrt + ", rsDrtNm=" + rsDrtNm + ", rsScnt=" + rsScnt
				+ ", rsMscnt=" + rsMscnt + ", rsStdt=" + rsStdt + ", rsEndt=" + rsEndt + ", rsstCls=" + rsstCls
				+ ", rsstClsNm=" + rsstClsNm + ", repDt=" + repDt + ", visitCnt=" + visitCnt + ", duplYn=" + duplYn
				+ ", rsPos=" + rsPos + ", rsName=" + rsName + ", rsPps=" + rsPps + ", rsPtc=" + rsPtc + ", vendNo="
				+ vendNo + ", vendName=" + vendName + ", vmngName=" + vmngName + ", vmnghpNo=" + vmnghpNo
				+ ", vmngEmail=" + vmngEmail + ", rsPay=" + rsPay + ", rsPayvt=" + rsPayvt + ", irbsmYn=" + irbsmYn
				+ ", itemCls=" + itemCls + ", itemClsNm=" + itemClsNm + ", itemName=" + itemName + ", branchCd="
				+ branchCd + ", branchNm=" + branchNm + ", delYn=" + delYn + ", dataLockYn=" + dataLockYn
				+ ", ecrfState=" + ecrfState + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt
				+ ", isAdminType=" + isAdminType + ", isRsDrt=" + isRsDrt + ", isRsStaff=" + isRsStaff + ", isDelCntr="
				+ isDelCntr + ", rsGrt=" + rsGrt + ", rsGrtNm=" + rsGrtNm + ", rsTstdt=" + rsTstdt + ", rsTendt="
				+ rsTendt + ", genYn=" + genYn + ", ageSt=" + ageSt + ", ageEn=" + ageEn + ", rsplDt=" + rsplDt
				+ ", rsitDt=" + rsitDt + ", rsirbDt=" + rsirbDt + ", rsrStdt=" + rsrStdt + ", rsrEndt=" + rsrEndt
				+ ", rep2Dt=" + rep2Dt + ", rsiNo=" + rsiNo + ", rsjName=" + rsjName + ", age=" + age + ", appYn="
				+ appYn + ", firstSt=" + firstSt + ", cfmYn=" + cfmYn + ", poolYn=" + poolYn + ", rsiNo1=" + rsiNo1
				+ ", rsjNo=" + rsjNo + ", appstaCls=" + appstaCls + ", appStdt=" + appStdt + ", appEndt=" + appEndt
				+ ", rsiNo3=" + rsiNo3 + ", subNo=" + subNo + ", rsiNo2=" + rsiNo2 + ", etc=" + etc + "]";
	}
	
	
			
	
}
