package top.czttn.modules.sys.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import top.czttn.modules.sys.entity.SysUserEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 系统用户
 *
 * @author czj
 * @email 493804781@qq.com
 * @date 2016年9月18日 上午9:34:11
 */
@Mapper
public interface SysUserDao extends BaseMapper<SysUserEntity> {

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
    SysUserEntity queryByMobile(String mobile);

    /**
     * 查询所有用户
     *
     * @return
     * @param cpId
     */
    List<SysUserEntity> findAll(@Param("cpId") Long cpId);

    /**
     *
     * @param id
     * @return
     */
    SysUserEntity selectByDept(@Param("id") Long id);

    /**
     * 根据部门id查询用户id
     * @param deptviewIds
     * @return
     */
    List<Long> findByDeptIds(@Param("deptviewIds") String deptviewIds);

    /**
     *
     * @param username
     * @return
     */
    SysUserEntity queryUser(@Param("username") String username);

    /**
     *
     * @param email
     * @return
     */
    SysUserEntity queryByEmail(@Param("email") String email);

    /**
     *
     * @param userId
     */
    void updateLastLoginTime(@Param("userId") Long userId);

}
