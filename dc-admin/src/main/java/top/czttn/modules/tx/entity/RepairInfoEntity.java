package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 报修管理消息记录
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_repair_info")
public class RepairInfoEntity implements Serializable {
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
	 * 报修主表
	 */
	private Long repairId;
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
	 * 设置：报修主表
	 */
	public void setRepairId(Long repairId) {
		this.repairId = repairId;
	}
	/**
	 * 获取：报修主表
	 */
	public Long getRepairId() {
		return repairId;
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
