package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.math.BigDecimal;
import java.io.Serializable;
import java.util.Date;

/**
 * 工程列表
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_project")
public class ProjectEntity implements Serializable {
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
	 * 分类id
	 */
	private Long typeId;
	/**
	 * 项目名称
	 */
	private String name;
	/**
	 * 工种
	 */
	private Long workType;
	@TableField(exist = false)
	private String workTypeName;
	/**
	 * 单位
	 */
	private String unit;
	/**
	 * 综合价
	 */
	private BigDecimal totalPrice;
	/**
	 * 特项编码
	 */
	private String superCode;
	/**
	 * 综合成本
	 */
	private BigDecimal totalCost;
	/**
	 * 人工成本
	 */
	private BigDecimal humanCost;
	/**
	 * 辅材成本
	 */
	private BigDecimal helpCost;
	/**
	 * 是否启用
	 */
	private Boolean ifOn;
	/**
	 * 能否改价
	 */
	private Boolean ifEditble;
	/** 备注  主材及辅料规格,品牌和工艺 */
	private String remark;

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getWorkTypeName() {
		return workTypeName;
	}

	public void setWorkTypeName(String workTypeName) {
		this.workTypeName = workTypeName;
	}

	public Long getWorkType() {
		return workType;
	}

	public void setWorkType(Long workType) {
		this.workType = workType;
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
	 * 设置：分类id
	 */
	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}
	/**
	 * 获取：分类id
	 */
	public Long getTypeId() {
		return typeId;
	}
	/**
	 * 设置：项目名称
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获取：项目名称
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置：单位
	 */
	public void setUnit(String unit) {
		this.unit = unit;
	}
	/**
	 * 获取：单位
	 */
	public String getUnit() {
		return unit;
	}
	/**
	 * 设置：综合价
	 */
	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}
	/**
	 * 获取：综合价
	 */
	public BigDecimal getTotalPrice() {
		return totalPrice;
	}
	/**
	 * 设置：特项编码
	 */
	public void setSuperCode(String superCode) {
		this.superCode = superCode;
	}
	/**
	 * 获取：特项编码
	 */
	public String getSuperCode() {
		return superCode;
	}
	/**
	 * 设置：综合成本
	 */
	public void setTotalCost(BigDecimal totalCost) {
		this.totalCost = totalCost;
	}
	/**
	 * 获取：综合成本
	 */
	public BigDecimal getTotalCost() {
		return totalCost;
	}
	/**
	 * 设置：人工成本
	 */
	public void setHumanCost(BigDecimal humanCost) {
		this.humanCost = humanCost;
	}
	/**
	 * 获取：人工成本
	 */
	public BigDecimal getHumanCost() {
		return humanCost;
	}
	/**
	 * 设置：辅材成本
	 */
	public void setHelpCost(BigDecimal helpCost) {
		this.helpCost = helpCost;
	}
	/**
	 * 获取：辅材成本
	 */
	public BigDecimal getHelpCost() {
		return helpCost;
	}

	public Boolean getIfOn() {
		return ifOn;
	}

	public void setIfOn(Boolean ifOn) {
		this.ifOn = ifOn;
	}

	public Boolean getIfEditble() {
		return ifEditble;
	}

	public void setIfEditble(Boolean ifEditble) {
		this.ifEditble = ifEditble;
	}
}
