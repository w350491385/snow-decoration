package top.czttn.modules.sys.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 字典类型
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-09 23:41:45
 */
@TableName("sys_dict_type")
public class DictTypeEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	@TableId
	private Long id;
	/**
	 * name
	 */
	private String name;
	/**
	 * order_num
	 */
	private Integer orderNum;
	/**
	 * remark
	 */
	private String remark;

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
	 * 设置：name
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获取：name
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置：order_num
	 */
	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}
	/**
	 * 获取：order_num
	 */
	public Integer getOrderNum() {
		return orderNum;
	}
	/**
	 * 设置：remark
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/**
	 * 获取：remark
	 */
	public String getRemark() {
		return remark;
	}
}
