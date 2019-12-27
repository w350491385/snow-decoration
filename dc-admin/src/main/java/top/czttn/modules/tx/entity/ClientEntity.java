package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 我的客户
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_client")
public class ClientEntity implements Serializable {
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

    @TableField(exist = false)
    private String strids;
    @TableField(exist = false)
    private Long[] longids;
    /**
     * 所属人
     */
    private Long belongId;
    /**
     * 客户姓名
     */
    private String clientName;
    /**
     * 客户电话
     */
    private String phone;
    /**
     * 客户编码
     */
    private String clientCode;
    /**
     * 性别
     */
    private String sex;
    /**
     * 地址
     */
    private String address;
    /**
     * 业务类型
     */
    private Long busType;

    @TableField(exist = false)
    private String busTypeName;
    /**
     * 阶段
     */
    private Long busPhase;

    @TableField(exist = false)
    private String busPhaseName;
    /**
     * 户型
     */
    private Long roomType;
    @TableField(exist = false)
    private String roomTypeName;
    /**
     * 房型
     */
    private Long houseType;
    @TableField(exist = false)
    private String houseTypeName;
    /**
     * 创建人
     */
    private String createMan;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 实用面积
     */
    private BigDecimal usefulArea;
    /**
     * 所处状态
     */
    private String status;
    /**
     * 建筑面积
     */
    private BigDecimal buidArea;
    /**
     * 领取时间
     */
    private Date receiveTime;
    /** 领取次数 */
    private Integer receiveCount;
    /**
     * 数据来源
     */
    private Long source;
    @TableField(exist = false)
    private String sourceName;
    /**
     * 客户类型
     */
    private Long clientType;
    @TableField(exist = false)
    private String clientTypeName;
    /**
     * 逃单描述
     */
    private String escape;
    /**
     * 期望签单金额
     */
    private BigDecimal hopeAmount;
    /**
     * 期望签单日期
     */
    private Date hopeTime;
    /**
     * 合同金额
     */
    private BigDecimal contractAmount;
    /**
     * 已收款
     */
    private BigDecimal paidAmount;
    /**
     * 收款百分百
     */
    @TableField(exist = false)
    private BigDecimal paidPercent;
    /**
     * 未跟进天数
     */
    private Integer unfollwedDays;
    /**
     * 小区
     */
    private String community;

    @TableField(exist = false)
    private String communityName;
    /**
     * 栋
     */
    private String roof;
    /**
     * 单位
     */
    private String unit;
    /**
     * 门牌
     */
    private String doorplate;
    /** 预约时间 */
    private Date reserveTime;

    public String getStrids() {
        return strids;
    }

    public void setStrids(String strids) {
        this.strids = strids;
    }

    public Long[] getLongids() {
        return longids;
    }

    public void setLongids(Long[] longids) {
        this.longids = longids;
    }

    public Integer getReceiveCount() {
        return receiveCount;
    }

    public void setReceiveCount(Integer receiveCount) {
        this.receiveCount = receiveCount;
    }

    public Date getReserveTime() {
        return reserveTime;
    }

    public void setReserveTime(Date reserveTime) {
        this.reserveTime = reserveTime;
    }

    public String getBusTypeName() {
        return busTypeName;
    }

    public void setBusTypeName(String busTypeName) {
        this.busTypeName = busTypeName;
    }

    public String getBusPhaseName() {
        return busPhaseName;
    }

    public void setBusPhaseName(String busPhaseName) {
        this.busPhaseName = busPhaseName;
    }

    public String getRoomTypeName() {
        return roomTypeName;
    }

    public void setRoomTypeName(String roomTypeName) {
        this.roomTypeName = roomTypeName;
    }

    public String getHouseTypeName() {
        return houseTypeName;
    }

    public void setHouseTypeName(String houseTypeName) {
        this.houseTypeName = houseTypeName;
    }

    public String getSourceName() {
        return sourceName;
    }

    public void setSourceName(String sourceName) {
        this.sourceName = sourceName;
    }

    public String getClientTypeName() {
        return clientTypeName;
    }

    public void setClientTypeName(String clientTypeName) {
        this.clientTypeName = clientTypeName;
    }

    public String getCommunityName() {
        return communityName;
    }

