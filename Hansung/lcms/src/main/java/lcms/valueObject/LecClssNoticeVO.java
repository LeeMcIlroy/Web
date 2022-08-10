package lcms.valueObject;

import lcms.valueObject.cmm.CmmnSearchVO;

/**
 * @author Leegh
 * 
 * 관리자VO 2019.06.20
 *
 */
public class LecClssNoticeVO extends CmmnSearchVO { 
	
	private String lcnotiSeq 		= ""; 						// 강의공지 SEQ
	private String lectCode			= "";						// 강의 SEQ
	private String lcnotiGubun   	= "";						// 강의공지 구분
	private String lcnotiWriter		= "";						// 강의공지 작성자
	private String lcnotiDate		= "";						// 강의공지 작성일
	private String lcnotiHit		= "";						// 강의공지 조회수
	private String lcnotiContent	= "";						// 강의공지 내용
	private String lcnotiTitle		= "";						// 강의공지  제목
	private String lcnotiTop		= "";						// 강의공지 상단고정
	
	public LecClssNoticeVO(){}
	
	public void setLcnotiSeq(String lcnotiSeq) {
		this.lcnotiSeq = lcnotiSeq;
	}
	
	public String getLcnotiSeq() {
		return lcnotiSeq;
	}
	
	public void setLectCode(String lectCode) {
		this.lectCode = lectCode;
	}
	
	public String getLectCode() {
		return lectCode;
	}
	
	public void setLcnotiGubun(String lcnotiGubun) {
		this.lcnotiGubun = lcnotiGubun;
	}
	
	public String getLcnotiGubun() {
		return lcnotiGubun;
	}
	
	public void setLcnotiWriter(String lcnotiWriter) {
		this.lcnotiWriter = lcnotiWriter;
	}
	
	public String getLcnotiWriter() {
		return lcnotiWriter;
	}
	
	public void setLcnotiDate(String lcnotiDate) {
		this.lcnotiDate = lcnotiDate;
	}
	
	public String getLcnotiDate() {
		return lcnotiDate;
	}
	
	public void setLcnotiHit(String lcnotiHit) {
		this.lcnotiHit = lcnotiHit;
	}
	
	public String getLcnotiHit() {
		return lcnotiHit;
	}
	
	public void setLcnotiContent(String lcnotiContent) {
		this.lcnotiContent = lcnotiContent;
	}
	
	public String getLcnotiContent() {
		return lcnotiContent;
	}
	
	public void setLcnotiTitle(String lcnotiTitle) {
		this.lcnotiTitle = lcnotiTitle;
	}
	
	public String getLcnotiTitle() {
		return lcnotiTitle;
	}
	
	public void setLcnotiTop(String lcnotiTop) {
		this.lcnotiTop = lcnotiTop;
	}
	
	public String getLcnotiTop() {
		return lcnotiTop;
	}
}
