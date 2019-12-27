package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ClientEntity;
import top.czttn.modules.tx.service.ClientService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;


/**
 * 我的客户
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/formalclient")
public class FormalClientController extends AbstractController {
    @Resource
    private ClientService formalClientService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:formalclient:list")
    public R list(@RequestParam Map<String, Object> params) {
        params.put("dataType", 1);
        PageUtils page = formalClientService.queryPage(params, getCpId(), getUserId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:formalclient:info")
    public R info(@PathVariable("id") Long id) {
        ClientEntity formalClient = formalClientService.selectById(id);
        if (!formalClient.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("formalclient", formalClient);
    }

    /**
     * 根据用户查询旗下客户
     */
    @RequestMapping("/select/{id}")
    @RequiresPermissions("tx:formalclient:list")
    public R findClientByUser(@PathVariable("id") Long id) {
        List<ClientEntity> list = formalClientService.findByUser(id);
        return R.ok().put("list", list);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:formalclient:save")
    public R save(@RequestBody ClientEntity formalClient) {
        formalClient.setCreateMan(getUser().getUsername());
        formalClient.setCreateTime(new Date());
        formalClient.setBelongId(getUserId());
        formalClient.setCpId(getCpId());
        formalClientService.insert(formalClient);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:formalclient:update")
    public R update(@RequestBody ClientEntity formalClient) {
        ClientEntity select = formalClientService.selectById(formalClient.getId());
        if (!select.getBelongId().equals(getUserId())) {
            return R.ok("该客户属于其他员工，您不能做修改操作");
        }
        if (select.getCpId().equals(getCpId())) {
            formalClientService.updateById(formalClient);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:formalclient:delete")
    public R delete(@RequestBody Long[] ids) {
        List<ClientEntity> list = formalClientService.selectBatchIds(Arrays.asList(ids));
        for (ClientEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
            if (!entity.getBelongId().equals(getUserId())) {
                return R.error("客户：" + entity.getClientName() + ",属于其他员工，您不能做删除操作");
            }
        }
        formalClientService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

    /**
     * 转到逃单客户
     */
    @RequestMapping("/escape")
    public R escape(@RequestBody ClientEntity formalClient) {
        Long[] ids = formalClient.getLongids();
        List<ClientEntity> list = formalClientService.selectBatchIds(Arrays.asList(ids));
        for (ClientEntity clientEntity : list) {
            if (!clientEntity.getCpId().equals(getCpId())) {
                return null;
            }
            if (!clientEntity.getBelongId().equals(getUserId())) {
                return R.error("客户：" + clientEntity.getClientName() + ",属于其他员工，您不能做逃单操作");
            }
        }
        for (ClientEntity entity : list) {
            entity.setEscape(formalClient.getEscape());
        }
        formalClientService.escape(list);
        return R.ok();
    }

    /**
     * 转入公海
     *
     * @param ids
     * @return
     */
    @RequestMapping("/sea")
    @RequiresPermissions("tx:formalclient:sea")
    public R sea(@RequestBody Long[] ids) {
        List<ClientEntity> list = formalClientService.selectBatchIds(Arrays.asList(ids));
        for (ClientEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
            if (!entity.getBelongId().equals(getUserId())) {
                return R.error("客户：" + entity.getClientName() + ",属于其他员工，您不能做转入公海操作");
            }
        }
        formalClientService.sea(ids);

        return R.ok();
    }

}
