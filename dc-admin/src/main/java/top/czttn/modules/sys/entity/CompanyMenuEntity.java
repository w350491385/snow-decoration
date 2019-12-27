package top.czttn.modules.sys.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 企业菜单权限
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-02-27 23:19:01
 */
@TableName("sys_company_menu")
public class CompanyMenuEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private Long id;
	/**
	 * 企业id
	 */
	private Long cpId;
	/**
	 * 菜单id
	 */
	private Long menuId;

	/**
	 * 设置：
	 */
	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * 获取：
	 */
	public Long getId() {
		return id;
	}
	/**
	 * 设置：企业id
	 */
	public void setCpId(Long cpId) {
		this.cpId = cpId;
	}
	/**
	 * 获取：企业id
	 */
	public Long getCpId() {
		return cpId;
	}
	/**
	 * 设置：菜单id
	 */
	public void setMenuId(Long menuId) {
		this.menuId = menuId;
	}
	/**
	 * 获取：菜单id
	 */
	public Long getMenuId() {
		return menuId;
	}
}
