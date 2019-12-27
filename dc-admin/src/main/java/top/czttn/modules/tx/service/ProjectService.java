package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.ProjectEntity;

import java.util.Map;

/**
 * 工程列表
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
public interface ProjectService extends IService<ProjectEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);

    /**
     * 根据预算模板空间id过滤出未选的项目集合
     * @param params
     * @param cpId
     * @return
     */
    PageUtils fiterByPredictRoom(Map<String, Object> params, Long cpId);
}

