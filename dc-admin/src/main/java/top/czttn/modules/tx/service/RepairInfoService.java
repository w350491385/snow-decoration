package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.RepairInfoEntity;

import java.util.Map;

/**
 * 报修管理消息记录
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
public interface RepairInfoService extends IService<RepairInfoEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);
}

