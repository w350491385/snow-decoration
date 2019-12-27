package top.czttn.modules.sys.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.entity.DictTypeEntity;
import top.czttn.modules.sys.service.DictTypeService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 字典类型
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-09 23:41:45
 */
@RestController
@RequestMapping("sys/dicttype")
public class DictTypeController {
    @Resource
    private DictTypeService dictTypeService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:dicttype:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = dictTypeService.queryPage(params);

        return R.ok().put("page", page);
    }

    /**
     * 查询所有
     *
     * @return
     */
    @RequestMapping("/allList")
    public R list() {
        EntityWrapper<DictTypeEntity> wrapper = new EntityWrapper<>();
        wrapper.orderBy("order_num");
        List<DictTypeEntity> list = dictTypeService.selectList(wrapper);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("sys:dicttype:info")
    public R info(@PathVariable("id") Long id) {
        DictTypeEntity dictType = dictTypeService.selectById(id);

        return R.ok().put("dictType", dictType);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("sys:dicttype:save")
    public R save(@RequestBody DictTypeEntity dictType) {
        DictTypeEntity one = dictTypeService.ifExit(dictType);
        if (one != null) {
            return R.error("分类名称已存在");
        }
        dictTypeService.insert(dictType);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("sys:dicttype:update")
    public R update(@RequestBody DictTypeEntity dictType) {
        DictTypeEntity one = dictTypeService.ifExit(dictType);
        if (one != null && !one.getId().equals(dictType.getId())) {
            return R.error("分类名称已存在");
        }
        dictTypeService.updateById(dictType);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("sys:dicttype:delete")
    public R delete(@RequestBody Long[] ids) {
        dictTypeService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
