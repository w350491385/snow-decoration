package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.PlanTemplatEntity;
import top.czttn.modules.tx.service.PlanTemplatService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 施工计划模板
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/plantemplat")
public class PlanTemplatController extends AbstractController {
    @Resource
    private PlanTemplatService planTemplatService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:plantemplat:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = planTemplatService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:plantemplat:info")
    public R info(@PathVariable("id") Long id) {
        PlanTemplatEntity planTemplat = planTemplatService.selectById(id);
        if (!planTemplat.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("plantemplat", planTemplat);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:plantemplat:save")
    public R save(@RequestBody PlanTemplatEntity planTemplat) {
        planTemplat.setCpId(getCpId());
        planTemplatService.insert(planTemplat);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:plantemplat:update")
    public R update(@RequestBody PlanTemplatEntity planTemplat) {
        PlanTemplatEntity select = planTemplatService.selectById(planTemplat.getId());
        if (select.getCpId().equals(getCpId())) {
            planTemplatService.updateById(planTemplat);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:plantemplat:delete")
    public R delete(@RequestBody Long[] ids) {
        List<PlanTemplatEntity> list = planTemplatService.selectBatchIds(Arrays.asList(ids));
        for (PlanTemplatEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        planTemplatService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
