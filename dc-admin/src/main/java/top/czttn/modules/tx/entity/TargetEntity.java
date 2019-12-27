package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 业绩目标
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_target")
public class TargetEntity implements Serializable {
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
     * 部门
     */
    private Long deptId;
    @TableField(exist = false)
    private String deptName;
    /**
     * 目标年份
     */
    private String year;
    /**
     * 1月合同目标
     */
    private BigDecimal contract1;
    /**
     * 2月合同目标
     */
    private BigDecimal contract2;
    /**
     * 3月合同目标
     */
    private BigDecimal contract3;
    /**
     * 4月合同目标
     */
    private BigDecimal contract4;
    /**
     * 5月合同目标
     */
    private BigDecimal contract5;
    /**
     * 6月合同目标
     */
    private BigDecimal contract6;
    /**
     * 7月合同目标
     */
    private BigDecimal contract7;
    /**
     * 8月合同目标
     */
    private BigDecimal contract8;
    /**
     * 9月合同目标
     */
    private BigDecimal contract9;
    /**
     * 10月合同目标
     */
    private BigDecimal contract10;
    /**
     * 11月合同目标
     */
    private BigDecimal contract11;
    /**
     * 12月合同目标
     */
    private BigDecimal contract12;
    /**
     * 1月收款目标
     */
    private BigDecimal goal1;
    /**
     * 2月收款目标
     */
    private BigDecimal goal2;
    /**
     * 3月收款目标
     */
    private BigDecimal goal3;
    /**
     * 4月收款目标
     */
    private BigDecimal goal4;
    /**
     * 5月收款目标
     */
    private BigDecimal goal5;
    /**
     * 6月收款目标
     */
    private BigDecimal goal6;
    /**
     * 7月收款目标
     */
    private BigDecimal goal7;
    /**
     * 8月收款目标
     */
    private BigDecimal goal8;
    /**
     * 9月收款目标
     */
    private BigDecimal goal9;
    /**
     * 10月收款目标
     */
    private BigDecimal goal10;
    /**
     * 11月收款目标
     */
    private BigDecimal goal11;
    /**
     * 12月收款目标
     */
    private BigDecimal goal12;

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
     * 设置：部门
     */
    public void setDeptId(Long deptId) {
        this.deptId = deptId;
    }

    /**
     * 获取：部门
     */
    public Long getDeptId() {
        return deptId;
    }

    /**
     * 设置：目标年份
     */
    public void setYear(String year) {
        this.year = year;
    }

    /**
     * 获取：目标年份
     */
    public String getYear() {
        return year;
    }

    /**
     * 设置：1月合同目标
     */
    public void setContract1(BigDecimal contract1) {
        this.contract1 = contract1;
    }

    /**
     * 获取：1月合同目标
     */
    public BigDecimal getContract1() {
        return contract1;
    }

    /**
     * 设置：2月合同目标
     */
    public void setContract2(BigDecimal contract2) {
        this.contract2 = contract2;
    }

    /**
     * 获取：2月合同目标
     */
    public BigDecimal getContract2() {
        return contract2;
    }

    /**
     * 设置：3月合同目标
     */
    public void setContract3(BigDecimal contract3) {
        this.contract3 = contract3;
    }

    /**
     * 获取：3月合同目标
     */
    public BigDecimal getContract3() {
        return contract3;
    }

    /**
     * 设置：4月合同目标
     */
    public void setContract4(BigDecimal contract4) {
        this.contract4 = contract4;
    }

    /**
     * 获取：4月合同目标
     */
    public BigDecimal getContract4() {
        return contract4;
    }

    /**
     * 设置：5月合同目标
     */
    public void setContract5(BigDecimal contract5) {
        this.contract5 = contract5;
    }

    /**
     * 获取：5月合同目标
     */
    public BigDecimal getContract5() {
        return contract5;
    }

    /**
     * 设置：6月合同目标
     */
    public void setContract6(BigDecimal contract6) {
        this.contract6 = contract6;
    }

    /**
     * 获取：6月合同目标
     */
    public BigDecimal getContract6() {
        return contract6;
    }

    /**
     * 设置：7月合同目标
     */
    public void setContract7(BigDecimal contract7) {
        this.contract7 = contract7;
    }

    /**
     * 获取：7月合同目标
     */
    public BigDecimal getContract7() {
        return contract7;
    }

