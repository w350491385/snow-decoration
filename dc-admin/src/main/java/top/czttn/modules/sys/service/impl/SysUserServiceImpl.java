package top.czttn.modules.sys.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import top.czttn.common.utils.PageUtils;
import top.czttn.common.utils.Query;
import top.czttn.modules.sys.dao.SysRoleMenuDao;
import top.czttn.modules.sys.dao.SysUserDao;
import top.czttn.modules.sys.dao.SysUserRoleDao;
import top.czttn.modules.sys.entity.*;
import top.czttn.modules.sys.entity.*;
import top.czttn.modules.sys.form.ForgetForm;
import top.czttn.modules.sys.form.RegistForm;
import top.czttn.modules.sys.service.*;
import top.czttn.modules.sys.service.*;
import top.czttn.modules.tx.dao.SysRetiredDao;
import top.czttn.modules.tx.entity.ServingTechEntity;
import top.czttn.modules.tx.entity.SysPositionEntity;
import top.czttn.modules.tx.entity.SysRetiredEntity;
import top.czttn.modules.tx.service.ClientService;
import top.czttn.modules.tx.service.ServingTechService;
import top.czttn.modules.tx.service.SysPositionService;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;


/**
 * 系统用户
 *
 * @author czj
 * @email 493804781@qq.com
 * @date 2016年9月18日 上午9:46:09
 */
