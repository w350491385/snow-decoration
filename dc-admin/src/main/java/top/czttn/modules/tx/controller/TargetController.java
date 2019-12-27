package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.sys.entity.DeptEntity;
import top.czttn.modules.sys.service.DeptService;
import top.czttn.modules.tx.entity.TargetEntity;
import top.czttn.modules.tx.service.TargetService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 业绩目标
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/target")
public class TargetController extends AbstractController {
    @Resource
    private TargetService targetService;
    @Resource
    private DeptService deptService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:target:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = targetService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:target:info")
    public R info(@PathVariable("id") Long id) {
        TargetEntity target = targetService.selectById(id);
        if (!target.getCpId().equals(getCpId())) {
            return null;
        }
        DeptEntity deptEntity = deptService.selectById(target.getDeptId());
        target.setDeptName(deptEntity.getName());
        return R.ok().put("target", target);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:target:save")
    public R save(@RequestBody TargetEntity target) {
        target.setCpId(getCpId());
        targetService.insert(target);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:target:update")
    public R update(@RequestBody TargetEntity target) {
        TargetEntity select = targetService.selectById(target.getId());
        if (select.getCpId().equals(getCpId())) {
            targetService.updateById(target);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:target:delete")
    public R delete(@RequestBody Long[] ids) {
        List<TargetEntity> list = targetService.selectBatchIds(Arrays.asList(ids));
        for (TargetEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        targetService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
