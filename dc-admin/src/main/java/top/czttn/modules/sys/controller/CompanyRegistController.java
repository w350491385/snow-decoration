package top.czttn.modules.sys.controller;

import java.util.Arrays;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import top.czttn.modules.sys.entity.CompanyRegistEntity;
import top.czttn.modules.sys.service.CompanyRegistService;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;


/**
 *
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-04-08 16:12:46
 */
@RestController
@RequestMapping("sys/companyregist")
public class CompanyRegistController {
    @Autowired
    private CompanyRegistService companyRegistService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:companyregist:list")
    public R materialList(@RequestParam Map<String, Object> params){
        PageUtils page = companyRegistService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("sys:companyregist:info")
    public R info(@PathVariable("id") Long id){
			CompanyRegistEntity companyRegist = companyRegistService.selectById(id);

        return R.ok().put("companyRegist", companyRegist);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("sys:companyregist:save")
    public R save(@RequestBody CompanyRegistEntity companyRegist){
			companyRegistService.insert(companyRegist);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("sys:companyregist:update")
    public R update(@RequestBody CompanyRegistEntity companyRegist){
			companyRegistService.updateById(companyRegist);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("sys:companyregist:delete")
    public R delete(@RequestBody Long[] ids){
			companyRegistService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
