package top.czttn.modules.sys.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.entity.VersionEntity;
import top.czttn.modules.sys.service.VersionService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-07-08 10:53:36
 */
@RestController
@RequestMapping("sys/version")
public class VersionController {
    @Resource
    private VersionService versionService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:version:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = versionService.queryPage(params);

        return R.ok().put("page", page);
    }

    @RequestMapping("/allList")
    public R allList() {
        Wrapper<VersionEntity> wrapper = new EntityWrapper<>();
        wrapper.orderBy("update_time", false);
        List<VersionEntity> list = versionService.selectList(wrapper);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("sys:version:info")
    public R info(@PathVariable("id") Long id) {
        VersionEntity version = versionService.selectById(id);

        return R.ok().put("version", version);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("sys:version:save")
    public R save(@RequestBody VersionEntity version) {
        versionService.insert(version);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("sys:version:update")
    public R update(@RequestBody VersionEntity version) {
        versionService.updateById(version);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("sys:version:delete")
    public R delete(@RequestBody Long[] ids) {
        versionService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
