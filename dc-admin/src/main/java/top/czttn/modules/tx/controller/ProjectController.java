package top.czttn.modules.tx.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ProjectEntity;
import top.czttn.modules.tx.service.ProjectService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 工程列表
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/project")
public class ProjectController extends AbstractController {
    @Resource
    private ProjectService projectService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:project:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = projectService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }

    /**
     * 列表
     */
    @RequestMapping("/all")
    @RequiresPermissions("tx:project:list")
    public R all() {
        EntityWrapper<ProjectEntity> wrapper = new EntityWrapper<>();
        wrapper.eq("cp_id", getCpId());
        List<ProjectEntity> list = projectService.selectList(wrapper);

        return R.ok().put("list", list);
    }

    /**
     * 根据预算模板空间id过滤出未选的项目集合
     * 列表
     */
    @RequestMapping("/fiterByPredictRoom")
    public R fiterByPredictRoom(@RequestParam Map<String, Object> params) {
        PageUtils page = projectService.fiterByPredictRoom(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:project:info")
    public R info(@PathVariable("id") Long id) {
        ProjectEntity project = projectService.selectById(id);
        if (!project.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("project", project);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:project:save")
    public R save(@RequestBody ProjectEntity project) {
        project.setCpId(getCpId());
        projectService.insert(project);

        return R.ok();
    }


    /**
     * 导出
     */
    @RequestMapping("/export")
    @RequiresPermissions("tx:project:export")
    public R export(@RequestBody ProjectEntity project) {
        // TODO: 2019/3/5  

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:project:update")
    public R update(@RequestBody ProjectEntity project) {
        ProjectEntity select = projectService.selectById(project.getId());
        if (select.getCpId().equals(getCpId())) {
            projectService.updateById(project);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:project:delete")
    public R delete(@RequestBody Long[] ids) {
        List<ProjectEntity> list = projectService.selectBatchIds(Arrays.asList(ids));
        for (ProjectEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        projectService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
