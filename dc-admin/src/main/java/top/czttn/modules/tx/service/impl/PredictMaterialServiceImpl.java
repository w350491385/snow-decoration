package top.czttn.modules.tx.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.PredictMaterialDao;
import top.czttn.modules.tx.entity.PredictMaterialEntity;
import top.czttn.modules.tx.service.PredictMaterialService;


@Service("predictMaterialService")
public class PredictMaterialServiceImpl extends ServiceImpl<PredictMaterialDao, PredictMaterialEntity> implements PredictMaterialService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<PredictMaterialEntity> page = this.selectPage(
                new Query<PredictMaterialEntity>(params).getPage(),
                new EntityWrapper<PredictMaterialEntity>()
        );

        return new PageUtils(page);
    }

    /**
     * 根据空间id查询列表
     *
     * @param params
     * @param cpId
     * @return
     */
    @Override
    public List<PredictMaterialEntity> findList(Map<String, Object> params, Long cpId) {
        List<PredictMaterialEntity> list = this.baseMapper.findList(params, cpId);
        if (null != list && list.size() > 0) {
            for (PredictMaterialEntity entity : list) {
                // 计算销售总价
                BigDecimal multiply = entity.getTotalPrice().multiply(entity.getAmount()).setScale(2,   BigDecimal.ROUND_HALF_UP);
                entity.setSalePrice(multiply);
            }
        }
        return list;
    }

    /**
     * @param roomId
     * @param cpId
     * @return
     */
    @Override
    public List<Long> findIdByRoom(Long roomId, Long cpId) {
        return this.baseMapper.findByRoom(roomId, cpId);
    }

    /**
     * @param roomIds
     * @return
     */
    @Override
    public List<PredictMaterialEntity> findByRoomIds(String roomIds) {
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
