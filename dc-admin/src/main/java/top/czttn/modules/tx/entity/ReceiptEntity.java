package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 单据类型维护
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_receipt")
public class ReceiptEntity implements Serializable {
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
	 * 单据类型
	 */
	private String receiptType;
	/**
	 * 单据名称
	 */
	private String name;
	/**
	 * 是否启用
	 */
	private Integer ifOn;
	/**
	 * 物流信息
	 */
	private String logistics;
	/**
	 * 标记状态
	 */
	private Integer status;

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
	 * 设置：单据类型
	 */
	public void setReceiptType(String receiptType) {
		this.receiptType = receiptType;
	}
	/**
	 * 获取：单据类型
	 */
	public String getReceiptType() {
		return receiptType;
	}
	/**
	 * 设置：单据名称
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获取：单据名称
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置：是否启用
	 */
	public void setIfOn(Integer ifOn) {
		this.ifOn = ifOn;
	}
	/**
	 * 获取：是否启用
	 */
	public Integer getIfOn() {
		return ifOn;
	}
	/**
	 * 设置：物流信息
	 */
	public void setLogistics(String logistics) {
		this.logistics = logistics;
	}
	/**
	 * 获取：物流信息
	 */
	public String getLogistics() {
		return logistics;
	}
	/**
	 * 设置：标记状态
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}
	/**
	 * 获取：标记状态
	 */
	public Integer getStatus() {
		return status;
	}
}
