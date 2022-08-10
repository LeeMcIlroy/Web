package writer.valueObject;

/**
 * 20200730 wlsaud92
 * 	대회 관리
 *  SELECT * FROM TB_HSWC_CONTEST_MANAGER;
 */
public class ContestVO {
	private String cntSeq = "";				// seq
	private String cntTitle = "";			// 대회주제
	private String cntContent = "";			// 대회comment
	private String cntPernum = "";			// 대회인원수제한
	private String cntGubun = "";			// 대회구분 프레젠테이션 or 글쓰기
	private String cntStartdate = "";		// 접수시작
	private String cntEnddate = "";			// 접수끝
	private String cntRegid = "";			// 등록자
	
	public String getCntSeq() {
		return cntSeq;
	}
	public void setCntSeq(String cntSeq) {
		this.cntSeq = cntSeq;
	}
	public String getCntTitle() {
		return cntTitle;
	}
	public void setCntTitle(String cntTitle) {
		this.cntTitle = cntTitle;
	}
	public String getCntContent() {
		return cntContent;
	}
	public void setCntContent(String cntContent) {
		this.cntContent = cntContent;
	}
	public String getCntPernum() {
		return cntPernum;
	}
	public void setCntPernum(String cntPernum) {
		this.cntPernum = cntPernum;
	}
	public String getCntGubun() {
		return cntGubun;
	}
	public void setCntGubun(String cntGubun) {
		this.cntGubun = cntGubun;
	}
	public String getCntStartdate() {
		return cntStartdate;
	}
	public void setCntStartdate(String cntStartdate) {
		this.cntStartdate = cntStartdate;
	}
	public String getCntEnddate() {
		return cntEnddate;
	}
	public void setCntEnddate(String cntEnddate) {
		this.cntEnddate = cntEnddate;
	}
	public String getCntRegid() {
		return cntRegid;
	}
	public void setCntRegid(String cntRegid) {
		this.cntRegid = cntRegid;
	}

}
