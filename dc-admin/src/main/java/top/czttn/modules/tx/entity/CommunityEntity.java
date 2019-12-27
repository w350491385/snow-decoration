package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * 小区维护
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_community")
public class CommunityEntity implements Serializable {
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
	 * 小区行政编码
	 */
	private String regionCode;
	/**
	 * 小区名称
	 */
	private String name;
	/**
	 * 经度
	 */
	private Float lgt;
	/**
	 * 维度
	 */
	private Float lat;

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
	 * 设置：小区行政编码
	 */
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	/**
	 * 获取：小区行政编码
	 */
	public String getRegionCode() {
		return regionCode;
	}
	/**
	 * 设置：小区名称
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * 获取：小区名称
	 */
	public String getName() {
		return name;
	}
	/**
	 * 设置：经度
	 */
	public void setLgt(Float lgt) {
		this.lgt = lgt;
	}
	/**
	 * 获取：经度
	 */
	public Float getLgt() {
		return lgt;
	}
	/**
	 * 设置：维度
	 */
	public void setLat(Float lat) {
		this.lat = lat;
	}
	/**
	 * 获取：维度
	 */
	public Float getLat() {
		return lat;
	}
}
