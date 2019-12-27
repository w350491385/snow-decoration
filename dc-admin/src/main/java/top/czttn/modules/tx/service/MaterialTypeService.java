package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.MaterialTypeEntity;

import java.util.List;
import java.util.Map;

/**
 * 材料分类
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
public interface MaterialTypeService extends IService<MaterialTypeEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 查询所有列表
     * @return
     * @param cpId
     */
    List<MaterialTypeEntity> findAll(Long cpId);

    /**
     * 查询所有分类
     * @return
     */
    Map<String,String> findMapAll(Long cpId);
}

