package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.PredictProjectEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 空间工程预算
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@Mapper
public interface PredictProjectDao extends BaseMapper<PredictProjectEntity> {
    /**
     * 根据预算模板空间查询  空间工程预算表已存在 工程id记录
     * @param roomId
     * @param cpId
     * @return
     */
    List<Long> findIdByRoom(@Param("roomId") Long roomId, @Param("cpId") Long cpId);

    /**
     *
     * @param params
     * @param cpId
     * @return
     */
    List<PredictProjectEntity> findList(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId);

    /**
     *
     * @param roomId
     * @return
     */
    PredictProjectEntity ifExit(@Param("roomId") Long roomId);

    /**
     *
     * @param roomIds
     * @return
     */
    List<PredictProjectEntity> findByRoomIds(@Param("roomIds") String roomIds);

    /**
     *
     * @param roomIds
     */
    void deleteByRoomIds(@Param("roomIds") String roomIds);
}
