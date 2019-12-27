package top.czttn.modules.sys.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.util.List;

/**
 * 部门
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-09 23:41:45
 */
@TableName("sys_dept")
public class DeptEntity implements Serializable {
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
     * 上级部门
     */
    private Long parentId;
    @TableField(exist = false)
    private String parentName;
    /**
     * 名称
     */
    private String name;
    /**
     * 排序
     */
    private Integer orderNum;

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

    @TableField(exist = false)
    private List<DeptEntity> children;


    public List<DeptEntity> getChildren() {
        return children;
    }

    public void setChildren(List<DeptEntity> children) {
        this.children = children;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
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
     * 设置：排序
     */
    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    /**
     * 获取：排序
     */
    public Integer getOrderNum() {
        return orderNum;
    }
}
