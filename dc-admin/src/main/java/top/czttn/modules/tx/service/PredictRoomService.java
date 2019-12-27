package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.PredictRoomEntity;

import java.util.Map;

/**
 * 模板空间
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
public interface PredictRoomService extends IService<PredictRoomEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);

    /**
     *
     * @param id
     */
    void deleteOne(Long id);
}

