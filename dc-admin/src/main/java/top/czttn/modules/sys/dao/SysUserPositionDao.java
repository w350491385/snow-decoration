package top.czttn.modules.sys.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import top.czttn.modules.tx.entity.SysUserPositionEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户与角色对应关系
 *
 * @author czj
 * @email 493804781@qq.com
 * @date 2016年9月18日 上午9:34:46
 */
@Mapper
public interface SysUserPositionDao extends BaseMapper<SysUserPositionEntity> {
    /**
     * 查询用户的所有岗位
     *
     * @param userId
     * @return
     */
    List<Long> queryPositionIdList(@Param("userId") Long userId);

    /**
     *
     * @param userId
     */
    void deleteByUser(@Param("userId") Long userId);
}
