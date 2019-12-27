package top.czttn.modules.tx.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 考勤管理
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@TableName("tx_attendance")
public class AttendanceEntity implements Serializable {
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
     * 考勤点名称
     */
    private String name;
    /**
     * 考勤点地址
     */
    private String address;
    /**
     * 误差范围
     */
    private BigDecimal errorRange;
    /**
     * 上班时间
     */
    @JsonFormat(pattern = "HH:mm:ss",timezone="GMT+8")
    private String startTime;
    /**
     * 下班时间
     */
    @JsonFormat(pattern = "HH:mm:ss",timezone="GMT+8")
    private String endTime;
    /**
     * 适用部门
     */
    private String applicable;
    /** 最早打卡时间 */
    private String estartTime;
    /** 最晚打卡时间 */
    private String eendTime;
    /**
     * 考勤点经度
     */
    private Float lgt;
    /**
     * 考勤点维度
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
     * 设置：考勤点名称
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取：考勤点名称
     */
    public String getName() {
        return name;
    }

    /**
     * 设置：考勤点地址
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * 获取：考勤点地址
     */
    public String getAddress() {
        return address;
    }

    /**
     * 设置：误差范围
     */
    public void setErrorRange(BigDecimal errorRange) {
        this.errorRange = errorRange;
    }

    /**
     * 获取：误差范围
     */
    public BigDecimal getErrorRange() {
        return errorRange;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    /**
     * 设置：适用部门
     */
    public void setApplicable(String applicable) {
        this.applicable = applicable;
    }

    /**
     * 获取：适用部门
     */
    public String getApplicable() {
        return applicable;
    }

    /**
     * 设置：考勤点经度
     */
    public void setLgt(Float lgt) {
        this.lgt = lgt;
    }

    /**
     * 获取：考勤点经度
     */
    public Float getLgt() {
        return lgt;
    }

    /**
     * 设置：考勤点维度
     */
    public void setLat(Float lat) {
        this.lat = lat;
    }

    /**
     * 获取：考勤点维度
     */
    public Float getLat() {
        return lat;
    }

    public String getEstartTime() {
        return estartTime;
    }

    public void setEstartTime(String estartTime) {
        this.estartTime = estartTime;
    }

    public String getEendTime() {
        return eendTime;
    }

    public void setEendTime(String eendTime) {
        this.eendTime = eendTime;
    }
}
