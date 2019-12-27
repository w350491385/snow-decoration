package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.ServingTechEntity;

import java.util.List;
import java.util.Map;

/**
 * 客户服务术语
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
public interface ServingTechService extends IService<ServingTechEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);

    /**
     *
     * @return
     */
    List<ServingTechEntity> findCommon();
}

