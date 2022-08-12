package component.mail;

import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import component.file.FileInfoVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Component
public class MailSendUtil {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MailSendUtil.class);
    
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;

	/**
	 * 이미지 태그의 width와 height 값을 max-width와 max-height로 변경한다
	 * 	- 기존의 min-width, max-width와 min-height, max-height는 삭제한다
	 * @param content
	 * @throws MessagingException 
	 * @throws AddressException 
	 * 
	 */
	public void sendEmail(String usrEmail, String usrName, String afterPwd, String title, String cont, String thost, String tusername, String tpassword, List<FileInfoVO> fileList) throws Exception{
		
		String uploadHome = propertyService.getString("Globals.fileStorePath.attachedFile");
		
		String host = thost; 
		final String username = tusername;  
		final String password = tpassword; 
		// 네이버일 경우 smtp.naver.com 을 입력합니다. 
		// Google일 경우 smtp.gmail.com 을 입력합니다. 
		//String host = "smtp.naver.com"; 
		
		//final String username = "j3sfactory"; //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요. 테이블 설정  
		//final String password = "j3s198531!#"; //네이버 이메일 비밀번호를 입력해주세요. 암호화처리 필요함  테이블 설정
		int port=465; //포트번호 
		
		// 메일 내용
		String recipient = usrEmail; //받는 사람의 메일주소를 입력해주세요. 
		String subject = title; //메일 제목 입력해주세요. 
		String body = ""; //메일 내용
		body += "안녕하세요. 에이치앤바이오 피부임상센터 입니다.\r\n\r\n";
		body += usrName + "님에게 안내해드립니다.\r\n";
		body += cont+"\r\n\r\n";  
		body += "그럼, 좋은 하루 되시길 바랍니다.\r\n\r\n";  
		body += "- H&Bio 피부임상센터 -\r\n\r\n";  
		body += "[본 메일은 발신 전용입니다. 문의사항은 H&Bio 피부임상센터로 연락 주시기 바랍니다.]";  
		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성 

		
		// SMTP 서버 정보 설정
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		//Session 생성
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				String un=username; 
				String pw=password; 
				protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
					return new javax.mail.PasswordAuthentication(un, pw); 
				} 
		});
		session.setDebug(true); //for debug
		
		Message mimeMessage = new MimeMessage(session); //MimeMessage 생성
		mimeMessage.setFrom(new InternetAddress(username+"@naver.com")); //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요.
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
		
		mimeMessage.setSubject(subject); //제목셋팅

		if(fileList != null && fileList.size() != 0){
			// 첨부파일이 있을 경우
			MimeMultipart multipart = new MimeMultipart();
			for(FileInfoVO fileInfoVO : fileList){
				LOGGER.info("------------------------------------------------ "+uploadHome + fileInfoVO.getFilePath());
				MimeBodyPart messageBodyPart = new MimeBodyPart();
				DataSource source = new FileDataSource(uploadHome + fileInfoVO.getFilePath());
				
				messageBodyPart.setDataHandler(new DataHandler(source));
				messageBodyPart.setFileName(MimeUtility.encodeText(fileInfoVO.getFileName(),"euc-kr","B"));
				multipart.addBodyPart(messageBodyPart);
			}
			MimeBodyPart bodyPart = new MimeBodyPart();
			bodyPart.setText(body); //내용셋팅
			multipart.addBodyPart(bodyPart);
			
			mimeMessage.setContent(multipart, "text/plain; charset=UTF-8");
		}else{
			// 첨부파일이 없으면 내용만 전송
			mimeMessage.setText(body); //내용셋팅
		}
		
		Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
	}
	
}