    public void setCommunityName(String communityName) {
        this.communityName = communityName;
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
     * 设置：所属人
     */
    public void setBelongId(Long belongId) {
        this.belongId = belongId;
    }

    /**
     * 获取：所属人
     */
    public Long getBelongId() {
        return belongId;
    }

    /**
     * 设置：客户姓名
     */
    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    /**
     * 获取：客户姓名
     */
    public String getClientName() {
        return clientName;
    }

    /**
     * 设置：客户电话
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * 获取：客户电话
     */
    public String getPhone() {
        return phone;
    }

    /**
     * 设置：客户编码
     */
    public void setClientCode(String clientCode) {
        this.clientCode = clientCode;
    }

    /**
     * 获取：客户编码
     */
    public String getClientCode() {
        return clientCode;
    }

    /**
     * 设置：性别
     */
    public void setSex(String sex) {
        this.sex = sex;
    }

    /**
     * 获取：性别
     */
    public String getSex() {
        return sex;
    }

    /**
     * 设置：地址
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * 获取：地址
     */
    public String getAddress() {
        return address;
    }

    /**
     * 设置：业务类型
     */
    public void setBusType(Long busType) {
        this.busType = busType;
    }

    /**
     * 获取：业务类型
     */
    public Long getBusType() {
        return busType;
    }

    /**
     * 设置：阶段
     */
    public void setBusPhase(Long busPhase) {
        this.busPhase = busPhase;
    }

    /**
     * 获取：阶段
     */
    public Long getBusPhase() {
        return busPhase;
    }

    /**
     * 设置：户型
     */
    public void setRoomType(Long roomType) {
        this.roomType = roomType;
    }

    /**
     * 获取：户型
     */
    public Long getRoomType() {
        return roomType;
    }

    /**
     * 设置：房型
     */
    public void setHouseType(Long houseType) {
        this.houseType = houseType;
    }

    /**
     * 获取：房型
     */
    public Long getHouseType() {
        return houseType;
    }

    /**
     * 设置：创建人
     */
    public void setCreateMan(String createMan) {
        this.createMan = createMan;
    }

    /**
     * 获取：创建人
     */
    public String getCreateMan() {
        return createMan;
    }

    /**
     * 设置：创建时间
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /**
     * 获取：创建时间
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 设置：实用面积
     */
    public void setUsefulArea(BigDecimal usefulArea) {
        this.usefulArea = usefulArea;
    }

    /**
     * 获取：实用面积
     */
    public BigDecimal getUsefulArea() {
        return usefulArea;
    }

    /**
     * 设置：所处状态
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * 获取：所处状态
     */
    public String getStatus() {
        return status;
    }

    /**
     * 设置：建筑面积
     */
    public void setBuidArea(BigDecimal buidArea) {
        this.buidArea = buidArea;
    }

    /**
     * 获取：建筑面积
     */
    public BigDecimal getBuidArea() {
        return buidArea;
    }

    /**
     * 设置：领取时间
     */
    public void setReceiveTime(Date receiveTime) {
        this.receiveTime = receiveTime;
    }

    /**
     * 获取：领取时间
     */
    public Date getReceiveTime() {
        return receiveTime;
    }

    public Long getSource() {
        return source;
    }

    public void setSource(Long source) {
        this.source = source;
    }

    /**
     * 设置：客户类型
     */
    public void setClientType(Long clientType) {
        this.clientType = clientType;
    }

    /**
     * 获取：客户类型
     */
    public Long getClientType() {
        return clientType;
    }

    /**
     * 设置：逃单描述
     */
    public void setEscape(String escape) {
        this.escape = escape;
    }

    /**
     * 获取：逃单描述
     */
    public String getEscape() {
        return escape;
    }

    /**
     * 设置：期望签单金额
     */
    public void setHopeAmount(BigDecimal hopeAmount) {
        this.hopeAmount = hopeAmount;
    }

    /**
     * 获取：期望签单金额
     */
    public BigDecimal getHopeAmount() {
        return hopeAmount;
    }

    /**
     * 设置：期望签单日期
     */
    public void setHopeTime(Date hopeTime) {
        this.hopeTime = hopeTime;
    }

    /**
     * 获取：期望签单日期
     */
    public Date getHopeTime() {
        return hopeTime;
    }

    /**
     * 设置：合同金额
     */
    public void setContractAmount(BigDecimal contractAmount) {
        this.contractAmount = contractAmount;
    }

    /**
     * 获取：合同金额
     */
    public BigDecimal getContractAmount() {
        return contractAmount;
    }

    /**
     * 设置：已收款
     */
    public void setPaidAmount(BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    /**
     * 获取：已收款
     */
    public BigDecimal getPaidAmount() {
        return paidAmount;
    }

    /**
     * 设置：收款百分百
     */
    public void setPaidPercent(BigDecimal paidPercent) {
        this.paidPercent = paidPercent;
    }

    /**
     * 获取：收款百分百
     */
    public BigDecimal getPaidPercent() {
        return paidPercent;
    }

    /**
     * 设置：未跟进天数
     */
    public void setUnfollwedDays(Integer unfollwedDays) {
        this.unfollwedDays = unfollwedDays;
    }

    /**
     * 获取：未跟进天数
     */
    public Integer getUnfollwedDays() {
        return unfollwedDays;
    }

    /**
     * 设置：小区
     */
    public void setCommunity(String community) {
        this.community = community;
    }

    /**
     * 获取：小区
     */
    public String getCommunity() {
        return community;
    }

    /**
     * 设置：栋
     */
    public void setRoof(String roof) {
        this.roof = roof;
    }

    /**
     * 获取：栋
     */
    public String getRoof() {
        return roof;
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
     * 设置：门牌
     */
    public void setDoorplate(String doorplate) {
        this.doorplate = doorplate;
    }

    /**
     * 获取：门牌
     */
    public String getDoorplate() {
        return doorplate;
    }
}
