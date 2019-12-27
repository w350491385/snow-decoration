package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * 模板空间
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@TableName("tx_predict_room")
public class PredictRoomEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    @TableId
    private Long id;

    private Long cpId;

    private Long templateId;

    private String name;
    /** 小计 */
    @TableField(exist = false)
    private BigDecimal subtotal;
    /** 施工项 */
    @TableField(exist = false)
    private List<PredictProjectEntity> projectList;
    /** 主材 */
    @TableField(exist = false)
    private List<PredictMaterialEntity> materialList;


    public List<PredictProjectEntity> getProjectList() {
        return projectList;
    }

    public void setProjectList(List<PredictProjectEntity> projectList) {
        this.projectList = projectList;
    }

    public List<PredictMaterialEntity> getMaterialList() {
        return materialList;
    }

    public void setMaterialList(List<PredictMaterialEntity> materialList) {
        this.materialList = materialList;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public Long getCpId() {
        return cpId;
    }

    public void setCpId(Long cpId) {
        this.cpId = cpId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    /**
     * 设置：
     */
    public void setTemplateId(Long templateId) {
        this.templateId = templateId;
    }

    /**
     * 获取：
     */
    public Long getTemplateId() {
        return templateId;
    }

    /**
     * 设置：
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取：
     */
    public String getName() {
        return name;
    }
}
