package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.ProjectTypeEntity;

import java.util.List;
import java.util.Map;

/**
 * 工程分类
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
public interface ProjectTypeService extends IService<ProjectTypeEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     *
     * @param params
     * @param cpId
     * @return
     */
    List<ProjectTypeEntity> findChooseList(Map<String, Object> params, Long cpId);
}

