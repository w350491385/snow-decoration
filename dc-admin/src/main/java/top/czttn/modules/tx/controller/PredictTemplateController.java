package top.czttn.modules.tx.controller;

import top.czttn.common.utils.DownLoadUtil;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.controller.AbstractController;
import top.czttn.modules.sys.service.ExportService;
import top.czttn.modules.tx.entity.PredictTemplateEntity;
import top.czttn.modules.tx.service.PredictTemplateService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;


/**
 * 预算模板
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-12-12 15:17:33
 */
@RestController
@RequestMapping("tx/predicttemplate")
public class PredictTemplateController extends AbstractController {
    @Resource
    private PredictTemplateService predictTemplateService;
    @Resource
    private ExportService exportService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("tx:predicttemplate:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = predictTemplateService.queryPage(params, getCpId());

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("tx:predicttemplate:info")
    public R info(@PathVariable("id") Long id) {
        PredictTemplateEntity predictTemplate = predictTemplateService.selectById(id);
        if (!predictTemplate.getCpId().equals(getCpId())) {
            return null;
        }

        return R.ok().put("predicttemplate", predictTemplate);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("tx:predicttemplate:save")
    public R save(@RequestBody PredictTemplateEntity predictTemplate) {
        predictTemplate.setCpId(getCpId());
        predictTemplateService.insert(predictTemplate);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("tx:predicttemplate:update")
    public R update(@RequestBody PredictTemplateEntity predictTemplate) {
        PredictTemplateEntity select = predictTemplateService.selectById(predictTemplate.getId());
        if (select.getCpId().equals(getCpId())) {
            predictTemplateService.updateById(predictTemplate);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete/{id}")
    @RequiresPermissions("tx:predicttemplate:delete")
    public R delete(@PathVariable("id") Long id) {
        PredictTemplateEntity select = predictTemplateService.selectById(id);
        if (!select.getCpId().equals(getCpId())) {
            return null;
        }
        predictTemplateService.deleteOne(id);

        return R.ok();
    }

    /**
     * 导出报价表
     *
     * @param response
     * @param id
     */
    @RequiresPermissions("tx:predicttemplate:list")
    @RequestMapping(value = "/export/{id}", method = RequestMethod.GET, produces = MediaType.MULTIPART_FORM_DATA_VALUE)
    public void export(HttpServletResponse response, @PathVariable("id") Long id) {
        PredictTemplateEntity data = predictTemplateService.export(id);
        String datastring = exportService.exportPredict(data);
        // 预算表文件名
        String fileName = data.getName() + "-" + (data.getClientName() == null ? "" : data.getClientName()) + ".xls";
        DownLoadUtil.downFile(response, fileName, datastring);
    }

    /**
     * 克隆
     * @param id
     * @return
     */
    @RequiresPermissions("tx:predicttemplate:save")
    @PostMapping(value = "/clone/{id}")
    public R clone(@PathVariable("id") Long id) {
        predictTemplateService.cloneOne(id);
        return R.ok();
    }

}
