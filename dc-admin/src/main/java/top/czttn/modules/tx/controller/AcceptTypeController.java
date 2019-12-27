package top.czttn.modules.tx.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.AcceptTypeEntity;
import top.czttn.modules.tx.service.AcceptTypeService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 验收类别
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/accepttype")
public class AcceptTypeController extends AbstractController {
    @Resource
    private AcceptTypeService acceptTypeService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:accepttemplet:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = acceptTypeService.queryPage(params, super.getCpId());

        return R.ok().put("page", page);
    }

    @RequestMapping("/all")
    @RequiresPermissions("tx:accepttemplet:list")
    public R all() {
        EntityWrapper<AcceptTypeEntity> wrapper = new EntityWrapper<>();
        wrapper.eq("cp_id", getCpId());
        List<AcceptTypeEntity> list = acceptTypeService.selectList(wrapper);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:accepttemplet:info")
    public R info(@PathVariable("id") Long id) {
        AcceptTypeEntity acceptType = acceptTypeService.selectById(id);
        if (!acceptType.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("accepttype", acceptType);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:accepttemplet:save")
    public R save(@RequestBody AcceptTypeEntity acceptType) {
        acceptType.setCpId(getCpId());
        acceptTypeService.insert(acceptType);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:accepttemplet:update")
    public R update(@RequestBody AcceptTypeEntity acceptType) {
        AcceptTypeEntity select = acceptTypeService.selectById(acceptType.getId());
        if (select.getCpId().equals(getCpId())) {
            acceptTypeService.updateById(acceptType);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:accepttemplet:delete")
    public R delete(@RequestBody Long[] ids) {
        List<AcceptTypeEntity> list = acceptTypeService.selectBatchIds(Arrays.asList(ids));
        for (AcceptTypeEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        acceptTypeService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
