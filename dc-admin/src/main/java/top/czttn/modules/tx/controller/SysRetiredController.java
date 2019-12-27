package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.SysRetiredEntity;
import top.czttn.modules.tx.service.SysRetiredService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 离职员工
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:52:30
 */
@RestController
@RequestMapping("tx/sysretired")
public class SysRetiredController extends AbstractController {
    @Resource
    private SysRetiredService sysRetiredService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:sysretired:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = sysRetiredService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:sysretired:info")
    public R info(@PathVariable("id") Long id) {
        SysRetiredEntity sysRetired = sysRetiredService.selectById(id);
        if (!sysRetired.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("sysRetired", sysRetired);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:sysretired:save")
    public R save(@RequestBody SysRetiredEntity sysRetired) {
        sysRetired.setCpId(getCpId());
        sysRetiredService.insert(sysRetired);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:sysretired:update")
    public R update(@RequestBody SysRetiredEntity sysRetired) {
        SysRetiredEntity select = sysRetiredService.selectById(sysRetired.getId());
        if (select.getCpId().equals(getCpId())) {
            sysRetiredService.updateById(sysRetired);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:sysretired:delete")
    public R delete(@RequestBody Long[] ids) {
        List<SysRetiredEntity> list = sysRetiredService.selectBatchIds(Arrays.asList(ids));
        for (SysRetiredEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        sysRetiredService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
