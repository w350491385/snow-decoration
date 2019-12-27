package top.czttn.modules.sys.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.List;

/**
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-02-26 23:07:39
 */
@TableName("sys_company")
public class CompanyEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     *
     */
    @TableId
    private Long cpId;

    private Integer allowAccount;
    /**
     * 企业名称
     */
    private String cpName;
    /**
     * CEO
     */
    private String ceo;
    /**
     * 营业执照
     */
    private String licenseUrl;
    /**
     * 联系电话
     */
    private String phone;

    private String address;

    @TableField(exist=false)
    private List<Long> menuIdList;


    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<Long> getMenuIdList() {
        return menuIdList;
    }

    public void setMenuIdList(List<Long> menuIdList) {
        this.menuIdList = menuIdList;
    }

    public Integer getAllowAccount() {
        return allowAccount;
    }

    public void setAllowAccount(Integer allowAccount) {
        this.allowAccount = allowAccount;
    }

    /**
     * 设置：
     */
    public void setCpId(Long cpId) {
        this.cpId = cpId;
    }

    /**
     * 获取：
     */
    public Long getCpId() {
        return cpId;
    }

    /**
     * 设置：企业名称
     */
    public void setCpName(String cpName) {
        this.cpName = cpName;
    }

    /**
     * 获取：企业名称
     */
    public String getCpName() {
        return cpName;
    }

    /**
     * 设置：CEO
     */
    public void setCeo(String ceo) {
        this.ceo = ceo;
    }

    /**
     * 获取：CEO
     */
    public String getCeo() {
        return ceo;
    }

    /**
     * 设置：营业执照
     */
    public void setLicenseUrl(String licenseUrl) {
        this.licenseUrl = licenseUrl;
    }

    /**
     * 获取：营业执照
     */
    public String getLicenseUrl() {
        return licenseUrl;
    }

    /**
     * 设置：联系电话
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * 获取：联系电话
     */
    public String getPhone() {
        return phone;
    }
}
