package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.sys.entity.DictEntity;

import java.util.Map;

/**
 * 字典
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-09 23:41:45
 */
public interface DictService extends IService<DictEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);

    /**
     * 名称和编码查询是否存在
     * @param dict
     * @param cpId
     * @return
     */
    DictEntity ifExit(DictEntity dict, Long cpId);

    /**
     * 根据字典类型查询map
     * @param l
     * @return
     */
    Map<Long,String> findMapByType(long l);
}

