package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

/**
 * 施工计划模板
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_plan_templat")
public class PlanTemplatEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long cpId;

    public Long getCpId() {
        return cpId;
    }

    public void setCpId(Long cpId) {
        this.cpId = cpId;
    }
    /**
     * id
     */
    @TableId
    private Long id;
    /**
     * 计划类别
     */
    private Long planType;

    @TableField(exist = false)
    private String planTypeName;
    /**
     * 项目
     */
    private Long projectId;

    @TableField(exist = false)
    private String projectName;
    /**
     * 偏移天数
     */
    private Integer offsetDays;
    /**
     * 历时天数
     */
    private Integer durationDays;
    /**
     * 排序
     */
    private Integer sort;
    /**
     * 备注
     */
    private String remark;


    public String getPlanTypeName() {
        return planTypeName;
    }

    public void setPlanTypeName(String planTypeName) {
        this.planTypeName = planTypeName;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    /**
     * 设置：id
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * 获取：id
     */
    public Long getId() {
        return id;
    }

    /**
     * 设置：计划类别
     */
    public void setPlanType(Long planType) {
        this.planType = planType;
    }

    /**
     * 获取：计划类别
     */
    public Long getPlanType() {
        return planType;
    }

    /**
     * 设置：项目
     */
    public void setProjectId(Long projectId) {
        this.projectId = projectId;
    }

    /**
     * 获取：项目
     */
    public Long getProjectId() {
        return projectId;
    }

    /**
     * 设置：偏移天数
     */
    public void setOffsetDays(Integer offsetDays) {
        this.offsetDays = offsetDays;
    }

    /**
     * 获取：偏移天数
     */
    public Integer getOffsetDays() {
        return offsetDays;
    }

    /**
     * 设置：历时天数
     */
    public void setDurationDays(Integer durationDays) {
        this.durationDays = durationDays;
    }

    /**
     * 获取：历时天数
     */
    public Integer getDurationDays() {
        return durationDays;
    }

    /**
     * 设置：排序
     */
    public void setSort(Integer sort) {
        this.sort = sort;
    }

    /**
     * 获取：排序
     */
    public Integer getSort() {
        return sort;
    }

    /**
     * 设置：备注
     */
    public void setRemark(String remark) {
        this.remark = remark;
    }

    /**
     * 获取：备注
     */
    public String getRemark() {
        return remark;
    }
}
