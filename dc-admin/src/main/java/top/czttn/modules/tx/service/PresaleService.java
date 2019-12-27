package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.PresaleEntity;

import java.util.Map;

/**
 * 售前阶段
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
public interface PresaleService extends IService<PresaleEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);
}

