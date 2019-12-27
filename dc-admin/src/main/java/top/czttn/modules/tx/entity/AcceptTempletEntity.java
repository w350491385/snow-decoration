package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

/**
 * 验收模板
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_accept_templet")
public class AcceptTempletEntity implements Serializable {
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
     * 验收类别
     */
    private Long acceptType;

    @TableField(exist = false)
    private String acceptTypeName;
    /**
     * 验收项目
     */
    private Long projectId;
    @TableField(exist = false)
    private String projectName;
    /**
     * 标准
     */
    private String standard;
    /**
     * 是否必检
     */
    private Integer ifMust;
    /**
     * 标准图片_json
     */
    private String pictureJson;

    public String getAcceptTypeName() {
        return acceptTypeName;
    }

    public void setAcceptTypeName(String acceptTypeName) {
        this.acceptTypeName = acceptTypeName;
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
     * 设置：验收类别
     */
    public void setAcceptType(Long acceptType) {
        this.acceptType = acceptType;
    }

    /**
     * 获取：验收类别
     */
    public Long getAcceptType() {
        return acceptType;
    }

    /**
     * 设置：验收项目
     */
    public void setProjectId(Long projectId) {
        this.projectId = projectId;
    }

    /**
     * 获取：验收项目
     */
    public Long getProjectId() {
        return projectId;
    }

    /**
     * 设置：标准
     */
    public void setStandard(String standard) {
        this.standard = standard;
    }

    /**
     * 获取：标准
     */
    public String getStandard() {
        return standard;
    }

    /**
     * 设置：是否必检
     */
    public void setIfMust(Integer ifMust) {
        this.ifMust = ifMust;
    }

    /**
     * 获取：是否必检
     */
    public Integer getIfMust() {
        return ifMust;
    }

    /**
     * 设置：标准图片_json
     */
    public void setPictureJson(String pictureJson) {
        this.pictureJson = pictureJson;
    }

    /**
     * 获取：标准图片_json
     */
    public String getPictureJson() {
        return pictureJson;
    }
}
