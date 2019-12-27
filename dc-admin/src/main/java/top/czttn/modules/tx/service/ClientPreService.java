package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.ClientPreEntity;

import java.util.Map;

/**
 * 我的客户
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
public interface ClientPreService extends IService<ClientPreEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId, Long userId);
}

