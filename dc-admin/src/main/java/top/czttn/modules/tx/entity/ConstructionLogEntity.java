package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 施工日志
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_construction_log")
public class ConstructionLogEntity implements Serializable {
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
	 * 发生时间
	 */
	private Date createTime;
	/**
	 * 操作人
	 */
	private Long operateMan;
	/**
	 * 关联客户
	 */
	private Long linkedClient;
	@TableField(exist = false)
	private String clientName;
	/**
	 * 施工状态
	 */
	private Integer status;
	/**
	 * 描述
	 */
	private String description;
	/**
	 * 照片json
	 */
	private String picture;
	/**
	 * 动作
	 */
	private String action;

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

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	/**
	 * 设置：发生时间
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	/**
	 * 获取：发生时间
	 */
	public Date getCreateTime() {
		return createTime;
	}
	/**
	 * 设置：操作人
	 */
	public void setOperateMan(Long operateMan) {
		this.operateMan = operateMan;
	}
	/**
	 * 获取：操作人
	 */
	public Long getOperateMan() {
		return operateMan;
	}
	/**
	 * 设置：关联客户
	 */
	public void setLinkedClient(Long linkedClient) {
		this.linkedClient = linkedClient;
	}
	/**
	 * 获取：关联客户
	 */
	public Long getLinkedClient() {
		return linkedClient;
	}
	/**
	 * 设置：施工状态
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}
	/**
	 * 获取：施工状态
	 */
	public Integer getStatus() {
		return status;
	}
	/**
	 * 设置：描述
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * 获取：描述
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * 设置：照片json
	 */
	public void setPicture(String picture) {
		this.picture = picture;
	}
	/**
	 * 获取：照片json
	 */
	public String getPicture() {
		return picture;
	}
	/**
	 * 设置：动作
	 */
	public void setAction(String action) {
		this.action = action;
	}
	/**
	 * 获取：动作
	 */
	public String getAction() {
		return action;
	}
}
