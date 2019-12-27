package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.PredictMaterialEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 空间主材预算
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@Mapper
public interface PredictMaterialDao extends BaseMapper<PredictMaterialEntity> {
    /**
     *
     * @param params
     * @param cpId
     * @return
     */
    List<PredictMaterialEntity> findList(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId);

    /**
     *
     * @param roomId
     * @param cpId
     * @return
     */
    List<Long> findByRoom(@Param("roomId") Long roomId, @Param("cpId") Long cpId);

    /**
     *
     * @param roomIds
     * @return
     */
    List<PredictMaterialEntity> findByRoomIds(@Param("roomIds") String roomIds);

    /**
     *
     * @param roomIds
     */
    void deleteByRoomIds(@Param("roomIds") String roomIds);
}
