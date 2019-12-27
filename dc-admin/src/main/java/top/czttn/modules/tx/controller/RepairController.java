package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.RepairEntity;
import top.czttn.modules.tx.service.RepairService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 报修管理
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/repair")
public class RepairController extends AbstractController {
    @Resource
    private RepairService repairService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:repair:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = repairService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:repair:info")
    public R info(@PathVariable("id") Long id) {
        RepairEntity repair = repairService.selectById(id);
        if (!repair.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("repair", repair);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:repair:save")
    public R save(@RequestBody RepairEntity repair) {
        repair.setCpId(getCpId());
        repairService.insert(repair);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:repair:update")
    public R update(@RequestBody RepairEntity repair) {
        RepairEntity select = repairService.selectById(repair.getId());
        if (select.getCpId().equals(getCpId())) {
            repairService.updateById(repair);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:repair:delete")
    public R delete(@RequestBody Long[] ids) {
        List<RepairEntity> list = repairService.selectBatchIds(Arrays.asList(ids));
        for (RepairEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        repairService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
