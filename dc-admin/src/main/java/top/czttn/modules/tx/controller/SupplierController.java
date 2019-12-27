package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.SupplierEntity;
import top.czttn.modules.tx.service.SupplierService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 供应商管理
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/supplier")
public class SupplierController extends AbstractController {
    @Resource
    private SupplierService supplierService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:supplier:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = supplierService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:supplier:info")
    public R info(@PathVariable("id") Long id) {
        SupplierEntity supplier = supplierService.selectById(id);
        if (!supplier.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("supplier", supplier);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:supplier:save")
    public R save(@RequestBody SupplierEntity supplier) {
        supplier.setCpId(getCpId());
        supplierService.insert(supplier);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:supplier:update")
    public R update(@RequestBody SupplierEntity supplier) {
        SupplierEntity select = supplierService.selectById(supplier.getId());
        if (select.getCpId().equals(getCpId())) {
            supplierService.updateById(supplier);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:supplier:delete")
    public R delete(@RequestBody Long[] ids) {
        List<SupplierEntity> list = supplierService.selectBatchIds(Arrays.asList(ids));
        for (SupplierEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        supplierService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
