package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ServingTechEntity;
import top.czttn.modules.tx.service.ServingTechService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 客户服务术语
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/servingtech")
public class ServingTechController extends AbstractController {
    @Resource
    private ServingTechService servingTechService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:servingtech:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = servingTechService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:servingtech:info")
    public R info(@PathVariable("id") Long id) {
        ServingTechEntity servingTech = servingTechService.selectById(id);
        if (!servingTech.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("servingtech", servingTech);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:servingtech:save")
    public R save(@RequestBody ServingTechEntity servingTech) {
        servingTech.setCpId(getCpId());
        servingTechService.insert(servingTech);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:servingtech:update")
    public R update(@RequestBody ServingTechEntity servingTech) {
        ServingTechEntity select = servingTechService.selectById(servingTech.getId());
        if (select.getCpId().equals(getCpId())) {
            servingTechService.updateById(servingTech);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:servingtech:delete")
    public R delete(@RequestBody Long[] ids) {
        List<ServingTechEntity> list = servingTechService.selectBatchIds(Arrays.asList(ids));
        for (ServingTechEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        servingTechService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
