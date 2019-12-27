package top.czttn.modules.tx.controller;

import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.MaterialEntity;
import top.czttn.modules.tx.entity.PredictMaterialEntity;
import top.czttn.modules.tx.service.MaterialService;
import top.czttn.modules.tx.service.PredictMaterialService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 空间主材预算
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@RestController
@RequestMapping("tx/predictmaterial")
public class PredictMaterialController extends AbstractController {
    @Resource
    private PredictMaterialService predictMaterialService;
    @Resource
    private MaterialService materialService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:predicttemplate:list")
    public R list(@RequestParam Map<String, Object> params) {
        List<PredictMaterialEntity> list = predictMaterialService.findList(params,getCpId());
        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:predicttemplate:info")
    public R info(@PathVariable("id") Long id) {
        PredictMaterialEntity predictMaterial = predictMaterialService.selectById(id);
        if (!predictMaterial.getCpId().equals(getCpId())) {
            return null;
        }
        MaterialEntity select = materialService.selectById(predictMaterial.getMaterialId());
        predictMaterial.setMaterialName(select.getName());
        predictMaterial.setUnit(select.getUnit());
        predictMaterial.setTotalPrice(select.getPriceSalse());
        return R.ok().put("predictmaterial", predictMaterial);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:predicttemplate:save")
    public R save(@RequestBody PredictMaterialEntity predictMaterial) {
        predictMaterial.setCpId(getCpId());
        predictMaterialService.insert(predictMaterial);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:predicttemplate:update")
    public R update(@RequestBody PredictMaterialEntity predictMaterial) {
        PredictMaterialEntity select = predictMaterialService.selectById(predictMaterial.getId());
        if (select.getCpId().equals(getCpId())) {
            predictMaterialService.updateById(predictMaterial);
        }

        return R.ok();
    }

    /**
     * 选择新增/修改
     */
    @RequestMapping("/choose")
    @RequiresPermissions("tx:predicttemplate:save")
    public R choose(@RequestBody PredictMaterialEntity predictMaterial) {
        List<MaterialEntity> list = predictMaterial.getMaterialList();
        Long roomId = predictMaterial.getRoomId();
        if (list != null && list.size() > 0) {
            List<PredictMaterialEntity> saveList = new ArrayList<>();
            for (MaterialEntity entity : list) {
                PredictMaterialEntity saveEntity = new PredictMaterialEntity();
                saveEntity.setRoomId(roomId);
                saveEntity.setMaterialId(entity.getId());
                saveEntity.setAmount(BigDecimal.valueOf(0));
                saveEntity.setCpId(getCpId());
                saveList.add(saveEntity);
            }
            predictMaterialService.insertBatch(saveList);
        }
        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:predicttemplate:delete")
    public R delete(@RequestBody Long[] ids) {
        List<PredictMaterialEntity> list = predictMaterialService.selectBatchIds(Arrays.asList(ids));
        for (PredictMaterialEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        predictMaterialService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
