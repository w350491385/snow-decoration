package top.czttn.modules.tx.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.entity.PredictTemplateEntity;

import java.util.Map;

/**
 * 预算模板
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
public interface PredictTemplateService extends IService<PredictTemplateEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId);

    /**
     * 导出模板
     * @param ids
     * @return
     */
    PredictTemplateEntity export(Long ids);

    /**
     * 克隆
     * @param id
     */
    void cloneOne(Long id);

    /**
     * 删除报价表一整套
     * @param id
     */
    void deleteOne(Long id);
}

