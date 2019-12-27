package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ClientInfoEntity;
import top.czttn.modules.tx.service.ClientInfoService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 客户记录
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/clientinfo")
public class ClientInfoController extends AbstractController {
    @Resource
    private ClientInfoService clientInfoService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:clientinfo:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = clientInfoService.queryPage(params, getCpId(),getUserId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:clientinfo:info")
    public R info(@PathVariable("id") Long id) {
        ClientInfoEntity clientInfo = clientInfoService.selectById(id);
        if (!clientInfo.getCpId().equals(getCpId())) {
            return null;
        }
        return R.ok().put("clientInfo", clientInfo);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:clientinfo:save")
    public R save(@RequestBody ClientInfoEntity clientInfo) {
        clientInfo.setCpId(getCpId());
        clientInfoService.insert(clientInfo);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:clientinfo:update")
    public R update(@RequestBody ClientInfoEntity clientInfo) {
        ClientInfoEntity select = clientInfoService.selectById(clientInfo.getId());
        if (select.getCpId().equals(getCpId())) {
            clientInfoService.updateById(clientInfo);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:clientinfo:delete")
    public R delete(@RequestBody Long[] ids) {
        List<ClientInfoEntity> list = clientInfoService.selectBatchIds(Arrays.asList(ids));
        for (ClientInfoEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        clientInfoService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
