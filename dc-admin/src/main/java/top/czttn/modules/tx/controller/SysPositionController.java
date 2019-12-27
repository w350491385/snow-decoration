package top.czttn.modules.tx.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.SysPositionEntity;
import top.czttn.modules.tx.service.SysPositionService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 公司职位
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:52:30
 */
@RestController
@RequestMapping("tx/sysposition")
public class SysPositionController extends AbstractController {
    @Resource
    private SysPositionService sysPositionService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:sysposition:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = sysPositionService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }

    /**
     * 选择控件
     */
    @RequestMapping("/select")
    @RequiresPermissions("tx:sysposition:list")
    public R select() {
        EntityWrapper<SysPositionEntity> wrapper = new EntityWrapper<>();
        wrapper.eq("if_on", true);
        wrapper.eq("cp_id", getCpId());
        List<SysPositionEntity> list = sysPositionService.selectList(wrapper);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:sysposition:info")
    public R info(@PathVariable("id") Long id) {
        SysPositionEntity sysPosition = sysPositionService.selectById(id);
        if (!sysPosition.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("sysPosition", sysPosition);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:sysposition:save")
    public R save(@RequestBody SysPositionEntity sysPosition) {
        sysPosition.setCpId(getCpId());
        sysPositionService.insert(sysPosition);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:sysposition:update")
    public R update(@RequestBody SysPositionEntity sysPosition) {
        SysPositionEntity select = sysPositionService.selectById(sysPosition.getId());
        if (select.getCpId().equals(getCpId())) {
            sysPositionService.updateById(sysPosition);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:sysposition:delete")
    public R delete(@RequestBody Long[] ids) {
        List<SysPositionEntity> list = sysPositionService.selectBatchIds(Arrays.asList(ids));
        for (SysPositionEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        sysPositionService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
