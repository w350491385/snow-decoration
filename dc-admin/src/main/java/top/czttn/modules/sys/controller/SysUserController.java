package top.czttn.modules.sys.controller;

import top.czttn.common.annotation.SysLog;
import top.czttn.common.utils.Constant;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.R;
import top.czttn.common.validator.Assert;
import top.czttn.common.validator.ValidatorUtils;
import top.czttn.common.validator.group.AddGroup;
import top.czttn.common.validator.group.UpdateGroup;
import top.czttn.modules.sys.entity.DeptEntity;
import top.czttn.modules.sys.entity.SysUserEntity;
import top.czttn.modules.sys.form.PasswordForm;
import top.czttn.modules.sys.service.*;
import top.czttn.modules.sys.service.*;
import top.czttn.modules.tx.service.ClientService;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 系统用户
 */
@RestController
@RequestMapping("/sys/user")
public class SysUserController extends AbstractController {
    @Resource
    private SysUserService sysUserService;
    @Resource
    private SysUserRoleService sysUserRoleService;
    @Resource
    private SysUserPositionService sysUserPositionService;
    @Resource
    private UserViewService userViewService;
    @Resource
    private DeptViewService deptViewService;
    @Resource
    private ClientService clientService;
    @Resource
    private DeptService deptService;

    /**
     * 主账号首次登录初始化数据
     *
     * @return
     */
    @PostMapping("/init")
    public R init() {
        sysUserService.init(getUser());
        return R.ok();
    }

    /**
     * 所有用户列表
     */
    @GetMapping("/list")
    @RequiresPermissions("sys:user:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = sysUserService.queryPage(params, super.getCpId(), getUserId());

        return R.ok().put("page", page);
    }

    /**
     * 选择控件
     */
    @GetMapping("/select")
    @RequiresPermissions("sys:user:list")
    public R select() {
        List<SysUserEntity> list = sysUserService.findAll(super.getCpId());

        return R.ok().put("list", list);
    }

    /**
     * 获取登录的用户信息
     */
    @GetMapping("/info")
    public R info() {
        return R.ok().put("user", getUser());
    }

    /**
     * 修改登录用户密码
     */
    @SysLog("修改密码")
    @PostMapping("/password")
    public R password(@RequestBody PasswordForm form) {
        Assert.isBlank(form.getNewPassword(), "新密码不为能空");

        //sha256加密
        String password = new Sha256Hash(form.getPassword(), getUser().getSalt()).toHex();
        //sha256加密
        String newPassword = new Sha256Hash(form.getNewPassword(), getUser().getSalt()).toHex();

        //更新密码
        boolean flag = sysUserService.updatePassword(getUserId(), password, newPassword);
        if (!flag) {
            return R.error("原密码不正确");
        }

        return R.ok();
    }

    /**
     * 用户的角色id集合
     *
     * @param userId
     * @return
     */
    @GetMapping("/findRoleIdList/{userId}")
    @RequiresPermissions("sys:user:info")
    public R findRoleIdList(@PathVariable("userId") Long userId) {
        //获取用户所属的角色列表
        List<Long> roleIdList = sysUserRoleService.queryRoleIdList(userId);

        return R.ok().put("list", roleIdList);
    }

    /**
     * 用户的岗位id集合
     *
     * @param userId
     * @return
     */
    @GetMapping("/findPositionIdList/{userId}")
    @RequiresPermissions("sys:user:info")
    public R findPositionIdList(@PathVariable("userId") Long userId) {
        // 获取用户所属的岗位列表
        List<Long> positionIdList = sysUserPositionService.queryPositionIdList(userId);
        return R.ok().put("list", positionIdList);
    }

    /**
     * 用户的个人视野
     *
     * @param userId
     * @return
     */
    @GetMapping("/findPersonViewIdList/{userId}")
    @RequiresPermissions("sys:user:info")
    public R findPersonViewIdList(@PathVariable("userId") Long userId) {
        List<Long> list = userViewService.findPersonViewIdList(userId);

        return R.ok().put("list", list);
    }

    /**
     * 用户的部门视野
     *
     * @param userId
     * @return
     */
    @GetMapping("/findDeptViewIdList/{userId}")
    @RequiresPermissions("sys:user:info")
    public R findDeptViewIdList(@PathVariable("userId") Long userId) {
        List<Long> list = deptViewService.findDeptViewIdList(userId);

        return R.ok().put("list", list);
    }

    /**
     * 用户信息
     */
    @GetMapping("/info/{userId}")
    @RequiresPermissions("sys:user:info")
    public R info(@PathVariable("userId") Long userId) {
        SysUserEntity user = sysUserService.selectById(userId);

        //获取用户所属的角色列表
        List<Long> roleIdList = sysUserRoleService.queryRoleIdList(userId);
        user.setRoleIdList(roleIdList);
        // 获取用户所属的岗位列表
        List<Long> positionIdList = sysUserPositionService.queryPositionIdList(userId);
        user.setPositionIdList(positionIdList);
        // 查询部门名称
        if (user.getDeptId() != null) {
            DeptEntity entity = deptService.selectById(user.getDeptId());
            user.setDeptName(entity.getName());
        }


        return R.ok().put("user", user);
    }

