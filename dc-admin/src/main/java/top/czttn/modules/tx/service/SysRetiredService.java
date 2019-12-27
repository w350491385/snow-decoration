package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.SysRetiredEntity;

import java.util.Map;

/**
 * 离职员工
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:52:30
 */
public interface SysRetiredService extends IService<SysRetiredEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);
}

