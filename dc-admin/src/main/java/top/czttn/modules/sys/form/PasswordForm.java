

package top.czttn.modules.sys.form;

/**
 * 密码表单
 *
 * @author Mark sunlightcs@gmail.com
 * @since 1.4.0 2018-01-25
 */
public class PasswordForm {
    /**
     * 原密码
     */
    private String password;
    /**
     * 新密码
     */
    private String newPassword;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }
}
