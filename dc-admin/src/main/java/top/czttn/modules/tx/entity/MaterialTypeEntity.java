package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

/**
 * 材料分类
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_material_type")
public class MaterialTypeEntity implements Serializable {
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
     * 上级分类
     */
    private Long parentId;

    @TableField(exist = false)
    private String parentName;

    /**
     * 分类名称
     */
    private String typeName;
    /**
     * 分类编码
     */
    private String typeCode;


    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
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
     * 设置：上级分类
     */
    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    /**
     * 获取：上级分类
     */
    public Long getParentId() {
        return parentId;
    }

    /**
     * 设置：分类名称
     */
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    /**
     * 获取：分类名称
     */
    public String getTypeName() {
        return typeName;
    }

    /**
     * 设置：分类编码
     */
    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    /**
     * 获取：分类编码
     */
    public String getTypeCode() {
        return typeCode;
    }
}
