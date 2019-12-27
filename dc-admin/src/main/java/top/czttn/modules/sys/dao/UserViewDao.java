package top.czttn.modules.sys.dao;

import top.czttn.modules.sys.entity.UserViewEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 个人视野
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-26 22:09:11
 */
@Mapper
public interface UserViewDao extends BaseMapper<UserViewEntity> {

    List<Long> findPersonViewIdList(@Param("userId") Long userId);

    /**
     *
     * @param userId
     */
    void deleteByUser(@Param("userId") Long userId);
}
