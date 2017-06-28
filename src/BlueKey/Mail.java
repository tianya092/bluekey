package BlueKey;
import javax.mail.Session;
import javax.mail.Transport;
//import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.InternetAddress;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Map;
import java.util.Properties;


public class Mail {
	private static  String  subjectTitle;  					//邮箱服务器名
	private static  String  content;  					        //
	
	

	private static String  mailServer = "d23hubm8";  			//邮箱服务器名
	private static String  mailProt = "smtp";						//邮箱服务协议
	
	private static String  mailAccount = "brucel@cn.ibm.com";		//邮箱服务器名
	private static String  mailPassword = " ";
	private static String  receiveMailAccount = "brucel@cn.ibm.com";
	
	public String getSubjectTitle() {
		return subjectTitle;
	}

	public void setSubjectTitle(String subjectTitle) {
		this.subjectTitle = subjectTitle;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public void setReceiveAccount(String receiveMailAccount){
		this.receiveMailAccount = receiveMailAccount;
	}
	
	public void setMailAccount(String mailAccount){
		this.mailAccount = mailAccount;
	}
	
	public  boolean sendMail() throws Exception{
		boolean flag =false;  
		try{
			
			// 1. 创建一封邮件
		    Properties props = new Properties();               
		    props.setProperty("mail.debug", "true");			   	//开启debug调试模式
		    props.setProperty("mail.host", mailServer);   		   	//设置邮件服务器的主机名
		    props.setProperty("mail.transport.protocol", mailProt);	//设置邮件服务器的协议名称
		    props.setProperty("mail.smtp.auth", "true");            // 需要请求认证

		    
		    // PS: 某些邮箱服务器要求 SMTP 连接需要使用 SSL 安全认证 (为了提高安全性, 邮箱支持SSL连接, 也可以自己开启),
	        //     如果无法连接邮件服务器, 仔细查看控制台打印的 log, 如果有有类似 “连接失败, 要求 SSL 安全连接” 等错误,
	        //     打开下面 /* ... */ 之间的注释代码, 开启 SSL 安全连接。
	        
	        // SMTP 服务器的端口 (非 SSL 连接的端口一般默认为 25, 可以不添加, 如果开启了 SSL 连接,
	        //                  需要改为对应邮箱的 SMTP 服务器的端口, 具体可查看对应邮箱服务的帮助,
	        //                  QQ邮箱的SMTP(SLL)端口为465或587, 其他邮箱自行去查看)
//	        final String smtpPort = "465";
//	        props.setProperty("mail.smtp.port", smtpPort);
//          props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//	        props.setProperty("mail.smtp.socketFactory.fallback", "false");
//	        props.setProperty("mail.smtp.socketFactory.port", smtpPort);
	        
		    
		    Session session= Session.getDefaultInstance(props); // 根据参数配置，创建会话对象（为了发送邮件准备的）
		    
		    MimeMessage message = createMimeMessage(session, mailAccount, receiveMailAccount);

		    Transport transport = session.getTransport();
		    transport.connect(mailServer,mailPassword);
		    transport.sendMessage(message, message.getAllRecipients());
		    
		    transport.close();
		    flag = true;
		   
		}
		catch (Exception e) {
		      System.err.println("邮件发送失败的原因是：" + e.getMessage());
		      System.err.println("具体错误原因：");
		      e.printStackTrace(System.err);
		 }
		return flag;
}
	
	/**
     * 创建一封只包含文本的简单邮件
     *
     * @param session 和服务器交互的会话
     * @param sendMail 发件人邮箱
     * @param receiveMail 收件人邮箱
     * @return
     * @throws Exception
     */
    public static  MimeMessage createMimeMessage(Session session, String sendMail, String receiveMail) throws Exception {
    	
    
        // 1. 创建一封邮件
        MimeMessage message = new MimeMessage(session);

        // 2. From: 发件人
        message.setFrom(new InternetAddress(sendMail, "某宝网", "UTF-8"));

        // 3. To: 收件人（可以增加多个收件人、抄送、密送）
        message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "XX用户", "UTF-8"));

        // 4. Subject: 邮件主题
        message.setSubject(subjectTitle, "UTF-8");

        // 5. Content: 邮件正文（可以使用html标签）
        message.setContent(content, "text/html;charset=UTF-8");

        // 6. 设置发件时间
        message.setSentDate(new Date());

        // 7. 保存设置
        message.saveChanges();

        return message;
    }

	 
}
