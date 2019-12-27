package top.czttn.modules.tx.service.impl;

import top.czttn.modules.sys.service.DictService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import top.czttn.modules.tx.dao.PredictProjectDao;
import top.czttn.modules.tx.entity.PredictProjectEntity;
import top.czttn.modules.tx.service.PredictProjectService;

import javax.annotation.Resource;


@Service("predictProjectService")
public class PredictProjectServiceImpl extends ServiceImpl<PredictProjectDao, PredictProjectEntity> implements PredictProjectService {

    @Resource
    private DictService dictService;
    /**
     * 查询预算施工项列表
     *
     * @param params
     * @param cpId
     * @return
     */
    @Override
    public List<PredictProjectEntity> findList(Map<String, Object> params, Long cpId) {
        List<PredictProjectEntity> list = this.baseMapper.findList(params, cpId);
        if (null != list && list.size() > 0) {
            Map<Long, String> mapByType = dictService.findMapByType(1026);
            for (PredictProjectEntity entity : list) {
                entity.setWorkTypeName(mapByType.get(entity.getWorkType()));
                // 计算销售价
                BigDecimal multiply = entity.getTotalPrice().multiply(entity.getAmount()).setScale(2,   BigDecimal.ROUND_HALF_UP);
                entity.setSalePrice(multiply);
            }
        }
        return list;
    }

    /**
     * @param id
     * @return
     */
    @Override
    public PredictProjectEntity ifExit(Long id) {
        return this.baseMapper.ifExit(id);
    }

    /**
     * @param roomIds
     * @return
     */
    @Override
    public List<PredictProjectEntity> findByRoomIds(String roomIds) {
        return this.baseMapper.findByRoomIds(roomIds);
    }

    /**
     * @param roomIds
     */
    @Override
    public void deleteByRoomIds(String roomIds) {
        if (StringUtils.isNotBlank(roomIds)) {
            this.baseMapper.deleteByRoomIds(roomIds);
        }
    }
}
