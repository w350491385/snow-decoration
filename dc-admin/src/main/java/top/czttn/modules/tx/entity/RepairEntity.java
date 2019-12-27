package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.math.BigDecimal;
import java.io.Serializable;
import java.util.Date;

/**
 * 报修管理
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_repair")
public class RepairEntity implements Serializable {
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
	 * 报修客户
	 */
	private Long clientId;
	/**
	 * 保修类型
	 */
	private String repairType;
	/**
	 * 报修描述
	 */
	private String repairDesc;
	/**
	 * 报修照片json
	 */
	private String repairPic;
	/**
	 * 修理人
	 */
	private String repairMan;
	/**
	 * 修理人联系电话
	 */
	private String repairPhone;
	/**
	 * 分配描述
	 */
	private String distributeDesc;
	/**
	 * 报修来源
	 */
	private String repairSource;
	/**
	 * 核价
	 */
	private BigDecimal amount;
	/**
	 * 状态
	 */
	private Integer status;
	/**
	 * 反馈时间
	 */
	private Date feedbackTime;
	/**
	 * 发起时间
	 */
	private Date launchTime;

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
	 * 设置：报修客户
	 */
	public void setClientId(Long clientId) {
		this.clientId = clientId;
	}
	/**
	 * 获取：报修客户
	 */
	public Long getClientId() {
		return clientId;
	}
	/**
	 * 设置：保修类型
	 */
	public void setRepairType(String repairType) {
		this.repairType = repairType;
	}
	/**
	 * 获取：保修类型
	 */
	public String getRepairType() {
		return repairType;
	}
	/**
	 * 设置：报修描述
	 */
	public void setRepairDesc(String repairDesc) {
		this.repairDesc = repairDesc;
	}
	/**
	 * 获取：报修描述
	 */
	public String getRepairDesc() {
		return repairDesc;
	}
	/**
	 * 设置：报修照片json
	 */
	public void setRepairPic(String repairPic) {
		this.repairPic = repairPic;
	}
	/**
	 * 获取：报修照片json
	 */
	public String getRepairPic() {
		return repairPic;
	}

	public String getRepairMan() {
		return repairMan;
	}

	public void setRepairMan(String repairMan) {
		this.repairMan = repairMan;
	}

	/**
	 * 设置：修理人联系电话
	 */
	public void setRepairPhone(String repairPhone) {
		this.repairPhone = repairPhone;
	}
	/**
	 * 获取：修理人联系电话
	 */
	public String getRepairPhone() {
		return repairPhone;
	}
	/**
	 * 设置：分配描述
	 */
	public void setDistributeDesc(String distributeDesc) {
		this.distributeDesc = distributeDesc;
	}
	/**
	 * 获取：分配描述
	 */
	public String getDistributeDesc() {
		return distributeDesc;
	}
	/**
	 * 设置：报修来源
	 */
	public void setRepairSource(String repairSource) {
		this.repairSource = repairSource;
	}
	/**
	 * 获取：报修来源
	 */
	public String getRepairSource() {
		return repairSource;
	}
	/**
	 * 设置：核价
	 */
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	/**
	 * 获取：核价
	 */
	public BigDecimal getAmount() {
		return amount;
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
	 * 设置：反馈时间
	 */
	public void setFeedbackTime(Date feedbackTime) {
		this.feedbackTime = feedbackTime;
	}
	/**
	 * 获取：反馈时间
	 */
	public Date getFeedbackTime() {
		return feedbackTime;
	}
	/**
	 * 设置：发起时间
	 */
	public void setLaunchTime(Date launchTime) {
		this.launchTime = launchTime;
	}
	/**
	 * 获取：发起时间
	 */
	public Date getLaunchTime() {
		return launchTime;
	}
}
