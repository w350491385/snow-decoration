package top.czttn.modules.tx.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import top.czttn.modules.tx.entity.ClientPreEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 我的客户
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface ClientPreDao extends BaseMapper<ClientPreEntity> {
    /**
     *
     * @param params
     * @param cpId
     * @param userId
     * @return
     */
    List<ClientPreEntity> findPageList(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId, @Param("userId") Long userId);

    /**
     *
     * @param params
     * @param cpId
     * @param userId
     * @return
     */
    int findPageTotal(Map<String, Object> params, @Param("cpId") Long cpId, @Param("userId") Long userId);
}
