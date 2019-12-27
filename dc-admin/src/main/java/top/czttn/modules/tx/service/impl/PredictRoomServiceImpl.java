package top.czttn.modules.tx.service.impl;

import top.czttn.modules.tx.service.PredictMaterialService;
import top.czttn.modules.tx.service.PredictProjectService;
import org.springframework.stereotype.Service;

import java.util.Map;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;

import top.czttn.modules.tx.dao.PredictRoomDao;
import top.czttn.modules.tx.entity.PredictRoomEntity;
import top.czttn.modules.tx.service.PredictRoomService;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;


@Service("predictRoomService")
public class PredictRoomServiceImpl extends ServiceImpl<PredictRoomDao, PredictRoomEntity> implements PredictRoomService {

    @Resource
    private PredictMaterialService predictMaterialService;
    @Resource
    private PredictProjectService predictProjectService;

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        Page<PredictRoomEntity> page = this.selectPage(
                new Query<PredictRoomEntity>(params).getPage(),
                new EntityWrapper<PredictRoomEntity>()
                        .eq("cp_id", cpId)
        );

        return new PageUtils(page);
    }

    /**
     * @param id
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteOne(Long id) {
        predictMaterialService.deleteByRoomIds(id.toString());
        predictProjectService.deleteByRoomIds(id.toString());
        this.baseMapper.deleteById(id);
    }
}
