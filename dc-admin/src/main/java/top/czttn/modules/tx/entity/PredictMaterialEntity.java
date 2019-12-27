package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * 空间主材预算
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@TableName("tx_predict_material")
public class PredictMaterialEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @TableId
    private Long id;
    /** 材料id */
    private Long materialId;
    /** 材料名称 */
    @TableField(exist = false)
    private String materialName;
    /** 空间id */
    private Long roomId;

    private Long cpId;

    @TableField(exist = false)
    private List<MaterialEntity> materialList;
    /** 数量 */
    private BigDecimal amount;
    /** 销售单价 */
    @TableField(exist = false)
    private BigDecimal totalPrice;
    /** 销售总价 */
    @TableField(exist = false)
    private BigDecimal salePrice;
    /** 计量单位*/
    @TableField(exist = false)
    private String unit;
    /** 品牌 */
    @TableField(exist = false)
    private String brandName;
    /** 型号 */
    @TableField(exist = false)
    private String model;


    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getMaterialId() {
        return materialId;
    }

    public void setMaterialId(Long materialId) {
        this.materialId = materialId;
    }

    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public Long getRoomId() {
        return roomId;
    }

    public void setRoomId(Long roomId) {
        this.roomId = roomId;
    }

    public Long getCpId() {
        return cpId;
    }

    public void setCpId(Long cpId) {
        this.cpId = cpId;
    }

    public List<MaterialEntity> getMaterialList() {
        return materialList;
    }

    public void setMaterialList(List<MaterialEntity> materialList) {
        this.materialList = materialList;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public BigDecimal getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(BigDecimal salePrice) {
        this.salePrice = salePrice;
    }
}
