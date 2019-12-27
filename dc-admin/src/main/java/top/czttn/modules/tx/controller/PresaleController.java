package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.PresaleEntity;
import top.czttn.modules.tx.service.PresaleService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 售前阶段
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/presale")
public class PresaleController extends AbstractController {
    @Resource
    private PresaleService presaleService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:presale:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = presaleService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:presale:info")
    public R info(@PathVariable("id") Long id) {
        PresaleEntity presale = presaleService.selectById(id);
        if (!presale.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("presale", presale);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:presale:save")
    public R save(@RequestBody PresaleEntity presale) {
        presale.setCpId(getCpId());
        presaleService.insert(presale);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:presale:update")
    public R update(@RequestBody PresaleEntity presale) {
        PresaleEntity select = presaleService.selectById(presale.getId());
        if (select.getCpId().equals(getCpId())) {
            presaleService.updateById(presale);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:presale:delete")
    public R delete(@RequestBody Long[] ids) {
        List<PresaleEntity> list = presaleService.selectBatchIds(Arrays.asList(ids));
        for (PresaleEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        presaleService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
