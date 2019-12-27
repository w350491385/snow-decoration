package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ClientEntity;
import top.czttn.modules.tx.service.ClientService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 逃单客户
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/escapeclient")
public class EscapeClientController extends AbstractController {
    @Resource
    private ClientService clientService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:escapeclient:list")
    public R list(@RequestParam Map<String, Object> params) {
        params.put("dataType", 2);
        PageUtils page = clientService.queryPage(params, getCpId(), getUserId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:escapeclient:info")
    public R info(@PathVariable("id") Long id) {
        ClientEntity escapeClient = clientService.selectById(id);
        if (!escapeClient.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("escapeclient", escapeClient);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:escapeclient:save")
    public R save(@RequestBody ClientEntity escapeClient) {
        escapeClient.setCpId(getCpId());
        clientService.insert(escapeClient);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:escapeclient:update")
    public R update(@RequestBody ClientEntity escapeClient) {
        ClientEntity select = clientService.selectById(escapeClient.getId());
        if (select.getCpId().equals(getCpId())) {
            clientService.updateById(escapeClient);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:escapeclient:delete")
    public R delete(@RequestBody Long[] ids) {
        List<ClientEntity> list = clientService.selectBatchIds(Arrays.asList(ids));
        for (ClientEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        clientService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

    /**
     * 转入公海
     *
     * @param ids
     * @return
     */
    @RequestMapping("/sea")
    @RequiresPermissions("tx:escapeclient:sea")
    public R sea(@RequestBody Long[] ids) {
        List<ClientEntity> list = clientService.selectBatchIds(Arrays.asList(ids));
        for (ClientEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        clientService.sea(ids);

        return R.ok();
    }

}
