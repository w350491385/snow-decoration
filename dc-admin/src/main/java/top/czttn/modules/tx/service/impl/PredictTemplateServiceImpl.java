package top.czttn.modules.tx.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.tx.dao.PredictTemplateDao;
import top.czttn.modules.tx.entity.PredictMaterialEntity;
import top.czttn.modules.tx.entity.PredictProjectEntity;
import top.czttn.modules.tx.entity.PredictRoomEntity;
import top.czttn.modules.tx.entity.PredictTemplateEntity;
import top.czttn.modules.tx.service.PredictMaterialService;
import top.czttn.modules.tx.service.PredictProjectService;
import top.czttn.modules.tx.service.PredictRoomService;
import top.czttn.modules.tx.service.PredictTemplateService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.*;


@Service("predictTemplateService")
public class PredictTemplateServiceImpl extends ServiceImpl<PredictTemplateDao, PredictTemplateEntity> implements PredictTemplateService {

    @Resource
    private PredictRoomService predictRoomService;
    @Resource
    private PredictMaterialService predictMaterialService;
    @Resource
    private PredictProjectService predictProjectService;

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId) {
        PageUtils.gennerParam(params);
        List<PredictTemplateEntity> list = this.baseMapper.findPageList(params, cpId);
        if (null != list && list.size() > 0) {
            for (PredictTemplateEntity entity : list) {
                entity.setProfit(entity.getSalePrice().subtract(entity.getTotalCost()));
            }
        }
        int total = this.baseMapper.findPageTotal(params, cpId);
        return new PageUtils(list, total, params);
    }

    /**
     * 导出模板
     *
     * @param
     * @return
     */
    @Override
    public PredictTemplateEntity export(Long id) {
        PredictTemplateEntity predictTemplateEntity = this.baseMapper.findById(id);
        String roomIds = predictTemplateEntity.getRoomIds();
        if (StringUtils.isNotBlank(roomIds)) {
            // 查询空间
            List<PredictRoomEntity> roomlist = predictRoomService.selectBatchIds(Arrays.asList(roomIds.split(",")));
            // 根据空间ids查询相应预算
            List<PredictMaterialEntity> matlist = predictMaterialService.findByRoomIds(roomIds);
            List<PredictProjectEntity> prolist = predictProjectService.findByRoomIds(roomIds);
            BigDecimal total = new BigDecimal("0");
            for (PredictRoomEntity entity : roomlist) {
                Long thisroomid = entity.getId();
                List<PredictMaterialEntity> list1 = new ArrayList<>();
                BigDecimal subTotalMat = new BigDecimal("0");
                BigDecimal subTotalPro = new BigDecimal("0");
                List<PredictProjectEntity> list2 = new ArrayList<>();
                // 设置材料
                if (matlist != null && matlist.size() > 0) {
                    for (PredictMaterialEntity materialEntity : matlist) {
                        if (materialEntity.getRoomId().equals(thisroomid)) {
                            list1.add(materialEntity);
                            subTotalMat = subTotalMat.add(materialEntity.getSalePrice());
                        }
                    }
                    entity.setMaterialList(list1);
                }
                if (prolist != null && prolist.size() > 0) {
                    // 设置施工项
                    for (PredictProjectEntity projectEntity : prolist) {
                        if (projectEntity.getRoomId().equals(thisroomid)) {
                            list2.add(projectEntity);
                            subTotalPro = subTotalPro.add(projectEntity.getSalePrice());
                        }
                    }
                    entity.setProjectList(list2);
                }
                entity.setSubtotal(subTotalMat.add(subTotalPro));
                total = total.add(entity.getSubtotal());
            }
            predictTemplateEntity.setSalePrice(total);
            predictTemplateEntity.setRoomList(roomlist);
        }
        return predictTemplateEntity;
    }

    /**
     * 克隆
     *
     * @param id
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void cloneOne(Long id) {
        PredictTemplateEntity templateEntity = this.baseMapper.findById(id);
        templateEntity.setCreateTime(new Date());
        templateEntity.setClientId(null);
        String roomIds = templateEntity.getRoomIds();
        templateEntity.setName("[克隆副本]" + templateEntity.getName());
        this.insert(templateEntity);
        if (StringUtils.isNotBlank(roomIds)) {
            // 查询空间
            List<PredictRoomEntity> roomlist = predictRoomService.selectBatchIds(Arrays.asList(roomIds.split(",")));
            if (null != roomlist && roomlist.size() > 0) {
                for (PredictRoomEntity entity : roomlist) {
                    entity.setTemplateId(templateEntity.getId());
                    List<PredictProjectEntity> prolist = predictProjectService.findByRoomIds(entity.getId().toString());
                    List<PredictMaterialEntity> matlist = predictMaterialService.findByRoomIds(entity.getId().toString());
                    predictRoomService.insert(entity);
                    if (prolist != null && prolist.size() > 0) {
                        for (PredictProjectEntity projectEntity : prolist) {
                            projectEntity.setRoomId(entity.getId());
                        }
                        predictProjectService.insertBatch(prolist);
                    }
                    if (matlist != null && matlist.size() > 0) {
                        for (PredictMaterialEntity materialEntity : matlist) {
                            materialEntity.setRoomId(entity.getId());
                        }
                        predictMaterialService.insertBatch(matlist);
                    }
                }
            }
        }
    }

    /**
     * 删除报价表一整套
     *
     * @param id
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteOne(Long id) {
        PredictTemplateEntity templateEntity = this.baseMapper.findById(id);
        String roomIds = templateEntity.getRoomIds();
        if (StringUtils.isNotBlank(roomIds)) {
            predictMaterialService.deleteByRoomIds(roomIds);
            predictProjectService.deleteByRoomIds(roomIds);
            predictRoomService.deleteBatchIds(Arrays.asList(roomIds.split(",")));
        }
        this.baseMapper.deleteById(id);
    }
}
