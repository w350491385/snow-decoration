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

import top.czttn.modules.sys.entity.CompanyMenuEntity;
import top.czttn.modules.sys.service.CompanyMenuService;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;


/**
 * 企业菜单权限
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-02-27 23:19:01
 */
@RestController
@RequestMapping("sys/companymenu")
public class CompanyMenuController {
    @Autowired
    private CompanyMenuService companyMenuService;

    /**
     * 列表
     */
    @RequestMapping("/materialList")
    @RequiresPermissions("sys:companymenu:materialList")
    public R materialList(@RequestParam Map<String, Object> params){
        PageUtils page = companyMenuService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("sys:companymenu:info")
    public R info(@PathVariable("id") Long id){
			CompanyMenuEntity companyMenu = companyMenuService.selectById(id);

        return R.ok().put("companyMenu", companyMenu);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("sys:companymenu:save")
    public R save(@RequestBody CompanyMenuEntity companyMenu){
			companyMenuService.insert(companyMenu);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("sys:companymenu:update")
    public R update(@RequestBody CompanyMenuEntity companyMenu){
			companyMenuService.updateById(companyMenu);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("sys:companymenu:delete")
    public R delete(@RequestBody Long[] ids){
			companyMenuService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
