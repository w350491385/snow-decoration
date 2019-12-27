package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.sys.entity.DictEntity;
import top.czttn.modules.sys.service.DictService;
import top.czttn.modules.tx.entity.BrandEntity;
import top.czttn.modules.tx.entity.MaterialEntity;
import top.czttn.modules.tx.service.BrandService;
import top.czttn.modules.tx.service.MaterialService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 材料列表
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/material")
public class MaterialController extends AbstractController {
    @Resource
    private MaterialService materialService;
    @Resource
    private BrandService brandService;
    @Resource
    private DictService dictService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:material:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = materialService.queryPage(params,getCpId());

        return R.ok().put("page", page);
    }

    /**
     * 根据预算模板空间id过滤出未选的项目集合
     * 列表
     */
    @RequestMapping("/fiterByPredictRoom")
    public R fiterByPredictRoom(@RequestParam Map<String, Object> params) {
        PageUtils page = materialService.fiterByPredictRoom(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:material:info")
    public R info(@PathVariable("id") Long id) {
        MaterialEntity material = materialService.selectById(id);
        if (!material.getCpId().equals(getCpId())) {
            return null;
        }
        BrandEntity brandEntity = brandService.selectById(material.getBrand());
        if (null != brandEntity) {
            material.setBrandName(brandEntity.getName());
        }
        DictEntity dictEntity = dictService.selectById(material.getRoomArea());
        material.setRoomAreaName(dictEntity.getName());
        return R.ok().put("material", material);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:material:save")
    public R save(@RequestBody MaterialEntity material) {
        material.setCpId(getCpId());
        materialService.insert(material);

        return R.ok();
    }

    /**
     * 导入
     */
    @RequestMapping("/import")
    @RequiresPermissions("tx:material:import")
    public R importMaterial(@RequestBody MaterialEntity material) {
        // TODO: 2019/3/5
        return R.ok();
    }


    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:material:update")
    public R update(@RequestBody MaterialEntity material) {
        MaterialEntity select = materialService.selectById(material.getId());
        if (select.getCpId().equals(getCpId())) {
            materialService.updateById(material);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:material:delete")
    public R delete(@RequestBody Long[] ids) {
        List<MaterialEntity> list = materialService.selectBatchIds(Arrays.asList(ids));
        for (MaterialEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        materialService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
