package top.czttn.modules.sys.form;

/**
 * 注册表单
 */
public class RegistForm {
    /** 邮箱 */
    private String email;
    /** 验证码 */
    private String code;
    /** 密码 */
    private String password;
    /** 企业名称 */
    private String cpName;
    /** 法人代表 */
    private String ceo;
    /** 联系电话 */
    private String phone;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCpName() {
        return cpName;
    }

    public void setCpName(String cpName) {
        this.cpName = cpName;
    }

    public String getCeo() {
        return ceo;
    }

    public void setCeo(String ceo) {
        this.ceo = ceo;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
