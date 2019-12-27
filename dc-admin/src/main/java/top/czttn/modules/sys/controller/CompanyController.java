package top.czttn.modules.sys.controller;

import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.modules.sys.entity.CompanyEntity;
import top.czttn.modules.sys.service.CompanyMenuService;
import top.czttn.modules.sys.service.CompanyService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2019-02-26 23:07:39
 */
@RestController
@RequestMapping("sys/company")
public class CompanyController {
    @Resource
    private CompanyService companyService;
    @Resource
    private CompanyMenuService companyMenuService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:company:list")
    public R materialList(@RequestParam Map<String, Object> params) {
        PageUtils page = companyService.queryPage(params);

        return R.ok().put("page", page);
    }

    /**
     * 所有列表
     */
    @RequestMapping("/select")
    @RequiresPermissions("sys:company:list")
    public R select() {
        List<CompanyEntity> list = companyService.selectList(null);

        return R.ok().put("list", list);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{cpId}")
    @RequiresPermissions("sys:company:info")
    public R info(@PathVariable("cpId") Long cpId) {
        CompanyEntity company = companyService.selectById(cpId);
        //查询拥有菜单权限信息
        List<Long> list = companyMenuService.queryMenuIdList(cpId);
        company.setMenuIdList(list);
        return R.ok().put("company", company);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("sys:company:save")
    public R save(@RequestBody CompanyEntity company) {
        companyService.save(company);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("sys:company:update")
    public R update(@RequestBody CompanyEntity company) {
        companyService.modify(company);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("sys:company:delete")
    public R delete(@RequestBody Long id) {
        companyService.deleteComany(id);

        return R.ok();
    }

}
