
package utilities;
import java.util.Date;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailWork {
    //mail người gửi
    private String from="healingland001@gmail.com";
    //password cho ứng dụng email cung cấp để đăng nhập vào email
    private String password="nfjksexgcagogpzy";   
    //thuộc tính
    private Properties properties;
    // tạo 1 phiên đăng nhập
    private Authenticator auth;
    // tạo 1 phiên
    private Session session;
    public EmailWork() {
        properties=new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        auth=new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
            
        };
        session=Session.getInstance(properties, auth);
    }
    public boolean sendEmail(String to, String subject, String content){               
        try {
            // tạo tin nhắn
            MimeMessage msg = new MimeMessage(session);
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(from);
            //người nhận
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject(subject);
            msg.setSentDate(new Date());
            msg.setText(content, "UTF-8");
            Transport.send(msg);
            return true;
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    
    public String sendOtpToEmail(String to){ 
        String otp_code=random.createOtpCode();
        if(sendEmail(to, "Sao quên hoài vậy!!!", "OTP đây: " + otp_code))return otp_code;
        return "";
    }
    public static void main(String[] args) {
        EmailWork ew=new EmailWork();
        ew.sendOtpToEmail("nguyenvietthanhtrunga3@gmail.com");
        
    }
}
