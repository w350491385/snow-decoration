package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 预算模板
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@TableName("tx_predict_template")
public class PredictTemplateEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long cpId;

    @TableId
    private Long id;

    private String name;

    private Long templateType;
    /** 关联客户 */
    private Long clientId;
    @TableField(exist = false)
    private String clientName;
    /** 所属用户id */
    private Long belongId;

    private Date createTime;

    @TableField(exist = false)
    private String templateTypeName;
    /** 空间集合 */
    @TableField(exist = false)
    private String rooms;
    /** 总成本 */
    @TableField(exist = false)
    private BigDecimal totalCost;
    /** 销售总价 */
    @TableField(exist = false)
    private BigDecimal salePrice;
    /** 总利润 */
    @TableField(exist = false)
    private BigDecimal profit;


    /*-----------------导出使用start-----------------*/
    /** 公司名称 */
    @TableField(exist = false)
    private String cpName;
    /** 工程地点 */
    @TableField(exist = false)
    private String proAddress;
    /** 公司地址 */
    @TableField(exist = false)
    private String cpAddress;
    /** 装修热线 */
    @TableField(exist = false)
    private String phone;
    /** 空间 */
    @TableField(exist = false)
    private List<PredictRoomEntity> roomList;
    @TableField(exist = false)
    private String roomIds;
    /*-----------------导出使用end-----------------*/


    public String getRoomIds() {
        return roomIds;
    }

    public void setRoomIds(String roomIds) {
        this.roomIds = roomIds;
    }

    public List<PredictRoomEntity> getRoomList() {
        return roomList;
    }

    public void setRoomList(List<PredictRoomEntity> roomList) {
        this.roomList = roomList;
    }

    public String getCpName() {
        return cpName;
    }

    public void setCpName(String cpName) {
        this.cpName = cpName;
    }

    public String getProAddress() {
        return proAddress;
    }

    public void setProAddress(String proAddress) {
        this.proAddress = proAddress;
    }

    public String getCpAddress() {
        return cpAddress;
    }

    public void setCpAddress(String cpAddress) {
        this.cpAddress = cpAddress;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public BigDecimal getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(BigDecimal totalCost) {
        this.totalCost = totalCost;
    }

    public BigDecimal getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(BigDecimal salePrice) {
        this.salePrice = salePrice;
    }

    public BigDecimal getProfit() {
        return profit;
    }

    public void setProfit(BigDecimal profit) {
        this.profit = profit;
    }

    public Long getClientId() {
        return clientId;
    }

    public void setClientId(Long clientId) {
        this.clientId = clientId;
    }

    public Long getBelongId() {
        return belongId;
    }

    public void setBelongId(Long belongId) {
        this.belongId = belongId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /** 设置 */
    public void setId(Long id) {
        this.id = id;
    }

    /** 获取 */
    public Long getId() {
        return id;
    }

    public Long getCpId() {
        return cpId;
    }

    public void setCpId(Long cpId) {
        this.cpId = cpId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public Long getTemplateType() {
        return templateType;
    }

    public void setTemplateType(Long templateType) {
        this.templateType = templateType;
    }

    public String getTemplateTypeName() {
        return templateTypeName;
    }

    public void setTemplateTypeName(String templateTypeName) {
        this.templateTypeName = templateTypeName;
    }

    public String getRooms() {
        return rooms;
    }

    public void setRooms(String rooms) {
        this.rooms = rooms;
    }
}
