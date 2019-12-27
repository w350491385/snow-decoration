package top.czttn.common.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class MailService {

    @Resource
    private JavaMailSender sender;

    @Value("${spring.mail.username}")
    private String formMail;

    public void sendSimpleMail(String toMail, String subject, String content) {
        SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
        simpleMailMessage.setFrom(formMail);
        simpleMailMessage.setTo(toMail);
        simpleMailMessage.setSubject(subject);
        simpleMailMessage.setText(content);
        try {
            sender.send(simpleMailMessage);
            System.out.println("发送给" + toMail + "简单邮件已经发送。 subject：" + subject);
        } catch (Exception e) {
            System.out.println("发送给" + toMail + "简单邮件已经发送。 subject：" + subject);
            e.printStackTrace();
        }
    }
}
