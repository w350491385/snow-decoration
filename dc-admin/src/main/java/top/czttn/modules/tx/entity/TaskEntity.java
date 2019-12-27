package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

/**
 * 任务
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_task")
public class TaskEntity implements Serializable {
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
     * 发起人
     */
    private String launchMan;
    /**
     * 内容
     */
    private String content;
    /**
     * 状态
     */
    private Integer status;
    /**
     * 重要性
     */
    private String importance;
    /**
     * 负责人
     */
    private String principal;

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
     * 设置：内容
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * 获取：内容
     */
    public String getContent() {
        return content;
    }

    /**
     * 设置：状态
     */
    public void setStatus(Integer status) {
        this.status = status;
    }

    /**
     * 获取：状态
     */
    public Integer getStatus() {
        return status;
    }

    /**
     * 设置：重要性
     */
    public void setImportance(String importance) {
        this.importance = importance;
    }

    /**
     * 获取：重要性
     */
    public String getImportance() {
        return importance;
    }

    public String getLaunchMan() {
        return launchMan;
    }

    public void setLaunchMan(String launchMan) {
        this.launchMan = launchMan;
    }

    public String getPrincipal() {
        return principal;
    }

    public void setPrincipal(String principal) {
        this.principal = principal;
    }
}
