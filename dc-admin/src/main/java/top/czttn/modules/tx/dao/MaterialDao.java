package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.MaterialEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 材料列表
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@Mapper
public interface MaterialDao extends BaseMapper<MaterialEntity> {
    /**
     * 分页集合
     * @param params
     * @param cpId
     * @return
     */
    List<MaterialEntity> findPageList(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId);

    /**
     * 分页数量
     * @param params
     * @param cpId
     * @return
     */
    int findPageCount(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId);
}