@Service("sysUserService")
public class SysUserServiceImpl extends ServiceImpl<SysUserDao, SysUserEntity> implements SysUserService {
    @Resource
    private SysUserRoleService sysUserRoleService;
    @Resource
    private SysUserDao sysUserDao;
    @Resource
    private SysUserPositionService sysUserPositionService;
    @Resource
    private SysUserRoleDao sysUserRoleDao;
    @Resource
    private UserViewService userViewService;
    @Resource
    private DeptViewService deptViewService;
    @Resource
    private CompanyService companyService;
    @Resource
    private SysRetiredDao sysRetiredDao;
    @Resource
    private ClientService clientService;
    @Resource
    private DeptService deptService;
    @Resource
    private SysRoleMenuDao sysRoleMenuDao;
    @Resource
    private CompanyMenuService companyMenuService;
    @Resource
    private SysRoleService sysRoleService;
    @Resource
    private SysPositionService sysPositionService;
    @Resource
    private ServingTechService servingTechService;

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long cpId, Long userId) {
        if (cpId == null) {
            EntityWrapper<SysUserEntity> wrapper = new EntityWrapper<>();
            if (params.get("ifMain").equals("1")) {
                wrapper.eq("if_main", 1);
            }
            if (params.get("ifMain").equals("2")) {
                wrapper.isNull("if_main");
            }
            Page<SysUserEntity> page = this.selectPage(
                    new Query<SysUserEntity>(params).getPage(),
                    wrapper);
            List<SysUserEntity> records = page.getRecords();
            if (records != null && records.size() > 0) {
                for (SysUserEntity record : records) {
                    if (record.getCpId() != null) {
                        CompanyEntity companyEntity = companyService.selectById(record.getCpId());
                        if (companyEntity != null) {
                            record.setCpName(companyEntity.getCpName());
                        }
                    }
                }
            }
            return new PageUtils(page);
        }
        EntityWrapper<SysUserEntity> wrapper = new EntityWrapper<>();
        wrapper.eq(params.get("deptId") != null, "dept_id", Long.parseLong(params.get("deptId").toString()));
        wrapper.eq(true, "cp_id", cpId);
        Page<SysUserEntity> page = this.selectPage(
                new Query<SysUserEntity>(params).getPage(),
                wrapper
        );
        List<SysUserEntity> records = page.getRecords();
        if (records != null && records.size() > 0) {
            for (SysUserEntity record : records) {
                List<String> list = sysPositionService.findNameByUser(record.getUserId());
                record.setPosition(list);
                List<String> listrole = sysUserRoleDao.findNameByUser(record.getUserId());
                record.setRole(listrole);
                CompanyEntity companyEntity = companyService.selectById(record.getCpId());
                record.setCpName(companyEntity.getCpName());
            }
        }
        return new PageUtils(page);
    }

    @Override
    public List<String> queryAllPerms(Long userId) {
        return baseMapper.queryAllPerms(userId);
    }

    @Override
    public List<Long> queryAllMenuId(Long userId) {
        return baseMapper.queryAllMenuId(userId);
    }

    @Override
    public SysUserEntity queryByMobile(String username) {
        return baseMapper.queryByMobile(username);
    }

    @Override
    @Transactional
    public void save(SysUserEntity user) {
        //sha256加密
        String salt = RandomStringUtils.randomAlphanumeric(20);
        user.setPassword(new Sha256Hash(user.getPassword(), salt).toHex());
        user.setSalt(salt);
        this.insert(user);
        //保存用户与角色关系
        sysUserRoleService.saveOrUpdate(user.getUserId(), user.getRoleIdList());
        //保存用户与服务岗位关系
        sysUserPositionService.saveOrUpdate(user.getUserId(), user.getPositionIdList());
    }

    @Override
    @Transactional
    public void update(SysUserEntity user) {
        this.updateById(user);
        //保存用户与角色关系
        sysUserRoleService.saveOrUpdate(user.getUserId(), user.getRoleIdList());
        //保存用户与服务岗位关系
        sysUserPositionService.saveOrUpdate(user.getUserId(), user.getPositionIdList());
    }

    @Override
    public void deleteBatch(Long[] userId) {
        this.deleteBatchIds(Arrays.asList(userId));
    }

    @Override
    public boolean updatePassword(Long userId, String password, String newPassword) {
        SysUserEntity userEntity = new SysUserEntity();
        userEntity.setPassword(newPassword);
        return this.update(userEntity,
                new EntityWrapper<SysUserEntity>().eq("user_id", userId).eq("password", password));
    }

    /**
     * 查询所有用户，带部门名称
     *
     * @param cpId
     */
    @Override
    public List<SysUserEntity> findAll(Long cpId) {
        return sysUserDao.findAll(cpId);
    }

    /**
     * 更新用户角色
     *
     * @param user
     */
    @Override
    public void updateUserRole(SysUserEntity user) {

        sysUserRoleService.saveOrUpdate(user.getUserId(), user.getRoleIdList());
    }

    /**
     * 更新用户岗位
     *
     * @param user
     */
    @Override
    public void updateUserPosition(SysUserEntity user) {

        sysUserPositionService.saveOrUpdate(user.getUserId(), user.getPositionIdList());
    }

    /**
     * 更新用户个人视野
     *
     * @param user
     */
    @Override
    public void updatePersonView(SysUserEntity user) {

        userViewService.saveOrUpdate(user.getUserId(), user.getPersonViewIdList());

    }

    /**
     * 更新用户部门视野
     *
     * @param user
     */
    @Override
    public void updateDeptView(SysUserEntity user) {

        deptViewService.saveOrUpdate(user.getUserId(), user.getDeptViewIdList());
    }

    /**
     * 删除用户一系列
     *
     * @param userId
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteUser(Long userId) {
        sysUserPositionService.deleteByUser(userId);
        sysUserRoleDao.deleteByUser(userId);
        userViewService.deleteByUser(userId);
        deptViewService.deleteByUser(userId);
        sysUserDao.deleteById(userId);
    }

    /**
     * @param id
     * @return
     */
    @Override
    public SysUserEntity selectByDept(Long id) {
        return this.baseMapper.selectByDept(id);
    }

    /**
     * 用户转到离职
     *
     * @param userId
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void moveToRetired(Long userId) {
        // 旗下客户转到公海池
        clientService.moveToPubByUserId(userId);
        // 删除该用户的部门视野，个人视野，用户角色关系
        deptViewService.deleteByUser(userId);
        userViewService.deleteByUser(userId);
        sysUserRoleDao.deleteByUser(userId);
        // 对用户进行处理
        SysUserEntity select = this.baseMapper.selectById(userId);
        SysRetiredEntity entity = new SysRetiredEntity();
        entity.setCpId(select.getCpId());
        entity.setEntryTime(select.getEntry());
        entity.setJob(select.getJob());
        entity.setName(select.getUsername());
        entity.setPhone(select.getMobile());
        sysRetiredDao.insert(entity);
        this.baseMapper.deleteById(select);
    }

    /**
     * 根据部门id查询用户
     *
     * @param deptviewIds
     * @return
     */
    @Override
    public List<Long> findByDeptIds(String deptviewIds) {
        return this.baseMapper.findByDeptIds(deptviewIds);
    }

    /**
     * 重置密码
     *
     * @param form
     */
    @Override
    public void updateByEmail(ForgetForm form) {
        SysUserEntity one = this.selectOne(new EntityWrapper<SysUserEntity>().eq("email", form.getEmail()));
        SysUserEntity userEntity = new SysUserEntity();
        //sha256加密
        String password = new Sha256Hash(form.getPassword(), one.getSalt()).toHex();
        userEntity.setPassword(password);
        this.update(userEntity,
                new EntityWrapper<SysUserEntity>().eq("email", form.getEmail()));
    }

    /**
     * 创建企业,部门,账号
     *
     * @param form
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void regist(RegistForm form) {
        CompanyEntity companyEntity = new CompanyEntity();
        // 默认可开十个子账号
        companyEntity.setAllowAccount(10);
        companyEntity.setCeo(form.getCeo());
        companyEntity.setCpName(form.getCpName());
        companyEntity.setPhone(form.getPhone());
        companyService.insert(companyEntity);
        // 默认使用一级企业角色
        List<SysRoleMenuEntity> rolemenus = sysRoleMenuDao.selectList(new EntityWrapper<SysRoleMenuEntity>().eq("role_id", 1));
        if (null != rolemenus && rolemenus.size() > 0) {
            List<CompanyMenuEntity> companyMenus = new ArrayList<>();
            for (SysRoleMenuEntity entity : rolemenus) {
                CompanyMenuEntity menuEntity = new CompanyMenuEntity();
                menuEntity.setCpId(companyEntity.getCpId());
                menuEntity.setMenuId(entity.getMenuId());
                companyMenus.add(menuEntity);
            }
            companyMenuService.insertBatch(companyMenus);
        }
        // 创建部门
        DeptEntity deptEntity = new DeptEntity();
        deptEntity.setOrderNum(1);
        deptEntity.setName(form.getCpName());
        deptEntity.setCpId(companyEntity.getCpId());
        deptService.insert(deptEntity);
        // 创建主账号
        SysUserEntity sysUserEntity = new SysUserEntity();
        sysUserEntity.setEmail(form.getEmail());
        sysUserEntity.setCpId(companyEntity.getCpId());
        sysUserEntity.setDeptId(deptEntity.getId());
        sysUserEntity.setCreateTime(new Date());
        sysUserEntity.setIfOn(true);
        sysUserEntity.setMobile(form.getPhone());
        //sha256加密
        String salt = RandomStringUtils.randomAlphanumeric(20);
        sysUserEntity.setSalt(salt);
        sysUserEntity.setPassword(new Sha256Hash(form.getPassword(), salt).toHex());
        sysUserEntity.setUsername(form.getCeo());
        sysUserEntity.setIfMain(true);
        sysUserDao.insert(sysUserEntity);
        // 创建用户角色关系,默认使用一级企业角色
        SysUserRoleEntity sysUserRoleEntity = new SysUserRoleEntity();
        sysUserRoleEntity.setUserId(sysUserEntity.getUserId());
        sysUserRoleEntity.setRoleId(1L);
        sysUserRoleDao.insert(sysUserRoleEntity);
    }

    /**
     * 根据登录名,查询手机号,邮箱
     *
     * @param username
     * @return
     */
    @Override
    public SysUserEntity queryUser(String username) {
        return this.baseMapper.queryUser(username);
    }

    /**
     * @param email
     * @return
     */
    @Override
    public SysUserEntity queryByEmail(String email) {
        return this.baseMapper.queryByEmail(email);
    }

    @Override
    public void updateLastLoginTime(Long userId) {
        this.baseMapper.updateLastLoginTime(userId);
    }

    /**
     * @param user
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void init(SysUserEntity user) {
        // 初始化角色表数据
        List<SysRoleEntity> list = sysRoleService.findCommonList();
        if (null != list && list.size() > 0) {
            for (SysRoleEntity entity : list) {
                entity.setCpId(user.getCpId());
                entity.setIfCommon(false);
                entity.setRoleId(null);
            }
            sysRoleService.insertBatch(list);
        }
        // 初始化岗位表数据
        List<SysPositionEntity> poslist = sysPositionService.findCommonList();
        if (poslist != null && poslist.size() > 0) {
            for (SysPositionEntity entity : poslist) {
                entity.setCpId(user.getCpId());
                entity.setId(null);
                entity.setIfOn(1);
                entity.setIfCommon(false);
            }
            sysPositionService.insertBatch(poslist);
        }
        // 初始化客户服务术语
        List<ServingTechEntity> techEntityList = servingTechService.findCommon();
        if (techEntityList != null && techEntityList.size() > 0) {
            for (ServingTechEntity entity : techEntityList) {
                entity.setCpId(user.getCpId());
                entity.setId(null);
            }
            servingTechService.insertBatch(techEntityList);
        }
        // 更新最后登录时间
        this.baseMapper.updateLastLoginTime(user.getUserId());
    }

    /**
     * 创建个人账号
     *
     * @param form
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void registPerson(RegistForm form) {
        CompanyEntity companyEntity = new CompanyEntity();
        // 默认可开十个子账号
        companyEntity.setAllowAccount(10);
        companyEntity.setCeo(form.getCeo());
        companyEntity.setCpName(form.getCpName());
        companyEntity.setPhone(form.getPhone());
        companyService.insert(companyEntity);
        // 默认使用个人账号角色
        List<SysRoleMenuEntity> rolemenus = sysRoleMenuDao.selectList(new EntityWrapper<SysRoleMenuEntity>().eq("role_id", 31));
        if (null != rolemenus && rolemenus.size() > 0) {
            List<CompanyMenuEntity> companyMenus = new ArrayList<>();
            for (SysRoleMenuEntity entity : rolemenus) {
                CompanyMenuEntity menuEntity = new CompanyMenuEntity();
                menuEntity.setCpId(companyEntity.getCpId());
                menuEntity.setMenuId(entity.getMenuId());
                companyMenus.add(menuEntity);
            }
            companyMenuService.insertBatch(companyMenus);
        }
        // 创建部门
        DeptEntity deptEntity = new DeptEntity();
        deptEntity.setOrderNum(1);
        deptEntity.setName(form.getCpName());
        deptEntity.setCpId(companyEntity.getCpId());
        deptService.insert(deptEntity);
        // 创建主账号
        SysUserEntity sysUserEntity = new SysUserEntity();
        sysUserEntity.setEmail(form.getEmail());
        sysUserEntity.setCpId(companyEntity.getCpId());
        sysUserEntity.setDeptId(deptEntity.getId());
        sysUserEntity.setCreateTime(new Date());
        sysUserEntity.setIfOn(true);
        sysUserEntity.setMobile(form.getPhone());
        //sha256加密
        String salt = RandomStringUtils.randomAlphanumeric(20);
        sysUserEntity.setSalt(salt);
        sysUserEntity.setPassword(new Sha256Hash(form.getPassword(), salt).toHex());
        sysUserEntity.setUsername(form.getCeo());
        sysUserEntity.setIfMain(true);
        sysUserDao.insert(sysUserEntity);
        // 创建用户角色关系,默认使用个人账号角色
        SysUserRoleEntity sysUserRoleEntity = new SysUserRoleEntity();
        sysUserRoleEntity.setUserId(sysUserEntity.getUserId());
        sysUserRoleEntity.setRoleId(31L);
        sysUserRoleDao.insert(sysUserRoleEntity);
    }
}
