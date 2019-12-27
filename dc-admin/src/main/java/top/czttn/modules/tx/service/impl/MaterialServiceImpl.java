package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.dao.MaterialDao;
import top.czttn.modules.tx.entity.MaterialEntity;
import top.czttn.modules.tx.service.MaterialService;
import top.czttn.modules.tx.service.PredictMaterialService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * @author czj
 */
@Service("materialService")
public class MaterialServiceImpl extends ServiceImpl<MaterialDao, MaterialEntity> implements MaterialService {

    @Resource
    private PredictMaterialService predictMaterialService;

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        PageUtils.gennerParam(params);
        List<MaterialEntity> list = this.baseMapper.findPageList(params,cpId);
        int total = this.baseMapper.findPageCount(params,cpId);
        return new PageUtils(list, total, params);
    }

    /**
     * @param params
     * @param cpId
     * @return
     */
    @Override
    public PageUtils fiterByPredictRoom(Map<String, Object> params, Long cpId) {
        PageUtils.gennerParam(params);
        List<Long> proIds = predictMaterialService.findIdByRoom(Long.valueOf(params.get("roomId").toString()),cpId);
        String filterId = null;
        if (null != proIds && proIds.size() > 0) {
            StringBuilder filterIdbuid = new StringBuilder();
            for (Long id : proIds) {
                filterIdbuid.append(",").append(id);
            }
            filterId = filterIdbuid.substring(1);
        }
        params.put("filterId", filterId);
        List<MaterialEntity> list = this.baseMapper.findPageList(params, cpId);
        int count = this.baseMapper.findPageCount(params, cpId);
        return new PageUtils(list, count, params);
    }

}
