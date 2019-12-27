package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ComplaintEntity;
import top.czttn.modules.tx.service.ComplaintService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 投诉管理
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/complaint")
public class ComplaintController extends AbstractController {
    @Resource
    private ComplaintService complaintService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:complaint:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = complaintService.queryPage(params,getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:complaint:info")
    public R info(@PathVariable("id") Long id) {
        ComplaintEntity complaint = complaintService.selectById(id);
        if (!complaint.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("complaint", complaint);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:complaint:save")
    public R save(@RequestBody ComplaintEntity complaint) {
        complaint.setCpId(getCpId());
        complaintService.insert(complaint);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:complaint:update")
    public R update(@RequestBody ComplaintEntity complaint) {
        ComplaintEntity select = complaintService.selectById(complaint.getId());
        if (select.getCpId().equals(getCpId())) {
            complaintService.updateById(complaint);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:complaint:delete")
    public R delete(@RequestBody Long[] ids) {
        List<ComplaintEntity> list = complaintService.selectBatchIds(Arrays.asList(ids));
        for (ComplaintEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        complaintService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
