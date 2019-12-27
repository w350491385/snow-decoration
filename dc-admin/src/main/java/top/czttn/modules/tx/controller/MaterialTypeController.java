package top.czttn.modules.tx.controller;

import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.MaterialTypeEntity;
import top.czttn.modules.tx.service.MaterialTypeService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;


/**
 * 材料分类
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/materialtype")
public class MaterialTypeController extends AbstractController {
    @Resource
    private MaterialTypeService materialTypeService;

    /**
     * 所有列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:materialtype:list")
    public R list() {
        List<MaterialTypeEntity> list = materialTypeService.findAll(getCpId());

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:materialtype:info")
    public R info(@PathVariable("id") Long id) {
        MaterialTypeEntity materialType = materialTypeService.selectById(id);
        if (!materialType.getCpId().equals(getCpId())) {
            return null;
        }
        if (materialType.getParentId() != null) {
            MaterialTypeEntity parent = materialTypeService.selectById(materialType.getParentId());
            materialType.setParentName(parent.getTypeName());
        }
        return R.ok().put("materialType", materialType);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:materialtype:save")
    public R save(@RequestBody MaterialTypeEntity materialType) {
        materialType.setCpId(getCpId());
        materialTypeService.insert(materialType);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:materialtype:update")
    public R update(@RequestBody MaterialTypeEntity materialType) {
        MaterialTypeEntity select = materialTypeService.selectById(materialType.getId());
        if (select.getCpId().equals(getCpId())) {
            materialTypeService.updateById(materialType);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:materialtype:delete")
    public R delete(@RequestBody Long id) {
        MaterialTypeEntity select = materialTypeService.selectById(id);
        if (!select.getCpId().equals(getCpId())) {
            return null;
        }
        materialTypeService.deleteById(id);

        return R.ok();
    }

}
