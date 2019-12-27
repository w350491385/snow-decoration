package top.czttn.modules.sys.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

/**
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-04-08 16:12:46
 */
@TableName("sys_company_regist")
public class CompanyRegistEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @TableId
    private Long id;
    /**
     *
     */
    private String cpName;

    private String email;
    /**
     *
     */
    private String phone;
    /**
     *
     */
    private String username;
    /**
     *
     */
    @TableField(exist = false)
    private String password1;

    @TableField(exist = false)
    private String password2;
    private String password;


    public String getPassword1() {
        return password1;
    }

    public void setPassword1(String password1) {
        this.password1 = password1;
    }

    public String getPassword2() {
        return password2;
    }

    public void setPassword2(String password2) {
        this.password2 = password2;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * 设置：
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * 获取：
     */
    public Long getId() {
        return id;
    }

    /**
     * 设置：
     */
    public void setCpName(String cpName) {
        this.cpName = cpName;
    }

    /**
     * 获取：
     */
    public String getCpName() {
        return cpName;
    }

    /**
     * 设置：
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * 获取：
     */
    public String getPhone() {
        return phone;
    }

    /**
     * 设置：
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * 获取：
     */
    public String getUsername() {
        return username;
    }

    /**
     * 设置：
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * 获取：
     */
    public String getPassword() {
        return password;
    }
}
