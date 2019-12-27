package top.czttn.modules.tx.dao;

import top.czttn.modules.tx.entity.PredictTemplateEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 预算模板
 * 
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@Mapper
public interface PredictTemplateDao extends BaseMapper<PredictTemplateEntity> {
    /**
     * 查询分页
     * @param params
     * @param cpId
     * @return
     */
    List<PredictTemplateEntity> findPageList(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId);

    /**
     * 分页数量
     * @param params
     * @param cpId
     * @return
     */
    int findPageTotal(@Param("params") Map<String, Object> params, @Param("cpId") Long cpId);

    /**
     *
     * @param id
     * @return
     */
    PredictTemplateEntity findById(@Param("id") Long id);
}
