package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.ConstructionLogEntity;

import java.util.Map;

/**
 * 施工日志
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
public interface ConstructionLogService extends IService<ConstructionLogEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);
}

