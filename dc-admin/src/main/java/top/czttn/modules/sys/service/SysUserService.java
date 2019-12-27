package top.czttn.modules.sys.service;

import com.baomidou.mybatisplus.service.IService;
import top.czttn.common.utils.PageUtils;
import top.czttn.modules.sys.entity.SysUserEntity;
import top.czttn.modules.sys.form.ForgetForm;
import top.czttn.modules.sys.form.RegistForm;

import java.util.List;
import java.util.Map;


/**
 * 系统用户
 *
 * @author czj
 * @email 493804781@qq.com
 * @date 2016年9月18日 上午9:43:39
 */
public interface SysUserService extends IService<SysUserEntity> {

    PageUtils queryPage(Map<String, Object> params, Long cpId, Long userId);

    /**
     * 查询用户的所有权限
     *
     * @param userId 用户ID
     */
    List<String> queryAllPerms(Long userId);

    /**
     * 查询用户的所有菜单ID
     */
    List<Long> queryAllMenuId(Long userId);

    /**
     * 根据用户名，查询系统用户
     */
    SysUserEntity queryByMobile(String username);

    /**
     * 保存用户
     */
    void save(SysUserEntity user);

    /**
     * 修改用户
     */
    void update(SysUserEntity user);

    /**
     * 删除用户
     */
    void deleteBatch(Long[] userIds);

    /**
     * 修改密码
     *
     * @param userId      用户ID
     * @param password    原密码
     * @param newPassword 新密码
     */
    boolean updatePassword(Long userId, String password, String newPassword);

    /**
     * 查询所有用户，带部门名称
     * @param cpId
     */
    List<SysUserEntity> findAll(Long cpId);

    /**
     * 更新用户角色
     * @param user
     */
    void updateUserRole(SysUserEntity user);

    /**
     * 更新用户岗位
     * @param user
     */
    void updateUserPosition(SysUserEntity user);

    /**
     * 更新用户个人视野
     * @param user
     */
    void updatePersonView(SysUserEntity user);

    /**
     * 更新用户部门视野
     * @param user
     */
    void updateDeptView(SysUserEntity user);

    /**
     * 删除用户一系列
     * @param userId
     */
    void deleteUser(Long userId);

    /**
     *
     * @param id
     * @return
     */
    SysUserEntity selectByDept(Long id);

    /**
     * 用户转到离职
     * @param userId
     */
    void moveToRetired(Long userId);

    /**
     * 根据部门id查询用户
     * @param deptviewIds
     * @return
     */
    List<Long> findByDeptIds(String deptviewIds);

    /**
     * 重置密码
     * @param form
     */
    void updateByEmail(ForgetForm form);

    /**
     * 创建企业,部门,账号
     * @param form
     */
    void regist(RegistForm form);

    /**
     * 根据登录名,查询手机号,邮箱
     * @param username
     * @return
     */
    SysUserEntity queryUser(String username);

    /**
     *
     * @param email
     * @return
     */
    SysUserEntity queryByEmail(String email);

    /**
     *
     * @param userId
     */
    void updateLastLoginTime(Long userId);

    /**
     *
     * @param user
     */
    void init(SysUserEntity user);

    /**
     * 创建个人账号
     * @param form
     */
    void registPerson(RegistForm form);
}
