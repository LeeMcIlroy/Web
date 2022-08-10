package hsDesign.valueObject;

/**
 * @author kjhoon
 * 전공게시판 썸네일
 * 2017.06.22
 */
public class MBThumbnailVO {
	private String mbthSeq				= ""; // 썸네일 SEQ
	private String mbthType				= ""; // 썸네일 타입
	private String mbthImgName			= ""; // 썸네일 이미지 이름
	private String mbthImgPath			= ""; // 썸네일 이미지 경로
	private String mbthUrl				= ""; // 동영상 url
	private String mbSeq				= ""; // 전공게시판 SEQ
	public String getMbthSeq() {
		return mbthSeq;
	}
	public void setMbthSeq(String mbthSeq) {
		this.mbthSeq = mbthSeq;
	}
	public String getMbthType() {
		return mbthType;
	}
	public void setMbthType(String mbthType) {
		this.mbthType = mbthType;
	}
	public String getMbthImgName() {
		return mbthImgName;
	}
	public void setMbthImgName(String mbthImgName) {
		this.mbthImgName = mbthImgName;
	}
	public String getMbthImgPath() {
		return mbthImgPath;
	}
	public void setMbthImgPath(String mbthImgPath) {
		this.mbthImgPath = mbthImgPath;
	}
	public String getMbthUrl() {
		return mbthUrl;
	}
	public void setMbthUrl(String mbthUrl) {
		this.mbthUrl = mbthUrl;
	}
	public String getMbSeq() {
		return mbSeq;
	}
	public void setMbSeq(String mbSeq) {
		this.mbSeq = mbSeq;
	}
	@Override
	public String toString() {
		return "MBThumbnailVO [mbthSeq=" + mbthSeq + "\r\n mbthType=" + mbthType
				+ "\r\n mbthImgName=" + mbthImgName + "\r\n mbthImgPath="
				+ mbthImgPath + "\r\n mbthUrl=" + mbthUrl + "\r\n mbSeq=" + mbSeq
				+ "]";
	}
	
	
	
}
