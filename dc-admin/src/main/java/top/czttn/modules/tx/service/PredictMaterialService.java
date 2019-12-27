package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.PredictMaterialEntity;

import java.util.List;
import java.util.Map;

/**
 * 空间主材预算
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
public interface PredictMaterialService extends IService<PredictMaterialEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 根据空间id查询列表
     * @param params
     * @param cpId
     * @return
     */
    List<PredictMaterialEntity> findList(Map<String, Object> params, Long cpId);

    /**
     *
     * @param roomId
     * @param cpId
     * @return
     */
    List<Long> findIdByRoom(Long roomId, Long cpId);

    /**
     *
     * @param roomIds
     * @return
     */
    List<PredictMaterialEntity> findByRoomIds(String roomIds);

    /**
     *
     * @param roomIds
     */
    void deleteByRoomIds(String roomIds);
}

