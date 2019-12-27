package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.RepairInfoEntity;
import top.czttn.modules.tx.service.RepairInfoService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 报修管理消息记录
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/repairinfo")
public class RepairInfoController extends AbstractController {
    @Resource
    private RepairInfoService repairInfoService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:repairinfo:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = repairInfoService.queryPage(params,getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:repairinfo:info")
    public R info(@PathVariable("id") Long id) {
        RepairInfoEntity repairInfo = repairInfoService.selectById(id);
        if (!repairInfo.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("repairInfo", repairInfo);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:repairinfo:save")
    public R save(@RequestBody RepairInfoEntity repairInfo) {
        repairInfo.setCpId(getCpId());
        repairInfoService.insert(repairInfo);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:repairinfo:update")
    public R update(@RequestBody RepairInfoEntity repairInfo) {
        RepairInfoEntity select = repairInfoService.selectById(repairInfo.getId());
        if (select.getCpId().equals(getCpId())) {
            repairInfoService.updateById(repairInfo);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:repairinfo:delete")
    public R delete(@RequestBody Long[] ids) {
        List<RepairInfoEntity> list = repairInfoService.selectBatchIds(Arrays.asList(ids));
        for (RepairInfoEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        repairInfoService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
