package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 投诉消息记录
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_complaint_info")
public class ComplaintInfoEntity implements Serializable {
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
	 * 投诉主表id
	 */
	private Long complaintId;
	/**
	 * 发言人
	 */
	private Long manId;
	/**
	 * 动作行为
	 */
	private String action;
	/**
	 * 内容
	 */
	private String content;
	/**
	 * 时间
	 */
	private Date createTime;

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
	 * 设置：投诉主表id
	 */
	public void setComplaintId(Long complaintId) {
		this.complaintId = complaintId;
	}
	/**
	 * 获取：投诉主表id
	 */
	public Long getComplaintId() {
		return complaintId;
	}
	/**
	 * 设置：发言人
	 */
	public void setManId(Long manId) {
		this.manId = manId;
	}
	/**
	 * 获取：发言人
	 */
	public Long getManId() {
		return manId;
	}
	/**
	 * 设置：动作行为
	 */
	public void setAction(String action) {
		this.action = action;
	}
	/**
	 * 获取：动作行为
	 */
	public String getAction() {
		return action;
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
	 * 设置：时间
	 */
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	/**
	 * 获取：时间
	 */
	public Date getCreateTime() {
		return createTime;
	}
}
