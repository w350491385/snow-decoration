package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.modules.tx.entity.PredictProjectEntity;

import java.util.List;
import java.util.Map;

/**
 * 空间工程预算
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
public interface PredictProjectService extends IService<PredictProjectEntity> {
    /**
     * 查询预算施工项列表
     * @param params
     * @param cpId
     * @return
     */
    List<PredictProjectEntity> findList(Map<String, Object> params, Long cpId);

    /**
     *
     * @param id
     * @return
     */
    PredictProjectEntity ifExit(Long id);

    /**
     *
     * @param roomIds
     * @return
     */
    List<PredictProjectEntity> findByRoomIds(String roomIds);

    /**
     *
     * @param roomIds
     */
    void deleteByRoomIds(String roomIds);
}

