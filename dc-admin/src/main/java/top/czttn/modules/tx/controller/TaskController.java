package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.TaskEntity;
import top.czttn.modules.tx.service.TaskService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 任务
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/task")
public class TaskController extends AbstractController {
    @Resource
    private TaskService taskService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:task:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = taskService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:task:info")
    public R info(@PathVariable("id") Long id) {
        TaskEntity task = taskService.selectById(id);
        if (!task.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("task", task);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:task:save")
    public R save(@RequestBody TaskEntity task) {
        task.setCpId(getCpId());
        taskService.insert(task);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:task:update")
    public R update(@RequestBody TaskEntity task) {
        TaskEntity select = taskService.selectById(task.getId());
        if (select.getCpId().equals(getCpId())) {
            taskService.updateById(task);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:task:delete")
    public R delete(@RequestBody Long[] ids) {
        List<TaskEntity> list = taskService.selectBatchIds(Arrays.asList(ids));
        for (TaskEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        taskService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
