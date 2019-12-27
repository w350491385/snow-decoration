package top.czttn.modules.sys.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import top.czttn.common.annotation.SysLog;
import top.czttn.common.utils.Constant;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.common.validator.ValidatorUtils;
import top.czttn.modules.sys.entity.SysRoleEntity;
import top.czttn.modules.sys.service.SysRoleMenuService;
import top.czttn.modules.sys.service.SysRoleService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 角色管理
 */
@RestController
@RequestMapping("/sys/role")
public class SysRoleController extends AbstractController {
    @Resource
    private SysRoleService sysRoleService;
    @Resource
    private SysRoleMenuService sysRoleMenuService;

    /**
     * 角色列表
     */
    @GetMapping("/list")
    @RequiresPermissions("sys:role:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = sysRoleService.queryPage(params, super.getCpId());

        return R.ok().put("page", page);
    }

    /**
     * 角色列表
     */
    @GetMapping("/select")
    @RequiresPermissions("sys:role:select")
    public R select() {
        EntityWrapper<SysRoleEntity> wrapper = new EntityWrapper<>();
        wrapper.eq(getCpId() != null, "cp_id", getCpId());
        wrapper.isNull(getCpId() == null, "cp_id");
        List<SysRoleEntity> list = sysRoleService.selectList(wrapper);

        return R.ok().put("list", list);
    }

    /**
     * 角色信息
     */
    @GetMapping("/info/{roleId}")
    @RequiresPermissions("sys:role:info")
    public R info(@PathVariable("roleId") Long roleId) {
        SysRoleEntity role = sysRoleService.selectById(roleId);
        if (getCpId() != null && !getCpId().equals(role.getCpId())) {
            return null;
        }
        //查询角色对应的菜单
        List<Long> menuIdList = sysRoleMenuService.queryMenuIdList(roleId);
        role.setMenuIdList(menuIdList);

        return R.ok().put("role", role);
    }

    /**
     * 保存角色
     */
    @SysLog("保存角色")
    @PostMapping("/save")
    @RequiresPermissions("sys:role:save")
    public R save(@RequestBody SysRoleEntity role) {
        ValidatorUtils.validateEntity(role);

        role.setCreateUserId(getUserId());
        role.setCpId(super.getCpId());
        sysRoleService.save(role);

        return R.ok();
    }

    /**
     * 修改角色
     */
    @SysLog("修改角色")
    @PostMapping("/update")
    @RequiresPermissions("sys:role:update")
    public R update(@RequestBody SysRoleEntity role) {
        SysRoleEntity select = sysRoleService.selectById(role.getRoleId());
        if (getUserId()== Constant.SUPER_ADMIN || select.getCpId().equals(super.getCpId())) {
            ValidatorUtils.validateEntity(role);

            role.setCreateUserId(getUserId());
            sysRoleService.update(role);
        }

        return R.ok();
    }

    /**
     * 删除角色
     */
    @SysLog("删除角色")
    @PostMapping("/delete")
    @RequiresPermissions("sys:role:delete")
    public R delete(@RequestBody Long[] roleIds) {
        // 非超管需要验证数据权限
        if (getUserId() != Constant.SUPER_ADMIN) {
            List<SysRoleEntity> sysRoleEntities = sysRoleService.selectBatchIds(Arrays.asList(roleIds));
            for (SysRoleEntity entity : sysRoleEntities) {
                if (!entity.getCpId().equals(super.getCpId())) {
                    return null;
                }
            }
        }
        sysRoleService.deleteBatch(roleIds);

        return R.ok();
    }
}
