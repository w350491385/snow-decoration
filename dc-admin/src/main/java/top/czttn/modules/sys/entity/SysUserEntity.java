package top.czttn.modules.sys.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import top.czttn.common.validator.group.AddGroup;
import top.czttn.common.validator.group.UpdateGroup;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 系统用户
 *
 * @author czj
 * @email 493804781@qq.com
 * @date 2016年9月18日 上午9:28:55
 */
@TableName("sys_user")
public class SysUserEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    /** 企业id */
    private Long cpId;

    @TableField(exist = false)
    private String cpName;

    private String email;

    /** 是否主账号 */
    private Boolean ifMain;

    private String lastLoginTime;
    /**
     * 用户ID
     */
    @TableId
    private Long userId;
    /** 所在部门 */
    private Long deptId;
    @TableField(exist = false)
    private String deptName;

    /**
     * 用户名
     */
    @NotBlank(message = "用户名不能为空", groups = {AddGroup.class, UpdateGroup.class})
    private String username;

    /**
     * 密码
     */
    private String password;

    /**
     * 盐
     */
    private String salt;

    /**
     * 手机号
     */
    private String mobile;
    /** 职位 */
    private String job;
    /** 入职日期 */
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date entry;
    /** 是否激活 */
    private Boolean ifOn;

    /** 服务岗位名称集合 */
    @TableField(exist = false)
    private List<String> position;
    /** 角色名称集合 */
    @TableField(exist = false)
    private List<String> role;
    /**
     * 角色ID列表
     */
    @TableField(exist = false)
    private List<Long> roleIdList;
    /** 服务岗位 */
    @TableField(exist = false)
    private List<Long> positionIdList;

    @TableField(exist = false)
    private List<Long> personViewIdList;

    @TableField(exist = false)
    private List<Long> deptViewIdList;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    /** 被转客户id */
    @TableField(exist = false)
    private List<Long> clientIdList;
    /** 目标用户id */
    @TableField(exist = false)
    private Long targetUser;

    public String getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(String lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<Long> getClientIdList() {
        return clientIdList;
    }

    public void setClientIdList(List<Long> clientIdList) {
        this.clientIdList = clientIdList;
    }

    public Long getTargetUser() {
        return targetUser;
    }

    public void setTargetUser(Long targetUser) {
        this.targetUser = targetUser;
    }

    public String getCpName() {
        return cpName;
    }

    public void setCpName(String cpName) {
        this.cpName = cpName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Boolean getIfMain() {
        return ifMain;
    }

    public void setIfMain(Boolean ifMain) {
        this.ifMain = ifMain;
    }

    public Long getCpId() {
        return cpId;
    }

    public void setCpId(Long cpId) {
        this.cpId = cpId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public List<Long> getPersonViewIdList() {
        return personViewIdList;
    }

    public void setPersonViewIdList(List<Long> personViewIdList) {
        this.personViewIdList = personViewIdList;
    }

    public List<Long> getDeptViewIdList() {
        return deptViewIdList;
    }

    public void setDeptViewIdList(List<Long> deptViewIdList) {
        this.deptViewIdList = deptViewIdList;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getDeptId() {
        return deptId;
    }

    public void setDeptId(Long deptId) {
        this.deptId = deptId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public Date getEntry() {
        return entry;
    }

    public void setEntry(Date entry) {
        this.entry = entry;
    }

    public Boolean getIfOn() {
        return ifOn;
    }

    public void setIfOn(Boolean ifOn) {
        this.ifOn = ifOn;
    }

    public List<Long> getRoleIdList() {
        return roleIdList;
    }

    public void setRoleIdList(List<Long> roleIdList) {
        this.roleIdList = roleIdList;
    }

    public List<Long> getPositionIdList() {
        return positionIdList;
    }

    public void setPositionIdList(List<Long> positionIdList) {
        this.positionIdList = positionIdList;
    }

    public List<String> getPosition() {
        return position;
    }

    public void setPosition(List<String> position) {
        this.position = position;
    }

    public List<String> getRole() {
        return role;
    }

    public void setRole(List<String> role) {
        this.role = role;
    }
}
