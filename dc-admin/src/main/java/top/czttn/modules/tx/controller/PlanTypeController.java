package top.czttn.modules.tx.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.PlanTypeEntity;
import top.czttn.modules.tx.service.PlanTypeService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 施工计划类别
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/plantype")
public class PlanTypeController extends AbstractController {
    @Resource
    private PlanTypeService planTypeService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:plantemplat:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = planTypeService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }

    @RequestMapping("/all")
    @RequiresPermissions("tx:plantemplat:list")
    public R all(@RequestParam Map<String, Object> params) {
        EntityWrapper<PlanTypeEntity> wrapper = new EntityWrapper<>();
        wrapper.eq("cp_id", getCpId());
        List<PlanTypeEntity> list = planTypeService.selectList(wrapper);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:plantemplat:info")
    public R info(@PathVariable("id") Long id) {
        PlanTypeEntity planType = planTypeService.selectById(id);
        if (!planType.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("plantype", planType);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:plantemplat:save")
    public R save(@RequestBody PlanTypeEntity planType) {
        planType.setCpId(getCpId());
        planTypeService.insert(planType);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:plantemplat:update")
    public R update(@RequestBody PlanTypeEntity planType) {
        PlanTypeEntity select = planTypeService.selectById(planType.getId());
        if (select.getCpId().equals(getCpId())) {
            planTypeService.updateById(planType);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:plantemplat:delete")
    public R delete(@RequestBody Long[] ids) {
        List<PlanTypeEntity> list = planTypeService.selectBatchIds(Arrays.asList(ids));
        for (PlanTypeEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        planTypeService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
