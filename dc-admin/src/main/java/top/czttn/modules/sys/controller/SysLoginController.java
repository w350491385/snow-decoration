package top.czttn.modules.sys.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import top.czttn.common.utils.MailService;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.entity.SysUserEntity;
import top.czttn.modules.sys.form.ForgetForm;
import top.czttn.modules.sys.form.RegistForm;
import top.czttn.modules.sys.form.SysLoginForm;
import top.czttn.modules.sys.service.SysCaptchaService;
import top.czttn.modules.sys.service.SysUserService;
import top.czttn.modules.sys.service.SysUserTokenService;
import org.apache.commons.io.IOUtils;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

/**
 * 登录相关
 */
@RestController
public class SysLoginController extends AbstractController {
    @Resource
    private SysUserService sysUserService;
    @Resource
    private SysUserTokenService sysUserTokenService;
    @Resource
    private SysCaptchaService sysCaptchaService;
    @Resource
    private MailService mailService;


    /**
     * 验证码
     */
    @GetMapping("captcha.jpg")
    public void captcha(HttpServletResponse response, String uuid) throws IOException {
        response.setHeader("Cache-Control", "no-store, no-cache");
        response.setContentType("image/jpeg");

        //获取图片验证码
        BufferedImage image = sysCaptchaService.getCaptcha(uuid);

        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(image, "jpg", out);
        IOUtils.closeQuietly(out);
    }

    /**
     * 登录
     */
    @PostMapping("/sys/login")
    public Map<String, Object> login(@RequestBody SysLoginForm form){
        boolean captcha = sysCaptchaService.validate(form.getUuid(), form.getCaptcha());
        if (!captcha) {
            return R.error("验证码不正确");
        }

        //用户信息
        SysUserEntity user = sysUserService.queryUser(form.getUsername());

        //账号不存在、密码错误
        if (user == null || !user.getPassword().equals(new Sha256Hash(form.getPassword(), user.getSalt()).toHex())) {
            return R.error("账号或密码不正确");
        }

        //账号锁定
        if (!user.getIfOn()) {
            return R.error("账号未激活,请联系管理员");
        }
        // 非首次登录则更新最后登录时间
        if (user.getLastLoginTime() != null) {
            sysUserService.updateLastLoginTime(user.getUserId());
        }

        //生成token，并保存到数据库
        R r = sysUserTokenService.createToken(user.getUserId());
        return r;
    }


    /**
     * 退出
     */
    @PostMapping("/sys/logout")
    public R logout() {
        sysUserTokenService.logout(getUserId());
        return R.ok();
    }


    /**
     * 注册获取邮件验证码
     */
    @PostMapping("/sys/registMail/{mail}")
    public R registMail(@PathVariable String mail) {
        // 查询是否已被注册
        SysUserEntity selectOne = sysUserService.selectOne(new EntityWrapper<SysUserEntity>().eq("email", mail));
        if (selectOne != null) {
            return R.error("邮箱已被注册");
        }
        String code = sysCaptchaService.getMailCaptcha(mail);
        mailService.sendSimpleMail(mail, "[流雪家装管理]用户注册", "验证码为:" + code + ",有效时长5分钟");
        return R.ok();
    }

    /**
     * 企业注册
     */
    @PostMapping("/sys/regist")
    public Map<String, Object> regist(@RequestBody RegistForm form){
        // 查询手机号是否已存在
        SysUserEntity mobile = sysUserService.queryByMobile(form.getPhone());
        if (mobile != null) {
            return R.error("电话号码已被使用");
        }
        // 查询邮箱是否已存在
        SysUserEntity queryByEmail = sysUserService.queryByEmail(form.getEmail());
        if (queryByEmail != null) {
            return R.error("邮箱已被使用");
        }
        boolean captcha = sysCaptchaService.validateMail(form.getEmail(), form.getCode());
        if (!captcha) {
            return R.error("验证码不正确");
        }
        sysUserService.regist(form);
        return R.ok();
    }

    /**
     * 个人注册
     */
    @PostMapping("/sys/registPerson")
    public Map<String, Object> registPerson(@RequestBody RegistForm form){
        // 查询邮箱是否已存在
        SysUserEntity queryByEmail = sysUserService.queryByEmail(form.getEmail());
        if (queryByEmail != null) {
            return R.error("邮箱已被使用");
        }
        boolean captcha = sysCaptchaService.validateMail(form.getEmail(), form.getCode());
        if (!captcha) {
            return R.error("验证码不正确");
        }
        // 设置默认企业信息
        String substring = UUID.randomUUID().toString().replace("-", "").substring(0, 5);
        form.setCeo(substring);
        form.setCpName(substring);
        sysUserService.registPerson(form);
        return R.ok();
    }

    /**
     * 忘记密码获取邮件验证码
     */
    @PostMapping("/sys/forgetMail/{mail}")
    public R forgetMail(@PathVariable String mail) {
        // 查询是否存在
        SysUserEntity one = sysUserService.selectOne(new EntityWrapper<SysUserEntity>().eq("email", mail));
        if (one == null) {
            return R.error("用户不存在");
        }
        String code = sysCaptchaService.getMailCaptcha(mail);
        mailService.sendSimpleMail(mail, "[流雪家装管理]重置密码", "验证码为:" + code + ",有效时长5分钟");
        return R.ok();
    }

    /**
     * 忘记密码,重置密码
     */
    @PostMapping("/sys/forget")
    public Map<String, Object> forget(@RequestBody ForgetForm form){
        boolean captcha = sysCaptchaService.validateMail(form.getEmail(), form.getCode());
        if (!captcha) {
            return R.error("验证码不正确");
        }
        // 根据email更新用户密码
        sysUserService.updateByEmail(form);
        return R.ok();
    }

}
