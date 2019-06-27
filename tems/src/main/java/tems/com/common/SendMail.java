package tems.com.common;

import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.Properties;
import java.util.UUID;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;


public class SendMail {
	
    
	public String send(String addTo, String subject, String msg) throws EmailException {
		//MultiPartEmail email = new MultiPartEmail();
		HtmlEmail email = new HtmlEmail();
		
		try {
		//테스트시 백신이 구동중이면 에러가 뜬다... 뭐 이런............
		email.setCharset("UTF-8");
		email.setHostName("smtp.gmail.com");
		email.setSSL(true);
		email.setSmtpPort(465);
		email.setStartTLSEnabled(true);
		email.setAuthentication("kpetroinfomail@gmail.com", "kpetroinfo");		//메일서버 인증 아이디/비밀번호
		email.setFrom("yamamusa83@gmail.com", "이찬무");	//보내는사람
		email.addTo("novass83@gmail.com", "이찬무");		//받는사람
		email.setSubject("test");						//제목
		email.setMsg("메일");								//내용
		// 삽입할 이미지와 그 Content Id를 설정합니다
		URL url = new URL("http://www.apache.org/images/asf_logo_wide.gif");	//성적서 링크 경로
		String cid = email.embed(url, "Apache logo");							//성적서 링크 이미지
		String linkurl = "http://www.apache.org/images/asf_logo_wide.gif";
 
		// HTML 메세지를 설정합니다	
		email.setHtmlMsg("<html><a href='"+linkurl+"'><img src=\"cid:"+cid+"\"></a></html>");
 
		// HTML 이메일을 지원하지 않는 클라이언트라면 다음 메세지를 뿌려웁니다
		email.setTextMsg("Your email client does not support HTML messages");
		 

		for(int i=0;i<2;i++){	//첨부파일 갯수만큼 루프를 돌린다..
			EmailAttachment attachment = new EmailAttachment();
			attachment.setPath("C:/uploadFile/201601/1454035486854c479226f-3e02-418d-bb01-79cb952705bd.doc");
			attachment.setDisposition(EmailAttachment.ATTACHMENT);
			attachment.setDescription("첨부 관련 TEST입니다");
			attachment.setName(new String("FSW 스크립트 함수 설명.doc".getBytes("euc-kr"), "latin1"));	//한글깨짐 방지
			email.attach(attachment);
		}

		email.send();
		return "Y";
		} catch (Exception e) {
			e.printStackTrace();
			return "N";
		}
		
	}

}