    /**
     * 保存用户
     */
    @SysLog("保存用户")
    @PostMapping("/save")
    @RequiresPermissions("sys:user:save")
    public R save(@RequestBody SysUserEntity user) {
        ValidatorUtils.validateEntity(user, AddGroup.class);
        if (StringUtils.isBlank(user.getPassword())) {
            user.setPassword("000000");
        }
        SysUserEntity query = sysUserService.queryByMobile(user.getMobile());
        if (query != null) {
            return R.error("手机号已被使用");
        }
        SysUserEntity sysUserEntity = sysUserService.queryByEmail(user.getEmail());
        if (sysUserEntity != null) {
            return R.error("邮箱已被使用");
        }
        // 如果不是超管添加的，则需要设置企业id
        if (getUserId() != Constant.SUPER_ADMIN) {
            user.setCpId(super.getCpId());
        }
        user.setCreateTime(new Date());
        sysUserService.save(user);

        return R.ok();
    }

    /**
     * 修改用户
     */
    @SysLog("修改用户")
    @PostMapping("/update")
    @RequiresPermissions("sys:user:update")
    public R update(@RequestBody SysUserEntity user) {
        ValidatorUtils.validateEntity(user, UpdateGroup.class);
        SysUserEntity query = sysUserService.queryByMobile(user.getMobile());
        if (query != null && !query.getUserId().equals(user.getUserId())) {
            return R.error("手机号已被使用");
        }
        SysUserEntity sysUserEntity = sysUserService.queryByEmail(user.getEmail());
        if (sysUserEntity != null && !sysUserEntity.getUserId().equals(user.getUserId())) {
            return R.error("邮箱已被使用");
        }
        if (getUserId() == Constant.SUPER_ADMIN || user.getCpId().equals(super.getCpId())) {
            sysUserService.update(user);
        }
        return R.ok();
    }

    /**
     * 转客户
     */
    @PostMapping("/exchange")
    @RequiresPermissions("sys:user:exchange")
    public R exchange(@RequestBody SysUserEntity user) {
        clientService.exchange(user.getClientIdList(), user.getTargetUser());
        return R.ok();
    }

    /**
     * 删除用户
     */
    @SysLog("删除用户")
    @PostMapping("/delete")
    @RequiresPermissions("sys:user:delete")
    public R delete(@RequestBody Long userId) {
        if (userId == 1L) {
            return R.error("系统管理员不能删除");
        }

        if (getUserId().equals(userId)) {
            return R.error("当前用户不能删除");
        }
        SysUserEntity sysUserEntity = sysUserService.selectById(userId);
        if (sysUserEntity.getIfMain()) {
            return R.error("主账号不能删除");
        }
        if (sysUserEntity.getCpId().equals(super.getCpId()) || getUserId() == Constant.SUPER_ADMIN) {
            sysUserService.deleteUser(userId);
        }

        return R.ok();
    }

    /**
     * 离职
     */
    @SysLog("离职")
    @PostMapping("/retired")
    @RequiresPermissions("sys:user:retired")
    public R retired(@RequestBody Long userId) {
        SysUserEntity select = sysUserService.selectById(userId);
        if (select.getIfMain()) {
            return R.error("主账号，不能离职");
        }
        sysUserService.moveToRetired(userId);

        return R.ok();
    }

    @SysLog("更新用户角色")
    @PostMapping("/role")
    @RequiresPermissions("sys:user:update")
    public R updateUserRole(@RequestBody SysUserEntity user) {
        SysUserEntity sysUserEntity = sysUserService.selectById(user.getUserId());
        if (sysUserEntity.getCpId().equals(super.getCpId())) {
            sysUserService.updateUserRole(user);
        }

        return R.ok();
    }

    @SysLog("更新用户岗位")
    @PostMapping("/position")
    @RequiresPermissions("sys:user:update")
    public R updateUserPosition(@RequestBody SysUserEntity user) {
        SysUserEntity sysUserEntity = sysUserService.selectById(user.getUserId());
        if (sysUserEntity.getCpId().equals(super.getCpId())) {
            sysUserService.updateUserPosition(user);
        }

        return R.ok();
    }

    @SysLog("更新用户个人视野")
    @PostMapping("/personview")
    @RequiresPermissions("sys:user:update")
    public R updatePersonView(@RequestBody SysUserEntity user) {
        SysUserEntity sysUserEntity = sysUserService.selectById(user.getUserId());
        if (sysUserEntity.getCpId().equals(super.getCpId())) {
            sysUserService.updatePersonView(user);
        }

        return R.ok();
    }

    @SysLog("更新用户部门视野")
    @PostMapping("/deptview")
    @RequiresPermissions("sys:user:update")
    public R updateDeptView(@RequestBody SysUserEntity user) {
        SysUserEntity sysUserEntity = sysUserService.selectById(user.getUserId());
        if (sysUserEntity.getCpId().equals(super.getCpId())) {
            sysUserService.updateDeptView(user);
        }

        return R.ok();
    }
}
