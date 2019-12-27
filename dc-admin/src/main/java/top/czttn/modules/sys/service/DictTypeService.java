package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.sys.entity.DictTypeEntity;

import java.util.Map;

/**
 * 字典类型
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-09 23:41:45
 */
public interface DictTypeService extends IService<DictTypeEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 查询分类是否已存在
     * @param dictType
     * @return
     */
    DictTypeEntity ifExit(DictTypeEntity dictType);
}

