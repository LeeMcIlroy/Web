package ctms.validator;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ctms.cmm.CmmController;
import ctms.valueObject.RsUploadVO;
import ctms.valueObject.Ct3000mVO;

public class MemberValidator {
	 private static final Logger LOGGER = LoggerFactory.getLogger(CmmController.class);
	
	 public static Map<String, String> validate(Object obj) {
	
		 Map<String, String> errors = new HashMap<>();
		 //RsUploadVO member = (RsUploadVO) obj;
		 Ct3000mVO member = (Ct3000mVO) obj;
		 //member= Ct3000mVO [corpCd=HNBSRC, astNo=, astCd=, astCls=현미경기기/1010, astClsNm=, astName=현미경8-1, fctvName=임상기기제조, pchvName=파러컴, mngName=, pchvTel=, pchvEmail=, empNo=20200001, empName=, pchAmt=1000000, pchAmtvt=100000, pchTamt=1100000, pchDt=2021-05-25, disDt=, sNum=, remk=자산조사4차, branchCd=1010, branchName=, useYn=N, dataRegdt=, dataRegnt=, isAdminType=, isRsDrt=, isRsStaff=, isDelCntr=]
		 LOGGER.debug("member= "+member.toString());
		 
		 // 자산명칭 - 이름 
	     String astName = member.getAstName();
	     if( !RegExp.check(RegExp.MEM_NAME, astName)) {
	        errors.put("astName", "자산명칭은 은 최대 50글자까지 입력 가능하며,\n한글은 완성형만 입력하실 수 있습니다.");
	     }
		 
	     // 제조사명칭 - 이름 
	     String fctvName = member.getFctvName();
	     if( !RegExp.check(RegExp.MEM_NAME, fctvName)) {
	        errors.put("fctvName", "제조사 명칭은 은 최대 50글자까지 입력 가능하며,\n한글은 완성형만 입력하실 수 있습니다.");
	     }
	     
	     // 구매처 - 이름 
	     String pchvName = member.getPchvName();
	     if( !RegExp.check(RegExp.MEM_NAME, pchvName)) {
	        errors.put("pchvName", "구매처 명칭은 은 최대 50글자까지 입력 가능하며,\n한글은 완성형만 입력하실 수 있습니다.");
	     }
	     		 
	     // 구매가격 - 숫자 
	     String pchAmt = member.getPchAmt();
	     if( !RegExp.check(RegExp.MEM_NUM, pchAmt)) {
	        errors.put("pchAmt", "구매가격은 숫자만 가능합니다.");
	     }
	     
	     // 부가세 - 숫자 
	     String pchAmtvt = member.getPchAmtvt();
	     if( !RegExp.check(RegExp.MEM_NUM, pchAmtvt)) {
	        errors.put("pchAmtvt", "부가세는 숫자만 가능합니다.");
	     }
	     
	     // 합계 - 숫자 
	     String pchTamt = member.getPchAmtvt();
	     if( !RegExp.check(RegExp.MEM_NUM, pchTamt)) {
	        errors.put("pchTamt", "합계는 숫자만 가능합니다.");
	     }
	     	     
	     // 사용여부 - Y,N 
	     String useYn = member.getUseYn();
	     if( !RegExp.check(RegExp.MEM_IS_YUNWOO_MEM, useYn)) {
	    	 // 공백도 가능
	         errors.put("useYn", "사용여부는 미입력, Y, N 값만 가능합니다.");
	     }
	     
	     // 비고 - 이름
	     String remk = member.getRemk();
	     if( !RegExp.check(RegExp.MEM_NAME, remk)) {
	    	 // 공백도 가능
	         errors.put("remk", "비고는 최대 50글자까지 입력 가능합니다.");
	     }
	     
	     // 전문분야
	     //String proField = member.getProField();
	     //if( !RegExp.check(RegExp.MEM_PROFIELD, proField)) {
	         //errors.put("proField", "잘못된 전문분야값이 입력되었습니다.");
	     //}
	     
	     // 전화번호
	     //String phoneNo = member.getPhoneNo();
	     //if( !RegExp.check(RegExp.MEM_PHONE, phoneNo)) {
	         //errors.put("phoneNo", "전화번호는 " + RegExp.phoneWarn);
	     //}
	     
	     // 휴대폰번호
	     //String mPhoneNo = member.getMphoneNo();
	     //if( !RegExp.check(RegExp.MEM_PHONE, mPhoneNo)) {
	         //errors.put("mPhoneNo", "휴대폰번호는 " + RegExp.phoneWarn);
	     //}
	     
	     // 팩스번호
	     //String faxNo = member.getFaxNo();
	     //if( !RegExp.check(RegExp.MEM_PHONE, faxNo)) {
	         //errors.put("faxNo", "팩스번호는 " + RegExp.phoneWarn);
	     //}
	     
	     // 이메일
	     //String email = member.geteMail();
	     //if( !RegExp.check(RegExp.MEM_EMAIL, email)) {
	         //errors.put("email1", RegExp.emailWarn);
	     //}
	     
	     // 이메일2
	     //String email2 = member.geteMail2();
	     //if( !RegExp.check(RegExp.MEM_EMAIL, email2)) {
	         //errors.put("email2", RegExp.emailWarn);
	     //}
	     
	     // 이메일3
	     //String email3 = member.geteMail3();
	     //if( !RegExp.check(RegExp.MEM_EMAIL, email3)) {
	         //errors.put("email3", RegExp.emailWarn);
	     //}
	     
	     //String zipCode1 = member.getZipCode1();
	     //if( !RegExp.check(RegExp.MEM_POST_CODE, zipCode1)) {
	         //errors.put("zipCode1", "자택 우편번호는 "+ RegExp.zipCodeWarn);
	     //}
	     
	     //String address1 = member.getAddress1();
	     //if( !RegExp.check(RegExp.getLengthRegExp(0, 60), address1)) {
	         //errors.put("address1", "자택 상세주소1는 "+ RegExp.addrWarn);
	     //}

	     //String address2 = member.getAddress2();
	     //if( !RegExp.check(RegExp.getLengthRegExp(0, 60), address2)) {
	    	 //errors.put("address2", "자택 상세주소2는 "+ RegExp.addrWarn);
	     //}
	     
	     //String zipCode2 = member.getZipCode2();
	     //if( !RegExp.check(RegExp.MEM_POST_CODE, zipCode2)) {
	         //errors.put("zipCode2", "회사 우편번호는 "+ RegExp.zipCodeWarn);
	     //}
	     
	     //String officeAddr1 = member.getOfficeAddr1();
	     //if( !RegExp.check(RegExp.getLengthRegExp(0, 60), officeAddr1)) {
	         //errors.put("officeAddr1", "회사 상세주소1는 "+ RegExp.addrWarn);
	     //}
	     
	     //String officeAddr2 = member.getOfficeAddr2();
	     //if( !RegExp.check(RegExp.getLengthRegExp(0, 60), officeAddr2)) {
	         //errors.put("officeAddr2", "회사 상세주소2는 "+ RegExp.addrWarn);
	     //}
	     
	     //String area = member.getArea();
	     //if( !RegExp.check(RegExp.getLengthRegExp(1, 30), area)) {
	         //errors.put("area", "지역을 입력하셔야 합니다.");
	     //}
	     
	     //String organ = member.getOrgan();
	     //if( !RegExp.check(RegExp.getLengthRegExp(0, 30), organ)) {
	         //errors.put("organ", "소속은 "+ RegExp.organWarn);
	     //}
	     
	     //String depart = member.getDepart();
	     //if( !RegExp.check(RegExp.getLengthRegExp(0, 30), depart)) {
	         //errors.put("depart", "부서는  "+ RegExp.organWarn);
	     //}
	     
	     //String position = member.getPosition();
	     //if( !RegExp.check(RegExp.getLengthRegExp(0, 30), position)) {
	         //errors.put("position", "직위는"+ RegExp.organWarn);
	     //}
	     
	     //String regDt = member.getRegDt();
	     //if( !RegExp.check(RegExp.MEM_REG_DATE, regDt)) {
	         //errors.put("regDt", "등록일은  "+ RegExp.dtWarn);
	     //}
	     
	     //String recommender = member.getRecommender();
	     //if( !RegExp.check(RegExp.getLengthRegExp(0, 10), recommender)) {
	         //errors.put("recommender", "추천인은"+ RegExp.getMaxLengWarnTxt(10,""));
	     //}
	     
	     //String isYunwooMem = member.getIsYunwooMem();
	     //if( !RegExp.check(RegExp.MEM_IS_YUNWOO_MEM, isYunwooMem)) {
	    	 // 공백도 가능
	         //errors.put("isYunwooMem", "유료도서회원(연우회원)은  미입력, Y, N 값만 가능합니다.");
	     //}

	     //String respoect = member.getRespect();
	     //if( !RegExp.check(RegExp.MEM_RESPECT, respoect)) {
	    	 // 공백도 가능
	    	 //errors.put("respoect","존칭은  미입력, '님 귀하', '귀중'만 가능합니다.");
	     //}
	     
		 // 성별 
	     //String gender = member.getGender();
	     //if( !RegExp.check(RegExp.MEM_GENDER, gender)) {
	         //errors.put("gender", "성별은 1남 2여, 3해당없음 3가지 종류 입니다. ");
	     //}

	     // 우편물 수령처
	     //String destination = member.getDestination();
	     //if( !RegExp.check(RegExp.MEM_DESTINATION, destination)) {
	    	 //errors.put("destination", "우편물수령처는 1자택 2회사, 2가지 종류 입니다. ");
	     //}
	     
	     // 고객그룹 1개 이상 있어야함.
	     //if(!("Y".equals(member.getCore())
	    	//|| "Y".equals(member.getCorr())
	    	//|| "Y".equals(member.getReporter())
	    	//|| "Y".equals(member.getTot())
	    	//|| "Y".equals(member.getPayb()))
	     //) {
	    	 //errors.put("memGroup", "고객그룹은 1개 이상 선택하셔야 합니다.");
	     //}
	     
	     return errors;
	 }
}


