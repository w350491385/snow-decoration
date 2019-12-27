package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ClientPreEntity;
import top.czttn.modules.tx.service.ClientPreService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 预约客户
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/clientpre")
public class ClientPreController extends AbstractController {
    @Resource
    private ClientPreService clientPreService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:clientpre:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = clientPreService.queryPage(params, getCpId(),getUserId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:clientpre:info")
    public R info(@PathVariable("id") Long id) {
        ClientPreEntity preClient = clientPreService.selectById(id);
        if (!preClient.getCpId().equals(super.getCpId())) {
            return null;
        }
        return R.ok().put("clientpre", preClient);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:clientpre:save")
    public R save(@RequestBody ClientPreEntity preClient) {
        preClient.setCpId(getCpId());
        preClient.setBelongId(getUserId());
        clientPreService.insert(preClient);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:clientpre:update")
    public R update(@RequestBody ClientPreEntity preClient) {
        ClientPreEntity select = clientPreService.selectById(preClient.getId());
        if (select.getCpId().equals(preClient.getCpId())) {
            clientPreService.updateById(preClient);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:clientpre:delete")
    public R delete(@RequestBody Long[] ids) {
        List<ClientPreEntity> list = clientPreService.selectBatchIds(Arrays.asList(ids));
        for (ClientPreEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        clientPreService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
