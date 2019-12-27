package top.czttn.modules.tx.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ProjectTypeEntity;
import top.czttn.modules.tx.service.ProjectTypeService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * 工程分类
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/projecttype")
public class ProjectTypeController extends AbstractController {
    @Resource
    private ProjectTypeService projectTypeService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:projecttype:list")
    public R list() {
        EntityWrapper<ProjectTypeEntity> wrapper = new EntityWrapper<>();
        wrapper.eq("cp_id", getCpId());
        List<ProjectTypeEntity> list = projectTypeService.selectList(wrapper);

        return R.ok().put("list", list);
    }

    /**
     * 列表
     */
    @RequestMapping("/chooseList")
    @RequiresPermissions("tx:projecttype:list")
    public R chooseList(@RequestParam Map<String, Object> params) {
        List<ProjectTypeEntity> list = projectTypeService.findChooseList(params, getCpId());

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:projecttype:info")
    public R info(@PathVariable("id") Long id) {
        ProjectTypeEntity projectType = projectTypeService.selectById(id);
        if (!projectType.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("projecttype", projectType);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:projecttype:save")
    public R save(@RequestBody ProjectTypeEntity projectType) {
        projectType.setCpId(getCpId());
        projectTypeService.insert(projectType);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:projecttype:update")
    public R update(@RequestBody ProjectTypeEntity projectType) {
        ProjectTypeEntity select = projectTypeService.selectById(projectType.getId());
        if (select.getCpId().equals(getCpId())) {
            projectTypeService.updateById(projectType);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete/{id}")
    @RequiresPermissions("tx:projecttype:delete")
    public R delete(@PathVariable Long id) {
        ProjectTypeEntity select = projectTypeService.selectById(id);
        if (select != null && !select.getCpId().equals(getCpId())) {
            return null;
        }
        projectTypeService.deleteById(id);

        return R.ok();
    }

}
