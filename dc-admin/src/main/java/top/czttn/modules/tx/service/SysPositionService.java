package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.SysPositionEntity;

import java.util.List;
import java.util.Map;

/**
 * 公司职位
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:52:30
 */
public interface SysPositionService extends IService<SysPositionEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);

    List<SysPositionEntity> findCommonList();

    List<String> findNameByUser(Long userId);
}

