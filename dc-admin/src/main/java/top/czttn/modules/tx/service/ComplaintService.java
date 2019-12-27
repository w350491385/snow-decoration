package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.ComplaintEntity;

import java.util.Map;

/**
 * 投诉管理
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
public interface ComplaintService extends IService<ComplaintEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);
}

