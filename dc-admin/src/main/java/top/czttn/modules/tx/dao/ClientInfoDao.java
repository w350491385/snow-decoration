package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.ClientInfoEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 客户记录
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface ClientInfoDao extends BaseMapper<ClientInfoEntity> {
    /**
     * 分页列表
     * @param params
     * @param cpId
     * @param userId
     * @return
     */
    List<ClientInfoEntity> findPageList(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId, @Param("userId") Long userId);

    /**
     * 分页数量
     * @param params
     * @param cpId
     * @param userId
     * @return
     */
    int findPageTotal(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId, @Param("userId") Long userId);
}
