package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ComplaintInfoEntity;
import top.czttn.modules.tx.service.ComplaintInfoService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 投诉消息记录
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/complaintinfo")
public class ComplaintInfoController extends AbstractController {
    @Resource
    private ComplaintInfoService complaintInfoService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:complaintinfo:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = complaintInfoService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:complaintinfo:info")
    public R info(@PathVariable("id") Long id) {
        ComplaintInfoEntity complaintInfo = complaintInfoService.selectById(id);
        if (!complaintInfo.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("complaintInfo", complaintInfo);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:complaintinfo:save")
    public R save(@RequestBody ComplaintInfoEntity complaintInfo) {
        complaintInfo.setCpId(getCpId());
        complaintInfoService.insert(complaintInfo);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:complaintinfo:update")
    public R update(@RequestBody ComplaintInfoEntity complaintInfo) {
        ComplaintInfoEntity select = complaintInfoService.selectById(complaintInfo.getId());
        if (select.getCpId().equals(getCpId())) {
            complaintInfoService.updateById(complaintInfo);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:complaintinfo:delete")
    public R delete(@RequestBody Long[] ids) {
        List<ComplaintInfoEntity> list = complaintInfoService.selectBatchIds(Arrays.asList(ids));
        for (ComplaintInfoEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        complaintInfoService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
