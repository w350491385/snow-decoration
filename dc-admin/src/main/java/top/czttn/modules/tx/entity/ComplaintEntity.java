package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

/**
 * 投诉管理
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_complaint")
public class ComplaintEntity implements Serializable {
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
     * 投诉客户
     */
    private Long clientId;
    @TableField(exist = false)
    private String clientName;
    /**
     * 投诉类型
     */
    private Long complaintType;

    @TableField(exist = false)
    private String complaintTypeName;
    /**
     * 投诉描述
     */
    private String complaintDesc;
    /**
     * 投诉照片json
     */
    private String complaintPic;
    /**
     * 受理状态
     */
    private String status;
    /**
     * 受理意见
     */
    private String opinion;

    public String getComplaintTypeName() {
        return complaintTypeName;
    }

    public void setComplaintTypeName(String complaintTypeName) {
        this.complaintTypeName = complaintTypeName;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
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
     * 设置：投诉客户
     */
    public void setClientId(Long clientId) {
        this.clientId = clientId;
    }

    /**
     * 获取：投诉客户
     */
    public Long getClientId() {
        return clientId;
    }

    public Long getComplaintType() {
        return complaintType;
    }

    public void setComplaintType(Long complaintType) {
        this.complaintType = complaintType;
    }

    /**
     * 设置：投诉描述
     */
    public void setComplaintDesc(String complaintDesc) {
        this.complaintDesc = complaintDesc;
    }

    /**
     * 获取：投诉描述
     */
    public String getComplaintDesc() {
        return complaintDesc;
    }

    /**
     * 设置：投诉照片json
     */
    public void setComplaintPic(String complaintPic) {
        this.complaintPic = complaintPic;
    }

    /**
     * 获取：投诉照片json
     */
    public String getComplaintPic() {
        return complaintPic;
    }

    /**
     * 设置：受理状态
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * 获取：受理状态
     */
    public String getStatus() {
        return status;
    }

    /**
     * 设置：受理意见
     */
    public void setOpinion(String opinion) {
        this.opinion = opinion;
    }

    /**
     * 获取：受理意见
     */
    public String getOpinion() {
        return opinion;
    }
}
