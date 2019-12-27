package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.math.BigDecimal;
import java.io.Serializable;
import java.util.Date;

/**
 * 售前阶段
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_presale")
public class PresaleEntity implements Serializable {
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
	 * 阶段名称
	 */
	private String name;
	/**
	 * 阶段状态
	 */
	private Integer status;
	/**
	 * 成单率
	 */
	private BigDecimal percentage;

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
	 * 设置：阶段名称
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获取：阶段名称
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置：阶段状态
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}
	/**
	 * 获取：阶段状态
	 */
	public Integer getStatus() {
		return status;
	}
	/**
	 * 设置：成单率
	 */
	public void setPercentage(BigDecimal percentage) {
		this.percentage = percentage;
	}
	/**
	 * 获取：成单率
	 */
	public BigDecimal getPercentage() {
		return percentage;
	}
}
