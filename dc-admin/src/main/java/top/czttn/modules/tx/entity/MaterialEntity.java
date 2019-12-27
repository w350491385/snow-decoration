package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 材料列表
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_material")
public class MaterialEntity implements Serializable {
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

    @TableField(exist = false)
    private String typeName;
    /**
     * 名称
     */
    private String name;
    /**
     * 图片
     */
    private String pictureJson;
    /**
     * 品牌
     */
    private Long brand;

    @TableField(exist = false)
    private String brandName;
    /**
     * 型号
     */
    private String model;
    /**
     * 房间区域
     */
    private Long roomArea;
    @TableField(exist = false)
    private String roomAreaName;
    /**
     * 产地
     */
    private String origin;
    /**
     * 标准单位
     */
    private String unit;
    /**
     * 采购价
     */
    private BigDecimal pricePurchase;
    /**
     * 销售价
     */
    private BigDecimal priceSalse;
    /**
     * 承包价
     */
    private BigDecimal priceContract;
    /**
     * 特项编码
     */
    private String superCode;
    /**
     * 其他编码
     */
    private String otherCode;
    /**
     * 采购转换单位
     */
    private String purchaseUnit;
    /**
     * 采购转换系数
     */
    private BigDecimal purchaseCeo;
    /**
     * 销售转换单位
     */
    private String salseUnit;
    /**
     * 销售转换系数
     */
    private BigDecimal salseCeo;
    /**
     * 是否启用
     */
    private Boolean ifOn;
    /**
     * 备注
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
     * 设置：名称
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取：名称
     */
    public String getName() {
        return name;
    }

    /**
     * 设置：图片
     */
    public void setPictureJson(String pictureJson) {
        this.pictureJson = pictureJson;
    }

    /**
     * 获取：图片
     */
    public String getPictureJson() {
        return pictureJson;
    }

    /**
     * 设置：型号
     */
    public void setModel(String model) {
        this.model = model;
    }

    /**
     * 获取：型号
     */
    public String getModel() {
        return model;
    }

    public Long getBrand() {
        return brand;
    }

    public void setBrand(Long brand) {
        this.brand = brand;
    }

    public Long getRoomArea() {
        return roomArea;
    }

    public void setRoomArea(Long roomArea) {
        this.roomArea = roomArea;
    }

    /**
     * 设置：产地
     */
    public void setOrigin(String origin) {
        this.origin = origin;
    }

    /**
     * 获取：产地
     */
    public String getOrigin() {
        return origin;
    }

    /**
     * 设置：标准单位
     */
    public void setUnit(String unit) {
        this.unit = unit;
    }

    /**
     * 获取：标准单位
     */
    public String getUnit() {
        return unit;
    }

    /**
     * 设置：采购价
     */
    public void setPricePurchase(BigDecimal pricePurchase) {
        this.pricePurchase = pricePurchase;
    }

    /**
     * 获取：采购价
     */
    public BigDecimal getPricePurchase() {
        return pricePurchase;
    }

    /**
     * 设置：销售价
     */
    public void setPriceSalse(BigDecimal priceSalse) {
        this.priceSalse = priceSalse;
    }

    /**
     * 获取：销售价
     */
    public BigDecimal getPriceSalse() {
        return priceSalse;
    }

    /**
     * 设置：承包价
     */
    public void setPriceContract(BigDecimal priceContract) {
        this.priceContract = priceContract;
    }

    /**
     * 获取：承包价
     */
    public BigDecimal getPriceContract() {
        return priceContract;
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
     * 设置：其他编码
     */
    public void setOtherCode(String otherCode) {
        this.otherCode = otherCode;
    }

    /**
     * 获取：其他编码
     */
    public String getOtherCode() {
        return otherCode;
    }

    /**
     * 设置：采购转换单位
     */
    public void setPurchaseUnit(String purchaseUnit) {
        this.purchaseUnit = purchaseUnit;
    }

    /**
     * 获取：采购转换单位
     */
    public String getPurchaseUnit() {
        return purchaseUnit;
    }

    /**
     * 设置：采购转换系数
     */
    public void setPurchaseCeo(BigDecimal purchaseCeo) {
        this.purchaseCeo = purchaseCeo;
    }

    /**
     * 获取：采购转换系数
     */
    public BigDecimal getPurchaseCeo() {
        return purchaseCeo;
    }

    /**
     * 设置：销售转换单位
     */
    public void setSalseUnit(String salseUnit) {
        this.salseUnit = salseUnit;
    }

    /**
     * 获取：销售转换单位
     */
    public String getSalseUnit() {
        return salseUnit;
    }

    /**
     * 设置：销售转换系数
     */
    public void setSalseCeo(BigDecimal salseCeo) {
        this.salseCeo = salseCeo;
    }

    /**
     * 获取：销售转换系数
     */
    public BigDecimal getSalseCeo() {
        return salseCeo;
    }

    public Boolean getIfOn() {
        return ifOn;
    }

    public void setIfOn(Boolean ifOn) {
        this.ifOn = ifOn;
    }

    /**
     * 设置：备注
     */
    public void setRemark(String remark) {
        this.remark = remark;
    }

    /**
     * 获取：备注
     */
    public String getRemark() {
        return remark;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getRoomAreaName() {
        return roomAreaName;
    }

    public void setRoomAreaName(String roomAreaName) {
        this.roomAreaName = roomAreaName;
    }
}
