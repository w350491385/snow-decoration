package top.czttn.modules.sys.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-07-08 10:53:36
 */
@TableName("sys_version")
public class VersionEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private Long id;
	/**
	 * 版本号
	 */
	private String version;
	/**
	 * 更新时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date updateTime;
	/**
	 * 更新描述
	 */
	private String description;
	/**
	 * win32更新包
	 */
	private String win32Href;
	/**
	 * win64更新包
	 */
	private String win64Href;
	/**
	 * mac更新包
	 */
	private String macHref;

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
	 * 设置：版本号
	 */
	public void setVersion(String version) {
		this.version = version;
	}
	/**
	 * 获取：版本号
	 */
	public String getVersion() {
		return version;
	}
	/**
	 * 设置：更新时间
	 */
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	/**
	 * 获取：更新时间
	 */
	public Date getUpdateTime() {
		return updateTime;
	}
	/**
	 * 设置：更新描述
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * 获取：更新描述
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * 设置：win32更新包
	 */
	public void setWin32Href(String win32Href) {
		this.win32Href = win32Href;
	}
	/**
	 * 获取：win32更新包
	 */
	public String getWin32Href() {
		return win32Href;
	}
	/**
	 * 设置：win64更新包
	 */
	public void setWin64Href(String win64Href) {
		this.win64Href = win64Href;
	}
	/**
	 * 获取：win64更新包
	 */
	public String getWin64Href() {
		return win64Href;
	}
	/**
	 * 设置：mac更新包
	 */
	public void setMacHref(String macHref) {
		this.macHref = macHref;
	}
	/**
	 * 获取：mac更新包
	 */
	public String getMacHref() {
		return macHref;
	}
}
