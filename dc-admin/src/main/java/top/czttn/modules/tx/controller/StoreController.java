package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.StoreEntity;
import top.czttn.modules.tx.service.StoreService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 仓库管理
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/store")
public class StoreController extends AbstractController {
    @Resource
    private StoreService storeService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:store:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = storeService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:store:info")
    public R info(@PathVariable("id") Long id) {
        StoreEntity store = storeService.selectById(id);
        if (!store.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("store", store);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:store:save")
    public R save(@RequestBody StoreEntity store) {
        store.setCpId(getCpId());
        storeService.insert(store);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:store:update")
    public R update(@RequestBody StoreEntity store) {
        StoreEntity select = storeService.selectById(store.getId());
        if (select.getCpId().equals(getCpId())) {
            storeService.updateById(store);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:store:delete")
    public R delete(@RequestBody Long[] ids) {
        List<StoreEntity> list = storeService.selectBatchIds(Arrays.asList(ids));
        for (StoreEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        storeService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
