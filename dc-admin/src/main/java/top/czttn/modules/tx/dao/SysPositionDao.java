package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.SysPositionEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 公司职位
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:52:30
 */
@Mapper
public interface SysPositionDao extends BaseMapper<SysPositionEntity> {
    /**
     * 根据用户id查询岗位名称
     * @param userId
     * @return
     */
    List<String> findNameByUser(@Param("userId") Long userId);

    /**
     *
     * @return
     */
    List<SysPositionEntity> findCommonList();
}