    /**
     * 设置：8月合同目标
     */
    public void setContract8(BigDecimal contract8) {
        this.contract8 = contract8;
    }

    /**
     * 获取：8月合同目标
     */
    public BigDecimal getContract8() {
        return contract8;
    }

    /**
     * 设置：9月合同目标
     */
    public void setContract9(BigDecimal contract9) {
        this.contract9 = contract9;
    }

    /**
     * 获取：9月合同目标
     */
    public BigDecimal getContract9() {
        return contract9;
    }

    /**
     * 设置：10月合同目标
     */
    public void setContract10(BigDecimal contract10) {
        this.contract10 = contract10;
    }

    /**
     * 获取：10月合同目标
     */
    public BigDecimal getContract10() {
        return contract10;
    }

    /**
     * 设置：11月合同目标
     */
    public void setContract11(BigDecimal contract11) {
        this.contract11 = contract11;
    }

    /**
     * 获取：11月合同目标
     */
    public BigDecimal getContract11() {
        return contract11;
    }

    /**
     * 设置：12月合同目标
     */
    public void setContract12(BigDecimal contract12) {
        this.contract12 = contract12;
    }

    /**
     * 获取：12月合同目标
     */
    public BigDecimal getContract12() {
        return contract12;
    }

    /**
     * 设置：1月收款目标
     */
    public void setGoal1(BigDecimal goal1) {
        this.goal1 = goal1;
    }

    /**
     * 获取：1月收款目标
     */
    public BigDecimal getGoal1() {
        return goal1;
    }

    /**
     * 设置：2月收款目标
     */
    public void setGoal2(BigDecimal goal2) {
        this.goal2 = goal2;
    }

    /**
     * 获取：2月收款目标
     */
    public BigDecimal getGoal2() {
        return goal2;
    }

    /**
     * 设置：3月收款目标
     */
    public void setGoal3(BigDecimal goal3) {
        this.goal3 = goal3;
    }

    /**
     * 获取：3月收款目标
     */
    public BigDecimal getGoal3() {
        return goal3;
    }

    /**
     * 设置：4月收款目标
     */
    public void setGoal4(BigDecimal goal4) {
        this.goal4 = goal4;
    }

    /**
     * 获取：4月收款目标
     */
    public BigDecimal getGoal4() {
        return goal4;
    }

    /**
     * 设置：5月收款目标
     */
    public void setGoal5(BigDecimal goal5) {
        this.goal5 = goal5;
    }

    /**
     * 获取：5月收款目标
     */
    public BigDecimal getGoal5() {
        return goal5;
    }

    /**
     * 设置：6月收款目标
     */
    public void setGoal6(BigDecimal goal6) {
        this.goal6 = goal6;
    }

    /**
     * 获取：6月收款目标
     */
    public BigDecimal getGoal6() {
        return goal6;
    }

    /**
     * 设置：7月收款目标
     */
    public void setGoal7(BigDecimal goal7) {
        this.goal7 = goal7;
    }

    /**
     * 获取：7月收款目标
     */
    public BigDecimal getGoal7() {
        return goal7;
    }

    /**
     * 设置：8月收款目标
     */
    public void setGoal8(BigDecimal goal8) {
        this.goal8 = goal8;
    }

    /**
     * 获取：8月收款目标
     */
    public BigDecimal getGoal8() {
        return goal8;
    }

    /**
     * 设置：9月收款目标
     */
    public void setGoal9(BigDecimal goal9) {
        this.goal9 = goal9;
    }

    /**
     * 获取：9月收款目标
     */
    public BigDecimal getGoal9() {
        return goal9;
    }

    /**
     * 设置：10月收款目标
     */
    public void setGoal10(BigDecimal goal10) {
        this.goal10 = goal10;
    }

    /**
     * 获取：10月收款目标
     */
    public BigDecimal getGoal10() {
        return goal10;
    }

    /**
     * 设置：11月收款目标
     */
    public void setGoal11(BigDecimal goal11) {
        this.goal11 = goal11;
    }

    /**
     * 获取：11月收款目标
     */
    public BigDecimal getGoal11() {
        return goal11;
    }

    /**
     * 设置：12月收款目标
     */
    public void setGoal12(BigDecimal goal12) {
        this.goal12 = goal12;
    }

    /**
     * 获取：12月收款目标
     */
    public BigDecimal getGoal12() {
        return goal12;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}
