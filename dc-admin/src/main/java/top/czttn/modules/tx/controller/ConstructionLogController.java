package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ConstructionLogEntity;
import top.czttn.modules.tx.service.ConstructionLogService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 施工日志
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/constructionlog")
public class ConstructionLogController extends AbstractController {
    @Resource
    private ConstructionLogService constructionLogService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:constructionlog:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = constructionLogService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:constructionlog:info")
    public R info(@PathVariable("id") Long id) {
        ConstructionLogEntity constructionLog = constructionLogService.selectById(id);
        if (!constructionLog.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("constructionLog", constructionLog);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:constructionlog:save")
    public R save(@RequestBody ConstructionLogEntity constructionLog) {
        constructionLog.setCpId(getCpId());
        constructionLogService.insert(constructionLog);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:constructionlog:update")
    public R update(@RequestBody ConstructionLogEntity constructionLog) {
        ConstructionLogEntity select = constructionLogService.selectById(constructionLog.getId());
        if (select.getCpId().equals(getCpId())) {
            constructionLogService.updateById(constructionLog);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:constructionlog:delete")
    public R delete(@RequestBody Long[] ids) {
        List<ConstructionLogEntity> list = constructionLogService.selectBatchIds(Arrays.asList(ids));
        for (ConstructionLogEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        constructionLogService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
