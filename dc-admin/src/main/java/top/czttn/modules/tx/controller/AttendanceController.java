package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.AttendanceEntity;
import top.czttn.modules.tx.service.AttendanceService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 考勤管理
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/attendance")
public class AttendanceController extends AbstractController {
    @Resource
    private AttendanceService attendanceService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:attendance:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = attendanceService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:attendance:info")
    public R info(@PathVariable("id") Long id) {
        AttendanceEntity attendance = attendanceService.selectById(id);
        if (!attendance.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("attendance", attendance);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:attendance:save")
    public R save(@RequestBody AttendanceEntity attendance) {
        attendance.setCpId(getCpId());
        attendanceService.insert(attendance);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:attendance:update")
    public R update(@RequestBody AttendanceEntity attendance) {
        AttendanceEntity select = attendanceService.selectById(attendance.getId());
        if (select.getCpId().equals(getCpId())) {
            attendanceService.updateById(attendance);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:attendance:delete")
    public R delete(@RequestBody Long[] ids) {
        List<AttendanceEntity> list = attendanceService.selectBatchIds(Arrays.asList(ids));
        for (AttendanceEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        attendanceService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
