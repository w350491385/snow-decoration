package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.AcceptTempletEntity;
import top.czttn.modules.tx.service.AcceptTempletService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 验收模板
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/accepttemplet")
public class AcceptTempletController extends AbstractController {
    @Resource
    private AcceptTempletService acceptTempletService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:accepttemplet:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = acceptTempletService.queryPage(params, super.getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:accepttemplet:info")
    public R info(@PathVariable("id") Long id) {
        AcceptTempletEntity acceptTemplet = acceptTempletService.selectById(id);
        if (!acceptTemplet.getCpId().equals(super.getCpId())) {
            return null;
        }

        return R.ok().put("accepttemplet", acceptTemplet);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:accepttemplet:save")
    public R save(@RequestBody AcceptTempletEntity acceptTemplet) {
        acceptTemplet.setCpId(super.getCpId());
        acceptTempletService.insert(acceptTemplet);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:accepttemplet:update")
    public R update(@RequestBody AcceptTempletEntity acceptTemplet) {
        AcceptTempletEntity select = acceptTempletService.selectById(acceptTemplet.getId());
        if (select.getCpId().equals(super.getCpId())) {
            acceptTempletService.updateById(acceptTemplet);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:accepttemplet:delete")
    public R delete(@RequestBody Long[] ids) {
        List<AcceptTempletEntity> acceptTempletEntities = acceptTempletService.selectBatchIds(Arrays.asList(ids));
        for (AcceptTempletEntity entity : acceptTempletEntities) {
            if (!entity.getCpId().equals(super.getCpId())) {
                return null;
            }
        }
        acceptTempletService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
