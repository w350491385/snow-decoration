package top.czttn.modules.sys.controller;

import top.czttn.common.utils.R;
import top.czttn.modules.sys.entity.DeptEntity;
import top.czttn.modules.sys.entity.SysUserEntity;
import top.czttn.modules.sys.service.DeptService;
import top.czttn.modules.sys.service.SysUserService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * 部门
 *
 * @author chenzhenjian
 * @email 493804781@qq.com
 * @date 2018-10-09 23:41:45
 */
@RestController
@RequestMapping("sys/dept")
public class DeptController extends AbstractController{
    @Resource
    private DeptService deptService;
    @Resource
    private SysUserService sysUserService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @RequiresPermissions("sys:dept:list")
    public R list(@RequestParam Map<String, Object> params) {
        List<DeptEntity> list = deptService.findAll(params,super.getCpId());

        return R.ok().put("list", list);
    }

    /**
     * 列表
     */
    @RequestMapping("/multiSelect")
    @RequiresPermissions("sys:dept:list")
    public R multiSelect() {
        List<DeptEntity> rootlist = null;
        List<DeptEntity> list = deptService.findAll(null, super.getCpId());
        if (null != list && list.size() > 0) {
            rootlist = new ArrayList<>();
            for (DeptEntity entity : list) {
                if (entity.getParentId() == null) {
                    rootlist.add(entity);
                }
            }
            //循环一级菜单查找所有子菜单
            if (rootlist.size() > 0) {
                for (DeptEntity bean : rootlist) {
                    bean.setChildren(getChild(bean.getId(), list));
                }
            }
        }
        return R.ok().put("list", rootlist);
    }

    private List<DeptEntity> getChild(Long id, List<DeptEntity> sourcelist) {
        // 子菜单
        List<DeptEntity> childList = new ArrayList<>();
        for (DeptEntity deptEntity : sourcelist) {
            // 遍历所有节点，将父菜单id与传过来的id比较
            if (deptEntity.getParentId() != null && deptEntity.getParentId().equals(id)) {
                childList.add(deptEntity);
            }
        }
        // 把子菜单的子菜单再循环一遍
        for (DeptEntity deptEntity : childList) {
            deptEntity.setChildren(getChild(deptEntity.getId(), sourcelist));
        }
        // 递归退出条件
        if (childList.size() == 0) {
            return null;
        }
        return childList;
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @RequiresPermissions("sys:dept:info")
    public R info(@PathVariable("id") Long id) {
        DeptEntity dept = deptService.selectById(id);
        if (!dept.getCpId().equals(super.getCpId())) {
            return null;
        }
        DeptEntity parent = deptService.selectById(dept.getParentId());
        if (null != parent) {
            dept.setParentName(parent.getName());
        }

        return R.ok().put("dept", dept);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @RequiresPermissions("sys:dept:save")
    public R save(@RequestBody DeptEntity dept) {
        dept.setCpId(super.getCpId());
        deptService.insert(dept);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @RequiresPermissions("sys:dept:update")
    public R update(@RequestBody DeptEntity dept) {
        DeptEntity select = deptService.selectById(dept.getId());
        if (select.getCpId().equals(super.getCpId())) {
            deptService.updateById(dept);
        }

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @RequiresPermissions("sys:dept:delete")
    public R delete(@RequestBody Long id) {
        // 是否有下级
        DeptEntity child = deptService.selectByParentId(id);
        if (child != null) {
            return R.error("请先删除下级组织");
        }
        // 组织下是否存在用户
        SysUserEntity sysUserEntity = sysUserService.selectByDept(id);
        if (sysUserEntity != null) {
            return R.error("请先删除或转移组织下员工");
        }
        DeptEntity deptEntity = deptService.selectById(id);
        if (deptEntity.getCpId().equals(super.getCpId())) {
            deptService.deleteDept(id);
        }

        return R.ok();
    }

}
