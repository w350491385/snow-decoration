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
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * 客户公海池
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/seaclient")
public class SeaClientController extends AbstractController {
    @Resource
    private ClientService clientService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:seaclient:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = clientService.queryPage(params, getCpId(), getUserId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:seaclient:info")
    public R info(@PathVariable("id") Long id) {
        ClientEntity seaClient = clientService.selectById(id);
        if (!seaClient.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("seaclient", seaClient);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:seaclient:save")
    public R save(@RequestBody ClientEntity seaClient) {
        seaClient.setCpId(getCpId());
        seaClient.setCreateMan(getUser().getUsername());
        seaClient.setCreateTime(new Date());
        clientService.insert(seaClient);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:seaclient:update")
    public R update(@RequestBody ClientEntity seaClient) {
        ClientEntity select = clientService.selectById(seaClient.getId());
        if (select.getCpId().equals(getCpId())) {
            clientService.updateById(seaClient);
        }

        return R.ok();
    }

    /**
     * 领取
     */
    @RequestMapping("/receive")
    @RequiresPermissions("tx:seaclient:receive")
    public R receive(@RequestBody Long[] ids) {
        List<ClientEntity> list = clientService.selectBatchIds(Arrays.asList(ids));
        for (ClientEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        clientService.receive(ids,this.getUserId());

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:seaclient:delete")
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

}
