package top.czttn.modules.tx.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.tx.entity.ReceiptEntity;
import top.czttn.modules.tx.service.ReceiptService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


/**
 * 单据类型维护
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-17 00:41:11
 */
@RestController
@RequestMapping("tx/receipt")
public class ReceiptController extends AbstractController {
    @Resource
    private ReceiptService receiptService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:receipt:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = receiptService.queryPage(params,getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:receipt:info")
    public R info(@PathVariable("id") Long id) {
        ReceiptEntity receipt = receiptService.selectById(id);
        if (!receipt.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("receipt", receipt);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:receipt:save")
    public R save(@RequestBody ReceiptEntity receipt) {
        receipt.setCpId(getCpId());
        receiptService.insert(receipt);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:receipt:update")
    public R update(@RequestBody ReceiptEntity receipt) {
        ReceiptEntity select = receiptService.selectById(receipt.getId());
        if (select.getCpId().equals(getCpId())) {
            receiptService.updateById(receipt);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("tx:receipt:delete")
    public R delete(@RequestBody Long[] ids) {
        List<ReceiptEntity> list = receiptService.selectBatchIds(Arrays.asList(ids));
        for (ReceiptEntity entity : list) {
            if (!entity.getCpId().equals(getCpId())) {
                return null;
            }
        }
        receiptService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
