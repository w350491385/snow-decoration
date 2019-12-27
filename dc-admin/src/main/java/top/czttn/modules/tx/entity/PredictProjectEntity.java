package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * 空间工程预算
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@TableName("tx_predict_project")
public class PredictProjectEntity implements Serializable {
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
     *
     */
    private Long roomId;

    @TableField(exist = false)
    private String roomName;
    /**
     *
     */
    private Long projectId;

    @TableField(exist = false)
    private List<ProjectEntity> projectList;
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
    /** 数量 */
    private BigDecimal amount;
    /**
     * 综合单价
     */
    @TableField(exist = false)
    private BigDecimal totalPrice;
    /** 销售总价 */
    @TableField(exist = false)
    private BigDecimal salePrice;

    /** 备注  主材及辅料规格,品牌和工艺 */
    @TableField(exist = false)
    private String remark;


    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(BigDecimal salePrice) {
        this.salePrice = salePrice;
    }

    public Long getWorkType() {
        return workType;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
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

    public void setWorkType(Long workType) {
        this.workType = workType;
    }

    public String getWorkTypeName() {
        return workTypeName;
    }

    public void setWorkTypeName(String workTypeName) {
        this.workTypeName = workTypeName;
    }

    /**
     * 设置：
     */
    public void setRoomId(Long roomId) {
        this.roomId = roomId;
    }

    /**
     * 获取：
     */
    public Long getRoomId() {
        return roomId;
    }

    /**
     * 设置：
     */
    public void setProjectId(Long projectId) {
        this.projectId = projectId;
    }

    /**
     * 获取：
     */
    public Long getProjectId() {
        return projectId;
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

    public List<ProjectEntity> getProjectList() {
        return projectList;
    }

    public void setProjectList(List<ProjectEntity> projectList) {
        this.projectList = projectList;
    }
}
